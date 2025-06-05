package kr.co.exchangeRate.dao;

import kr.co.exchangeRate.exception.ExchangeRateException;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Logger;
import java.util.logging.Level;

/**
 * 환율 데이터 접근 구현체
 * @author 개발자
 * @since 2025.01.27
 */
public class ExchangeRateDAOImpl implements ExchangeRateDAO {
    
    private static final Logger logger = Logger.getLogger(ExchangeRateDAOImpl.class.getName());
    
    /** API 기본 URL */
    private static final String API_BASE_URL = "https://api.exchangerate-api.com/v4/latest/USD";
    
    /** 연결 타임아웃 (밀리초) */
    private static final int CONNECT_TIMEOUT = 5000;
    
    /** 읽기 타임아웃 (밀리초) */
    private static final int READ_TIMEOUT = 5000;
    
    /**
     * 외부 API로부터 실시간 환율 정보를 조회
     */
    @Override
    public Map<String, Double> selectRealTimeExchangeRates() throws ExchangeRateException {
        Map<String, Double> exchangeRates = new HashMap<>();
        HttpURLConnection conn = null;
        BufferedReader reader = null;
        
        try {
            logger.info("실시간 환율 정보 조회 시작");
            
            // API 연결 설정
            URL url = new URL(API_BASE_URL);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setConnectTimeout(CONNECT_TIMEOUT);
            conn.setReadTimeout(READ_TIMEOUT);
            conn.setRequestProperty("User-Agent", "ExchangeRate-Service/1.0");
            
            int responseCode = conn.getResponseCode();
            logger.info("API 응답 코드: " + responseCode);
            
            if (responseCode == HttpURLConnection.HTTP_OK) {
                reader = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
                StringBuilder response = new StringBuilder();
                String line;
                
                while ((line = reader.readLine()) != null) {
                    response.append(line);
                }
                
                String jsonResponse = response.toString();
                logger.info("API 응답 수신 완료");
                
                // JSON 파싱 (간단한 문자열 파싱 방식)
                exchangeRates = parseExchangeRatesFromJson(jsonResponse);
                
                logger.info("환율 정보 파싱 완료: " + exchangeRates.size() + "개 통화");
                
            } else {
                throw new ExchangeRateException("API 호출 실패. 응답 코드: " + responseCode);
            }
            
        } catch (Exception e) {
            logger.log(Level.SEVERE, "환율 정보 조회 중 오류 발생", e);
            throw new ExchangeRateException("환율 정보 조회 실패: " + e.getMessage(), e);
        } finally {
            // 리소스 정리
            if (reader != null) {
                try {
                    reader.close();
                } catch (Exception e) {
                    logger.log(Level.WARNING, "Reader 닫기 실패", e);
                }
            }
            if (conn != null) {
                conn.disconnect();
            }
        }
        
        return exchangeRates;
    }
    
    /**
     * 특정 통화의 환율 정보를 조회
     */
    @Override
    public Double selectExchangeRateByCurrency(String currencyCode) throws ExchangeRateException {
        Map<String, Double> allRates = selectRealTimeExchangeRates();
        Double rate = allRates.get(currencyCode);
        
        if (rate == null) {
            throw new ExchangeRateException("통화 코드를 찾을 수 없습니다: " + currencyCode);
        }
        
        return rate;
    }
    
    /**
     * JSON 응답에서 환율 정보를 파싱
     * @param jsonResponse JSON 응답 문자열
     * @return 통화코드를 키로 하는 환율 정보 Map
     */
    private Map<String, Double> parseExchangeRatesFromJson(String jsonResponse) {
        Map<String, Double> rates = new HashMap<>();
        
        try {
            // "rates" 객체 부분 추출
            String ratesStart = "\"rates\":{";
            int startIndex = jsonResponse.indexOf(ratesStart);
            if (startIndex == -1) {
                logger.warning("JSON에서 rates 객체를 찾을 수 없습니다");
                return rates;
            }
            
            startIndex += ratesStart.length();
            int endIndex = jsonResponse.indexOf("}", startIndex);
            if (endIndex == -1) {
                logger.warning("JSON rates 객체의 끝을 찾을 수 없습니다");
                return rates;
            }
            
            String ratesJson = jsonResponse.substring(startIndex, endIndex);
            
            // 각 통화별 환율 파싱
            String[] currencyPairs = ratesJson.split(",");
            for (String pair : currencyPairs) {
                String[] keyValue = pair.split(":");
                if (keyValue.length == 2) {
                    String currency = keyValue[0].trim().replace("\"", "");
                    String rateStr = keyValue[1].trim();
                    
                    try {
                        Double rate = Double.parseDouble(rateStr);
                        rates.put(currency, rate);
                    } catch (NumberFormatException e) {
                        logger.warning("환율 파싱 실패 - 통화: " + currency + ", 값: " + rateStr);
                    }
                }
            }
            
        } catch (Exception e) {
            logger.log(Level.WARNING, "JSON 파싱 중 오류 발생", e);
        }
        
        return rates;
    }
} 