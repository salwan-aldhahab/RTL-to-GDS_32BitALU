<#
    build.ps1 -- build the ALU documentation PDF on Windows.

    Prefers latexmk; falls back to two pdflatex passes (needed so the
    table of contents, list of figures/tables and cross-references
    resolve). Run from the rtl-to-gds-alu-doc folder:

        ./build.ps1

    Requires a TeX distribution on PATH (e.g. MiKTeX: `choco install miktex`).
    On first MiKTeX run, allow on-the-fly package installation, or run
    `mpm --admin --update` beforehand.
#>
$ErrorActionPreference = 'Stop'
Set-Location -Path $PSScriptRoot

$main = 'main'

function Test-Cmd($name) { [bool](Get-Command $name -ErrorAction SilentlyContinue) }

if (Test-Cmd 'latexmk') {
    Write-Host '==> Building with latexmk' -ForegroundColor Cyan
    latexmk -pdf -interaction=nonstopmode -halt-on-error "$main.tex"
}
elseif (Test-Cmd 'pdflatex') {
    Write-Host '==> latexmk not found; using pdflatex (2 passes)' -ForegroundColor Cyan
    pdflatex -interaction=nonstopmode -halt-on-error "$main.tex"
    pdflatex -interaction=nonstopmode -halt-on-error "$main.tex"
}
else {
    Write-Error 'No LaTeX engine found. Install MiKTeX (`choco install miktex`) or use Overleaf (see README.md).'
}

if (Test-Path "$main.pdf") {
    Write-Host "==> Built $main.pdf" -ForegroundColor Green
}
