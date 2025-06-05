@echo off
echo 🚀 Exchange Rate 시스템 - 심플 실행기
echo.

REM Java 체크
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java가 설치되지 않았거나 PATH에 설정되지 않았습니다.
    echo Java 8 이상을 설치하고 PATH를 설정하세요.
    echo 📥 Java 다운로드: https://adoptium.net/
    pause
    exit /b 1
)

echo ✅ Java 환경 확인 완료
echo.

REM 필요한 디렉토리 생성
if not exist "target\classes" mkdir "target\classes"
if not exist "lib" mkdir "lib"

echo 📦 필요한 라이브러리를 다운로드합니다...
echo    이 과정은 최초 실행 시에만 진행됩니다.
echo.

REM 임베디드 Tomcat JAR 다운로드 (필요시)
if not exist "lib\tomcat-embed-core-9.0.70.jar" (
    echo 📥 Tomcat Embed Core 다운로드 중...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-core/9.0.70/tomcat-embed-core-9.0.70.jar', 'lib\tomcat-embed-core-9.0.70.jar')"
)

if not exist "lib\tomcat-embed-jasper-9.0.70.jar" (
    echo 📥 Tomcat Embed Jasper 다운로드 중...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-jasper/9.0.70/tomcat-embed-jasper-9.0.70.jar', 'lib\tomcat-embed-jasper-9.0.70.jar')"
)

if not exist "lib\tomcat-embed-el-9.0.70.jar" (
    echo 📥 Tomcat Embed EL 다운로드 중...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/org/apache/tomcat/embed/tomcat-embed-el/9.0.70/tomcat-embed-el-9.0.70.jar', 'lib\tomcat-embed-el-9.0.70.jar')"
)

if not exist "lib\servlet-api-3.1.0.jar" (
    echo 📥 Servlet API 다운로드 중...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/3.1.0/javax.servlet-api-3.1.0.jar', 'lib\servlet-api-3.1.0.jar')"
)

if not exist "lib\jsp-api-2.3.3.jar" (
    echo 📥 JSP API 다운로드 중...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/javax/servlet/jsp/jsp-api/2.3.3/jsp-api-2.3.3.jar', 'lib\jsp-api-2.3.3.jar')"
)

if not exist "lib\jstl-1.2.jar" (
    echo 📥 JSTL 다운로드 중...
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://repo1.maven.org/maven2/javax/servlet/jstl/1.2/jstl-1.2.jar', 'lib\jstl-1.2.jar')"
)

echo.
echo ✅ 라이브러리 다운로드 완료
echo.

echo 🔨 Java 소스 컴파일 중...
javac -cp "lib\*" -d "target\classes" src\main\java\kr\co\exchangeRate\*.java src\main\java\kr\co\exchangeRate\controller\*.java src\main\java\kr\co\exchangeRate\service\*.java src\main\java\kr\co\exchangeRate\dao\*.java src\main\java\kr\co\exchangeRate\vo\*.java src\main\java\kr\co\exchangeRate\exception\*.java

if %errorlevel% neq 0 (
    echo ❌ 컴파일 실패
    pause
    exit /b 1
)

echo ✅ 컴파일 완료
echo.

echo 🚀 서버를 시작합니다...
echo 🌐 브라우저에서 http://localhost:8976/exchangeRates.do 로 접속하세요
echo 🛑 종료하려면 Ctrl+C를 누르세요
echo.

java -cp "target\classes;lib\*" kr.co.exchangeRate.EmbeddedTomcatServer 8976

echo.
echo �� 서버가 종료되었습니다.
pause 