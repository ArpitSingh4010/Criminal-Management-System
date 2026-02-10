@echo off
echo ============================================
echo Compile and Deploy - Criminal Management
echo ============================================
echo.

echo Step 1: Compiling Java files...
call compile.bat

if %ERRORLEVEL% NEQ 0 (
    echo.
    echo Compilation failed! Please fix errors first.
    pause
    exit /b 1
)

echo.
echo Step 2: Deploying to Tomcat...
call deploy.bat

echo.
echo ============================================
echo Done! Application should be running now.
echo ============================================
