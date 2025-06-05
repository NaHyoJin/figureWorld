@echo off
chcp 65001 >nul
echo 🚀 Exchange Rate System - Quick Start
echo.

REM Java check
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java not found. Please install Java 8 or higher.
    echo 📥 Download: https://adoptium.net/
    pause
    exit /b 1
)

echo ✅ Java environment OK
echo.

REM Create directories
if not exist "target\classes" mkdir "target\classes"
if not exist "lib" mkdir "lib"

echo 📦 Downloading essential libraries (first run only)...
echo.

REM Download essential Tomcat jars
if not exist "lib\tomcat-embed-core-9.0.70.jar" (
    echo 📥 Downloading Tomcat Core...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-core/9.0.70/tomcat-embed-core-9.0.70.jar', 'lib\tomcat-embed-core-9.0.70.jar')" 2>nul
    if %errorlevel% neq 0 (
        echo ⚠️  Download failed, but will try to continue...
    )
)

if not exist "lib\servlet-api-3.1.0.jar" (
    echo 📥 Downloading Servlet API...
    powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; (New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar', 'lib\servlet-api-3.1.0.jar')" 2>nul
    if %errorlevel% neq 0 (
        echo ⚠️  Download failed, but will try to continue...
    )
)

echo.
echo ✅ Library setup complete
echo.

echo 🔨 Compiling Java sources...
javac -encoding UTF-8 -cp "lib\*" -d "target\classes" src\main\java\kr\co\exchangeRate\*.java src\main\java\kr\co\exchangeRate\controller\*.java src\main\java\kr\co\exchangeRate\service\*.java src\main\java\kr\co\exchangeRate\dao\*.java src\main\java\kr\co\exchangeRate\vo\*.java src\main\java\kr\co\exchangeRate\exception\*.java 2>nul

if %errorlevel% neq 0 (
    echo ❌ Compilation failed. Please check your Java code.
    echo.
    echo 💡 Alternative: Open project in IDE and run EmbeddedTomcatServer class
    pause
    exit /b 1
)

echo ✅ Compilation successful
echo.

echo 🚀 Starting server...
echo 🌐 Access: http://localhost:8976/exchangeRates.do
echo 🛑 Press Ctrl+C to stop
echo.

java -cp "target\classes;lib\*" kr.co.exchangeRate.EmbeddedTomcatServer 8976

echo.
echo 🛑 Server stopped.
pause 