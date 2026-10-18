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
    args = parser.parse_args(argv)

    if args.command == "verify-reviews":
        problems = reviews.check_reviews(args.repo)
        for problem in problems:
            print(problem)
        return int(bool(problems))

    now = datetime.now(UTC)
    if args.command == "refresh":
        changes = refresh.refresh(args.repo, source_dir=args.source_dir)
        records = refresh.load_index(args.repo / "connectors")
        bundle.append_log(args.repo / "knowledge" / "log.md", changes, records, now)
        bundle.build(args.repo, now)
        bundle.confirm_archive(args.repo, now)
        print(
            f"Added {len(changes.added)}, updated {len(changes.updated)}, "
            f"removed {len(changes.removed)} connectors."
        )
    else:
        bundle.build(args.repo, now)
        print("Bundle rebuilt.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
