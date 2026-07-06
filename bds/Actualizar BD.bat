@echo off
setlocal

REM Ejecutar exportar_csv.py
cd /d D:\CODE\hermesfar\bds
python exportar_csv.py

IF ERRORLEVEL 1 (
    echo Error al ejecutar exportar_csv.py
    pause
    exit /b 1
)

REM Ir al repositorio Git
cd /d D:\CODE\hermesfar

REM Actualizar Git
git add .

REM Verificar si hay cambios para commitear
git diff --cached --quiet
IF %ERRORLEVEL% EQU 0 (
    echo No hay cambios para commitear.
    pause
    exit /b 0
)

git commit -m "update biblioteca"

IF ERRORLEVEL 1 (
    echo Error al hacer commit.
    pause
    exit /b 1
)

git push

IF ERRORLEVEL 1 (
    echo Error al hacer push.
    pause
    exit /b 1
)

echo Proceso completado correctamente.
pause
endlocal