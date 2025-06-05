@echo off
echo ========================================
echo         Git Commit Script
echo ========================================

echo 📂 Git 저장소 초기화 중...
git init .

echo 📝 사용자 정보 설정 중...
set /p GIT_NAME="Git 사용자명을 입력하세요 (예: 홍길동): "
set /p GIT_EMAIL="Git 이메일을 입력하세요 (예: hong@example.com): "
git config user.name "MikuOhashi"
git config user.email "nahyo0207@gmail.com"

echo ➕ 파일 추가 중...
git add .

echo 💾 커밋 생성 중...
git commit -m "🔧 포트 8976 변경 및 MVC 구조 완성

✅ 완료된 작업:
- 포트 8080 → 8976 변경 (모든 파일)
- @WebServlet 어노테이션 제거
- Spring CharacterEncodingFilter 제거
- javax.annotation-api-1.3.2.jar 추가
- MVC 패턴 구조 완성

🔥 해결 필요:
- 인코딩 문제 (MS949 vs UTF-8)
- 서블릿 API 호환성 문제

📍 브라우저 접속: http://localhost:8976/exchangeRates.do"

echo 🌐 원격 저장소 추가 중...
git remote add origin https://github.com/NaHyoJin/figureWorld.git

echo 📤 원격 저장소로 푸시 중...
git push -u origin main

echo ✅ GitHub에 성공적으로 업로드되었습니다!
echo 🔗 저장소 주소: https://github.com/NaHyoJin/figureWorld

pause 