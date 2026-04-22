@echo off
setlocal EnableDelayedExpansion

REM ===== BASE JAVA DIRECTORY =====
set "JAVA_BASE=C:\Program Files\Java"

echo ==============================
echo   Java Version Switcher
echo ==============================

set i=0

REM ===== LIST ALL JDKs =====
for /d %%D in ("%JAVA_BASE%\*") do (
    set /a i+=1
    set "jdk[!i!]=%%~nxD"
    echo !i!. %%~nxD
)

echo.
set /p choice=Select Java version (enter number): 

REM ===== VALIDATE INPUT =====
if not defined jdk[%choice%] (
    echo  Invalid choice!
    pause
    exit /b
)

set "SELECTED_JDK=!jdk[%choice%]!"
set "NEW_JAVA_HOME=%JAVA_BASE%\!SELECTED_JDK!"

echo.
echo You selected: !SELECTED_JDK!

REM ===== SET JAVA_HOME PERMANENT =====
setx JAVA_HOME "!NEW_JAVA_HOME!" /M

REM ===== UPDATE PATH CLEANLY =====
echo Updating PATH...

for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set CURRENT_PATH=%%b

REM Remove old Java entries (basic cleanup)
set "CLEAN_PATH=!CURRENT_PATH:;%%JAVA_HOME%%\bin=!"

REM Add new Java bin at beginning
set "FINAL_PATH=!NEW_JAVA_HOME!\bin;!CLEAN_PATH!"

setx Path "!FINAL_PATH!" /M

echo.
echo  Java switched permanently to !SELECTED_JDK!
echo ️ Restart terminal to apply changes

pause