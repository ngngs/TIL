# 기본형의 한계

## 문자열과 타입 안전성1
- 열거형(Enum Type)을 이해하려면, 왜 열거형이 등장했는지 알아야한다
- 비즈니스 요구사항에 따라 고객을 3등급으로 나누고 상품 구매시 등급별로 할인을 적용한다고 해보자

### 비즈니스 요구사항
- 고객은 3등급으로나눈다.
- 상품 구매 시 등급별로 할인을 적용한다
- 할인 시 소수점 이하는 버린다
- Basic(10%), Gold(20%), Diamond(30%) 할인

```java
 public int discount(String grade, int price) {
        int discountPercent = 0;
        if (grade.equals("BASIC")) {
            discountPercent = 10;
        } else if (grade.equals("GOLD")) {
            discountPercent = 20;
        } else if (grade.equals("DIAMOND")) {
            discountPercent = 30;
        } else {
            System.out.println(grade + ": 할인X");
        }
        return price * discountPercent / 100;
}
```

## 위 코드의 문제점
- 1. 타입 안전성 부족 : 단순히 문자열을 입력하는 방식은 `오타`가 발생, 유효하지 않는 값이 입력될 수 있음(소문자 등)
- 2. 데이터 일관성 떨어짐 : "GOLD", "gold" 등 입력 될 수 있음
- 3. 컴파일 시 오류를 감지할 수 없다(`String`은 어떤 문자열이든 받기 때문에 문제를 해결할 수 없다)

## 열거형 - Enum Type
- enum은 enumeration의 줄임말로, `열거`라는 뜻이다
- 일련의 명명된 상수들의 집합을 정의한 것
```java
 public enum Grade {
 BASIC, GOLD, DIAMOND
 }
 ```

```java
 public class Grade extends Enum {
   public static final Grade BASIC = new Grade();
   public static final Grade GOLD = new Grade();
   public static final Grade DIAMOND = new Grade();
   //private 생성자 추가
  private Grade() {}
 }

```

## 열거형의 장점
- 타입 안전성 향상 : 열거형은 사전에 정의된 상수들로만 구성(유효하지 않은 값이 입력될 수 없고, 되더라도 컴파일 오류)
- 간결성 및 일관성
- 확장성 : 새로운 회원 추가하고 싶으면 ENUM 상수만 추가해주면 된다

### ENUM 주요 메서드
- values() : 모든 ENUM 상수를 포함하는 배열을 반환
- valueOf(String name) : 주어진 이름과 일치하는 ENUM 상수를 반환
- name() : ENUM 상수의 이름을 문자열로 반환
- ordinal() : ENUM 상수의 선언 순서(0부터)를 반환 * 가급적 사용하지 말자(중간에 상수를 선언하는 위치가 변경되면 전체 상수 위치가 변경되기 때문)
- toString() : ENUM 상수의 이름을 문자열로 반환.
