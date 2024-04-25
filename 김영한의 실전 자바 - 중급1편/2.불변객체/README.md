## 공유 참조와 사이드 이펙트
```java
b.setValue("부산");
System.out.println("부산 -> b");
System.out.println("a = " + a); // 사이드 이펙트 발생
System.out.println("b = " + b);
```
## 사이드 이펙트가 발생하는 이유
- b의 값을 바꾸면서, a의 값까지 발생하는 문제가 발생했다
- 객체를 공유하고, 공유된 객체의 값을 변경하기 때문에 발생한다
- `Address` 객체의 값을 변경하지 못 하게 설계한다면 사이드 이펙트가 발생하지 않는다

## 불변 객체 도입
- 객체의 상태(값, 필드, 멤버변수)가 변하지 않는 객체를 불변 객체(Immutable Object)라 한다
- `Address`클래스를 불변 클래스로 만들어보자
```java
 private final String value;
```
- 내부 값이 변경되기 안되기 때문에 `final` 로 선언
- 값을 변경할 수 있는 `setValue()`를 제거
- 그냥 쉽게, 절대 값을 변경 못하게 만들면 불변 객체

```java
 ImmutableAddress a = new ImmutableAddress("서울");
 ImmutableAddress b = a; // 이걸 막을 방법은 없다

 // b.setValue("부산"); // 컴파일 오류가 발생하여, 이를 사용하는 개발자는 불변객체임을 알게 됨
 b = new ImmutableAddress("부산"); // 새로운 객체로 생성한다
```

![image](https://github.com/ngngs/TIL/assets/47618270/59500939-6803-4978-94e3-9cb57daf2c53)

## 불변 객체 값 변경이 필요한 경우
- 예를 들어, 기존 값에 새로운 값을 더하는 add() 같은 메소드가 있다면?
- 참고로 불변 객체는 변하지 않아야 한다!

```java
public class ImmutableObj {
    private final int value;
    public ImmutableObj(int value) {
        this.value = value;
    }
    public ImmutableObj add(int addValue) {
        int result = value + addValue;
        return new ImmutableObj(result); // 새로 생성한 ImmutableObj 를 return 한다  
    }
    public int getValue() {
        return value;
    }
}
```
 - 스터디 질문 : 그렇다면 add를 할 때마다 객체가 새로 생성될텐데.. 기존 객체를 지우는 게 좋은 방법일지..?

### withYear, withDate 등 with 관례
- setValue와 같이 관례적으로 불변객체에서 사용하는 것이 `withValue`
- `withValue` 를 사용할 경우, 새로운 객체를 반환한다고 생각하면 된다

```java
public ImmutableMyDate withYear(int newYear){
  return new ImmutableMyDate(newYear, month, day)
}
```

```java
 ImmutableMyDate date1 = new ImmutableMyDate(2024,1,1);
 date1 = date1.withYear(2025); // 질문 - 이런 식으로 기존 객체에 덮어쓰기가 좋은 방식일까요..? 그렇다면 왜 불변객체로 만든걸까요..
```
