# 🙆‍♂️TIL 

## 👍작성 Rule

- (1) 업무 및 스터디에서 학습한 내용 정리
- (2) 학습한 내용의 출처는 반드시 남겨서 다시 확인할 수 있도록 하기
- (3) 깔끔하게 정리하지 못 하더라도 꾸준히 메모 조각이라도 남기기   

## 🍉분류 

### Books
- [클린 코드](https://velog.io/@ngngs/%EC%B1%85%EB%84%88%EB%91%90-5%EA%B8%B0-%ED%81%B4%EB%A6%B0%EC%BD%94%EB%93%9C)
- [이펙티브엔지니어](https://velog.io/@ngngs/%ED%9A%A8%EC%9C%A8%EC%A0%81%EC%9D%B8-%EA%B0%9C%EB%B0%9C%EC%9E%90-12)
- [코딩인터뷰 완전분석](https://velog.io/@ngngs/%EC%83%88%EB%A1%9C%EC%9A%B4-%EC%95%8C%EA%B3%A0%EB%A6%AC%EC%A6%98-%EC%B1%8C%EB%A6%B0%EC%A7%80%EB%8A%94-%EC%83%88%EB%A1%9C%EC%9A%B4-%EC%96%B8%EC%96%B4%EB%A1%9C)
- [컴퓨터시스템](https://velog.io/@ngngs/%EC%BB%B4%ED%93%A8%ED%84%B0%EC%8B%9C%EC%8A%A4%ED%85%9CCSAPP-1%EC%9E%A5)
- [면접을 위한 CS전공지식노트](https://www.yes24.com/Product/Goods/108887922)
- [운영체제 아주 쉬운 세 가지 이야기](https://www.yes24.com/Product/Goods/93738334)
- 이펙티브자바
- 헤드퍼스트 디자인 패턴

### Java
- [리팩토링](https://github.com/ngngs/Refactoring_excercise)
- [김영한의 실전 자바 - 중급 1편](https://github.com/ngngs/TIL/tree/main/%EA%B9%80%EC%98%81%ED%95%9C%EC%9D%98%20%EC%8B%A4%EC%A0%84%20%EC%9E%90%EB%B0%94%20-%20%EC%A4%91%EA%B8%891%ED%8E%B8)
- 롬복 구현하기
- [자바의 Virtual Thread](https://velog.io/@ngngs/%EC%B9%B4%EC%B9%B4%EC%98%A4%EC%99%80-%EC%9A%B0%EC%95%84%ED%95%9C%ED%98%95%EC%A0%9C%EB%93%A4%EC%9D%B4-%EC%84%A0%EB%B3%B4%EC%9D%B4%EB%8A%94-Java-%EA%B0%80%EC%83%81-%EC%8A%A4%EB%A0%88%EB%93%9C-%ED%98%81%EC%8B%A0)
  
### Spring
- [김영한 로드맵 1 : 스프링 핵심원리 기본편](https://github.com/ngngs/TIL/tree/main/%EC%8A%A4%ED%94%84%EB%A7%81%ED%95%B5%EC%8B%AC%EC%9B%90%EB%A6%AC_%EA%B8%B0%EB%B3%B8%ED%8E%B8)
- [스프링 트랜잭션](https://github.com/ngngs/TIL/tree/main/DB/1.%20%EC%8A%A4%ED%94%84%EB%A7%81%20%ED%8A%B8%EB%9E%9C%EC%9E%AD%EC%85%98)
- Exception 발생 시 익셉션을 어떻게 처리하는지(sysException, bizException 핸들링 확인하기) -> @ExceptionHandler와 @ControllerAdvice 이해하기
- XSSFilter, SessionFilter 처리 및 디버깅 화면에서 확인 가능한 "http-nio-18080-exec-3"@12,136 in group "main" : RUNNING은 스레드의 상태와 관련된 정보
- http-nio-18080-exec-3는 스레드명, 12,136은 메모리 주소, "main" 그룹에 속한 스레드
- @Service(경로) 를 살펴봐야 서비스 빈이 어디에 등록되었는 지 확인할 수 있음. 간혹 위치를 옮긴 파일들이 있어서 실제 경로와 다를 수 있음
- @SuppressWarnings("rawtypes") 를 사용하는 이유? 제너릭을 사용하는 클래스 매개 변수가 불특정일 때의 경고 

### 리눅스
- 리눅스 명령어 통해 서버 올리기, 내리기
- tail -f : 실시간 로그 보기

### DB
- [DB한눈에 보기](https://github.com/ngngs/TIL/tree/main/DB)
- 오라클 결합 인덱싱 : 결합 인덱스에서 열의 순서는 매우 중요하다. 인덱스는 첫 번째 열부터 정렬되고 검색되기 때문에, 자주 사용되는 조건 또는 필터링 조건에 따라 순서를 정해야 한다. 만약, SELECT 문의 WHERE절에 결합 인덱스의 첫 번째 컬럼을 조건에 사용하였다면 결합문을 사용할 수 있지만 결합 인덱스의 두번쨰 컬럼만을 WHERE 절에 조건으로 사용하고 결합 인덱스를 사용하려하면 실행계획은 인덱스를 사용하지 못 한다
  
### Web
- 

### 형상관리
-

### Design Pattern
- 싱글톤 패턴
- 옵저버 패턴
- 데코레이터 패턴
- 팩토리 패턴
- 플라이웨이트 패턴

### Algorithm
-

### 프론트
- 

### IDE
- [인텔리제이 Update resources / Update classes and resources / Hot swap classes / Redeploy / Restart server](https://www.jetbrains.com/help/idea/updating-applications-on-application-servers.html)
- [인텔리제이 디버깅](https://github.com/jojoldu/blog-code/tree/master/intellij-debugging)

### 네트워크
- [ICMP 와 IP, 디도스](https://www.cloudflare.com/ko-kr/learning/ddos/glossary/internet-control-message-protocol-icmp/)
- [OSI 모델](https://www.cloudflare.com/ko-kr/learning/ddos/glossary/open-systems-interconnection-model-osi/)
- [OSI 7계층](https://velog.io/@ngngs/ping%EA%B3%BC-telnet%EC%9C%BC%EB%A1%9C-%EC%8B%9C%EC%9E%91%ED%95%9C-OSI-7-Layer)
- [리그오브레전드 디도스 체험하기](https://byeo.tistory.com/entry/%EB%A6%AC%EA%B7%B8%EC%98%A4%EB%B8%8C%EB%A0%88%EC%A0%84%EB%93%9C-%EB%94%94%EB%8F%84%EC%8A%A4)
- [전선을 통한 데이터 송수신 심화](https://thisiswoo.github.io/development/osi-7-physical-layer.html)
- [ICMP ping 응답이란?](https://docs.netapp.com/ko-kr/e-series-santricity/sm-hardware/what-are-icmp-ping-responses.html)
- [Ping, telnet, curl](https://toneyparky.tistory.com/59)
- [Ping, TCP, UDP, Three-Way Handshake (What are these and how do they work)](https://www.scaler.com/topics/cyber-security/what-is-ping/)
- (작성예정) ping(traceroute), telnet 보기. 업무 당시 겪은 일, www.linux.co.kr, ping과 telnet이란? 복습하기 osi 7계층 중 3계층과 4계층. icmp란?, 프로토콜 짚고가기, icmp 어디 사용될까, icmp과 udp/tcp 차이(handshake), icmp 메시지 포맷, 디도스공격방식(2가지), 


## 👩‍🏫👨‍🏫 컨퍼런스
- [Go를 모르는 취준생의 GopherCon Korea 2023 오프라인 참석 후기](https://velog.io/@ngngs/%EC%B7%A8%EC%A4%80%EC%83%9D%EC%9D%98-GopherCon-Korea-2023-%EC%98%A4%ED%94%84%EB%9D%BC%EC%9D%B8-%EC%B0%B8%EC%84%9D-%ED%9B%84%EA%B8%B0)
- [제2회 카카오Tech Meet 짧은 후기](https://velog.io/@ngngs/%EC%A0%9C2%ED%9A%8C-%EC%B9%B4%EC%B9%B4%EC%98%A4-%ED%85%8C%ED%81%AC-%EB%B0%8B%EC%A7%A7%EC%9D%80%ED%9B%84%EA%B8%B0)
