SHOW USER;
-- USER이(가) "HR " 입니다.

SELECT
    *
FROM
    dba_users;
-- 관리자 계정에서만 조회가 가능하고 
-- 권한이없는 계정에서 실행시 오류발생.

-- ORA-00942: table or view does not exist

SELECT
    *
FROM
    tab;
-- 현재 오라클 서버에 접속한 사용자(지금은 HR) 소유의 테이블명과 뷰명을 조회해주는 것이다.

SELECT
    *
FROM
    departments; -- 부서 테이블
-- 대소문자 구분을 하지 않는다.

/*
    department_id      => 부서번호 컬럼(column ==field == attribute), 열)
    department_name => 부서명 컬럼
    manager_id         => 부서장의 사원번호
    location_id          => 부서위치 컬럼 
    
    10	Administration	200	1700  => row == record  == tuple == 행
    
    departments => table == emtity(개체) == 테이블
    
 */

DESCRIBE departments; -- departments 테이블의 컬럼 구성을 조회 
/*
---------------------------------------
컬럼명                 널여부 
not null 필수입력사항이라는 뜻.
---------------------------------------
DEPARTMENT_ID       NOT NULL                   NUMBER(4)     > 숫자타입
DEPARTMENT_NAME  NOT NULL                  VARCHAR2(30)  문자열타입
MANAGER_ID            (선택사항)                  NUMBER(6)     날짜타입
LOCATION_ID            (선택사항)                  NUMBER(4)    
*/

SELECT
    *
FROM
    employees; -- 사원테이블

/*
DESC employees;
EMPLOYEE_ID    NOT NULL NUMBER(6)         => 사원번호  
FIRST_NAME              VARCHAR2(20)          => 성 
LAST_NAME      NOT NULL VARCHAR2(25)    => 이름 
EMAIL          NOT NULL VARCHAR2(25)        => 이메일
PHONE_NUMBER            VARCHAR2(20)       => 전화번호
HIRE_DATE      NOT NULL DATE                 => 입사일자
JOB_ID         NOT NULL VARCHAR2(10)        => 직종아이디 
SALARY                  NUMBER(8,2)             => 기본급여
COMMISSION_PCT          NUMBER(2,2)         => 커미션(수당) 퍼센티지 0.2는 기본급여(salary)의 20% 라는 말이다.
MANAGER_ID              NUMBER(6)              => 직속상관(사수)의 사원번호
DEPARTMENT_ID           NUMBER(4)            => 본인이 근무하는 부서번호
*/

SELECT
    *
FROM
    locations;  -- 부서의 위치를 알려주는 테이블

SELECT
    *
FROM
    countries; -- 국가정보를 알려주는 테이블

SELECT
    *
FROM
    regions; -- 대륙정보를 알려주는 테이블


/*
    ==== 아주아주아주아주아주아주아주아주아주 중요함(필수암기!!!!!!!!!!!!!!!!!!)=======
    
    >>>> select 문의 처리 순서<<<<
    
    select 컬럼명              --- 5 컬럼명 대신에 *을 쓰면 *은 모든 칼럼을 뜻하는 것이다.
    from 테이블(뷰명)          --- 1
    where 조건절               --- 2  where 절이 뜻하는 것은 해당 테이블(뷰)에서 조건에 만족하는 행을 메모리(RAM)에 로딩 (올리는것)해주는 것이다.
    group by 절                 --- 3 
    having 그룹함수 조건절  --- 4 
    order by 절                  --- 6
    
    select
    from
    where
    group by
    having
    order by
    
*/

--------- *** NULL을 처리해주는 함수 *** ------------
---- NULL 은 존재하지 않는 것이므로 4칙연산( +-*/) 에 NULL이 포함되어지면 그 결과는 무조건 NULL 이다.

SELECT
    1 + 2,
    1 + NULL,
    3 * 0,
    NULL * 0,
    2 - 1,
    2 - NULL,
    5 / 2,
    5 / NULL
FROM
    dual;

SELECT
    nvl(7,3),
    nvl(NULL,3),
    nvl('이순신','거북선'),
    nvl(NULL,'거북선')
FROM
    dual;

SELECT
    nvl2(7,3,2),
    nvl2(NULL,3,2),
    nvl2('이순신','거북선','구국영웅'),
    nvl2(NULL,'거북선','구국영웅')
FROM
    dual;

-- employees 출력후.

SELECT
    *
FROM
    employees;

SELECT
    employee_id      "사원번호" -- 별칭 alias
   ,
    first_name       "성",
    last_name        이름,
    salary           "기본 급여", 
-- 공백이 있을때는 "", 
    commission_pct   AS "수당퍼센티지",
    nvl(salary + (salary * commission_pct),salary) AS "월급",
    nvl2(commission_pct, (salary * commission_pct),salary) AS "월급"
FROM
    employees;
        
/*        ----- *** 비교연산자 -----
        1. 같다                      = 
        2. 같지않다            !=  <>  ^= 
        3. 크다. 작다.    >     <
        4. 크거나 같다. 작거나 같다.  >=  <=
        5. null은 존재하지 않는 것이므로 비교대상이 될수가 없다.
           그러므로 비교연산 (= != <> ^= ) 을 할수가 없다.
           그래서 비교연산을 하려면 nvl()함수, nvl2()함수를 사용하여 처리한다.
           
*/

       
           
       -- employees 테이블에서  부서번호 30번에 근무하는 사원들만 
       -- 사원번호, 사원명, 월급, 부서번호를 나타내세요.
       
       
       
       -- employees 테이블에서  부서번호가 null인 사원들만 
       -- 사원번호, 사원명, 월급, 부서번호를 나타내세요.
       

    
       --first name 컬럼과 lst_name을 합치는 것은 ||
       from employees 
       where department_id = 30;
       
       from employees 
       where department_id = null;  --> 데이터가 출력되지 않는다.
       
       
       -- null 이들어가서 안나오는데 그렇다면 null 값을 가진 데이터를 어떻게 선택할것인지...
       -- 왜냐하면 NULL은 존재하지 않는 것이므로 비교대상이 될수가 없다.
       
.
       
 --      select employee_id as 사원번호
 --    , first_name || ' ' || last_name as 사원명
 --    , nvl(department_id, -9999) as 부서번호
 
 -- null 값을 nvl로 null값을 변경하는 방법
 
 -- is 연산자를 사용하는 방법
     select employee_id as 사원번호, 
       first_name || ' ' || last_name as 사원명 -- , 월급, 부서번호
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
    where department_id is null;
    
 
 -- nvl을 사용하는 해서 null 값을 바꿔어 주어 출력하는 방법.   
       select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 -- , 월급, 부서번호
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
       where nvl(department_id, -9999)=-9999; 
       
       
       -- 정렬(오름차순정렬, 내림차순정렬)을 할때 null 은 존재하지 않는 것이므로
       -- 오름차순 asc, 내림차순 desc.
       -- 오라클에서는 가장 큰것으로 간주를 해주고, My-SQL에서는 가장 작은 것으로 간주를 해버린다.
       
       
       -- 월급을 오름차순, 내림차순으로 정리.
         select employee_id as 사원번호,
         first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by nvl(salary + (salary*commission_pct), salary) --asc; -- 오름차순은 asc을 생략할수 있다.
           
           
        -- 지정해준 컬럼명으로도 지정가능.
           select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by 월급 asc;
           
           
        -- 해당 line으로도 설정가능.    
           select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by 3; -- asc;           
       
       
          select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by nvl(salary + (salary*commission_pct), salary) desc;        -- 내림차순 뒤에 desc생략 안됨.    
       
           select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by 3 desc;        -- 내림차순 뒤에 desc생략 안됨. 
           
                      select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by 월급 desc;        -- 내림차순 뒤에 desc생략 안됨.   
           
           
           
           
         -- 오라클의 경우 null은 가장 큰것으로 간주함.
         -- MS는 null은 가장 작은것으로 간주함.
         
          select employee_id as 사원번호,
       first_name || ' ' || last_name as 사원명 
     , nvl(salary + (salary*commission_pct), salary) as 월급
     , department_id as 부서번호
           from employees
           order by department_id, 3 desc; -- 부서번호의 오름차순을 정렬
           
           -- 동일한 부서에서 급여가 가장많은 사람이 오름차순으로 정리하고 싶다.
           -- 1차정렬은 department_id(부서번호)의 오름차순으로 정렬 시킨후
           -- 2차정렬은 동일한 부서내 월급의 내림차순으로 정렬하겠다.
    
    
        select *
        from employees
        
        -- employees 테이블에서 수당퍼센티지가 null 인 사원들만 
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        select 
        employee_id as 사원번호,
        first_name || ' ' || last_name as 사원명,
        salary as 급여,
        department_id as 부서번호
        from employees
        where commission_pct is null
        order by 4, 3 desc;
        -- 여기도 오류남
        -- employees 테이블에서 부서번호가 50번 부서가 아닌 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
       select
        employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , salary as 급여
      , department_id as 부서번호
        from employees
        where nvl(department_id, -9999) !=50
        order by department_id asc, salary desc; 
        
        
        -- department_id가 null이 아닌 행들만 보고자 할 경우.
        select 
        employee_id as 사원번호,
        first_name || ' ' || last_name as 사원명,
        salary as 급여,
        department_id as 부서번호
        from employees
        where department_id is not null
        order by department_id asc, salary desc;
        
        
        
        -- employees 테이블에서 월급(기본급여+수당금액)이 10000 보다 큰 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        desc employees;
        select
        employee_id as 사원번호
      , first_name || ' ' || last_name as 사원명
      , nvl(salary+(salary*commission_pct), salary)  as 급여
        -- 급여자체에 걸어버리면됨.
        -- 오라클의 특징 null과 연산을 하면 값이 어떻든간에 null이 나오는것을 이용하여
        -- nvl함수를 활용하여 null값은 녀석들을 모조리 제거하는 것.
      , department_id as 부서번호
        from employees
        where nvl (salary + (salary*commission_pct), salary) >10000
        --조건식 
        order by department_id asc, salary desc; 
        
        
      select * 
           from employees
    
    
        -- employees 테이블에서 수당퍼센티지가 null 인 아닌사원들만 
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        select 
        employee_id as 사원번호,
        first_name || ' ' || last_name as 사원명,
        salary as 급여,
        department_id as 부서번호
        from employees
        where not commission_pct is null
        order by department_id asc, salary desc;
        
       
        
      
        
        -- employees 테이블에서 월급(기본급여+수당금액)이 10000 보다 큰 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        SELECT
            employee_id as 직원번호,
            first_name || ' ' || last_name as 이름,
            nvl (salary + (salary*commission_pct), salary) as 급여,
            department_id as 부서번호
        FROM employees
        where nvl (salary + (salary*commission_pct), salary) >10000
        order by 4, 3 desc;
        
        
        SELECT
            *
        FROM employees
        
          -- employees 테이블에서 수당퍼센티지가 null 인 아닌사원들만 
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        SELECT 
            employee_id as 사원번호,
            first_name || ' ' || last_name as 사원명,
            nvl (salary+(salary*commission_pct), salary) as 급여
            
        FROM employees
        
        nvl(3,5)
        
        
         -- employees 테이블에서 월급(기본급여+수당금액)이 10000 보다 큰 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
               
        SELECT
            employee_id as 사원번호,
            first_name || ' ' || last_name as 사원명,
            nvl (salary+(salary*commission_pct), salary) as 급여,
            department_id as 부서번호            
        FROM employees
        where nvl (salary+(salary*commission_pct), salary) >'10000'
        -- 해도그만안해도그만.
        order by 4, 3 desc;
        
         -- employees 테이블에서 수당퍼센티지가 null 인 아닌사원들만 
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        
        -- 질문하기
            SELECT
                employee_id as 사원번호,
                 first_name || ' ' || last_name as 사원명,
                  nvl (salary+(salary*commission_pct), salary) as 급여,
                 department_id as 부서번호
            FROM employees
            
            where nvl(commission_pct, -9999)  != -9999
            -- null이랑 등위가 성립이안됨.
            -- 조건식이 문제있음.
            
            order by 4, 3 desc;
            
            
            
        -- employees 테이블에서 부서번호가 50번 부서가 아닌 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        
        SELECT
               employee_id as 사원번호,
               first_name || ' ' || last_name as 사원명,
                salary as 급여,
               department_id as 부서번호
                 FROM employees
                 where department_id!='50'
                 -- 끝에만 ;붙이는거
                 order by 4, 3 desc;
                
                
                -- 50이 아닌애들만 출력하라니까 부서번호 50까지나옴..
                
                
        -- employees 테이블에서 부서번호가 50번 부서가 아닌 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
            select
            employee_id as 사원번호,
            first_name || ' ' || last_name as 사원명,
            nvl((salary+(salary*commission_pct)), salary) as 월급,
            department_id as 부서번호
            from employees
            where department_id!='50'
            order by 4, 3 desc;
        
        -- employees 테이블에서 수당퍼센티지가 null 인 아닌사원들만 
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
           select
            employee_id as 사원번호,
            first_name || ' ' || last_name as 사원명,
            nvl((salary+(salary*commission_pct)), salary) as 월급,
            department_id as 부서번호
            from employees
            where commission_pct is not null
            order by 4, 3 desc;
        
         -- employees 테이블에서 월급(기본급여+수당금액)이 10000 보다 큰 사원들만  
        -- 사원번호, 사원명, 월급, 부서번호를 나타내되
        -- 부서번호의 오름차순으로 정렬한 후 동일한 부서번호내에서 월급이 내림차순으로 나타내세요.
        select
            employee_id as 사원번호,
            first_name || ' ' || last_name as 사원명,
            nvl((salary+(salary*commission_pct)), salary) as 월급,
            department_id as 부서번호
            from employees
            where nvl((salary+(salary*commission_pct)), salary) > 10000
            order by 4, 3 desc;


        /*
            ===AND, OR, NOT 연산자가 혼용되어지면 우선순위를 따르는데
                 NOT > AND > OR 의 순위를 따라간다.
                 우선순위에 있어서 최우선은 () 괄호 이다.
                 
                연산에도 우선순위가 있다.
                or 연산자와 같은 것이 IN() 이다. IN()는 괄호가 있는 OR 이다.
                범위연산자가 있는데 between A and B 이상 A 이하를 나타내는 것이다.
                
        */
        .
        select 2+3*4
        from dual;
        
        /*
                employees 테이블에서 부서번호가 30, 50, 60 번 부서에  근무하는 사원들 중에
                연봉(월급*12)이 20000이상 60000 이하인 사원들만
                사원번호, 사원명, 연봉(월급*12), 부서번호를 나타내되 
                부서번호의 오름차순으로 정렬한 후, 연봉의 내림차순으로 정렬하여 출력하세요.
        */
        
        -- 오류찾기.
        -- ,를 빼먹음.
        select employee_id  as 사원번호, 
        first_name || ' ' || last_name as 사원명, 
        nvl(salary+(salary*commission_pct), salary)*12 as 연봉, 
        department_id as 부서번호
        from    employees
        where (department_id = 30 or department_id =60 or department_id=50) and
                 20000 <= nvl(salary+(salary*commission_pct), salary)*12 and
                 nvl(salary+(salary*commission_pct), salary)*12 <=60000
        order by 4, 3 desc;
         /* and우선순위이므로
                 department_id=50 and
                 20000 <= nvl(salary+(salary*commission_pct), salary)*12 and
                 nvl(salary+(salary*commission_pct), salary)*12 <=60000
                 먼저하고 
                 department_id = 30 or department_id =60  임으로
                 30,60은 뒤에 and 조건상관없이 결과값이 나오게됨.
                 우선순위를 부여하려면 ()를 쳐서 먼저조건을 수정해주어야함.
                 */
                 
        select employee_id  as 사원번호, 
        first_name || ' ' || last_name as 사원명, 
        nvl(salary+(salary*commission_pct), salary)*12 as 연봉, 
        department_id as 부서번호
        from    employees
        where department_id in(30,50,60) and
                 -- or와 같음
                 -- (department_id = 30 or department_id =60 or department_id=50)
                 nvl(salary+(salary*commission_pct), salary)*12 between 20000 and 60000         
        --      20000 <= nvl(salary+(salary*commission_pct), salary)*12 and
        --        nvl(salary+(salary*commission_pct), salary)*12 <=60000
                order by 4, 3 desc;
        
        
        
        -- 대용량 데이터베이스인 경우 in 보다는 or를, between A and B 보다는 >= <= 를 사용할것을 권장한다.
        -- 왜냐하면 in은 내부적으로 or로 변경되어서 사용되고,
        -- 또한 between A and B 도 <= >=로 변경되어서 사용되어지기 때문이다.
        -- 대용량 데이터베이스의 기준은 어떤 테이블의 행의 갯수가 100만건을 넘을 경우를 말한다.
        -- 소규모 데이터베이스의 기준은 어떤 테이블의 행의 갯수가 1만건 미만인 경우를 말한다.
        
    
         /*
                employees 테이블에서 부서번호가 50, 80 번 부서에  근무하지 않는 사원들 중에
                월급이 4000이상인  사원들만
                사원번호, 사원명, 월급, 부서번호를 나타내되 
                부서번호의 오름차순으로 정렬한 후, 연봉의 내림차순으로 정렬하여 출력하세요.
        */
        
        select
                         employee_id as 사원번호
                      ,first_name || ' ' || last_name as 사원명
                      ,nvl(salary+(salary*commission_pct), salary) as 월급
                      ,department_id as 부서번호
        from   employees
        where nvl(department_id, -9999) !=50   and 
                      nvl(department_id, -9999) !=80   and
                      nvl(salary+(salary*commission_pct), salary) >= 4000 
        order by 4, 3 desc;
        -- ((department_id != 50) and (department_id != 80))  and nvl(salary+(salary*commission_pct), salary) >=4000
        -- and 는 모든게 참일때 참.
        -- or은 하나가 참이면 참.
  
  
          
        select
                         employee_id as 사원번호
                      ,first_name || ' ' || last_name as 사원명
                      ,nvl(salary+(salary*commission_pct), salary) as 월급
                      ,department_id as 부서번호
        from   employees
        where not nvl(department_id, -9999)  in(50,80)  and 
        -- not nvl(department_id, -9999)  in(50,80)  
        -- 우선순위에 따라.
                      nvl(salary+(salary*commission_pct), salary) >= 4000 
        order by 4, 3 desc;
        
        
        
  -----------------------------------------------------------------------------------------------      
         select
                          employee_id as 사원번호
                       ,first_name || ' ' || last_name as 사원명
                       ,nvl(salary+(salary*commission_pct), salary) as 월급
                       ,department_id as 부서번호
        from       employees
        where   (department_id != 50 and department_id != 80 )and
                        nvl(salary+(salary*commission_pct), salary) >=4000
        order by 4, 3 desc;
       
       -- 왜 오류가 나지??
       -- employees 잘못적음. (해결)
        
-----------------------------------------------------------------------------------------------      

        select
                         employee_id as 사원번호
                      ,first_name || ' ' || last_name as 사원명
                      ,nvl(salary+(salary*commission_pct), salary) as 월급
                      ,department_id as 부서번호
        from   employees
        where nvl(department_id, -9999) not  in(50,80)  and 
        -- not nvl(department_id, -9999)  in(50,80)  
        -- 우선순위에 따라.
                      nvl(salary+(salary*commission_pct), salary) >= 4000 
        order by 4, 3 desc;
    
  -- 위아래가 똑같음
  -----------------------------------------------------------------------------------------------
  
        select
                         employee_id as 사원번호
                      ,first_name || ' ' || last_name as 사원명
                      ,nvl(salary+(salary*commission_pct), salary) as 월급
                      ,department_id as 부서번호
        from   employees
        where nvl(department_id, -9999) != 50 and
                      nvl(department_id, -9999) != 80 and
                      nvl(salary+(salary*commission_pct), salary) >= 4000 
        order by 4, 3 desc;  
        
        
 -----------------------------------------------------------------------------------------------
 
    --- *** 범위 연산자 ======= *** --- 
    --  >  < >= <=
    -- between A and B
    -- 범위 연산자에는 데이터가 숫자 뿐만 아니라 문자, 날짜까지 모두 사용가능하다 
        
        desc employees
        -- hire_date date ==> 기본적으로 Date 타입의 기본적인 표현방식은 'RR/MM/DD' 으로 나타내어진다.
                                                    -- RR은  년도의 2자리만 나타내어주는데 50 ~ 99은 1950 ~ 1999 이다.
                                                    -- RR은  년도의 2자리만 나타내어주는데 00 ~ 49은 2000 ~ 2049 이다.
                                                    -- MM은 월이고 , DD는 일이다.

        -- *** 현재 시각을 알려주는것 *** --
        
        
        
        select sysdate, current_date, localtimestamp, current_timestamp, systimestamp
        -- sysdate 시스템 날짜.
        -- localtimestamp 시간
        -- current_timestamp 지역 장소까지
        -- systimestamp 그리니치 시간을 기준으로 비교 해줌.
        from dual;
        -- dual 조건을 줄 테이블이 없을경우 dual을 넣어 처리한다.
        
        select sysdate, current_date, localtimestamp, current_timestamp,systimestamp
        from dual;
        
        select sysdate, to_char(sysdate, 'yyyy-mm-dd  hh24 : mi : ss')
        from dual;
        
        select employee_id, first_name, hire_date, to_char(hire_date, 'yyyy-mm-dd')
        -- to_char는 날짜를  'yyyy-mm-dd' 형식으로 바꾸어주는 함수.
        from employees;
        
        
        select sysdate -1 , sysdate + 1 -- 숫자의 단위는 일수이다.
        from dual;
        
        select to_char (sysdate -1, 'yyyy-mm-dd') , to_char(sysdate, 'yyyy-mm-dd') , to_char(sysdate + 1, 'yyyy-mm-dd') 
        from dual;        
        -- 하루전을 보고싶다면
        -- ex) sysdate -1
        
        
        select to_char (sysdate -1/24, 'yyyy-mm-dd hh24:mi:ss') , to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') , to_char(sysdate + 1/24, 'yyyy-mm-dd hh24:mi:ss') 
        from dual;    
        
        -- 한시간후 한시간전을 보고싶다면
        -- ex) -1/24 1시간전
        
        
        select to_date('2020/08/01', 'yyyy/mm/dd')  + 2,
        -- 앞에 to_date의 형식은 못바꿈. 기본 20/20/20형식임.
        -- 형식으로 변환시켜주는 to_char만 가능.
        -- 달력에 있어야만 연산이 가능. 없는 날짜라면 불가.
                     to_char(to_date('2020-08-01', 'yyyy-mm-dd')  + 2, 'yyyy-mm-dd')
        --  select '2020-08-01' + 2 문자타입으로 받아들여서 문자+숫자 오류남.
        -- 해결방법은 문자를 날짜로 바꾸어주어야 정상 연산이 된다.
        -- to_date('2020-08-01', 'yyyy-mm-dd') to_date을 사용하여 문자를 날짜형식으로 변경하여 연산하면 오류가 나지않는다.
        from dual;
-----------------------------------------------------------------------------------------------

        select employee_id, first_name, hire_date, to_char(hire_date, 'yyyy-mm-dd')
        -- to_char는 날짜를  'yyyy-mm-dd' 형식으로 바꾸어주는 함수.
        from employees
        where '2005-01-01' <= hire_date and hire_date <= '2006-12-31'; 
        -- 자동형변환해줌
        
--     오류 고쳐보기.   
        select employee_id, first_name, hire_date, to_char(hire_date, 'yyyy-mm-dd')
        from  employees
        where hire_date between to_date('2005-01-01') and to_date('2006-12-31')
        order by 4;
        
-----------------------------------------------------------------------------------------------
-- 숫자 암기해두기.
       'A'--> 65
       'a' --> 97
       '0' --> 48
       ' '  --> 32
       
       select ascii('A'),  ascii('a'),  ascii('0'),  ascii(' ')
       from dual;
       -- 문자를 10진수 숫자로 표현.
       
       select chr(65),  chr(97),  chr(48),  chr(32)
       from dual;
       -- 아스키 코드 10진수를 문자로 알려줌.
       
       
       select first_name
       from employees
       where 'Elj' <= first_name and first_name <= 'H';


-- 부등호사용할때 문자도 비교가 가능하다.       
       
       
----------------------------------------------------------------------------------------------

    --- *** employees 테이블에 jubun(주민번호) 이라는 컬럼을 추가하겠다.  *** ---
    --- jubun(주민번호) 이라는 컬럼은 숫자 타입이 아니라 문자 타입이어야 한다.!!!
    select 9710201234567,  '9710201234567'
    from dual;
    -- 오른쪽 정렬이면 숫자
    -- 왼쪽정렬이면 문자
    
     select 0110201234567,  '01110201234567'
    from dual;
    
    -- 숫자타입인 경우 오라클에서 앞자리의 0은 생략해서 표현 한다.
    -- 따라서 생략되어 표현되지 않을려면 문자로 설정해주어야 한다.
    
    desc employees;
    
    alter table employees
    add jubun varchar2(13)
    
    -- varchar2(13) 최대 13자리가 온다.
       
       
       select *
       from employees;
 
 ---------------------------------------------------------------------------------------------- 주민번호 컬럼에 넣기.   
       update employees set jubun = '6010151234567'
where employee_id = 100;

update employees set jubun = '8510151234567'
where employee_id = 101;

update employees set jubun = '6510152234567'
where employee_id = 102;

update employees set jubun = '7510151234567'
where employee_id = 103;

update employees set jubun = '6110152234567'
where employee_id = 104;

update employees set jubun = '6510151234567'
where employee_id = 105;

update employees set jubun = '6009201234567'
where employee_id = 106;

update employees set jubun = '0803153234567'
where employee_id = 107;

update employees set jubun = '0712154234567'
where employee_id = 108;

update employees set jubun = '8810151234567'
where employee_id = 109;

update employees set jubun = '8908152234567'
where employee_id = 110;

update employees set jubun = '9005052234567'
where employee_id = 111;

update employees set jubun = '6610151234567'
where employee_id = 112;

update employees set jubun = '6710151234567'
where employee_id = 113;

update employees set jubun = '6709152234567'
where employee_id = 114;

update employees set jubun = '6110151234567'
where employee_id = 115;

update employees set jubun = '6009301234567'
where employee_id = 116;

update employees set jubun = '6110152234567'
where employee_id = 117;

update employees set jubun = '7810151234567'
where employee_id = 118;

update employees set jubun = '7909151234567'
where employee_id = 119;

update employees set jubun = '7702152234567'
where employee_id = 120;

update employees set jubun = '7009151234567'
where employee_id = 121;

update employees set jubun = '7111011234567'
where employee_id = 122;

update employees set jubun = '8010131234567'
where employee_id = 123;

update employees set jubun = '8110191234567'
where employee_id = 124;

update employees set jubun = '9012132234567'
where employee_id = 125;

update employees set jubun = '9406251234567'
where employee_id = 126;

update employees set jubun = '9408252234567'
where employee_id = 127;

