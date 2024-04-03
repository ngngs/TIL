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
