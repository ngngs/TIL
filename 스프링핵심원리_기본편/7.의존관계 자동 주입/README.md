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
