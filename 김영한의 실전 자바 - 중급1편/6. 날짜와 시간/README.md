## 날짜와 시간 라이브러리가 필요한 이유?

### 1. 날짜와 시간 차이 계산
- 특정 날짜에서 다른 날짜까지의 정확한 일수를 계산하는 것은 생각보다 복잡하다
- `윤년`, `각 달의 일수` 등을 모두 고려해야 한다
- 예시) 2024년 1월 1일 2024년 2월 1일까지는 며칠일까?

### 2. 윤년 계산
- 4년마다 하루(2월 29일)를 추가하는 윤년(leap year)이 존재한다
- 2월은 보통 28일까지 있지만, 윤년은 2월이 29일까지 존재한다

### 3. 일광 절약 시간(Daylight Saving Time, DST) 변환
- 일광 절약 시간제(썸머타임) : 태양이 상대적으로 늦게 뜨는 것에 맞춰 1시간 앞당기거나 늦추는 제도
- 썸머타임은 적용 여부와 시작 및 종료 날짜가 다르다
- 참고로, 대한민국은 1988년 이후로 시행하지 않는다

### 4. 타임존 계산
- 세계는 다양한 타임존으로 나뉘어져있다
- 각 타임존은 UTC(협정 세계시)로부터의 시간 차이로 정의된다
- 타임존 간의 날짜와 시간 변환을 정확히 계산하는 것은 복잡하다
- 예시) 서울에 있는 사람이 독일 베를린에 있는 사람과 미팅을 계획한다. 서울의 타임존은 Asia/Seoul, UTC+9에 위치해 있고, 베를린의 타임존은 Europe/Berlin, UTC+1에 위치한다. 서울에서 오후 9:00에 미팅을 하려면 베를린은 몇 시인가?

 ## 자바 날짜와 시간 라이브러리의 역사
 - `Joda-time` : 표준 라이브러리가 아님, 외부 라이브러리로 프로젝트에 별도로 추가해야 했다
 - 자바8에서 java.time패키지(JSR_310)를 표준 API로 도입

## JDK8(java.time 패키지 등장)
- Joda-time의 많은 기능을 표준 자바 플랫폼으로 가져왔다
- `LocalDate`, `LocalTime`, `LocalDateTime` 등 클래스를 포함한다

### 참고
- 자바가 표준으로 제공했던 Date, Calendar는 사용성이 너무 떨어졌다
- 결국, Joda-Time을 만든 개발자를 데려와서 `java.time` 이라는 새로운 자바 표준 날짜와 시간 라이브러리를 정의한다
- 자바 표준 ORM 기술인 JPA도 비슷한 역사를 갖는다
- 과거 자바 표준인 ORM이 너무 불편해서 누군가 하이버네이트라는 ORM 오픈 소스를 만들었고, 이 개발자를 데려와서 현재 자바 ORM 기술 표준인 JPA 를 만들었다

