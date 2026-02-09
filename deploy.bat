@echo off
echo ============================================
echo Criminal Management - Manual Deployment
echo ============================================
echo.

REM Set Tomcat path
set TOMCAT_HOME=C:\apache-tomcat-10.1.52
set CATALINA_HOME=C:\apache-tomcat-10.1.52
set JAVA_HOME=C:\Program Files\Java\jdk-22
set PROJECT_DIR=%~dp0Criminal Mangement

if not exist "%TOMCAT_HOME%" (
    echo ERROR: Tomcat not found at %TOMCAT_HOME%
    echo Please download Tomcat and update TOMCAT_HOME in this file
    pause
    exit /b 1
)

echo Stopping Tomcat if running...
call "%TOMCAT_HOME%\bin\shutdown.bat" 2>nul
timeout /t 3 /nobreak >nul

echo Cleaning previous deployment...
rmdir /S /Q "%TOMCAT_HOME%\webapps\criminal" 2>nul
del /Q "%TOMCAT_HOME%\webapps\criminal.war" 2>nul

echo Copying application files...
xcopy "%PROJECT_DIR%\src\main\webapp" "%TOMCAT_HOME%\webapps\criminal\" /E /I /Y
xcopy "%PROJECT_DIR%\build\classes" "%TOMCAT_HOME%\webapps\criminal\WEB-INF\classes\" /E /I /Y

echo.
echo Starting Tomcat...
start "" "%TOMCAT_HOME%\bin\startup.bat"

echo.
echo ============================================
echo Server starting on PORT 8081...
echo Access your app at: http://localhost:8081/criminal/Login.jsp
echo ============================================
timeout /t 5
start http://localhost:8081/criminal/Login.jsp

pause
