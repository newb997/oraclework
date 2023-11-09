-- 테이블 컬럼의 정보 조회
/*
(') 홑따옴표 : 문자열일 때 사용
(") 쌍따옴표 : 컴럼명일 때 사용

    <select>
    데이터 조회할때 사용하는 구문
    
    RESULT SET : SELECT문을 통해서 조회된 결과물(조회된 행들의 집합)
    [표현법]
    SELECT 조회하려는 컬럼명, 조회하려는 컬럼명, ...
    FROM 테이블명 

*/
-- EMPLOYEE테이블의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE;

-- DEPARTMENT테이블의 모든 컬럼 조회
SELECT *
FROM DEPARTMENT;

-- DEPARTMENT테이블의 부서코드, 부서명만 조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT;

-- EMPLOYEE테이블의 EMP_ID, EMP_NAME, PHONE 컬럼 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE;

--JOB테이블의 모든 컬럼조회
SELECT *
FROM JOB;

-- EMPLOYEE테이블의 이름, 전화번호, 입사일, 급여 조회
SELECT EMP_NAME, PHONE, HIRE_DATE, SALARY
FROM EMPLOYEE;

/*
    <컬럼값을 통한 산술연산>
    SELECT절 컬럼명 작성부분에 산술연산 기술 가능(이때 산술연산된 결과조회)
    
*/
--EMPLOYEE에서 사원명, 사원의 연봉(급여*12) 조회
SELECT EMP_NAME, SALARY*12
FROM EMPLOYEE;

--EMPLOYEE에서 사원명, 급여, 보너스 조회
SELECT EMP_NAME, SALARY, BONUS
FROM EMPLOYEE;

--EMPLOYEE에서 사원명, 급여, 보너스, 연봉, 보너스를 포함한 연봉(급여+(보너스*급여))*12
SELECT EMP_NAME, SALARY, BONUS, SALARY*12, (SALARY+BONUS*SALARY)*12
FROM EMPLOYEE;
--산술연산 중 NULL이 존재하면 결과는 무조건 NULL이됨. 별도처리(나중에)

--EMPLOYEE에서 사원명, 입사일, 근무일수(오늘날짜-입사일)
--DATE형 끼리도 연산 가능 : 결과값은 일 단위
-- 오늘날짜 : SYSDATE
SELECT EMP_NAME, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;
--함수 수업시 DATE날짜처리하면 초단위를 관리할 수 있다.
-- ============================================================================================
/*
    <컬럼병에 별칭 지정하기>
    산술연산시 산술에 들어간 수식 그대로 컬럼명이 됨. 이때 별칭을 부여하면 깔끔하게 처리
    
    [표현법]
    컬럼명 별칭 / 컬럼명 AS(ALIAS) 별칭 / 컬럼명"별칭" / 컬럼명 AS"별칭" 4가지 방법이 있는데
    제일 많이씀 /                     / 제일 만이씀  /
    별칭에 띄어쓰기나 특수문자가 포함되면 반드시 "" 쌍따옴표를 넣어줘야한다.
*/

--EMPLOYEE에서 사원명, 급여, 보너스, 연봉, 보너스를 포함한 연봉(급여+(보너스*급여))*12
SELECT EMP_NAME 사원명, SALARY AS 급여, BONUS "보너스", SALARY*12 "연봉(원)", (SALARY+BONUS*SALARY)*12 "총 소득"
FROM EMPLOYEE;

-- 오늘날짜 : SYSDATE
SELECT EMP_NAME 사원명, HIRE_DATE, SYSDATE-HIRE_DATE
FROM EMPLOYEE;

/*
    <리터럴>
    임의로 지정된 문자열(')
    
    SELECT절에 리터럴을 제시하면 마치 테이블상에 존재하는 데이터 처럼 조회 가능
    조회된 RESULT SET의 모든 행에 반복적으로 출력
    
*/
--EMPLOYEE에 사번, 사원명, 급여 원 AS 단위조회
SELECT EMP_ID, EMP_NAME, SALARY,'원'AS"단위"
FROM EMPLOYEE;
-- ========================================================================

