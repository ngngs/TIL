# ROWNUM

## 특징 및 정의
- ROWNUM은 Oracle에서 결과 집합의 각 행에 대해 순차적으로 부여되는 가상 열입니다. 이는 SQL 표준이 아니며 Oracle 고유의 기능입니다

- 실행 순서: ROWNUM은 쿼리의 결과 집합이 생성되는 즉시 부여되므로, ORDER BY보다 먼저 적용됩니다
- 이로 인해 원하는 순서로 정렬된 데이터를 정확히 필터링하려면 서브쿼리가 필요합니다
- 제약: ROWNUM은 한 번 부여된 값을 수정할 수 없으므로, 아래와 같은 조건은 항상 실패합니다
```sql
SELECT * 
FROM your_table 
WHERE ROWNUM > 1; -- 불가능
-- ROWNUM은 처음부터 순서대로 부여되며, ROWNUM > 1에 만족하는 첫 번째 행이 없기 때문
```

## 장점
- 오래된 Oracle 버전에서도 사용할 수 있습니다
- 간단한 제한 조건에는 서브쿼리 없이 빠르게 적용 가능합니다.

## 단점
- ORDER BY와 함께 사용할 때는 별도의 서브쿼리가 필요해 코드가 복잡해질 수 있습니다.
- SQL 표준 방식이 아니므로 **다른 데이터베이스와의 호환성이 떨어집니다.**

---

# FETCH FIRST

## 특징 및 정의
- FETCH FIRST는 SQL 표준 방식으로 Oracle 12c 이상에서 지원되며, 지정된 개수의 행을 가져오는 기능입니다
- 실행 순서: FETCH FIRST는 ORDER BY와 자연스럽게 결합되며, 정렬 후에 원하는 개수만큼의 행을 가져옵니다.
- 서브쿼리를 작성할 필요가 없습니다.
- 제약 조건: 가독성이 높고 명확한 방식으로 제한할 행 수를 설정할 수 있습니다
```sql
SELECT * 
FROM your_table 
ORDER BY column_name 
FETCH FIRST 10 ROWS ONLY;
```
- 추가 옵션: FETCH FIRST는 WITH TIES 옵션을 사용해 동일한 순위를 가진 행도 포함할 수 있습니다
```sql
SELECT * 
FROM your_table 
ORDER BY column_name 
FETCH FIRST 10 ROWS WITH TIES;
```

## 장점
- ORDER BY와 결합할 때 명확하고 간단한 코드를 작성할 수 있습니다.
- 최신 SQL 표준 방식으로 다른 데이터베이스와의 호환성이 높습니다.
- 정렬된 데이터에 대해 직관적으로 사용할 수 있습니다.

## 단점
- Oracle 12c 이전 버전에서는 지원되지 않습니다.
