@echo off
setlocal EnableExtensions

REM === Configuracion ===
set "REPO=D:\CODE\hermesfar"
set "BDS=%REPO%\bds"
set "PY_SCRIPT=%BDS%\exportar_csv.py"
set "VENV_PY=%REPO%\.venv\Scripts\python.exe"
set "CSV_REL=bds\Biblioteca.csv"
set "COMMIT_MSG=update biblioteca"

REM === Elegir Python: primero .venv, si no existe usa python del sistema ===
if exist "%VENV_PY%" (
    set "PYTHON_EXE=%VENV_PY%"
) else (
    set "PYTHON_EXE=python"
)

echo Usando Python: %PYTHON_EXE%

REM === 1) Convertir Excel a CSV ===
if not exist "%PY_SCRIPT%" (
    echo ERROR: No existe el script: %PY_SCRIPT%
    pause
    exit /b 1
)

cd /d "%BDS%" || (
    echo ERROR: No se pudo entrar a %BDS%
    pause
    exit /b 1
)

"%PYTHON_EXE%" "%PY_SCRIPT%"
if errorlevel 1 (
    echo ERROR: fallo la conversion Excel -^> CSV.
    pause
    exit /b 1
)

REM === 2) Actualizar repo fuente en GitHub ===
cd /d "%REPO%" || (
    echo ERROR: No se pudo entrar al repo: %REPO%
    pause
    exit /b 1
)

git status --short
if errorlevel 1 (
    echo ERROR: esta carpeta no parece ser un repo Git valido.
    pause
    exit /b 1
)

REM Si Biblioteca.csv estuviera ignorado por .gitignore, -f fuerza su inclusion.
git add -A
git add -f "%CSV_REL%"
if errorlevel 1 (
    echo ERROR: fallo git add.
    pause
    exit /b 1
)

git diff --cached --quiet
if errorlevel 1 (
    git commit -m "%COMMIT_MSG%"
    if errorlevel 1 (
        echo ERROR: fallo git commit.
        pause
        exit /b 1
    )

    git push
    if errorlevel 1 (
        echo ERROR: fallo git push. Revisar conexion, permisos o branch sin upstream.
        pause
        exit /b 1
    )
) else (
    echo No hay cambios nuevos para commitear en el repo fuente.
)

REM === 3) Actualizar GitHub Pages con Quarto ===
quarto publish gh-pages --no-browser --no-prompt
if errorlevel 1 (
    echo ERROR: fallo quarto publish gh-pages.
    pause
    exit /b 1
)

echo Proceso completado correctamente: CSV, repo fuente y GitHub Pages.
pause
endlocal
