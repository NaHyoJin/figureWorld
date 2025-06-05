@echo off
echo ========================================
echo    서블릿 API 호환성 문제 해결
echo ========================================

echo 🗑️ 1단계: 기존 서블릿 API 제거
if exist lib\servlet-api-3.1.0.jar (
    del lib\servlet-api-3.1.0.jar
    echo ✅ servlet-api-3.1.0.jar 제거 완료
)

if exist lib\javax.servlet-api-4.0.1.jar (
    echo ℹ️ javax.servlet-api-4.0.1.jar 이미 존재
) else (
    echo 📥 2단계: 서블릿 API 4.0.1 다운로드
    powershell -Command "Invoke-WebRequest -Uri 'https://repo1.maven.org/maven2/javax/servlet/javax.servlet-api/4.0.1/javax.servlet-api-4.0.1.jar' -OutFile 'lib\javax.servlet-api-4.0.1.jar'"
    echo ✅ javax.servlet-api-4.0.1.jar 다운로드 완료
)

echo 📋 3단계: lib 폴더 확인
dir lib\*.jar

echo 🔧 4단계: 컴파일 및 실행
call fix-encoding-issues.cmd

echo ✅ 서블릿 API 호환성 문제 해결 완료!
pause 