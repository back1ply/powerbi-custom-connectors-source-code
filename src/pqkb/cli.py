"""Command line entry point: ``pqkb refresh`` and ``pqkb build``."""

from __future__ import annotations

import argparse
from datetime import UTC, datetime
from pathlib import Path

from pqkb import bundle, refresh, reviews


def _repo(value: str) -> Path:
    path = Path(value).resolve()
    if not (path / "pyproject.toml").is_file():
        raise argparse.ArgumentTypeError(f"{path} is not the repository root")
    return path


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(prog="pqkb", description=__doc__)
    parser.add_argument("--repo", type=_repo, default=".", help="repository root (default: .)")
    commands = parser.add_subparsers(dest="command", required=True)
    refresh_parser = commands.add_parser(
        "refresh", help="refresh connectors, then rebuild the bundle"
    )
    refresh_parser.add_argument(
        "--source-dir", type=Path, help="use a complete local package folder instead of downloading"
    )
    commands.add_parser("build", help="rebuild the bundle from connectors/ without downloading")
    commands.add_parser(
        "verify-reviews", help="check pattern reviews against prose and cited source"
    )
    review_parser = commands.add_parser("review-matches", help="review changed pattern candidates")
    review_parser.add_argument(
        "--provider",
        choices=("claude-code", "opencode"),
        default="claude-code",
        help="Claude Haiku (default) or OpenCode with DeepSeek Flash",
    )
    commands.add_parser("verify-matches", help="check source-bound candidate assessments")
    functions_parser = commands.add_parser(
        "functions", help="list a connector's top-level functions, line ranges, and calls"
    )
    functions_parser.add_argument(
        "connector", nargs="?", help="connector folder name in connectors/, e.g. Attio"
    )
    functions_parser.add_argument(
        "--path", type=Path, help="a connector folder outside the archive (your own connector)"
    )
    functions_parser.add_argument("--json", action="store_true", help="print JSON")
    check_parser = commands.add_parser(
        "check-profiles", help="validate checklist answer files against the checklist and source"
    )
    check_parser.add_argument(
        "folder", nargs="?", type=Path, default=Path("evals/gold"), help="folder of <Name>.yaml"
    )
    profile_parser = commands.add_parser(
        "profile", help="answer the connector checklist with Claude (default: gold-set connectors)"
    )
    profile_parser.add_argument(
        "connectors", nargs="*", help="connector names (default: evals/gold)"
    )
    profile_parser.add_argument("--all", action="store_true", help="profile every connector")
    profile_parser.add_argument(
        "--path", type=Path, help="profile a connector folder outside the archive"
    )
    profile_parser.add_argument(
        "--model", default="haiku", help="Claude model alias (default: haiku)"
    )
    profile_parser.add_argument(
        "--out-dir",
        type=Path,
        default=Path("knowledge/profiles"),
        help="where profiles are written",
    )
    profile_parser.add_argument("--force", action="store_true", help="ignore cached profiles")
    profile_parser.add_argument(
        "--workers", type=int, default=2, help="connectors profiled in parallel (default: 2)"
    )
    eval_parser = commands.add_parser("eval", help="score profiles against the gold set")
    eval_parser.add_argument("--gold", type=Path, default=Path("evals/gold"))
    eval_parser.add_argument("--profiles", type=Path, default=Path("knowledge/profiles"))
    eval_parser.add_argument("--save", type=Path, help="write the full result JSON here")
    eval_parser.add_argument("--json", action="store_true", help="print the full result as JSON")
    cert_parser = commands.add_parser(
        "certification", help="check connectors against Microsoft's certification rules"
    )
    cert_parser.add_argument("connectors", nargs="*", help="connector names (default: all)")
    cert_parser.add_argument(
        "--path",
        type=Path,
        help="check a connector folder outside the archive (your own connector)",
    )
    cert_parser.add_argument("--json", action="store_true", help="print JSON")
    viz_parser = commands.add_parser("viz", help="write the OKF graph viewer for bundle/")
    viz_parser.add_argument("--out", type=Path, default=Path("build/viz.html"), help="output HTML")
    args = parser.parse_args(argv)

    if args.command == "review-matches":
        from pqkb.match_agent import review_matches

        review_matches(args.repo, provider=args.provider)
        return 0
    if args.command == "profile":
        return run_profile_command(args)
    if args.command == "eval":
        return run_eval_command(args)
    if args.command == "certification":
        if args.path:
            return run_certification_path(args.path, as_json=args.json)
        return run_certification(args.repo, args.connectors, as_json=args.json)
    if args.command == "check-profiles":
        return check_profiles(args.repo, args.repo / args.folder)
    if args.command == "functions":
        return list_functions(args.repo, args.connector, as_json=args.json, path=args.path)
    if args.command == "viz":
        from pqkb.viz import generate_visualization

        counts = generate_visualization(args.repo / bundle.BUNDLE_DIR, args.repo / args.out)
        print(f"Wrote {args.out}: {counts['concepts']} concepts, {counts['edges']} links.")
        return 0
    if args.command in ("verify-reviews", "verify-matches"):
        return verify(args.command, args.repo)

    now = datetime.now(UTC)
    if args.command == "refresh":
        changes = refresh.refresh(args.repo, source_dir=args.source_dir)
        records = refresh.load_index(args.repo / "connectors")
        bundle.append_log(args.repo / "knowledge" / "log.md", changes, records, now)
        # Write the receipt before building so connector pages and drifted pattern
        # copies take their freshness from this refresh.
        bundle.write_receipt(args.repo, now)
        bundle.build(args.repo, now)
        print(
            f"Added {len(changes.added)}, updated {len(changes.updated)}, "
            f"removed {len(changes.removed)} connectors."
        )
    else:
        bundle.build(args.repo, now)
        print("Bundle rebuilt.")
    return 0


