@echo off
cd /d %~dp0

echo ========================================
echo ClawX Watchdog Launcher (Portable)
echo ========================================
echo.

rem Try to find Python/uv
set PYTHON_FOUND=0

rem Try uv from ClawX
for %%p in (
    "C:\Program Files\ClawX\resources\bin\uv.exe"
    "C:\Program Files (x86)\ClawX\resources\bin\uv.exe"
) do (
    if exist %%p (
        set RUNNER=%%p
        set RUNNER_TYPE=uv
        set PYTHON_FOUND=1
        goto :found
    )
)

rem Try system Python
where python >nul 2>nul
if %errorlevel%==0 (
    set RUNNER=python
    set RUNNER_TYPE=python
    set PYTHON_FOUND=1
    goto :found
)

:found
if %PYTHON_FOUND%==0 (
    echo [ERROR] Python not found!
    echo Please install Python or ClawX first.
    pause
    exit /b 1
)

echo Using %RUNNER_TYPE%: %RUNNER%
echo.
echo Target: Auto-detected (default: http://127.0.0.1:18789/)
echo Interval: 10s
echo Restart: After 3 consecutive failures
echo Log: clawx_watchdog.log
echo.
echo Press Ctrl+C or close window to stop
echo ========================================
echo.

if "%RUNNER_TYPE%"=="uv" (
    %RUNNER% run python clawx_watchdog.py
) else (
    %RUNNER% clawx_watchdog.py
)

echo.
echo Watchdog stopped
pause
