package kr.co.exchangeRate.controller;

import kr.co.exchangeRate.service.ExchangeRateService;
import kr.co.exchangeRate.service.ExchangeRateServiceImpl;
import kr.co.exchangeRate.vo.ExchangeRateVO;
import kr.co.exchangeRate.exception.ExchangeRateException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 환율 정보 컨트롤러
 * @author 개발자
 * @since 2025.01.27
 */
public class ExchangeRateController extends HttpServlet {
    
    private static final long serialVersionUID = 1L;
    
    private ExchangeRateService exchangeRateService;
    
    /**
     * 서블릿 초기화
     */
    @Override
    public void init() throws ServletException {
        super.init();
        this.exchangeRateService = new ExchangeRateServiceImpl();
    }
    
    /**
     * GET 요청 처리
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 한글 인코딩 설정
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        
        try {
            // 서비스에서 환율 정보 조회
            List<ExchangeRateVO> exchangeRateList = exchangeRateService.getRealTimeExchangeRates();
            
            // 성공 시 데이터 설정
            request.setAttribute("exchangeRateList", exchangeRateList);
            request.setAttribute("apiSuccess", true);
            request.setAttribute("errorMessage", "");
            
            // 업데이트 시간 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            request.setAttribute("lastUpdatedTime", sdf.format(new Date()));
            
        } catch (ExchangeRateException e) {
            // 실패 시 기본값 설정
            request.setAttribute("exchangeRateList", getDefaultExchangeRates());
            request.setAttribute("apiSuccess", false);
            request.setAttribute("errorMessage", e.getMessage());
            
            // 오류 시간 설정
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            request.setAttribute("lastUpdatedTime", sdf.format(new Date()) + " (오류)");
        }
        
        // JSP로 포워딩
        request.getRequestDispatcher("/WEB-INF/views/exchangeRates.jsp").forward(request, response);
    }
    
    /**
     * POST 요청 처리 (GET과 동일하게 처리)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
    
    /**
     * API 실패 시 사용할 기본값 생성
     */
    private List<ExchangeRateVO> getDefaultExchangeRates() {
        List<ExchangeRateVO> defaultRates = new ArrayList<>();
        
        // USD 기본값
        ExchangeRateVO usdRate = new ExchangeRateVO("USD", 1375.50, 1385.00);
        usdRate.setCurrencyName("미국 달러 (USD)");
        usdRate.setFlagUrl("https://flagcdn.com/w40/us.png");
        usdRate.setFormattedCurrentRate("1,375.50");
        usdRate.setFormattedPredictedRate("1,385.00");
        usdRate.setFormattedRateDifference("9.50");
        defaultRates.add(usdRate);
        
        // JPY 기본값
        ExchangeRateVO jpyRate = new ExchangeRateVO("JPY", 875.2, 870.0);
        jpyRate.setCurrencyName("일본 엔 (JPY/100 KRW)");
        jpyRate.setFlagUrl("https://flagcdn.com/w40/jp.png");
        jpyRate.setFormattedCurrentRate("875.2");
        jpyRate.setFormattedPredictedRate("870.0");
        jpyRate.setFormattedRateDifference("5.2");
        defaultRates.add(jpyRate);
        
        return defaultRates;
    }
} 