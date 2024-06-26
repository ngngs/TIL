# 중첩 클래스, 내부 클래스1

## 중첩 클래스, 내부 클래스 란?

- for문 안에 for문이 중첩하는 것을 중첩(Nested) for문이라 한다
- 중첩 클래스(Nested Class) : 클래스 안에 클래스를 중첩해서 정의한 것

![image](https://github.com/ngngs/TIL/assets/47618270/d57cafee-3ddb-49ba-a93f-46a14efc3fe9)

## 중첩 클래스는 총 4가지가 있다
- 정적 중첩 클래스, 내부 클래스, 지역 클래스, 익명 클래스
- 중첩 클래스를 정의하는 위치는 변수의 선언 위치와 같다
- 정적 중첩 클래스는 정적 변수(클래스 변수)와 같은 위치
- 내부 클래스는 인스턴스 변수와 같은 위치
- 지역 클래스는 지역 변수와 같은 위치

```java
class Outer {
  // 정적 중첩 클래스
  static class StaticNested{

  }

  // 내부 클래스
  class Inner {
  ...
  }
}
```
- 정적 중첩 클래스는 정적 변수와 같이 앞에 static이 붙어있다
- 내부 클래스는 인스턴스 변수와 같이 앞에 static이 붙지 않는다

```java
class Outer {
  public void process(){
    // 지역 변수
    int localVar = 0;

    // 지역 클래스
    class Local {...}

    Local local = new Local();
  }
}
```
- 지역 클래스는 지역 변수와 같이 코드 블럭 안에서 클래스를 정의한다
- 참고로, 익명 클래스는 지역 클래스의 특별한 버전이다

### 중첩(Nested) vs 내부(Inner)
- 중첩 : 어떤 다른 것이 내부에 위치하거나 포함되는 구조적 관계, `나의 안에 있지만 내것이 아닌 것`
- 내부 : 나의 내부에 있는 나를 구성하는 요소, `나의 안에 있는 나를 구성하는 요소`
- 중첩과 내부를 분류하는 핵심은 바깥 클래스 입장에서 안에 있는 클래스가 내 인스턴스에 소속이 되는가? 안되는가?
- 정적 중첩 클래스는 바깥 클래스와 전혀 다른 클래스 -> 즉, 바깥 클래스의 인스턴스에 소속되지 않음
- 내부 클래스는 바깥 클래스를 구성하는 요소 -> 따라서, 바깥 클래스 인스턴스에 소속

## 중간 정리
- 정적 중첩 클래스는 static, 바깥 클래스 인스턴스에 소속되지 않음
- 내부 클래스(내부 클래스, 지역 클래스, 익명 클래스)는 바깥 클래스 인스턴스에 소속

## 중첩 클래스는 언제 사용해야 하는가
- 내부 클래스를 포함한 모든 중첩 클래스는 특정 클래스가 `다른 하나의 클래스 안`에서만 사용되거나, 둘이 아주 긴밀하게 연결된 특별한 경우
- 외부 여러 클래스가 특정 중첩 클래스를 사용한다면 중첩 클래스로 만들면 안된다

## 중첩 클래스를 사용하는 이유
- (1) 논리적 그룹화 : 특정 클래스가 다른 하나 클래스 안에서만 사용되는 경우, 해당 클래스 안에 포함하는 것이 논리적으로 그룹화 된다
- 추가로, 패키지를 열었을 때 다른 곳에서 사용될 필요가 없는 중첩 클래스가 외부에 노출되지 않는 장점
- (2) 캡슐화 : 중첩 클래스는 바깥 클래스의 private 멤버에 접근한다. 이렇게 해서 둘은 긴밀하게 연결되고, 불필요한 `public` 메소드가 제거된다

```java

class Scratch {
    public static class scratch {

        private static int outClassValue = 3;
        private int outInstanceValue = 2;

        static class Nested {
            private int nestedInstanceValue = 1;
            public void print() {

                // 자신의 멤버에 접근
                System.out.println(nestedInstanceValue);

                // 바깥 클래스의 인스턴스 멤버에는 접근할 수 없다.
                //System.out.println(outInstanceValue);

                // 바깥 클래스의 클래스 멤버에는 접근할 수 있다. private도 접근 가능
                System.out.println(NestedOuter.outClassValue);
            }
        }

    }
}
```
- `정적` 중첩 클래스는 정적이다. 앞에 static이 붙는다!
- 정적 중첩클래스는 바깥 클래스의 인스턴스 멤버에는 접근할 수 없지만, 클래스 멤버에는 접근할 수 있다
- 정적 중첩클래스는 다른 클래스를 그냥 중첩해둔 것 뿐이고, 둘이 아무런 관계가 없다


## 지역 변수
- [변수 캡처](https://kangworld.tistory.com/206)

## 익명클래스
- 선언과 생성을 한번에 하고 싶다면 익명 클래스를 사용하자
- 익명 클래스는 클래스의 본문(body)을 정의하면서 동시에 생성
- `new` 다음에 바로 상속 받으면서 구현 할 부모 타입을 입력하면 된다
- 자바에서 인터페이스를 생성(new)하는 것은 불가능하다. 인터페이스를 구현한 익명 클래스를 생성하는 것이다
- `body` 부분에 `Printer` 인터페이스를 구현한 코드를 작성하면 된다. 이 부분이 바로 익명 클래스의 본문이다
- `Printer`를 상속(구현)하면서 바로 생성한다

### 람다
- 자바8 이전까지 메서드에 인수로 전달하는 방법은 2가지였다
- `int`, `double` 같은 기본형 타입
- `Process` `Member`와 같은 참조형 타입(인스턴스)
- 자바8 부터는 메서드(더 정확히는 함수)를 인수로 전달할 수 있게 되었다. 이 것이 람다!
