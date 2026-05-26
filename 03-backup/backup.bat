@echo off
set DATA=%date:~6,4%-%date:~3,2%-%date:~0,2%
set HORA=%time:~0,2%-%time:~3,2%
set BACKUP_DIR=C:\backups\ecommerce
set DB_NAME=ecommer_db
set DB_USER=root

if not exist %BACKUP_DIR% mkdir %BACKUP_DIR%

mysqldump -u %DB_USER% -p %DB_NAME% > "%BACKUP_DIR%\backup_%DATA%_%HORA%.sql"

if %ERRORLEVEL% == 0 (
    echo Backup criado com sucesso!
) else (
    echo ERRO: Backup falhou!
)