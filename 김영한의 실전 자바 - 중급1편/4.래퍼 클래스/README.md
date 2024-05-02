# 래퍼클래스

## 기본형의 한계
- 자바는 객체 지향 언어
- int, double 같은 기본형(Primitive Type)은 객체가 아니기 때문에 한계가 있다
- 객체가 아니기 때문에 메서드를 제공할 수 없고, null값을 가질 수 없다
- 만약 객체라면, 객체 스스로 자신을 다른 값과 비교하는 등의 메서드를 만들 수 있다


## 직접 만든 래퍼 클래스
- int를 클래스로 만들어보자
- 특정 기본형을 감싸서(Wrap) 만드는 클래스를 `Wrapper` 클래스 라고 한다
- compareTo()를 메서드를 내부로 캡슐화

```java
public class MyInteger{

    private final int value;

    public MyInteger(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }

    public int compareTo(int target){
        if (value < target){
            return -1;
        } else if (value > target){
            return 1;
        } else {
            return 0;
        }
    }
}
```

## 기본형과 null
- 기본형은 항상 값을 갖지만, 때로는 데이터 `없음`을 표현해야 한다
- findValue()는 배열에 찾는 값이 있으면 해당 값을 반환하고, 없으면 -1을 반환한다
- 결과로 int를 반환하는데 int와 같은 기본형은 항상 값이 있어야 한다
- 여기서도 값을 반환할 때 값을 찾지 못하면 숫자를 반환 시켜야하고 보통 -1 또는 0을 사용한다
- 
```java
    public static void main(String[] args) {
        int[] intArr = {-1, 0, 1, 2, 3};
        System.out.println(findValue(intArr, -1));
        System.out.println(findValue(intArr, 0));
        System.out.println(findValue(intArr, 1));
        System.out.println(findValue(intArr, 100)); // -1
        
    }

    private static int findValue(int[] intArr, int target){
        for(int value : intArr){
            if(value == target){
                return value;
            }
        }
        return -1;
    }
```

- -1을 찾더라도 -1이 출력되고, 값이 없어도 -1이 출력되는 문제가 있다
- 이를 해결하기 위해, findValue()를 수정해보자
- `null`을 반환할 때는 NPE를 조심해야한다
- 기본형이 값을 무조건 갖는 건 좋은 제약일 수 있지만, 필요에 따라 값이 없다는 걸 표현할 필요가 있다
```java
    private static MyInteger findValue(MyInteger[] intArr, int target){
        for(MyInteger myInteger : intArr){
            if(myInteger.getValue() == target){
                return myInteger;
            }
        }
        return null;
    }
```

## 자바 래퍼 클래스
- 자바는 기본형에 대응하는 래퍼 클래스를 기본적으로 제공한다
- 래퍼 클래스의 특징 : `불변`, `equals`로 비교해야 한다
```java
Integer newInteger = new Integer(10);
Integer integerObj = Integer.valueOf(10); // -128 ~ 127은 자바가 미리 만들어놓은 걸 재사용하기 때문에 훨씬 효율적(마치 StringPool)
System.out.println(newInteger); // newInteger도 객체로 toString()을 Override하고 있기 때문에 출력됨
int intValue = integerObj.intValue(); // 원하는 값을 꺼낼 수 있음

// equals를 사용해야 하는 이유
System.out.println(newInteger == integerObj); // false(주소가 다르기 때문)
System.out.println(newInteger.equals(integerObj)); // true(내부 값으로 비교함)

```
- 기본형을 래퍼 클래스로 변경하는 것을 `박싱(Boxing)`이라고 한다
- 래퍼 클래스에 들어있는 기본형 값을 꺼내는 것을 `언박싱(Unboxing)`이라고 한다

## 오토 박싱
- 기본형과 래퍼 클래스간의 박싱/언박싱이 번거로워 오토 박싱/언박싱을 지원한다
- 컴파일러가 개발자 대신 valueOf, xxxValue() 등 코드를 추가해주는 기능
```java
int value = 7;
Integer boxedValue = value; // 오토 박싱

int unboxedValue = boxedValue; // 오토 언박싱
```

