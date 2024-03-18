# 스프링 컨테이너 생성

## 생성 과정
```java
// 스프링 컨테이너 생성
ApplicationContext applicationContext = new AnnotationConfigApplicationContext(AppConfig.class);
```

- (1) `ApplicationContext`를 스프링 컨테이너라고 한다
- (2) `ApplicationContext`는 인터페이스다
- 스프링 컨테이너는 XML로 만들 수도 있고, 애노테이션 기반 자바 설정 클래스로 만들 수 있다(요즘 트렌드는 애노테이션 기반)

![image](https://github.com/ngngs/TIL/assets/47618270/cd87e275-3706-4c27-bbfc-be7ab8ece08e)
![image](https://github.com/ngngs/TIL/assets/47618270/bf7825a6-77ff-4c38-a8e9-1a176363c6b9)
![image](https://github.com/ngngs/TIL/assets/47618270/db86a9e1-93cb-47b3-945c-c08d895434d9)

- (3) 스프링은 1.빈을 생성하는 단계, 2.의존관계를 주입하는 단계가 나누어져 있다.
- (4) 만약, 자바 코드로 스프링 빈을 등록하면 생성자를 호출하면서 의존관계 주입도 한 번에 처리된다.

## 스프링 빈 조회 - 상속관계
### 대원칙 : 부모 타입을 조회하면, 자식 타입이 모두 조회된다
- 모든 자바 객체 최고 부모인 `Object`를 조회하면, 모든 스프링 빈이 조회된다

![image](https://github.com/ngngs/TIL/assets/47618270/f4e95620-76dc-412f-9b18-07c0a9309e12)

### BeanFactory
- 스프링 컨테이너의 최상위 인터페이스
- 스프링 빈을 관리하고 조회하는 역할을 담당
- 지금까지 우리가 사용한 대부분의 기능은 BeanFactory의 기능

### ApplicationContext
- BeanFactory 기능을 모두 상속
- 빈을 관리하고 검색하는 기능을 BeanFactory가 제공해줌에도 사용하는 이유는?
- 애플리케이션을 개발할 때는 빈을 관리하고 조회하는 기능은 물론이고, 수 많은 부가기능이 필요

```java
public interface ApplicationContext extends EnvironmentCapable, ListableBeanFactory, HierarchicalBeanFactory,
		MessageSource, ApplicationEventPublisher, ResourcePatternResolver 
```
- `메세지소스`를 활용한 국제화 기능(MessageSource)
- `환경변수`를 활용한 `로컬`, `개발`, `운영`을 구분(EnvironmentCapable)
- `애플리케이션 이벤트`는 이벤트를 발행하고 구독하는 모델을 편리하게 지원(ApplicationEventPublisher)
- 파일, 클래스패스, 외부 등에서 `편리한리소스 조회`(ResourcePatternResolver)
