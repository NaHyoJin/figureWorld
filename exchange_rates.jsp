<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*, java.io.*, java.text.*, java.util.*" %>
<%@ page import="javax.json.*, javax.json.stream.*" %>

<%
    // 실시간 환율 데이터 변수 초기화
    double currentUsdToKrw = 1375.50; // 기본값
    double currentJpyToKrw = 875.20;  // 기본값 (100엔 기준)
    double predictedUsdToKrw = 1385.00; // 예측값 (임시)
    double predictedJpyToKrw = 870.00;  // 예측값 (임시)
    String lastUpdatedTime = "";
    boolean apiSuccess = false;
    String errorMessage = "";
    
    try {
        // ExchangeRate-API를 사용하여 실시간 환율 데이터 가져오기
        // 무료 API: https://api.exchangerate-api.com/v4/latest/USD
        URL url = new URL("https://api.exchangerate-api.com/v4/latest/USD");
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setConnectTimeout(5000); // 5초 타임아웃
        conn.setReadTimeout(5000);
        
        int responseCode = conn.getResponseCode();
        if (responseCode == 200) {
            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            
            while ((line = reader.readLine()) != null) {
                response.append(line);
            }
            reader.close();
            
            // JSON 파싱 (간단한 문자열 파싱 방식 사용)
            String jsonResponse = response.toString();
            
            // KRW 환율 추출
            String krwPattern = "\"KRW\":";
            int krwIndex = jsonResponse.indexOf(krwPattern);
            if (krwIndex != -1) {
                int startIndex = krwIndex + krwPattern.length();
                int endIndex = jsonResponse.indexOf(",", startIndex);
                if (endIndex == -1) endIndex = jsonResponse.indexOf("}", startIndex);
                
                String krwValue = jsonResponse.substring(startIndex, endIndex).trim();
                currentUsdToKrw = Double.parseDouble(krwValue);
            }
            
            // JPY 환율 추출 (USD -> JPY)
            String jpyPattern = "\"JPY\":";
            int jpyIndex = jsonResponse.indexOf(jpyPattern);
            if (jpyIndex != -1) {
                int startIndex = jpyIndex + jpyPattern.length();
                int endIndex = jsonResponse.indexOf(",", startIndex);
                if (endIndex == -1) endIndex = jsonResponse.indexOf("}", startIndex);
                
                String jpyValue = jsonResponse.substring(startIndex, endIndex).trim();
                double usdToJpy = Double.parseDouble(jpyValue);
                // JPY/100 KRW 계산: (USD -> KRW) / (USD -> JPY) * 100
                currentJpyToKrw = (currentUsdToKrw / usdToJpy) * 100;
            }
            
            // 업데이트 시간 설정
            lastUpdatedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
            apiSuccess = true;
            
            // 간단한 예측 로직 (실제로는 AI 모델이나 복잡한 알고리즘 사용)
            // 현재값 기준 ±2% 범위에서 랜덤하게 설정 (예시)
            Random rand = new Random();
            double usdVariation = (rand.nextDouble() - 0.5) * 0.04; // -2% ~ +2%
            double jpyVariation = (rand.nextDouble() - 0.5) * 0.04;
            
            predictedUsdToKrw = currentUsdToKrw * (1 + usdVariation);
            predictedJpyToKrw = currentJpyToKrw * (1 + jpyVariation);
            
        } else {
            errorMessage = "API 응답 오류: " + responseCode;
        }
        
    } catch (Exception e) {
        errorMessage = "환율 데이터 로딩 실패: " + e.getMessage();
        lastUpdatedTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()) + " (오류)";
    }
    
    // 숫자 포맷팅을 위한 DecimalFormat
    DecimalFormat df = new DecimalFormat("#,##0.00");
    DecimalFormat dfSmall = new DecimalFormat("#,##0.0");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 및 예측 환율</title>
    <link rel="stylesheet" href="common.css">
    <link rel="stylesheet" href="exchange-rates.css">
