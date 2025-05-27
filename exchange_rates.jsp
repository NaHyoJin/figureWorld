<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실시간 및 예측 환율</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f7f6;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 700px;
            text-align: center;
        }
        header h1 {
            color: #2c3e50;
            margin-bottom: 10px;
            font-size: 2em;
        }
        header p {
            color: #7f8c8d;
            font-size: 0.9em;
            margin-bottom: 30px;
        }
        .currency-section {
            margin-bottom: 30px;
            padding: 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            background-color: #f9f9f9;
        }
        .currency-section h2 {
            color: #3498db;
            margin-top: 0;
            margin-bottom: 15px;
            font-size: 1.5em;
            border-bottom: 2px solid #3498db;
            padding-bottom: 10px;
            display: inline-block;
        }
        .rate-info {
            display: flex;
            justify-content: space-around;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
        }
        .rate-info div {
            background-color: #ffffff;
            padding: 15px;
            border-radius: 6px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.07);
            margin: 10px;
            min-width: 200px;
            text-align: left;
        }
        .rate-info strong {
            color: #2980b9;
            font-size: 1.2em;
            display: block;
            margin-bottom: 5px;
        }
        .rate-info span {
            font-size: 1.4em;
            font-weight: bold;
            color: #2c3e50;
        }
        .rate-info .currency-unit {
            font-size: 0.8em;
            color: #7f8c8d;
            margin-left: 5px;
        }
        .comparison {
            margin-top: 20px;
            padding: 15px;
            background-color: #e8f6fd;
            border: 1px dashed #3498db;
            border-radius: 6px;
        }
        .comparison h3 {
            color: #2980b9;
            margin-top: 0;
            margin-bottom: 10px;
        }
        .comparison p {
            font-size: 1em;
            color: #333;
            line-height: 1.6;
        }
        .comparison .prediction-up {
            color: #27ae60; /* Green for upward trend */
            font-weight: bold;
        }
        .comparison .prediction-down {
            color: #c0392b; /* Red for downward trend */
            font-weight: bold;
        }
        .comparison .prediction-stable {
            color: #2c3e50; /* Neutral for stable */
            font-weight: bold;
        }
        .footer {
            margin-top: 30px;
            font-size: 0.8em;
            color: #95a5a6;
        }
        .last-updated {
            font-size: 0.8em;
            color: #7f8c8d;
            margin-bottom: 20px;
        }

        /* JSP Expression Language (EL) placeholders - will be replaced by server-side data */
        .data-placeholder {
            color: #e74c3c; /* Highlight placeholder data */
            font-style: italic;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>📈 실시간 환율 및 예측</h1>
            <p>Jules Beta를 활용한 미국 달러(USD) 및 일본 엔(JPY) 환율 정보</p>
        </header>

        <%--
            실제 데이터는 여기서 Java 코드 또는 EL을 통해 동적으로 설정됩니다.
            예:
            double currentUsdToKrw = 1370.50;
            double predictedUsdToKrw = 1380.00;
            String lastUpdatedTime = "2025-05-27 22:30:00";
        --%>

        <div class="last-updated">
            최근 업데이트: <span id="lastUpdateTime"><%-- <%= lastUpdatedTime %> 또는 ${lastUpdatedTime} --%>2025-05-27 22:30:00 (예시)</span>
        </div>

        <section class="currency-section">
            <h2><img src="https://flagcdn.com/w40/us.png" srcset="https://flagcdn.com/w80/us.png 2x" width="30" alt="USD"> 미국 달러 (USD)</h2>
            <div class="rate-info">
                <div>
                    <strong>현재 환율 (USD/KRW)</strong>
                    <span id="currentUsdRate"><%-- <%= currentUsdToKrw %> 또는 ${currentUsdRate} --%>1,375.50</span><span class="currency-unit">원</span>
                </div>
                <div>
                    <strong>미래 예측 환율 (Jules Beta)</strong>
                    <span id="predictedUsdRate"><%-- <%= predictedUsdToKrw %> 또는 ${predictedUsdRate} --%>1,385.00</span><span class="currency-unit">원</span>
                </div>
            </div>
            <div class="comparison">
                <h3>USD 환율 예측 요약</h3>
                <p id="usdComparisonText">
                    <%-- 여기에 JavaScript나 서버 사이드 로직으로 비교 결과 문장 생성 --%>
                    미래 예측 환율은 현재보다 <span class="prediction-up">상승</span>할 것으로 예상됩니다. (9.50원 <span class="prediction-up">▲</span>)
                </p>
            </div>
        </section>

        <section class="currency-section">
            <h2><img src="https://flagcdn.com/w40/jp.png" srcset="https://flagcdn.com/w80/jp.png 2x" width="30" alt="JPY"> 일본 엔 (JPY/100 KRW)</h2>
            <div class="rate-info">
                <div>
                    <strong>현재 환율 (JPY/100 KRW)</strong>
                    <span id="currentJpyRate"><%-- <%= currentJpyToKrw %> 또는 ${currentJpyRate} --%>875.20</span><span class="currency-unit">원</span>
                </div>
                <div>
                    <strong>미래 예측 환율 (Jules Beta)</strong>
                    <span id="predictedJpyRate"><%-- <%= predictedJpyToKrw %> 또는 ${predictedJpyRate} --%>870.00</span><span class="currency-unit">원</span>
                </div>
            </div>
            <div class="comparison">
                <h3>JPY 환율 예측 요약</h3>
                <p id="jpyComparisonText">
                    <%-- 여기에 JavaScript나 서버 사이드 로직으로 비교 결과 문장 생성 --%>
                    미래 예측 환율은 현재보다 <span class="prediction-down">하락</span>할 것으로 예상됩니다. (5.20원 <span class="prediction-down">▼</span>)
                </p>
            </div>
        </section>

        <footer class="footer">
            <p>&copy; <%= new java.util.GregorianCalendar().get(java.util.Calendar.YEAR) %> 환율 정보 서비스. 모든 권리 보유.</p>
            <p>환율 정보는 참고용이며, 실제 거래 시에는 해당 금융기관의 고시 환율을 확인하시기 바랍니다.</p>
            <p>예측 정보는 Jules Beta의 분석에 기반하며, 투자 결정에 대한 책임은 본인에게 있습니다.</p>
        </footer>
    </div>

    <%--
    <script>
        // 나중에 JavaScript를 사용하여 동적으로 데이터를 업데이트하거나 UI를 조작할 수 있습니다.
        // 예를 들어, AJAX를 사용하여 주기적으로 환율을 가져오고, 예측 변화를 시각적으로 표시할 수 있습니다.

        // 예시: 데이터 업데이트 함수 (실제로는 서버에서 데이터를 받아와야 함)
        function updateRates(data) {
            document.getElementById('lastUpdateTime').textContent = data.lastUpdated;

            document.getElementById('currentUsdRate').textContent = data.usd.current.toFixed(2);
            document.getElementById('predictedUsdRate').textContent = data.usd.predicted.toFixed(2);
            updateComparisonText('usd', data.usd.current, data.usd.predicted);

            document.getElementById('currentJpyRate').textContent = data.jpy.current.toFixed(2);
            document.getElementById('predictedJpyRate').textContent = data.jpy.predicted.toFixed(2);
            updateComparisonText('jpy', data.jpy.current, data.jpy.predicted);
        }

        function updateComparisonText(currency, current, predicted) {
            const difference = predicted - current;
            const absDifference = Math.abs(difference).toFixed(2);
            let text = '';
            let comparisonElementId = currency + 'ComparisonText';
            let comparisonElement = document.getElementById(comparisonElementId);

            if (difference > 0) {
                text = `미래 예측 환율은 현재보다 <span class="prediction-up">상승</span>할 것으로 예상됩니다. (${absDifference}원 <span class="prediction-up">▲</span>)`;
            } else if (difference < 0) {
                text = `미래 예측 환율은 현재보다 <span class="prediction-down">하락</span>할 것으로 예상됩니다. (${absDifference}원 <span class="prediction-down">▼</span>)`;
            } else {
                text = `미래 예측 환율은 현재와 <span class="prediction-stable">동일</span>할 것으로 예상됩니다.`;
            }
            comparisonElement.innerHTML = text;
        }

        // 페이지 로드 시 또는 주기적으로 호출될 수 있음
        // 예시 데이터 (실제로는 API 호출 등을 통해 받아옴)
        /*
        const sampleData = {
            lastUpdated: new Date().toLocaleString(),
            usd: { current: 1375.50, predicted: 1385.00 },
            jpy: { current: 875.20, predicted: 870.00 } // 100엔 기준
        };
        updateRates(sampleData);

        // 30초마다 업데이트 (예시)
        // setInterval(() => {
        //     // fetchNewData().then(newData => updateRates(newData));
        //     console.log("Updating rates..."); // 실제로는 API 호출
        //     // 임시로 sampleData를 약간 변형해서 업데이트하는 척
        //     sampleData.usd.current += (Math.random() - 0.5) * 2;
        //     sampleData.usd.predicted += (Math.random() - 0.5) * 3;
        //     sampleData.jpy.current += (Math.random() - 0.5);
        //     sampleData.jpy.predicted += (Math.random() - 0.5) * 1.5;
        //     sampleData.lastUpdated = new Date().toLocaleString();
        //     updateRates(sampleData);
        // }, 30000);
        */
    </script>
    --%>
</body>
</html>