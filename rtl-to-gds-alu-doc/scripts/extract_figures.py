#!/usr/bin/env python3
"""
Extract the embedded raster images (screenshots) from the EECS4612 term-project
report PDF into ``rtl-to-gds-alu-doc/figures/`` so they can be embedded in the
LaTeX documentation.

The report is essentially a gallery of Cadence tool screenshots (Xcelium
waveforms, Genus area/power reports, Innovus layouts / DRC / connectivity /
timing, and the Virtuoso pad-frame layout + pin diagram).  This script walks the
PDF page by page, pulls every embedded image and writes it as a PNG named
``page<NN>_img<K>.png`` (page and image index both zero-padded), together with a
``manifest.csv`` listing page, index, pixel size and file name.

Only the Python standard library plus ``pypdf``/``PyPDF2`` and ``Pillow`` are
required -- both are already available in this environment::

    python rtl-to-gds-alu-doc/scripts/extract_figures.py

Optional argument: path to the source PDF (defaults to the report next to the
repository root).
"""

from __future__ import annotations

import csv
import sys
from pathlib import Path

# pypdf is the maintained successor of PyPDF2; accept either.
try:  # pragma: no cover - trivial import shim
    from pypdf import PdfReader  # type: ignore
except ImportError:  # pragma: no cover
    from PyPDF2 import PdfReader  # type: ignore


HERE = Path(__file__).resolve().parent          # .../rtl-to-gds-alu-doc/scripts
DOC_ROOT = HERE.parent                           # .../rtl-to-gds-alu-doc
REPO_ROOT = DOC_ROOT.parent                      # repository root
DEFAULT_PDF = REPO_ROOT / "EECS4612_Term_Project_Report.pdf"
OUT_DIR = DOC_ROOT / "figures"

# Mapping from the raw ``page<NN>_img<K>`` extraction key to the report Figure
# number and a human-readable slug.  Derived by correlating the per-page figure
# captions with each embedded image (verified visually for multi-image pages).
# The PDF is fixed, so this mapping is stable; re-running reproduces both the raw
# and the semantic file names.  The LaTeX document references the semantic names.
FIGMAP: dict[str, tuple[int, str]] = {
    "page02_img00": (1,  "mux_sim"),          # 4x1 MUX testbench simulation
    "page03_img00": (2,  "arith_sim"),        # Arithmetic circuit simulation
    "page04_img00": (3,  "logic_sim"),        # Logic circuit simulation
    "page05_img00": (4,  "alu1_sim"),         # 1-bit ALU simulation
    "page06_img00": (5,  "alu1_synth"),       # 1-bit ALU synthesis schematic
    "page06_img01": (6,  "alu1_area"),        # 1-bit ALU area report
    "page07_img00": (7,  "alu1_power"),       # 1-bit ALU power report
    "page07_img01": (8,  "alu1_layout"),      # 1-bit ALU layout placement
    "page08_img00": (9,  "alu1_drc"),         # 1-bit ALU DRC
    "page08_img01": (10, "alu1_conn"),        # 1-bit ALU connectivity
    "page09_img00": (11, "alu1_timing"),      # 1-bit ALU timing report
    "page10_img00": (12, "hier_sim"),         # 32-bit hierarchical simulation
    "page10_img01": (13, "hier_synth"),       # 32-bit hierarchical synthesis
    "page11_img00": (14, "hier_area"),        # 32-bit hierarchical area report
    "page11_img01": (15, "hier_power"),       # 32-bit hierarchical power report
    "page12_img00": (16, "hier_pnr"),         # 32-bit hierarchical Innovus PnR
    "page12_img01": (17, "hier_drc"),         # 32-bit hierarchical DRC
    "page13_img00": (18, "hier_conn"),        # 32-bit hierarchical connectivity
    "page14_img00": (19, "behav_sim"),        # 32-bit behavioral simulation
    "page14_img01": (20, "behav_synth"),      # 32-bit behavioral synthesis
    "page15_img00": (21, "behav_area"),       # 32-bit behavioral area report
    "page15_img01": (22, "behav_power"),      # 32-bit behavioral power report
    "page16_img00": (23, "behav_pnr"),        # 32-bit behavioral Innovus PnR
    "page16_img01": (24, "behav_drc"),        # 32-bit behavioral DRC
    "page16_img02": (25, "behav_conn"),       # 32-bit behavioral connectivity
    "page17_img00": (26, "chip_padframe"),    # Full-chip layout with pad frame
    "page17_img01": (27, "chip_pindiagram"),  # Chip pin diagram
}


def semantic_name(key: str) -> str | None:
    """Return ``figNN_slug.png`` for a raw ``page<NN>_img<K>`` key, or None."""
    if key not in FIGMAP:
        return None
    number, slug = FIGMAP[key]
    return f"fig{number:02d}_{slug}.png"


def extract(pdf_path: Path, out_dir: Path) -> int:
    if not pdf_path.is_file():
        raise SystemExit(f"[extract_figures] source PDF not found: {pdf_path}")

    out_dir.mkdir(parents=True, exist_ok=True)
    reader = PdfReader(str(pdf_path))
    manifest_rows: list[tuple[str, int, int, int, int, str]] = []
    total = 0

    for page_no, page in enumerate(reader.pages, start=1):
        try:
            images = list(page.images)
        except Exception as exc:  # noqa: BLE001 - keep going on odd pages
            print(f"[extract_figures] page {page_no}: could not read images ({exc})")
            continue

        for img_idx, image in enumerate(images):
            key = f"page{page_no:02d}_img{img_idx:02d}"
            raw_name = f"{key}.png"
            raw_dest = out_dir / raw_name
            png_bytes: bytes | None = None
            try:
                pil = image.image  # Pillow Image object
                # Normalise mode so every output is a plain, viewer-friendly PNG.
                if pil.mode in ("P", "CMYK", "LA"):
                    pil = pil.convert("RGB")
                pil.save(raw_dest, format="PNG")
                w, h = pil.size
            except Exception:  # noqa: BLE001 - fall back to raw (already-PNG) bytes
                png_bytes = image.data
                raw_dest.write_bytes(png_bytes)
                try:
                    from PIL import Image as _Image  # local import, optional
                    with _Image.open(raw_dest) as probe:
                        w, h = probe.size
                except Exception:  # noqa: BLE001
                    w = h = 0

            # Also write the semantic ``figNN_slug.png`` copy used by the LaTeX.
            sem = semantic_name(key)
            label = ""
            if sem is not None:
                (out_dir / sem).write_bytes(raw_dest.read_bytes())
                label = f"Figure {FIGMAP[key][0]}"

            manifest_rows.append((label, page_no, img_idx, w, h, raw_name, sem or ""))
            total += 1
            tag = f" -> {sem}" if sem else ""
            print(f"[extract_figures] page {page_no:>2}  ->  {raw_name}  ({w}x{h}){tag}")

    manifest = out_dir / "manifest.csv"
    with manifest.open("w", newline="", encoding="utf-8") as fh:
        writer = csv.writer(fh)
        writer.writerow(
            ["figure_label", "page", "img_index", "width", "height",
             "raw_file", "semantic_file"]
        )
        writer.writerows(manifest_rows)

    mapped = sum(1 for r in manifest_rows if r[0])
    print(f"\n[extract_figures] wrote {total} image(s) to {out_dir} "
          f"({mapped} mapped to report figures)")
    print(f"[extract_figures] manifest: {manifest}")
    return total


def main(argv: list[str]) -> int:
    pdf_path = Path(argv[1]).resolve() if len(argv) > 1 else DEFAULT_PDF
    extract(pdf_path, OUT_DIR)
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv))
