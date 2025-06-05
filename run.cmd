@echo off
echo 🚀 Exchange Rate 시스템을 시작합니다...
echo.

REM Java 체크
java -version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Java가 설치되지 않았거나 PATH에 설정되지 않았습니다.
    echo Java 8 이상을 설치하고 PATH를 설정하세요.
    echo.
    echo 📥 Java 다운로드: https://adoptium.net/
    pause
    exit /b 1
)

echo ✅ Java 환경 확인 완료

REM Maven 설치 확인
mvn -version >nul 2>&1
if %errorlevel% equ 0 (
    echo ✅ Maven이 설치되어 있습니다.
    echo 📦 Maven으로 프로젝트를 컴파일하고 실행합니다...
    echo.
    
    REM Maven으로 실행
    mvn clean compile exec:exec -Dexec.mainClass="kr.co.exchangeRate.EmbeddedTomcatServer" -Dexec.args="8976"
    
) else (
    echo ⚠️  Maven이 설치되지 않았습니다.
    echo.
    echo 📥 다음 중 하나를 선택하세요:
    echo.
    echo 1. Maven 설치 후 다시 실행
    echo    다운로드: https://maven.apache.org/download.cgi
    echo.
    echo 2. IDE에서 프로젝트 열기
    echo    - IntelliJ IDEA, Eclipse, VS Code 등
    echo    - kr.co.exchangeRate.EmbeddedTomcatServer 클래스 실행
    echo.
    echo 3. 수동 컴파일
    echo    javac -cp "lib/*" src/main/java/kr/co/exchangeRate/*.java
    echo    java -cp "target/classes;lib/*" kr.co.exchangeRate.EmbeddedTomcatServer
    echo.
)

echo.
echo �� 실행을 종료합니다.
pause 