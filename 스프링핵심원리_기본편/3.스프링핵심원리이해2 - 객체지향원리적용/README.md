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