def run_profile_command(args) -> int:
    from pqkb.profile import run_profiles

    if args.path is not None:
        return profile_path(args)
    if args.all:
        names = sorted(refresh.load_index(args.repo / "connectors"))
    else:
        names = args.connectors or sorted(
            p.stem for p in (args.repo / "evals" / "gold").glob("*.yaml")
        )
    failures = run_profiles(
        args.repo,
        names,
        model=args.model,
        out_dir=args.repo / args.out_dir,
        force=args.force,
        workers=args.workers,
    )
    print(f"{len(names) - len(failures)} of {len(names)} connectors have a valid profile.")
    return 1 if failures else 0


def profile_path(args) -> int:
    """Profile one connector folder outside the archive into --out-dir/<name>.json."""
    import json
    import subprocess

    from pqkb.profile import profile_connector

    try:
        profile = profile_connector(args.repo, "", args.model, source_dir=args.path)
    except (OSError, subprocess.SubprocessError, ValueError, KeyError, TypeError) as error:
        print(f"Profile failed for {args.path}: {error}")
        return 1
    out_dir = args.repo / args.out_dir
    out_dir.mkdir(parents=True, exist_ok=True)
    out = out_dir / f"{profile['connector']}.json"
    out.write_text(
        json.dumps(profile, indent=2, ensure_ascii=False) + "\n", encoding="utf-8", newline="\n"
    )
    print(f"Wrote {out}.")
    return 0


def run_eval_command(args) -> int:
    import json

    from pqkb.evaluate import evaluate, report_lines

    result = evaluate(args.repo, args.repo / args.gold, args.repo / args.profiles)
    if args.save:
        target = args.repo / args.save
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8", newline="\n")
    print(json.dumps(result, indent=2) if args.json else "\n".join(report_lines(result)))
    return 0 if result["connectors_scored"] else 1


