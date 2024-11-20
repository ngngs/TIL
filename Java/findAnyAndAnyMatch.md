# findAny()
- findAny() 메서드는 Stream에서 임의의 요소를 검색하는 데 사용
- 요소의 **순서가 중요하지 않은 경우** 특히 유용하며, 특정 요소를 반환하지만 어떤 요소인지에 대한 보장은 하지 않음
- 성능이 요소의 순서 유지보다 우선시되는 **병렬 스트림에서 적합한 선택**
- Optional을 반환하는데, 이는 값이 존재할 수도 있고 Stream에 요소가 없을 경우 비어 있을 수도 있음 -> 이렇게 함으로써 빈 결과를 처리하도록 강제해 더 안전한 코드 작성이 가능

```java
@Test
public void whenFilterStreamUsingFindAny_thenOK() {
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    Integer result = numbers.stream()
      .filter(n -> n % 2 == 0)
      .findAny()
      .orElse(null);

    assertNotNull(result);
    assertTrue(Arrays.asList(2, 4, 6, 8, 10).contains(result));
}
```

## findFirst() 와 차이가 뭘까?
- **findAny()** 가 **findFirst()** 와 유사하게 작동하며, 첫 번째로 일치하는 요소를 반환
- 그러나 **findAny()** 의 진정한 장점은 **병렬 스트림**에서 발휘
- 일치하는 요소 중 하나를 빠르게 가져올 수 있어, 순서가 중요하지 않은 경우 성능을 향상시킬 가능성이 있음
```java
@Test
public void whenParallelStreamUsingFindAny_thenOK() {
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    Integer result = numbers.parallelStream()
      .filter(n -> n % 2 == 0)
      .findAny()
      .orElse(null);

    assertNotNull(result); 
    assertTrue(Arrays.asList(2, 4, 6, 8, 10).contains(result));
}
```

### 병렬 스트림(parallelStream)이 뭘까?
- 일반적으로 순차 스트림(Sequential Stream)은 단일 쓰레드에서 데이터를 처리하는 반면, 병렬 스트림은 Fork/Join Framework를 활용해 작업을 여러 쓰레드로 분산 처리
- 데이터 병렬 처리 :데이터의 처리를 여러 쓰레드에서 나눠서 실행하므로, 대량의 데이터를 처리할 때 성능을 크게 향상
- 순서 보장 안됨 : 병렬로 데이터를 처리하기 때문에 작업 순서가 보장되지 않음. 순서가 중요한 경우 병렬 스트림 사용 X
- Fork/Join Framework 사용 : 내부적으로 Fork/Join Framework를 사용해 작업을 분할하고 병합. 각 서브태스크가 서로 독립적이라면 병렬 처리가 효과적
- 코드 간소화 : 명시적으로 쓰레드 풀을 관리하거나 쓰레드를 생성하지 않아도 되므로, 병렬 처리를 코드 한 줄로 쉽게 작성


# anyMatch()
- anyMatch() 메서드는 Stream의 요소 중 하나라도 주어진 조건(Predicate)을 만족하는지 확인하는 데 사용
- 조건을 만족하는 요소가 하나라도 있으면 true를 반환하고, 없으면 false를 반환
- **특정 조건을 만족하는지 여부만 확인**하고 실제 요소를 가져올 필요가 없을 때 이상적
- 조건에 맞는 요소를 찾는 즉시 나머지 요소를 처리하지 않고 작업을 중단
- BUT! 조건에 맞는 요소가 없으면 스트림의 모든 요소를 평가 -> 큰 데이터셋을 처리할 때 불필요한 계산을 줄여주기 때문에 유용

```java
@Test
public void whenFilterStreamUsingAnyMatch_thenOK() {
    List<Integer> numbers = Arrays.asList(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);

    boolean result = numbers.stream()
      .anyMatch(n -> n % 2 == 0);

    assertTrue(result);
}
```

![image](https://github.com/user-attachments/assets/b078fd1f-0636-4a85-aab0-43e707a771f5)