update employees set jubun = '9204152234567'
where employee_id = 128;

update employees set jubun = '8507251234567'
where employee_id = 129;

update employees set jubun = '6511111234567'
where employee_id = 130;

update employees set jubun = '0010153234567'
where employee_id = 131;

update employees set jubun = '0005254234567'
where employee_id = 132;

update employees set jubun = '0110194234567'
where employee_id = 133;

update employees set jubun = '0412154234567'
where employee_id = 134;

update employees set jubun = '0503253234567'
where employee_id = 135;

update employees set jubun = '9510012234567'
where employee_id = 136;

update employees set jubun = '9510021234567'
where employee_id = 137;

update employees set jubun = '9610041234567'
where employee_id = 138;

update employees set jubun = '9610052234567'
where employee_id = 139;

update employees set jubun = '7310011234567'
where employee_id = 140;

update employees set jubun = '7310092234567'
where employee_id = 141;

update employees set jubun = '7510121234567'
where employee_id = 142;

update employees set jubun = '7612012234567'
where employee_id = 143;

update employees set jubun = '7710061234567'
where employee_id = 144;

update employees set jubun = '7810052234567'
where employee_id = 145;

update employees set jubun = '6810251234567'
where employee_id = 146;

update employees set jubun = '6811062234567'
where employee_id = 147;

update employees set jubun = '6712052234567'
where employee_id = 148;

update employees set jubun = '6011251234567'
where employee_id = 149;

update employees set jubun = '6210062234567'
where employee_id = 150;

update employees set jubun = '6110191234567'
where employee_id = 151;

update employees set jubun = '5712062234567'
where employee_id = 152;

update employees set jubun = '5810231234567'
where employee_id = 153;

update employees set jubun = '6311051234567'
where employee_id = 154;

update employees set jubun = '6010182234567'
where employee_id = 155;

update employees set jubun = '6110191234567'
where employee_id = 156;

update employees set jubun = '6210112234567'
where employee_id = 157;

update employees set jubun = '6311132234567'
where employee_id = 158;

update employees set jubun = '8511112234567'
where employee_id = 159;

update employees set jubun = '8710131234567'
where employee_id = 160;

update employees set jubun = '8710072234567'
where employee_id = 161;

update employees set jubun = '9010171234567'
where employee_id = 162;

update employees set jubun = '9112072234567'
where employee_id = 163;

update employees set jubun = '9110241234567'
where employee_id = 164;

update employees set jubun = '9212251234567'
where employee_id = 165;

update employees set jubun = '9310232234567'
where employee_id = 166;

update employees set jubun = '9811151234567'
where employee_id = 167;

update employees set jubun = '9810252234567'
where employee_id = 168;

update employees set jubun = '9910301234567'
where employee_id = 169;

update employees set jubun = '0910153234567'
where employee_id = 170;

update employees set jubun = '1011153234567'
where employee_id = 171;

update employees set jubun = '1006153234567'
where employee_id = 172;

update employees set jubun = '1111154234567'
where employee_id = 173;

update employees set jubun = '1209103234567'
where employee_id = 174;

update employees set jubun = '1207154234567'
where employee_id = 175;

update employees set jubun = '0906153234567'
where employee_id = 176;

update employees set jubun = '0812113234567'
where employee_id = 177;

update employees set jubun = '9810132234567'
where employee_id = 178;

update employees set jubun = '8712111234567'
where employee_id = 179;

update employees set jubun = '8310012234567'
where employee_id = 180;

update employees set jubun = '6510191234567'
where employee_id = 181;

update employees set jubun = '6510221234567'
where employee_id = 182;

update employees set jubun = '6510232234567'
where employee_id = 183;

update employees set jubun = '8512131234567'
where employee_id = 184;

update employees set jubun = '8510182234567'
where employee_id = 185;

update employees set jubun = '7510192234567'
where employee_id = 186;

update employees set jubun = '8512192234567'
where employee_id = 187;

update employees set jubun = '9511151234567'
where employee_id = 188;

update employees set jubun = '7509302234567'
where employee_id = 189;

update employees set jubun = '8510161234567'
where employee_id = 190;

update employees set jubun = '9510192234567'
where employee_id = 191;

update employees set jubun = '0510133234567'
where employee_id = 192;

update employees set jubun = '0810194234567'
where employee_id = 193;

update employees set jubun = '0910183234567'
where employee_id = 194;

update employees set jubun = '1010134234567'
where employee_id = 195;

update employees set jubun = '9510032234567'
where employee_id = 196;

update employees set jubun = '9710181234567'
where employee_id = 197;

update employees set jubun = '9810162234567'
where employee_id = 198;

update employees set jubun = '7511171234567'
where employee_id = 199;

update employees set jubun = '7810172234567'
where employee_id = 200;

update employees set jubun = '7912172234567'
where employee_id = 201;

update employees set jubun = '8611192234567'
where employee_id = 202;

update employees set jubun = '7810252234567'
where employee_id = 203;

update employees set jubun = '7803251234567'
where employee_id = 204;

update employees set jubun = '7910232234567'
where employee_id = 205;

update employees set jubun = '8010172234567'
where employee_id = 206;

commit;
       
       
  ----------------------------------------------------------------------------------------------        
       
       select *
       from employees;
       
           
    
  ----------------------------------------------------------------------------------------------     
                ---- >>> 단일행 함수 <<< ----
    /*
            ※ 단일행 함수의 종류 
            1. 문자함수
            2. 숫자함수
            3. 날짜함수
            4. 변환함수
            5. 기타함수
    */
       
       
  ----------------------------------------------------------------------------------------------     
       
                ---- >>> 1. 문자함수  <<< ----
                -- 1.1 upper() ==> 문자열을 모두 대문자로 변환 시켜주는것.
                -- 1.2 lower() ==> 문자열을 모두 소문자로  변환 시켜주는것.
                -- 1.3 initcap() ==> 문자열을 단어별(구분자가 공백) 첫글자만 대문자, 나머지는 모두 소문자로 변환
                select 'KoRea seOul', upper('KoRea seOul'), lower('KoRea seOul'),  initcap('KoRea seOul')
                from dual;
                
                select *
                from employees
                where last_name = 'King';
 
                 select *
                from employees
                where last_name = 'king'; 
                
                 select *
                from employees
                where last_name = 'KING'; 
                
                -- 오라클은 데이터 타입은 대,소문자 구분을 한다
                -- 네이버 처럼 대소문자 상관없이 결과물이 나와야함.
                
                select *
                from employees
                where last_name =  initcap ('KING'); 
                
                
                select * 
                from employees
                where initcap(last_name) = initcap('KING');
                
                 select *
                from employees
                where lower(last_name) =  lower('KING'); 


----------------------------------------------------------------------------------------------
        
    -- 1.4 substr : 문자열중 특정문자 또는 문자열의 특정 일부분을 선택해 올때 사용한다.
SELECT
    '쌍용교육센터',
    substr('쌍용교육센터',2,3) -- 2번째 글자부터 3글자를 뽑아라. => 용교육
   ,
    substr('쌍용교육센터',2) -- 2번째 글자부터 뽑을 글자수가 없으면 끝까지 뽑아 온다.
FROM
    dual;
--------- 연습 -----
SELECT
    '언젠가그날이오면'
    , substr('언젠가그날이오면', 4, 5)
    , substr('언젠가그날이오면', 4)
FROM
    dual;

        -- *** employees 테이블에서 성별이 '여자'만  사원번호, 사원명, 주민번호를 나타내세요.
            select
                    employee_id as 사원번호
                    , first_name || ' ' || last_name as 사원명
                    , jubun as 주민번호
            from employees
            where substr(jubun,7,1) in(2,4)
            --where substr(jubun,7,1) = 2 or  substr(jubun,7,1) = 4;  
            
            
            
SELECT
    employee_id   AS 사원번호,
    first_name || ' ' || last_name AS 사원명,
    jubun         AS 주민번호
FROM
    employees
WHERE
    substr(jubun,7,1) = 2
    OR substr(jubun,7,1) = 4; 
        -- where substr(jubun,7,1) in(2,4); 
        
        -- *** employees 테이블에서 1990년 ~ 1995년에 태어난사원중 성별이 '남자'만
        -- 사원번호, 사원명, 주민번호를 나타내세요. ***
        
        select
                      employee_id as 사원번호
                    , first_name || ' ' || last_name as 사원명
                    , jubun as 주민번호        
        from employees
        where substr(jubun, 1, 2) <='95' and substr(jubun, 1, 2) >='90'  and 
        substr(jubun, 7 , 1) in (1, 3);
        
        /*where substr(jubun, 1 , 2) between '90' and '95' 
                       and substr(jubun, 7,1) in(1,3); */
                       
        -- between은 오류가 안나는데 그냥하면 남. 이유는?
        
        
    
        
SELECT
    employee_id   AS 사원번호,
    first_name
    || ' '
    || last_name AS 사원명,
    jubun         AS 주민번호
FROM
    employees;
WHERE
    substr(jubun,1,2) BETWEEN '90' AND '95'
    AND substr(jubun,7,1)
    in(
        '1'
    );
    
         -- 조건식을 안붙임.
         
         --- **** 1.5  instr : 어떤 문자열에서 명명된 문자의 위치를 알려주는 것 **** --
         -- 인덱스와 같은 기능.

SELECT
    instr('쌍용교육센터 서울교육대학교 교육문화원','교육',1,1)
  
      -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육'이 나온 위치를 찾는데
      -- 출발점은 1 번째부터 1번째로 나오는 '교육'의 위치를 알려달라는 말이다.
      -- 3번째 있다 라는뜻.
   ,
    instr('쌍용교육센터 서울교육대학교 교육문화원','교육',1,2)
      -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육'이 나온 위치를 찾는데
      -- 1 번째 문자열부터 2번째로 나오는 '교육'의 위치를 알려달라는 말이다.
      -- 두번째의 교육의 문자열이 10번째 있다는것.
   ,
    instr('쌍용교육센터 서울교육대학교 교육문화원','교육',4,1)
      -- '쌍용교육센터 서울교육대학교 교육문화원' 에서 '교육'이 나온 위치를 찾는데
      -- 4번쨰 문자열부터  1번째로 나오는 교육의 위치를 알려달라는것
   ,
    instr('쌍용교육센터 서울교육대학교 교육문화원','교육',4,3)
      -- 없으면 0
   ,
    instr('쌍용교육센터 서울교육대학교 교육문화원','교육',1)
      --시작점만 나왔고 뒤가빠져있으면 첫번째
   ,
    instr('쌍용교육센터 서울교육대학교 교육문화원','교육',4)
    
    ,instr('쌍용교육센터 서울교육대학교 교육문화원','교육', -1, 1)
    -- -1 이라함은 역순으로 읽어오기.
    -- 교육을 찾는데 거꾸로 처음만난 교육의 위치값은 16.
    ,instr('쌍용교육센터 서울교육대학교 교육문화원','교육', -6, 1)
    -- 앞에서 부터 읽을꺼면 뭐하러 -을씀?;;
