package kr.co.exchangeRate.vo;

import java.io.Serializable;
import java.util.Date;

/**
 * 환율 정보 Value Object
 * @author 개발자
 * @since 2025.01.27
 */
public class ExchangeRateVO implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    /** 통화 코드 (USD, JPY 등) */
    private String currencyCode;
    
    /** 현재 환율 */
    private double currentRate;
    
    /** 예측 환율 */
    private double predictedRate;
    
    /** 환율 차이 */
    private double rateDifference;
    
    /** 트렌드 (UP, DOWN, STABLE) */
    private String trend;
    
    /** 트렌드 CSS 클래스 */
    private String trendClass;
    
    /** 트렌드 심볼 */
    private String trendSymbol;
    
    /** 통화명 */
    private String currencyName;
    
    /** 국가 플래그 URL */
    private String flagUrl;
    
    /** 업데이트 시간 */
    private Date updateTime;
    
    /** 포맷된 현재 환율 */
    private String formattedCurrentRate;
    
    /** 포맷된 예측 환율 */
    private String formattedPredictedRate;
    
    /** 포맷된 환율 차이 */
    private String formattedRateDifference;
    
    /**
     * 기본 생성자
     */
    public ExchangeRateVO() {}
    
    /**
     * 생성자
     */
    public ExchangeRateVO(String currencyCode, double currentRate, double predictedRate) {
        this.currencyCode = currencyCode;
        this.currentRate = currentRate;
        this.predictedRate = predictedRate;
        this.rateDifference = predictedRate - currentRate;
        this.updateTime = new Date();
        
        // 트렌드 계산
        calculateTrend();
    }
    
    /**
     * 트렌드 계산 및 설정
     */
    private void calculateTrend() {
        if (rateDifference > 0) {
            this.trend = "상승";
            this.trendClass = "prediction-up";
            this.trendSymbol = "▲";
        } else if (rateDifference < 0) {
            this.trend = "하락";
            this.trendClass = "prediction-down";
            this.trendSymbol = "▼";
        } else {
            this.trend = "동일";
            this.trendClass = "prediction-stable";
            this.trendSymbol = "■";
        }
    }
    
    // Getter & Setter
    public String getCurrencyCode() {
        return currencyCode;
    }
    
    public void setCurrencyCode(String currencyCode) {
        this.currencyCode = currencyCode;
    }
    
    public double getCurrentRate() {
        return currentRate;
    }
    
    public void setCurrentRate(double currentRate) {
        this.currentRate = currentRate;
        this.rateDifference = this.predictedRate - currentRate;
        calculateTrend();
    }
    
    public double getPredictedRate() {
        return predictedRate;
    }
    
    public void setPredictedRate(double predictedRate) {
        this.predictedRate = predictedRate;
        this.rateDifference = predictedRate - this.currentRate;
        calculateTrend();
    }
    
    public double getRateDifference() {
        return rateDifference;
    }
    
    public void setRateDifference(double rateDifference) {
        this.rateDifference = rateDifference;
    }
    
    public String getTrend() {
        return trend;
    }
    
    public void setTrend(String trend) {
        this.trend = trend;
    }
    
    public String getTrendClass() {
        return trendClass;
    }
    
    public void setTrendClass(String trendClass) {
        this.trendClass = trendClass;
    }
    
    public String getTrendSymbol() {
        return trendSymbol;
    }
    
    public void setTrendSymbol(String trendSymbol) {
        this.trendSymbol = trendSymbol;
    }
    
    public String getCurrencyName() {
        return currencyName;
    }
    
    public void setCurrencyName(String currencyName) {
        this.currencyName = currencyName;
    }
    
    public String getFlagUrl() {
        return flagUrl;
    }
    
    public void setFlagUrl(String flagUrl) {
        this.flagUrl = flagUrl;
    }
    
    public Date getUpdateTime() {
        return updateTime;
    }
    
    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
    
    public String getFormattedCurrentRate() {
        return formattedCurrentRate;
    }
    
    public void setFormattedCurrentRate(String formattedCurrentRate) {
        this.formattedCurrentRate = formattedCurrentRate;
    }
    
    public String getFormattedPredictedRate() {
        return formattedPredictedRate;
    }
    
    public void setFormattedPredictedRate(String formattedPredictedRate) {
        this.formattedPredictedRate = formattedPredictedRate;
    }
    
    public String getFormattedRateDifference() {
        return formattedRateDifference;
    }
    
    public void setFormattedRateDifference(String formattedRateDifference) {
        this.formattedRateDifference = formattedRateDifference;
    }
    
    @Override
    public String toString() {
        return "ExchangeRateVO{" +
                "currencyCode='" + currencyCode + '\'' +
                ", currentRate=" + currentRate +
                ", predictedRate=" + predictedRate +
                ", rateDifference=" + rateDifference +
                ", trend='" + trend + '\'' +
                ", updateTime=" + updateTime +
                '}';
    }
} 