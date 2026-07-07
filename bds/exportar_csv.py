from pathlib import Path
import sys

import pandas as pd

BASE_DIR = Path(__file__).resolve().parent
XLSX = BASE_DIR / "Biblioteca.xlsx"
CSV = BASE_DIR / "Biblioteca.csv"

COLUMNAS_POSICIONALES = [1, 2, 3, 4, 5]
NOMBRES_CSV = ["Titulo", "Autor", "Editorial", "Anio", "Pais"]
PRESTADO_POSICION = 10

print(f"Leyendo Excel: {XLSX}")

if not XLSX.exists():
    print(f"ERROR: no existe el archivo Excel: {XLSX}")
    sys.exit(1)

try:
    df_raw = pd.read_excel(XLSX)
except Exception as e:
    print(f"ERROR leyendo Excel: {e}")
    sys.exit(1)

min_cols = max(COLUMNAS_POSICIONALES + [PRESTADO_POSICION]) + 1
if df_raw.shape[1] < min_cols:
    print(
        "ERROR: el Excel tiene menos columnas de las esperadas. "
        f"Tiene {df_raw.shape[1]} columnas y se necesitan al menos {min_cols}."
    )
    sys.exit(1)

try:
    df = df_raw.iloc[:, COLUMNAS_POSICIONALES].copy()
except Exception as e:
    print(f"ERROR seleccionando columnas: {e}")
    sys.exit(1)

df.columns = NOMBRES_CSV

# Dejar el CSV en una sola linea por registro para que Quarto lo lea sin saltos internos.
df = df.replace(r"\n|\r", " ", regex=True)

# Si la columna K tiene algun valor, se marca como prestado.
prestado_col = df_raw.iloc[:, PRESTADO_POSICION]
df["Prestado"] = prestado_col.notna().map({True: "Si", False: "No"})

try:
    df.to_csv(CSV, index=False, encoding="utf-8-sig")
except Exception as e:
    print(f"ERROR escribiendo CSV: {e}")
    sys.exit(1)

print(f"CSV generado: {CSV} ({len(df)} registros)")
