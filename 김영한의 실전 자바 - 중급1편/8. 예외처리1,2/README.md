# 예외처리가 필요한 이유

## 간단한 예제 만들기
- 사용자의 입력을 받고, 입력 받은 문자를 외부 서버에 전송하는 프로그램을 만들기
![image](https://github.com/ngngs/TIL/assets/47618270/06af1b06-58b4-4ce6-b34c-7dafbdd507b0)
- `NetworkClient` : 외부 서버와 연결하고, 데이터를 전송, 연결을 종료하는 기능
- `NetworkService` : `NetworkClient`를 사용해서 데이터를 전송, `NetworkClient`를 사용하려면 연결, 전송, 연결종료와 같은 복잡한 흐름을 제어해야 하는데 이런 부분을 `NetworkService`가 담당
- `Main` : 사용자의 입력 받기
- `NetworkClient` 사용 시 주의 사항 : `connect()`가 실패한 경우 `send()`를 호출하면 안된다 + 사용 후에는 반드시 `disconnect()`를 호출해서 연결을 해제해야한다

## 오류 상황 만들기
- 외부서버와 통신 시 다양한 문제 발생 : 연결 실패, 데이터 전송 실패 등
- 연결 실패 : 사용자가 입력한 문자에 "error1"이 있으면 연결 실패 (오류 코드 : connectError)
- 전송 실패 : 사용자가 입력한 문자에 "error2"가 있으면 데이터 전송 실패 (오류 코드 : sendError)

## 반환 값으로 예외 처리
- `connect()`가 실패 시 `send`를 호출하면 안된다
- `disconnect()`를 호출해서 연결을 해제해야 한다
- 연결을 성공한 이후에, 에러가 발생하면 연결을 종료해야 한다
- 인텔리제이 팁)ctrl + alt + T를 이용해 메서드화 시킬 수 있다

### 자바의 경우 GC가 존재하며, JVM 메모리에 있는 인스턴스는 자동으로 해제한다
- 하지만! 외부 연결과 같은 자바 외부의 자원은 자동으로 해제가 되지 않는다
- 즉, 외부 자원을 사용한 후에는 연결을 해제해서 외부 자원을 반드시 반납해야한다
- 이런 걸 잘 안 해주면, 일주일마다 서버를 껐다 켜야한다

## disconnect()를 반드시 호출하기
```java
public class NetworkServiceV1_3 {
    public void sendMessage(String data) {
        NetworkClientV1 client = new NetworkClientV1("http://example.com");
        client.initError(data);
        String connectResult = client.connect();
        if (isError(connectResult)) {
            System.out.println("[네트워크 오류 발생] 오류 코드: " + connectResult);
        }
        else {
            String sendResult = client.send(data);
            if (isError(sendResult)) {
                System.out.println("[네트워크 오류 발생] 오류 코드: " + sendResult);
            }
        }
        client.disconnect();
    }
    private static boolean isError(String resultCode) {
        return !resultCode.equals("success");
    }
}
```
- `return`문을 제거하고 if문을 사용하기
- connect()를 성공해서 오류가 없는 경우에만 `send()`를 호출하도록 설계

## 정상 흐름과 예외 흐름
- 하지만, 이 코드는 정상 흐름과 예외 흐름이 분리되어 있지 않다
- 어떤 부분이 정상 흐름이고 어떤 부분이 예외 흐름인지 이해하기 어렵다
- 실제로 예외 흐름을 처리하는 부분이 더 길다
- 실무에서는 예외 처리가 훨씬 더 복잡해진다
- 이런 문제를 해결하는 `예외 처리 매커니즘`이 존재한다

## 자바 예외 처리1 - 예외 계층
- 자바는 예외 처리 매커니즘을 존재한다
- 자바 예외 처리 : `try`, `catch`, `finally`, `throw`, `throws`
- 예외 계층 그림은 다음과 같다
![image](https://github.com/ngngs/TIL/assets/47618270/55951935-af82-412b-92ff-9f46537b278d)
- Object : 자바에서 기본형을 제외한 모든 것은 객체다. 예외도 객체다. 모든 객체의 최상위 부모는 `Object`이므로 예외의 최상위부모도 `Object`다
- `Throwable` : 최상위 예외이다. 하위에 `Exception`과 `Error`가 있다
- `Error` : 메모리 부족이나 심각한 시스템 오류와 같이 애플리케이션이 복구 불가능한 시스템 예외. 애플리케이션 개발자는 이 예외를 잡으려 해서는 안된다
- `Exception` : 체크 예외 (애플리케이션 로직에서 사용가능한 실질적 최상위 예외, 컴파일러가 체크하는 체크 예외)
- `RuntimeException` : 언체크 예외, 런타임 예외(컴파일러가 체크하지 않는 예외)

### 컴파일러가 체크하는 예외?
- 페크 예외는 발생한 예외를 반드시 개발자가 명시적으로 처리해야한다. (그렇지 않으면 컴파일 오류)
- 언체크 예외는 개발자가 발생한 예외를 명시적으로 처리하지 않아도 된다

### 개발자가 Throwable 예외를 잡으면 안되는 이유
- ?
