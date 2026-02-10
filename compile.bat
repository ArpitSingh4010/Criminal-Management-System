@echo off
echo Compiling Criminal Management Application...

REM Set Tomcat path (needed for servlet libraries)
set TOMCAT_HOME=C:\apache-tomcat-10.1.52
set PROJECT_DIR=%~dp0Criminal Mangement

REM Check if Tomcat exists
if not exist "%TOMCAT_HOME%\lib\servlet-api.jar" (
    if not exist "%TOMCAT_HOME%\lib\jakarta.servlet-api*.jar" (
        echo ERROR: Tomcat libraries not found at %TOMCAT_HOME%\lib
        echo Please download Tomcat first or update TOMCAT_HOME path
        pause
        exit /b 1
    )
)

cd "%PROJECT_DIR%"

REM Clean and create build directory
if exist "build\classes" rmdir /S /Q "build\classes"
mkdir "build\classes"

REM Compile Java files
echo Compiling Java source files...
javac -d "build\classes" ^
      -cp "src\main\webapp\WEB-INF\lib\*;%TOMCAT_HOME%\lib\*" ^
      -encoding UTF-8 ^
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
      src\main\java\com\SignUp\model\*.java

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ============================================
    echo Compilation successful!
    echo ============================================
    echo.
    echo Now run deploy.bat to deploy to Tomcat
) else (
    echo.
    echo ============================================
    echo Compilation failed! Check errors above.
    echo ============================================
)

pause
