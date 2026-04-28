@echo off
echo ============================================
echo Criminal Management - Build WAR File
echo ============================================
echo.

REM Set paths
set PROJECT_DIR=%~dp0Criminal Mangement
set TOMCAT_HOME=C:\apache-tomcat-10.1.52

REM Navigate to project directory
cd /d "%PROJECT_DIR%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to navigate to project directory
    pause
    exit /b 1
)

REM Verify required files exist
if not exist "src\main\java" (
    echo ERROR: src\main\java directory not found
    pause
    exit /b 1
)

if not exist "src\main\webapp" (
    echo ERROR: src\main\webapp directory not found
    pause
    exit /b 1
)

REM Clean previous build
echo Cleaning previous build...
if exist "build\classes" rmdir /S /Q "build\classes"
if exist "build\criminal" rmdir /S /Q "build\criminal"
mkdir "build\classes"

REM Compile Java files
echo.
echo Compiling Java source files...
echo.

javac -d "build\classes" ^
	-cp "src\main\webapp\WEB-INF\lib\*;%TOMCAT_HOME%\lib\*" ^
	-encoding UTF-8 ^
	src\main\java\com\AdminLogin\*.java ^
	src\main\java\com\AdminLogin\dao\*.java ^
	src\main\java\com\AdminCaseType\*.java ^
	src\main\java\com\AdminCaseType\dao\*.java ^
	src\main\java\com\login\*.java ^
	src\main\java\com\login\dao\*.java ^
	src\main\java\com\Criminals\*.java ^
	src\main\java\com\Criminals\dao\*.java ^
	src\main\java\com\Criminals\model\*.java ^
	src\main\java\com\CaseType\*.java ^
	src\main\java\com\CaseType\dao\*.java ^
	src\main\java\com\CaseType\model\*.java ^
	src\main\java\com\Officer\*.java ^
	src\main\java\com\Officer\Dao\*.java ^
	src\main\java\com\Officer\model\*.java ^
	src\main\java\com\Laws\*.java ^
	src\main\java\com\Laws\Dao\*.java ^
	src\main\java\com\Laws\model\*.java ^
	src\main\java\com\Reports\*.java ^
	src\main\java\com\Reports\dao\*.java ^
	src\main\java\com\Reports\model\*.java ^
	src\main\java\com\LogOut\*.java ^
	src\main\java\com\LogOut\dao\*.java ^
	src\main\java\com\LogOut\model\*.java ^
	src\main\java\com\SignUp\*.java ^
	src\main\java\com\SignUp\dao\*.java ^
	src\main\java\com\SignUp\model\*.java ^
	src\main\java\com\Complaint\model\*.java ^
	src\main\java\com\Complaint\dao\*.java ^
	src\main\java\com\Complaint\*.java

if %ERRORLEVEL% NEQ 0 (
	echo.
	echo ============================================
	echo Compilation FAILED!
	echo ============================================
	pause
	exit /b 1
)

echo.
echo Compilation successful!
echo.
echo Creating WAR directory structure...
mkdir "build\criminal\WEB-INF\classes"
mkdir "build\criminal\WEB-INF\lib"

echo Copying web resources...
xcopy "src\main\webapp\*" "build\criminal\" /E /I /Y /Q

echo Copying compiled classes...
xcopy "build\classes\*" "build\criminal\WEB-INF\classes\" /E /I /Y /Q

echo Copying libraries...
xcopy "src\main\webapp\WEB-INF\lib\*" "build\criminal\WEB-INF\lib\" /E /I /Y /Q 2>nul

echo.
echo ============================================
echo ✓ Build successful!
echo ============================================
echo.
echo Output: build\criminal (exploded WAR)
echo.
echo Next step:
echo   Run: deploy.bat
echo.
pause
@echo off
echo ============================================
echo Criminal Management - Build WAR File
echo ============================================
echo.

REM Set paths
set PROJECT_DIR=%~dp0Criminal Mangement
set ANT_HOME=C:\\apache-ant-1.10.12
set TOMCAT_HOME=C:\\apache-tomcat-10.1.52

REM Check if ant.bat exists
if exist \"%ANT_HOME%\\bin\\ant.bat\" (
    goto USE_ANT
)

REM Fallback to direct javac compilation
echo WARNING: Apache Ant not found, using direct compilation...
echo.
goto USE_JAVAC

:USE_ANT
echo Using Apache Ant for build...
echo.

REM Change to project directory
cd /d "%PROJECT_DIR%"

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to navigate to %PROJECT_DIR%
    pause
    exit /b 1
)

echo Cleaning previous build...
call "%ANT_HOME%\bin\ant.bat" clean

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Clean step failed
    pause
    exit /b 1
)

echo.
echo Building WAR file...
call "%ANT_HOME%\bin\ant.bat" war

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo Build successful!
    echo WAR file: build\criminal.war
    echo ============================================
    echo.
    echo Next steps:
    echo 1. Run: deploy.bat
    echo 2. Open: http://localhost:8080/criminal
) else (
    echo.
    echo ============================================
    echo Build failed! Check errors above.
    echo ============================================
)

pause