FROM
    dual;
         
 -----------
        SELECT
            instr('쌍용교육센터 서울교육대학교 교육문화원','교육', -6, 1)
        FROM dual;
        
         SELECT
             instr('쌍용교육센터 서울교육대학교 교육문화원', '교육', -1,1)
         FROM dual;
      --- 1.6 reverse : 어떤 문자열을 거꾸로 보여주는 것이다. *** --      
      select 'ORACLE' , reverse('ORACLE')
                    , '대한민국', reverse('대한민국')
                    , reverse(reverse('대한민국'))
      from dual;
      
      ------------------------------------------- [퀴즈] ---------------------------------------
  create table tbl_files
  (fileno      number(3)
  ,filepath    varchar2(200)
  );
  
  insert into tbl_files(fileno, filepath)
  values(1, 'c:\myDocuments\resume.hwp');
  
  insert into tbl_files(fileno, filepath)
  values(2, 'd:\mymusic.mp3');
  
  insert into tbl_files(fileno, filepath)
  values(3, 'c:\myphoto\2020\08\face.jpg');
  
  commit;
  

  
  -- 아래와 같이 나오도록 하세요. --
 /* 
  ---------------------------
    파일번호    파일명
  --------------------------- 
       1	   resume.hwp
       2	   mymusic.mp3
       3	   face.jpg
  ----------------------------
 */
  
  -- \수를 인덱스로 잡아서 파일명을 잡을수있다.
  -- 마지막 \뒤부터 끝까지.
  
            select
                                fileno as 파일번호,
                                reverse(substr(reverse(filepath),instr(reverse(filepath), '\', 1, 1) - 1)) as 파일명
            from tbl_files;
  
        
             select
                                fileno as 파일번호,
                                substr(filepath, instr(filepath, '\', -1 , 1) +1) as 파일명
            from tbl_files;           

  
  select 
  fileno as 파일번호,
  filepath as 파일경로,
  reverse (substr(reverse(filepath),1, (instr(reverse(filepath), '\',1)-1))) as 파일명,

  from tbl_files

--------------------- 복습후 완벽이해 ---------------------------------------------------------------------  
  SELECT
      fileno, filepath, reverse(filepath)
      , intstr(reverse(filepath), '\', 1)-1
      , substr(reverse(filepath), 1, intstr(reverse(filepath), '\', 1)-1)
      , reverse(substr(reverse(filepath), 1, intstr(reverse(filepath), '\', 1)-1)) as 파일명    
      , instr(filepath, '\', -1)+1
      , substr(filepath,  instr(filepath, '\', -1)+1)
  FROM tbl_files;
  
  
   ,instr('쌍용교육센터 서울교육대학교 교육문화원','교육', -1, 1)
   
  
  
  
  ---- *** 1.7 lpad : 왼쪽부터 문자를 자리채움 *** ----
  ---- *** 1.8 lpad : 오른쪽부터 문자를 자리채움 *** ----
  select lpad('교육센터', 20, '*') -- 20byte를 확보해서 거기에 '교육센터'를 넣습니다.  넣은 후 빈공간 (12byte)이 있으면 왼쪽부터 *로 채워라.
               , rpad('교육센터', 20, '*') -- 20byte를 확보해서 거기에 '교육센터'를 넣습니다.  넣은 후 빈공간 (12byte)이 있으면 오른쪽부터 *로 채워라.
  from dual;
  
  
  ---- *** 1.9 ltrim    : 왼쪽부터 문자를 제거한다 *** ----
  ---- *** 1.10 rtrim : 오른쪽부터 문자를 제거한다 *** ----
  ---- *** 1.11 trim : 왼쪽 오른쪽 부터 문자를 제거한다 *** ---
  
  select ltrim('abbbcccccppdbbbbppp', 'abcd'),   ---- ltrim은 왼쪽에서 부터  a or b or c or d 문자를 삭제하기시작해서 아닌문자가 나오면 멈춘다.
               rtrim('abbbcccppppccdbbbb', 'abcd'),  ---- ltrim은 오른쪽에서 부터  a or b or c or d 문자를 삭제하기시작해서 아닌문자가 나오면 멈춘다.
             --  trim('abbbcccppppTDdabSccdbbbb', 'abcd')  ---- trim은 공백만 제거한다.
               rtrim(ltrim('abbbcccccppdbbbbppp', 'abcd'), 'abcd')
            from dual;
            
            
            select '쌍용'  || '                         교육   센터 ' 
                        ,'쌍용'  || ltrim('               교육   센터')
                        ,'쌍용'  || ltrim('               교육   센터')  
                        , rtrim('쌍용                ') || '교육          센터'
                        , '쌍용' || trim('                      교육                ') || '센터'
            from dual;
  
  
    --- **** 1.12 translate **** ---
    select translate('010-3456-7890',
                                     '0123456789',
                                     '영일이삼사오육칠팔구')
                                     -- 해당문자열에서 0123456789가 존재한다라면 영일이삼사오육칠팔구로 바꿔줘라.
                                     -- 일대일로 반영.
                                     -- ex) 0을 영으로 1을 일로 ...
    from dual;
    -- 요즘은 잘 안쓴다.
    
    
    --- **** 1.13 replace **** ---
    select replace('쌍용교육센터 서울교육대학교 교육문화원'
                                    ,'교육'
                                    , 'education')
    from dual;
  
  -- 해당문자열에서 교육이라는 말을 지우고 education을 집어넣어라.
  
  
    --- **** 1.14 length => 문자열의 길이를 알려주는 것**** ---
    select length('쌍용center')
    from dual;
    
    --- **** ==== like 연산자  ==== **** ---
        select *
    from employees
    where department_id = 30;
    
    select *
    from employees
    where department_id like 30;  -- euqal과 같은 뜻이있음.
    
    /*
         like 연산자와 함께 사용되어지는 %와 _를 wild character 라고 부른다.
         like 연산자와 함께 사용되어지는 %의 뜻은 글자가 있든지(글자수와는 관계없음) 없든지 관계없다라는 말이고,
         like 연산자와 함께 사용되어지는 _의 뜻은 반드시 아무글자 1개만을 말함
    */
    
    SELECT
      frist_name || '  ' || last_name as 사원명
       , jubun as 주민번호
    from employees
    where jubun like '90____2%' or jubun like '90____1%';
                   -- employees 테이블에서 first _name 컬럼의 값이 'J'로 시작하는 사원들만 
                   -- 사원번호, 이름, 성, 기본급여를 나타내세요.
        select employee_id, first_name, last_name, salary
        from employees
        where  first _name like '%s%';
        
        select employee_id, first_name, last_name, salary
        from employees
        where  first _name like '%ee%';
    
        select employee_id, first_name, last_name, salary
        from employees
        where  first _name like '%e%e%';    
    
    select *
    from tbl_board
    where subject like '%건강%';
    
    select
         *
    from employees
    where last_name like 'F_e%';
    
    -- F로 시작하고 그다음 아무거 1 글자 상관없고그다음e 붙고 그다음에는 아무거나와도 상관없는 값.
    
    
    -- *** like 연산자와 함께 사용되어지는 % 와 _ 는 어떤 뜻을 가지고 있는 wild character 인데 
  --     이러한 wild character 를 없애버리도록 해본다. *** --
  create table tbl_watch
  (watchname   Nvarchar2(10)  -- korea 
  ,bigo        Nvarchar2(100)         -- 
  

  );
  
  insert into tbl_watch(watchname, bigo)
  values('금시계', '순금 99.99% 함유 고급시계');
  
  insert into tbl_watch(watchname, bigo)
  values('은시계', '고객만족도 99.99점 획득한 고급시계');
  
  commit;
  
  -- tbl_watch 테이블에서 bigo 컬럼에 99.99% 라는 글자가 들어있는 행만 추출하세요 --
    
  select *
  
  from tbl_watch;
  
    
      select *
  from tbl_watch
  where bigo like '%99.99%%' escape '\';
  
  --- \ 다음에 나오는  % 1개만을  wiild character 기능에서 탈출시켜야만 퍼센트라고 인식된다.
  
      select *
  from tbl_watch
  where bigo like '%99,99a%%' escape 'a';
  
  --- a 다음에 나오는  %1개만을  wiild character 기능에서 탈출시켜야만 퍼센트라고 인식된다.  
    
    
       ------- >>>> 2. 숫자함수 <<< -------------------------------------------------   
       
       --2.1 mod : 나머지를 구해주는것.
       select 5/2, mod(5,2), trunc(5/2)
        -- mod 5를 2로 나누었을때 나머지 
        -- trunc (5/2) 5를 2로 나누었을때 몫.
        
       from dual;
       
       
        --2.2 round : 반올림을 해주는 것.
        
        select : 94.547
                      , round(94.547) -- 95
                      , round(94.547, 0)        ---   95       0은 정수 1자리까지만 나타내어준다.  
                      , ROUND((94.547,1))        ---   94.5    1은 소수 첫자리까지만 나타내어준다.
                      , round(94,547, 2)        ---   94.55    2은 소수 둘째자리까지만 나타내어준다.
                      , round(94,547, -1)        --- 90     -1은 정수 10자리까지만 나타내어준다.
                      , round(94,547, -2)        --- 100      -2은 정수 100자리까지만 나타내어준다. 
                      from dual;

        select : 95.111
                    , round(95.111)
                    from dual;
                    
        --2.3 trunc  : 절삭 해주는 것.    
        select : 94.547
                      , trunc(94.547)            -- 94
                      , trunc(94.547, 0)       -- 94       0은 정수 1자리까지만 나타내어준다.  
                      , trunc(94,547, 1)       -- 94.5    1은 소수 첫자리까지만 나타내어준다.
                      , trunc(94,547, 2)       -- 94.54    2은 소수 둘째자리까지만 나타내어준다.
                      , trunc(94,547, -1)      -- 90     -1은 정수 10자리까지만 나타내어준다.
                      , trunc(94,547, -2)      -- 0      -2은 정수 100자리까지만 나타내어준다. 
                      from dual;
        
        
        create table tbl_sungjuk
(hakbun   varchar2(20) 
,name     varchar2(20)
,kor      number(3)
,eng      number(3)
,math     number(3)
);

insert into tbl_sungjuk(hakbun, name, kor, eng, math)
values('SIST001','한석규', 90, 92, 93);

insert into tbl_sungjuk(hakbun, name, kor, eng, math)
values('SIST002','두석규', 100, 100, 100);

insert into tbl_sungjuk(hakbun, name, kor, eng, math)
values('SIST003','세석규', 71, 72, 73);

insert into tbl_sungjuk(hakbun, name, kor, eng, math)
values('SIST004','네석규', 89, 87, 81);

insert into tbl_sungjuk(hakbun, name, kor, eng, math)
values('SIST005','오석규', 60, 50, 40);

insert into tbl_sungjuk(hakbun, name, kor, eng, math)
values('SIST006','육석규', 80, 81, 87);

select *
from tbl_sungjuk;

commit;
    
--------------------------------------------------------------------------------------------
학번      성명      국어      영어      수학      총점      평균(소수부첫째자리까지 나타내되 반올림)          학점(평균이 90이상이면 'A' 90미만 80이상이면 'B' .....  60미만이면 F)

select
        hakbun as 학번
        , name as 성명
        , kor as 국어
        , eng as 영어
        , math as 수학
        ,  kor + eng + math as 총점
        ,  round((kor + eng + math)/3, 1) as 평균
        ,  case 
            when round((kor + eng + math)/3, 1) > 95 then 'A+'
            when round((kor + eng + math)/3, 1) > 90 then 'A'
            when round((kor + eng + math)/3, 1) > 80 then 'B'
            when round((kor + eng + math)/3, 1) > 70 then 'C'
            when round((kor + eng + math)/3, 1) > 60 then 'D'
            else 'F'
            end as 학점
from tbl_sungjuk;
    
    

select hakbun, name ,kor, eng, math,
                  (kor +eng+math) as 총점
                , round((kor +eng+math)/3,1) as 평균
                , case trunc(round((kor +eng+math)/3,1), -1)
                  when 100 then 'A+'
                  when 90 then 'A'
                  when 80 then 'B'
                  when 70 then 'C'
                  when 60 then 'D'
                  else 'F'
                  end as 학점
from tbl_sungjuk;    


select hakbun, name ,kor, eng, math,
                  (kor +eng+math) as 총점
                , round((kor +eng+math)/3,1) as 평균
                , decode(trunc(round((kor +eng+math)/3,1), -1), 100, 'A+' 
                , decode(trunc(round((kor +eng+math)/3,1), -1), 90, 'A' 
                , decode(trunc(round((kor +eng+math)/3,1), -1), 80, 'A+' 
                , decode(trunc(round((kor +eng+math)/3,1), -1), 70, 'A+' 
                , decode(trunc(round((kor +eng+math)/3,1), -1), 60, 'A+' 
                                                                                                                , , , 'F' ) 
 
                  end as 학점
from tbl_sungjuk;    
    -- 디코드로 수업후 고치기.
    
    
    
    
        --2.4 power : 거듭제곱.
        
        select 2*2*2*2*2 , power(2,5)
        from dual;

    
        --2.5 sqrt : 제곱근(루트)
        select sqrt(4), sqrt(16), sqrt(2), 
        from dual;
        
        --2.6 sin, cos, tan, asin, acos, atan
                    asin(0,3), acos(0,3), atan(0,3)
        from dual;
        
         --2.7 log
         select log(10, 100)
         from dual;
        
        
        --2.8 ascii , chr
        
        select ascii('A'), ascii('a'), ascii('0'), ascii(' ')
        from dual;
        
        select chr(65), chr(97), chr(48), chr(32)
        from dual;  
        

        --2.9 sign ==> 결과값이 양수이라면 1, 결과값이 0이라면 0, 결과값이 음수이라면 -1
        select sign(5-2), sign(0), sign(-2)
        from dual;
        
        
        --2.10 ceil, floor
        --ceil(실수) ==> 입력되어진 실수 보다 큰 최소의 정수를 나타내어 준다.
        --ceil(정수) ==> 입력되어진 정수 그대로 나온다.
        
        select ceil(10, 1), ceil(-10, 1), ceil(10), ceil(-10)
        from dual;
        
        
        --floor(실수) ==> 입력되어진 실수 보다 작은 최소의 정수를 나타내어 준다.
        --floor(정수) ==> 입력되어진 정수 그대로 나온다.
        SELECT floor(10, 1), floor(-10, 1), floor(10), floor(-10)
        FROM dual;
        
        
         ------- >>> 3. 날짜함수 <<< ------
         
         
       -- Date 타입의 기본적인 표현방식은 'RR/MM/DD' 으로 나타내어진다.
                                                    -- RR은  년도의 2자리만 나타내어주는데 50 ~ 99은 1950 ~ 1999 이다.
                                                    -- RR은  년도의 2자리만 나타내어주는데 00 ~ 49은 2000 ~ 2049 이다.
                                                    -- MM은 월이고 , DD는 일이다.

        -- *** 현재 시각을 알려주는것 *** --

        
        select sysdate, current_date, localtimestamp, current_timestamp, systimestamp
        -- sysdate 시스템 날짜.
        -- localtimestamp 시간
        -- current_timestamp 지역 장소까지
        -- systimestamp 그리니치 시간을 기준으로 비교 해줌.
        from dual;
        -- dual 조건을 줄 테이블이 없을경우 dual을 넣어 처리한다.
        
                
        /*
                날짜 + 숫자 = 날짜
                날짜 - 숫자 = 날짜
                
                여기서 숫자의 단위는 일수 이다.
                
        */
        
        select sysdate -1 as 어제시각
                    ,sysdate  as 현재시각
                    ,sysdate +1 내일시각
                    from dual;
                    
        
        select to_char(sysdate -1 , 'yyyy-mm-dd hh24:miss') as 어제시각
                    ,to_char(sysdate  , 'yyyy-mm-dd hh24:miss') as 현재시각
                    ,to_char(sysdate +1 , 'yyyy-mm-dd hh24:miss') as 내일시각
        from dual;
                    
        
        -- 1 kg = 1000g
        -- 1 g = 1/1000 kg
        -- 1일 = 24시간
        -- [퀴즈] 현재시각 및 현재시각으로 부터 1일 2시간 3분 4초 뒤를 나타내세요.
        --              yyyy-mm-dd hh24:mi:ss 
        
        select 
        to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') as 현재시각
                      , to_char(sysdate +1 + 2/24 + 3/(24/60) + 4/(24*60*60),  'yyyy-mm-dd hh24:mi:ss') as ㅎㅎ
        from dual;
        
        
        -- 3.1 add_months(날짜, 숫자) => 날짜에서 숫자만큼 개월수를 더해주는 것 숫자는 단위가 개월수이고 결과값은 날짜가 나온다.
        
                select to_char(add_months(sysdate, -2), 'yyyy-mm-dd hh24:miss') as "2개월전"
                    ,to_char(sysdate, 'yyyy-mm-dd hh24:miss') as 현재
                    ,to_char(add_months(sysdate, +2) , 'yyyy-mm-dd hh24:miss') as "2개월후"
        from dual;
                    
        
        --- *** 오늘 부로 홍길동씨가 또 군대에 끌려갑니다.
        --- 근무개월수가 18개월이라고 할때 제대일자(년월일)를 구하세요.
        
        select to_char(add_months(sysdate, 18), 'yyyy-mm-dd') as "제대날짜"
        ,to_char(sysdate, 'yyyy-mm-dd') as 현재
    
        from dual;
        
         -- 3.2  months_between(날짜1, 날짜2)
         --          날짜1 - 날짜2 를 뺀 값으로 숫자가 나오는데 그단위는 개월 수 이다.
         --           즉, 두 날짜의 개월차이를 구할때 사용하는것이다.
         
         -- 날짜1 - 날짜2은  숫자가 나오는데 그 단위는 일수이다.
         
         select months_between(add_months(sysdate, 18), sysdate )
         from dual;
         
          -- 3.3  last_day(특정날짜) ==> 특정날짜가 포함된 달력에서 맨 마지막날을 알려주는 것이다.
            select to_char(last_day(sysdate), 'yyyy-mm-dd')
                        , last_day('2019-02-05') 
                        , last_day(to_date('2019-02-05', 'yyyy-mm-dd'))
                        , to_char(last_day(to_date('2020-02-05', 'yyyy-mm-dd')), 'yyyy-mm-dd')
            from dual;          
            
/*
   [퀴즈]
   employees 테이블에서
   사원번호, 사원명, 주민번호, 성별, 현재나이, 월급, 입사일자, 정년퇴직일 을 나타내세요.

   여기서 정년퇴직일이라 함은 
   해당 사원의 생월이 3월에서 8월에 태어난 사람은 
   해당 사원의 나이(한국나이)가 63세가 되는 년도의 8월 31일로 하고,
   해당 사원의 생월이 9월에서 2월에 태어난 사람은 
   해당 사원의 나이(한국나이)가 63세가 되는 년도의 2월말일(2월28일 또는 2월29일)로 한다.
*/

SELECT
    employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명
    , jubun as 주민번호
    , case 
                    when substr(jubun, 7,1) in(1,3) then '남'
                    else '여'
                    end
                    as 성별 
    , extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1 AS 현재나이
    , nvl(salary+(salary*commission_pct),salary) as 월급
    , to_char(hire_date, 'yyyy-mm-dd') as 입사일자 
    , to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number(substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS 정년퇴직일
FROM employees
order by 1;

select
            case 
            when substr(jubun, 7 , 1) in(1,2) then to_char(sysdate, 'yyyy') - ('19' || substr(jubun, 1, 2))
            when substr(jubun, 7 ,1) in(3,4) then '20' || substr(jubun, 1, 2)
            else     '외계인'
            end as 생년월일
            
from employees;

select
      employee_id, jubun,  
      to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number( substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS 정년퇴직일
      
      -- 문자열이 날짜형식이면 오라클이 자동적으로 형변환해줌.
      
from employees
order by 1;


        -- 3.4         next_day (특정날짜, '일') '일'~'토'
        --                 ==> 특정날짜로 부터 다음번에 돌아오는 가장 빠른 '일'~'토' 의 날짜를 알려주는 것이다.
        select sysdate
                     , next_day(stsdate, '금') 
                     , next_day(stsdate, '토') 
                     , next_day(stsdate, '금') 
        from dual;
        
        
        -- 3.5          extract ==> 날짜에서 년, 월, 일을 숫자형태로 추출해주는 함수이다.
        select sysdate
                , extract(year from sysdate), to_char(sysdate, 'yyyy')
                , extract(month from sysdate), to_char(sysdate, 'mm')
                , extract(day from sysdate), to_char(sysdate, 'dd')
                , extract(month from sysdate)
        from dual;
        
        
        
        -- 3.6          to_yminterval, to_dsinterval
        --                  현재일로 부터 1년 2개월 3일 4시간 5분 6초 뒤를 나타내시오.
        
        select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss') as nowtime
                    , to_char(sysdate + to_yminterval('01-02') + to_dsinterval('003 04:05:06'), 'yyyy-mm-dd hh24:mi:ss' ) as addtime
                    -- to_yminterval('01-02') 뜻은 1년 2개월을 더해라.
                    -- to_dsinterval('003 04:05:06') 며칠 / 몇 시간/ 몇 분 / 몇 초
                    -- as(엘리야스) 30글자 이내여야함.
                    
        from dual ;
  ---------------------테이블 tbl_loan 삽입절------------------------------------------------------      
        create table tbl_loan
(gejanum        varchar2(10)   -- 통장번호
,loanmoney      number         -- 대출금
,interestrate   number(2,2)    -- 이자율
,paymentdate    varchar2(2)    -- 이자를내는날짜 '01', '05', '16', '20', 매월말일 '00'
);           

insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate)
values('10-1234-01', 5000, 0.03, '01');

insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate)
values('10-1234-02', 5000, 0.03, '05');

insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate)
values('10-1234-03', 5000, 0.03, '16');

insert into tbl_loan(gejanum, loanmoney, interestrate, paymentdate)
values('10-1234-04', 5000, 0.03, '00');

commit;
        
    -----------------------------------------------------------------------------------------------------------------    
        -- 이자를 내야하는 날짜.

        
        ----  *** 해당날짜에 대한 요일명을 알아오는 것 *** ----
        select to_char(sysdate , 'day') -- 윈도우는 '금요일'  리눅스는 'Friday'
                   , to_char(sysdate , 'dy') -- 윈도우는 '금'          리눅스는  ' Fri'
                   , to_char(sysdate , 'd')  -- 6  
        from dual;
        
       select to_char(sysdate , 'day') -- 윈도우는 '금요일'  리눅스는 'Friday'
                   , to_char(sysdate , 'dy') -- 윈도우는 '금'          리눅스는  ' Fri'
                   , to_char(sysdate , 'd')  -- 6               6           1(일) 2(월) 3(화) 4(수) 5(목) 6(금) 7(토)  // 운영체제별로 요일의 언어값이 다르기나오기 때문에 그냥 숫자로 처리해서 사용한다.
                   
        from dual;
        
        select decode(to_char(sysdate, 'd'), '1', '일'
                                                                           , '2', '월'
                                                                           , '3', '화'
                                                                           , '4', '수'
                                                                           , '5', '목'
                                                                           , '6', '금'
                                                                           , '7', '토') AS 오늘의 요일명  -- case나 decode를 사용해서 숫자를 원하는 문자열의 언어로 처리해주면 동일하게 얻을수있음.
        from dual;
        
        
        select gejanum, loanmoney, interestrate, paymentdate
                        ,decode( to_char(thispaymentdate, 'd' ), '1', thispaymentdate+1
                                                                                                  , '7', thispaymentdate+2
                                                                                                  ,        thispaymentdate) as 이번달이자납부일
                       ,   decode( to_char(prevpaymentdate, 'd' ), '1', prevpaymentdate+1
                                                                                                  , '7', prevpaymentdate+2
                                                                                                  ,        prevpaymentdate) as 저번달이자납부일                                                                        
                                                                                                  
        from
        (
        select gejanum, loanmoney, interestrate, paymentdate
                    , decode(paymentdate, '00',  last_day(sysdate)
                                                                         ,  to_char(sysdate, 'yyyy-mm-') ||  paymentdate)

                    as thispaymentdate
                    , decode(paymentdate, '00',  last_day(add_months(sysdate, -1) )
                                                                         ,  to_char(add_months(sysdate, -1), 'yyyy-mm-') ||  paymentdate)

                    as prevpaymentdate
        from tbl_loan
         ) V; 
         
---------------------------------------------------------------------------------------

         select T.*
         , (이번달이자납부일-  저번달이자납부일)*loanmoney*interestrate
         from 
         -- 날짜에서 날짜를 빼면 일수.
(
          select gejanum, loanmoney, interestrate, paymentdate
                        ,decode( to_char(thispaymentdate, 'd' ), '1', thispaymentdate+1
                                                                                                  , '7', thispaymentdate+2
                                                                                                  ,        thispaymentdate) as 이번달이자납부일
                       ,   decode( to_char(prevpaymentdate, 'd' ), '1', prevpaymentdate+1
                                                                                                  , '7', prevpaymentdate+2
                                                                                                  ,        prevpaymentdate) as 저번달이자납부일                                                                        
                                                                                                  
        from
        (
        select gejanum, loanmoney, interestrate, paymentdate
                    , decode(paymentdate, '00',  last_day(sysdate)
                                                                         ,  to_char(sysdate, 'yyyy-mm-') ||  paymentdate)

                    as thispaymentdate
                    , decode(paymentdate, '00',  last_day(add_months(sysdate, -1) )
                                                                         ,  to_char(add_months(sysdate, -1), 'yyyy-mm-') ||  paymentdate)

                    as prevpaymentdate
        from tbl_loan
         ) V
  )T;       
  
---------------------------------------------------------------------------------------
        
     select gejanum, loanmoney, interestrate, paymentdate,
                        decode( to_char(thispaymentdate, 'd' ), '1', thispaymentdate+1
                                                                                                  , '7', thispaymentdate+2
                                                                                                  ,        thispaymentdate) as 지난달이자납부일
                                                                                                                                                                                      
        from
        (
        select gejanum, loanmoney, interestrate, paymentdate
                    , decode(paymentdate, '00',  last_day(add_months(sysdate, -1) )
                                                                         ,  to_char(add_months(sysdate, -1), 'yyyy-mm-') ||  paymentdate)

                    as prevpaymentdate
        from tbl_loan
         ) V;                  
        
        select 
        add_months(sysdate, -1)
        from dual;
        
        
        
        














-------- ***************** 아주아주아주아주아주아주아주!@#!@#!@#!@$!@#!@$!@#$%%^&*() 꼭암기 ***********
-------- inline view (인라인 뷰)
/*
        View(뷰)는 테이블은 아니지만 select 되어진 결과물이 테이블 형태로 띄기 때문에
        select 구문을 마치 테이블 처럼 보는것(간주하는 것)
        
        View(뷰)의 종류는 inline view (인라인 뷰) 와 stored View(저장된 뷰)가 있다.
        inline view (인라인 뷰)는 1회용이라고 보면 되겠고,
        Stored View(저장된 뷰)는 저장되었기 때문에 언제든지 꺼내어 사용할 수 있다.
*/

------- 전체를 select 결과를 테이블로 간주하자.
------- 정년퇴직일 그대로 쓸수있음 그게 컬럼이니까.


-- *** 퇴직금이라함은 근무년수 * 월급 으로 하겠다. ***
--          만약에 27.3개월 근무를 했다라면 27/12 * 월급 ==> 2.25 * 월급 ==> trunc (2.25) * 월급
--          정년퇴직일에서 입사일까지 개월의 차이를 구하면 되겠다. 
--          trunc( trunc(months_between(정년퇴직일, 입사일) ) / 12) * 월급          


select V.*
             , trunc( trunc(months_between(V.정년퇴직일, V.입사일자) ) / 12) * V.월급  AS 퇴직금     
from
(
SELECT
    employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명
    , jubun as 주민번호
    , case 
                    when substr(jubun, 7,1) in(1,3) then '남'
                    else '여'
                    end
                    as 성별 
    , extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1 AS 현재나이
    , nvl(salary+(salary*commission_pct),salary) as 월급
    , to_char(hire_date, 'yyyy-mm-dd') as 입사일자 
    , to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number(substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS 정년퇴직일
FROM employees
) V -- V를 inline view 라고 부른다.
where V.현재나이 < 30;

--- 전체 ()안에 테이블을 V로 간주.
select 27/12 from dual;

 select V.*
             , trunc( trunc(months_between(정년퇴직일, 입사일자) ) / 12) * 월급  AS 퇴직금     
from
(
SELECT
    employee_id as 사원번호
    , first_name || ' ' || last_name as 사원명
    , jubun as 주민번호
    , case 
                    when substr(jubun, 7,1) in(1,3) then '남'
                    else '여'
                    end
                    as 성별 
    , extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1 AS 현재나이
    , nvl(salary+(salary*commission_pct),salary) as 월급
    , to_char(hire_date, 'yyyy-mm-dd') as 입사일자 
    , to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number(substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS 정년퇴직일
FROM employees
) V -- V를 inline view 라고 부른다.
where 현재나이 >= 50 and 성별='여';
            
-- V.은 생략이 가능하다. 다만 처음에 칼럼의 전체를 보여주려면 V.*은있어야함.
         
         
         
 ---- >>> *** Stored View(저장된 뷰) *** <<< ---
 create or replace view  view_employees_retire
 as
 SELECT
    employee_id
    , first_name || ' ' || last_name as ename
    , jubun
    , case 
                    when substr(jubun, 7,1) in(1,3) then '남'
                    else '여'
                    end
                    as gender
    , extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1 AS age
    , nvl(salary+(salary*commission_pct),salary) as monthsal
    , to_char(hire_date, 'yyyy-mm-dd') as  hire_date
    , to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number(substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS retire_date
FROM employees;

----- view가 생성이 안됬음. 

select *
from view_employees_retire;
 
select employee_id, ename, jubun, gender, age, monthsal, hire_date, retire_date
            , trunc( trunc(months_between(정년퇴직일, 입사일자) ) / 12) * 월급  AS 퇴직금   
from view_employees_retire
where age >= 50 and gender '남';

create or replace view view_abcd
as
select  * from employees;
-- ORA-00936: missing expression
-- 00936. 00000 -  "missing expression select 범위 빼먹음

select * from tab;
-- 현재 오라클 서버에 접속한 사용자(지금은 HR) 소유의 테이블명과 뷰명을 조회해주는것. 
-- 테이블명 작명하는 법
-- 처음부터 view 해주면됨.         
-- view, table 앞에 표시하고 _해서  가독성을 높임..

--- *** 테이블이나 뷰를 생성한 이후에는 반드시 코멘트(주석)을 꼭 달아 주도록 합시다.!!! *** ---
select *
from user_tab_comments;

comment on table view_employees_retire
is '사원들의 정년퇴직일과 퇴직금을 알려주는 VIEW';

comment on table view_abcd is '연습용 저장용 뷰 생성';
--- *** 생성되어진 테이블이나 뷰의 컬럼에도 반드시 코멘트(주석)를 꼭 달아 주도록 합시다. !!! *** ---
select column_name, comments
from user_col_comments
where table_name = 'EMPLOYEES';

comment on column employees.JUBUN
is '주민등록번호';

-- 오라클은 컬럼명 테이블이름은 전부 대문자로 됨.


comment on column VIEW_EMPLOYEES_RETIRE.gender
is '성별';

comment on column VIEW_EMPLOYEES_RETIRE.retire_date
is '정년퇴직일자';


select *
from view_employees_retire;

select *
from view_abcd;
-- 그냥 뷰 싹다 가져오면

---- **** stored View(저장되어진 View)의 원본소스(select문)를 보겠다. **** ----
select text
from user_Views
where view_name = 'VIEW_EMPLOYEES_RETIRE';

select text
form user_Views
where view_name = 'view_abcd';


select text
from user_Views
where view_name = 'VIEW_EMPLOYEES_RETIRE';
         
/*
"SELECT
    employee_id
    , first_name || ' ' || last_name as ename
    , jubun
    , case 
                    when substr(jubun, 7,1) in(1,3) then '남'
                    else '여'
                    end
                    as gender
    , extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1 AS age
    , nvl(salary+(salary*commission_pct),salary) as monthsal
    , to_char(hire_date, 'yyyy-mm-dd') as  hire_date
    , to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number(substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS retire_date
FROM employees"
*/
         
         
---- **** stored View(저장되어진 View)의 원본소스(select문)를 변경하겠다. **** ----         
--- 안에있는 소스를 바꿀때.

create or replace view VIEW_EMPLOYEES_RETIRE
as
select department_id, department_name
from departments;

select text
from user_Views
where view_name = 'VIEW_EMPLOYEES_RETIRE';
         

create or replace view VIEW_test1
-- 생성하거나 기존것이 있다면 대체해라 아래의 문으로.
as
select employee_id, first_name, salary
from employees;         
         
select *
from VIEW_test1;

select *
from user_views;

select * from tab;

-- ****view를 삭제하기. **** -----
drop view view_test1;
drop view view_abcd;

select *
from tab;

-- 현재 있는 테이블명령 보기 --

      ------- >>>> 5. 변환함수 <<< -------------------------------------------------
      -- 4.1                to_char() => 날짜를 문자형태로 변환, 숫자를 문자형태로 변환
      
      select to_char(sysdate, 'yyyy') AS 년도
      , to_char(sysdate, 'mm') AS 월
      , to_char(sysdate, 'dd') AS 일
      , to_char(sysdate, 'hh24') AS "24시간"
      , to_char(sysdate, 'hh am') AS "12시간"
      , to_char(sysdate, 'hh pm') AS "12시간"
      , to_char(sysdate, 'mi') AS 분
      , to_char(sysdate, 'ss') AS 초
      , to_char(sysdate, 'q') AS 분기 --  1월~3월 : 1 , 4월~6월 : 2 , 7월~9월 : 3 , 10월~12월 : 4   
      , to_char(sysdate, 'day') AS 요일명
      , to_char(sysdate, 'dy') AS 요일명
 from dual;
 

 select to_char(sysdate, 'yyyy') as 년도
              ,to_char(sysdate, 'mm') as 월
              , to_char(sysdate, 'dd') as 일
              , to_char(sysdate, 'hh24') as 시간
              , to_char(sysdate, 'hh24') as 시간
              , to_char(sysdate, 'hh am') as "12시간"
              , to_char(sysdate, 'hh pm') as "24시간"
              , to_char(sysdate, 'mi') as 분
              , to_char(sysdate, 'ss') as 초
              , to_char(sysdate, 'q') as 분기
              , to_char(sysdate, 'day') as 요일
              , to_char(sysdate, 'dy') as 요일
              , to_char(sysdate, 'd') as
              from dual;
              
              -- 은퇴 나이는 63세 입사 날짜가 1~6월 이라면 6월 30일 아니면 2월 29일로 
              -- 
               select     부서번호, 사원명
                               ,  to_char(last_day((63-나이) + extract(year from sysdate) || case when extract(month from hire_date) between 1 and 6 then '06-01'
                                  else '02-01') , 'yyyy-mm-dd') as 은퇴일자
              
              from 
              (
              select
              first_name || '    '  ||last_name as 사원명
              , department_id as 부서번호
              ,case 
              when substr(jubun, 7, 1) in (1,2) then extract(year from sysdate) - (substr(jubun, 1, 2) + 1901) else  extract(year from sysdate) - (substr(jubun, 1, 2) + 2001) end as 나이 
              
              from employees
              ) V;
              
              --------------------------------------------------------------------------------------------------------------------------
              
              select
              
             
              
              as 은퇴년도
              from employees;
              
              select
              case when extract(month from hire_date) between 1 and 6 then extract(year from sysdaye)  + (63-나이) || '06-01' else  extract(year from sysdaye)  + (63-나이) || '02-01' end as 은퇴년
              from employees;
              
   
              select
      employee_id, jubun,  
      to_char(  last_day( extract(year from sysdate)+(63 - (extract (year from sysdate) - ( substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1)) 
      || case when to_number( substr(jubun, 3,2) ) between 3 and 8 then '-08-01' else '-02-01' end )  , 'yyyy-mm-dd')      AS 정년퇴직일
      
      -- 문자열이 날짜형식이면 오라클이 자동적으로 형변환해줌.
      
from employees
order by 1;
              
              
              
 select to_char(sysdate, 'ddd') -- 올해 1월 1일부터 현재까지
      , to_char(to_date('2014-02-02', 'yyyy-mm-dd'), 'ddd')
      , to_char(sysdate, 'dd')  -- 
      , to_char(sysdate, 'd') -- 요일
 from dual;
 
 select to_date('2014-07-05', 'yyyy-mm-dd')
 from dual;
 select to_char(sysdate, 'sssss')
 from dual;
 -- 이날짜에 자정(0시0분0초) 부터 현재까지 몇초 째냐
 
 select 123456789
      , to_char(123456789, '999,999,999')
      , to_char(123456789, '$999,999,999') -- 통화기호도 붙여주면됨.
      , to_char(123456789, 'L999,999,999') -- 대문자 L쓰면 그지역의 화폐의 단위 표시가 붙음.
  from dual;
      -- 돈같은경우는 3자리마디 콤마를 찍어준다. 9는 숫자를 의미함.
      -- 숫자가 9개 나오는데 3자리마다 콤마를 찍어라.
           
      -- 4.2                to_date() => 문자를 날짜형태로 변환
        select  to_date('2020-08-13', 'yyyy-mm-dd')  +1
        from dual;
        -- 문자를 날짜형식으로 바꿔야함 그래서 첫번째 부분에 ''가들어감.
      -- 4.3                to_number() => 문자를 숫자형태로 변환
      select to_number('5') + to_number('2') 
      -- 4.4 
      
      
      
    
      select sysdate - to_date('20140705', 'yyyy-mm-dd')
      from dual;
      
      
      
      
      
      
      
      
      
      ----------------------------------------------------------------------------------
      ------- >>>> 5. 기타함수 <<< -------------------------------------------------
      
      --switch case문과 비슷한놈.
       -- 자주쓰는거니 꼭 암기할것.
      -- 5.1  case when then else end (암기!!!)
      select case 5-2
                  when 4 then '5-2=4 입니다.'
                  when 1 then '5-2=1 입니다.'
                  when 0 then '5-2=3 입니다.'
                  else '나는 수학을 몰라요 ㅜㅜ'
                  end AS 결과
      from dual;
      
    
    select case 5-1
                when 1 then '1-1=0 이다'
                when 2 then '나는 어마어마하게 돈을 많이 벌것이다.'
                when 3 then '언젠가 그날이 올것이다.'
                when 4 then '그때는 반드시 온다.'
                else ' 믿음은 바라는것들의 실상, 보이지 않는것들의 증거.'
                end AS 결과
                from dual;
                
                
      -- 참거짓만 나타낼때.
       select case 
                  when 4 >5 then '4는 5보다 큽니다.'
                  when 5 > 7 then '5는 7보다 큽니다'
                  when 3 > 2 then '3은 2보다 큽니다.'
                  else '나는 수학을 몰라요 ㅜㅜ'
                  end AS 결과
      from dual;
      
      select case
                    when 5>6 then '진리가 너희를 자유케 하리라'
                    when 2>7 then '태초에 하나님이 천지를 창조하시느니라'
                    when 3>8 then '의인은 오직 믿음으로 살리라'
                    when 1>9 then '너희는 먼저 그나라와 그의를 구하라 그리하면 너희에게 모든것들을 더하시리라.'
                    else '믿음으로 믿음에 이른다 '
                    end AS 말씀
                    from dual;
       ----------------------------------------------------------------------------------     
      
      -- 5.2 decode 
      select decode(5-2, 4, '5-2=4 입니다'
                                          ,1, '5-2=1 입니다.'  
                                          ,6, '5-2=3 입니다.'
                                          , '나는 수학을 몰라요') AS 결과                                         
          from dual;
      -- 첫번쨰항이 두번째항이 같다라면 세번째항을 보여줌.
      
      
       ----------------------------------------------------------------------------------
    /*   
       -- employees 테이블에서 아래와 같이 나오도록 하세요.
       ----------------------------------------------------------------------------------
       -- 사원번호 사원명 주민번호 성별 --
       ----------------------------------------------------------------------------------       
               ...                          ...          961210212  남
       
              */
      
      SELECT 
             employee_id as 사원번호
          , first_name || ' ' || last_name as 사원명
          , jubun as 주민번호
          , case  substr(jubun, 7, 1)
          when '1' then '남'
          when '3' then '남'
          when '2' then '여'
          when '4' then '여'
          -- 문자열 함수이니 '' 문자열 처리를 해줘야함.
          else '외계인'
          end AS 성별,
          case substr(jubun, 7, 1)
          when '1' then to_char(substr(jubun, 1,2), '19' + substr(jubun, 1,2))
          when '2' then to_char(substr(jubun, 1,2), '19' + substr(jubun, 1,2))
          when '3' then to_char(substr(jubun, 1,2), '20' + substr(jubun, 1,2)) 
          when '4' then to_char(substr(jubun, 1,2), '20' + substr(jubun, 1,2)) 
          else '외계인'
          end AS 태어난년도
         -- 2000년도랑 1900년도.
         -- 뒤에숫자로 구분
         -- to_char로 변경 경우적용해서.
         
      FROM employees;
      
      SELECT 
       employee_id as 사원번호
       ,first_name || last_name as 사원명
       ,jubun as 주민번호,      
      decode(substr(jubun, 7, 1),'1', '남'
                                                         ,'3', '남'
                                                         ,'2', '여'
                                                         ,'4', '여') AS 성별
      FROM employees;
      
      
      
      select sysdate
                , to_char (sysdate, 'yyyy')
                , extract(year from sysdate)
       from dual;
       
       select '1997'
                , to_number('1997')
                ,'1997'+'1'
                , to_number('1997') + 1
       from dual;
      
      
      
      
      select  employee_id   as 사원번호
                    , first_name || ' ' || last_name  as 사원명
                    ,  jubun as 주민번호
                    ,   case substr(jubun, 7, 1)
                        when '1' then '남'
                        when '3' then '남'
                        else '여'
                        end AS 성별1
                    ,  case when substr(jubun, 7, 1) in('2','4') then '여' else '남' end as 성별2
                    ,   decode(substr(jubun, 7, 1), '1' , '남', '3', '남', '여')as 성별3
                    ,  case when substr(jubun, 7, 1) in('1','2') then '19' else  '20' end || substr(jubun, 1, 2) AS 태어난년도1
                    -- || 문자열결합
                    ,  substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end AS 태어난년도2
                    -- + 숫자열 결합
                    , extract (year from sysdate) - (substr(jubun, 1, 2)  + case when substr(jubun,7,1) in('1', '2') then 1900 else 2000 end) +1 AS 현재나이
                    
    from employees;           
    
    
 create table tbl_members
(userid    varchar2(20)
,passwd    varchar2(20)
,name      varchar2(20)
,addr      varchar2(100)
);

insert into tbl_members(userid, passwd, name, addr)
values('kimys','abcd','김유신','서울');

insert into tbl_members(userid, passwd, name, addr)
values('young2','abcd','이영이','서울');

insert into tbl_members(userid, passwd, name, addr)
values('leesa','abcd','이에리사','서울');

insert into tbl_members(userid, passwd, name, addr)
values('park','abcd','박이남','서울');

insert into tbl_members(userid, passwd, name, addr)
values('leebon','abcd','이본','서울');

commit;   
      
        select 
            *
        from tbl_members;
       
        select count(*) 
        from tbl_members
        where userid='kimys' and passwd= 'abcd'; 
        -- 0개행
        -- 맞으면 1개행.
        
        
        select
        *
        from tbl_members;
        
        select count(*)
        from tbl_members
        where userid='kimys' and passwd = 'abcd';
    ---------------------------------------------------------------------------------------
    
        select
        *
        from tbl_members;
        
        select count(*)
        from tbl_members
        where userid='kimys' and passwd ='abcd';
        
        select case(select count(*)
                                from tbl_members
                                where userid='supwerman' and passwd='asdf' else end 
                                from dual;
    
        select case(select count(*)
                                from tbl_members
                                where userid='superman' and passwd='asdf')
                                when 1 then '로그인에 성공하였습니다'
                                else (case (select count(*)
                                                     from tbl_members
                                                     where userid='superman')
                                                     when 1 then '비밀번호가 틀렸습니다'
                                                     else '없는 아이디 입니다'
                                                     end )
                                end as 로그인결과
        from dual;
        
       
   ---------------------------------------------------------------------------------------------- 
        
        select case( select count(*)
                                 from tbl_members
                                 where userid='superman' and passwd='abcd') -- 이게 조건식 ()로 구분.
                    when 1 then '로그인성공'
                   else ( case( select count(*)
                                          from tbl_members
                                         where userid='superman' )  
                            when 1 then '암호가 틀립니다'
                            else '아이디가 존재하지 않습니다.'
                           end
                 )
               end AS LOGIN결과
 from dual;
     

-- 문장 쪼개기하면 나옴.

select case (select count (*)
            from tbl_members
            where userid='superman' and passwd='abcd')
            when 1 then '로그인에 성공하셨습니다'
            else (case (select count (*)
                                from tbl_members
                                where userid='superman')
                                when 1 then '비밀번호가 틀렸습니다'
                                else   '아이디가 없습니다.'
                                end
                                )
                                
          end as "LOGIN 결과"
          from dual;

-- 로그인 창 구성 -

select count(*)
from tbl_members
where userid = 'superman' and passwd='abcd';


select case (
                        select count(*)
                        from tbl_members
where userid = 'superman' and passwd='abcd')
              when  1 then '로그인에 성공하셨습니다.'
              else (case (select count(*)
                        from tbl_members
                        where userid= 'superman')
                       when 1 then '비밀번호가 틀렸습니다.'
                       else '아이디가 없습니다.' end 
                       ) 
                       end as "로그인 결과"
                        from dual;

select case (
            select count(*)
            from tbl_members
            where userid='aaaa' and passwd= 'abcd'
            ) when 1 then '로그인에 성공하셨습니다'
            else (case 
                        (select count(*)
                        from tbl_members
                        where userid='aaaa')
                                        when 1 then '비밀번호가 틀렸습니다'
                                        else '아이디가 없습니다.' end )
                                        end as "로그인 결과"
                                        from dual;


select count(*)
        from tbl_members
        where userid='aaaa' and passwd='aaaa';
        
        -- 이 조건에 맞는 컬럼이 몇개나 있나??
        -- 아이디랑 비밀번호기 때문에 하나 가나옴 >> 이걸이용해서 로그인창을 만듬
        
        
        select count(*)
        from employees;
        
        select case (
                    select count(*)
                    from tbl_members
                    where userid='aaaa' and passwd='aaaa'
                    ) when 1 then '로그인에 성공하셨습니다.'
                    else (case
                                (select count(*) 
                                         from tbl_members
                                         where userid='aaaa')
                                         when 1 then '비밀번호가 틀렸습니다'
                                         else '아이디가 없습니다' end)
                                         
                                         
                    end as "로그인 상태"
                    from dual;








    -- 괄호문제 들여쓰기
     select case(select count(*)
                            from tbl_members
                            where userid = 'superman' and passwd='abcd')
                            
                            when 1 then '로그인성공'
                            else(case(select count(*)
                                            from tbl_members
                                            where userid='superman')
                                            when 1 then '암호가 틀립니다'
                                            else '아이디가 존재하지 않습니다'
                                            end
                                            )
                                            end AS LOGIN결과
                                            from dual;
   ----------------------------------------------------------------------------------------------         
    
    select decode(
                                    (select count(*)
                                    from tbl_members
                                    where userid='superman' and passwd='abcd'), 1, '로그인성공'
                                                                                                              , 0, decode((select count(*)
                                                                                                                     from tbl_members
                                                                                                                     where userid='superman'), 1, '비밀번호가 틀렸습니다.'
                                                                                                                                                                        , 0, '아이디가 없습니다.')
                                                                                                                                                                        )
from dual;      
      
          
          
      select case(count (*)
      from tbl_members
      where userid='kimys' and  passwd='abcd'
      when 1 then '로그인성공'
      else (case(count(*) 
      from tbl_members
      where userid='kimys'
      when 1 then '비밀번호가 틀렸습니다.'
      else '아이디가 없습니다.'
      end
      )
      end AS 결과
      from dual;
      
      
      create table tbl_board         
(boardno       number          -- 글번호
,subject       varchar2(4000)  -- 글제목
,content       varchar2(4000) -- 글내용
,userid        varchar2(40)    -- 글쓴이의 ID  
,registerday   date            -- 작성일자
,readcount     number(10)      -- 조회수               
);

insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
 values(1, '안녕하세요', '글쓰기 연습입니다', 'leess', sysdate, 0);
 -- sysdate 는 현재시각을 말한다. 
 
 insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
 values(2, '반갑습니다', '모두 취업대박 나십시오', 'eomjh', sysdate, 0);
  
 insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
 values(3, '건강하세요', '로또 1등을 기원합니다', 'leess', sysdate, 0);
  
 insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
 values(4, '기쁘고 감사함이 넘치는 좋은하루되세요 ', '늘 행복하세요', 'emojh', sysdate, 0);

 insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
 values(5, '오늘도 좋은하루되세요', '늘 감사합니다', 'hongkd', sysdate, 0);

 insert into tbl_board(boardno, subject, content, userid, registerday, readcount)
 values(6, '좋은 하루 되시고 건강하시고 부자되시고 늘 행복하세요', '맛있는 점심 드세요', 'leess', sysdate, 0);

 commit;
      
      
      
      SELECT
      subject as subject,
                         case 
                         when length(subject) > 16 then substr(subject, 1) || '...'
                         else subject
                         end as 기사제목
      FROM tbl_board;
      
      
    16 글자보다 크면 16+...  == 16글자

---- 5.3 rank 등수 구하기, dense_rank 서열구하기

select employee_id as 사원번호
              , first_name || '   ' || last_name as 사원명
              , nvl(salary + (salary*commission_pct), salary) as 월급
              , rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as 월급순위
              , dense_rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as 서열  -- 서열
from employees;

-- 굳이 컴마가 없어도 되고 그냥 블럭쳐서 실행시키면 실행됨.
-- 컴마가 있으면 알아서 시작과 끝을 구분해서 실행시켜줌.


select department_id as 부서번호 
              , employee_id as 사원번호
              , first_name || '   ' || last_name as 사원명
              , nvl(salary + (salary*commission_pct), salary) as 월급
              , rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as 월급순위
              , dense_rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as 서열  
              , rank() over(partition by department_id order by nvl(salary + (salary*commission_pct), salary) desc ) as 월급부서내등수
              -- partition by 파티션을 쳐버림.
              -- 등수를 정해서 할 부분을 부서번호 안에서로
              -- 석차를 구할때 사용한다.
              
              , dense_rank() over(partition by department_id order by nvl(salary + (salary*commission_pct), salary) desc ) as 월급부서내서열 
from employees
order by 1;

    /*
            employees 테이블에서 워륵ㅂ에 대한 전체등수가 1등 부터 10등까지인 사원들만
            사원번호, 사원명, 월급, 등수를 나타내세요.
            
    */
    
    select employee_id as 사원번호
              , first_name || '   ' || last_name as 사원명
              , nvl(salary + (salary*commission_pct), salary) as 월급
              , rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as 월급순위
              from employees
              where rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as between 1 and 10 ;
              -- 오류!!!!  rank() 와 dense_rank()는 where 절에 사용불가하다.
              -- 해결책인 inline view를 사용하면 된다.
     
    select *         
    from
    (
    select employee_id as 사원번호
              , first_name || '   ' || last_name as 사원명
              , nvl(salary + (salary*commission_pct), salary) as 월급
              , rank() over(order by nvl(salary + (salary*commission_pct), salary) desc ) as 월급순위
              from employees              
      )  V
      where 월급순위 between 1 and 10; 
              
     
     -- 5.4 lag, lead (게시판에서 특정글을 조회할때 많이 사용한다) --
     
     select *
     from tbl_board;
     
     select  boardno, subject, content
     from tbl_board;
     ----------------------------------------------------------------------------------------
    -- 앞글번호 앞글제목 현재글번호 현재글제목 현재글내용 다음글번호 다음글제목
    -----------------------------------------------------------------------------------------
    
    /*
    null                null                1         안녕하세요 글쓰기         연습입니다 2               2  반갑습니다.
    1	안녕하세요	글쓰기 연습입니다
    2	반갑습니다	모두 취업대박 나십시오
    ....................................................................................................................................
    6	좋은 하루 되시고 건강하시고 부자되시고 늘 행복하세요	맛있는 점심 드세요 null null
    */


     select lag(boardno, 1) over (order by boardno asc)   
                   , boardno, subject, content
                   , lead(boardno, 1) over (order by boardno asc) 
                   
     from tbl_board;
     
     
      select lag(boardno, 1) over (order by boardno desc)   
                   , lag(subject, 1) over(order by boardno desc)
                   , boardno, subject
                   , lead(boardno, 1) over (order by boardno desc) 
                   , lead(subject, 1) over (order by boardno desc)
     from tbl_board;
     
     -- 그냥 게시판이라고 생각하고 사이에 한개씩 번호 중간에 컨텐트가 들어가서.
      select lag(boardno, 1) over (order by boardno asc)   
                   , lag(subject, 1) over(order by boardno asc)
                   , boardno, subject, content
                   , lead(boardno, 1) over (order by boardno asc) 
                   , lead(subject, 1) over (order by boardno asc)
     from tbl_board;
     ------ 여기서는 그냥 비교할려고 다 넣어논거.
     ------ lead(boardno, 1) over (order by boardno asc)  boardno 1번 다음부터  오름차순으로 정렬해서  범위(over boardno)
     ------ lag(subject, 1) over (order by boardno asc)   subject 1번 이전부터 번호 오르마순
     
     select 
     lag(boardno, 1) over (order by boardno asc) 
     , lead(subject, 1) over (order by boardno asc)
     from tbl_board;

     select 
     lag(boardno, 2) over (order by boardno asc) 
     from tbl_board;
     
     select 
     lead(subject, 2) over (order by boardno asc)
     from tbl_board;

    select * from tbl_board;


-- 문제 (5	오늘도 좋은하루되세요	4	기쁘고 감사함이 넘치는 좋은하루되세요 	늘 행복하세요	3	건강하세요)
    select
                lag(subject, 1) over(order by boardno desc)
              , boardno, subject
              , lead(boardno, 3) over(order by boardno desc)
    from tbl_board;
    
    select 
                    lag(subject, 1) over(order by boardno desc)
                    , boardno, subject
    from tbl_board;
    
    
    
    

    -- 5.5 greatest, least
    
    select greatest(10, 90, 100, 80)
                 , least(10, 90, 100, 80)
    from dual;
    
    
    select greatest('김유신', '윤봉길', '허준', '고수')
                 , least('김유신', '윤봉길', '허준', '고수')
    from dual;
    
    -- =====================================================================
    
    -- ***** >>>>>> 그룹함수(집계함수) <<<< ***** --
    
    
    /*
            1. sum -- 합계
            2. avg  -- 평균
            3. max -- 최댓값
            4. min -- 최소값
            5. count -- select 되어서 나온 결과물의 행의 갯수
            6. variacne -- 분산
            7. stddev -- 표준편차
            
            
            분산         : 분산의 제곱근이 표준편차
            표준편차  : 표준편차의 제곱승이 분산
            
            
            
            >>> 주식투자 <<<
            50 60 40 50 55 45 52 48 평균 50 편차가 적음 --- 안정투자
            10 90 20 80 30 70 90 10 평균 50 편차가 큼     ---- 투기성투자(위험을 안고서 투자함)
            분산과 표준편차는 어떤 의사결정시 도움이 되는 지표이다.
            
            */
            
            
            
            --- !!!! 그룹함수(집계함수)에서는 null 이 이쓰면 무조건 null 은 제외시킨 후 연산한다!!!! ---
            --- 그룹함수(집계함수)를 사용하면 말 그대로 1개의 결과값만 나온다.
            
            
            select salary, max(salary)
            from employees;  -- 오류!! 테이블은 다각혀으로 만들 수 없기 때문에...
            
            -- 합계.
            select sum(salary)
            from employees;
            
            
            
            select sum (nvl (salary*commission_pct, 0) )
            , sum(salary*commission_pct)
            -- 그룹함수에서 null이 상관없음...
            from employees
            
            
            
            
            select salary, commission_pct, department_id
            from employees;
            
            select count(salary), count(commission_pct), count(department_id)
            from employees;            
            --- 107 35 106
            --- 값이 없으면 0.
            
            
            
            select sum(salary), avg(salary), max(salary), min(salary), count(salary)
                                , variance(salary), stddev(salary)
            from employees;
            
            
            select count(*)
            from employees;

            -- 이 테이블의 행이 몇개인지 알려줌. 
            -- 테이블의 행은 null이 없기에...
            
            
            --- employees 테이블에서 기본급여(salary)의 평균치를 구하세요.
            select 
              sum(salary), count (salary)
            , sum(salary) / count(salary)
            , avg(salary)
            from employees;
            
            
            --- employees 테이블에서 수당(salary * commission_pct)의 평균치를 구하세요.
             select 
              sum(salary * commission_pct), count (salary * commission_pct)
            , sum(salary * commission_pct) / count(salary * commission_pct)
            , avg(salary * commission_pct)
            
            -- 그룹함수는 null 값을 가진 컬럼을 자동적으로 뺴기때문에  commission_pct이 없는 사원들은 빠져있어
            -- 수당받는 사람들의 평균이됨.
            from employees;
            
            select avg(salary * commission_pct)  
                         , sum(salary * commission_pct) / count(salary * commission_pct)
                         , avg(nvl(salary * commission_pct), 0))
                         , sum((salary * commission_pct) / count(*)
                         from employees;
                         
                         --- nvl을 써서 null 값을 가진 사원도포함시켜야 전체직원의 월급 평균이 나옴.)
                         
                         
                         
                         ----- **** employees 테이블에서  부서번호별 인원수를 나타내세요... *** ---


  
  select department_id as 부서번호
                , count(*) as 인원수
                from employees
                group by department_id
                order by 1;
                
  --            employee 테이블에서 부서번호별 인원수를 나타내세요. 또한 모든 사원들의 총인원수도 나타내세요**** ----
  --            또한 모든 사원들의 총인원수도 나타내세요 **** --
  
  
  select nvl(to_char(department_ID), '전체') as "부서번호", count(*) as "부서별 인원수"
  from employees
  group by department_ID
  order by 1;
  
  select *
  from employees;
  
  
   select department_id as 부서번호,
   count(*) as 인원수
  from employees
  group by rollup(department_id);
  select department_id as 부서번호,
    count(*) as 인원수
    from employees
    group by rollup(department_id);
-- 카운트는 되나 구분이 안됨으로 그룹핑 을사용함.

   select grouping(department_id)  -- gruop의 뜻은 deapartment_id 컬럼의 값을 가지고 group을 지었을때 grouping(department_id) 값이 0이라면 department_id 컬럼은 실제 데이터임을 알려주는 것이고,
                                                                     --  grouping(department_id) 값이 1이라면  department_id 컬럼은 실제 데이터가 아니라 group을 짓지 않은 전체 라는 뜻이다.      
                
                , department_id as 부서번호
                , count(*) as 인원수
                from employees
                group by rollup(department_id);
                -- department_id 로 그룹을 짓지않았다. ==> 1

    select grouping(department_id) as "실제컬럼의 값여부"
                                     , department_id as 부서번호
                                     , count(*) as 인원수
                                     from employees
                                     group by rollup(department_id);
                                     
    
   select decode (grouping(department_id), 0, to_char(department_id)
                                                                                        , '전체') as 부서번호
    -- 한 컬럼안에 문자면 문자 숫자면 숫자여야함.
    
                , count(*) as 인원수
                from employees
                group by rollup(department_id);

   select decode (grouping(department_id), 0, nvl(to_char(department_id), '인턴')
                                                                                        , '전체') as 부서번호
                                                                                        -- 1이면 전체다.
    
    select decode(grouping(department_id), 0, nvl(to_char(department_id), '인턴')
                                                                                        , '전체') as 부서번호
                ,count(*) as 사원숫자
    from employees
    group by rollup(department_id);
                
    select 
    decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴')
                                                                             , '전체'   ) , count(*) as 사원수
    from employees
    group by rollup (department_id)

                
                
    select decode(grouping(department_id), 0, nvl(to_char)department_id), '인턴')            
                
--  
  
  -- where 안줘도 가능.                 
                
                         -- 어떤 기준으로 그룹을 지을래.
                         
                         
                         -----------------------------------
                         성별                                인원수
                         -----------------------------------
                         남                                      56
                         여                                      51
                         전체                                   107
                         
                         
     with V as (
                         select 
                                        case 
                                        when substr(jubun, 7, 1) in(1,3) then  '남' else '여' end as 성별
                         from employees
                         )
     select 성별, count(*) as 숫자 , round (count(*) / (select count(*) from employees)*100, 1) as "퍼센티지(%)"     
     from V                    
     group by 성별;                    
                         
                         
                         
                         
                         
                                                                 
                         
                         
    select 성별,  count(*) as 인원수
                    ,  round(count(*)/(select count(*) from employees) *100, 1) || ' %' as "퍼센티지(%)"
    
    from
    (
    select case 
                when substr(jubun, 7, 1) in(1,3) then '남' else  '여' end as 성별 from employees 
    ) V
     -- 바로 group by로 잡아서 count(*)을 가져올수없는이유는
     -- employees 테이블에 부서는 이미 부서별 안에 10 20 30 40 50 60 70 값이 있어
     -- department_id로 정렬을 가져와도 그안에있는 비슷한 값끼리 묶을수 있지만
     -- 성별의 경우 기존 테이블에 성별이라는 카테고리가 없기 때문에 성별이라는 것으로 값을 묶을수가 없다.
     -- 따라서 inline view를 사용해서 테이블화 한후 view 안에는 성별이라는 컬럼이 존재하기에
     -- 해당 컬럼으로 정렬해줘라고 명령을 줄수있기때문임.
     
     group by 성별;
               



    select 성별,  count(*) as 인원수
                    ,  round(count(*)/(select count(*) from employees) *100, 1) || ' %' as "퍼센티지(%)"

    from
    (
    select case 
                when substr(jubun, 7, 1) in(1,3) then '남' else  '여' end as 성별 from employees 
    ) V
     -- 바로 group by로 잡아서 count(*)을 가져올수없는이유는
     -- employees 테이블에 부서는 이미 부서별 안에 10 20 30 40 50 60 70 값이 있어
     -- department_id로 정렬을 가져와도 그안에있는 비슷한 값끼리 묶을수 있지만
     -- 성별의 경우 기존 테이블에 성별이라는 카테고리가 없기 때문에 성별이라는 것으로 값을 묶을수가 없다.
     -- 따라서 inline view를 사용해서 테이블화 한후 view 안에는 성별이라는 컬럼이 존재하기에
     -- 해당 컬럼으로 정렬해줘라고 명령을 줄수있기때문임.
     
     group by 성별;
     
      -- 문제 --
      
                        select decode(grouping(gender) , 0, gender
                                                                                            , '전체') as 성별
                                                                                            , count(*) as 인원수
              
      from
      (
      select case when substr(jubun, 7, 1) in(1, 3) then '남' else '여' end as 성별
      from employees
      ) V
      group by rollup (gender);
    
            
  select department_id, sum(salary)
  from employees
  group by department_id
  order by department_id;
  
  select nvl(to_char(department_id), '인턴'), sum(salary)
  from employees
  group by department_id
  order by department_id;
  
  
  -- employee 테이블에서 부서번호별 기본급여의 평균을 나타내세요.
  
  select *
  from employees;
  
  select decode (grouping(department_id), 0, nvl(to_char(department_id), '인턴')
                                                                                       , '전체' ) as 부서번호, trunc(avg(salary)) as 급여                  
  from employees
  group by rollup(department_id);
 
  
  
  
  
   select decode(grouping(department_id), 0, nvl(to_char(department_id), '인턴')
                                                                                       , '전체') as 부서번호
                , sum(salary) as 기본급여평균
  from employees
  group by rollup (department_id);
  
  
  select grouping(department_id)
  from employees
  group by rollup (department_id);
  
  
  
  select department_id as 부서번호
  from employees
  group by rollup (department_id);
  
  
  -- 퀴즈 employees 테이블에서 연령대별로 인원수와 퍼센티지(%)를 나타내되
  -- 전체사원수도 나오도록 하세요....
  
  ---------------------------------------------------------------------------------------
  연령대             인원수                퍼센티지(%)
  ---------------------------------------------------------------------------------------
       00                   07                            06 
       10                   07                            06
       20                   07                            06
       30                   07                            06
       ...                   ...                               ...
       전체               107                         100
       
       with V as (
       select 
       case when substr(jubun, 7, 1) in (1,2) then trunc(extract(year from sysdate) - (substr(jubun, 1, 2) + 1901), -1) else  trunc (extract (year from sysdate) - (substr(jubun, 1, 2) + 2001), -1) end as 나이
       from employees)
       
       select 나이, count(*), round(count(*)/(select count(*) from employees) *100, 1) || '%' as "퍼센티지(%)"
       from V
       group by 나이
       order by 나이;
       
       
       
    
       
       select 나이,
       count(*) as 인원수, 
       round(count(*)/(select count(*) from employees) *100, 1) || ' %' as "퍼센티지(%)"
       -- 뷰 참조할때는 그것만.
       from
       (
       select 
       case 
       when substr(jubun, 7, 1) in(1,2)  then trunc (extract(year from sysdate) - (substr(jubun, 1, 2) + 1901),-1) else trunc(extract(year from sysdate) - (substr(jubun, 1, 2) + 2001),-1) end as 나이        
       from employees
        ) V
        group by 나이
        order by 1;
        ----------------------------------------------------------------------- 고쳐보기
        
       select decode(grouping(나이), 0, to_char(나이), '전체') as 연령대
        -- grouping 0이면 실제 데이터값 아니라면 1
       , count(*) as 인원수, 
       round(count(*)/(select count(*) from employees) *100, 1) || '%' as "퍼센티지(%)"
       from
       (
       select 
       case 
       when substr(jubun, 7, 1) in(1,2)  then trunc (extract(year from sysdate) - (substr(jubun, 1, 2) + 1901),-1) else trunc(extract(year from sysdate) - (substr(jubun, 1, 2) + 2001),-1) end as 나이        
       from employees
        ) V
        group by rollup(나이)
        -- rollup 전체를 보여준다.
        
        order by 1;
        
        ---- *** inline view를 with 절을 사용하여 나타낼수 있다. *** ----
        
        with V as( 
              select case whein)
        -- 괄호안에있는 부분을 V이라는 테이블로 view로 보겠다.
        
        select gender as 성별
                    , count(*) as 인원수
                    from V
                    group by gender;
                    
                    -- with 절과 아래절을 같이 실행하면 동일하게 적용이 됨.
                    -- 인라인뷰를 밖으로 뺄때 사용.. >> 단순해짐.
                
 /*                         -----------------------------------
                         성별                                인원수
                         -----------------------------------
                         남                                      56
                         여                                      51
                         전체                                   107
     */           
     
     with V as (
            select case when substr(jubun, 7,1) in(1,3) then '남' else '여' end as gender
                from employees
                 )
                 
        select decode (grouping(gender), 0, gender, '전체') AS 성별
                      , count(*) as 인원수
        from V
        group by rollup(gender);
        
        ------- with 절을 이용해서 바꾸어보기 ------------------------------------------
        with V as(
       select 
       case 
       when substr(jubun, 7, 1) in(1,2)  then trunc (extract(year from sysdate) - (substr(jubun, 1, 2) + 1901),-1) else trunc(extract(year from sysdate) - (substr(jubun, 1, 2) + 2001),-1) end as 나이        
       from employees
        )
        
          select decode(grouping(나이), 0, to_char(나이), '전체') as 연령대
       , count(*) as 인원수, 
       round(count(*)/(select count(*) from employees) *100, 1) || '%' as "퍼센티지(%)"
       from V
        group by rollup(나이);
        
        
        ----------------------------------------------------------------------------------------
        
        with V as (
            select 
            case 
            when substr(jubun, 7,1) in (1,2) then trunc (extract(year from sysdate) - (substr(jubun, 1, 2) + 1901),-1)
            else trunc (extract(year from sysdate) - (substr(jubun, 1, 2) + 2001), -1) end as 나이
            from employees
        )
        -- else then 오류. 
        select 나이, count(*) as 인원수
        from V
        group by (나이);
    
        select 나이, count(*) as 인원수
        from V;
        
        
        --- employee 
          select department_id as 부서번호
                , count(*) as 인원수
                from employees
                group by department_id
                order by 1;
        
        --- *** 그룹을 지을때 1차로 그룹을 지은 다음에 거기서 다시한번 2차로 또 그룹을 지을수 있다. *** ---
        
    
                         -------------------------------------------
                         부서번호            성별              인원수
                         -------------------------------------------
                         10                       남                  56
                         10                       여                  51
                          -----------------------------------------
                          전체                    남                  56  
                          전체                    여                  51
                          
                          
                          
                          
                          select decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                          , decode(grouping(성별), 0, 성별, '전체') as gender
                          , count(*) as 인원수
                          
                          from
                          (
                            select department_id
                                         ,  case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
                             from employees
                         ) V
                        group by rollup(department_id, 성별);
        
                        -------------------- with 절로 바꾸기 -----------------------------------------
                        
                        
                        with V as  (
                        select 
                        case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별
                        , department_id as 부서번호
                        from employees 
                        )
                        
                        select decode (grouping (부서번호), 0, nvl(to_char(부서번호), '인턴'), '전체') as 부서번호 , decode (grouping (성별), 0, 성별, '전체') as 성별,  count(*) 인원수
                        from V
                        group by rollup(부서번호, 성별);
        
                        with V as (
                        select department_id as 부서번호, first_name || ' '  || last_name as 이름, salary as 급여
                        from employees
                        )
                        
                        select 부서번호, 이름, 급여, count(*) as 인원수
                        from V;
                        
        
        
        
        
        
        
        
        -- 일단 나이 컬럼을 만든뒤 테이블로 V로 만들고
        -- 나이별로 정리를 한다음에 count로 그 해당 나이 만큼의 컬럼수를 구하고
        -- 퍼센테이지를 구한다.
  
        select
        trunc(11,-1)
        from dual;  
  
  -- employee 테이블에서 부서번호별 기본급여의 최대값을 나타내세요.
   select department_id, max(salary) as 기본급여최대값
  from employees
  group by department_id
  order by department_id;
            
        
  -- employee 테이블에서 부서번호별 기본급여의 최소값을 나타내세요.
   select department_id, min(salary) as 기본급여최소값
  from employees
  group by department_id
  order by department_id;
  -- where 안줘도 가능. 
  
  
      ----- >>>>> 요약값(rollup, cube, grouping sets) <<<<< ------
  /*
      1. rollup(a,b,c) == grouping sets( (a,b,c),(a,b),(a),() ) 
           -- a,b,c가 들어있는 경우의 수가 나옴.
           
            group by rollup(department_id, gender)
         == group by grouping sets( (department_id, gender), (department_id), () )
  
      2. cube(a,b,c) == grouping sets( (a,b,c),(a,b),(b,c),(a,c),(a),(b),(c),() )
           모든 경우의 수
           abc
            group by cube(department_id, gender)
         == group by grouping sets( (department_id, gender), (department_id), (gender), () )
         
         3.  grouping sets
  */      
                           select decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                          , decode(grouping(성별), 0, 성별, '전체') as gender
                          , count(*) as 인원수
                          
                          from
                          (
                            select department_id
                                         ,  case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
                             from employees
                         ) V
                        group by rollup(department_id, 성별);
                        
                        
                        select decode(grouping(department_id),0,nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                                     , decode(
                                     
                                     
                                     with V as (
                                     select department_id 
                                                   , case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별
                                                from employees);
                                                
                                                
                         select  grouping(department_id)
                         from employees
                         group by rollup(department_id);
                         
                         select decode( grouping(department_id) , 0, nvl(to_char(department_id), '인턴') , '전체') as 부서번호 
                        from employees
                        group by rollup(department_id);
                        
                        
                        
                        
                        
                        
                        
                        
                        
                            
                          select decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                          , decode(grouping(성별), 0, 성별, '전체') as gender
                          , count(*) as 인원수
                          
                          from
                          (
                            select department_id
                                         ,  case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
                             from employees
                         ) V
                        group by grouping sets((department_id, 성별), (department_id), () );
                        -- (동일한 부서에서 성별끼리), (부서끼리만 구분짓는것), (아무것도 구분짓지 않는것).
            
                        --- *** cube *** --- 
                        
                         select decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                          , decode(grouping(성별), 0, 성별, '전체') as gender
                          , count(*) as 인원수
                          
                          from
                          (
                            select department_id
                                         ,  case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
                                        , first_name
                             from employees
                         ) V
                        group by cube(department_id, 성별)
                        order by 1,2;
                        
                        -- 조금더 상세하게 볼때 쓰인다.
                        -- 또는
                        
                          select decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                          , decode(grouping(성별), 0, 성별, '전체') as gender
                          , count(*) as 인원수
                          
                          from
                          (
                            select department_id
                                         ,  case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
                                        , first_name
                             from employees
                         ) V
                        group by grouping sets ((department_id, 성별), (department_id), (성별), () )
                        order by 1,2;
                        
                                                
                          select decode (grouping (department_id), 0, nvl(to_char(department_id), '인턴'), '전체') as 부서번호
                          , decode(grouping(성별), 0, 성별, '전체') as gender
                          , count(*) as 인원수
                          , round(count(*)/(select count(*) from employees) *100, 1) || ' %' as "퍼센티지(%)"
                          
                          from
                          (
                            select department_id
                                         ,  case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
                             from employees
                         ) V
                        group by grouping sets ((department_id, 성별), (department_id) );
                        order by 1,2;
                        
                        -- group by  grouping sets 보고싶은것만 출력가능.
                        
                        
                        
                        ---- *** having 그룹함수 조건절 *** ----
                        --- group 절을 사용하여 그룹함수의 값을 나타내었을때 
                        ---  그룹함수의 값이 특정 조건에 해당하는 것만 추출하고자 할때는 where  절을 사용하는 것이 아니라
                        --- having 그룹함수 조건절을 사용해야 한다.
                        
                        -- employees 테이블에서 사원이 10명 이상 근무하는 부서번호와  그 인원수를 나타내세요.
                        select department_id, count(*)
                        from employees
                        group by department_id; -- 오류
                        
                        -- 성별인지 직접별인지 모르겠다.
                        -- 00934. 00000 -  "group function is not allowed here"
                        
                        select department_id, count(*)
                        from employees
                        group by department_id
                        having count(*) >= 10
                        -- 그룹을 지은 개수가 10개가 넘는것만 !!!!!!!!!!!
                        -- 그룹지은 대상에 대한 조건을 줄때 having 을 사용함.
                        order by 2;
                        
                        -- employee 테이블에서 부서별로 월급의 합계를 나타내었을때 
                        -- 부서번호별 월급의 합계가 5만 이상인 부서에 대해서만 
                        -- 부서번호, 월급의 합계를 나타내세요.
                        
 
                        select department_id as 부서번호, 
                                      sum(nvl(salary+(salary*commission_pct), salary))
                        from employees
                        group by department_id
                        having sum(nvl(salary+(salary*commission_pct), salary)) > 50000;
                        

                        -- 왜오류 안남.

상품번호                       판매일자                                       판매량                   시간대별 누적판매량                                    상품번호별 누적판매량
   101                  2020-08-01 09:00:00                         10                                     10                                                                     5
   102                  2020-08-01 09:10:00                         20                                     30                                                                     15
   100                  2020-08-01 10:00:00                         05                                     35                                                                     35
   103                  2020-08-01 11:10:00                         30                                     65                                                                     65

            
            
                         ---- *** !!!! 누적에 대해서 알아봅니다. !!!! *** ----
 /*
   --  sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc])
    
   --  sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
                                  order by 누적되어질 기준이 되는 컬럼명 asc[desc])
                                  
-- 누계 -- 
 10    >  10
 20    >  30
 30    >  60
 40    >  100
 50    >  150
 
            
            
            
            
 */
            
 create table tbl_panmae
 (panmaedate  date
 ,jepumname   varchar2(20)
 ,panmaesu    number
 );

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-2), '새우깡', 10);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-2)+1, '새우깡', 15); 

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-2)+2, '감자깡', 20);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-2)+3, '새우깡', 10);
 
 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-2)+3, '새우깡', 3);
 
 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-1), '고구마깡', 7);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-1)+1, '새우깡', 8); 

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-1)+2, '감자깡', 10);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( add_months(sysdate,-1)+3, '감자깡', 5);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate - 4, '허니버터칩', 30);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate - 3, '고구마깡', 15);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate - 2, '고구마깡', 10);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate - 1, '허니버터칩', 20);


 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '새우깡', 10);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '새우깡', 10);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '감자깡', 5);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '허니버터칩', 15);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '고구마깡', 20);

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '감자깡', 10); 

 insert into tbl_panmae(panmaedate, jepumname, panmaesu)
 values( sysdate, '새우깡', 10);

 commit;
 
 select *
 from tbl_panmae;
            
