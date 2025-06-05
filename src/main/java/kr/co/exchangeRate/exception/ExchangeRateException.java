package kr.co.exchangeRate.exception;

/**
 * 환율 서비스 관련 예외 클래스
 * @author 개발자
 * @since 2025.01.27
 */
public class ExchangeRateException extends Exception {
    
    private static final long serialVersionUID = 1L;
    
    /**
     * 기본 생성자
     */
    public ExchangeRateException() {
        super();
    }
    
    /**
     * 메시지를 포함한 생성자
     * @param message 예외 메시지
     */
    public ExchangeRateException(String message) {
        super(message);
    }
    
    /**
     * 메시지와 원인을 포함한 생성자
     * @param message 예외 메시지
     * @param cause 원인 예외
     */
    public ExchangeRateException(String message, Throwable cause) {
        super(message, cause);
    }
    
    /**
     * 원인을 포함한 생성자
     * @param cause 원인 예외
     */
    public ExchangeRateException(Throwable cause) {
        super(cause);
    }
} 