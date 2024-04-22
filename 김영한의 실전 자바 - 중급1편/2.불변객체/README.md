## 공유 참조와 사이드 이펙트
```java
b.setValue("부산");
System.out.println("부산 -> b");
System.out.println("a = " + a); // 사이드 이펙트 발생
System.out.println("b = " + b);