/*
    <연결 연산자 : || >
    여러 컬럼값들을 마치 하나의 컬럼값인것처럼 연결하거나, 컬럼값과 리터럴을 연결할 수 있음
*/
--EMPLOYEE에 사번, 사원명, 급여를 하나의 컬럼으로 조회
SELECT EMP_ID || EMP_NAME || SALARY
FROM EMPLOYEE;

SELECT EMP_ID || EMP_NAME || SALARY || '원'
FROM EMPLOYEE;

-- 홍길동의 월급은 900000원 입니다.
SELECT EMP_NAME||'의 월급은 '||SALARY|| '원 입니다'
FROM EMPLOYEE;

--홍길동의 전화번호는 PHONE이고 이메일은 EMAIL입니다
SELECT EMP_NAME||'의 전화번호는 '||PHONE|| '이고 이메일은 '||EMAIL|| '입니다.'
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------

/*
    <DISTINCT>
    컬럼의 중복된 값들을 한번씩만 표시하고자 할 때  
*/

SELECT JOB_CODE
FROM EMPLOYEE;

--EMPLOYEE에서 직급코드 중복제외하고 조회
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--EMPLOYEE에서 부서 중복제외하고 조회
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--유의사항 : SELECT절에서 DISTINCT는 한번만 적용
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

-------------------------------------------------------------------------------------------------------

/*
    <WHERE절>
    조회하고자 하는 테이블에서 특정 조건에 만족하는 데이터만 조회할 때
    WHERE절에 조건식을 제시
    
    [표현법]
    SELECT 컬럼, 컬럼, 산술연산, .....
    FROM 테이블명
    WHERE 조건식;
    
    >>비교연산자
    >,<,>=,<=  : 대소비교
    =   :  같은지 비교
    !=, ^=, <>     : 같지않은지 비교 
*/

--EMPLOYEE에서 부서코드가 'D9'인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9';

--EMPLOYEE에서 부서코드가 'D1'이 아닌 사원들의 사번, 사원명, 부서코드 조회
--컬럼, 테이블명은 대소문자 안가리는데 들어가져있는 데이터는 대소문자 가림 (여기서는 D1)
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE != 'D1';  -- !=, <>, ^=

--EMPLOYEE에서 급여가 400만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--EMPLOYEE에서 재직중인 사원의 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE ENT_YN = 'N';


--EMPLOYEE에서 급여가 300만원 이상인 사원들의 사원명, 급여, 입사일, 연봉 조회
SELECT  EMP_NAME, SALARY,  HIRE_DATE, SALARY*12
FROM EMPLOYEE
WHERE SALARY >= 3000000;


--EMPLOYEE에서 연봉이 5000만원 이상인 사원들의 사원명, 급여, 연봉, 부서코드 조회
SELECT  EMP_NAME, SALARY,  HIRE_DATE, SALARY*12, DEPT_CODE
FROM EMPLOYEE
WHERE SALARY*12 >= 50000000;


--EMPLOYEE에서 직급코드가 'J3;이 아닌 사원들의 사번, 사원명, 직급코드, 퇴사여부 조회
SELECT  EMP_ID, EMP_NAME, JOB_CODE, ENT_YN
FROM EMPLOYEE
WHERE JOB_CODE != 'J3';

-------------------------------------------------------------------------------------------------------

/*
    >>논리연산자
    여러개의 조건을 묶어서 제시하고자 할 때
    
    AND (~이면서, 그리고)
    OR (~이거나, 또는)
*/
--부서코드가 'D9'이면서 급여서 500만원 이상인 사원들의 사원명, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D9' AND SALARY >= 5000000;

--부서코드가 'D6'이거나 급여가 300만원 이상인 사원들의 사원명 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' OR SALARY >= 3000000;

