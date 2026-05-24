# /// script
# requires-python = ">=3.10"
# dependencies = ["httpx"]
# ///
"""
egenesis init script â€” pulls the egenesis scaffold template into the current directory.
Run with:  uv run https://raw.githubusercontent.com/ethavais/egenesis/main/init.py
"""

import httpx
import io
import zipfile
from pathlib import Path

REPO = "ethavais/egenesis"
BRANCH = "main"
ZIP_URL = f"https://github.com/{REPO}/archive/refs/heads/{BRANCH}.zip"
PREFIX = f"egenesis-{BRANCH}/"

def main():
    dest = Path.cwd()
    print(f">>> Pulling ethavais/egenesis into {dest} ...")

    with httpx.Client(follow_redirects=True, timeout=30) as client:
        resp = client.get(ZIP_URL)
        resp.raise_for_status()

    with zipfile.ZipFile(io.BytesIO(resp.content)) as zf:
        members = [m for m in zf.infolist() if m.filename.startswith(PREFIX) and m.filename != PREFIX]
        skipped = []
        for member in members:
            rel = member.filename[len(PREFIX):]
            target = dest / rel
            if member.is_dir():
                target.mkdir(parents=True, exist_ok=True)
            else:
                target.parent.mkdir(parents=True, exist_ok=True)
                # Skip if file already exists (safe mode)
                if target.exists():
                    skipped.append(rel)
                    continue
                target.write_bytes(zf.read(member.filename))

    pulled = len(members) - len(skipped)
    print(f">>> Done! {pulled} files pulled.")
    if skipped:
        print(f">>> Skipped {len(skipped)} existing files: {', '.join(skipped[:5])}{'...' if len(skipped) > 5 else ''}")
    print(">>> Next: Ctrl+H in VS Code -> replace {{ProjectName}} with your project name.")

if __name__ == "__main__":
    main()

