## LISTAGG 함수

### LISTAGG 함수는 Oracle SQL에서 여러 행의 값을 하나의 문자열로 결합하여 반환하는 데 사용 
- 일반적으로 여러 행의 데이터를 쉼표나 다른 구분자로 구분된 문자열로 결합하여 사용

```sql
SELECT department_id,
       LISTAGG(employee_name, ', ') WITHIN GROUP (ORDER BY employee_name) AS employee_names
FROM (SELECT DISTINCT department_id, employee_name FROM employees)
GROUP BY department_id;

```

### 문제상황
CMP_CD는 1, 2, 3, 4, 5라는 값을 가져
만약 TABLE A에서 CMP_CD가 1이라는 값을 갖고 있다면 '복합'을 출력하고 싶고, 1을 갖고 있지 않다면 2,3,4를 '2, 3, 4' 형식으로 출력하고 싶어

```sql

SELECT 
    CASE 
        WHEN COUNT(CASE WHEN CMP_CD = 1 THEN 1 END) > 0 THEN '복합'
        ELSE 
            LISTAGG(CMP_CD, ', ') WITHIN GROUP (ORDER BY CMP_CD) 
    END AS 결과
FROM 
    A
WHERE 
    CMP_CD IN (1, 2, 3, 4, 5);

```
