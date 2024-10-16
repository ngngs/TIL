
# final 
- 우리는 자바 코드를 진행하다 보면, 때론 확장 가능성을 제한해줘야 하는 경우가 있다
- 이를 자바에서 `final` 키워드를 이용하여 class, mnethod, variable 모두에 사용 가능하다!

# 1. final Class
- final로 선언된 대표적인 클래스는 바로 `String` class
- final로 선언된 고양이 클래스를 상속받는 다면?
```java
public final class Cat {

    private int weight;

    // standard getter and setter
}
```
```java
public class BlackCat extends Cat {
}    // The type BlackCat cannot subclass the final class Cat
```
- 바로 위와 같은 컴파일 에러가 발생한다

## 주의 : final class는 상속을 받을 수 없는 것이지 해당 클래스의 object가 불변이라는 것은 아님!!!!
```java
Cat cat = new Cat();
cat.setWeight(1);

assertEquals(1, cat.getWeight());
```

# 2. final Method
- final로 선언된 메서드는 override 할 수 없다
- 보통 이런 코드들은 Java Core Libraries에서 찾을 수 있다!
- 예를 들어, 특정 메서드의 오버라이딩을 막아야 하는 경우가 있다. (아주 좋은 예가 `Thread` 클래스)
- Thread 클래스는 `isAlive()` 메서드는 final로 선언되어 있다
- isAlive() 메서드는 네이티브 메서드로, 다른 프로그래밍 언어로 구현되어 있어 운영 체제와 하드웨어에 따라 달라지기 때문
- Dog 라는 클래스를 만들고 sound()를 final로 만든다면?
```java
public class Dog {
    public final void sound() {
        // ...
    }
}
```
```java
public class BlackDog extends Dog {
    public void sound() {
    }
}
```
- 바로 다음과 같은 컴파일 에러를 만나버린다
```java
- overrides
com.Dog.sound
- Cannot override the final method from Dog
sound() method is final and can’t be overridden
```

# 3. final Variable
- Variable은 final로 선언될 경우 재할당될 수 없다
## 1) Primitive Variable
```java
public void whenFinalVariableAssign_thenOnlyOnce() {
    final int i = 1;
    //...
    i=2;
    // The final local variable i may already have been assigned
}
```
## 2) Reference Variable
```java
final Cat cat = new Cat();
// The final local variable cat cannot be assigned. It must be blank and not using a compound assignment
```
- 그러나 앞서서 이야기했지만, Cat의 property는 바꿀 수 있다
```java
cat.setWeight(5);

assertEquals(5, cat.getWeight());
```
## 3) Fields
- final 필드는 초기값을 줄 수 있는 방법이 2가지다
- `필드 선언 시` 또는 `생성자에서 넘겨주기`
- 필드 선언 시 초기화를 해주는 경우는 단순한 값일 때다
- 생성자에서 넘겨줘야 하는 경우는 외부 데이터로 초기화하여 생성자에서 초기값을 지정해줘야 하는 경우다
- 다음과 같은 상황을 가정해보자. `대한민국 국민`이라는 Class를 만들어야하는 상황이다
- 필드는 `국적`, `주민등록번호`, `이름`이라고 주어질 때 어떤 값을 final로 선언해주어야 할까?
```java
public class KoreaPerson{
  final String Nation = "Republic of Korea";
  final String ID;
  String Name;

  public KoreaPerson(String ID, String Name){
    this.ID = ID;
    this.Nmae = Name;
  }

  // getter, setter
}
```
 - 주민등록번호는 KoreaPerson 객체가 생성될 때 부여되므로 초기값을 줄 수 없다
 - Nation은 항상 고정된 값을 가지기 때문에 필드 선언 시 초기값으로 준다
```java
public class Example{
  public static void main(String[] args){
    val Person1 = new KoreaPerson("241016-3123456", "문복남");
    Person1.setName("문복규");
  }
}
```
## 4) Parameter
- final parameter는 메서드 내에서 바뀔 수 없다
```java
public void methodWithFinalArguments(final int x) {
    x=1;
}
// The final local variable x cannot be assigned. It must be blank and not using a compound assignment
```

---
# final 성능 테스트
- final을 사용할 경우 성능에 영향이 있을까?
```java
// withOutFinal
@Benchmark
@OutputTimeUnit(TimeUnit.NANOSECONDS)
@BenchmarkMode(Mode.AverageTime)
public static String concatNonFinalStrings() {
    String x = "x";
    String y = "y";
    return x + y;
}
```
```java
// withFinal
@Benchmark
@OutputTimeUnit(TimeUnit.NANOSECONDS)
@BenchmarkMode(Mode.AverageTime)
public static String concatFinalStrings() {
    final String x = "x";
    final String y = "y";
    return x + y;
}
```
- 벤치마크 결과는 다음과 같다고 한다. (이 경우 final을 사용할 때가 2.5배 더 빠르다)
```java
Benchmark                              Mode  Cnt  Score   Error  Units
BenchmarkRunner.concatFinalStrings     avgt  200  2,976 ± 0,035  ns/op
BenchmarkRunner.concatNonFinalStrings  avgt  200  7,375 ± 0,119  ns/op
```
- `final` 키워드가 컴파일러가 코드를 정적으로 최적화 하는데 도움을 준 것을 확인할 수 있다
- 해당 코드들이 생상한 바이트 코드들을 비교해 보면 다음과 같다
```java
NEW java/lang/StringBuilder
DUP
INVOKESPECIAL java/lang/StringBuilder.<init> ()V
ALOAD 0
INVOKEVIRTUAL java/lang/StringBuilder.append (Ljava/lang/String;)Ljava/lang/StringBuilder;
ALOAD 1
INVOKEVIRTUAL java/lang/StringBuilder.append (Ljava/lang/String;)Ljava/lang/StringBuilder;
INVOKEVIRTUAL java/lang/StringBuilder.toString ()Ljava/lang/String;
ARETURN
```
```java
LDC "xy"
ARETURN
```
## 주의 : 실제로 지역변수에 `final`을 추가했다고 해서 실제 성능은 큰 차이가 나지 않는다
## 결론 : 디자인 선택을 적용하기 위해 `final` 을 선택하다는 근거는 합당하다. 정말 성능 차이 때문이라기엔.. 그렇게 차이가 안난다
--

Reference
1. [The “final” Keyword in Java](https://www.baeldung.com/java-final)
2. [The Java final Keyword – Impact on Performance](https://www.baeldung.com/java-final-performance)
3. [[자바] final에 美친놈](https://lazypazy.tistory.com/281)
