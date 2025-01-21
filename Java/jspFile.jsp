

# 📄 AjaxUtil.call 메서드의 콜백 함수 매개변수 설명

## 1. 메서드 구조
```javascript
AjaxUtil.call("/AA/BB/CC/getABC.do", 
    {"Param": "${Param}"}, 
    function(result) {
        // 콜백 함수 내부
        console.log(result);
    }
);
```

---

## 2. 동작 설명
1. **`AjaxUtil.call` 메서드**  
   - Ajax 요청을 처리하는 메서드 
   - 주요 매개변수:
     - **첫 번째 매개변수**: 요청 URL (e.g., `/AA/BB/CC/getABC.do`).
     - **두 번째 매개변수**: 전송할 데이터를 담은 객체 (e.g., `{"Param": "${Param}"`).
     - **세 번째 매개변수**: 요청 성공 시 실행될 **콜백 함수**.

2. **콜백 함수**  
   - `function(result)`는 `AjaxUtil.call` 메서드의 **세 번째 매개변수**로 전달된 **콜백 함수**
   - Ajax 요청이 성공하면 서버의 응답 데이터가 **`result` 매개변수**로 전달

---

## 3. `result` 매개변수의 역할
- **`result`란?**  
  - Ajax 요청의 결과값(응답 데이터)을 담고 있는 **콜백 함수의 매개변수**
- **스코프(scope):**
  - `result`는 **콜백 함수 내에서만 유효**한 **지역 변수**
  - 함수 외부에서는 접근할 수 없음!

---
