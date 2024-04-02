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
- `basePackages`를 이용해 탐색 패키지 시작 위치를 지정한다. (여러 개를 둘 수도 있다)
- 지정하지 않는 경우, hello.core(@ComponentScan 이 붙은 설정 정보 클래스의 패키지)가 시작 위치가 된다

## 권장 방법
- 패키지 위치를 지정하지 않고, 설정 정보 클래스의 위치를 프로젝트 최상단에 두는 것
- 최근 스프링 부트도 이 방법을 기본으로 제공
- 스프링 부트를 사용하면, 스프링 부트의 대표 시작 정보인 `@SpringBootApplication`을 이 프로젝트 시작 루트 위치에 두는 것이 관례(이 설정 안에 바로 `@ComponentScan`이 들어있음)

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(excludeFilters = { @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
		@Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
public @interface SpringBootApplication {
```

## 컴포넌스 스캔 기본 대상
- `@Component` : 컴포넌트 스캔
- `@Controller` : 스프링 MVC 컨트롤러로 인식
- `@Service` : 스프링 비즈니스 로직에서 사용, 특별한 처리를 하지 않지만 개발자들이 핵심 로직이 여기 있다는 것을 파악
- `@Repository` : 스프링 데이터 접근 계층으로 인식, 데이터 계층의 예외를 스프링 예외로 변환
- `@Configuration` : 스프링 설정 정보에서 사용, 스프링 빈이 싱글톤을 유지하도록 추가 처리
