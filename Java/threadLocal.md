# ThreadLocal이란?

`ThreadLocal<T>`은 **각 쓰레드마다 독립적인 변수를 저장**할 수 있도록 해주는 Java의 기능 즉, 여러 쓰레드가 동시에 실행될 때, **각 쓰레드가 공유하지 않고 자기만의 변수를 유지**할 수 있도록

-> threadLocal 로 인해 업무 중 발생했던 문제 : 비동기 처리 해놓은 코드가 의도하지 않게 작동. 확인해보니 값을 set해주는 부분에서 문제가 발생했음. 문제의 원인을 찾아보니 내부적으로 InheritableThreadLocal을 사용하고 있었는데 값을 set하는 부분에서 지금처럼 국가가 늘어날 곳을 고려하지 않고 코드를 짜놓은 부분을 발견
1. 자식 thread가 생성될 때 부모 thread에 존재하는 ThreadLocal 값을 상속받음
    1. childValue 메서드로 override 가능.
2. 위 사실이 최초 ThreadPool의 ThreadLocal 값을 조회했을 때 의도와 다른 값이 세팅되어있었던 이유였음

---

## 특징

1. **쓰레드별 독립적인 저장공간**  
   - 동일한 `ThreadLocal` 인스턴스를 여러 쓰레드에서 사용하더라도, 쓰레드마다 별도의 값을 저장하고 관리  
   - 즉, A 쓰레드가 저장한 값과 B 쓰레드가 저장한 값은 서로 영향을 주지 않음.

2. **쓰레드가 종료될 때까지 값이 유지됨**  
   - 특정 쓰레드에서 `ThreadLocal`에 값을 설정하면, 그 쓰레드가 종료되기 전까지는 해당 값이 유지
   - 쓰레드가 종료되면, 해당 쓰레드의 `ThreadLocal` 값도 자동으로 사라짐

3. **메모리 누수 가능성**  
   - `ThreadLocal` 변수는 **쓰레드가 종료될 때 반드시 제거.. 진짜 꼭..(`remove()`)**, 그렇지 않으면 **메모리 누수**가 발생 
   - 특히, **쓰레드 풀(Thread Pool)을 사용할 때 주의.**  
     - 쓰레드 풀에서는 쓰레드가 재사용되므로, `ThreadLocal`에 저장된 값이 예상과 다르게 유지됨

---

## 사용법

```java
public class ThreadLocalExample {
    // ThreadLocal 변수 선언
    private static ThreadLocal<Integer> threadLocalValue = new ThreadLocal<>();

    public static void main(String[] args) {
        Runnable task = () -> {
            threadLocalValue.set((int) (Math.random() * 100)); // 현재 쓰레드만의 값 설정
            System.out.println(Thread.currentThread().getName() + " - " + threadLocalValue.get());
            threadLocalValue.remove(); // 메모리 누수 방지를 위해 제거
        };

        Thread t1 = new Thread(task, "Thread-1");
        Thread t2 = new Thread(task, "Thread-2");

        t1.start();
        t2.start();
    }
}
```

### 출력 예시

```
Thread-1 - 42
Thread-2 - 85
```


---

## 활용 사례

1. **트랜잭션 관리**  
   - DB 트랜잭션 객체(Connection)를 `ThreadLocal`에 저장하여, 같은 쓰레드에서 실행되는 여러 메서드가 같은 DB 커넥션을 사용

2. **사용자 세션 정보 저장**  
   - 웹 애플리케이션에서 로그인한 사용자 정보를 `ThreadLocal`에 저장하면, 같은 요청을 처리하는 동안 사용자 정보를 가져옴

3. **로깅 (Logging) 컨텍스트 관리**  
   - 로그를 남길 때, 특정 요청과 관련된 정보를 `ThreadLocal`에 저장하고 이를 활용하여 로그에 포함

4. **Spring의 `@Transactional` 동작 원리**  
   - Spring의 `@Transactional`은 `ThreadLocal`을 이용하여 현재 트랜잭션을 관리

---

## 주의할 점

- **반드시 `remove()` 호출하기**  
  - 쓰레드가 종료될 때 `ThreadLocal` 값을 삭제하지 않으면 **메모리 누수(memory leak)**가 발생
  - 예제처럼 `finally` 블록에서 `threadLocal.remove();` 호출하는 것이 안전

- **쓰레드 풀 사용 시 주의**  
  - 쓰레드 풀에서는 같은 쓰레드가 여러 요청을 처리할 수 있기 때문에, 이전 요청의 `ThreadLocal` 값이 다음 요청에 영향을 미칠 수 있음
  - 해결 방법:  
    - **쓰레드가 끝날 때 반드시 `remove()` 호출**
    - **InheritableThreadLocal** 대신 `ThreadLocal` 사용

---