select * from tab;
select *
from tbl_panmae;
            
                        
                        
                        

상품번호                       판매일자                                       판매량                   시간대별 누적판매량                                    상품번호별 누적판매량
   101                  2020-08-01 09:00:00                         10                                     10                                                                     5
   102                  2020-08-01 09:10:00                         20                                     30                                                                     15
   100                  2020-08-01 10:00:00                         05                                     35                                                                     35
   103                  2020-08-01 11:10:00                         30                                     65                                                                     65

  select to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') as panmaedate, panmaesu
  from tbl_panmae
  where jepumname = '새우깡';
  
   --- *** tbl_panmae 테이블에서 새우깡에 대한 일별판매량과 일별누적판매량을 나타내세요 -- ***
   ------------------------------------------------------------------------------------------------------------
   판매일자             일별판매량           일별 누적판매량
   ------------------------------------------------------------------------------------------------------------         
            
    2020-06-18 	10                                 10
    2020-06-19 	15                                 25
    2020-06-21 	13                                 38
    2020-06-21 	8                                    46 
    2020-07-19 	30                                  76
    2020-08-18 	10
    2020-08-18 	10
    2020-08-18 	10       
            
                         ---- *** !!!! 누적에 대해서 알아봅니다. !!!! *** ----
 /*
   --  sum(누적되어야할 컬럼명) over(order by 누적되어질 기준이 되는 컬럼명 asc[desc])
    
   --  sum(누적되어야할 컬럼명) over(partition by 그룹화 되어질 컬럼명 
                                  order by 누적되어질 기준이 되는 컬럼명 asc[desc])            
   
   */
   
   select to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
               , sum(panmaesu) as 일별판매량
               , sum(sum(panmaesu)) over(order by to_char(panmaedate, 'yyyy-mm-dd') asc) as  "일별 누적판매량"
   from tbl_panmae
   where jepumname = '새우깡'
   group by to_char(panmaedate, 'yyyy-mm-dd')
   order by 1;
    
    
    ---  asc생략가능.
    
    select to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
                  , sum(panmaesu) as 일별판매량
    from tbl_panmae
    where jepumname='새우깡'
    group by to_char(panmaedate, 'yyyy-mm-dd')
    order by 1;
    


    select to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
                 , sum(panmaesu) as 일별판매량
    from tbl_panmae
    where jepumname='새우깡'
    group by to_char(panmaedate, 'yyyy-mm-dd')
    order by 1;


    select to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
                , sum(panmaesu) as 일별판매량
                , sum(sum(panmaesu)) over(partition by to_char(panmaedate, 'yyyy-mm-dd') ) as "일별 누적판매량"
                from tbl_panmae
                group by to_char(panmaedate, 'yyyy-mm-dd') 
                order by to_char(panmaedate, 'yyyy-mm-dd'); 
                
                
                
                
            
    -- *** tbl_panmae 테이블에서 모든제품에 대한 일별판매량과 일별누적 판매량을 나타내세요 *** ---
   
   
   --------------------------------------------------------------------------------------------------------------------
   제품명                              판매일자                                일별판매량                                       일별누적판매량
   --------------------------------------------------------------------------------------------------------------------
    
    
    select  jepumname as 제품명 
                , to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
                , sum(panmaesu) as 일별판매량
                , sum(sum(panmaesu)) over (partition by jepumname 
                                                             order by to_char(panmaedate, 'yyyy-mm-dd') asc ) as "일별 누적판매량"
    from tbl_panmae
    group by jepumname,  to_char(panmaedate, 'yyyy-mm-dd');
    
    
    select jepumname as 제품명
               , to_char(panmaedate, 'yyyy-mm-dd') as 판매일자
               , sum(panmaesu) as 판매량 
               , sum (sum(panmaesu)) over(partition by jepumname 
                                                             order by to_char(panmaedate, 'yyyy-mm-dd') asc ) as "일별 누적판매량"
               from tbl_panmae 
               group by jepumname, to_char(panmaedate, 'yyyy-mm-dd');

    
    ----------------------------------------------------------------------------------------------------
    
    select department_id as 부서번호 , count(*) as 인원수
    from employees
    where department_id in(30,60)
    group by department_id; 
    
    
    -------------------------------------------------------------------
    부서번호 30                                                         부서번호 60
    ------------------------------------------------------------------
           6                                                                              5

          -- 오라클 11g 이전에는 아래와 같이 구했다.
          
          
          select department_id
                        , case department_id when 30 then 1 else 0 end
                        , case department_id when 60 then 1 else 0 end
                        
          from employees
          where department_id in (30,60);
          
          
          --- *** 오라클 11g 부터 사용가능한 pivot 을 사용하여 구해보겠다. *** ---
          --- pivot  ==> oracle 11g 부터 제공하는 것으로써, 행을 열로 변환하고자 할 때 사용하는 방법으로서
          -- 기존의 group by와 그룹함수(max, sum 등), decode,case 를 사용하는 방법 대신 좀 더 간결하게 해준다.
          -- 
          
          
          
          select    sum (case department_id when 30 then 1 else 0 end) as "부서번호 30"
                        , sum (case department_id when 60 then 1 else 0 end) as "부서번호 60"
                        
          from employees
          where department_id in (30,60);
          
          
          with V as
                
                (select department_id
                , count(*) as cnt
                from employees
                where department_id in(30,60)
                group by department_id) 
                
                
    select 부서번호30, 부서번호60
    from V
    pivot (
                     count(department_id)
                     for department_id
                     in (30 as 부서번호30 , 60 as 부서번호60)                      
                  ) 
    
    
    ---------------------------------------------------------------------------------
  
  ---- *** 아래처럼 나오도록 하세요 *** ----
  
  ------------------------------------------------------------------------
  전체사원수     10대미만   10대   20대  30대  40대  50대  60대
  ------------------------------------------------------------------------
            107                                    2	14	21	19	21	18	12
  --- 오라클 11g 이전에는 아래와 같이 구했다. 
  select count(*) as "전체사원수"
       , sum( decode(V.AGELINE, 0, 1) )  as "10대미만"
       , sum( decode(V.AGELINE, 10, 1) ) as "10대"
       , sum( decode(V.AGELINE, 20, 1) ) as "20대"
       , sum( decode(V.AGELINE, 30, 1) ) as "30대"
       , sum( decode(V.AGELINE, 40, 1) ) as "40대"
       , sum( decode(V.AGELINE, 50, 1) ) as "50대"
       , sum( decode(V.AGELINE, 60, 1) ) as "60대"
   from 
   (
     select trunc( extract(year from sysdate) - (to_number(substr(jubun, 1, 2)) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end) + 1 , -1) as AGELINE 
     from employees
   ) V;
  
  -- **** PIVOT ==> Oracle 11g부터 제공하는 것으로써, 
   --      행을 열로 변환하고자 할 때 사용하는 방법으로서 기존의 GROUP BY 와 집계함수(MAX, SUM 등), DECODE 나 CASE 를 사용하는 방법 대신 좀 더 간결하게 해준다.
   --      1. PIVOT 절은 그룹함수가 적용될 컬럼을 정의하는 것으로서 마치 GROUP BY가 들어간 쿼리에서 SELECT SUM(SALARY), AVG(SALARY), COUNT(SALARY) 구절과 같다.
   --      2. PIVOT FOR 절은 피봇의 기준의 되는 컬럼을 정의하는 것으로서 마치 GROUP BY 절에 뒤따르는 컬럼과 같은 역할로 이해하면 된다.
   --         SELECT 절의 SUM(SALARY), AVG(SALARY), COUNT(SALARY) 가 PIVOT 절의 역할이라면, GROUP BY DEPARTMENT_ID 는 PIVOT FOR의 역할이다.
   --      3. PIVOT IN 절은 
   --           PIVOT FOR 절에서 정의한 컬럼에서 필터링을 정의하는 것으로서 마치 SQL 중 WHERE DEPARTMENT_ID IN(10, 20)은 PIVOT IN 절의 역할이다.
   --         또한 PIVOT IN 절은 Subquery 는 포함 할 수 없으나 Alias 정의는 가능하다.


   ------------------------------------------------------------------------------------------------------------
   10대 미만 10대 20대 30대 40대 50대 60대
   ------------------------------------------------------------------------------------------------------------
   
   
   with V as (
     select trunc( extract(year from sysdate) - (to_number(substr(jubun, 1, 2)) + case when substr(jubun,7,1) in('1','2') then 1900 else 2000 end) + 1 , -1) as AGELINE 
     from employees
   )
   
   
   select *
   from V
   PIVOT(COUNT(AGELINE)
         FOR AGELINE
         IN(0 AS "10대미만", 10 AS "10대", 20 AS "20대", 30 AS "30대", 40 AS "40대", 50 AS "50대", 60 AS "60대")); 
         
  ----------------------------------------------------------------------------------
  select department_id AS 부서번호
       , count(*) AS 인원수 
  from employees
  where department_id in (30,60)
  group by department_id;
  
  -------------------------------------------------------
  
  ----------------------------
    부서번호30      부서번호60
  ----------------------------
       6              5
  
  select department_id
       , case department_id when 30 then 1 end
       , case department_id when 60 then 1 end
  from employees
  where department_id in (30,60);
  
  --- 오라클 11g 이전에는 아래와 같이 구했다. 
  select sum(case department_id when 30 then 1 end) AS 부서번호30
       , sum(case department_id when 60 then 1 end) AS 부서번호60
  from employees
  where department_id in (30,60);
  
  -- 오라클 11g 에서는 아래와 같이 pivot 을 사용하여 나타낼수 있다.
  
  with V as (select department_id 
             from employees
             where department_id in (30,60))
  select 부서번호30, 부서번호60           
  from V
  pivot( count(department_id)
         for department_id
         in(30 as 부서번호30, 60 as 부서번호60) );
    
  ----------- **** pivot 예제 아래처럼 나오도록 하세요 **** ----------
  
  -------------------------------------------------------------------------------
  직종ID          남자평균급여                          여자평균급여           평균급여
  -------------------------------------------------------------------------------
  
  연구직                4500                                          5400                     5000
  영엽직                6000                                          5500                     5800



    -- pivot 을 사용하지 않고 구하겠습니다. --
    
    with V as (
            select job_id as 직종
                         , case when substr(jubun, 7,1) in (1,3)  then '남' else '여' end as GENDER
                         , salary
            from employees
    )
    
    select 직종
                 , trunc(avg(decode(GENDER, '남', salary)),-1)  as "남자 평균급여"-- 9000 4800 4800 4200
                 , trunc(avg(decode(GENDER, '여', salary)),-1)  as "여자 평균급여" -- null 6000                                           
                 , avg(salary) as "전체 평균급여"
                 from V
    group by  직종;


    with V as (
            select job_id as 직종
                         , case when substr(jubun, 7,1) in (1,3)  then '남' else '여' end as GENDER
                         , salary
            from employees
    )
    
    select 직종
                 , trunc(avg(decode(GENDER, '남', salary)),-1)  as "남자 평균급여"-- 9000 4800 4800 4200
                 , trunc(avg(decode(GENDER, '여', salary)),-1)  as "여자 평균급여" -- null 6000                                           
                 , avg(salary) as "전체 평균급여"
                 from V
    group by  직종;
    
    -- === [과제] null 을 '' 공백으로 처리해보자.
    
        with V as (
            select job_id as 직종
                         , case when substr(jubun, 7,1) in (1,3)  then '남' else '여' end as GENDER
                         , salary
            from employees
    )
    
    select 직종
                 , nvl (to_char( trunc(avg(decode(GENDER, '남', salary)),-1), '99,999'), ' ')  as "남자 평균급여"-- 9000 4800 4800 4200
                 , nvl (to_char(trunc(avg(decode(GENDER, '여', salary)),-1), '99,999') , ' ')  as "여자 평균급여" -- null 6000                                           
                 , to_char(avg(salary)) as "전체 평균급여"
                 from V
    group by  직종;
    
    
