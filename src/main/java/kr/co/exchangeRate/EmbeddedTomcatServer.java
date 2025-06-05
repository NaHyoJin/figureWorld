package kr.co.exchangeRate;

import org.apache.catalina.Context;
import org.apache.catalina.LifecycleException;
import org.apache.catalina.startup.Tomcat;
import org.apache.tomcat.util.descriptor.web.FilterDef;
import org.apache.tomcat.util.descriptor.web.FilterMap;

import java.io.File;

/**
 * 임베디드 Tomcat 서버
 * Maven 설치 없이 바로 실행 가능한 웹 서버
 * 
 * @author 개발자
 * @since 2025.01.27
 */
public class EmbeddedTomcatServer {
    
    private static final String WEBAPP_DIR = "src/main/webapp/";
    private static final String CONTEXT_PATH = "";
    
    public static void main(String[] args) {
        int port = 8976;
        if (args.length > 0) {
            try {
                port = Integer.parseInt(args[0]);
            } catch (NumberFormatException e) {
                System.out.println("기본값 8976 포트를 사용합니다.");
            }
        }
        
        try {
            System.out.println("🚀 서버를 시작합니다... 포트: " + port);
            
            Tomcat tomcat = new Tomcat();
            tomcat.setPort(port);
            tomcat.getConnector();
            
            File webappDir = new File("src/main/webapp/");
            Context context = tomcat.addWebapp("", webappDir.getAbsolutePath());
            
            tomcat.start();
            
            System.out.println("✅ 서버 시작 완료!");
            System.out.println("🌐 접속: http://localhost:" + port + "/exchangeRates.do");
            
            tomcat.getServer().await();
            
        } catch (Exception e) {
            System.err.println("서버 시작 실패: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    /**
     * UTF-8 인코딩 필터 추가
     */
    private static void addCharacterEncodingFilter(Context context) {
        // 필터 정의
        FilterDef filterDef = new FilterDef();
        filterDef.setFilterName("CharacterEncodingFilter");
        filterDef.setFilterClass("org.springframework.web.filter.CharacterEncodingFilter");
        filterDef.addInitParameter("encoding", "UTF-8");
        filterDef.addInitParameter("forceEncoding", "true");
        
        // 필터 매핑
        FilterMap filterMap = new FilterMap();
        filterMap.setFilterName("CharacterEncodingFilter");
        filterMap.addURLPattern("/*");
        
        try {
            context.addFilterDef(filterDef);
            context.addFilterMap(filterMap);
        } catch (Exception e) {
            System.out.println("⚠️ 인코딩 필터 추가 실패 (Spring Framework 미포함): " + e.getMessage());
            System.out.println("기본 인코딩을 사용합니다.");
        }
    }
} 