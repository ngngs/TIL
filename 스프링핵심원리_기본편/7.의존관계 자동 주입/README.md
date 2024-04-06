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