--- 작업할떄 함수 앞에 괄호클릭하면 끝을 알수있음. ---
--- 한 컬럼내에 다른타입의 데이터가 존재할수 없기 때문에 타입을 숫자아니면 문자로 바꾸어야 하는데 null 값을 조정해서 공백을 주려면 숫자는 안됨.. 따라서 문자형으로 전체를 통일시켜 표현.



    
    -- pivot 을 사용하지 않고 구하겠습니다. --
    
    with V as (
            select job_id as 직종
                         , case when substr(jubun, 7,1) in (1,3)  then '남' else '여' end as GENDER
                         , salary
            from employees)
            
            
    select  직종, trunc(남자평균급여), trunc(여자평균급여)
    from V
    pivot (AVG(salary) 
                -- 실제 데이터 값, 아래의 남 및 여 열에 보여질 데이터 값을 정의한다.
                for GENDER  -- 남, 여로 보여지는 행을  남여로 바꾸려고한다.
                in ('남' as 남자평균급여, '여' as 여자평균급여) -- 열로 보여줄 데이터를 필러링한다.
                -- 실제로 보여지는것
    )
    
    -- *** unpivot ==> 열을 행으로 변경하고자 할때 사용하는 것으로서, 
    --                                 열을 행으로 변경하고자 하는 컬럼명과 데이터 영역을 선정해야 한다.
    
  

    with V as (
            select 
                        first_name || ' ' || last_name as ENAME
                        , salary
                        , (salary + (salary*commission_pct) ) as COMM
            from employees )

    select ENAME, COLNAME, DATAVALUE
    from V
    unpivot (DATAVALUE -- 데이터 영역의 컬럼명을 지정해주는 자리.
                        FOR COLNAME   -- 열 영역의 컬럼명을 지정해주는것
                        IN (salary, COMM) -- 데이터 영역으로 들어올 컬럼명을 지정해주는것. NULL 은 표현되지 않는다.
    );

select *
from employees;



----------- !!! 중요 JOIN은 면접에 가면 주조건 물어봅니다. !!! ------------------
           --------- ======== **** JOIN **** ========  ----------- (손코딩)
           
/*
        join(조인)은 테이블(뷰)과 테이블(뷰)을 합치는 것을 말하는데
        행(ROW) 과 행(ROW)을 합치는 것이 아니라, 컬럼(COLUMN)과 컬럼(COLUMN)을 합치는 것을 말한다.
        위에서 말한 행과 행을 합치는것은 UNION 연산자를 활용하는 것이다.
        
        
        -- 질문 : INNER JOIN과 OUTTER JOIN의 차이점에 대해서 말해보세요.
        -- 내부조인 : 
        두 테이블에서 공통적으로 존재하는 컬럼의 값이 일치되는 행을 연결하여 결과를 생성하는 조인 방법.
        -- 외부조인 : 
        상호 테이블간에 일치되는 값으로 연결되는 내부조인과는 달리 어느 한 테이블에 공통 컬럼값이 없더라도 
        해당 로우들이 조회결과에 포함되게 하는 조인이며 조회 조건에서 (+) 기호를 사용하여 조인합니다.
        -- 사용하는 이유
        내부조인으로 인하여 전체 자료 107개에서.. 하나의 row가 null 값을 가지게 되면
        상호 테이블간에 일치하지 않는 자료가 되어 결과에서 누락되는 현상이 일어날 수 있습니다.
        employees 테이블에는 존재하고 departments 테이블에 존재하지 않는다고 할지라도, 
        employees 테이블을 기준으로 하여 department테이블이 조인에 참여하라는 의미를 부여하기 위하여 
        where절 조건에서 department_id (+)를 사용합니다.
        모든 외부조인 조건에 (+)를 붙여야 하며, 
        일반조건에도 (+)를 붙이지 않으면 아래와 같이 다른 결과값이 나옵니다.

            데카르트 곱(수학) ==> 원소의 곱 : 3*2 = 6개(모든 경우의수)
            --> 수학에서 말하는 데카트르곱을 데이터베이스에서는 Catersian Product 라고 부른다.
            
            JOIN => SQL 1992 CODE 방식 --> 테이블(뷰)과 사이에 콤마(,)를 찍어주는 것.
                                                                          데이터베이스 벤더(회사) 제품마다 문법이 조금씩 다르다.                                                    
                      => SQL 1999 CODE 방식(ANSI) --> 테이블(뷰)과 테이블(뷰) 사이에 JOIN 이라는 단어를 넣어주는 것.
                                                                                       ANSI(표준화) SQL
                      


        차이점이 무엇인가
        -- 질문 : JOIN과 UNION의 차이점에 대해서 말해보세요.
        
        
----- **** SET Operator(SET 연산자) **** -----
----- 집합 연산자 
UNION  합집합
여러개의 SQL문의 결과에 대한 합집합으로 결과에서 모든 중복된 행 제거하고은 하나의 행으로 만든다.
UNION ALL 
여러개의 SQL문의 결과에 대한 합집합으로 중복된 행도 그대로 결과에 표시.
INTERSECT
SQL문의 결과에 대한 교집합 중복된 행은 제거.
MINUS 차집합
-- 면접시 JOIN 과 UNION 의 차이점에 대해서 말해보세요~~!! 
==>  UNION 은 테이블(뷰)과 테이블(뷰)을 합쳐서 보여주는 것으로써,
      이것은 행(ROW)과 행(ROW)을 합친 결과를 보여주는 것이다.

    A = { a, x, b, e, g }
    B = { c, d, a, b, y, k, m}    
    A ∪ B = {a, b, c, d, e, g, k, m, x, y}  ==> UNION               
                                             {a, b, c, d, e, g, k, m, x, y}
                                             / UNION ALL 
                                             {a, x, b, e, g, c, d, a, b, y, k, m} 
    A ∩ B = {a,b}  ==> INTERSECT
                       {a,b}
    A - B = {x,e,g} ==> MINUS 
                        {x,e,g}
                        A에만 존재하고 B에는 없는것.
    B - A = {c,d,y,k,m} ==> MINUS 
                            {c,d,y,k,m}
                            B에는 존재하고 A에는 없는것.
        A = {1, 2, 3} 원소가 3개
        B = {a, b} 원소가 2개
*/
 
 
 
 
 -- 현재가 2020년 8월이므로 저저번달은 2020년 6월달
 -- 2020년 6월에 판매되어진 정보는 tbl_panmae_202006 이라는 테이블속에 이관시키고자 한다.
 -- 먼저 2020년 6월에 판매되어진 정보를 추출해야 한다.
 
 create table tbl_panmae_202006
 as
 select *
 from tbl_panmae
 where to_char(panmaedate, 'yyyymm') = to_char(add_months(sysdate, -2) ,'yyyymm');
 
 -- 현재가 2020년 8월이므로 저저번달은 2020년 7월달
 -- 2020년 6월에 판매되어진 정보는 tbl_panmae_202006 이라는 테이블속에 이관시키고자 한다.
 
 create table tbl_panmae_202007
 as
 select *
 from tbl_panmae
 where to_char(panmaedate, 'yyyymm') = to_char(add_months(sysdate, -1) ,'yyyymm');
 
 -- 현재가 2020년 8월이므로 tbl_panmae 테이블에는
 -- 2020년 8월에 판매되어진 정보만 남기고자 한다.
 
 -- tbl_panmae 테이블에서 이번달에 판매가 아닌 행들만 모두 추출하세요.

 select *
 from tbl_panmae
 where to_char(panmaedate, 'yyyymm') != to_char(sysdate, 'yyyymm')
 
 
 -- 이관했기떄문에 필요없음. 따라서 행을 지우자.
 
 -- tbl_panmae 테이블에서 이번달에 판매가 아닌 행들만 모두 삭제하세요.

 
 delete from tbl_panmae -- 행삭제
  where to_char(panmaedate, 'yyyymm') != to_char(sysdate, 'yyyymm'); -- 어떠한 행들만 지울래.
 -- 9개 행 이(가) 삭제되었습니다.
 
 commit; -- 커밋을 해야만 데이터에 저장.
 
        select *
        from tbl_panmae;
        
        
        select *
        from tbl_panmae_202006;
        
                
        select *
        from tbl_panmae_202007;
 
 -- 지금 까지 판매되어진 제품별로 판매량의 합계를 추출하세요.
 
 ----------------------------------------------
 제품명                                    판매량의합계
 ----------------------------------------------
 감자깡                                          3242
 고구마깡
 새우깡
 허니버터칩

        
        select *
        from tbl_panmae_202007
        UNION
        select *
        from tbl_panmae_202006
        UNION
        select *
        from tbl_panmae;                
   -- UNION을 한 결과는 첫번째 컬럼으로 오름차순되어 나온다.
   ------------------------------------------------------
   -- UNION ALL은 전혀 관계가 없다.
        select *
        from tbl_panmae_202007
        UNION ALL
        select *
        from tbl_panmae_202006
        UNION ALL
        select *
        from tbl_panmae;                
        
        
   ------------------------------------------------------     
        select jepumname as 제품명
                     , sum(panmaesu) as 판매수
        from
        (
        select *
        from tbl_panmae_202007
        UNION ALL
        select *
        from tbl_panmae_202006
        UNION ALL
        select *
        from tbl_panmae        
        ) V
        group by jepumname
        order by 1;
 
