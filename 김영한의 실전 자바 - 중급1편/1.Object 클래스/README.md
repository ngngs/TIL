# Object 클래스란?
## java.lang 패키지 소개
- `Object` : 모든 자바 객체 부모 클래스
- `String`
- `Integer`, `Long`, `Double` : 래퍼 타입
- `Class` : 클래스 메타 정보
- `System` : 시스템과 관련된 기본 기능

## import 생략 가능
- `java.lang` 패키지는 모든 자바 애플리케이션에 자동으로 임포트(`import`)된다
```java
    public static void main(String[] args) {
        System.out.println("hello java"); // System은 임포트 안해도 작동한다
    }
```

## Object 클래스
- 부모 클래스가 없으면 묵시적으로 `Object`클래스를 상속 받는다
![image](https://github.com/ngngs/TIL/assets/47618270/cbede877-636b-409b-8b07-9c53b2d60dd1)

### 자바에서 모든 클래스가 Object 클래스를 상속받게 만든 이유?
- `공통 기능 제공` : 모든 객체에게 필요한 공통 기능(객체 간 비교, 객체 구성 확인 등)을 제공
- 대표적으로, `toString()`, `equals()`, `getClass()` 등이 있다
- `다형성의 기본 구형` : 부모는 자식을 담는다. Object는 모든 클래스의 부모 클래스이므로 모든 객체를 참조할 수 있다
- 다양한 타입의 객체를 통합적으로 처리할 수 있게 한다.

------

# Object 다형성
- `Object`는 모든 타입의 부모. 부모는 자식을 담을 수 있다
- 어떤 객체든지 인자로 전달할 수 있다

## Object 다형성의 한계
```java
action(dog)
private static void action(Object obj){
    obj.sound(); // 컴파일 오류 발생! Object는 sound()가 없다
}
```
![image](https://github.com/ngngs/TIL/assets/47618270/cb08d5c1-322c-41ee-8d7e-a6cc2371538f)

- Dog 인스턴스의 sound()를 호출하려면 다운캐스팅을 해야 한다
```java
if (obj instance of Dog dog){
    dog.sound();
}
```

----

## Object 배열
- Object는 자바에 존재하는 모든 객체를 담을 수 있는 배열을 만들 수 있다
- size() 메서드 : Object 타입에만 사용한다


## toString()
- `Object.toString()` 메서드는 객체의 정보를 문자열 형태로 제공한다
- 디버깅과 로깅에 사용한다
- 이 메서드는 Object 클래스에 정의되므로 모든 클래스에서 상속받아 사용가능하다

```java
public static void main(String[] args){
    Object object = new Object();
    String string = object.toString();

    //toString() 반환값 출력
    System.out.println(string);    // java.lang.Object@b4c966a

    //object 직접 출력
    System.out.println(object);    // java.lang.Object@b4c966a

}
```
- 결과값이 동일한 이유가 뭘까?
- `toString()`을 보면, 패키지를 포함한 객체의 이름과 객체의 참조값(해시코드)를 16진수로 제공한다
- `System.out.println()`은 사실 내부적으로 `toString()`을 호출하기 때문
- 결론 : 굳이 toString()을 사용하지 않고 object만 전달해도 출력이 된다!

## toString()을 유용하게 사용하기
- toString()은 클래스 정보와 참조값만 제공하기 때문에 객체의 정보를 더 알기 어렵다
- 보통 오버라이딩을 해서 유용한 정보를 제공하게 한다
- getter and setter 처럼 toString()도 IDE가 만들어줌
```java
@Override
public String toString(){
    return "dogName = " + dog + "/" + "age = " + age;
}
```
- 만약, 오버라이딩을 해서 참조값을 알 수 없는 상황이라면, 다음을 사용하면 된다
```java
String refValue = Integer.toHexString(System.identityHashCode(dog1));
System.out.println("refValue = " + refValue);
```

------
# Object와 OCP

## 구체적인 것에 의존
- Object는 구체적인 타입(Car, Dog)을 사용한다
- 구체적인 클래스가 10개로 늘어나면 메서드도 10개로 늘어난다
- 이렇게 클래스가 구체적인 특정 클래스를 사용하는 것을 `의존한다`고 표현한다

## 추상적인 것에 의존
- ObjectPrinter 클래스는 Car, Dog와 같은 구체적인 클래스를 사용하지 않는다
- 추상적인 `Object` 클래스를 사용하며, 이를 추상적인 것에 의존한다고 표현한다
- 여기서, `추상`은 조금 더 상위 개념의 느낌?을 의미하는 것 같음
![image](https://github.com/ngngs/TIL/assets/47618270/2579e873-ba20-4487-918a-1cc813a2c504)


-----

## System.out.println()
- sout 메서드도 Object 매개변수를 사용하고 내부에서 toString()을 호출한다
- 따라서 sout을 사용하면, 세상의 모든 객체의 정보를 편리하게 출력할 수 있다

-----

## equals() - 1.동일성과 동등성
- 자바에서 두 객체가 같다는 표현은 2가지로 분리한다
- (1) 동일성(Identity) : `==` 연산자를 사용해서 두 객체의 참조가 동일한 객체를 가리키고 있는지 확인
- (2) 동등성(Equality) : `equals()` 메서드를 사용하여 두 객체가 논리적으로 동등한지 확인
