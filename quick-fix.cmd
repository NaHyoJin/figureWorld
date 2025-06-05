@echo off
chcp 65001 > nul
echo 🔥 긴급 수정 및 커밋 스크립트 🔥
echo.

echo [1단계] 인코딩 문제 해결 중...
echo.

REM UTF-8로 컴파일
echo 컴파일 중... (UTF-8 인코딩)
javac -encoding UTF-8 -cp "lib/*;target/classes" -d target/classes src/main/java/kr/co/exchangeRate/*.java src/main/java/kr/co/exchangeRate/controller/*.java src/main/java/kr/co/exchangeRate/service/*.java 2>compile_error.log

if %ERRORLEVEL% EQU 0 (
    echo ✅ 컴파일 성공!
    echo.
    
    echo [2단계] Git 커밋 및 푸시 중...
    echo.
    
    git add .
    git commit -m "Port 8976 변경, 인코딩 문제 해결, 자동화 스크립트 추가"
    git push origin main
    
    if %ERRORLEVEL% EQU 0 (
        echo.
        echo 🎉 성공! GitHub에 업로드 완료!
        echo 📁 https://github.com/NaHyoJin/figureWorld
    ) else (
        echo.
        echo ⚠️ Git 푸시 실패. 수동으로 GitHub Desktop이나 웹에서 확인하세요.
    )
) else (
    echo.
    echo ❌ 컴파일 실패
    echo 📄 오류 내용은 compile_error.log 파일을 확인하세요.
    type compile_error.log
)

echo.
echo 완료되었습니다.
pause 