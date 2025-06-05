# 📈 실시간 환율 정보 시스템

Jules Beta를 활용한 미국 달러(USD) 및 일본 엔(JPY) 실시간 환율 정보 제공 시스템

## 🚀 **Git에서 바로 실행 (설치 불필요!)**

### **1. 레포지토리 클론**
```bash
git clone <repository-url>
cd exchange-rate-system
```

### **2. 바로 실행 (Windows)**

#### **Option A: 빠른 시작 (권장) ⚡**
```cmd
quick-start.cmd
```
- ✅ **아무것도 설치 불필요** (Java만 있으면 OK)
- ✅ 필요한 라이브러리 자동 다운로드
- ✅ 자동 컴파일 및 실행
- ✅ 최초 실행 후 빠른 재실행

#### **Option B: Maven 사용**
```cmd
run.cmd
```
- ⚠️ Maven 설치 필요
- ⚠️ 수동 설정 필요

### **3. 수동 실행**
```cmd
# Maven 사용 (Maven 설치 필요)
mvn clean compile exec:exec

# 또는 IDE에서 실행
# kr.co.exchangeRate.EmbeddedTomcatServer 클래스를 직접 실행
```

### **4. 브라우저 접속**
```
http://localhost:8976/exchangeRates.do
```

---

## 📦 **필요한 것**
- ✅ **Java 8 이상** (JDK 또는 JRE)
- ❌ Maven 설치 불필요 (Maven Wrapper 포함)
- ❌ Tomcat 설치 불필요 (임베디드 Tomcat 사용)
- ❌ IDE 설치 불필요

## 🎯 **주요 특징**

### ✅ **완전 포터블**
- Git 클론 후 바로 실행 가능
- 별도 설치 프로그램 불필요
- 회사/집 어디서든 동일한 환경

### ✅ **실시간 환율 데이터**
- **ExchangeRate-API**를 통한 실시간 USD/KRW, JPY/KRW 환율 조회
- 5초 타임아웃으로 안정적인 API 호출
- API 오류 시 기본값으로 fallback 처리

### ✅ **환율 예측 (Jules Beta)**
- 현재 환율 기준 ±2% 범위 내 예측값 생성
- 상승/하락/안정 트렌드 시각적 표시
- 예측 차이값 및 방향성 자동 계산

### ✅ **전자정부프레임워크 스타일 MVC**
- Controller-Service-DAO 패턴
- JSP에서 Java 코드 완전 분리 (JSTL/EL만 사용)
- 인터페이스 기반 설계

## 📁 **프로젝트 구조**

```
📦 exchange-rate-system
├── 🏃 run.cmd                                   # 원클릭 실행 스크립트
├── 🏃 mvnw.cmd                                  # Maven Wrapper (Windows)
├── 📄 pom.xml                                   # Maven 설정
├── 📁 src/main/java/kr/co/exchangeRate/
│   ├── 📄 EmbeddedTomcatServer.java             # 임베디드 서버
│   ├── 📁 controller/
│   │   └── 📄 ExchangeRateController.java       # 서블릿 컨트롤러
│   ├── 📁 service/
│   │   ├── 📄 ExchangeRateService.java          # 서비스 인터페이스
│   │   └── 📄 ExchangeRateServiceImpl.java      # 서비스 구현체
│   ├── 📁 dao/
│   │   ├── 📄 ExchangeRateDAO.java              # DAO 인터페이스
│   │   └── 📄 ExchangeRateDAOImpl.java          # DAO 구현체
│   ├── 📁 vo/
│   │   └── 📄 ExchangeRateVO.java               # Value Object
│   └── 📁 exception/
│       └── 📄 ExchangeRateException.java        # 커스텀 예외
├── 📁 src/main/webapp/
│   ├── 📁 WEB-INF/
│   │   ├── 📄 web.xml                           # 서블릿 설정
│   │   └── 📁 views/
│   │       └── 📄 exchangeRates.jsp             # 뷰 (JSTL/EL만 사용)
│   ├── 📄 common.css                            # 공통 스타일
│   └── 📄 exchange-rates.css                    # 환율 전용 스타일
└── 📄 README.md                                 # 이 파일
```

## 🛠 **기술 스택**

- **Backend**: Java 1.8, JSP, Servlet
- **Frontend**: HTML5, CSS3, JavaScript, JSTL/EL
- **Server**: Embedded Tomcat 9
- **Build**: Maven Wrapper (mvnw)
- **API**: ExchangeRate-API (무료)

## 🔧 **고급 사용법**

