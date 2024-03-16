# 새로운 할인 정책 개발

## 비즈니스 변동 사항 발생
- (1) 고정 금액 할인 -> 주문 금액당 할인하는 정률(%) 할인으로 변경해달라
- 예를 들어, VIP가 주문 금액에 상관없이 1000원 할인이었다면 이제는 10000원 당 1000원으로 할인해주자

## 참고 : 애자일 소프트웨어 개발 선언

우리는 소프트웨어를 개발하고, 또 다른 사람의 개발을
도와주면서 소프트웨어 개발의 더 나은 방법들을 찾아가고
있다. 이 작업을 통해 우리는 다음을 가치 있게 여기게 되었다.

공정과 도구보다 `개인과 상호작용`을
포괄적인 문서보다 `작동하는 소프트웨어`를
계약 협상보다 `고객과의 협력`을
계획을 따르기보다 `변화에 대응`하기를 가치 있게 여긴다. 

이 말은, 왼쪽에 있는 것들도 가치가 있지만,
우리는 오른쪽에 있는 것들에 더 높은 가치를 둔다는 것이다.

`Kent Beck`
`Mike Beedle`
`Arie van Bennekum`
`Alistair Cockburn`
`Ward Cunningham`
`Martin Fowler`
`James Grenning`
`Jim Highsmith`
`Andrew Hunt`
`Ron Jeffries`
`Jon Kern`
`Brian Marick`
`Robert C. Martin`
`Steve Mellor`
`Ken Schwaber`
`Jeff Sutherland`
`Dave Thomas`


## 인텔리제이 테스트 만들기
[윈도우 기준] CTRL + SHIFT + T


# 새로운 할인 정책 적용 시 발생하는 문제
- OrderServiceImpl은 인터페이스(DiscountPolicy), 구현체(FixDiscountPolicy) 모두에게 의존한다. (DIP위반)
- 지금 코드는 기능을 확장해서 변경하면, 클라이언트 코드에 영향을 준다. (OCP 위반)

![6](https://github.com/ngngs/TIL/assets/47618270/6587b7d0-dd20-4c6e-add7-fe8f87cc5f8c)

# 해결방안
- OrderServiceImpl이 인터페이스만 바라보면 된다.
```java
    // private final DiscountPolicy discountPolicy = new FixDiscountPolicy();
    private DiscountPolicy discountPolicy;
```
- 이렇게 DIP는 지킬 수 있지만, 코드 실행시 NPE가 발생한다
- 해결방안 : 누군가가 클라이언트인 OrderServiceImpl 에 DiscountPolicy 의 구현 객체를 대신 생성하고 주입해주어야 한다.

## 관심사의 분리
- 애플리케이션은 하나의 공연이다. 각각의 인터페이스를 배역이라 생각하자.
- 로미오와 줄리엣을 누가 할지 정하는 건 배우가 아니다. 이전 코드는 마치 로미오 역할(인터페이스)을 하는 배우가 줄리엣 역할을 하는 여자 주인공도 섭외하는 것과 같다. 즉, 한 인터페이스에게 `다양한 책임`이 주어진다

## AppConfig 등장
- 애플리케이션 전체 동작 방식을 구성(config)하기 위해, `구현 객체를 생성`하고, `연결`하는 책임을 가진 별도의 설정 클래스 만들기

- 기존에는 MemberServiceImpl이 Repository()까지 직접 만들어 주었다면,
```java
public class MemberServiceImpl implements MemberService{

    private final MemberRepository memberRepository = new MemoryMemberRepository();

```
- 이제는 AppConfig가 넣어준다. (`생성자주입`)
```java
    private final MemberRepository memberRepository;

    public MemberServiceImpl(MemberRepository memberRepository) {
        this.memberRepository = memberRepository;
    }
```

## AppConfig 리팩터링
- 현재 AppConfig는 "중복"이 존재
- 다음과 같은 방향으로 AppConfig 수정
![image](https://github.com/ngngs/TIL/assets/47618270/4dafaa0f-1992-4020-b6c0-3039b2464db8)


# IoC, DI, 그리고 컨테이너
## 제어의 역전 IoC(Inversion of Control)
- 리팩토링 전 코드는 클라이언트 구현 객체가 스스로 필요한 서버 구현 객체를 생성하고 연결하고 실행했다.(구현 객체가 프로그램의 제어 흐름을 스스로 조종)
- `AppConfig`의 등장으로 구현 객체는 자신의 로직을 실행하는 역할만 담당. 프로그램의 제어 흐름이 AppConfig에게 넘어감
- 예를 들어, OrderServiceImpl은 어떤 구현 객체들이 실행될지 모름
- 프로그램의 제어 흐름을 직접 제어하는 것이 아닌 외부에서 관리하는 것을 `제어의 역전(IoC)`이라고 한다

### 프레임워크 vs 라이브러리
- 프레임워크 : 내가 작성한 코드를 자신의 라이프 사이클 속에서 부른다(제어의 역전)
- 라이브러리 : 내가 작성한 코드가 제어의 흐름을 따라간다면 라이브러리

## 의존관계 주입 DI(Dependency Injection)
- 정적 의존관계 : 클래스가 사용하는 `import`만 보고도 알수 있음(애플리케이션을 실행하지 않아도 됨)
- 동적 의존관계 : 인스턴스가 생성되며 의존되는 관계
- 애플리케이션 `실행시점(런타임)`에 외부에서 객체를 생성하고 클라이언트에 전달해서, 클라이언트와 서버의 실제 의존관계가 연결되는 것을 `의존관계 주입`이라 한다
- 의존관계 주입을 사용하면, 클라이언트 코드를 변경하지 않고 클라이언트가 호출하는 대상 타입 인스턴스를 변경
- 의존관계 주입을 사용하면 정적인 클래스 의존관계를 변경하지 않고, 동적인 객체 인스턴스 의존관계를 쉽게 변경

## 컨테이너
- AppConfig처럼 객체를 생성하고 관리하면서 의존관계를 연결해주는 것을 `IoC컨테이너` 또는 `DI컨테이너`라고 함
- 최근에는 주로 `DI컨테이너`라 함

# 자바에서 스프링으로
## @Configuration, @Bean 등록 이후 MemberApp을 실행하면
![image](https://github.com/ngngs/TIL/assets/47618270/7071e32c-74c5-413f-8ded-7530ce1ca4e5)

## 스프링으로 개발할 때 장점이 뭘까?
- AppConfig보다 SpringContainer 뭐가 나은지 다음 강의에서 고고
