# 시작하며,

- 클린 코드와 관련된 도서들이 많고, 블로그에 [글](https://velog.io/@ngngs/%EC%B1%85%EB%84%88%EB%91%90-5%EA%B8%B0-%ED%81%B4%EB%A6%B0%EC%BD%94%EB%93%9C)도 남겨가며 정리했지만 실제로 업무 중 모든 코드에 적용하기란 어려웠다
- 그럼에도, 프로젝트가 점점 커지는 걸 생각하면 클린코드의 중요성은 항상 강조된다
![image](https://github.com/user-attachments/assets/e33375fd-1c40-4056-aae5-2a5d55f635dc)
- 프로그래밍 원칙과 관련해서 많은 원칙들이 있지만 그 중에서 좋아하는 원칙은 `개발자를 놀라게 하지 말자`, `보이스카웃 규칙`
- 업무 중 마주했던 나를 놀래켰던 코드들과 그 코드들을 떠나기 전에 어떻게 리팩토링하기 위해 노력했는지 정리해보았다

---

# 1. 다른 개발자들을 놀래키지 말자
- 새로운 코드를 마주했을 때, 대부분의 개발자는 다음의 감정을 느낀다
- 두려움, 흥분, 놀라움, 분노, 그리고 `좌절`
- 흔히 *레거시 코드* 라 부르는 코드는 아무도 건드리고 싶지도 않고 모두가 두려워한다
- 시간이 지나면서 비즈니스 로직은 계속 변화하고, 요구 사항이 바뀌며 (절대 그런 값은 안 들어온다며 당부했던 부분들이 바뀌면 더더욱) 변경 가능성을 고려했던 코드였음에도 도저히 읽기 어려운 `서비스 코드`들을 마주한다
- 다행히도 우리 회사만의 문제는 아니었고 정말 대다수의 개발자들이 엉망이 되는 코드들을 마주한다고 한다 (다행인가?)

## 1-1. 복잡한 서비스 코드
- 내가 만났던 복잡한 서비스 코드 중 하나는 if, else-if 코드였다
- 예시 상황을 만들기 위해, 우리는 메시지를 전송하는 서비스를 만들고 있다고 하자
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
