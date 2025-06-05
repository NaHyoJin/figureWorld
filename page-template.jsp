<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>페이지 제목</title>
    <!-- 공통 스타일은 반드시 포함 -->
    <link rel="stylesheet" href="common.css">
    <!-- 페이지별 전용 스타일 (선택사항) -->
    <link rel="stylesheet" href="page-specific.css">
</head>
<body>
    <!-- 메인 컨테이너 -->
    <div class="page-container">
        <div class="content-container">
            
            <!-- 페이지 헤더 -->
            <header class="page-header">
                <h1>🎯 페이지 제목</h1>
                <p>페이지에 대한 간단한 설명</p>
            </header>

            <%--
                서버 사이드 데이터 처리 영역
                JSP 스크립틀릿이나 EL 표현식 사용
            --%>

            <!-- 업데이트 시간 표시 (선택사항) -->
            <div class="last-updated text-muted text-small">
                최근 업데이트: <span id="lastUpdateTime">2025-05-27 22:30:00</span>
            </div>

            <!-- 메인 콘텐츠 섹션들 -->
            <section class="content-section">
                <h2>섹션 제목 1</h2>
                <div class="info-card">
                    <strong>정보 제목</strong>
                    <span>정보 내용</span>
                </div>
                <!-- 알림 메시지 (선택사항) -->
                <div class="alert alert-info">
                    <p>정보성 메시지</p>
                </div>
            </section>

            <section class="content-section">
                <h2>섹션 제목 2</h2>
                <div class="info-card">
                    <strong>정보 제목</strong>
                    <span class="status-up">상승 상태</span>
                    <span class="status-down">하락 상태</span>
                    <span class="status-stable">안정 상태</span>
                </div>
                
                <!-- 버튼 예시 -->
                <div class="mt-20">
                    <button class="btn btn-primary">주요 액션</button>
                    <button class="btn btn-secondary">보조 액션</button>
                </div>
            </section>

            <!-- 추가 섹션들... -->

            <!-- 페이지 푸터 -->
            <footer class="page-footer">
                <p>&copy; <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> 시스템명. 모든 권리 보유.</p>
                <p>추가 정보나 면책 조항</p>
            </footer>
            
        </div>
    </div>

    <%--
    <!-- JavaScript 영역 (선택사항) -->
    <script>
        // 페이지별 JavaScript 로직
        
        // 데이터 업데이트 함수 예시
        function updatePageData(data) {
            // DOM 업데이트 로직
        }
        
        // 이벤트 리스너 등록
        document.addEventListener('DOMContentLoaded', function() {
            // 초기화 로직
        });
    </script>
    --%>
</body>
</html> 