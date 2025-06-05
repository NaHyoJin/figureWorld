package kr.co.exchangeRate.service;

import kr.co.exchangeRate.dao.ExchangeRateDAO;
import kr.co.exchangeRate.dao.ExchangeRateDAOImpl;
import kr.co.exchangeRate.vo.ExchangeRateVO;
import kr.co.exchangeRate.exception.ExchangeRateException;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Random;

/**
 * 환율 서비스 구현체
 * @author 개발자
 * @since 2025.01.27
 */
public class ExchangeRateServiceImpl implements ExchangeRateService {
    
    private ExchangeRateDAO exchangeRateDAO;
    private Random random;
    
    /**
     * 생성자
     */
    public ExchangeRateServiceImpl() {
        this.exchangeRateDAO = new ExchangeRateDAOImpl();
        this.random = new Random();
    }
    
    /**
     * 실시간 환율 정보 및 예측 정보를 조회
     */
    @Override
    public List<ExchangeRateVO> getRealTimeExchangeRates() throws ExchangeRateException {
        List<ExchangeRateVO> exchangeRateList = new ArrayList<>();
        
        try {
            // DAO를 통해 실시간 환율 조회
            Map<String, Double> rates = exchangeRateDAO.selectRealTimeExchangeRates();
            
            // USD 환율 처리
            Double usdToKrw = rates.get("KRW");
            if (usdToKrw != null) {
                ExchangeRateVO usdRate = createExchangeRateVO("USD", usdToKrw);
                usdRate.setCurrencyName("미국 달러 (USD)");
                usdRate.setFlagUrl("https://flagcdn.com/w40/us.png");
                exchangeRateList.add(usdRate);
            }
            
            // JPY 환율 처리 (100엔 기준)
            Double usdToJpy = rates.get("JPY");
            if (usdToKrw != null && usdToJpy != null) {
                double jpyToKrw = (usdToKrw / usdToJpy) * 100; // 100엔 기준
                ExchangeRateVO jpyRate = createExchangeRateVO("JPY", jpyToKrw);
                jpyRate.setCurrencyName("일본 엔 (JPY/100 KRW)");
                jpyRate.setFlagUrl("https://flagcdn.com/w40/jp.png");
                exchangeRateList.add(jpyRate);
            }
            
        } catch (Exception e) {
            throw new ExchangeRateException("환율 정보 처리 중 오류 발생", e);
        }
        
        return exchangeRateList;
    }
    
    /**
     * 특정 통화의 환율 정보를 조회
     */
    @Override
    public ExchangeRateVO getExchangeRateByCurrency(String currencyCode) throws ExchangeRateException {
        List<ExchangeRateVO> allRates = getRealTimeExchangeRates();
        
        for (ExchangeRateVO rate : allRates) {
            if (currencyCode.equals(rate.getCurrencyCode())) {
                return rate;
            }
        }
        
        throw new ExchangeRateException("통화 코드를 찾을 수 없습니다: " + currencyCode);
    }
    
    /**
     * 환율 예측 정보 생성 (Jules Beta 알고리즘 시뮬레이션)
     */
    @Override
    public double generatePredictedRate(double currentRate) {
        // 현재값 기준 ±2% 범위에서 예측값 생성
        double variation = (random.nextDouble() - 0.5) * 0.04; // -2% ~ +2%
        return currentRate * (1 + variation);
    }
    
    /**
     * ExchangeRateVO 객체 생성 및 포맷팅
     */
    private ExchangeRateVO createExchangeRateVO(String currencyCode, double currentRate) {
        double predictedRate = generatePredictedRate(currentRate);
        ExchangeRateVO vo = new ExchangeRateVO(currencyCode, currentRate, predictedRate);
        
        // 숫자 포맷팅
        DecimalFormat df;
        if ("USD".equals(currencyCode)) {
            df = new DecimalFormat("#,##0.00");
        } else {
            df = new DecimalFormat("#,##0.0");
        }
        
        vo.setFormattedCurrentRate(df.format(currentRate));
        vo.setFormattedPredictedRate(df.format(predictedRate));
        vo.setFormattedRateDifference(df.format(Math.abs(vo.getRateDifference())));
        
        return vo;
    }
} 