@echo off
chcp 65001
echo ========================================
echo     인코딩 문제 해결 스크립트
echo ========================================

echo 🔧 1단계: 클래스 파일 삭제
if exist target\classes (
    rmdir /s /q target\classes
    echo ✅ 기존 클래스 파일 삭제 완료
)

echo 📁 2단계: 클래스 디렉토리 생성
mkdir target\classes

echo ☕ 3단계: UTF-8 인코딩으로 컴파일
echo 📝 EmbeddedTomcatServer 컴파일...
javac -encoding UTF-8 -cp "lib\*" -d target\classes src\main\java\kr\co\exchangeRate\EmbeddedTomcatServer.java

echo 📝 VO 클래스 컴파일...
javac -encoding UTF-8 -cp "lib\*;target\classes" -d target\classes src\main\java\kr\co\exchangeRate\vo\*.java

echo 📝 Exception 클래스 컴파일...
javac -encoding UTF-8 -cp "lib\*;target\classes" -d target\classes src\main\java\kr\co\exchangeRate\exception\*.java

echo 📝 DAO 클래스 컴파일...
javac -encoding UTF-8 -cp "lib\*;target\classes" -d target\classes src\main\java\kr\co\exchangeRate\dao\*.java

echo 📝 Service 클래스 컴파일...
javac -encoding UTF-8 -cp "lib\*;target\classes" -d target\classes src\main\java\kr\co\exchangeRate\service\*.java

echo 📝 Controller 클래스 컴파일...
javac -encoding UTF-8 -cp "lib\*;target\classes" -d target\classes src\main\java\kr\co\exchangeRate\controller\*.java

echo 🚀 4단계: 서버 실행
echo 🌐 브라우저에서 http://localhost:8976/exchangeRates.do 로 접속하세요
java -cp "target\classes;lib\*" kr.co.exchangeRate.EmbeddedTomcatServer 8976

pause 