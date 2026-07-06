import pandas as pd
import os
import sys

XLSX = r"D:\CODE\hermesfar\bds\Biblioteca.xlsx"
CSV  = r"D:\CODE\hermesfar\bds\Biblioteca.csv"

print("Leyendo Excel...")
try:
    df_raw = pd.read_excel(XLSX)
except Exception as e:
    print(f"ERROR leyendo Excel: {e}")
    sys.exit(1)

df = df_raw.iloc[:, [1, 2, 3, 4, 5]].copy()
df.columns = ["Titulo", "Autor", "Editorial", "Anio", "Pais"]
df = df.replace(r'\n|\r', ' ', regex=True)

prestado_col = df_raw.iloc[:, 10]
df["Prestado"] = prestado_col.notna().map({True: "Si", False: "No"})

df.to_csv(CSV, index=False, encoding="utf-8-sig")
print(f"CSV generado: {CSV} ({len(df)} registros)")
