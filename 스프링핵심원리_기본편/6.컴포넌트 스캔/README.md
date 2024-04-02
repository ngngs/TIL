# 컴포넌트 스캔

## 컴포넌트 스캔과 의존관계 자동 주입
- 이전까지 스프링 빈 등록을 자바 코드의 @Bean이나 XML <bean> 을 통해 설정 정보에 직접 등록할 빈을 나열했다
- 스프링은 설정 정보가 없어도 자동으로 스프링 빈을 등록하는 `컴포넌트 스캔`이라는 기능을 제공한다
- 의존관계도 자동으로 주입하는 `@Autowired`라는 기능을 제공한다

## 스캔 방법
- `@Component` 애노테이션이 붙은 클래스를 스캔해서 스프링 빈으로 등록
- `@Configuration` 도 인터페이스를 보면 @Component가 붙어 있다
- `@Autowired`는 의존관계를 자동으로 주입해준다

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Component
public @interface Configuration {
```

## 탐색 위치와 기본 스캔 대상
