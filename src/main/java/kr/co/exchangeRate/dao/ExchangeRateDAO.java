package kr.co.exchangeRate.dao;

import kr.co.exchangeRate.exception.ExchangeRateException;
import java.util.Map;

/**
 * 환율 데이터 접근 인터페이스
 * @author 개발자
 * @since 2025.01.27
 */
public interface ExchangeRateDAO {
    
    /**
     * 외부 API로부터 실시간 환율 정보를 조회
     * @return 통화코드를 키로 하는 환율 정보 Map
     * @throws ExchangeRateException API 호출 실패 시
     */
    Map<String, Double> selectRealTimeExchangeRates() throws ExchangeRateException;
    
    /**
     * 특정 통화의 환율 정보를 조회
     * @param currencyCode 통화 코드 (USD, JPY 등)
     * @return 해당 통화의 환율
     * @throws ExchangeRateException API 호출 실패 시
     */
    Double selectExchangeRateByCurrency(String currencyCode) throws ExchangeRateException;
} 