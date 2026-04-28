@echo off
echo ============================================
echo Criminal Management - Deploy to Tomcat
echo ============================================
echo.

REM Set Tomcat path
set TOMCAT_HOME=C:\apache-tomcat-10.1.52
set CATALINA_HOME=C:\apache-tomcat-10.1.52
set JAVA_HOME=C:\Program Files\Java\jdk-22
set TOMCAT_PORT=8081
set PROJECT_DIR=%~dp0Criminal Mangement

REM Verify Tomcat exists
if not exist "%TOMCAT_HOME%\bin\catalina.bat" (
    echo ERROR: Tomcat not found at %TOMCAT_HOME%
    echo Please verify the path and update TOMCAT_HOME in this script
    pause
    exit /b 1
)

REM Check if WAR file exists
REM Check if built application exists
if not exist "%PROJECT_DIR%\build\criminal\WEB-INF" (
    echo ERROR: Application not built at %PROJECT_DIR%\build\criminal
    echo Please run compile.bat first
    pause
    exit /b 1
)

echo Stopping Tomcat...
call "%TOMCAT_HOME%\bin\shutdown.bat" 2>nul
timeout /t 5 /nobreak >nul

echo Cleaning previous deployment...
rmdir /S /Q "%TOMCAT_HOME%\webapps\criminal" 2>nul
del /Q "%TOMCAT_HOME%\webapps\criminal.war" 2>nul

echo Deploying application...
xcopy "%PROJECT_DIR%\build\criminal\*" "%TOMCAT_HOME%\webapps\criminal\" /E /I /Y /Q

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to copy application files
    pause
    exit /b 1
)

echo.
echo Starting Tomcat in foreground...

echo.
echo ============================================
echo Deployment complete!
echo ============================================
echo.
echo Access application at:
echo http://localhost:%TOMCAT_PORT%/criminal/Login.jsp
echo.
echo Tomcat logs will stream in this terminal.
echo Press Ctrl+C to stop Tomcat.
echo ============================================

start "" "http://localhost:%TOMCAT_PORT%/criminal/Login.jsp"
call "%TOMCAT_HOME%\bin\catalina.bat" run

