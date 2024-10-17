
# 1. val 이란?

- Java를 사용하다 보면, 자주 사용하는 보일러 플레이트 코드들을 마주하게 된다
- Lombok은 val을 이용하여, 비효율적으로 작성하던 코드들을 제거해준다

---

# 2. val은 final과 타입 선언을 동시에 해준다
- 지역 변수(local variable)를 선언할 때 val 을 사용하면, 컴파일 타임 시 지역변수의 타입을 추론한다
- val의 역할은 곧 `final 선언` 및 `타입 추론`이다

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
## 질문) [final 선언은 왜 해줘야 하나요?](https://github.com/ngngs/TIL/blob/main/Java/final.md)
## 질문. .class 파일을 봤는데 getter, setter 어노테이션과 다르게 final이 없는데요?
1) getter, setter는 컴파일 시점에 해당 코드를 생성한다
2) val는 컴파일 시점에 해당 변수가 final처럼 작동하게 한다(재선언하려면 에러가 발생해 컴파일 자체가 되지 않는다)
3) 그러므로, val는 .class 파일에는 final이 없다 - 사실 val이 아니더라도 final 자체가 .class를 보면 없다
```java
val myVar = "Hello";
```
```java
String myVar = "Hello";
```

# 3. 문제
- 다음 ??? 에 들어갈 타입은?
```java
??? compound = isArray ? new ArrayList<String>() : new HashSet<String>();
```
- val 을 사용하면 다음과 같이 쓸 수 있다
```java
val compound = isArray ? new ArrayList<String>() : new HashSet<String>();
```
- val을 사용하지 않는다면 다음과 같이 적어주어야 한다
```java
final java.util.AbstractCollection<java.lang.String> compound = isArray ? new ArrayList<String>() : new HashSet<String>();
```

---
[롬복 Val 공식 문서](https://projectlombok.org/features/val)

[Baeldung Val / Var 가이드](https://www.baeldung.com/java-lombok-val-var)
