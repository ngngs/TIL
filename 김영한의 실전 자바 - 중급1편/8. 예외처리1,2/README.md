# 예외처리가 필요한 이유

## 간단한 예제 만들기
- 사용자의 입력을 받고, 입력 받은 문자를 외부 서버에 전송하는 프로그램을 만들기
![image](https://github.com/ngngs/TIL/assets/47618270/06af1b06-58b4-4ce6-b34c-7dafbdd507b0)
- `NetworkClient` : 외부 서버와 연결하고, 데이터를 전송, 연결을 종료하는 기능
- `NetworkService` : `NetworkClient`를 사용해서 데이터를 전송, `NetworkClient`를 사용하려면 연결, 전송, 연결종료와 같은 복잡한 흐름을 제어해야 하는데 이런 부분을 `NetworkService`가 담당
- `Main` : 사용자의 입력 받기
- `NetworkClient` 사용 시 주의 사항 : `connect()`가 실패한 경우 `send()`를 호출하면 안된다 + 사용 후에는 반드시 `disconnect()`를 호출해서 연결을 해제해야한다