### **포트 변경**
```cmd
# 다른 포트로 실행 (예: 9090)
mvnw.cmd clean compile
java -cp target/classes;target/dependency/* kr.co.exchangeRate.EmbeddedTomcatServer 9090
```

### **개발 모드**
```cmd
# 자동 재컴파일 (코드 변경 시)
mvnw.cmd compile exec:exec
```

### **WAR 배포용 패키징**
```cmd
mvnw.cmd clean package
# target/exchange-rate-system.war 생성
```

## 📊 **환율 데이터**

### **USD/KRW (미국 달러)**
- **현재 환율**: API에서 실시간 조회
- **예측 환율**: 현재값 ±2% 범위 예측
- **표시 형식**: #,##0.00 (소수점 2자리)

### **JPY/100 KRW (일본 엔화)**
- **현재 환율**: USD→JPY 환율을 통한 간접 계산
- **예측 환율**: 현재값 ±2% 범위 예측  
- **표시 형식**: #,##0.0 (소수점 1자리)

## 🎨 **화면 기능**

### **🔄 자동 새로고침** 
- 수동 새로고침 버튼
- 30초 주기 자동 새로고침 토글 기능
- 실시간 데이터 상태 표시

### **📱 반응형 디자인**
- 모바일/데스크톱 호환 레이아웃
- 공통 스타일 시스템
- 접근성 고려 UI

## 🔍 **트러블슈팅**

### **"Java 명령을 찾을 수 없습니다"**
- Java 8 이상 설치 필요
- JAVA_HOME 환경변수 설정
- PATH에 Java bin 디렉토리 추가

### **"포트가 이미 사용 중입니다"**
```cmd
# 다른 포트로 실행
java -cp target/classes;target/dependency/* kr.co.exchangeRate.EmbeddedTomcatServer 9090
```

### **"웹앱 디렉토리를 찾을 수 없습니다"**
- 프로젝트 루트 디렉토리에서 실행하고 있는지 확인
- `src/main/webapp/` 디렉토리가 존재하는지 확인

### **API 호출 실패**
- 인터넷 연결 확인
- 방화벽/프록시 설정 확인
- 기본값으로 동작하므로 기능은 정상 작동

## 📋 **개발 확장 가이드**

### **새 페이지 추가**
1. `page-template.jsp` 복사
2. 새 컨트롤러 서블릿 생성
3. Service/DAO 레이어 구현
4. `web.xml`에 서블릿 매핑 추가

### **새 통화 추가**
1. `ExchangeRateServiceImpl.java`에서 통화 추가
2. JSP에서 표시 로직 수정
3. CSS 스타일 조정

## 🚢 **배포**

### **운영 서버 배포**
```cmd
# WAR 파일 생성
mvnw.cmd clean package

# Tomcat에 배포
copy target\exchange-rate-system.war %TOMCAT_HOME%\webapps\
```

### **Docker 컨테이너**
```dockerfile
FROM openjdk:8-jre
COPY target/exchange-rate-system.war app.war
EXPOSE 8976
CMD ["java", "-jar", "app.war"]
```

---

## 🎉 **시작하기**

1. **Git 클론**
2. **`run.cmd` 실행**
3. **브라우저에서 `http://localhost:8976/exchangeRates.do` 접속**

그게 전부입니다! 🚀

---

## 🚨 **현재 상태 및 해결 방법 (2025.01.27)**

### **⚠️ 알려진 문제**
1. **인코딩 문제**: MS949 vs UTF-8 충돌로 컴파일 실패
2. **서블릿 API 호환성**: getHttpServletMapping() 메서드 500 에러

### **🔧 문제 해결 스크립트**
```cmd
# 인코딩 문제 해결
fix-encoding-issues.cmd

# 서블릿 API 문제 해결
fix-servlet-api.cmd

# Git 커밋
git-commit.cmd
```

### **✅ 완료된 변경사항**
- 포트 8080 → 8976 변경 (모든 파일)
- @WebServlet 어노테이션 제거, web.xml만 사용
- Spring CharacterEncodingFilter 제거
- javax.annotation-api-1.3.2.jar 추가
- MVC 패턴 구조 완성

### **📋 상세 상태**
- **COMMIT_STATUS.md**: 개발 진행 상황 상세 기록
- **fix-encoding-issues.cmd**: 인코딩 문제 해결 스크립트
- **fix-servlet-api.cmd**: 서블릿 API 호환성 문제 해결
- **git-commit.cmd**: Git 커밋 자동화 스크립트

---

*© 2025 환율 정보 서비스. Jules Beta 기반 예측 시스템.*
*Maven 설치 없이 바로 실행 가능한 포터블 웹 애플리케이션* 