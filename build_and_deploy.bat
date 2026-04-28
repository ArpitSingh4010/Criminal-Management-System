@echo off
REM ============================================
REM Criminal Management System - Build & Deploy Script
REM ============================================
REM This script automates the build and deployment process
REM Run this after applying database fixes

setlocal enabledelayedexpansion

echo.
echo ============================================
echo Criminal Management System - Build & Deploy
echo ============================================
echo.

REM Set variables
set PROJECT_PATH=Criminal Mangement
set BUILD_DIR=%PROJECT_PATH%\build
set WAR_FILE=%BUILD_DIR%\criminal.war
set TOMCAT_PATH=C:\apache-tomcat-10.1.52
set WEBAPPS_PATH=%TOMCAT_PATH%\webapps

REM Display configuration
echo Configuration:
echo  - Project: %PROJECT_PATH%
echo  - WAR File: %WAR_FILE%
echo  - Tomcat: %TOMCAT_PATH%
echo.

REM Step 1: Verify Tomcat is accessible
echo [Step 1/5] Verifying Tomcat path...
if not exist "%TOMCAT_PATH%" (
    echo ERROR: Tomcat not found at %TOMCAT_PATH%
    echo Please update TOMCAT_PATH in this script
    exit /b 1
)
echo ✓ Tomcat found
echo.

REM Step 2: Stop Tomcat
echo [Step 2/5] Stopping Tomcat...
echo Sending stop command to Tomcat...
call "%TOMCAT_PATH%\bin\catalina.bat" stop
timeout /t 3 /nobreak
echo ✓ Tomcat stopped (or was already stopped)
echo.

REM Step 3: Clean build
echo [Step 3/5] Cleaning build directory...
cd "%PROJECT_PATH%"
call ant clean
cd ..
if errorlevel 1 (
    echo ERROR: ant clean failed
    exit /b 1
)
echo ✓ Build cleaned
echo.

REM Step 4: Build WAR
echo [Step 4/5] Building WAR file...
cd "%PROJECT_PATH%"
call ant war
cd ..
if not exist "%WAR_FILE%" (
    echo ERROR: WAR file not created
    echo Verify ant build completed successfully
    exit /b 1
)
echo ✓ WAR built successfully: %WAR_FILE%
echo.

REM Step 5: Deploy to Tomcat
echo [Step 5/5] Deploying to Tomcat...
echo Copying WAR to: %WEBAPPS_PATH%
copy "%WAR_FILE%" "%WEBAPPS_PATH%\"
if errorlevel 1 (
    echo ERROR: Failed to copy WAR file
    exit /b 1
)
echo ✓ WAR deployed to Tomcat
echo.

REM Step 6: Start Tomcat
echo [Step 6/6] Starting Tomcat...
call "%TOMCAT_PATH%\bin\catalina.bat" start
echo Tomcat starting... Please wait 10-15 seconds
timeout /t 15 /nobreak
echo.

REM Verification
echo ============================================
echo Deployment Complete!
echo ============================================
echo.
echo Application should be available at:
echo   http://localhost:8080/criminal
echo.
echo Next steps:
echo  1. Open http://localhost:8080/criminal in browser
echo  2. Test the Criminals page (click "Criminals Database")
echo  3. Test search functionality
echo  4. Check Tomcat logs if errors occur:
echo    %TOMCAT_PATH%\logs\catalina.out
echo.
echo To view logs in real-time:
echo  powershell -Command "Get-Content '%TOMCAT_PATH%\logs\catalina.out' -Wait"
echo.
pause

