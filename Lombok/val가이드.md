
# 1. val 이란?

Java를 사용하다 보면, 자주 사용하는 보일러 플레이트 코드들을 마주하게 된다
<br>
Lombok은 val을 이용하여, 비효율적으로 작성하던 코드들을 제거해준다

---

# 2. val은 final과 타입 선언을 동시에 해준다
지역 변수(local variable)를 선언할 때 val 을 사용하면, 컴파일 타임 시 지역변수의 타입을 추론하게 한다.
```java
// with Lombok.val
val example = new ArrayList<String>();
example.add("Hello, World!");
val foo = example.get(0);
```
```java
// without val
final ArrayList<String> example = new ArrayList<String>();
example.add("Hello, World!");
final String foo = example.get(0);
```
## 질문. .class 파일을 봤는데 getter, setter 어노테이션과 다르게 final이 없는데요?
1) getter, setter는 컴파일 시점에 해당 코드를 생성
2) var는 컴파일 시점에 해당 변수가 final처럼 작동하게 하여, 실제로 재선언하게 해줄 경우 컴파일 자체가 되지 않음
3) 그러므로, var는 .class 파일에는 final이 없다
```java
val myVar = "Hello";
```
```java
String myVar = "Hello";
```



---
[롬복 Val 공식 문서](https://projectlombok.org/features/val)

[Baeldung Val / Var 가이드](https://www.baeldung.com/java-lombok-val-var)
