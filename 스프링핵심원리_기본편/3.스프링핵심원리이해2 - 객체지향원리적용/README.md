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
- (1) 우리는 역할과 구현을 충실하게 분리했다. OK
- (2) 다형성도 활용하고, 인터페이스와 구현 객체를 분리했다. OK
- (3) OCP, DIP 같은 객체지향 설계 원칙을 충실히 준수했다 -> 그렇게 보이지만 사실은 아니다.
- DIP: 주문서비스 클라이언트( OrderServiceImpl )는 DiscountPolicy 인터페이스에 의존하면서 DIP를
지킨 것 같은데?
- 클래스 의존관계를 분석해 보자. 추상(인터페이스) 뿐만 아니라 구체(구현) 클래스에도 의존하고 있다.
- 추상(인터페이스) 의존: DiscountPolicy
- 구체(구현) 클래스: FixDiscountPolicy , RateDiscountPolicy
- OCP: 변경하지 않고 확장할 수 있다고 했는데!
- 지금 코드는 기능을 확장해서 변경하면, 클라이언트 코드에 영향을 준다! 따라서 OCP를 위반한다.

![6](https://github.com/ngngs/TIL/assets/47618270/6587b7d0-dd20-4c6e-add7-fe8f87cc5f8c)