## 자바 날짜와 시간 라이브러리 소개
![image](https://github.com/ngngs/TIL/assets/47618270/5b5f7a78-5c48-4dfa-90ac-571ee50dfe92)
- `*` : 초는 나노초 단위의 정밀도로 캡처된다(밀리초, 나노초 가능)
- `**` : 이 클래스는 정보를 저장하지 않지만 이러한 단위로 시간을 제공하는 메서드가 있다
- `***` : ZonedDateTime에 Period를 추가하면 서머타임 또는 기타 현지 시간 차이를 준수한다

 
## LocalDate, LocalTime, LocalDateTime
- LocalDate : 날짜만 표현할 때 사용(년, 월, 일)
- LocalTime : 시간만 표현할 때 사용(시, 분, 초)
- LocalDateTime : LocalDate와 LocalTime을 합한 개념

### Local이 붙는 이유는 타임존이 적용되지 않기 때문!!!

## ZonedDateTime, OffsetDateTime
- ZonedDateTime : 시간대를 고려한 날짜와 시간을 표현할 때 사용, 여기에는 시간대를 표현하는 타임존이 포함
- OffsetDateTime : 시간대를 고려한 날짜와 시간, 여기에는 타임존은 없고, UTC로부터의 시간대 차이인 고정된 오프셋만 포함


## 기본 날짜와 시간 - LocalDateTime
- 국내 애플리케이션 개발 시 사용
- 모든 날짜 클래스는 `불변`이다. 변경이 발생할 경우 반드시 새로운 객체를 생성해서 반환값을 받자

### 시간 비교는 isEquals() vs equals() ?
- `isEquals()` : 다른 날짜와 시간적으로 동일한지 비교, 예를 들어 서울의 9시와 UTC 0시는 같다. true를 반환
- `equals()` : 객체의 타입, 타임존 등등 모든 구성요소가 같아야 true를 반환한다. 서울의 9시와 UTC 0시는 시간적으로 같지만 false

# ZonedDateTime - 타임존
- 자바는 타임존을 `ZoneId` 클래스로 관리한다
```java
        for (String availableZoneId : ZoneId.getAvailableZoneIds()){
            ZoneId zoneId = ZoneId.of(availableZoneId);
            System.out.println(zoneId + " | " + zoneId.getRules());
        }
```

# 기계 중심의 시간 - Instant
- `Instant`는 UTC를 기준으로 하는, 시간의 한 지점을 나타낸다
- 1970년 1월 1일 0시 0분 0초(UTC 기준)를 기준으로 경과한 시간이다
- Instant 내부에는 초 데이터만 들어있다(나노초 포함)
- 즉, 날짜와 시간을 계산에 사용할 때는 사용하지 않는다

### 참고 - Epoch 시간
- 에포크 시간은 컴퓨터 시스템에서 시간을 나타내는 방법 중 하나
- 시간대에 영향을 받지 않는 절대적인 시간 표현 방식
- `Epoch`라는 뜻은 어떤 사건의 시작점을 뜻하는 용어다

## Instant는 언제 사용할까?
- 전 세계적인 시간 기준이 필요할 경우(로그 기록, 트랜잭션 타임스탬프, 서버 간의 시간 동기화)
- 시간대 변환 없이 시간 계산이 필요할 경우
- 데이터 저장 및 교환(데이터의 일관성을 유지하기 위해)


# 날짜와 시간의 핵심 인터페이스

## 특정 시점의 시간과 시간의 간격
- 날짜와 시간은 특정 시점의 시간(시각)과 시간의 간격(기간)으로 나눌 수 있다
- 특정 시점의 시간 : `Temporal(TemporalAccessor 포함)` 인터페이스 - `LocalDateTime`, `LocalDate`, `LocalTime` 등
- 시간의 간격(기간) : `TemporalAmount` 인터페이스 - `Period`, `Duration` 등
![image](https://github.com/ngngs/TIL/assets/47618270/7ff5b8bb-0ecc-4825-97fd-5bd31f081113)
- Temporal : `TemporalAccessor`의 하위 인터페이스, 날짜와 시간을 조작하기 위한 기능 제공(readonly + write)
- TemporalAccessor : 날짜와 시간을 읽기 위한 기본 인터페이스(readonly 느낌)
- TemporalAmount : 시간의 간격(시간의 양)을 나타내며, 읽기 쓰기 모두 가능

## 시간의 단위와 시간 필드
- 시간의 단위를 뜻하는 `TemporalUnit`과 시간의 각 필드를 뜻하는 `TemporalField`
![image](https://github.com/ngngs/TIL/assets/47618270/a006a638-500a-4278-9ecc-7e490b7d93b9)
- TemporalUnit은 시간의 단위를 갖고 있는 Enum이다
<br>
![image](https://github.com/ngngs/TIL/assets/47618270/80d8aed2-ab56-457b-9986-b8fab29be36f)
- TemporalField는 연도, 월, 일, 시간과 같은 날짜와 시간의 특정 부분이다
![image](https://github.com/ngngs/TIL/assets/47618270/17ad5870-7fdb-4a34-8725-1ffb53a23dfb)

