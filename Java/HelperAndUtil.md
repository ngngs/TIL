# Helper 클래스와 Utility 클래스 비교

| 특징                          | **Helper 클래스**                                                                 | **Utility 클래스**                                                                |
|-------------------------------|-----------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| **인스턴스화 가능 여부**       | 인스턴스화 가능                                                               | 인스턴스화 불가능 (private 생성자)                                              |
| **메서드 타입**               | 인스턴스 메서드와 정적 메서드 모두 포함 가능                                     | 정적 메서드만 포함                                                              |
| **변수 타입**                 | 인스턴스 변수와 정적 변수 모두 포함 가능                                         | 정적 변수만 포함                                                                |
| **목적**                      | 특정 문맥이나 상태를 기반으로 보조 작업 수행                                     | 애플리케이션 전역에서 접근 가능한 일반 작업 제공                                 |
| **범위**                      | 일반적으로 **패키지 범위**에서 사용                                             | **전역 범위**에서 사용                                                          |
| **설계 패턴**                 | 상태 기반 설계 가능                                                             | 상태가 없는 정적 설계                                                           |
| **사용 예시**                 | 할인 계산, 데이터베이스 연결 관리 등 상태를 유지해야 하는 작업                   | 문자열 조작, 날짜 계산, 수학 연산과 같은 범용 작업                              |

---

## Helper 클래스 특징

1. **상태 유지**  
   - Helper 클래스는 인스턴스 변수를 가질 수 있으므로, 특정 상태를 유지하면서 동작이 가능합니다.  
   - 예: 할인율이나 사용자 컨텍스트를 유지.

2. **패키지 범위**  
   - Helper 클래스는 특정 작업을 수행하는 데 필요한 보조적인 기능을 제공하며, 일반적으로 패키지 범위 내에서만 사용됩니다.  
   - 예: 내부적으로 데이터 처리에 도움을 주는 클래스.

3. **혼합된 메서드 구조**  
   - 인스턴스 메서드와 정적 메서드를 혼합하여 설계할 수 있습니다.  
   - 예: 데이터베이스 연결 작업은 인스턴스 메서드로, 유틸리티 성격의 간단한 메서드는 정적으로 구현.

---

## Utility 클래스 특징

1. **정적 설계**  
   - Utility 클래스는 상태를 유지하지 않으며, 모든 메서드와 변수가 정적(static)으로 선언됩니다.  
   - 예: Java의 `Math` 클래스.

2. **글로벌 사용**  
   - Utility 클래스는 애플리케이션 전역에서 접근할 수 있도록 설계됩니다.  
   - 예: 여러 패키지나 클래스에서 공통적으로 사용되는 기능 제공.

3. **인스턴스화 금지**  
   - private 생성자를 통해 인스턴스화를 막아 클래스가 순수 유틸리티 용도로만 사용되도록 제한합니다.  
   - 예:
     ```java
     public class UtilityClass {
         private UtilityClass() {
             throw new UnsupportedOperationException("Cannot instantiate UtilityClass");
         }
     }
     ```

---

## 예제 코드

### Helper 클래스
```java
public class DiscountHelper {
    private double discount;

    public DiscountHelper(double discount) {
        if (discount <= 0 || discount >= 1) {
            throw new IllegalArgumentException("Discount must be between 0 and 1.");
        }
        this.discount = discount;
    }

    public double calculatePrice(double price) {
        return price - (price * discount);
    }
}
```

### Util 클래스
```java
public final class StringUtils {

    private StringUtils() {
        throw new UnsupportedOperationException("Cannot instantiate utility class");
    }

    public static String reverse(String input) {
        if (input == null) {
            throw new IllegalArgumentException("Input cannot be null");
        }
        return new StringBuilder(input).reverse().toString();
    }
}

```
---
# Helper 클래스와 Utility 클래스의 선택 기준
1. **상태 유지가 필요한가?**
   - 필요하면 Helper 클래스를 사용
   - 필요하지 않으면 Utility 클래스를 사용

2. **전역에서 접근 가능한가?**
   - 전역적으로 사용해야 한다면 Utility 클래스가 적합
   - 특정 패키지에서만 사용할 목적이라면 Helper 클래스를 사용

3. **코드 구조의 복잡성**
   - Helper 클래스는 복잡한 상태를 처리해야 할 때 유리
   - Utility 클래스는 단순하고 반복적인 작업에 적합
