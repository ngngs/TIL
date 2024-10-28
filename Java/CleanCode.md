# 시작하며,

- 클린 코드와 관련된 도서들이 많고, 블로그에 [글](https://velog.io/@ngngs/%EC%B1%85%EB%84%88%EB%91%90-5%EA%B8%B0-%ED%81%B4%EB%A6%B0%EC%BD%94%EB%93%9C)도 남겨가며 정리했지만 실제로 업무 중 모든 코드에 적용하기란 어려웠다
- 그럼에도, 프로젝트가 점점 커지는 걸 생각하면 클린코드의 중요성은 항상 강조된다
![image](https://github.com/user-attachments/assets/e33375fd-1c40-4056-aae5-2a5d55f635dc)
- 프로그래밍 원칙과 관련해서 많은 원칙들이 있지만 그 중에서 좋아하는 원칙은 `개발자를 놀라게 하지 말자`, `보이스카웃 규칙`
- 업무 중 마주했던 나를 놀래켰던 코드들과 그 코드들을 떠나기 전에 어떻게 리팩토링하기 위해 노력했는지 정리해보았다

---

# 우리가 마주하는 코드는
- 새로운 코드를 마주했을 때, 대부분의 개발자는 다음의 감정을 느낀다
- 두려움, 흥분, 놀라움, 분노, 그리고 `좌절`
- 흔히 *레거시 코드* 라 부르는 코드는 아무도 건드리고 싶지 않고 모두가 두려워한다
- 시간이 지나면서 비즈니스 로직은 계속 변화하고, 요구 사항은 바뀐다
- (절대 그런 값은 안 들어온다며 당부했던 부분들이 바뀌면) 변경 가능성을 고려했던 코드였음에도 도저히 읽기 어려운 `서비스 코드`들을 마주한다
- 다행히도 우리 회사만의 문제는 아니었고 정말 대다수의 개발자들이 엉망이 되는 코드들을 마주한다고 한다 (다행인가?)

## 적절하지 않은 메서드명
- 다음 서비스의 메서드를 보고 우리는 무엇을 하려는 지 예측할 수 없어 코드를 처음부터 끝까지 읽어봐야 한다
- 심지어, 해당 메서드가 메서드명과 다른 역할을 수행한다면 혼란에 빠질 수 밖에 없다
```java
public class SendService {

    public void sendSms(String msg) {
        // SMS를 보내는 것처럼 보이지만 실제로는 파일에 로그를 저장
        saveLogToFile("SMS message logged: " + msg);
    }

    private void saveLogToFile(String log) {
        // 파일에 로그를 저장하는 메서드
        System.out.println("Saving log to file: " + log);
    }
}
```
- 해당 메서드들은 코드가 짧아 적절한 메서드명으로 변경할 수 있었지만, 만약 해당 서비스를 Call하는 부분이 많다면 모두 찾아줘야 하기 때문에 쉽지 않다는 걸 깨달았다..
```java
public class SendService {

    // SMS 메시지를 파일에 기록하는 메서드
    public void logSmsMessage(String msg) {
        saveLogToFile("SMS message logged: " + msg);
    }

    private void saveLogToFile(String log) {
        // 파일에 로그를 저장하는 메서드
        System.out.println("Saving log to file: " + log);
    }
}

```
## 복잡한 서비스 코드(if, else-if)
- 내가 만났던 복잡한 서비스 코드 중 하나는 if, else-if 코드였다
- 우리는 메시지를 전송하는 서비스를 만들고 있다고 가정하자
- 메시지 전송 서비스는 `긴급발송`과 `일반발송` 두 가지 기능이 있다
```java
public class SendService {

    public void send(String msg, String type, String sendType) {
        // 긴급 발송
        if (Constants.SENDTYPE.URGENT.equals(sendType) {
            if (Constants.TYPE.EMAIL.equals(type)) {
                // 로직 쭉..
                System.out.println("Sending urgent email with message: " + msg);
            } else if (Constants.TYPE.SMS.equals(type)) {
                // 로직 쭉..
                System.out.println("Sending urgent SMS with message: " + msg);
            } else if (Constants.TYPE.NOTIFICATION.equals(type)) {
                // 로직 쭉..
                System.out.println("Sending urgent notification with message: " + msg);
            } else {
                System.out.println("Unknown type for urgent message.");
            }
        }
        
        // 일반 발송
        else {
           ...
        }
    }
}

```
- 1. 상수들을 IMPORT를 통해 가독성을 높혀주었다
- 2. 모듈화를 통해, 코드의 가독성을 높혀주었다
```java
import static Constants.SENDTYPE.*;
import static Constants.TYPE.*;

public class SendService {

    public void send(String msg, String type, String sendType) {
        if (URGENT.equals(sendType)) {
            sendUrgentMessage(msg, type);
        } else {
            sendGeneralMessage(msg, type);
        }
    }

    private void sendUrgentMessage(String msg, String type) {
        if (EMAIL.equals(type)) {
            sendUrgentEmail(msg);
        } else if (SMS.equals(type)) {
            sendUrgentSms(msg);
        } else if (NOTIFICATION.equals(type)) {
            sendUrgentNotification(msg);
        } else {
            System.out.println("Unknown type for urgent message.");
        }
    }
}

```
