# 선언적 트랜잭션

- 스프링은 AOP를 이용해 코드 외부에서 트랜잭션의 기능을 부여해주고 속성을 지정할 수 있게 해준다
- 이를, `선언적 트랜잭션`이라고 한다
- @Transactional과 같은 Annotation 을 사용하거나 XML 정의를 이용하는 방법 등이 있다
- 타깃을 포인트컷(pointcut)의 대상으로 자동 등록하고 트랜잭션 대상으로 관리한다


## XML 정의를 이용한 트랜잭션 관리
```xml
<aop:config>
   <aop:pointcut id="requiredTx" expression="execution(* egovframework.sample..impl.*Impl.*(..))"/>
   <aop:advisor advice-ref="txAdvice" pointcut-ref="requiredTx" />
</aop:config>
 
<tx:advice id="txAdvice" transaction-manager="transactionManager"> 
   <tx:attributes>
      <tx:method name="find*" read-only="true"/>
      <tx:method name="createNoRBRole" no-rollback-for="NoRoleBackTx"/>
      <tx:method name="createRBRole" rollback-for="RoleBackTx"/>
      <tx:method name="create*"/>
   </tx:attributes>
</tx:advice>
```
- 예를 들어, findById(), findByName() 등의 메소드에 모두 적용된다
- <aop:pointcut>을 이용하여 실행되어 Catch해야 하는 Method를 지정한다
- <tx:advice>를 통해서 각각에 대한 룰을 정의하고 있다
- 이를 통해 별도의 트랜잭션 관련한 사항에 대해서 기술하지 않아도 트랜잭션관리가 된다


## 트랜잭션 롤백 처리
- 자바는 체크 예외(Checked Exception)와 언체크 예외(Unchecked Exception)이 있다
- 대표적인 체크 예외는 ClassNotFoundException 이 있으며, 반드시 에러 처리(try/catch)를 해야한다
- 대표적인 언체크 예외는 RuntimeException이며, 에러 처리를 강제하지 않는다
- 선언적 트랜잭션에서 예외가 발생할 때, 해당 예외가 언체크 예외라면 자동적으로 롤백이 발생한다(체크 예외는 롤백되지 않는다)
- 체크 예외를 롤백시키기 위해서는 rollbackFor 속성으로 체크 예외를 주어야한다
```xml
<tx:advice id="txAdvice" transaction-manager="transactionManager"> 
   <tx:attributes>
      <tx:method name="save*" rollback-for="Exception" timeout="240"/>
   </tx:attributes>
</tx:advice>
```

## 트랜잭션 전파 속성(Propagation)
- 선언적 트랜잭션은 여러 트랜잭션 적용 범위를 묶어 처리하거나, 새로운 트랜잭션을 처리할 수 있다
- 트랜잭션을 `어떻게` 진행시킬 지 결정하는 것이 Propagation이다.
- 트랜잭션 전파 규칙(Propagation Behavior)은 7가지다

### 트랜잭션 전파 규칙 7가지
- (1) MADATORY : 반드시 Transaction 내에서 메소드가 실행되어야 한다. 없으면 예외발생
- (2) NESTED : Transaction에 있는 경우, 기존 Transaction 내의 nested transaction 형태로 메소드를 실행하고, nested transaction 자체적으로 commit, rollback이 가능하다
- Transaction이 없는 경우, PROPAGATION_REQUIRED 속성으로 행동한다. nested transaction 형태로 실행될 때는 수행되는 변경사항이 커밋이 되기 전에는 기존 Transaction에서 보이지 않는다
- (3) NEVER : Manatory와 반대로 Transaction 없이 실행되어야 하며 Transaction이 있으면 예외를 발생시킨다
- (4) NOT_SUPPORTED : Transaction 없이 메소드를 실행하며,기존의 Transaction이 있는 경우에는 이 Transaction을 호출된 메소드가 끝날 때까지 잠시 보류한다
- (5) REQUIRED : 기존 Transaction이 있는 경우에는 기존 Transaction 내에서 실행하고, 기존 Transaction이 없는 경우에는 새로운 Transaction을 생성한다.
- (6) REQUIRED_NEW : 호출되는 메소드는 자신 만의 Transaction을 가지고 실행하고, 기존의 Transaction들은 보류된다
- (7) SUPPORTS : 새로운 Transaction을 필요로 하지는 않지만, 기존의 Transaction이 있는 경우에는 Transaction 내에서 메소드를 실행한다.
