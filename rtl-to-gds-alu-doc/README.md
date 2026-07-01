# RTL-to-GDS 32-bit ALU — Technical Documentation (LaTeX)

A standalone, technically-written LaTeX document describing the full
**RTL-to-GDS ASIC flow** for the 32-bit ALU project: architecture,
per-step results (simulation, synthesis, place-and-route, DRC/connectivity,
timing), design decisions, the two 32-bit design variants and their
comparison, and the **pad-frame** design and wiring.

Visuals combine **redrawn vector schematics** (TikZ / CircuiTikz) with the
**actual tool screenshots** extracted from `EECS4612_Term_Project_Report.pdf`.

> **Note.** This document was authored but **not compiled on the machine
> that generated it** (no LaTeX toolchain was installed there). It uses only
> standard TeX Live / Overleaf packages and is written to compile
> first-try. Build it with Overleaf or a local TeX install as below.

---

## Folder layout

```
rtl-to-gds-alu-doc/
├── main.tex                 # document root: title page, ToC, chapter includes
├── preamble.tex             # packages, colours, TikZ styles, Verilog listing style, macros
├── sections/                # one file per chapter
│   ├── 01-introduction.tex        # purpose, objectives, I/O, functional table, bit-slice idea
│   ├── 02-asic-flow.tex           # RTL→GDS flow diagram, tools, GPDK045 technology
│   ├── 03-architecture.tex        # 1-bit ALU schematics (TikZ) + RTL + design decisions
│   ├── 04-part1-1bit.tex          # 1-bit ALU: sim, synth, PnR, DRC, timing
│   ├── 05-part2a-hierarchical.tex # 32-bit structural: ripple-carry chain + full flow
│   ├── 06-part2b-behavioral.tex   # 32-bit behavioural + full flow
│   ├── 07-comparison.tex          # area/power/speed comparison + core selection
│   ├── 08-padframe.tex            # 104-pad ring (TikZ), pin table, chip assembly
│   ├── 09-conclusion.tex          # results, decisions, limitations, future work
│   └── A-appendix.tex             # full RTL + testbench listings
├── figures/                 # PNGs extracted from the report (fig01_… .. fig27_…) + manifest.csv
├── rtl/                     # verbatim copies of the Verilog sources (self-contained listings)
├── scripts/extract_figures.py  # regenerates figures/ from the report PDF
├── build.ps1 / build.sh    # local build helpers
└── README.md
```

---

## Building the PDF

### Option A — Overleaf (no install)

1. Zip the `rtl-to-gds-alu-doc/` folder (or drag it into a new Overleaf
   project). The `figures/` and `rtl/` folders are already included, so the
   project is self-contained.
2. In Overleaf, set **Menu → Main document → `main.tex`** and
   **Compiler → pdfLaTeX**.
3. Compile. (Overleaf ships every package used here.)

### Option B — Local MiKTeX (Windows)

```powershell
choco install miktex        # or install MiKTeX from miktex.org
# allow on-the-fly package installation on first run
./build.ps1                 # latexmk if present, else pdflatex ×2
```

### Option C — Local TeX Live / MacTeX (Linux/macOS)

```bash
./build.sh                  # latexmk if present, else pdflatex ×2
```

The output is `main.pdf`.

### Packages used

`graphicx, tikz (+circuitikz), booktabs, tabularx, makecell, colortbl,
siunitx, listings, xcolor, hyperref, cleveref, fancyhdr, caption,
subcaption, enumitem, geometry, amsmath, amssymb, microtype`. All are in
the standard TeX Live / MiKTeX / Overleaf distributions. No `--shell-escape`
and no `minted` are required.

---

## Regenerating the figures

The screenshots in `figures/` are extracted from
`../EECS4612_Term_Project_Report.pdf` by:

```bash
python scripts/extract_figures.py
```

This writes, for each embedded image, a raw `page<NN>_img<K>.png` plus a
semantic `figNN_slug.png` (the names the LaTeX references), and a
`manifest.csv` mapping images to report Figure numbers. Requires
`pypdf` (or `PyPDF2`) and `Pillow`.

**Fallback for stubborn figures.** If a figure is stored as vector art and
does not extract cleanly, include the report page directly instead, e.g.:

```latex
\usepackage{pdfpages}
% ...
\includepdf[pages=17,scale=0.9]{../EECS4612_Term_Project_Report.pdf}
```

---

## Figure map (extracted → report Figure)

| File | Report | Content |
|------|--------|---------|
| `fig01_mux_sim` | Fig 1 | 4:1 MUX simulation |
| `fig02_arith_sim` | Fig 2 | Arithmetic circuit simulation |
| `fig03_logic_sim` | Fig 3 | Logic circuit simulation |
| `fig04_alu1_sim` | Fig 4 | 1-bit ALU simulation |
| `fig05_alu1_synth` | Fig 5 | 1-bit ALU synthesis |
| `fig06_alu1_area` | Fig 6 | 1-bit ALU area report |
| `fig07_alu1_power` | Fig 7 | 1-bit ALU power report |
| `fig08_alu1_layout` | Fig 8 | 1-bit ALU layout |
| `fig09_alu1_drc` / `fig10_alu1_conn` | Fig 9/10 | 1-bit ALU DRC / connectivity |
| `fig11_alu1_timing` | Fig 11 | 1-bit ALU timing |
| `fig12_hier_sim` … `fig18_hier_conn` | Fig 12–18 | 32-bit hierarchical (Part 2a) |
| `fig19_behav_sim` … `fig25_behav_conn` | Fig 19–25 | 32-bit behavioural (Part 2b) |
| `fig26_chip_padframe` | Fig 26 | Full-chip layout with pad frame |
| `fig27_chip_pindiagram` | Fig 27 | Chip pin diagram |
