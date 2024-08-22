# XMLAGG, XMLELEMENT 활용하기

## 테이블 생성
```sql
CREATE TABLE employees (
    employee_id NUMBER,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department_id NUMBER
);

INSERT INTO employees (employee_id, first_name, last_name, department_id) VALUES (1, 'John', 'Doe', 10);
INSERT INTO employees (employee_id, first_name, last_name, department_id) VALUES (2, 'Jane', 'Smith', 20);
INSERT INTO employees (employee_id, first_name, last_name, department_id) VALUES (3, 'Mike', 'Johnson', 10);

```

## XML로 출력하기
```sql
SELECT
    XMLELEMENT("Employees",
        XMLAGG(
            XMLELEMENT("Employee",
                XMLELEMENT("EmployeeID", employee_id),
                XMLELEMENT("FirstName", first_name),
                XMLELEMENT("LastName", last_name)
            )
        )
    ).GETCLOBVAL() AS employee_xml
FROM
    employees
WHERE
    department_id = 10;
```

### 결과
```xml
<Employees>
    <Employee>
        <EmployeeID>1</EmployeeID>
        <FirstName>John</FirstName>
        <LastName>Doe</LastName>
    </Employee>
    <Employee>
        <EmployeeID>3</EmployeeID>
        <FirstName>Mike</FirstName>
        <LastName>Johnson</LastName>
    </Employee>
</Employees>

```

## 추가) XML에서 EXTRACT를 활용하여 특정 텍스트 출력하기
```sql
WITH employee_data AS (
    SELECT
        XMLELEMENT("Employees",
            XMLAGG(
                XMLELEMENT("Employee",
                    XMLELEMENT("EmployeeID", employee_id),
                    XMLELEMENT("FirstName", first_name),
                    XMLELEMENT("LastName", last_name)
                )
            )
        ) AS employee_xml
    FROM
        employees
    WHERE
        department_id = 10
)
SELECT
    EXTRACT(employee_xml, '/Employees/Employee/FirstName/text()').getStringVal() AS first_names
FROM
    employee_data;

```

### 결과
```xml
John
```