--급여가 350만원이상 600만원 이하인 사원의 사번, 사원명, 급여조회(아래에서 AND말고 다른방법으로 설명하겠다.)
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE  SALARY >= 3000000 AND SALARY <= 6000000;

-------------------------------------------------------------------------------------------------------

/*
    >>BETWEEN AND
    ~이상 ~이하인 범위의 조건을 제시할 때
    
    [표현법]
    비교대상컬럼 BETWEEN 하한값 AND 상한값
    -> 해당 컬럼값이 하한값 이상이고 상한값 이하인경우
*/

--급여가 350만원이상 600만원 이하인 사원의 사번, 사원명, 급여조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE  SALARY BETWEEN 3000000 AND 6000000;


--급여가 350만원이상 600만원 이하를 제외한 사원의 사번, 사원명, 급여조회
SELECT EMP_ID, EMP_NAME, SALARY
FROM EMPLOYEE
WHERE  SALARY NOT BETWEEN 3000000 AND 6000000;

--입사일이 09/01/01 ~ 01/12/31 사이인 사원의 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE HIRE_DATE BETWEEN '90/01/01' AND '01/12/31';
-------------------------------------------------------------------------------------------------------

/*
    >>LIKE
    비교하고자하는 컬럼값이 내가 제시한 특정 패턴에 만족하는 경우 조회
    
    [표현법]
    비교대상컬럼 LIKE '특정패턴'
    : 특정패턴 제시시  '%', '_' 와일드카드로 사용할 수 있음
    
    % : 0글자 이상 
    EX) 비교대상컬럼 LIKE '문자%'  =>  비교대상 컬럼값이 '문자'로 시작되는 것들을 조회
           비교대상컬럼 LIKE '%문자'  =>  비교대상 컬럼값이 '문자'로 끝나는 것들을 조회
           비교대상컬럼 LIKE '%문자%'  =>  '문자'가 포함되는 것들을 조회
    문자
    문자들
    나중문자
    처음문자나중
    
    
    _  :  1글자
    EX) 비교대상컬럼 LIKE '_문자'  =>  비교대상 컬럼값의 '문자'앞에 무조건 한글자가 올경우(3글자만 가능)
           비교대상컬럼 LIKE '문자_'  =>  비교대상 컬럼값의 '문자'뒤에 무조건 한글자가 올경우(3글자만 가능)
            비교대상컬럼 LIKE '_문자_'  =>  비교대상 컬럼값의 '문자'앞과 뒤에 무조건 한글자가 올경우(4글자만 가능)
    이문자
    저문자
    커피문자(X)
*/

--사원들 중 성이 '전'씨인 사원들의 사번, 사원명 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--사원들 중 '하'가 포함되어있는 사원들의 사번, 사원명 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

--사원들 중 가운데 글자에 '하'가 포함되어있는 사원들의 사번, 사원명 조회
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_하_';

--전화번호 중 3번째 글자가 '1'인 사원의 사번, 사원명, 전화번호 조회
SELECT EMP_ID, EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE LIKE '__1%';


--이메일중 _앞에 글자가 3글자인 사원들의 사번, 사원명, 이메일 조회
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '____%';

/*
    와일드카드로 인식이 되지 않도록
    데이터와 와일드카드를 구분지어야 됨
    
    데이터 값으로 취급하고자하는 값 앞에 나만의 와일드카드(아무거나 다됨 : 문자, 숫자, 특수문자등)를 제시하고 나만의 와일드카드를 excape''에 등록해야함
*/
SELECT EMP_ID, EMP_NAME, EMAIL
FROM EMPLOYEE
WHERE EMAIL LIKE '___$_%' ESCAPE'$';

-- 이름이 '연'으로 끝나는 사원의 사번, 사원명, 입사일 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연';

-- 전화번호 처음 3자리가 010이 아닌 사원들의 사원명, 전화번호 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE PHONE NOT LIKE '010%';

--이름이 '하'가 포함되어 있고, 급여가 250만원 이상인 사원들의 사원명, 급여 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%' AND SALARY >= 2500000;

