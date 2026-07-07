# Repository Guidelines

## Project Overview

This is a Quarto personal website for Hermes Fernandez. Source content lives in
Quarto Markdown files (`*.qmd`), shared styling is in `styles.css`, static assets
are in `img/`, `pages/Escritos/`, `pages/Presentaciones/`, and library data is
in `bds/`.

The `_site/` directory is generated output. Prefer editing source files and
running Quarto instead of editing `_site/` directly.

## Important Files

- `_quarto.yml`: site configuration, navbar, footer, output directory, and
  resource paths.
- `index.qmd`: homepage.
- `pages/cv.qmd`: CV page.
- `pages/publicaciones.qmd`: publications page.
- `pages/presentaciones.qmd`: presentation links.
- `pages/vbiblioteca.qmd`: virtual library page with inline JavaScript that
  fetches `../bds/Biblioteca.csv`.
- `styles.css`: global visual styling for the Quarto site.
- `bds/exportar_csv.py`: converts `bds/Biblioteca.xlsx` into
  `bds/Biblioteca.csv`.
- `bds/Actualizar BD.bat`: Windows helper that exports the CSV, commits/pushes
  changes, and publishes with Quarto.

## Local Commands

- Preview locally:
  `quarto preview`
- Render static output:
  `quarto render`
- Publish to GitHub Pages:
  `quarto publish gh-pages --no-browser --no-prompt`
- Regenerate the library CSV:
  `python bds/exportar_csv.py`

`bds/exportar_csv.py` requires `pandas` and an Excel reader such as `openpyxl`.

## Editing Notes

- Keep edits scoped to source files unless the user explicitly asks to inspect or
  repair generated output.
- The site content is Spanish. Preserve Spanish names, accents, and user-facing
  wording.
- Keep asset links relative to the Quarto page location. For example,
  `pages/vbiblioteca.qmd` fetches `../bds/Biblioteca.csv`.
- When adding PDFs or presentations, place files under the existing `pages/`
  asset folders and ensure `_quarto.yml` resources include any new static path.
- Before committing or publishing, check `git status --short`; this worktree may
  contain generated changes in `_site/`.
