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
    functions_parser.add_argument("connector", help="connector folder name, e.g. Attio")
    functions_parser.add_argument("--json", action="store_true", help="print JSON")
    viz_parser = commands.add_parser("viz", help="write the OKF graph viewer for bundle/")
    viz_parser.add_argument("--out", type=Path, default=Path("build/viz.html"), help="output HTML")
    args = parser.parse_args(argv)

    if args.command == "review-matches":
        from pqkb.match_agent import review_matches

        review_matches(args.repo, provider=args.provider)
        return 0
    if args.command == "functions":
        return list_functions(args.repo, args.connector, as_json=args.json)
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


def list_functions(repo: Path, connector: str, *, as_json: bool) -> int:
    import json
    from dataclasses import asdict

    from pqkb.functions import index_connector

    records = refresh.load_index(repo / "connectors")
    if connector not in records:
        print(f"Unknown connector {connector!r}; see connectors/index.json.")
        return 2
    sources = bundle.read_sources(repo / "connectors", {connector: records[connector]})
    functions = index_connector(connector, sources[connector])
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
