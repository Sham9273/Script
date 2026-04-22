@echo off

echo.
echo ==============================
echo     Java Version Switcher
echo ==============================
echo.
echo 1 - Java 8 (jdk1.8.0_281)
echo 2 - Java 11
echo 3 - Java 17
echo 4 - Java 21
echo.

set /p choice=Enter choice:

if "%choice%"=="1" set "NEW_JAVA_HOME=C:\Program Files\Java\jdk1.8.0_281"
if "%choice%"=="2" set "NEW_JAVA_HOME=C:\Program Files\Java\jdk-11"
if "%choice%"=="3" set "NEW_JAVA_HOME=C:\Program Files\Java\jdk-17"
if "%choice%"=="4" set "NEW_JAVA_HOME=C:\Program Files\Java\jdk-21"

if not defined NEW_JAVA_HOME (
    echo Invalid choice
    pause
    exit /b
)

echo.
echo Switching to:
echo %NEW_JAVA_HOME%
echo.

:: Set JAVA_HOME globally
setx JAVA_HOME "%NEW_JAVA_HOME%" /M


:: Also update current session (so you don't need restart for THIS window)
set "JAVA_HOME=%NEW_JAVA_HOME%"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo  Java switched successfully!
echo.

echo Current JAVA_HOME:
echo %JAVA_HOME%

echo.
echo Java version:
java -version

echo.
echo NOTE:
echo Open NEW CMD/Terminal for permanent effect.

pause