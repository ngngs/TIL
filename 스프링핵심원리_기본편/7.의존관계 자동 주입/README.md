## 다양한 의존관계 주입 방법
- 생성자 주입
- 수정자 주입(setter)
- 필드 주입
- 일반 메서드 주입

### 생성자 주입
- 생성자 호출 시점에 1번 주입되며 `불변`이라는 특징을 갖는다
- 값은 반드시 `필수`적으로 존재해야 한다
- 생성자가 딱 1개만 있으면, @Autowired를 생략해도 된다
```java
    private final MemberRepository memberRepository;
    private final DiscountPolicy discountPolicy;
```


### 수정자 주입(setter)
- setter 수정자 메서드를 통해 의존관계를 주입하는 방법이다
- `선택`, `변경` 가능성이 있는 의존관계에 사용
- 자바빈 프로퍼티 규약의 수정자 메서드 방식(필드 값을 직접 변경하지 않고, setXXX 메서드를 통해 값을 수정하는 규칙)
- `@Autowired`는 주입할 대상이 없으면 오류가 발생한다. (주입할 대상이 없어도 동작하게 하려면 required=false)
```java
    private MemberRepository memberRepository;
    private DiscountPolicy discountPolicy;

    @Autowired
    public void setMemberRepository(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }

    @Autowired
    public void setDiscountPolicy(DiscountPolicy discountPolicy) {
        this.discountPolicy = discountPolicy;
    }
```

### 필드 주입
- 코드가 간결하지만, 외부 변경이 불가능해 테스트하기 어렵다는 치명적인 단점
- DI 프레임워크가 필요함
- 사용하지 않기를 권장
- 사용하는 경우는 애플리케이션의 실제 코드와 관계없는 테스트를 할 경우(스프링부트 테스트 등)
```java
    @Autowired private MemberRepository memberRepository;
    @Autowired private DiscountPolicy discountPolicy;
```

### 일반 메서드 주입
- 일반 메서드를 통한 주입
- 한번에 여러 필드를 주입 받을 수 있다
- 일반적으로 잘 사용하지는 않음!


## 옵션 처리
- 주입할 스프링 빈이 없어도 동작해야 할 때가 있다
- 하지만, `@Autowired`는 기본적으로 `required`가 `true`로 되어 있기 때문에 자동 주입 대상이 없으면 오류가 발생한다

### 자동 주입 대상을 옵션으로 처리하는 3가지 방법
- `@Autowired(required=false) : 자동 주입 대상이 없으면 수정자 메서드 자체가 호출이 안된다
- `org.springframework.lang.@Nullable` : 자동 주입할 대상이 없으면 null이 입력된다
- `Optional<>` : 자동 주입 대상이 없으면 `Optional.empty`가 입력된다

### 에러 발생
```java
org.springframework.beans.factory.NoUniqueBeanDefinitionException: No qualifying bean of type 'hello.core.member.MemberRepository' available: expected single matching bean but found 2: memoryMemberRepository,memberRepository

```
- 스프링 부트 테스트 : 스프링에서 진행하는 통합 테스트
- 원인 :  AppConfig 내 MemoryMemberRepository와 MemoryMemberRepository 클래스 둘 모두 빈으로 등록되어서 발생한 문제
- 나와 같은 에러가 발생한 분들이 많아 해당 문제에 대해 영한킴이 직접 답변해주신 내용
- 답변 : 스프링의 @ComponentScan이 중복 적용된 경우에는 excludeFilters가 적용되지 않습니다.
- 예를 들어서 다음 com.example.app 패키지에 있는 AppBean을 중복으로 컴포넌트 스캔해볼께요.
```java
package com.example.app;

import org.springframework.stereotype.Component;

@Component

public class AppBean {

}
```
그리고 2가지 컴포넌트 스캔이 있습니다.
```java
//@Component를 제외하고 스캔한다. AppBean은 스캔되지 않아야 한다.
@ComponentScan(basePackages = "com.example.app", excludeFilters = @ComponentScan.Filter(type = FilterType.ANNOTATION, classes = Component.class))
//모든 빈을 스캔한다. AppBean이 스캔 되어야 한다.
@ComponentScan(basePackages = "com.example.app")
public class SpringScanApplication {
}
```
- 이렇게 중복 정의된 경우 한곳에서 이미 스캔을 하도록 되어 있기 때문에 결과적으로 AppBean은 컴포넌트 스캔의 대상이 됩니다.
- 그러면 이번 예제에서는 어떻게 된 것일까요?
- CoreApplicationTests는 스프링 부트를 찾아서 실행하게 됩니다. 테스트 위에 @SpringBootTest라는 애노테이션이 보이실꺼에요.
- 스프링 부트로 실행하게 되면 @SpringBootApplication 애노테이션이 있는 CoreApplication을 찾아서 설정 파일로 사용하게 됩니다.
- 그런데 SpringBootApplication 내부에는 @ComponentScan 코드가 있습니다. 참고로 스프링 부트는 편리함을 위해 자동으로 컴포넌트 스캔을 제공합니다.
- @ComponentScan은 별도의 코드를 제공하지 않으면 현재 클래스가 있는 패키지 부터 하위 패키지를 모두 컴포넌트 스캔합니다.
- 따라서 @SpringBootApplication 애노테이션이 있는 곳의 패키지 부터 모든 빈들을 컴포넌트 스캔합니다.
- 결과적으로 스프링 부트를 통해서 실행하는 경우 이미 @ComponentScan을 통해서 모든 빈들을 읽어버리기 때문에 AutoAppConfig의 컴포넌트 스캔의 excludeFilter 설정은 적용되지 않습니다.

## 롬복과 최신 트렌드
- gradle에 롬복을 추가
- `@RequiredArgsConstructor` 를 활용하여 기존 생성자를 대체하기
```java
// 기존코드
@Component
public class OrderServiceImpl implements OrderService{

    @Autowired private MemberRepository memberRepository;
    @Autowired private DiscountPolicy discountPolicy;

    public OrderServiceImpl(MemberRepository memberRepository, DiscountPolicy discountPolicy) {
        System.out.println("memberRepository =  " + memberRepository);
        System.out.println("discountPolicy = " + discountPolicy);
        this.memberRepository = memberRepository;
        this.discountPolicy = discountPolicy;
    }
```
```java
// 생성자를 대체
@Component
@RequiredArgsConstructor // final이 붙은 값을 생성자로 만들어줌
public class OrderServiceImpl implements OrderService{

    private final MemberRepository memberRepository;
    private final DiscountPolicy discountPolicy;
}
```

### 생성자 요약
- 생성자를 딱 1개 두고, `@Autowired`를 생략하는 방법을 사용
- Lombok 라이브러리의 `@RequiredArgsConstructor` 함께 사용하면 더 깔끔해진다
