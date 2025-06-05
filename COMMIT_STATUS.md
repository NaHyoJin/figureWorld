# 현재 개발 상태 (2025.01.27)

## ✅ 완료된 작업
1. **포트 변경**: 8080 → 8976으로 모든 파일 수정 완료
2. **MVC 구조 완성**: Controller-Service-DAO 패턴 구현
3. **실시간 환율 API 연동**: ExchangeRate-API 호출 기능
4. **Embedded Tomcat 서버**: 독립 실행 가능한 웹 애플리케이션
5. **필요 라이브러리 추가**: javax.annotation-api-1.3.2.jar 다운로드 완료

## 🔥 현재 해결해야 할 문제
1. **인코딩 문제**: MS949 vs UTF-8 충돌로 컴파일 실패
2. **서블릿 API 호환성**: javax.servlet.http.HttpServletRequest.getHttpServletMapping() 500 에러

## 📁 주요 파일 변경사항
- **EmbeddedTomcatServer.java**: 포트 8976으로 변경
- **ExchangeRateController.java**: @WebServlet 제거, web.xml만 사용
- **web.xml**: Spring CharacterEncodingFilter 제거
- **run-simple.cmd, quick-start.cmd**: 포트 8976으로 변경
- **README.md**: 포트 및 Docker 설정 업데이트

## 🏠 집에서 해야 할 작업
1. **인코딩 문제 해결**:
   ```bash
   # 파일 인코딩을 UTF-8로 변경
   javac -encoding UTF-8 -cp "lib/*" -d target/classes src/main/java/kr/co/exchangeRate/*.java
   ```

2. **서블릿 API 업그레이드**:
   ```bash
   # servlet-api-3.1.0.jar → javax.servlet-api-4.0.1.jar
   ```

3. **실행 테스트**:
   ```bash
   # 실행 후 브라우저에서 확인
   http://localhost:8976/exchangeRates.do
   ```

## 💡 참고사항
- 자바 1.8 기반으로 개발
- 톰캣 9 버전 사용
- 실시간 USD/JPY 환율 표시
- 에러 발생시 fallback 데이터 사용 