def run_certification(repo: Path, names: list[str], *, as_json: bool) -> int:
    import json
    from collections import Counter
    from dataclasses import asdict

    from pqkb.certification import check_connector

    records = refresh.load_index(repo / "connectors")
    unknown = [n for n in names if n not in records]
    if unknown:
        print(f"Unknown connectors: {', '.join(unknown)}.")
        return 2
    selected = {n: records[n] for n in (names or sorted(records))}
    sources = bundle.read_sources(repo / "connectors", selected)
    results = {n: check_connector(n, sources[n]) for n in selected}
    if as_json:
        print(json.dumps({n: [asdict(f) for f in fs] for n, fs in results.items()}, indent=2))
        return 0
    if len(names) == 1:
        for f in next(iter(results.values())):
            where = f" ({f.file}:{f.line})" if f.file else ""
            print(f"{f.status:7} {f.rule:24} {f.detail}{where}")
        return 0
    tally = Counter((f.rule, f.status) for fs in results.values() for f in fs)
    for rule in dict.fromkeys(rule for rule, _ in tally):
        counts = ", ".join(f"{s} {c}" for (r, s), c in sorted(tally.items()) if r == rule)
        print(f"{rule:24} {counts}")
    print(f"{len(results)} connectors checked.")
    return 0


def run_certification_path(path: Path, *, as_json: bool) -> int:
    """Certification checks for one connector folder outside the archive."""
    import json
    from dataclasses import asdict

    from pqkb.certification import check_connector

    try:
        name, files = folder_sources(path)
    except FileNotFoundError as error:
        print(error)
        return 2
    findings = check_connector(name, files)
    if as_json:
        print(json.dumps({name: [asdict(f) for f in findings]}, indent=2))
        return 0
    for f in findings:
        where = f" ({f.file}:{f.line})" if f.file else ""
        print(f"{f.status:7} {f.rule:24} {f.detail}{where}")
    return 0


def check_profiles(repo: Path, folder: Path) -> int:
    from pqkb.checklist import load_checklist, load_profiles, validate_profile

    checklist = load_checklist(repo)
    profiles = load_profiles(folder)
    problems = []
    for name, profile in profiles.items():
        if profile.get("connector") != name:
            problems.append(f"{name}.yaml: connector field is {profile.get('connector')!r}")
        problems += validate_profile(repo, profile, checklist)
    for problem in problems:
        print(problem)
    print(f"{len(profiles)} profiles checked: {len(problems)} problems.")
    return 1 if problems or not profiles else 0


def folder_sources(path: Path) -> tuple[str, dict[str, str]]:
    """Name and M source files (.pq, .pqm, .m) of a connector folder outside the archive."""
    from pqkb.package import m_sources
    from pqkb.scan import read_source

    if not path.is_dir():
        raise FileNotFoundError(f"{path} is not a folder")
    files = {f: read_source(path / f) for f in m_sources(path)}
    if not files:
        raise FileNotFoundError(f"no .pq, .pqm or .m files in {path}")
    return path.resolve().name, files


def list_functions(
    repo: Path, connector: str | None, *, as_json: bool, path: Path | None = None
) -> int:
    import json
    from dataclasses import asdict

    from pqkb.functions import index_connector

    if path is not None:
        try:
            connector, files = folder_sources(path)
        except FileNotFoundError as error:
            print(error)
            return 2
    elif connector is None:
        print("Give a connector name from connectors/, or --path <folder>.")
        return 2
    else:
        records = refresh.load_index(repo / "connectors")
        if connector not in records:
            print(f"Unknown connector {connector!r}; see connectors/index.json, or use --path.")
            return 2
        files = bundle.read_sources(repo / "connectors", {connector: records[connector]})[connector]
    functions = index_connector(connector, files)
    if as_json:
        print(json.dumps([asdict(f) for f in functions], indent=2))
        return 0
    for f in functions:
        calls = f" -> {', '.join(f.calls)}" if f.calls else ""
        print(f"{f.file}:{f.start}-{f.end} {'shared ' if f.shared else ''}{f.name}{calls}")
    print(f"{len(functions)} functions in {connector}.")
    return 0


def verify(command: str, repo: Path) -> int:
    from pqkb.match_agent import verify_matches

    problems = verify_matches(repo) if command == "verify-matches" else reviews.check_reviews(repo)
    for problem in problems:
        print(problem)
    return int(bool(problems))


if __name__ == "__main__":
    raise SystemExit(main())
