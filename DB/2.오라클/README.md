- 오라클 start with ~ connect작성예정)
- 데이터 마이그레이션하기(인텔리제이 - Copy Table to..)
- 오라클 object types, collection types
- 오라클 compile을 하는 이유..?
- WHERE 1=1 이 위험한 이유 : SQL Injection 뿐만 아니라 1=1 아래 조건에서 null이 들어오더라도 항상 조회되는 문제가 있음 -> trim으로 해결하기 https://java119.tistory.com/103
- 오라클 MView
- 오라클 in~ 에는 해당 칼럼이 1000개 넘어갈 경우 ORA-01795 에러가 발생함. -> exsits 구문으로 바꿔줘야함
- on clause vs where clause
https://gibles-deepmind.tistory.com/entry/Oracle-SQL-JOIN%EC%8B%9C-WHERE-%EC%A0%88%EA%B3%BC-ON-%EC%A0%88%EC%9D%98-%EC%B0%A8%EC%9D%B4where-clause-vs-on-clause
- <s>로컬에서는 잘되는데, 실 서버 올리고 되지 않는다면 (가능성은 낮지만) DB 세팅(드라이버 등)이 맞지 않을 수도 있으니 확인해보자</s> 그냥 반영 잘못 한 거 였음