## 래퍼 클래스와 성능
- 기본형을 제공하는 이유는 뭘까? -> 성능이 5배 차이가 난다는데..
- 기본형은 메모리에서 단순히 그 크기만큼의 공간을 차지
- 예를 들어 `int`는 4바이트 메모리만 차지한다
- CPU 연산을 아주 많이 수행하는 특수한 경우나 수많은 횟수로 연속해서 연산을 수행해야하는 경우라면 기본형을 사용하자
- (질문) 왜 난느 차이가 안 나지..?
```java
public class scratch{

    public static void main(String[] args) {
        int iterations = 1_000_000_000; // 반복횟수 10억
        long startTime, endTime;

        // 기본형 long
        long sumPrimitive = 0;
        startTime = System.currentTimeMillis();
        for (int i = 0; i< iterations; i++){
            sumPrimitive += i;
        }
        endTime = System.currentTimeMillis();
        System.out.println(sumPrimitive);
        System.out.println(endTime - startTime + "ms"); // 497ms

        // 래퍼 클래스 Long
        Long sumWrapper = 0L;
        startTime = System.currentTimeMillis();
        for (int i = 0; i< iterations; i++){
            sumWrapper += i;
        }
        endTime = System.currentTimeMillis();
        System.out.println(sumWrapper);
        System.out.println(endTime - startTime + "ms"); // 486ms
    }
}
```

### 유지보수 VS 최적화
- 유지보수가 좋은 코드를 우선으로
- 연산을 몇 번 줄인다고 해도 큰 도움 안된다
- 성능최적화는 단순함보다 복잡함을 요구한다
- 최적화가 정말 최적화일까? 애플리케이션 성능 관점에서 불필요한 최적화일 수 있다
- 자바로 짤 바에 어셈블리로 짤 거 아니면..
- 웹 어플리케이션의 경우, 메모리 안에서 발생하는 연산보다 네트워크 호출 한 번이 많게는 수삽만배 더 오래 걸린다
- 네트워크 호출을 한 번이라도 더 줄이도록 해보자
- 권장 방법 : 개발 이후 성능테스트를 하고 정말 문제가 되는 부분을 찾아서 최적화하자

## Class 클래스
- `Class` 클래스는 클래스의 정보를 다룬다
- (1) 타입 정보 얻기 : 클래스 이름, 슈퍼클래스, 인터페이스 등과 같은 정보 조회
- (2) 리플렉션 : 클래스에 정의된 메소드, 필드, 생성자를 조회하고 이들을 통해 객체 인스턴스를 생성하거나 메서드를 호출하는 등의 작업
- (3) 동적 로딩과 생성 : `Class.forName()` 메서드를 사용해서 클래스를 동적으로 로드하고, newInstance() 메서드를 통해 새로운 인스턴스를 생성
- (4) 애노테이션 처리 : 클래스에 적용된 애노테이션을 조회하고 처리
```java
Class clazz = String.class // 1. 클래스에서 조회 (변수명 `class`는 예약어기 때문에 할수 없다)
Class clazz1 = new String().getClass(); // 2. 인스턴스에서 조회
Class clazz2 = Class.forName("java.lang.String"); // 3. 문자열로 조회

// 모든 필드 
Field[] fields = clazz.getDeclareFields();

// 모든 메서드
Method[] methods = clazz.getDeclareMethods();
```

### 리플렉션?
- 클래스를 사용하면 메타 정보를 기반으로 클래스에 정의된 메소드, 필드, 생성자 등을 조회
- 객체 인스턴스를 생성하거나 메소드를 호출하는 작업을 `리플렉션`이라고 한다

## System 클래스
```java
System.out.println("getenv= " + System.getenv()); // 환경 변수 읽기
System.out.println("properties = " + System.getProperties()); // 자바 시스템 속성
```