select *
from tbl_panmae;
---------------------------------------------------------------------------------------
with V as (
                                select *
        from tbl_panmae_202007
        UNION ALL
        select *
        from tbl_panmae_202006
        UNION ALL
        select *
        from tbl_panmae  
                    )
                    select jepumname, sum(panmaesu)
                    from V
                    group by jepumname;
---------------------------------------------------------------------------------------
-- [퀴즈] 아래와 같이 나오도록 하세요..        
-- 2020년 6월 부터 현재까지 발생한 판매에 있어서 제품별, 월별, 판매량의 합계를 나타내세요.
제품명             판매월             판매량의합계
감자깡              2020-06               10
전체                   전체                   000

        with V as (
        select *
        from tbl_panmae_202007
        UNION 
        select *
        from tbl_panmae_202006
        UNION 
        select *
        from tbl_panmae
        )
        
        -- 판매월을 일을 빼고  yyyymm으로 바꾸고, group by로 판매월별, 제품명으로 묶는다.
        select to_char(panmaedate, 'yyyymm')
        from V
        where  to_char(panmaedate, 'yyyymm') in(to_char ('2020-06', '2020-07','2020-08'
        
 --------------------------------------------------------------------------------
 with V as (
                                select *
        from tbl_panmae_202007
        UNION 
        select *
        from tbl_panmae_202006
        UNION 
        select *
        from tbl_panmae  
                    )
                    
                    select decode (grouping(jepumname), 0, jepumname, '전체') as 제품명,  to_char(panmaedate, 'yyyy-mm') as 판매월
                                 ,  sum(panmaesu) as 판매량의합계
                                 
                    from V
                    group by rollup(jepumname,  to_char(panmaedate, 'yyyy-mm'))
                    order by 1;
                    
                   
----------------------------------------------------------------------------------------

with S as 
 (
        select panmaesu
        from tbl_panmae_202007
        UNION 
        select panmaesu
        from tbl_panmae_202006
        UNION 
        select panmaesu
        from tbl_panmae  
 ) 
 
 
     select    sum(panmaesu)
     from S
     group by jepumname;
        
        select *
        from tbl_panmae;

with V as (
                                select *
        from tbl_panmae_202007
        UNION 
        select *
        from tbl_panmae_202006
        UNION 
        select *
        from tbl_panmae)
        
                    select decode (grouping(jepumname), 0, jepumname, '전체') as 제품명
                                 ,  to_char(panmaedate, 'yyyy-mm') as 판매월
                                 ,  sum(panmaesu) as 판매량의합계
                                 , round (sum(panmaesu)/(select sum(panmaesu)from V) *100,1) as 퍼센티지
                                  
                    from V
                    group by rollup(jepumname,  to_char(panmaedate, 'yyyy-mm'))

                    
---------------------------------------------------------------------------------------
------------ **** INTERESECT(교집합), minus(차집합) **** ----------------------
rollback;
insert into tbl_panmae_202006(panmaedate, jepumname, panmaesu)
values(to_date('2020-08-01', 'yyyy-mm-dd'), '허니버터칩', 10);

insert into tbl_panmae_202007(panmaedate, jepumname, panmaesu)
values(to_date('2020-08-01', 'yyyy-mm-dd'), '허니버터칩', 10);

insert into tbl_panmae_202006(panmaedate, jepumname, panmaesu)
values(to_date('2020-08-01', 'yyyy-mm-dd'), '허니버터칩', 10);
                
commit;
                    
 select *
        from tbl_panmae_202007
        UNION 
        select *
        from tbl_panmae_202006
        UNION 
        select *
        from tbl_panmae


 select *
        from tbl_panmae_202007
        UNION ALL
        select *
        from tbl_panmae_202006
        UNION ALL
        select *
        from tbl_panmae
        
        
 select *
        from tbl_panmae_202007
        INTERSECT
        select *
        from tbl_panmae_202006                    
                    
 
  select *
        from tbl_panmae_202007
        MINUS
        select *
        from tbl_panmae_202006                      

        
        -- ***tbl_panmae_202006 테이블과 tbl_panmae_202007 테이블에 중복되어져 있는 행을 추출해서 삭제하세요.
        select *
        from tbl_panmae_202006
        union
        select *
        from tbl_panmae_202007;
        
        delete from tbl_panmae_202007
        where (panmaedate, jepumname, panmaesu) in (
                select *
                from tbl_panmae_202006
                intersect
                select *
                from tbl_panmae_202007);
        
        rollback;
                 
 -----------------------------------------------------------------------------                   
                    
insert into tbl_panmae_202006
 select *
        from tbl_panmae_202006
        where jepumname = '감자깡'
        commit;
        
insert into tbl_panmae_202006
 select jepumname, to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') , panmaesu
        from tbl_panmae_202006
        where jepumname = '새우깡' and panmaedate = to_date('2020-06-21 14:32:48', 'yyyy-mm-dd');
        

        delate from tbl_panmae_202006
        where jepumname = '감자깡' and to_char(panmaedate, 'yyyy-mm-dd hh24:mi:ss') = '2020-06-21 14:32:48' and panmaesu = 10;
        
select *
from tbl_panmae_202006

-- *** tbl_temporary 테이블 삭제하기 *** --


select *
from tbl_temporary;
drop table tbl_teoporary purge;

---

-- 테이블 자체를 지우는 것

------------- 중복된 값을 제거하기 ---------------------------------------------------
------------- ***** Pseudo Column (의사, 유사, 모조) 컬럼 **** -------------
-----  rowid, rownum

select jepumname, panmaedate, panmaesu, count(*)
from tbl_panmae_202006
group by jepumname, panmaedate, panmaesu
having count(*) > 1 


select jepumname, panmaedate, panmaesu, rowid
from tbl_panmae_202006
where jepumname in( '새우깡', '감자깡' );

select jepumname, panmaedate, panmaesu, rowid
from tbl_panmae_202006
where jepumname in(    select distinct jepumname
                                                from tbl_panmae_202006 
                                               where jepumname in('새우깡', '감자깡')  );


select jepumname, panmaedate, panmaesu, rowid
from tbl_panmae_202006
where (jepumname, panmaedate, panmaesu) in(select jepumname, panmaedate, panmaesu
                                                                                              from tbl_panmae_202006
                                                                                             group by jepumname, panmaedate, panmaesu
                                                                                             having count(*) > 1);


delete from tbl_panmae_202006
where rowid in ('AAAE6/AAEAAAAGjAAC' , 'AAAE6/AAEAAAAGnAAD' ,
'AAAE6/AAEAAAAGnAAE'
,'AAAE6/AAEAAAAGnAAF'
,'AAAE6/AAEAAAAGnAAG' , 'AAAE6/AAEAAAAGnAAC')

--- 행이중복되면 lowid를 적용..

rollback;   ---- 마지막저장지점으로 이동.
commit;  -- 저장.




select rowum, jepumname, panmaedate, panmaesu
from tbl_panmae;


-- rownum은 select 되어진 행의 행번호를 나타내고자 할때 사용하는 pseudo colum 이다.

select boardno, subject, userid, registerday
from tbl_board
order by 1 desc;          ----             rownum은 기본값은 insert 되어진 순서대로 나온다.



-------------------------------------------------------------------------------------------------------------------------
번호            글번호                                           글제목                                          글쓴이                             작성일자
--------------------------------------------------------------------------------------------------------------------------
                        6	좋은 하루 되시고 건강하시고 부자되시고 늘 행복하세요	leess	                      20/08/14
                        5	오늘도 좋은하루되세요	                                                        hongkd	                      20/08/14
                        4	기쁘고 감사함이 넘치는 좋은하루되세요 	                        emojh	                      20/08/14
                        3	건강하세요	                                                                        leess	                      20/08/14
                        2	반갑습니다	                                                                        eomjh	                      20/08/14
                        1	안녕하세요	                                                                        leess	                      20/08/14


with A as (
select 
             boardno
            , subject
            , userid
            , registerday
from tbl_board)

select rownum,  boardno, subject,userid
            , registerday
            from A;
            
            -- 또는
            

select  row_number( ) over(order by boardno desc) 
            , boardno
            , subject
            , userid
            , registerday
from tbl_board;


with B as (

with A as (



select 
             boardno
            , subject
            , userid
            , registerday
from tbl_board)

select rownum,  boardno, subject,userid
            , registerday
            from A
            where rownum between 1 and 2;            -------- rownum 은 where 절에 바로  쓸수가 없다.!!!!
    )
    
    select boardno
                  , subject
                  , userid
                  , registerday
                  where rno between 3 and 4;
                  
                  
                  
   -- 또는
                  
                  
                  
                  
                  
                  
                  
                  
                  
                  
    
                                                                                      --------  그러므로 inline view 를 사용해야만 올바르게 나온다.
                                                                                             
                                                                                                





---- 페이지당 2개씩 보여주고자 한다.
---- 1페이지당 rownum 1~2 boardno => 6-5
---- 1페이지당 rownum 3~4 boardno => 5-4
---- 1페이지당 rownum 5~6 boardno => 4-3









                    
---------------------------------JOIN------------------------------------------------- 
    select  *
    from employees;  -- 107개 행

    select count(*)
    from departments; -- 27개 행
    
    
    -- JOIN 컬럼과 컬럼을 합친다. 1992 방식
     select *
    from employees, departments;
    
    select count(*)
    from employees, departments;
    
    select 107(employees 행의수 )*27(departments 행의 수)
    from dual;
    
     /*    A = {1, 2, 3} 원소가 3개
        B = {a, b} 원소가 2개
        A▣ B = { (1,a), (1,b)
                         , (2,a), (2,b)
                         , (3,a), (3,b) } */


     -- 데카르트 곱(수학) ==> 원소의 곱 : 3*2 = 6개(모든 경우의수)
            --> 수학에서 말하는 데카트르곱을 데이터베이스에서는 Catersian Product 라고 부른다.



  -- JOIN 컬럼과 컬럼을 합친다. 1999 방식
  -- 테이블과 테이블사이에 JOIN을 쓴다.
    select *
    from employees cross join departments;
    
    select count(*)
    from employees cross join departments; 
    
    select 107(employees 행의수 )*27(departments 행의 수)
    from dual;
    
    
     /*    A = {1, 2, 3} 원소가 3개
        B = {a, b} 원소가 2개
        A▣ B = { (1,a), (1,b)
                         , (2,a), (2,b)
                         , (3,a), (3,b) } */

    
 -- cross join 은 프로야구를 예를 들면 10개 팀이 있는데
 -- 각 1팀당 경기를 몇번해야 하는지 구할때 쓰인다. 1팀당 모든 팀과 경기를 펼쳐야 한다.
 -- cross join은 그룹함수로 나온 1개의 행을 가지고 어떤 데이터 값을 얻으려고 할 때 사용한다.
 -- 크로스 조인 모든경우의 수를 다결합해서 보여주는 조인방식
 
 -- 사원번호           사원명          부서번호   기본급여        전체사원의평균급여           평균급여와의차액 --
 -- 위와 같이 나오도록 구하세요 ...


  select trunc (avg(salary)) as AVGSAL
  from employees -- 1개
  
  select employee_id, first_name || ' ' || last_name, department_id, salary
  from employees;  -- 107개
  
  
  select employee_id as 사원번호 , ename as 사원명 , salary as 기본급여 ,  avgsal as 기본급여평균, salary-avgsal as 평균급여와의차액
  from
  (
      select employee_id, first_name || ' ' || last_name as ENAME, department_id, salary
  from employees
  ) A
  ,
    (
    select trunc (avg(salary)) as AVGSAL
  from employees 
    ) B;
    
    cross join 
    (
    select trunc(avg(salary)) as avgsal
    from employees
    ) B;
    
                ---- **** EQUI JOIN **** -----
                -- 부서번호   부서명      사원번호       사원명      기본급여 --
                -- 위와 같이 나오도록 하세요.

                    -- 1992년도 방식으로 컬럼합치기.
                select *
                from employees, departments
                where employees.department_id = departments.department_id
                order by employees.employee_id asc;
                
                
                select *
                from employees, departments
                where employees.department_id = departments.department_id;
                -- 그냥 합치는건 조건이 없는것.
        
                
                select *
                from employees E, departments D
                where E.department_id = D.department_id
                order by E.employee_id asc;
                
                
                select *
                from employee E, departments D
                where E.department_id = D.department_id;
                
                
                select *
                from employees E, departments D
                where E.department_id = D.department_id;
                
                
                
                
        
                select *
                from employees E, departments D
                where E.department_id = D.department_id
                order by E.employee_id asc;
                
                --- 별칭사용가능
                 -- 변칭을 달아주는 순간 별칭을 사용해야함. 원래 명을 사용하면 오류가 나타남. 

                select  department_id as 부서번호
                              , department_name as 부서명
                              , employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E, departments D
                where E.department_id = D.department_id
                order by E.employee_id asc;
                -- coulum ambiguously defined 
                -- 오류 !! : 애매모호하다! 
                -- 소속을 밝혀주어야함 중복된 컬럼인경우.
            
                 select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E, departments D
                where E.department_id = D.department_id -- 조인조건절
                order by D.department_id , employee_id, salary desc;     --1992 CODE 방식           
                
                select      D.department_id as 부서번호
                                 , department_name as 부서명
                                 , E.employee_id as 사원번호
                                 , first_name || ' ' || last_name as 사원명
                                 , salary as 급여
                from employees E , departments D
                where E.department_id = D.department_id
                order by D.department_id, employee_id;
                
                
                
                -- employees 테이블에서 사원들이 실제 근무하고 있는 부서번호를 나타내세요.
                select distinct department_id
                from employees
                order by 1;
                
                -- select 바로 다음에 컬럼명 앞 distinct을 사용하면 select 되어진 행중에 중복된 행값이 있으면 
                -- 중복을 제거해주고 한번만 보여주게끔 해주는 것이다.
                select *
                from departments; -- 부서번호가 10~110 120~270
                
                
                -- 1999 CODE 방식(ANSI SQL)
                ---- 1. inner join(내부조인)
                 select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E inner join departments D
                on E.department_id(+) = D.department_id -- 조인조건절(+)가 없는쪽 테이블(department_id D) 출력해준다음에 employee D에 맵핑에 들어간다.
                                                                                                  --   E.department_id(+) = D.department_id 일치하는 조건만 맵핑!
                order by D.department_id , employee_id;   --    1999 CODE 방식(ANSI SQL)  
                
                
                
                                
                /*
                    부서번호                      부서명                사원번호           사원명         기본급여
                    ------------------     ---------------
                    departments      departments                              employees
                    employees
                */
                
                
                
                select E.department_id as 부서번호
                             , department_name as 부서명
                             , employee_id as 사원번호
                             , first_name || ' ' || last_name as 사원명
                             , salary as 기본급여
                from employees E  join departments D
                on    nvl(E.department_id, -9999)= nvl(D.department_id, -9999);
                
                -- 이너조인은 공통적으로 가지고 있는것만.
                -- 크로스 조이는 전체다        
                
                -- missing keyword
                -- 998 인경우 (+) 안먹음
                select   E.department_id as 부서번호
                             , department_name as 부서명
                             , employee_id as 사원번호
                             , first_name || ' ' || last_name as 사원명
                             , salary as 기본급여
                from employees E left join departments D
                on E.department_id = D.department_id;
                
                
                ---- *** OUTER JOIN(외부조인) *** -----
                          select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                        from employees E Right OUTER join departments D
                        -- employees 테이블을 일단 다보여라.
                        on E.department_id = D.department_id --  LEFT,와 Right 는 왼쪽과 오른쪽 테이블인을 from 절의 해당방향을  출력해준다음에 다른한바양의 테이블로 맵핑에 들어간다.
                        order by D.department_id , employee_id;   --    1999 CODE 방식(ANSI SQL)  
                        -- OUTER는 생략가능하다.
                
                ---------------------------------------------------------------------------------------------------------------------------------------------
                
                
                
                 ---- *** OUTER JOIN(외부조인) *** -----
                          select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E FULL OUTER join departments D
                -- employees 테이블을 일단 다보여라.
                on E.department_id = D.department_id --  FULL은 from 절 양쪽테이블을 다 보여준다음에 맵핑시켜주는 것.
                order by D.department_id , employee_id;   --    1999 CODE 방식(ANSI SQL)  
                

                 select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E  join departments D
                on E.department_id = D.department_id(+) -- 조인조건절
                order by D.department_id , employee_id;  --    1999 CODE 방식(ANSI SQL)                  
                
                
                
                
                
                 -- 1.1 inner은 생략이 가능하다
                 select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E  join departments D
                on E.department_id = D.department_id 
                order by D.department_id , employee_id;   
                
                
                
                 select  D.department_id as 부서번호
                              , department_name as 부서명
                              -- E,D나 중복이 안된 컬럼은 신분을 안밝혀도 된다.
                              -- 중복되어진 컬럼은 반드시 표시를 해주어야한다.
                              , E.employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여
                from employees E  join departments D
                on E.department_id = D.department_id 
                order by D.department_id , employee_id;   
                                
                


--- SQL 1999 CODE 방식은
---- 1. 모든 경우의 수(catersian Product ) **> cross JOIN
---- 조인 조건절이 없음.
----  inner JOIN, null을 제외한 조인 (inner)JOIN
---- 2. OUTER JOIN --> null 까지 보여주고자 한다라면 ==> LEFT (OUTER) JOIN, RIGHT (OUTER) JOIN, FULL (OUTER) JOIN







 -- 부서번호      부서명    사원번호        사원명          부서번호   기본급여   부서평균급여   평균급여와의차액 --
 -- 위와 같이 나오도록 구하세요...
 
 /*
        부서번호별 평균급여                      부서번호            사원번호              사원명              기본급여 
        -----------------------                    --------------------------------------------------------------------
        10                  3500                                                                 employees
        20                  4000                            10                    1122                 홍길동                  3700                                                                                                    
        30                  2800                            10                    1133                 이순신                  3000
        ...                      ....                              20                    1144                 엄정화                  5000
        110               3200                             ..                      .......                   ........                   ....
        
                       V
                                       
        조인조건절 ==> V.부서번호 = E.부서번호
 */
 
 
 
 with V as (select department_id, trunc (avg(salary)) as avgsal
                        from employees
                        group by department_id
                        
                        )
 
        select   
                        E.department_id
                        ,avgsal
                        , V.department_id
                        , employee_id
                        , first_name || ' ' || last_name
                        , salary
        from employees E left join V
        on E.department_id = V.department_id
        order by 1,4; 
        
        

 
        select   E.department_id as 부서번호
                       , employee_id as 사원번호
                       , first_name || ' ' || last_name as 사원명
                       , salary as 기본급여
                       , avgsal as 부서평균급여
                       , salary-avgsal as 평균급여차액
        from employees E join
        (select department_id, trunc(avg(salary)) as AVGSAL
         from employees
         group by department_id
        ) V
        on nvl(E.department_id, -9999) = nvl(V.department_id, -9999)
        order by 1, 4 desc;
 

        -- 한쪽 셀렉트에서 nvl함수를 사용하여  null 값을 -9999로하고 
        -- 조인조건절에서 한쪽에서 nvl.

        select   E.department_id as 부서번호
                       , employee_id as 사원번호
                       , first_name || ' ' || last_name as 사원명
                       , salary as 기본급여
                       , avgsal as 부서평균급여
                       , salary-avgsal as 평균급여차액
        from employees E join
        (select nvl(department_id, -9999) as department_id, trunc(avg(salary)) as AVGSAL
         from employees
         group by department_id
        ) V
        on nvl(E.department_id, -9999) = V.department_id
        where E.department_id between 10 and 50
        order by 1, 4 desc;
        
        
        
        -- 아래방법을 권장한다.
        select   E.department_id as 부서번호
                       , employee_id as 사원번호
                       , ENAME as 사원명
                       , salary as 기본급여
                       , avgsal as 부서평균급여
                       , salary-avgsal as 평균급여차액
        from (   select department_id, employee_id, first_name || ' ' || last_name as ENAME,  salary
                        from employees 
                        where department_id between 10 and 50 ) E join
        (select department_id, trunc(avg(salary)) as AVGSAL
         from employees
         where department_id between 10 and 50
         group by department_id
        ) V
        on E.department_id = V.department_id
        order by 1, 4 desc;
        
        -- where 절을 from 안에 집어넣어라.
        
        ---- **** ==== NON-EQUI JOIN ==== **** ----
        --> 어떤 컬럼의 값이 특정 범위에 속할 때 사용하는 JOIN 이다. 

        -- 소득세율 지표 관련 테이블을 생성한다. 
        create table tbl_taxindex
        (lowerincome    number       -- 연봉의 최저
        ,highincome      number       -- 연봉의 최대
        ,taxpercent        number(2,2)  -- 세율  -0.99 ~ 0.99 
        );
        -- 데이터 타입이 숫자로 되어진 것만 받고자 할 경우에는 number 타입을 사용한다.
        -- number          --> 숫자가 무제한으로 들어온다.
        -- number(4)     --> 숫자가 -9999 ~ 9999 까지만 들어온다.
        -- number(5)     --> 숫자가 -99999 ~ 99999 까지만 들어온다.
        -- number(3,1) --> 숫자가 -99.9 ~ 99.9 까지만 들어온다.
        -- number(4, 2) --> 숫자가 -99.99 ~ 99.99 까지만 들어온다.
        -- number(전체자리수, 소수부)
        insert into tbl_taxindex(lowerincome,highincome,taxpercent)
        values(1, 99999, 0.02);

        insert into tbl_taxindex(lowerincome,highincome,taxpercent)
        values(100000, 149999, 0.05);

        insert into tbl_taxindex(lowerincome,highincome,taxpercent)
        values(150000, 199999, 0.08);

        insert into tbl_taxindex(lowerincome,highincome,taxpercent)
        values(200000, 10000000000000000, 0.1);

        commit;
        
        select *
        from tbl_taxindex;
        
        ------------------------------------------------------------------------------------
        사원번호            사원명             연봉              세율              소득세액
        ------------------------------------------------------------------------------------
           1001              홍길동           50000          0.02        50000 * 0.02
           1002              엄정화           250000        0.08        50000 * 0.08
           
        
        select employee_id as 사원번호
                , first_name || ' ' || last_name as 사원명
                ,  to_char(nvl (salary+(salary*commission_pct), salary) * 12,'999,999') as 연봉
                , taxpercent as 세율
                ,  to_char (nvl (salary+(salary*commission_pct), salary) * 12 * taxpercent, '99,99,9')  as 소득세액
        from employees E,  tbl_taxindex T  -- SQL 1992 CODE
        where nvl (salary+(salary*commission_pct), salary)*12 between lowerincome and highincome          -- 조인조건절
        order by 1;
        
           

        --- sql 1999 code
        select employee_id as 사원번호
                , first_name || ' ' || last_name as 사원명
                ,  to_char(nvl (salary+(salary*commission_pct), salary) * 12,'999,999') as 연봉
                , taxpercent as 세율
                ,  to_char (nvl (salary+(salary*commission_pct), salary) * 12 * taxpercent, '99,99,9')  as 소득세액
        from employees E join tbl_taxindex T  
        on nvl (salary+(salary*commission_pct), salary)*12 between lowerincome and highincome          -- 조인조건절
        order by 1;
        
        
        ----- **** SELF JOIN(자기조인) **** -----
        /*
                자기자신의 테이블(뷰)를 자기자신의 테이블(뷰)과 JOIN 시키것을 말한다.
                이떄 반드시 테이블(뷰)에 대한 alias를 달리 주어서 실행해야 한다.
        */
        
        --------------------------------------------------------------------------------------------------------
        사원번호            사원명             이메일           급여              직속상관번호          직속상관명
        --------------------------------------------------------------------------------------------------------
        100              StevenKing	SKING           24000          null                              null
        102	              LexDe Haan LDEHAAN      17000          100                  Steven	King
        103	      AlexanderHunold	 AHUNOLD  9000            102                      Lex	De Haan
        104	                    BruceErnst      BERNST  6000            103               Alexander	 Hunold
        
        emloyee_id    first_name || last_name                         employee_id           first_name || last_name
                                                                                                       manager_id
        
        SELECT     E1.employee_id as 사원번호 --E1
                           ,E1.first_name || ' ' || E1.last_name as 사원명    -- E1
                           ,E1.email as 이메일   -- E1
                           ,E1.salary as  급여  -- E1
                           ,E2.employee_id as 직속상관번호 --E2
                           ,E2.first_name || ' ' || E2.last_name as 직속상관명     -- E2
        FROM EMPLOYEES E1, EMPLOYEES E2 -- SQL 1992 CODE
        where E1.manager_id = E2.employee_id(+)
        order by E1.employee_id;
        
-- 괄호플라스가 없는쪽을 전부다 보여라.

        SELECT     E1.employee_id as 사원번호 --E1
                           ,E1.first_name || ' ' || E1.last_name as 사원명    -- E1
                           ,E1.email as 이메일   -- E1
                           ,E1.salary as  급여  -- E1
                           ,E2.employee_id as 직속속상관번호 --E2
                           ,E2.first_name || ' ' || E2.last_name as 직속상관명     -- E2
        FROM EMPLOYEES E1 LEFT join EMPLOYEES E2  -- SQL 1999 CODE
        on E1.manager_id = E2.employee_id
        order by E1.employee_id;


        -- [퀴즈] --
   create table tbl_authorbook
   (bookname       varchar2(100)
   ,authorname     varchar2(20)
   ,loyalty        number(5)
   );
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('자바프로그래밍','최은지',1000);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','이영경',800);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('로빈슨크루소','최은지',500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('조선왕조실록','안세형',2500);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','박지현',1200);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','이지은',1300);
   
   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('그리스로마신화','박수빈',1700);

   insert into tbl_authorbook(bookname, authorname, loyalty)
   values('어린왕자','김동휘',1800);
   
   commit;
        
        
        
       
        select *
        from tbl_authorbook

     
        
        /* 
                tbl_authorbook 테이블에서 공저(도서명은 동일하지만 작가명이 다른 도서)로 지어진
                도서정보를 나타내세요(self join을 사용해서 풀이)
                */

        --------------------------------------------------------------------------------------------------------
                도서명             작가명             로얄티
        --------------------------------------------------------------------------------------------------------
        그리스로마신화,    박지현,              1200
        그리스로마신화,    이지은,               1300
        
        -- self join을 사용하라고해서 풀긴풀었으나 왜 이렇게 되는지 정확하게 이해는 못함.
        select distinct  T1.bookname as 도서명
                     , T1.authorname as 작가명
                     , T1.loyalty as 로열티 
        from tbl_authorbook T1  join tbl_authorbook T2
        on T1.bookname = T2.bookname and T1.authorname != T2.authorname
        order by 1;
        
        
        
        ------ **** MULTI Table Join(다중 테이블 조인) **** -------
        --> 3개 이상의 테이블(뷰)을 가지고 조인 시켜주는 것이다.
        
        
        /*
                -----------------------------------------------------------------------------------------------------------------
                부서번호            부서명             국가명             부서주소            사원번호            사원명              기본급여
                -----------------------------------------------------------------------------------------------------------------
                부서번호 => departments.department_id
                                => employess.department_id
                
                부서번호 컬럼을 가지고 departments 테이블과 employess 테이블 사이에 조인조건절을
                만들어 JOIN 할 수 있다.
                
                부서명 => departments.department_name
                
                국가명 => countires.country_name
                
                부서주소 => locations.street_address
                                      locations.city
                                      locations.street_province
                
                
                사원번호 사원명 기본급여 => employees
        */
                
                select *
                from employees; -- E.department_id
                select *
                from departments; -- D.department_id     D.location_id
                
                
                select *
                from locations; -- L.location_id L.country_id
                
                select *
                from countries; -- C.country_id
                
                --4 개의 테이블을 하나로 합치기.
                
                select E.department_id as 부서번호
                             , department_name as 부서명
                             , country_name as 국가명
                             , street_address || ' ' || city  || ' ' || state_province as 부서주소
                             , employee_id as 사원번호
                             , first_name || ' ' || last_name as 사원명
                             , salary as 기본급여
                from employees E, departments D, locations L, countries C          --------------- 1992
                where E.department_id= D.department_id and
                              D.location_id = L.location_id and L.country_id = C.country_id
                                order by 1;     
                        

                
                
        
                -- 같은 데이터값을 경유해서 묶어주기.
        
                        -- 1999로 바꾸기
                select E.department_id as 부서번호
                             , department_name as 부서명
                             , country_name as 국가명
                             , street_address || ' ' || city  || ' ' || state_province as 부서주소
                             , employee_id as 사원번호
                             , first_name || ' ' || last_name as 사원명
                             , salary as 기본급여
                from employees E  join  departments D
                on E.department_id=D.department_id
                Join locations L 
                on  D.location_id = L.location_id
                join countries C 
                on  C.country_id = C.country_id
                order by 1;
                
                
        select *
        from locations;

        select *
        from countries;
        
        
        --- 오류
        --1) 컬럼명을 잘못씀... 하...
        --2)    ORA-00904: "E"."DEPARTMNT_ID": invalid identifier >> e가 빠졌다.  오류뜨면 내용이 안에 나오니 읽어보기.
        --         invalid identifier 부적합한 식별자 ( 1. 컬럼명을 잘못썻다.)
        --        00904. 00000 -  "%s: invalid identifier"
                        
                        
            select E.department_id as 부서번호
                             , department_name as 부서명
                             , country_name as 국가명
                             ,street_address|| ' ' || city  || ' ' || state_province as 부서주소
                             , employee_id as 사원번호
                             , first_name || ' ' || last_name as 사원명
                             , salary as 기본급여
                from employees E, departments D, locations L, countries C          --------------- 1992
                where E.department_id= D.department_id(+) and
                              D.location_id = L.location_id(+) and 
                              L.country_id = C.country_id(+)
                order by 1; 
                
                
                ---- SQL 1999 code
                select E.department_id as 부서번호
                             , department_name as 부서명
                             , country_name as 국가명
                             , street_address || ' ' || city  || ' ' || state_province as 부서주소
                             , employee_id as 사원번호
                             , first_name || ' ' || last_name as 사원명
                             , salary as 기본급여
                from employees E LEFT join  departments D
                on E.department_id=D.department_id
                LEFT Join locations L 
                on  D.location_id = L.location_id
                LEFT join countries C 
                on  C.country_id = C.country_id
                order by 1;
                
                
                
                
        ------------------------------------------------------------------------------------
        사원번호            사원명             연봉              세율              소득세액
        ------------------------------------------------------------------------------------
           1001              홍길동           50000          0.02        50000 * 0.02
           1002              엄정화           250000        0.08        50000 * 0.08                
                
        --- [과제] ---   107명이 나와야 함!!!!
  -------------------------------------------------------------------------------------------------------------------------------------
   부서번호   부서명   부서주소  부서장성명  사원번호  사원명  연봉  연봉소득세액  부서내연봉평균차액   부서내연봉등수
  -------------------------------------------------------------------------------------------------------------------------------------
  select *
  from employees;
  select *
  from departments;

  
