<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 및 예측 환율</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/common.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/exchange-rates.css">
</head>
<body>
    <div class="page-container">
        <div class="content-container">
            <header class="page-header">
                <h1>📈 실시간 환율 및 예측</h1>
                <p>Jules Beta를 활용한 미국 달러(USD) 및 일본 엔(JPY) 환율 정보</p>
            </header>

            <!-- API 상태 표시 -->
            <c:choose>
                <c:when test="${!apiSuccess && !empty errorMessage}">
                    <div class="alert alert-warning mb-20">
                        <strong>⚠️ 알림:</strong> ${errorMessage}<br>
                        기본값으로 표시됩니다. 페이지를 새로고침하여 다시 시도해보세요.
                    </div>
                </c:when>
                <c:when test="${apiSuccess}">
                    <div class="alert alert-success mb-20">
                        <strong>✅ 실시간 데이터:</strong> 환율 정보가 성공적으로 업데이트되었습니다.
                    </div>
                </c:when>
            </c:choose>

            <div class="last-updated">
                최근 업데이트: <span id="lastUpdateTime">${lastUpdatedTime}</span>
                <c:choose>
                    <c:when test="${apiSuccess}">
                        <span class="status-up">● 실시간</span>
                    </c:when>
                    <c:otherwise>
                        <span class="status-warning">● 오프라인</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 환율 정보 반복 출력 -->
            <c:forEach var="rate" items="${exchangeRateList}" varStatus="status">
                <section class="content-section currency-section">
                    <h2>
                        <img src="${rate.flagUrl}" 
                             srcset="${rate.flagUrl} 2x" 
                             width="30" 
                             alt="${rate.currencyCode}"> 
                        ${rate.currencyName}
                    </h2>
                    <div class="rate-info">
                        <div>
                            <strong>현재 환율 (${rate.currencyCode}/KRW)</strong>
                            <span id="current${rate.currencyCode}Rate">${rate.formattedCurrentRate}</span><span class="currency-unit">원</span>
                        </div>
                        <div>
                            <strong>미래 예측 환율 (Jules Beta)</strong>
                            <span id="predicted${rate.currencyCode}Rate">${rate.formattedPredictedRate}</span><span class="currency-unit">원</span>
                        </div>
                    </div>
                    <div class="comparison">
                        <h3>${rate.currencyCode} 환율 예측 요약</h3>
                        <p id="${rate.currencyCode}ComparisonText">
                            미래 예측 환율은 현재보다 
                            <span class="${rate.trendClass}">${rate.trend}</span>할 것으로 예상됩니다. 
                            (${rate.formattedRateDifference}원 <span class="${rate.trendClass}">${rate.trendSymbol}</span>)
                        </p>
                    </div>
                </section>
            </c:forEach>

            <!-- 새로고침 버튼 추가 -->
            <div class="text-center mt-30">
                <button class="btn btn-primary" onclick="location.reload();">🔄 환율 새로고침</button>
                <button class="btn btn-secondary" onclick="toggleAutoRefresh();">⏰ 자동 새로고침</button>
            </div>

            <footer class="page-footer">
                <p>&copy; <fmt:formatDate value="<%=new java.util.Date()%>" pattern="yyyy" /> 환율 정보 서비스. 모든 권리 보유.</p>
                <p>환율 정보는 참고용이며, 실제 거래 시에는 해당 금융기관의 고시 환율을 확인하시기 바랍니다.</p>
                <p>예측 정보는 Jules Beta의 분석에 기반하며, 투자 결정에 대한 책임은 본인에게 있습니다.</p>
                <p class="text-small mt-10">데이터 제공: ExchangeRate-API | 업데이트 주기: 실시간</p>
            </footer>
            
        </div>
    </div>

    <script>
        let autoRefreshInterval = null;
        let isAutoRefreshEnabled = false;

        // 자동 새로고침 토글 함수
        function toggleAutoRefresh() {
            const button = event.target;
            
            if (isAutoRefreshEnabled) {
                // 자동 새로고침 중지
                clearInterval(autoRefreshInterval);
                autoRefreshInterval = null;
                isAutoRefreshEnabled = false;
                button.textContent = '⏰ 자동 새로고침';
                button.className = 'btn btn-secondary';
            } else {
                // 자동 새로고침 시작 (30초마다)
                autoRefreshInterval = setInterval(function() {
                    location.href = '${pageContext.request.contextPath}/exchangeRates.do';
                }, 30000);
                isAutoRefreshEnabled = true;
                button.textContent = '⏸️ 자동 새로고침 중지';
                button.className = 'btn btn-danger';
                
                // 사용자에게 알림
                const alertDiv = document.createElement('div');
                alertDiv.className = 'alert alert-info mb-20';
                alertDiv.innerHTML = '<strong>📱 자동 새로고침:</strong> 30초마다 환율이 자동으로 업데이트됩니다.';
                
                const container = document.querySelector('.content-container');
                const header = container.querySelector('.page-header');
                container.insertBefore(alertDiv, header.nextSibling);
                
                // 3초 후 알림 제거
                setTimeout(() => {
                    if (alertDiv.parentNode) {
                        alertDiv.parentNode.removeChild(alertDiv);
                    }
                }, 3000);
            }
        }

        // 페이지 로드 시 현재 시간 업데이트
        document.addEventListener('DOMContentLoaded', function() {
            // 실시간 시계 표시 (선택사항)
            function updateCurrentTime() {
                const now = new Date();
                const timeString = now.toLocaleString('ko-KR');
                
                // 현재 시간을 표시할 요소가 있다면 업데이트
                const timeElement = document.getElementById('currentTime');
                if (timeElement) {
                    timeElement.textContent = timeString;
                }
            }
            
            // 1초마다 시간 업데이트
            setInterval(updateCurrentTime, 1000);
        });
    </script>
</body>
</html> 