# Hermes.Ar — Quarto Site

## Estructura del proyecto

```
quarto-hermes/
├── _quarto.yml              ← Config: navbar, tema, colores
├── styles.css               ← Toda la estética (verde sobrio + Playfair Display)
├── index.qmd                ← Inicio con foto circular
├── img/
│   └── foto.jpg             ← ⬅ TU FOTO VA ACÁ (renombrá a foto.jpg)
├── bds/
│   └── Biblioteca.csv       ← ⬅ EL CSV VA ACÁ (ya lo tenés)
└── pages/
    ├── cv.qmd
    ├── publicaciones.qmd
    ├── vbiblioteca.qmd
    └── Escritos/            ← Copiar todos los PDFs acá
```

## Pasos rápidos

### 1. Poner tu foto
Copiá tu foto a `img/foto.jpg` y en `index.qmd` reemplazá el bloque
`<div class="photo-placeholder">` por `<img src="img/foto.jpg" alt="Hermes Fernández">`.

### 2. Poner el CSV de la biblioteca
Ya está en `bds/Biblioteca.csv` (el archivo que me mandaste).

### 3. Poner los PDFs
Copialos a `pages/Escritos/`.

### 4. Levantar
```bash
quarto preview    # preview en vivo con hot-reload
quarto render     # genera _site/
quarto publish gh-pages  # publica en GitHub Pages
```

## Problema del CSV resuelto
El path `../bds/Biblioteca.csv` es relativo al HTML renderizado en `_site/pages/`.
Quarto copia `bds/` al output gracias a `resources: - bds/` en `_quarto.yml`.
El script también elimina el BOM (﻿) que tenía tu CSV exportado desde Excel.
