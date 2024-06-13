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
- 인텔리제이 팁)ctrl + alt + M를 이용해 메서드화 시킬 수 있다

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


## 자바 예외 처리2 - 예외 기본 규칙
- 예외는 폭탄 돌리기다. 예외가 발생하고 처리하지 않으면 밖으로 던진다
![image](https://github.com/ngngs/TIL/assets/47618270/3d17f4b8-ef97-44e8-ab53-6e4932e58a8f)
- 예외를 처리하지 못 하면 자신을 호출한 곳까지 예외가 던져진다
![image](https://github.com/ngngs/TIL/assets/47618270/fd4d539f-bb33-4e74-a723-2e2348e87a2d)


## 자바 예외 처리3 - 체크 예외
- `Exception`과 그 하위 예외는 모두 컴파일러가 체크하는 체크 예외다(단, RuntimeException은 예외)
- 체크 예외는 처리하지 않으면 컴파일 오류가 발생한다
- `throw` : 새로운 예외를 발생시킨다. 예외도 객체이기 때문에 객체를 먼저 `new`로 생성하고 예외를 발생시킨다
- `throws` : 발생시킨 예외를 메서드 밖으로 던질 때 사용하는 키워드

### 체크 예외의 장단점
- 체크 예외는 예외를 잡아서 처리할 수 없을 때, 예외를 밖으로 던지는 `throws`를 필수로 선언해야한다
- 그렇지 않으면, 컴파일 오류가 발생한다. 이것 때문에 장점과 단점이 동시에 존재한다
- 장점 : 개발자가 실수로 예외를 누락하지 않도록 컴파일러를 통해 문제를 잡아주는 훌륭한 안전 장치(어떤 체크 예외가 발생하는 지 쉽게 파악)
- 단점 : 하지만 모든 체크 예외를 반드시 잡아야하기 때문에 매우 번고롭다. 크게 신경쓰고 싶지 않은 예외까지 모두 챙겨야한다

## 자바 예외 처리4 - 언체크 예외
- `RuntimeException`과 그 하위 예외는 언체크 예외로 분류
- 말 그대로 컴파일러가 예외를 체크하지 않는다는 뜻
- 예외를 처리해서 잡지 않아도 `throws` 키워드를 생략할 수 있다
- 컴파일러가 잡지 않아도 처리하지 않으면 밖에까지 나와서 스택 트레이스로 출력됨

### 언체크 예외의 장단점
- 언체크 예외는 예외를 잡아서 처리할 수 없을 때, 예외를 밖으로 던지는 `throws`를 생략할 수 있다
- 장점 : 신경쓰고 싶지 않은 언체크 예외를 무시할 수 있다. 체크 예외의 경우 처리할 수 없는 예외를 밖으로 던지려면 항상 `throws`를 선언해야했다
- 단점 : 개발자가 실수로 예외를 누락할 수 있다


# 예외 처리 실습

## 예외 처리 도입1 - 시작
![image](https://github.com/ngngs/TIL/assets/47618270/6fad0bb3-a556-41a1-8dcf-9eafcb6f4096)
- 기존 프로그램의 문제 : 정상 흐름과 예외 흐름이 섞여 있다. 예외 흐름이 더 많은 분량을 차지한다.
```java
public class NetworkClientExceptionV2 extends Exception {
    private String errorCode;
    public NetworkClientExceptionV2(String errorCode, String message) {
        super(message);
        this.errorCode = errorCode;
    }
}
public String getErrorCode() {
    return errorCode;
}
```

```java
 if (connectError) {
     throw new NetworkClientExceptionV2("connectError", address + " 서버 연결 실패");
    }
```
- 기존 코드와 같지만, 오류가 발생했을 때 오류 코드를 반환하는 것이 아닌 예외를 던진다
- 따라서 반환 값(return)을 사용하지 않아도 된다. 여기서는 반환 값을 `void`로 처리한다
- 이전에는 반환 값으로 성공, 실패여부를 확인해야 했지만, 예외 처리 덕분에 메서드가 정상 종료되면 성공이고, 예외가 던져지면 예외를 통해 실패를 확인할 수 있다
- 오류가 발생하면, `예외` 객체를 만들고 거기에 오류 코드와 오류 메시지를 담는다
- 예외 처리는 도입되었지만, 예외가 복구되지 않았다(예외 발생 시 프로그램 종료)

## 예외 처리 도입2 - 예외 복구
```java
package exception.ex2;
public class NetworkServiceV2_2 {
    public void sendMessage(String data) {
        String address = "http://example.com";
        NetworkClientV2 client = new NetworkClientV2(address);
        client.initError(data);
        try {
            client.connect();
        } catch (NetworkClientExceptionV2 e) {
            System.out.println("[오류] 코드: " + e.getErrorCode() + ", 메시지: " +
                    e.getMessage());
            return;
        }
        try {
            client.send(data);
        } catch (NetworkClientExceptionV2 e) {
            System.out.println("[오류] 코드: " + e.getErrorCode() + ", 메시지: " +
                    e.getMessage());
            return;
        }
        client.disconnect();
    }
}
```
- try, catch를 사용해서 예외를 잡는다
- 예외를 잡아 오류 코드와 예외 메시지를 출력한다
- 하지만, 정상 흐름과 예외 흐름이 섞여 있어서 코드를 읽기 어렵다

## 예외 처리 도입3 - 정상, 예외 흐름 분리
```java
package exception.ex2;
public class NetworkServiceV2_2 {
    public void sendMessage(String data) {
        String address = "http://example.com";
        NetworkClientV2 client = new NetworkClientV2(address);
        client.initError(data);
        try {
            client.connect();
            client.send(data);
            client.disconnect();
        } catch (NetworkClientExceptionV2 e) {
            System.out.println("[오류] 코드: " + e.getErrorCode() + ", 메시지: " + e.getMessage());
        }
    }
}
```
- try, catch 구조를 하나로 처리하여 try 안으로 정상 흐름, catch 블럭으로 예외 흐름을 처리하였다
- 사용 후에는 반드시 disconnect()를 호출해서 연결을 해제해야 한다
- 예외가 발생해도 `disconnect()`를 호출하는 방법은?

## 예외 처리 도입4 - 리소스 반환 문제
- 개발자가 생각하지 못한 예외처리가 발생했을 경우 disconnect()가 호출되지 않을 수 있다
- 반드시 실행시키고 싶다면, finally를 사용하자

## 예외 처리 도입5 - finally
```java
package exception.ex2;
public class NetworkServiceV2_2 {
    public void sendMessage(String data) {
        String address = "http://example.com";
        NetworkClientV2 client = new NetworkClientV2(address);
        client.initError(data);
        try {
            client.connect();
            client.send(data);
        } catch (NetworkClientExceptionV2 e) {
            System.out.println("[오류] 코드: " + e.getErrorCode() + ", 메시지: " + e.getMessage());
        } finally {
            client.disconnect();
        }
    }
}
```
- 자바는 어떤 경우라도 반드시 호출 되는 finally 기능을 제공한다
- try{ 정상흐름 } catch { 예외흐름 } finally { 반드시 호출부 }

## 예외 계층1 - 시작
![image](https://github.com/ngngs/TIL/assets/47618270/d24182b6-5d94-4e6f-82aa-5d7336a49a1e)
- 예외를 단순히 오류 코드로 분류하는 것이 아닌 예외를 계층화해서 다양하게 만들면 더 세밀한 예외 처리 가능
- `NetworkClientExceptionV3` : `NetworkClient`에서 발생하는 모든 예외는 예외의 자식
- `ConnectExceptionV3` : 연결 실패 시 발생하는 예외. 내부 연결을 시도한 `address`를 보관
- `SendExcpetionV3` : 전송 실패 시 발생하는 예외. 내부 전송을 시도한 데이터인 `sendData`를 보관

### 예외 계층화 시 장점
- 자바에서 예외는 객체기 때문에 부모 예외를 잡거나 던지면, 자식 예외도 함께 잡거나 던질 수 있다
- 예를 들어 `NetworkClientExceptionV3`를 잡으면 그 하위 예외도 함께 잡는다
- 반대로 세밀하게 예외 처리하고 싶다면 ConnectExceptionV3를 잡아서 처리할 수 있다
- (인텔리제이팁) Add 'catch' clause(s) 를 사용하면 선언한 예외처리들이 모두 출력된다
```java
package exception.ex2;
public class NetworkServiceV2_2 {
    public void sendMessage(String data) {
        String address = "http://example.com";
        NetworkClientV2 client = new NetworkClientV2(address);
        client.initError(data);
        try {
            client.connect();
            client.send(data);
        } catch (ConnectExceptionV3 e) {
            System.out.println("[연결 오류] 주소: " + e.getAddress() + ", 메시지: " + e.getMessage());
        } catch (SendExceptionV3 e) {
            System.out.println("[전송 오류] 전송 데이터: " + e.getSendData() + ", 메시지: " + e.getMessage());
        } finally{
            client.disconnect();   
        }
    }
}
```

## 예외 계층2 - 활용
- `NetworkClientExceptionV3`에서 수 많은 예외가 발생한다고 가정해보자
- 모든 예외를 잡아서 처리하는 것은 상당히 번거롭다
- 그래서 다음과 같이 예외를 처리해보자
- 연결 오류, 나머지 예외, 알 수 없는 오류로 나누어 출력한다
```java
package exception.ex2;
public class NetworkServiceV2_2 {
    public void sendMessage(String data) {
        String address = "http://example.com";
        NetworkClientV2 client = new NetworkClientV2(address);
        client.initError(data);
        try {
            client.connect();
            client.send(data);
        } catch (ConnectExceptionV3 e) {
            System.out.println("[연결 오류] 주소: " + e.getAddress() + ", 메시지: " + e.getMessage());
        } catch (NetworkClientExceptionV3 e) {
            System.out.println("[네트워크 오류] 메시지 : "  + e.getMessage());
        } catch (Excpetion e) {
            System.out.println("알 수 없는 오류 : " + e.getMessage());
        } finally{
            client.disconnect();   
        }
    }
}
```
- 주의사항 : `catch`는 순서대로 실행되므로, 디테일한 자식들을 먼저 잡아주어야한다. (그렇지 않으면 잡히지 않음)

## 실무 예외 처리방안1 - 설명
- `언체크 예외` : 상대 네트워크 서버 문제가 발생하거나, 통신이 불가능 한 경우 등 예외가 발생한다
- 이렇게 시스템 오류 때문에 발생한 예외들은 예외를 잡아도 해결할 수 없다
- 예외를 잡아서 호출해도 다시 오류에 빠진다
- 이런 경우 고객에게는 "현재 시스템 문제가 있습니다" 오류 메시지를 보여주고, 웹이라면 오류 페이지를 보여주면 된다
- 내부 개발자에게는 문제상황을 빠르게 인지할 수 있도록 오류에 대한 로그를 남겨야한다
<br>
- `체크 예외의 부담` : 처리할 수 없는 예외가 많아지고, 프로그램이 복잡해지면서 체크 예외를 사용하기 점점 부담스러워진다

### 체크 예외 사용 시나리오
![image](https://github.com/ngngs/TIL/assets/47618270/4e91f1b9-37d6-41e5-ba4b-ceec9dcd4a1f)
- 서비스는 예외 처리 지옥이 된다
```java
 class Service {
     void sendMessage(String data) throws NetworkException, DatabaseException, ...{
        ...
    }
 }
```
- 결국 개발자는 `throw`s Exception`이라는 최악의 수를 둔다
- 이렇게 되면 치명적인 문제가 있다. Exceptiond은 최상위 타입이므로 모든 체크 예외를 다 밖으로 던지는 문제가 발생한다
- 반드시 체크해야하는 중요한 체크 예외를 다놓치게 된다

### 언체크 예외 사용 시나리오
![image](https://github.com/ngngs/TIL/assets/47618270/18b228e3-a964-40a2-994a-1a1580dc0c11)
- 언체크 예외이므로 `throw`를 선언하지 않아도 된다
- Service에서는 어차피 본인이 처리할 수 없는 예외들이므로 밖으로 던지는 것이 더 나은 결정이다
- 예외 공통 처리 : 처리할 수 없는 에러는 어차피 서비스가 처리할 수 없다. 로그를 남기거나 오류 페이지를 보여주는 방식이 좋다

## 실무 예외 처리방안2 - 구현
- 실습한 내용을 언체크 예외로 만들고, 해결할 수 없는 예외들을 공통으로 처리하자
![image](https://github.com/ngngs/TIL/assets/47618270/87f2a259-5af0-465f-bf08-c4f669be287c)
```java
package exception.ex4;
public class NetworkServiceV4 {
    public void sendMessage(String data) {
        String address = "https://example.com";
        NetworkClientV4 client = new NetworkClientV4(address);
        client.initError(data);
        try {
            client.connect();
            client.send(data);
        }
        finally {
            client.disconnect();
        }
    }
}
```
- 발생한 예외들을 잡아도 해당 오류들을 복구할 수 없으므로 예외를 밖으로 던진다
- 언체크 예외이므로 `throws`를 사용하지 않는다
- 해결할 수 없는 예외들을 다른 곳에서 공통으로 처리한다
![image](https://github.com/ngngs/TIL/assets/47618270/8f1584cc-c7e6-4a6a-a1e1-67b264e2151f)

```java
package exception.ex4;
import exception.ex4.exception.SendExceptionV4;
import java.util.Scanner;

public class MainV4 {
    public static void main(String[] args) {
        NetworkServiceV4 networkService = new NetworkServiceV4();
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.print("전송할 문자: ");
            String input = scanner.nextLine();
            if (input.equals("exit")) {
                break;
            }
            try {
                networkService.sendMessage(input);
            } catch (Exception e) { // 모든 예외를 잡아서 처리
                exceptionHandler(e);
            }
            System.out.println();
        }
        System.out.println("프로그램을 정상 종료합니다.");
    }
    //공통 예외 처리
    private static void exceptionHandler(Exception e) {
        //공통 처리
        System.out.println("사용자 메시지: 죄송합니다. 알 수 없는 문제가 발생했습니다.");
        System.out.println("==개발자용 디버깅 메시지==");
        e.printStackTrace(System.out); // 스택 트레이스 출력

        //필요하면 예외 별로 별도의 추가 처리 가능
        if (e instanceof SendExceptionV4 sendEx) {
            System.out.println("[전송 오류] 전송 데이터: " + sendEx.getSendData());
        }
    }
}
```
- exceptionHandler() : 해결할 수 없는 예외가 발생하면 사용자에게는 디테일한 오류 코드나 오류 상황까지 알려줄 필요가 없다
- 개발자는 빨리 문제를 찾고 디버깅가능하도록 오류 메시지를 남겨야한다
- 예외도 객체이므로 필요하면 `instanceof`와 같이 예외 객체 타입을 확인해서 별도의 추가 처리를 할 수 있다
