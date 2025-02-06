# IntelliJ .http 파일 사용법

## 1. IntelliJ .http 기능
IntelliJ IDEA의 `.http` 파일은 **HTTP Client** 기능을 활용하여 HTTP 요청을 작성하고 실행할 수 있는 기능
Postman과 같은 API 테스트 도구의 역할을 하며, 코드와 함께 API 요청을 관리

### 주요 기능
- HTTP 요청을 `.http` 파일에 작성하고 실행 가능
- 요청과 응답 히스토리 저장
- 환경 변수 지원 (`.env` 파일)
- JSON, XML 등의 응답을 포맷팅하여 보기 쉽게 출력
- CI/CD와 연계 가능 (스크립트로 실행 가능)

---

## 2. Postman과의 차이점 (장단점 비교)

| 비교 항목  | IntelliJ .http | Postman |
|------------|---------------|---------|
| **설치 여부** | IntelliJ 기본 제공 | 별도 설치 필요 |
| **형상 관리** | Git 등과 쉽게 연동 | JSON 파일로 내보내야 함 |
| **환경 변수 관리** | `.env` 파일로 간편하게 관리 | UI에서 설정 가능하지만 공유가 불편함 |
| **테스트 자동화** | JetBrains HTTP Client CLI 지원 | Postman Collection Runner 사용 |
| **UI/사용성** | 코드 스타일(텍스트 기반) | GUI 기반으로 직관적 |
| **협업** | 코드 리뷰와 함께 관리 가능 | Postman Workspace 사용 가능 |

### 💡 장점과 단점
#### ✅ IntelliJ `.http` 장점
- 코드와 함께 API 요청을 관리할 수 있어 **형상 관리(Git)** 에 용이
- IntelliJ 내에서 실행 가능하여 **개발 흐름이 끊기지 않음**
- `.http` 파일만 공유하면 쉽게 요청을 실행할 수 있음
- CI/CD와 연계 가능

#### ❌ IntelliJ `.http` 단점
- UI가 없는 CLI 기반이라 **비개발자는 사용하기 어려울 수 있음**
- Postman보다 **복잡한 테스트 시나리오 관리가 어렵다**

#### ✅ Postman 장점
- GUI 기반으로 **직관적인 API 테스트 가능**
- 다양한 기능 (Pre-request Script, Collection Runner 등) 지원
- 협업을 위한 클라우드 저장소 제공

#### ❌ Postman 단점
- 별도 프로그램 설치가 필요
- API 요청을 JSON 파일로 내보내야 하므로 **형상 관리가 불편함**

---

## 3. IntelliJ .http 파일을 잘 쓰는 방법

### 1️⃣ 요청 템플릿 활용
여러 개의 요청을 한 파일에 정리하여 관리 (`###`로 구분)
```http
### GET 요청 예제
GET http://localhost:8080/api/users

### POST 요청 예제
POST http://localhost:8080/api/users
Content-Type: application/json

{
    "name": "John",
    "email": "john@example.com"
}
```

### 2️⃣ 환경 변수 사용 (`.env` 활용)
서버 URL, API 키 등을 `.env` 파일에서 관리하여 **재사용성** 증가  
#### `.env` 파일 예제
```env
BASE_URL=http://localhost:8080
API_KEY=123456
```

#### `.http` 파일에서 참조
```http
GET {{BASE_URL}}/api/users
Authorization: Bearer {{API_KEY}}
```

### 3️⃣ 자동화 스크립트 활용
IntelliJ의 **JetBrains HTTP Client CLI**를 활용하여 CI/CD에서 API 테스트 실행 가능  
```shell
./http-client-cli request.http
```

### 4️⃣ 테스트 시나리오 구성
- `@no-cookie-jar`, `@no-redirect` 같은 옵션으로 HTTP 요청 제어  
- `> {%"response.body"}` 로 응답을 JSON 형식으로 확인  

---

## 4. IntelliJ .http 파일의 형상 관리

### Git과 연동 가능
- `.http` 파일은 일반 텍스트 파일이므로 Git에 커밋하여 **버전 관리 가능**
- API 요청 변경 이력을 추적할 수 있음

### 개발 팀 내 공유 가능
- `.http` 파일을 저장소에 올려두면 팀원들이 Postman 없이 바로 실행 가능
- `.env` 파일은 `.gitignore` 처리하여 보안 유지 (`.env.example` 제공)

---
