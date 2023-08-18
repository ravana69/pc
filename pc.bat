@echo off
title PC Automation Script

:start
cls
echo 1. Open Clock Website on Startup
echo 2. Refresh explorer.exe
echo 3. Schedule Shutdown at 04:40 PM
echo 4. Exit

choice /c 1234 /n /m "Select an option:"

if errorlevel 4 goto exit
if errorlevel 3 goto shutdown
if errorlevel 2 goto refresh
if errorlevel 1 goto open

:open
start "" "https://ravana69.github.io/clock/dist/index.html"
goto start

:refresh
taskkill /f /im explorer.exe
start explorer.exe
echo Explorer.exe refreshed.
pause
goto start

:shutdown
REM Calculate the time difference in minutes until 04:40 PM
for /f "tokens=1,2 delims=: " %%a in ('time /t') do (
    set /a "current_time=(((%%a*60)+1%%b %% 100))"
)
set /a "shutdown_time=((16*60)+40)"

if %current_time% lss %shutdown_time% (
    set /a "shutdown_delay=%shutdown_time% - %current_time%"
) else (
    set /a "shutdown_delay=(24*60) - %current_time% + %shutdown_time%"
)

REM Schedule the shutdown
at %shutdown_time%:%shutdown_delay% "shutdown /s /f /t 60"

echo Shutdown scheduled at 04:40 PM.
pause
goto start

:exit
exit
