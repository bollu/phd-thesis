#!/usr/bin/env -S uv run
"""Pull benchmark family results from the evaluation host into plots/, then
extract the committed artifacts the paper needs (the cactus plot PDF and its
stats) into the per-family folder plots/<family>/.

Usage:
    uv run sync.py <family> [<family> ...]   # sync the named families
    uv run sync.py all                       # sync every family on the host
"""
import argparse
import logging
import shutil
import subprocess
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent

logging.basicConfig(level=logging.INFO, format="%(levelname)s: %(message)s")
log = logging.getLogger(__name__)


def load_hostpath() -> str:
    """Read $hostpath out of config.sh, honoring its shell quoting/comments."""
    config = HERE / "config.sh"
    if not config.exists():
        sys.exit("error: plots/config.sh not found. "
                 "Copy config.sh.sample to config.sh and edit hostpath.")
    hostpath = subprocess.run(
        ["bash", "-c", 'source "$1" && printf %s "$hostpath"', "_", str(config)],
        capture_output=True, text=True, check=True,
    ).stdout.strip()
    if not hostpath:
        sys.exit("error: hostpath is unset in plots/config.sh.")
    return hostpath


def list_families(hostpath: str) -> list[str]:
    """List the family subdirs under runresults/ on the host (via rsync)."""
    out = subprocess.run(
        ["rsync", f"{hostpath}/runresults/"],
        capture_output=True, text=True, check=True,
    ).stdout
    families = []
    for line in out.splitlines():
        cols = line.split()
        if len(cols) >= 5 and cols[0].startswith("d") and cols[-1] != ".":
            families.append(cols[-1])
    return families


def sync_family(hostpath: str, family: str) -> None:
    subprocess.run(
        ["rsync", "-ravz", "--progress", f"{hostpath}/runresults/{family}", "."],
        cwd=HERE, check=True,
    )
    # Extract committed artifacts into the per-family folder; the raw data/ and
    # outputs/ subdirs synced alongside them are gitignored.
    dest = HERE / family
    cactus = dest / "outputs" / "plots" / "cactus"
    if not (cactus / "cactus.pdf").exists():
        log.warning("skipping %s: no cactus plot generated on the host yet "
                    "(%s missing)", family, cactus / "cactus.pdf")
        return
    shutil.copyfile(cactus / "cactus.pdf", dest / "smtlib-cactus.pdf")
    shutil.copyfile(cactus / "cactus.tex", dest / "smtlib-stats.tex")
    log.info("Updated %s/smtlib-cactus.pdf and %s/smtlib-stats.tex", family, family)


def main() -> None:
    parser = argparse.ArgumentParser(
        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument(
        "families", nargs="+",
        help="benchmark families (runresults subdirs) to sync; "
             "pass 'all' to sync every family on the host")
    families = parser.parse_args().families

    hostpath = load_hostpath()
    if "all" in families:
        families = list_families(hostpath)
        if not families:
            sys.exit("error: no families found under runresults/ on the host.")
        print(f"syncing all families: {', '.join(families)}")

    for family in families:
        sync_family(hostpath, family)


if __name__ == "__main__":
    main()