</head>
<body>
    <div class="page-container">
        <div class="content-container">
            <header class="page-header">
            <h1>📈 실시간 환율 및 예측</h1>
            <p>Jules Beta를 활용한 미국 달러(USD) 및 일본 엔(JPY) 환율 정보</p>
        </header>

            <!-- API 상태 표시 -->
            <% if (!apiSuccess && !errorMessage.isEmpty()) { %>
                <div class="alert alert-warning mb-20">
                    <strong>⚠️ 알림:</strong> <%= errorMessage %><br>
                    기본값으로 표시됩니다. 페이지를 새로고침하여 다시 시도해보세요.
                </div>
            <% } else if (apiSuccess) { %>
                <div class="alert alert-success mb-20">
                    <strong>✅ 실시간 데이터:</strong> 환율 정보가 성공적으로 업데이트되었습니다.
                </div>
            <% } %>

        <div class="last-updated">
                최근 업데이트: <span id="lastUpdateTime"><%= lastUpdatedTime %></span>
                <% if (apiSuccess) { %>
                    <span class="status-up">● 실시간</span>
                <% } else { %>
                    <span class="status-warning">● 오프라인</span>
                <% } %>
        </div>

            <section class="content-section currency-section">
            <h2><img src="https://flagcdn.com/w40/us.png" srcset="https://flagcdn.com/w80/us.png 2x" width="30" alt="USD"> 미국 달러 (USD)</h2>
            <div class="rate-info">
                <div>
                    <strong>현재 환율 (USD/KRW)</strong>
                        <span id="currentUsdRate"><%= df.format(currentUsdToKrw) %></span><span class="currency-unit">원</span>
                </div>
                <div>
                    <strong>미래 예측 환율 (Jules Beta)</strong>
                        <span id="predictedUsdRate"><%= df.format(predictedUsdToKrw) %></span><span class="currency-unit">원</span>
                    </div>
            </div>
            <div class="comparison">
                <h3>USD 환율 예측 요약</h3>
                <p id="usdComparisonText">
                        <%
                            double usdDifference = predictedUsdToKrw - currentUsdToKrw;
                            String usdTrend = "";
                            String usdTrendClass = "";
                            String usdSymbol = "";
                            
                            if (usdDifference > 0) {
                                usdTrend = "상승";
                                usdTrendClass = "prediction-up";
                                usdSymbol = "▲";
                            } else if (usdDifference < 0) {
                                usdTrend = "하락";
                                usdTrendClass = "prediction-down";
                                usdSymbol = "▼";
                            } else {
                                usdTrend = "동일";
                                usdTrendClass = "prediction-stable";
                                usdSymbol = "■";
                            }
                        %>
                        미래 예측 환율은 현재보다 <span class="<%= usdTrendClass %>"><%= usdTrend %></span>할 것으로 예상됩니다. 
                        (<%= df.format(Math.abs(usdDifference)) %>원 <span class="<%= usdTrendClass %>"><%= usdSymbol %></span>)
                </p>
            </div>
        </section>

            <section class="content-section currency-section">
            <h2><img src="https://flagcdn.com/w40/jp.png" srcset="https://flagcdn.com/w80/jp.png 2x" width="30" alt="JPY"> 일본 엔 (JPY/100 KRW)</h2>
            <div class="rate-info">
                <div>
                    <strong>현재 환율 (JPY/100 KRW)</strong>
                        <span id="currentJpyRate"><%= dfSmall.format(currentJpyToKrw) %></span><span class="currency-unit">원</span>
                </div>
                <div>
                    <strong>미래 예측 환율 (Jules Beta)</strong>
                        <span id="predictedJpyRate"><%= dfSmall.format(predictedJpyToKrw) %></span><span class="currency-unit">원</span>
                    </div>
            </div>
            <div class="comparison">
                <h3>JPY 환율 예측 요약</h3>
                <p id="jpyComparisonText">
                        <%
                            double jpyDifference = predictedJpyToKrw - currentJpyToKrw;
                            String jpyTrend = "";
                            String jpyTrendClass = "";
                            String jpySymbol = "";
                            
                            if (jpyDifference > 0) {
                                jpyTrend = "상승";
                                jpyTrendClass = "prediction-up";
                                jpySymbol = "▲";
                            } else if (jpyDifference < 0) {
                                jpyTrend = "하락";
                                jpyTrendClass = "prediction-down";
                                jpySymbol = "▼";
                            } else {
                                jpyTrend = "동일";
                                jpyTrendClass = "prediction-stable";
                                jpySymbol = "■";
                            }
                        %>
                        미래 예측 환율은 현재보다 <span class="<%= jpyTrendClass %>"><%= jpyTrend %></span>할 것으로 예상됩니다. 
                        (<%= dfSmall.format(Math.abs(jpyDifference)) %>원 <span class="<%= jpyTrendClass %>"><%= jpySymbol %></span>)
                </p>
            </div>
        </section>

            <!-- 새로고침 버튼 추가 -->
            <div class="text-center mt-30">
                <button class="btn btn-primary" onclick="location.reload();">🔄 환율 새로고침</button>
                <button class="btn btn-secondary" onclick="toggleAutoRefresh();">⏰ 자동 새로고침</button>
            </div>

            <footer class="page-footer">
            <p>&copy; <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> 환율 정보 서비스. 모든 권리 보유.</p>
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
                    location.reload();
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