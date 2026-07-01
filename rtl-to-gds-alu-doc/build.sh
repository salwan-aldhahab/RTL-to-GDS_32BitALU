#!/usr/bin/env bash
# build.sh -- build the ALU documentation PDF on Linux/macOS/Git-Bash.
# Prefers latexmk; falls back to two pdflatex passes so the ToC, list of
# figures/tables and cross-references resolve.
#
#     ./build.sh
#
# Requires a TeX distribution on PATH (TeX Live / MacTeX / MiKTeX).
set -euo pipefail
cd "$(dirname "$0")"

MAIN=main

if command -v latexmk >/dev/null 2>&1; then
    echo "==> Building with latexmk"
    latexmk -pdf -interaction=nonstopmode -halt-on-error "${MAIN}.tex"
elif command -v pdflatex >/dev/null 2>&1; then
    echo "==> latexmk not found; using pdflatex (2 passes)"
    pdflatex -interaction=nonstopmode -halt-on-error "${MAIN}.tex"
    pdflatex -interaction=nonstopmode -halt-on-error "${MAIN}.tex"
else
    echo "ERROR: no LaTeX engine found. Install TeX Live/MiKTeX or use Overleaf (see README.md)." >&2
    exit 1
fi

echo "==> Built ${MAIN}.pdf"
