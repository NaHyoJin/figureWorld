package kr.co.exchangeRate.service;

import kr.co.exchangeRate.vo.ExchangeRateVO;
import kr.co.exchangeRate.exception.ExchangeRateException;
import java.util.List;

/**
 * 환율 서비스 인터페이스
 * @author 개발자
 * @since 2025.01.27
 */
public interface ExchangeRateService {
    
    /**
     * 실시간 환율 정보 및 예측 정보를 조회
     * @return 환율 정보 리스트 (USD, JPY)
     * @throws ExchangeRateException 서비스 처리 실패 시
     */
    List<ExchangeRateVO> getRealTimeExchangeRates() throws ExchangeRateException;
    
    /**
     * 특정 통화의 환율 정보를 조회
     * @param currencyCode 통화 코드
     * @return 환율 정보 객체
     * @throws ExchangeRateException 서비스 처리 실패 시
     */
    ExchangeRateVO getExchangeRateByCurrency(String currencyCode) throws ExchangeRateException;
    
    /**
     * 환율 예측 정보 생성
     * @param currentRate 현재 환율
     * @return 예측 환율
     */
    double generatePredictedRate(double currentRate);
} 