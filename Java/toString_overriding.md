# 📌 자바 `toString()` 오버라이딩을 해야 하는 이유 

## 1️⃣ `toString()`을 반드시 재정의해야 하는 이유  
자바의 `Object` 클래스에서 기본 제공하는 `toString()`은 `"클래스이름@해시코드"` 형태로 출력  
하지만 이를 오버라이딩하면 **객체의 의미 있는 정보를 출력**할 수 있어 디버깅, 로깅, 오류 분석 등에 유용

### 📍 오버라이딩하지 않은 경우 (기본 `toString()`)
```java
class Order {
    private final int id;
    private final String product;
    private final int quantity;

    public Order(int id, String product, int quantity) {
        this.id = id;
        this.product = product;
        this.quantity = quantity;
    }
}

public class Main {
    public static void main(String[] args) {
        Order order = new Order(101, "Laptop", 2);
        System.out.println(order);
    }
}
```
**출력 결과:**
```
Order@5e2de80c
```
❌ 객체의 정보가 전혀 보이지 않음 → **디버깅과 로깅에 불편**  

---

### 📍 올바르게 `toString()`을 오버라이딩한 경우
```java
class Order {
    private final int id;
    private final String product;
    private final int quantity;

    public Order(int id, String product, int quantity) {
        this.id = id;
        this.product = product;
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "Order{id=" + id + ", product='" + product + "', quantity=" + quantity + "}";
    }
}

public class Main {
    public static void main(String[] args) {
        Order order = new Order(101, "Laptop", 2);
        System.out.println(order);
    }
}
```
**출력 결과:**
```
Order{id=101, product='Laptop', quantity=2}
```
✅ 객체의 필드 값을 포함해 사람이 읽을 수 있는 형태로 출력됨 → **디버깅과 로깅이 편리함**

---

## 2️⃣ `toString()`이 유용한 이유

### ✔️ **1. 디버깅이 쉬워짐**
- `System.out.println(객체)`, `logger.info(객체)` 호출 시 객체 상태를 쉽게 확인 가능

### ✔️ **2. 로깅할 때 유용**
- 로그 파일에서 객체 상태를 확인하는 것이 용이함  
```java
logger.info("Order placed: " + order);
```
**출력 (오버라이딩 X)**
```
INFO: Order placed: Order@3e25a5
```
**출력 (오버라이딩 O)**
```
INFO: Order placed: Order{id=101, product='Laptop', quantity=2}
```
➡ **객체의 정보를 한눈에 확인 가능**

### ✔️ **3. 오류 메시지에서 유용**
```java
throw new IllegalStateException("잘못된 주문: " + order);
```
**출력 (오버라이딩 O)**
```
Exception in thread "main" java.lang.IllegalStateException: 잘못된 주문: Order{id=101, product='Laptop', quantity=2}
```
➡ **오류 원인 분석이 쉬워짐**

---

## 3️⃣ `toString()` 작성 시 주의할 점

### ⚠️ **1. 반환 형식을 가능한 문서화할 것**
- API에서 `toString()`의 결과를 활용할 경우, 반환 형식을 문서화해야 함
- 하지만 너무 구체적인 포맷을 정하면 변경이 어려울 수 있음

### ⚠️ **2. 객체의 중요한 정보를 포함할 것**
- `"클래스이름@해시코드"` 대신 **객체의 필드 값을 포함해야 함**
- 예: `User{name='Alice', age=30}`

### ⚠️ **3. 민감한 정보는 포함하지 말 것**
- 비밀번호, 신용카드 번호, API Key 등은 `toString()`에 포함하면 안 됨
```java
@Override
public String toString() {
    return "User{username='" + username + "', password=******}"; // X
}
```

---

## ✅ 정리
✔ **`toString()`을 반드시 재정의해야 하는 이유**
- 기본 `toString()`은 `"클래스이름@해시코드"`만 반환 → **디버깅, 로깅, 오류 분석이 어려움**
- 사람이 읽을 수 있는 형태로 **객체의 주요 정보**를 포함해야 함

✔ **작성할 때 주의할 점**
- 반환 형식을 문서화하되, 너무 구체적으로 정하면 유지보수 어려움  
- **필드 값을 포함해야 유용**하지만, **민감한 정보는 제외해야 함**

➡ **이펙티브 자바 Item 12에서도 강조하는 모범 사례이므로, `toString()`을 반드시 오버라이딩하자!** 
