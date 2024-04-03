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
##