with V as
        (
        select employee_id as 사원번호
                , first_name || ' ' || last_name as 사원명
                ,  nvl (salary+(salary*commission_pct), salary) * 12 as yearsal
                , taxpercent as 세율
                ,  nvl (salary+(salary*commission_pct), salary) * 12 * taxpercent  as tax
                , E1.department_id 
        from employees E1,  tbl_taxindex T  
        where nvl (E1.salary+(E1.salary*E1.commission_pct), E1.salary)*12 between T.lowerincome and T.highincome
        ) 




        select   E1.department_id as 부서번호
                     , department_name as 부서명
                     , location_id as 부서주소
                     , E2.first_name || ' ' || E2.last_name  as 부서장성명
                     , E1.employee_id as 사원번호
                     , E1.first_name || ' ' || E1.last_name as 사원명
                     , nvl (E1.salary+(E1.salary*E1.commission_pct), E1.salary) * 12 as 연봉
                     , nvl (E1.salary+(E1.salary*E1.commission_pct), E1.salary) * T.taxpercent as 연봉소득세액
                     ,as 부서내연봉평균차액
                     ,as 부서내연봉등수
                     
                     
        from employees E1, employees E2, departments D, tbl_taxindex T, V
        where E1.department_id = D.department_id and D.manager_id = E2.employee_id;        
        
        

        --------------------------------------------------------------------------------------------------------------------------------------------
           WITH V AS(
        SELECT department_id, TRUNC(AVG(nvl(salary + (salary * commission_pct), salary) * 12)) AS avgsal
        FROM employees
        GROUP BY department_id
   )
   SELECT E.department_id AS 부서번호  
        , D.department_name AS 부서명 
        , street_address || ' ' || city || ' ' || state_province AS 부서주소  
        , E2.first_name || ' ' || E2.last_name AS 부서장성명  
        , E.employee_id AS 사원번호  
        , E.first_name || ' ' || E.last_name AS 사원명  
        , to_char(nvl(E.salary + (E.salary * E.commission_pct), E.salary) * 12, '999,999') AS 연봉
        , to_char(nvl(E.salary + (E.salary * E.commission_pct), E.salary) * 12 * taxpercent, '99,999.9') AS 연봉소득세액  
        , to_char(nvl(E.salary + (E.salary * E.commission_pct), E.salary) * 12 - V.avgsal, '999,999') AS 부서내연봉평균차액   
        , RANK() OVER(PARTITION BY E.department_id ORDER BY nvl(E.salary + (E.salary * E.commission_pct), E.salary) * 12 DESC )AS 부서내연봉등수
   FROM employees E
   LEFT JOIN V
   ON E.department_id = V.department_id
   LEFT JOIN tbl_taxindex T 
   ON nvl(salary + (salary * commission_pct), salary) * 12 BETWEEN lowerincome AND highincome
   LEFT JOIN departments D
   ON E.department_id = D.department_id
   LEFT JOIN locations L
   ON D.location_id = L.location_id
   LEFT JOIN employees E2
   ON D.manager_id = E2.employee_id
   ORDER BY 1,10;
        
    --------------------------------------------------------------------------------------------------------------------------------------------    
        
 --------------- ======= ***** SUB Query **** ======= --------------
/*

        -- SUB Query(서브쿼리)란?
        select 문속에 또 다른 select 문이 포함됭져 있을때 포함되어진 select 문을  SUB Query(서브쿼리) 라고 부른다
        
        select ....
        from ....       => Main Query(메인쿼리 == 외부쿼리)
        where ... in (select ....
                                from .... ) ==> SUB Query(서브쿼리 == 내부쿼리)
                                
        
        
        
        
        
        
        
        
        
      
        

*/


  /*
                employees 테이블에서 기본급여가 제일많은 사원과
                기본급여가 제일적은 사원의 정보를  사원번호, 사원명, 기본급여로 나타내세요.
                
  */
                select employee_id as 사원번호
                              , first_name || ' ' || last_name as 사원명
                              , salary as 기본급여.
                from employees
                where salary = (select max(salary) from employees) or
                              salary = (select min(salary) from employees);
        
        salary의 최대값 == > select max(salary) from employees ==>24000
        salary의 최소값 == > select min(salary) from employees ==>24000



/*
        employees 테이블에서 부서번호가 60, 80번 부서에 근무하는 사원들중에
        월급이 50번 부서 직원들의 '평균월급' 보다 많은 사원들만
        부서번호, 사원번호, 사원명, 월급을 나타내세요....
*/      
        from employees
        where department_id in (60,80) and 
                        월급 > (50번 부서 직원들의 '평균월급');
                        
                        
                        
        월급 ==> nvl(salary + (salary*commsission_pct), salary) 
        
        50번 부서 직원들의 '평균월급' 
        ==>  
        select trunc (avg(nvl(salary + (salary*commission_pct), salary) ))
        from employees
        where department_id = 50


        select department_id as 부서번호
                     , employee_id as 사원번호
                     , first_name || ' ' || last_name as 사원명
                     , avg(nvl(salary + (salary*commission_pct), salary) ) as 월급
        from employees
        where department_id in (60,80) and 
                        avg(nvl(salary + (salary*commission_pct), salary)) > (        select avg(nvl(salary + (salary*commission_pct), salary) )
                                                                                                                                                        from employees
                                                                                                                                                        where department_id = 50 );
                                                                                                                                                        
        ------------ *** === any, all === *** ---------------
        Sub Query 절에서 사용되어지는 Any는 or 와 흡사하고, 
        Sub Query 절에서 사용되어지는 ALL은 AND 와 흡사하다.
        
        --- employees 테이블에서 salary가 30번 부서에 근무하는 사원들의 salary와 동일한 사원들만 추출하세요.
        -- 단, 30번 부서에 근무하는 사원은 제외시키세요...
        
        from employees
        where nvl(department_id, -9999) != 30 and
                      salary = (30번 부서에 근무하는 사원들의 salary);
                      
        30번 부서에 근무하는 사원들의 salary
        ==> select salary
                from employees
                where department_id = 30
        
        
        
        
                --salary in() 같은말
                
        /*
                11000
                3100
                2900
                2800
                2600
                2500
        */
        
        
  
        
        
        select department_id, employee_id, first_name || ' ' || last_name, salary
        from employees
        where nvl(department_id, -9999) != 30 and
                      salary = any (select distinct salary       -------------- in
                                         from employees
                                         where department_id = 30)
       order by 1;                                         


        /*
                기본급여(salary)가 제일많은 사원을 제외한 나머지 모든 사원들만
                사원번호,사원명, 기본급여(SALARY)을 나타내세요.
        */
        
        
        기본급여가 제일 많은사람
        SELECT department_id, employee_id, first_name || ' ' || last_name, salary
        FROM employees
        WHERE salary >= ALL ( SELECT  MAX(salary) FROM employees);
        
        -- 또는
        SELECT department_id, employee_id, first_name || ' ' || last_name, salary
        FROM employees
        WHERE salary =  ( SELECT  MAX(salary) FROM employees);        
        

        기본급여가 제일 많은사람
        SELECT department_id, employee_id, first_name || ' ' || last_name, salary
        FROM employees
        WHERE not salary >= ALL ( SELECT  MAX(salary) FROM employees);
        
        -- 또는
        
        기본급여가 제일 많은사람
        SELECT department_id, employee_id, first_name || ' ' || last_name, salary
        FROM employees
        WHERE salary <= ALL ( SELECT  MAX(salary) FROM employees);
                
        
        ---- ALL을 사용할 경우 조심해야할 사항이 있다!! ------
        /*
                커미션(salary*commission_pct) 이 제일 많은 사원을 제외한 나머지 모든 사원들만
                사원번호,사원명, 기본급여(SALARY)을 나타내세요.
        */       
        
        SELECT department_id, employee_id, first_name || ' ' || last_name, salary*commission_pct
        FROM employees
        WHERE salary =  ( SELECT  MAX(salary*commission_pct) FROM employees);        

        SELECT department_id, employee_id, first_name || ' ' || last_name, salary*commission_pct
        FROM employees
        WHERE salary*commission_pct >= ALL ( SELECT  MAX(salary*commission_pct) FROM employees
                                                    where salary*commission_pct is not null);
                                                    
                                                    desc employees;
                                                    
                                                    
                                                    
                                                    
                                                    
        ---------------------------- *** pairwise Sub Query *** -------------------------------------------
        /*
                employees 테이블에서
                부서번호별로 salary가 최대인 사원과
                부서번호별로 salary가 최소인 사원의 정보를 
                부서번호, 사원번호, 사원명, 기본급여를 나타내세요...
        */
        
        
        from employees
        where (department_id, salary) in (10, 4000
                                                                         10, 2000
                                                                         20, 5000
                                                                         20, 1000)
        
        
        /*
                부서번호        기본급여                                추출한 결과는 부서번호 기본급여
                -------------------------
                10                    3000
                10                    4000
                10                    2000
                
                20                    5000
                20                    4000
                20                    3000
                20                    1000
                
                
        */

          -- 부서번호별 최대값,최소값을 구하기.
        
        select department_id, employee_id, first_name || ' ' || last_name, salary
        from employees
        where (nvl(department_id, -9999), salary) in (
        select nvl(department_id, -9999), max(salary) 
        from employees
        group by department_id
        union
        select nvl(department_id, -9999), min(salary) 
        from employees
        group by department_id
        )
        order by 1;
        


        부서번호별로 최대,최소값

        select distinct department_id, max(salary) 
        from employees
        group by department_id
        union
        select department_id, min(salary) 
        from employees
        group by department_id;

       select  nvl(department_id, -9999), max(salary) 
        from employees
        group by department_id
        union
        select nvl(department_id, -9999), min(salary) 
        from employees
        group by department_id;




---------------- *** 상관 서브쿼리 *** ===== --------------------------
        /*
                상관서브쿼리 이라함은 Main Query(== 외부쿼리) 에서 사용된 테이블(뷰)에 존재하는 컬럼이
                Sub Query(== 내부쿼리)의 조건절(where절, having절)에 사용되어 질때를 
                상관 서브쿼리(== 서브상관쿼리)라고 부른다.
        */
        
        select department_id as 부서번호 , employee_id as 사원번호, salary as 기본급여,
                        rank() over(order by salary desc) as 전체등수
                        , rank() over (partition by department_id order by salary desc) as 부서내등수
                        
        from employees
        order by 1,3 desc;