-- DEPARTMENT테이블에서 해외 영업부인 부서들의 부서코드, 부서명조회
SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '해외영업%' ;

-------------------------------------------------------------------------------------------------------

/*
    >>IS NULL / IS NOT NULL
    컬럼값에 NULL이 있는 경우 NULL값 비교에 사용되는 연산자
    
*/

--보너스를 받지 않는 사원의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
-- WHERE BONUS != NULL; 조회 안됨
WHERE BONUS IS NULL;

--보너스를 받는 사원의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;  
--WHERE NOT BONUS IS NULL; 위 아래 둘다 됨 위 표현식을 더 많이씀


--사수가 없는 사원들의 사번, 사원명, 사수번호 조회
SELECT EMP_ID, EMP_NAME, MANAGER_ID
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--부서배치를 받지 않았지만 보너스는 받는 사원들의 사원명, 보너스, 부서코드 조회
SELECT EMP_NAME, BONUS, DEPT_CODE
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

-------------------------------------------------------------------------------------------------------

/*
    >> IN / NOT IN
    IN : 컬럼값이 내가 제시한 목록중에 일치하는 값이 있는것만 조회
    NOT IN : 컬럼값이 내가 제시한 목록중에 일치하는 값을 제외한 나머지만 조회
    
    [표현법]
    비교대상컬럼 IN ('값1', '값2', '값3',...)
*/

--부서코드가  D5, D6, D8인 사원의 사원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
--WHERE  DEPT_CODE = 'D5' OR DEPT_CODE = 'D6' OR  DEPT_CODE = 'D8';
WHERE DEPT_CODE IN ('D5', 'D6', 'D8');

--부서코드가  D5이거나, D6이거나, D8이 아닌 사원의 사원명, 부서코드, 급여조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D5', 'D6', 'D8');

-------------------------------------------------------------------------------------------------------

/*
    <연산자 우선순위>
    1. ()
    2. 산술연산자
    3. 연결연산자
    4. 비교연산자
    5.  IS NULL / LIKE '패턴' / IN
    6.  BETWEEN AND
    7.  NOT(논리 연산자)
    8.  AND(논리 연산자)
    9.  OR(논리 연산자)
*/

--직급코드가 J7이거나 J2인 사원들 중 급여가 200만원 이상인 사원들의 모든 컬럼 조회
SELECT EMP_NAME, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE (JOB_CODE = 'J7' OR JOB_CODE = 'J2') AND SALARY >= 2000000;


--1. 사수가 없고 부서배치도 받지 않은 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--2. 연봉(보너스 포함X)이 3000만원 이상이고 보너스를 받지 않은 사원들의 사번, 사원명, 급여, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE SALARY*12 >= 30000000 AND BONUS IS NULL;

--3. 입사일이 95/01/01 이상이고 부서배치를 받은 사원들의 사번, 사원명, 입사일, 부서코드 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE
FROM EMPLOYEE
WHERE HIRE_DATE >= '95/01/01' AND DEPT_CODE IS NOT NULL ;

--4. 급여가 200만원 이상 500만원 이하고 입사일이 01/01/01 이상이고 보너스를 받지 않은 사원들의 사번, 사원명, 급여, 입사일, 보너스 조회
SELECT EMP_ID, EMP_NAME, SALARY, HIRE_DATE, BONUS
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 5000000 AND HIRE_DATE >= '01/01/01' AND BONUS IS NULL ;

--5. 보너스 포함 연봉이 NULL이 아니고 이름에 '하'가 포함되어 있는 사원들의 사번, 사원명, 급여, 보너스포함연봉 조회(별칭부여)
SELECT EMP_ID, EMP_NAME, SALARY,  (SALARY+BONUS*SALARY)*12 "보너스포함 연봉"
FROM EMPLOYEE
WHERE (SALARY+BONUS*SALARY)*12 IS NOT NULL AND EMP_NAME LIKE '%하%';


















