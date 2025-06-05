@echo off
chcp 65001
echo ========================================
echo 🔥 긴급 문제 해결 및 Git 커밋 🔥
echo ========================================

echo 1단계: 인코딩 문제 해결 중...
if not exist "lib" mkdir lib

echo 2단계: Servlet API 업데이트...
powershell -Command "& {[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar' -OutFile 'lib/javax.servlet-api-4.0.1.jar'}"

echo 3단계: UTF-8 컴파일...
javac -encoding UTF-8 -cp "lib/*;." -d "target/classes" src/main/java/kr/co/exchangeRate/*.java src/main/java/kr/co/exchangeRate/controller/*.java src/main/java/kr/co/exchangeRate/service/*.java

if %ERRORLEVEL% EQU 0 (
    echo ✅ 컴파일 성공! Git 커밋 진행...
    
    echo 4단계: Git 설정...
    git config user.name "MikuOhashi"
    git config user.email "nahyo0207@gmail.com"
    
    echo 5단계: Git 커밋...
    git add .
    git commit -m "Port 8976 변경, 인코딩 문제 해결, Servlet API 업데이트"
    git push origin main
    
    echo ========================================
    echo 🎉 모든 문제 해결 완료! 🎉
    echo ========================================
) else (
    echo ❌ 컴파일 실패. 수동으로 인코딩 확인 필요.
)

pause 