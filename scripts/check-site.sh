#!/usr/bin/env bash
#
# Verifies index.html before it gets published.
#
#   ./scripts/check-site.sh
#
# Catches the three ways this site realistically breaks:
#   1. An <img src> pointing at a file that is not there (or is spelled
#      differently). GitHub's servers are case-sensitive and macOS is not, so
#      "Rescue-1.svg" works on your laptop and 404s in production. This check
#      compares against the real filenames rather than asking the filesystem,
#      so it catches a case mismatch on macOS too.
#   2. A nav link pointing at a #section that no longer exists.
#   3. Image files left in assets/ that nothing uses (warning only).

set -uo pipefail

HTML="index.html"
fail=0

ok()   { printf '  ok    %s\n' "$1"; }
warn() { printf '  warn  %s\n' "$1"; }
err()  { printf '  FAIL  %s\n' "$1"; fail=1; }

if [ ! -f "$HTML" ]; then
  echo "FAIL: $HTML not found — run this from the repository root."
  exit 1
fi

# Real filenames on disk, for exact (case-sensitive) comparison.
actual=$(find assets -type f 2>/dev/null | sort)

echo "Asset references in $HTML"
refs=$(grep -oE '(src|href)="assets/[^"]*"' "$HTML" | sed -E 's/^[^"]*"//; s/"$//' | sort -u)
if [ -z "$refs" ]; then
  warn "no local asset references found"
else
  while IFS= read -r ref; do
    [ -n "$ref" ] || continue
    if printf '%s\n' "$actual" | grep -qxF "$ref"; then
      ok "$ref"
    else
      err "$ref — no such file (check spelling and capitalisation)"
    fi
  done <<< "$refs"
fi

echo
echo "Internal links"
anchors=$(grep -oE 'href="#[A-Za-z0-9_-]+"' "$HTML" | sed -E 's/href="#//; s/"$//' | sort -u)
while IFS= read -r a; do
  [ -n "$a" ] || continue
  if grep -q "id=\"$a\"" "$HTML"; then
    ok "#$a"
  else
    err "#$a — nothing on the page has that id"
  fi
done <<< "$anchors"

echo
echo "Unused files in assets/"
unused=0
while IFS= read -r f; do
  [ -n "$f" ] || continue
  if ! grep -qF "$(basename "$f")" "$HTML"; then
    warn "$f is not used by $HTML"
    unused=1
  fi
done <<< "$actual"
[ "$unused" -eq 0 ] && ok "none"

echo
if [ "$fail" -ne 0 ]; then
  echo "FAILED — the site would publish with broken links. Nothing was deployed."
  exit 1
fi
echo "All checks passed."