-- 랭크 함수를 안쓰고 순위구하기 --

        select E.department_id as 부서번호 , E.employee_id as 사원번호, E.salary as 기본급여
        
        
                        , ( select count(*)+1
                           from employees
                           where  salary > E.salary )as 전체등수
                        ,  (select count(*)+1
                                from employees
                                where salary > E.salary and department_id=E.department_id
                                )as 부서내등수
                        
        from employees E
        order by 1,3 desc;



        select salary
        from employees
        order by 1 desc;

        -- 꼭 알아 두시길 부탁 드립니다. 깨먹으면 복구.
        --------------------------    ***    ==== *** 상관서브쿼리()를 사용한 update 처리하기 *** ==== ------------------------------------------
        
        create table tbl_employees_backup
        as
        select *
        from employees
        
        select * 
        from employees ;
        
        update employees set first_name = '최', last_name = '지훈';
        
        
        
        select *
        from tbl_employees_backup;
        
        -- 집어넣어라.
        update employees E set first_name = (select first_name from tbl_employees_backup
                                                                              where employee_id = E.employee_id)
                                                  , last_name = (select last_name from tbl_employees_backup
                                                                              where employee_id = E.employee_id)
        
        
        commit;
        
        
        -- [퀴즈] 공저로 지어진 도서정보만 추출하세요 (단, Sub Query를 사용하셔서 해요)
        
        select bookname, authorname, loyalty
                        , (select *
                            from tbl_authorbook
                            where bookname=E.bookname and authorname = E.authorname)
        from tbl_authorbook E;
        -- 논리상 안맞음
        
        select bookname, count(*)
        from tbl_authorbook
        group by bookname
        having count(*) > 1;
        
        
        select *
        from tbl_authorbook
        where bookname in (select bookname, count(*)
                                                        from tbl_authorbook
                                                        group by bookname
                                                        having count(*) > 1);
        
        
        -------- *** Sub Quary 절을 사용하여 테이블을 생성할 수 있다. *** -------
        -------- employees 테이블에서 부서번호 10번과 30번에 근무하는 직원들만 뽑아서 그 직원들만 보이도록
        -------- tbl_employees_sub 라는 테이블을 생성하세요...
        
        
        
        
        create table tbl_employees_sub
        as
        select *
         from employees
        where department_id in (10,30)
        order by department_id, employee_id;
        
        
        
        insert into tbl_employees_sub
        select *
        from employees
        where department_id = 50;
        
        
        select *
        from tbl_employees_sub;
        
        
        
        -------- *** Sub Quary 절을 사용하여 테이블을 입력할 수 있다.  *** -------
        
        
        
        -------- *** Sub Quary 절을 사용하여 테이블을 변경할 수 있다.  *** -------
        
        update tbl_employees_sub set salary = (select max(salary) from employees)
                                                           , commission_pct=(select max(commission_pct) from employees)
        where department_id in (10,50)
        

        select *
        from tbl_authorbook
        
        
        ---------------- *********** 데이터 조작어(DML, Date Manuplation Language) --------
        ---- DML 문은 기본적으로 수동 commit 이다.
        --- 즉, DML 문을 수행한 다음에는 바로 디스크(파일)에 적용되지 않고 commit 해야만 적용된다.
        --- 그래서 dml 문을 수행한 다음에  디스크(파일)에 적용되지 않고자 한다라면 rollback 하면 된다.
        
        1. insert    -- 데이터 입력 
        2. update -- 데이터 수정
        3. delete   -- 데이터 삭제
        4. merge  -- 데이터 병합
        
        insert 는 문법이
        insert into 테이블명(컬럼명, 컬럼명....) values(값1, 값2,....);
        
        ※ unconditional insert all 
        [문법] insert all
                   into tbl_emp(empno, ename,monthsal,gender,manager_id,department_id,department_name)
                   valuse(값1, 값2, .....)
                   into tbl_emp_backup(empno, ename,monthsal,gender,manager_id,department_id,department_name)
                   valuse(값3, 값4, ...._
                   SUB Query 문;

                   
                   
                   
        create table tbl_emp
        (empno number(6)
        , ename varchar2(50)
        , monthsal      number(7)
        , gender                  varchar2(4)
        , manager_id      number(6)
        ,department_id number(4)
        ,department_name varchar2(30)
        );
        
         create table tbl_emp_backup
        (
          empno number(6)
        , ename varchar2(50)
        , monthsal      number(7)
        , gender                  varchar2(4)
        , manager_id      number(6)
        ,department_id number(4)
        ,department_name varchar2(30)
        );
        
        
                           

          insert  all
          into tbl_emp(empno, ename,monthsal,gender,manager_id,department_id,department_name)
          values (employee_id, ename, msal+100, gender, manager_id, department_id, department_name)
          into tbl_emp_backup(empno, ename,monthsal,gender,manager_id,department_id,department_name)
        values(employee_id, ename, msal-100, gender, manager_id,  department_id, department_name)
         select    employee_id
                      , first_name || ' ' || last_name as ename
                      , nvl(salary + (salary * commission_pct), salary) as msal
                      , case when substr(jubun, 7, 1,) in ('1','3') then '남' else '여' end  as gender 
                      , E.manager_id
                      , E.department_id
                      , department_name
                      from employees E left join departments D
                      on E.department_id = D.department_id
                      order by E.department_id , employee_id desc;
        
        select *
        from tbl_emp;
             ※ conditional insert all  
             
             
        create table tbl_emp_dept50
        (empno number(6)
        , ename varchar2(50)
        , monthsal      number(7)
        , gender                  varchar2(4)
        , manager_id      number(6)
        ,department_id number(4)
        ,department_name varchar2(30)
        );   
        
        
        
     create table tbl_emp_dept80
        (empno number(6)
        , ename varchar2(50)
        , monthsal      number(7)
        , gender                  varchar2(4)
        , manager_id      number(6)
        ,department_id number(4)
        ,department_name varchar2(30)
        );   
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        















 -- (퀴즈) 부서번호      부서명    사원번호        사원명          부서번호   기본급여   부서평균급여   평균급여와의차액       부서내급여등수      전체급여 등수--
 -- 위와 같이 나오도록 구하세요...
 
        
        -- 질문하기 (뭐가잘못됬는지) --
        
        select E.department_id as 부서번호
                      , departmnet_name as 부서명
                      , employee_id as 사원번호
                      , first_name || ' ' || last_name  as 사원명
                      , employee_id as 부서번호
                      , salary as 기본급여
                      , avgsal as 부서평균급여
                      , salary-avgsal as 평균급여와의차액
                      , rank() over(order by salary desc) as 전체급여등수
                      , rank() over(partition by department_id order by salary desc) as 부서내급여등수
                      
        from employees E join departments 
        (       select department_id, trunc (avg(salary))  as avgsal
                from employees
                group by department_id
        )
        V
        on E.department_id=V.department_id
        order by 1,4 asc;
        
        
        ---- 질문하기----
        -- missing right parenthesis 콤마가빠졌다.
        select    E.department_id as 부서번호
                      , department_name as 부서명
                      , 사원번호
                      , 사원명
                      , V.부서번호
                      , 기본급여
                      , 부서평균급여
                      , (V.salary-V.부서평균급여) as 평균급여차액       
                      , rank() over(partition by department_id order by ( V.기본급여 desc ) as 부서내급여등수
                      , rank() over(order by (V.기본급여 desc ) as 전체급여등수
        from department E join 
        (
        select department_id as 부서번호,  employee_id as 사원번호, first_name || ' ' || last_name as 사원명,trunc(avg(salary) as 월급) , salary as 기본급여 
        from employees
        group by department_id)
        V
        on nvl(E.department_id, -9999) =  nvl(V.department_id, -9999)
        order by 1, 4 desc;

 
 
        select *
        from departments;
 
 
 
 -- (퀴즈) 부서번호가 10, 20, 30, 40, 50번 부서에 근무하는 사원들을 대상으로 
 --  부서명    사원번호        사원명          부서번호   기본급여   부서평균급여   평균급여와의차액       부서내급여등수      전체급여 등수--
 --  위와 같이 나오도록 구하세요...
 
 
 
 
 
 
 
 
 
 
 
        
        


      
      /*
문제 1. 
employees 테이블에서 커미션을 받는 사원들만 
사원번호, 사원명, 기본급여, 수당, 월급을 
사원번호로 오름차순 정렬후, 월급의 내림차순으로 정렬하여 나타내세요.






------------------------------------------------------
사원번호    사원명            기본급여 수당     월급
------------------------------------------------------
145	    John Russell	    14000	5600	19600
146	    Karen Partners	    13500	4050	17550
147	    Alberto Errazuriz	12000	3600	15600
148	    Gerald Cambrault	11000	3300	14300
149	    Eleni Zlotkey	    10500	2100	12600
150	    Peter Tucker	    10000	3000	13000
151	    David Bernstein	    9500	2375	11875
152	    Peter Hall	        9000	2250	11250
153	    Christopher Olsen	8000	1600	9600
154	    Nanette Cambrault	7500	1500	9000
155	    Oliver Tuvault	    7000	1050	8050
156	    Janette King	    10000	3500	13500
157	    Patrick Sully	    9500	3325	12825
158	    Allan McEwen	    9000	3150	12150
159	    Lindsey Smith	    8000	2400	10400
160	    Louise Doran	    7500	2250	9750
161	    Sarath Sewall	    7000	1750	8750
162	    Clara Vishney	    10500	2625	13125
163	    Danielle Greene	    9500	1425	10925
164	    Mattea Marvins	    7200	720	    7920
165	    David Lee	        6800	680	    7480
166	    Sundar Ande	        6400	640	    7040
167	    Amit Banda	        6200	620	    6820
168	    Lisa Ozer	        11500	2875	14375
169	    Harrison Bloom	    10000	2000	12000
170	    Tayler Fox	        9600	1920	11520
171	    William Smith	    7400	1110	8510
172	    Elizabeth Bates	    7300	1095	8395
173	    Sundita Kumar	    6100	610	    6710
174	    Ellen Abel	        11000	3300	14300
175	    Alyssa Hutton	    8800	2200	11000
176	    Jonathon Taylor	    8600	1720	10320
177	    Jack Livingston	    8400	1680	10080
178	    Kimberely Grant	    7000	1050	8050
179	    Charles Johnson	    6200	620	    6820
*/
  
문제 1. 
employees 테이블에서 커미션을 받는 사원들만 
사원번호, 사원명, 기본급여, 수당, 월급을 
사원번호로 오름차순 정렬후, 월급의 내림차순으로 정렬하여 나타내세요.

select  
               employee_id    as 사원번호
                                       , first_name || '   ' || last_name as 사원명
                                       , salary as 기본급여
                                       , commission_pct as 수당
                                       , salary+(salary*commission_pct) as 월급
                        
from employees
where commission_pct is not null
order by 1, salary+(salary*commission_pct) desc;

---------------------------------------1. 정답--------------------------------------------- 

select  employee_id AS 사원번호
    , first_name || ' ' || last_name AS 사원명
    , salary AS 기본급여
    , (salary * commission_pct) AS 수당
    , nvl(salary + (salary * commission_pct), salary) AS 월급
from employees
where commission_pct is not null 
    and
    commission_pct > 0
order by 사원번호, 월급 desc;



/*
문제 2. 
employees 테이블에서 커미션이 없는 사원들중 남자직원들만 
부서번호, 사원명, 주민번호, 기본급여를 
부서번호로 오름차순 정렬후, 사원명의 오름차순으로 정렬하여 나타내세요.

-------------------------------------------------------
부서번호    사원명             주민번호        기본급여
-------------------------------------------------------
30	    Alexander Khoo	    6110151234567	3100
30	    Guy Himuro	        7810151234567	2600
30	    Karen Colmenares	7909151234567	2500
30	    Shelli Baida	    6009301234567	2900
50	    Adam Fripp	        7009151234567	8200
50	    Curtis Davies	    7510121234567	3100
50	    Douglas Grant	    7511171234567	2600
50	    Irene Mikkilineni	9406251234567	2700
50	    James Marlow	    0010153234567	2500
50	    Jean Fleaur	        6510191234567	3100
50	    Joshua Patel	    7310011234567	2500
50	    Kelly Chung	        9511151234567	3800
50	    Kevin Feeney	    9710181234567	3000
50	    Kevin Mourgos	    8110191234567	5800
50	    Ki Gee	            0503253234567	2400
50	    Laura Bissot	    8507251234567	3300
50	    Martha Sullivan	    6510221234567	2500
50	    Mozhe Atkinson	    6511111234567	2800
50	    Nandita Sarchand	8512131234567	4200
50	    Payam Kaufling	    7111011234567	7900
50	    Peter Vargas	    7710061234567	2500
50	    Renske Ladwig	    9510021234567	3600
50	    Samuel McCain	    0910183234567	3200
50	    Sarah Bell	        0510133234567	4000
50	    Shanta Vollman	    8010131234567	6500
50	    Stephen Stiles	    9610041234567	3200
50	    Timothy Gates	    8510161234567	2900
60	    Alexander Hunold	7510151234567	9000
60	    David Austin	    6510151234567	4800
60	    Diana Lorentz	    0803153234567	4200
60	    Valli Pataballa	    6009201234567	4800
70	    Hermann Baer	    7803251234567	10000
90	    Neena Kochhar	    8510151234567	17000
90	    Steven King	        6010151234567	24000
100	    Daniel Faviet	    8810151234567	9000
100	    Jose Manuel Urman	6610151234567	7800
100	    Luis Popp	        6710151234567	6900
*/
  
문제 2. 
employees 테이블에서 커미션이 없는 사원들중 남자직원들만 
부서번호, 사원명, 주민번호, 기본급여를 
부서번호로 오름차순 정렬후, 사원명의 오름차순으로 정렬하여 나타내세요.

select
employee_id    as 사원번호
                                       , first_name || '   ' || last_name as 사원명
                                       , salary as 기본급여
                                       , commission_pct as 수당
        
from employees
where commission_pct is null
order by 1, 2 desc;
 
 ---------------------------------------2. 정답--------------------------------------------- 
 select  department_id AS 부서번호
    , first_name || ' ' || last_name AS 사원명
    , jubun AS 주민번호
    , salary AS 기본급여
from employees
where (commission_pct is null 
     or
     commission_pct = 0
    )
    and
    substr(jubun, 7, 1) in ('1','3')
order by 부서번호, 사원명;  
 
 
/*
문제 3. 
employees 테이블에서 부서번호 30,50,60,80,100 번 부서에 근무하지 않는 사원들만 
부서번호, 사원명, 월급을 
부서번호로 오름차순 정렬후, 월급의 내림차순으로 정렬하여 나타내세요.

---------------------------------------
부서번호     사원명             월급
---------------------------------------
10	     Jennifer Whalen	  4400
20	     Michael Hartstein	  13000
20	     Pat Fay	          6000
40	     Susan Mavris	      6500
70	     Hermann Baer	      10000
90	     Steven King	      24000
90	     Neena Kochhar	      17000
90	     Lex De Haan	      17000
110	     Shelley Higgins	  12008
110	     William Gietz	      8300
(null)	 Kimberely Grant	  8050
*/
  
문제 3. 
employees 테이블에서 부서번호 30,50,60,80,100 번 부서에 근무하지 않는 사원들만 
부서번호, 사원명, 월급을 
부서번호로 오름차순 정렬후, 월급의 내림차순으로 정렬하여 나타내세요.


SELECT
                   employee_id  as 부서번호
                   , first_name || '    ' || last_name as 사원명         
                   , nvl (salary+(salary*commission_pct), salary)  as    월급
                   
FROM employees
where employee_id != '30' and employee_id != '50' and employee_id != '60'  and employee_id != '80'  and employee_id != '100'
order by 1, 3 desc;

 ---------------------------------------3. 정답--------------------------------------------- 
select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , nvl(salary + (salary * commission_pct), salary) AS 월급
from employees
where nvl(department_id, -9999) not in(30,50,60,80,100)
order by 부서번호, 월급 desc;

/*
문제 4. 
employees 테이블에서 부서번호가 존재하는 사원들중 월급이 8000 이상 8999 이하인 사원들만 
부서번호, 사원명, 월급을 
부서번호로 오름차순 정렬후, 월급의 내림차순으로 정렬하여 나타내세요.

------------------------------------------
부서번호        사원명            월급
------------------------------------------
50	        Adam Fripp	        8200
50	        Matthew Weiss	    8000
80	        Sarath Sewall	    8750
80	        William Smith	    8510
80	        Elizabeth Bates	    8395
80	        Oliver Tuvault	    8050
100	        John Chen	        8200
110	        William Gietz	    8300
*/

문제 4. 
employees 테이블에서 부서번호가 존재하는 사원들중 월급이 8000 이상 8999 이하인 사원들만 
부서번호, 사원명, 월급을 
부서번호로 오름차순 정렬후, 월급의 내림차순으로 정렬하여 나타내세요.


SELECT
                   employee_id  as 부서번호
                   , first_name || '    ' || last_name as 사원명         
                   , nvl (salary+(salary*commission_pct), salary)  as    월급
                   
FROM employees
where employee_id is not null and nvl (salary+(salary*commission_pct), salary) between 8000 and 8999
order by 1, 3 desc;


 ---------------------------------------4. 정답--------------------------------------------- 

select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , nvl(salary + (salary * commission_pct), salary) AS 월급
from employees
where department_id is not null
      and
      nvl(salary + (salary * commission_pct), salary) between 8000 and 8999
order by 부서번호, 월급 desc; 




/*
문제 5. 
employees 테이블에서 3월과 9월에 태어난 남자 사원들만 
사원명, 주민번호를 
사원명의 오름차순으로 정렬하여 나타내세요.

----------------------------------
사원명               주민번호
----------------------------------
Adam Fripp	        7009151234567
Diana Lorentz	    0803153234567
Ellen Abel	        1209103234567
Hermann Baer	    7803251234567
Karen Colmenares    7909151234567
Ki Gee	            0503253234567
Shelli Baida	    6009301234567
Valli Pataballa	    6009201234567
*/


문제 5. 
employees 테이블에서 3월과 9월에 태어난 남자 사원들만 
사원명, 주민번호를 
사원명의 오름차순으로 정렬하여 나타내세요.
  
  SELECT 
     first_name || '    ' || last_name as 사원명
     , jubun as 주민번호
  FROM employees
  where substr(jubun, 3, 2) in('03','09') and substr(jubun, 7, 1) in('1','3')
  order by 1;
  
  
  ---------------------------------------5. 정답---------------------------------------------  
  
  select first_name || ' ' || last_name AS 사원명
     , jubun AS 주민번호
from employees
where substr(jubun,3,2) in ('09','03')
      and
      substr(jubun,7,1) in ('1','3')
order by 사원명;
  
  
  
  
/*
문제 6. 
employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
사원명, 주민번호, 성별을 나타내세요.
성별은 '남' 또는 '여'라고 나타낸다.

----------------------------------------------------
부서번호    사원명             주민번호        성별
----------------------------------------------------
30	    Den Raphaely        6709152234567	여
30	    Alexander Khoo      6110151234567	남
30	    Shelli Baida	    6009301234567	남
30	    Sigal Tobias	    6110152234568	여
30	    Guy Himuro	        7810151234567	남
30	    Karen Colmenares	7909151234567	남
50	    Matthew Weiss	    7702152234567	여
50	    Adam Fripp	        7009151234567	남
50	    Payam Kaufling	    7111011234567	남
50	    Shanta Vollman	    8010131234567	남
50	    Kevin Mourgos	    8110191234567	남
50	    Julia Nayer	        9012132234567	여
50	    Irene Mikkilineni	9406251234567	남
50	    James Landry	    9408252234567	여
50	    Steven Markle	    9204152234567	여
50	    Laura Bissot	    8507251234567	남
50	    Mozhe Atkinson	    6511111234567	남
50	    James Marlow	    0010153234567	남
50	    TJ Olson	        0005254234567	여
50	    Jason Mallin	    0110194234567	여
50	    Michael Rogers	    0412154234567	여
50	    Ki Gee	            0503253234567	남
50	    Hazel Philtanker	9510012234567	여
50	    Renske Ladwig	    9510021234567	남
50	    Stephen Stiles	    9610041234567	남
50	    John Seo	        9610052234567	여
50	    Joshua Patel	    7310011234567	남
50	    Trenna Rajs	        7310092234567	여
50	    Curtis Davies	    7510121234567	남
50	    Randall Matos	    7612012234567	여
50	    Peter Vargas	    7710061234567	남
50	    Winston Taylor	    8310012234567	여
50	    Jean Fleaur	        6510191234567	남
50	    Martha Sullivan	    6510221234567	남
50	    Girard Geoni	    6510232234567	여
50	    Nandita Sarchand	8512131234567	남
50	    Alexis Bull	        8510182234567	여
50	    Julia Dellinger	    7510192234567	여
50	    Anthony Cabrio	    8512192234567	여
50	    Kelly Chung	        9511151234567	남
50	    Jennifer Dilly	    7509302234567	여
50	    Timothy Gates	    8510161234567	남
50	    Randall Perkins	    9510192234567	여
50	    Sarah Bell	        0510133234567	남
50	    Britney Everett	    0810194234567	여
50	    Samuel McCain	    0910183234567	남
50	    Vance Jones	        1010134234567	여
50	    Alana Walsh	        9510032234567	여
50	    Kevin Feeney	    9710181234567	남
50	    Donald OConnell	    9810162234567	여
50	    Douglas Grant	    7511171234567	남

*/

문제 6. 
employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
사원명, 주민번호, 성별을 나타내세요.
성별은 '남' 또는 '여'라고 나타낸다.

select
              first_name || '    ' || last_name as 사원명
              , jubun as 주민번호
              , case 
                      when  substr(jubun, 7 , 1) = '1' then '남'
                       when     substr(jubun, 7 , 1) = '3' then '남'
                         when   substr(jubun, 7 , 1) = '2' then '여'
                            when substr(jubun, 7 , 1) = '4' then '여' 
                             else '외계인'
                            end as 성별

from employees
where department_id in (30,50);


-------------- when 을 빠트려서 안나온것. ------------------------------------------- 
SELECT
    *
FROM employees;

  ---------------------------------------6. 정답---------------------------------------------  
  select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , jubun AS 주민번호
     , case when substr(jubun,7,1) in('1','3') then '남'
       else '여'
       end AS 성별
from employees
where department_id in (30,50);
  
  
/*
문제 7. 
employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
사원명, 주민번호, 성별을 나타내세요.
성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.

------------------------------------------------------------
부서번호        사원명             주민번호            성별
------------------------------------------------------------
30	        Den Raphaely	    670915*******	여
30	        Alexander Khoo	    611015*******	남
30	        Shelli Baida	    600930*******	남
30	        Sigal Tobias	    611015*******	여
30	        Guy Himuro	        781015*******	남
30	        Karen Colmenares    790915*******	남
50	        Matthew Weiss	    770215*******	여
50	        Adam Fripp	        700915*******	남
50	        Payam Kaufling	    711101*******	남
50	        Shanta Vollman	    801013*******	남
50	        Kevin Mourgos	    811019*******	남
50	        Julia Nayer	        901213*******	여
50	        Irene Mikkilineni   940625*******	남
50	        James Landry	    940825*******	여
50	        Steven Markle	    920415*******	여
50	        Laura Bissot	    850725*******	남
50	        Mozhe Atkinson	    651111*******	남
50	        James Marlow	    001015*******	남
50	        TJ Olson	        000525*******	여
50	        Jason Mallin	    011019*******	여
50	        Michael Rogers	    041215*******	여
50	        Ki Gee	            050325*******	남
50	        Hazel Philtanker    951001*******	여
50	        Renske Ladwig	    951002*******	남
50	        Stephen Stiles	    961004*******	남
50	        John Seo	        961005*******	여
50	        Joshua Patel	    731001*******	남
50	        Trenna Rajs	        731009*******	여
50	        Curtis Davies	    751012*******	남
50	        Randall Matos	    761201*******	여
50	        Peter Vargas	    771006*******	남
50	        Winston Taylor	    831001*******	여
50	        Jean Fleaur	        651019*******	남
50	        Martha Sullivan	    651022*******	남
50	        Girard Geoni	    651023*******	여
50	        Nandita Sarchand    851213*******	남
50	        Alexis Bull	        851018*******	여
50	        Julia Dellinger	    751019*******	여
50	        Anthony Cabrio	    851219*******	여
50	        Kelly Chung	        951115*******	남
50	        Jennifer Dilly	    750930*******	여
50	        Timothy Gates	    851016*******	남
50	        Randall Perkins	    951019*******	여
50	        Sarah Bell	        051013*******	남
50	        Britney Everett	    081019*******	여
50	        Samuel McCain	    091018*******	남
50	        Vance Jones	        101013*******	여
50	        Alana Walsh	        951003*******	여
50	        Kevin Feeney	    971018*******	남
50	        Donald OConnell	    981016*******	여
50	        Douglas Grant	    751117*******	남
*/

문제 7. 
employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
사원명, 주민번호, 성별을 나타내세요.
성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.

select
              first_name || '    ' || last_name as 사원명
              , replace(jubun, (substr(jubun, 7, 12)), '******') as 주민번호
              , case 
                      when  substr(jubun, 7 , 1) = '1' then '남'
                       when     substr(jubun, 7 , 1) = '3' then '남'
                         when   substr(jubun, 7 , 1) = '2' then '여'
                            when substr(jubun, 7 , 1) = '4' then '여' 
                             else '외계인'
                            end as 성별

from employees
where department_id in (30,50);

문제 7. 
employees 테이블에서 부서번호 30번, 50번에 근무하는 사원들만 
사원명, 주민번호, 성별을 나타내세요.
성별은 '남' 또는 '여'라고 나타낸다. 그리고 주민번호는 생년월일만 기재해주고 나머지는 마스킹('*')처리해서 보여준다.

    select
                first_name || ' ' || last_name as 사원명
                , rpad(substr(jubun, 1, 6), length(jubun), '*') as 주민번호
                , case when substr(jubun, 7, 1) in (1,3) then '남' else '여' end as 성별 
    from employees 
    where department_id  in(30,50);



  ---------------------------------------7. 정답---------------------------------------------
  
  select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , rpad( substr(jubun, 1, 6), length(jubun), '*')  AS 주민번호
 -- 숫자는 1바이트 기때문에 가능한 마스킹 처리.
 --  , rpad( substr(jubun, 1, 6), 13, '*')  AS 주민번호
     , case when substr(jubun,7,1) in('2','4') then '여'
       else '남'
       end AS 성별
from employees
where department_id in (30,50)
order by department_id;

/*
문제 8. 
employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
사원명, 공개연락처, 비공개연락처를 나타내세요.
여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.

---------------------------------------------
사원명          공개연락처      비공개연락처
---------------------------------------------
Steven King	    515.123.4567	515.***.4567
Neena Kochhar	515.123.4568	515.***.4568
Lex De Haan	    515.123.4569	515.***.4569
*/



문제 8. 
employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
사원명, 공개연락처, 비공개연락처를 나타내세요.
여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.


select
              first_name || '    ' || last_name as 사원명
              , phone_number as 공개연락처
              ,  replace(phone_number, (substr(phone_number, 5, 3)), '***')as 비공개연락처
             
from employees
where department_id ='90';


SELECT
    replace ('쌍용교육센터', '교육', 'education')
FROM dual;



문제 8. 
employees 테이블에서 90번 부서에 근무하는 사원들만 아래와 같이
사원명, 공개연락처, 비공개연락처를 나타내세요.
여기서 비공개연락처란? 국번을 * 로 마스킹처리 한것을 말한다.

select
                      first_name || '  ' || last_name as 사원명
                    , phone_number as 공개연락처
                    , substr(phone_number, 1, instr(phone_number, '.', 1, 1)) || 
                       lpad('*',instr(phone_number,'.',1,2)-instr(phone_number,'.',1,1)-1,'*') 
                       --instr(phone_number 만큼 공간을 확보해서 *로 채우고 나머지 공간도 *로 채워라 라는뜻....
                       -- 어차피 마스킹이니까 *로 채워도 무관함.
                        || substr(phone_number, instr(phone_number,'.',1, 2)) as 비공개연락처
from employees
where department_id = 90;



  ---------------------------------------8. 정답---------------------------------------------
-- 비공개연락처는 phone_number 컬럼에서 국번만 '*' 로 변경한다.
-- 국번만 발췌해와야 하는데 어떻게 할까?
-- 국번만 발췌 => phone_number 컬럼에서 최초로 .이 나오는 위치 그 다음부터 두번째로 .이 나오는 위치 그 앞까지만 발췌를 해오면 됨.
-- 로직을 먼저 써본 후 


  select first_name || ' ' || last_name AS 사원명
     , phone_number AS 공개연락처
     , substr(phone_number,1,instr(phone_number,'.',1,1)) 
    || lpad('*',instr(phone_number,'.',1,2)-instr(phone_number,'.',1,1)-1,'*')  
    || substr(phone_number,instr(phone_number,'.',1,2)) AS 비공개연락처
from employees
where department_id = 90;

-- 첫번째 . 두번째 . 자리값의 차이를 빼면 그사이의 글자수가 나옴.
-- instr(phone_number , '.', 2) - 1 - instr (phone_number, '.',1)

/*
문제 9. 
employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
사원명, 공개연락처, 비공개연락처를 나타내세요.
여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

---------------------------------------------------------------
사원명               공개연락처               비공개연락처
---------------------------------------------------------------
John Russell	    011.44.1344.429268	    011.**.1344.******
Karen Partners	    011.44.1344.467268	    011.**.1344.******
Alberto Errazuriz   011.44.1344.429278	    011.**.1344.******
Gerald Cambrault    011.44.1344.619268	    011.**.1344.******
Eleni Zlotkey	    011.44.1344.429018	    011.**.1344.******
Peter Tucker	    011.44.1344.129268	    011.**.1344.******
David Bernstein	    011.44.1344.345268	    011.**.1344.******
Peter Hall	        011.44.1344.478968	    011.**.1344.******
Christopher Olsen   011.44.1344.498718	    011.**.1344.******
Nanette Cambrault   011.44.1344.987668	    011.**.1344.******
Oliver Tuvault	    011.44.1344.486508	    011.**.1344.******
Janette King	    011.44.1345.429268	    011.**.1345.******
Patrick Sully	    011.44.1345.929268	    011.**.1345.******
Allan McEwen	    011.44.1345.829268	    011.**.1345.******
Lindsey Smith	    011.44.1345.729268	    011.**.1345.******
Louise Doran	    011.44.1345.629268	    011.**.1345.******
Sarath Sewall	    011.44.1345.529268	    011.**.1345.******
Clara Vishney	    011.44.1346.129268	    011.**.1346.******
Danielle Greene     011.44.1346.229268	    011.**.1346.******
Mattea Marvins	    011.44.1346.329268	    011.**.1346.******
David Lee	        011.44.1346.529268	    011.**.1346.******
Sundar Ande	        011.44.1346.629268	    011.**.1346.******
Amit Banda	        011.44.1346.729268	    011.**.1346.******
Lisa Ozer	        011.44.1343.929268	    011.**.1343.******
Harrison Bloom	    011.44.1343.829268	    011.**.1343.******
Tayler Fox	        011.44.1343.729268	    011.**.1343.******
William Smith	    011.44.1343.629268	    011.**.1343.******
Elizabeth Bates	    011.44.1343.529268	    011.**.1343.******
Sundita Kumar	    011.44.1343.329268	    011.**.1343.******
Ellen Abel	        011.44.1644.429267	    011.**.1644.******
Alyssa Hutton	    011.44.1644.429266	    011.**.1644.******
Jonathon Taylor	    011.44.1644.429265	    011.**.1644.******
Jack Livingston	    011.44.1644.429264	    011.**.1644.******
Charles Johnson	    011.44.1644.429262	    011.**.1644.******
*/  

문제 9. 
employees 테이블에서 80번 부서에 근무하는 사원들만 아래와 같이
사원명, 공개연락처, 비공개연락처를 나타내세요.
여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

select
              first_name || '    ' || last_name as 사원명
              , phone_number as 공개연락처
              ,  replace(phone_number, (substr(phone_number, 5, 2)), '**') 
                                   phone_number, (substr(phone_number, 13, 6)), '******' ) as 비공개연락처
from employees
where department_id ='80';
  ---------------------------------------9. 정답---------------------------------------------
  
  ---- 국번만 '*' 마스킹처리한다.
  ---- phone_number 컬럼에서 국번전까지만 발췌하고 || 국번 || 다음부터 끝까지 발체한다.
  ---  국번만  translate를 사용하여 '*'로 바꾸어 주면 되겠다.
  
  select phone_number,  translate(phone_number, '0123456789', '**********') 
  from employees;
  
  /*
   select phone_number,  국번전까지 발췌 || translate(국번, '0123456789', '**********')  || 다음부터 끝까지 발체한다.
  from employees;
  */
  
--  phone_number 컬럼에서 국번전까지만 발췌
-- 국번 다음부터 끝까지 발췌

select phone_number,  substr(phone_number, 1, instr(phone_number, '.' ,1,1))
                                           ,  substr(phone_number, 1, instr(phone_number, '.' ,1,1))
                                           
    from employee;
      
SELECT
    *
FROM employees;

select first_name || ' ' || last_name AS 사원명
     , phone_number AS 공개연락처
     , substr(phone_number,1,instr(phone_number,'.',1,1)) 
    || lpad('*',instr(phone_number,'.',1,2)-instr(phone_number,'.',1,1)-1,'*') 
    || substr(phone_number,instr(phone_number,'.',1,2), instr(phone_number,'.',1,3)-instr(phone_number,'.',1,2))
    || translate(substr(phone_number,instr(phone_number,'.',1,3)), '0123456789','**********')  AS 비공개연락처
from employees
where department_id = 80;

/*
문제 10. (난이도 상)
employees 테이블에서 80번, 90번 부서에 근무하는 사원들만 아래와 같이
부서번호, 사원명, 공개연락처, 비공개연락처를 나타내세요.
여기서 비공개연락처란? 첫번째 국번과 마지막 개별번호를 * 로 마스킹처리 한것을 말한다.

------------------------------------------------------------------------------
부서번호        사원명              공개연락처               비공개연락처
------------------------------------------------------------------------------  
80	        John Russell	    011.44.1344.429268	    011.**.1344.******
80	        Karen Partners	    011.44.1344.467268	    011.**.1344.******
80	        Alberto Errazuriz   011.44.1344.429278	    011.**.1344.******
80	        Gerald Cambrault    011.44.1344.619268	    011.**.1344.******
80	        Eleni Zlotkey	    011.44.1344.429018	    011.**.1344.******
80	        Peter Tucker	    011.44.1344.129268	    011.**.1344.******
80	        David Bernstein	    011.44.1344.345268	    011.**.1344.******
80	        Peter Hall	        011.44.1344.478968	    011.**.1344.******
80	        Christopher Olsen   011.44.1344.498718	    011.**.1344.******
80	        Nanette Cambrault   011.44.1344.987668	    011.**.1344.******
80	        Oliver Tuvault	    011.44.1344.486508	    011.**.1344.******
80	        Janette King	    011.44.1345.429268	    011.**.1345.******
80	        Patrick Sully	    011.44.1345.929268	    011.**.1345.******
80	        Allan McEwen	    011.44.1345.829268	    011.**.1345.******
80	        Lindsey Smith	    011.44.1345.729268	    011.**.1345.******
80	        Louise Doran	    011.44.1345.629268	    011.**.1345.******
80	        Sarath Sewall	    011.44.1345.529268	    011.**.1345.******
80	        Clara Vishney	    011.44.1346.129268	    011.**.1346.******
80	        Danielle Greene	    011.44.1346.229268	    011.**.1346.******
80	        Mattea Marvins	    011.44.1346.329268	    011.**.1346.******
80	        David Lee	        011.44.1346.529268	    011.**.1346.******
80	        Sundar Ande	        011.44.1346.629268	    011.**.1346.******
80	        Amit Banda	        011.44.1346.729268	    011.**.1346.******
80	        Lisa Ozer	        011.44.1343.929268	    011.**.1343.******
80	        Harrison Bloom	    011.44.1343.829268	    011.**.1343.******
80	        Tayler Fox	        011.44.1343.729268	    011.**.1343.******
80	        William Smith	    011.44.1343.629268	    011.**.1343.******
80	        Elizabeth Bates	    011.44.1343.529268	    011.**.1343.******
80	        Sundita Kumar	    011.44.1343.329268	    011.**.1343.******
80	        Ellen Abel	        011.44.1644.429267	    011.**.1644.******
80	        Alyssa Hutton	    011.44.1644.429266	    011.**.1644.******
80	        Jonathon Taylor	    011.44.1644.429265	    011.**.1644.******
80	        Jack Livingston	    011.44.1644.429264	    011.**.1644.******
80	        Charles Johnson	    011.44.1644.429262	    011.**.1644.******
90	        Steven King	        515.123.4567	    515.***.****
90	        Neena Kochhar	    515.123.4568	    515.***.****
90	        Lex De Haan	        515.123.4569	    515.***.****
*/


  
 -- ////////////////////////////////////////////////////////////////////////
      
      
        ---------------------------------------10. 정답---------------------------------------------
      
      
      select department_id AS 부서번호
     , first_name || ' ' || last_name AS 사원명
     , phone_number AS 공개연락처
     , substr(phone_number, 1, instr(phone_number,'.',1,1)) 
    || lpad('*', instr(phone_number,'.',1,2)-instr(phone_number,'.',1,1)-1, '*')
    || case 
       when instr(phone_number,'.',1,3) > 0 
            then substr(phone_number, instr(phone_number,'.',1,2), instr(phone_number,'.',1,3)-instr(phone_number,'.',1,2))
       else ''
       end
    || translate(substr(phone_number, instr(phone_number,'.',-1,1)), '0123456789', '**********')
    AS 비공개연락처
from employees
where department_id in (80,90)
order by department_id;
      
      
      
      
      
      
    
    
  
       
       