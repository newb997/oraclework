--15. EMPLOYEE테이블에서 사원 명과 직원의 주민번호를 이용하여 생년, 생월, 생일 조회
SELECT EMP_NAME,
       SUBSTR(EMP_NO, 1, 2) AS 생년,
       SUBSTR(EMP_NO, 3, 2) AS 생월,
       SUBSTR(EMP_NO, 5, 2) AS 생일
FROM EMPLOYEE;


--16. EMPLOYEE테이블에서 사원명, 주민번호 조회
--	(단, 주민번호는 생년월일만 보이게 하고, '-'다음 값은 '*'로 바꾸기)
SELECT EMP_NAME,
       CONCAT(SUBSTR(EMP_NO, 1, 6), '******') AS MASKED_EMP_NO
FROM EMPLOYEE;


--17. EMPLOYEE테이블에서 사원명, 입사일-오늘, 오늘-입사일 조회
--   (단, 각 별칭은 근무일수1, 근무일수2가 되도록 하고 모두 정수(내림), 양수가 되도록 처리)
SELECT EMP_NAME, FLOOR(ABS(HIRE_DATE-SYSDATE)) 근무일수1,
                                    FLOOR(ABS(HIRE_DATE-SYSDATE)) 근무일수2
FROM EMPLOYEE;

--18. EMPLOYEE테이블에서 사번이 홀수인 직원들의 정보 모두 조회


--19. EMPLOYEE테이블에서 근무 년수가 20년 이상인 직원 정보 조회


--20. EMPLOYEE 테이블에서 사원명, 급여 조회 (단, 급여는 '\9,000,000' 형식으로 표시)


--21. EMPLOYEE테이블에서 직원 명, 부서코드, 생년월일, 나이 조회
--   (단, 생년월일은 주민번호에서 추출해서 00년 00월 00일로 출력되게 하며 
--   나이는 주민번호에서 출력해서 날짜데이터로 변환한 다음 계산)
SELECT EMP_NAME, 
               DEPT_CODE, 
               SUBSTR(EMP_NO,1,2) || '년 ' || SUBSTR(EMP_NO,3,2) || '월 ' || SUBSTR(EMP_NO,5,2) ||'일' 생년월일,
               EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM TO_DATE(SUBSTR(EMP_NO,1,2), 'RRRR')) 나이
FROM EMPLOYEE;

--23. EMPLOYEE테이블에서 사번이 201번인 사원명, 주민번호 앞자리, 주민번호 뒷자리, 
--    주민번호 앞자리와 뒷자리의 합 조회


--24. EMPLOYEE 테이블에서 부서코드가 D5인 직원의 보너스 포함 연봉 합 조회
SELECT SUM(SALARY*NVL(BONUS,0)+SALARY) "D5인 사원 보너스 포함 연봉 "
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

--25. 직원들의 입사일로부터 년도만 가지고 각 녀도별 입사 인원수 조회
--전체 직원수, 2001년, 2002년, 2003년, 2004년
SELECT COUNT(*) "전체직원수",
                COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), '2001', 1)) "2001년",
                COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), '2002', 1)) "2002년",
                COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), '2003', 1)) "2003년",
                COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), '2004', 1)) "2004년"
FROM EMPLOYEE;

--여러방법으로 해보기
SELECT COUNT(*) "전체직원수",
                COUNT(CASE WHEN EXTRACT(YEAR FROM HIRE_DATE) = '2001' THEN 1 END) "2001년",
                COUNT(CASE WHEN TO_CHAR(HIRE_DATE, 'YYYY') = '2002' THEN 1 END) "2002년",
                COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2003','1')) "2003년" ,
                COUNT(DECODE(EXTRACT(YEAR FROM HIRE_DATE), '2004', 1)) "2004년"
FROM EMPLOYEE;



--9. 학번이 A517178 인 한아름 학생의 학점 총 평점을 구하는 SQL 문을 작성하시오. 단, 
--이때 출력 화면의 헤더는 "평점" 이라고 찍히게 하고, 점수는 반올림하여 소수점 이하 한 
--자리까지만 표시한다. 


-- 10. 학과별 학생수를 구하여 "학과번호", "학생수(명)" 의 형태로 헤더를 만들어 결과값이 출력되도록 하시오. 


-- 11. 지도 교수를 배정받지 못한 학생의 수는 몇 명 정도 되는 알아내는 SQL 문을 작성하시오. 


-- 12. 학번이 A112113 인 김고운 학생의 년도 별 평점을 구하는 SQL 문을 작성하시오. 단, 이때 출력 화면의 헤더는 "년도", "년도 별 평점" 이라고 찍히게 하고, 점수는 반올림하여 
--소수점 이하 한 자리까지만 표시한다. 


-- 13학과 별 휴학생 수를 파악하고자 한다. 학과 번호와 휴학생 수를 표시하는 SQL 문장을 작성하시오. 


-- 14. 춘 대학교에 다니는 동명이인(同名異人) 학생들의 이름을 찾고자 한다. 어떤 SQL 문장을 사용하면 가능하겠는가? 







