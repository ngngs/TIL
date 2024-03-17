# 스프링 컨테이너 생성

## 생성 과정
```java
// 스프링 컨테이너 생성
ApplicationContext applicationContext = new AnnotationConfigApplicationContext(AppConfig.class);
```

- (1) `ApplicationContext`를 스프링 컨테이너라고 한다
- (2) `ApplicationContext`는 인터페이스다
- 스프링 컨테이너는 XML로 만들 수도 있고, 애노테이션 기반 자바 설정 클래스로 만들 수 있다(요즘 트렌드는 애노테이션 기반)

![image](https://github.com/ngngs/TIL/assets/47618270/cd87e275-3706-4c27-bbfc-be7ab8ece08e)
![image](https://github.com/ngngs/TIL/assets/47618270/bf7825a6-77ff-4c38-a8e9-1a176363c6b9)
![image](https://github.com/ngngs/TIL/assets/47618270/db86a9e1-93cb-47b3-945c-c08d895434d9)

- (3) 스프링은 [1]빈을 생성하는 단계 [2]의존관계를 주입하는 단계가 나누어져 있다.
- (4) 만약, 자바 코드로 스프링 빈을 등록하면 생성자를 호출하면서 의존관계 주입도 한 번에 처리된다.
