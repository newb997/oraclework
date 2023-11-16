/*
    DDL : 데이터 정의어
    오라클에서 제공하는 객체를 만들고(CREATE), 구조를 변경하고(ALTER)하고, 구조를 삭제(DROP)하는 언어
    즉, 실제 데이터 값이 아닌 구조 자체를 정의하는 언어
    주로 DB관리자, 설계자가 사용함
    
    오라클 객체 : 테이블(TABLE), 뷰(VIEW), 시퀀스(SEQUENCE), 인덱스(INDEX), 패키지(PACKAGE), 
                        트리거(TRIGGER), 프로시저(PROCEDURE), 함수(FUNCTION), 동의어(SYNONYM), 사용자(USER)
*/

--============================================================================================================================================

/*
    <CREATE>
    객체를 생성하는 구문
*/
----------------------------------------------------------------------------------------------------------------------------------------------
/*
    1. 테이블 생성
        - 테이블 : 행(ROW)와 열(COLUMN)로 구성되는 가장 기본적인 데이터베이스 객체
                       모든 데이터들은 테이블을 통해 저장됨
                       (DBMS용어 중 하나로, 데이터를 일종의 표 형태로 표현한 것)
        
        [표현법]
        CREATE TABLE 테이블명(
                컬럼명 자료형(크기),  <--- (문자일경우 크기)
                컬럼명 자료형(크기),
                컬럼명 자료형,
                .....
         );
         *자료형
            - 문자 ( CHAR( 바이트 크기 ) | VARCHAR2( 바이트 크기 ))  =>  반드시 크기를 지정을 해야함
                >> CHAR : 최대 2000byte까지 지정할 수 있음.
                                고정길이( 지정한 크기보다 더 적은값이 들어와도 공백으로라도 채워서 처음 지정한 크기만큼 고정) --> 10byte로 지정하고 5byte만 넣어도 10byte를 차지함
                                고정된 데이터를 넣을 때 사용
                >> VARCHAR2 : 최대 4000byte까지 지정 가능
                                         가변길이( 담긴 값에 따라 공간의 크기가 맞춰짐 )
                                         몇글자가 들어올지 모를경우 사용
           - 숫자 ( NUMBER )
           - 날짜( DATE )
*/
--회원 테이블 MEMBER생성
CREATE TABLE MEMBER( 
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PW VARCHAR2(20),
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

SELECT * FROM MEMBER;



----------------------------------------------------------------------------------------------------------------------------------------------
/*
    2. 컬럼에 주석달기(컬럼에 대한 설명)
    
    [표현법]
    COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
    
    >> 잘못 작성했다면 수정 후 다시 실행하면됨
*/
COMMENT ON COLUMN MEMBER.MEM_NO IS '회원번호';
COMMENT ON COLUMN MEMBER.MEM_ID IS '회원아이디';
COMMENT ON COLUMN MEMBER.MEM_PW IS '회원비밀번호';
COMMENT ON COLUMN MEMBER.MEM_NAME IS '회원이름';
COMMENT ON COLUMN MEMBER.GENDER IS '성별';
COMMENT ON COLUMN MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN MEMBER.MEM_DATE IS '회원가입일';

--테이블에 데이터 추가하기
--INSERT INTO 테이블명 VALUES();
INSERT INTO MEMBER VALUES(1,'user01', '1234', '김나영', '여', '010-1234-5678', 'kim@naver.com', '23/11/16');
INSERT INTO MEMBER VALUES(2,'user02', '1234', '박길남', '남', null, NULL, SYSDATE);
INSERT INTO MEMBER VALUES(NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    <제약조건 CONTRAINTS>
    - 원하는 데이터값(유효한 형식의 값)만 유지하기 위해 특정 컬럼에 설정하는 제약
    - 데이터 무결성 보장을 목적으로 한다
        : 데이터에 결함이 없는 상태, 즉 데이터가 정확하고 유효하게 유지된 상태
            1. 객체 무결성 제약 조건 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY 조건 위배
            2. 참조 무결성 제약 조건 : FOREIGN KEY(외래키) 조건 위배

    * 종류 : NOT NULL, UNIQUE, CHECK(조건), PRIMARY KEY, FOREIGN KEY(외래키)
*/

/*
    * NOT NULL 제약조건
      해당컬럼에 반드시 값이 존재해야만 할 경우(즉, 컬럼에 절대 NULL이 들어오면 안되는 경우)
      삽입 / 수정시 NULL값을 허용하지 않도록 제한
      
      제약조건의 부여 방식은 크게 2가지로 나눔(컬럼 레벨 방식 | 테이블 레벨 방식)
        - NOT NULL제약조건은 오로지 컬럼 레벨 방식 밖에 안됨
*/
-- 컬럼 레벨 방식 : 컬럼명 자료형 옆에 제약조건을 넣어줌
CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE
);

INSERT INTO MEM_NOTNULL VALUES(1, 'user01', '1234', '김나영','여','010-1234-5678', 'kim@naver.com', '23/11/16');
INSERT INTO MEM_NOTNULL VALUES(2, 'user02', NULL , '박길남', '남', null, NULL, SYSDATE);
-- NOT NULL 제약조건에 위배되는 오류 발생

INSERT INTO MEM_NOTNULL VALUES(2, 'user01','pass01','이영순','여', null, null, sysdate);
INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','이영순','여', null, null, sysdate);

--------------------------------------------------------------------------------------------------------------
/*
    * UNIQUE 제약 조건
       해당 컬럼에 중복된 값이 들어가면 안되는 경우
       컬럼값에 중복값 제한을 하는 제약조건
       삽입 / 수정 시 기존에 있는 데이터값이 중복되었을 때 오류 발생
*/
-- 컬럼 레벨 방식
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL UNIQUE,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50)
);

-- 테이블 레벨 방식 : 모든 컬럼들을 나열한 후 마지막기술 .   테이블 맨끝네 넣음
-- [표현법] : 
CREATE TABLE MEM_UNIQUE2 (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR2(50),
    UNIQUE (MEM_NO),
    UNIQUE (MEM_ID)
);
-- 테이블 방식에 2개의 제약조건을 아래와 같이 넣으면
/*
    UNIQUE (MEM_NO, MEM_ID)
     : MEM_NO 와 MEM_ID 의 조합한 결과값으로 중복을 체크함
     
     1, A     -> db에 데이터가 이렇게 들어 있을 때
     2, B
     3, C
     
     1, D   -> 새로운값 삽입시 삽입됨
*/

INSERT INTO MEM_UNIQUE VALUES(1, 'user01', 'pass01','김남길','남',null,null);
INSERT INTO MEM_UNIQUE VALUES(1, 'user02', 'pass02','김남이','남',null,null);

INSERT INTO MEM_UNIQUE2 VALUES(1, 'user01', 'pass01','김남길','남',null,null);
INSERT INTO MEM_UNIQUE2 VALUES(2, 'user01', 'pass02','김남이','남',null,null);


/*
    제약조건 부여시 제약조건명까지 부여할 수 있다.
    
    >> 컬럼 레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형() [CONSTRAINT 제약조건명] 제약조건,
        ...
    );
    
    >>테이블 레벨 방식
    CREATE TABLE 테이블명(
        컬럼명 자료형(),
        ....
        [CONSTRAINT 제약조건명] 제약조건(컬럼명)
    );
*/

CREATE TABLE MEM_UNIQUE3(
    MEM_NO NUMBER CONSTRAINT MEMNO_NN NOT NULL CONSTRAINT NOUNIQUE UNIQUE,
    MEM_ID VARCHAR2(20) NOT NULL CONSTRAINT IDUNIQUE UNIQUE,
    MEM_PW VARCHAR2(20) CONSTRAINT PW_NN NOT NULL,
    MEM_NAME VARCHAR2(20),
    GENDER CHAR(3),
    CONSTRAINT NAME_UNIQUE UNIQUE(MEM_NAME)  -- 테이블 레벨 방식
);

INSERT INTO MEM_UNIQUE3 VALUES(1, 'uid', 'upw', '김길동', null);
INSERT INTO MEM_UNIQUE3 VALUES(1, 'uid2', 'upw2', '김길', null); --바뀐 이름을 볼 수 있음

INSERT INTO MEM_UNIQUE3 VALUES(2, 'uid2', 'upw2', 'ㄱ', NULL);
INSERT INTO MEM_UNIQUE3 VALUES(3, 'uid3', 'upw2', '이임', 'M');
--성별 : 남, 여

----------------------------------------------------------------------------------------------------------------------------------------------
/*
    CHECK(조건식) 제약조건
    
*/
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL UNIQUE,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    --GENDER CHAR(3) CHECK(GENDER IN ( '남', '여' )),       --컬럼 레벨 방식  이거 주석처리하려면 위에  GENDER CHAR(3) 해줘야함 컬럼은 말들어줘야됨
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE,
    CHECK( GENDER IN( '남','여' ))        --테이블 레벨 방식
);

INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남', null, null, sysdate);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '이길동', 'F', NULL, NULL, SYSDATE);       --CHECK 제약조건 위배
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '이길동', '여', NULL, NULL, SYSDATE);
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    PRIMARY KEY(기본키) 제약조건
    테이블에서 각 행동을 식별하기 이해 사용될 컬럼에 부여하는 제약조건(식별자 역할)
    
    EX) 회원번호, 학번, 사번, 예약번호, 운송장번호...
    
    PRIMARY KEY 제약조건을 부여하면 그 컬럼에 자동으로 NOT NULL + UNIQUE 제약조건을 의미
    >> 대체적으로 검색, 수정, 삭제 등에서 기본키의 컬럼값을 이용함
    
    --한 테이블당 오로지 한개만 설정가능
*/
CREATE TABLE MEM_PRIMARY (
    MEM_NO NUMBER PRIMARY KEY ,  --컬럼 레벨 방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE,
    CHECK( GENDER IN( '남','여' )) 
   -- PRIMARY KEY(MEM_NO)         --테이블 레벨 방식 /  이름 넣어주려면 앞에 CONSTRAINT 해주고 넣으면됨
);

INSERT INTO MEM_PRIMARY VALUES(1, 'user01', '1234', '김나영','여','010-1234-5678', 'kim@naver.com', '23/11/16');
INSERT INTO MEM_PRIMARY VALUES(1, 'user02', '1234', '이나영','여','010-1234-0987', 'lee@naver.com', '23/11/16');


CREATE TABLE MEM_PRIMARY2 (
    MEM_NO NUMBER PRIMARY KEY ,  --컬럼 레벨 방식
    MEM_ID VARCHAR2(20) PRIMARY KEY ,  --PRIMARY KEY 한개만 가능(오류)
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE,
    CHECK( GENDER IN( '남','여' )) 
);


CREATE TABLE MEM_PRIMARY3 (
    MEM_NO NUMBER ,  
    MEM_ID VARCHAR2(20)  , 
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(13),
    EMAIL VARCHAR2(50),
    MEM_DATE DATE,
    CHECK( GENDER IN( '남','여' )) ,
    PRIMARY KEY( MEM_NO, MEM_ID )   -- 생성은 되는데 기본키 아니고 복합키임, 묶어서 PRIMARY KEY 제약조건(복합키)
   -- PRIMARY KEY( MEM_NO)
   -- PRIMARY KEY( MEM_ID)          --  이렇게 따로하면 오류남
);

INSERT INTO MEM_PRIMARY3 VALUES(1, 'uid', 'upw', '나길동', '남', null, null, sysdate);
INSERT INTO MEM_PRIMARY3 VALUES(2, 'uid', 'upw', '나길동', '남', null, null, sysdate);
INSERT INTO MEM_PRIMARY3 VALUES(1, 'uid2', 'upw', '나길동', '남', null, null, sysdate); -- 컬럼값 2개를 조합해서 유일해야함
INSERT INTO MEM_PRIMARY3 VALUES(1, null, 'upw', '나길동', '남', null, null, sysdate); --primary 키는 null일 수 없다.
--> 기본키는 각 컬럼에는 절대 NULL을 허용하지 않는다.

/*
    복합키 사용 예(어떤 사용자가 어떤 물품을 찜했는지 데이터를 보관할 때)
    1 A
    1 B
    1 C
    2 A
    2 B
    2 C
    2 B(부적합)
*/

----------------------------------------------------------------------------------------------------------------------------------------------
--회원등급을 저장하는 테이블(MEM_GRADE)
CREATE TABLE MEM_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);
INSERT INTO MEM_GRADE VALUES( 10, '일반회원');
INSERT INTO MEM_GRADE VALUES( 20, '우수회원');
INSERT INTO MEM_GRADE VALUES( 30, '특별회원');

--회원정보를 저장하는 테이블(MEM)
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR(20),
    MEM_DATE DATE,
    GRADE_ID NUMBER --회원등급을 보관할 컬럼
);
INSERT INTO MEM VALUES( 1, 'user01', 'pass01', '홍길동', '남', NULL, NULL, SYSDATE, NULL );
INSERT INTO MEM VALUES( 2, 'user02', 'pass02', '김길똥', '여', NULL, NULL, SYSDATE, 10 );
INSERT INTO MEM VALUES( 3, 'user03', 'pass03', '여길녀', '여', NULL, NULL, SYSDATE, 50 );
--유효한 회원등급 번호가 아님에도 입력이 되었음
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    FOREIGN KEY(외래키) 제약조건
    다른 테이블에 존재하는 값만 들어와야되는 특정 컬럼에 부여하는 제약조건
    --> 다른 테이블을 참조한다고 표현
    --> 주로 FOREIGN KEY 제약조건에 의해 테이블간의 관계가 형성됨
    
    >> 컬럼 레벨 방식
        - 컬럼명 자료형 REFERENCES 참조할테이블명( 참조할 컬럼명 )
        컬럼명 자료형 [ CONSTRAINT 제약조건명 ] REFERENCES 참조할테이블명 [( 참조할 컬럼명 )]
        
    >> 테이블 레벨 방식
        - FOREIGN KEY( 컬럼명 ) REFERENCES 참조할테이블명( 참조할 컬럼명 )
         [ CONSTRAINT 제약조건명 ] FOREIGN KEY( 컬럼명 ) REFERENCES 참조할테이블명[( 참조할 컬럼명 )]
         
    --> 참조할컬럼이 PRIMARY KEY이면 생략가능( 자동으로 PRIMARY KEY와 외래키를 연결 )
*/
CREATE TABLE MEM2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR(20),
    MEM_DATE DATE,
     GRADE_ID NUMBER,
   -- GRADE_ID NUMBER REFERENCES MEM_GRADE( GRADE_CODE )  --컬럼 레벨 방식
    FOREIGN KEY(  GRADE_ID ) REFERENCES MEM_GRADE( GRADE_CODE )        -- 테이블 레벨 방식
);
INSERT INTO MEM2 VALUES( 1, 'user01', 'pass01', '홍길동', '남', NULL, NULL, SYSDATE, NULL );
INSERT INTO MEM2 VALUES( 2, 'user02', 'pass02', '김길똥', '여', NULL, NULL, SYSDATE, 10 );
INSERT INTO MEM2 VALUES( 3, 'user03', 'pass03', '여길녀', '여', NULL, NULL, SYSDATE, 50 ); --50값이 없어서 오류

-- MEM_GRADE( 부모테이블 )   -|-------------------------<-  MEM2( 자식테이블 )
--> 이때 부모테이블에서 데이터값을 삭제할 경우 어떤 문제가 발생하나?
    -- 데이터 삭제 : DELETE FROM 테이블명 WHERE 조건;

--MEM_GRADE 테이블에서 10번등급 삭제
DELETE FROM MEM_GRADE WHERE GRADE_CODE = 10;
-- 오류 보고 -
--ORA-02292: 무결성 제약조건(DDL.SYS_C008408)이 위배되었습니다- 자식 레코드가 발견되었습니다
--자식테이블에서 10이라는 값을 사용하고 있기 때문에 삭제가 안됨

--MEM_GRADE 테이블에서 30번등급 삭제
DELETE FROM MEM_GRADE WHERE GRADE_CODE = 30;
--자식테이블에서 30이라는 값을 사용하고 있지 않기 때문에 삭제됨

--> 자식테이블에 이미 사용되고 있는 값이 있을 경우
--> 부모테이블로부터 무조건 삭제가 안되는 삭제제한 옵션이 걸려있음( DEFAULT값 )
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    자식테이블 생성시 외래키 제약조건 부여할 때 삭제옵션 지정가능
     - 삭제옵션 : 부모테이블의 데이터 삭제시 그 데이터를 사용하고 있는 자식테이블의 값을 어떻게 처리할지?
        - ON DELETE RESTRICTED( 기본값 ) : 삭제 제한 옵션으로 자식테이블에서 쓰이는 값은 부모테이블에서 삭제못함
        - ON DELETE SET NULL : 부모테이블에서 삭제시 자식테이블의 값은 NULL로 변경하고 부모테이블의 행 삭제
        - ON DELETE CASCADE : 부모테이블에서 삭제하면 자식테이블의 행도 삭제
*/
DROP TABLE MEM;
DROP TABLE MEM2;

CREATE TABLE MEM (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR(20),
    MEM_DATE DATE,
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE SET NULL
);
INSERT INTO MEM VALUES( 1, 'user01', 'pass01', '홍길동', '남', NULL, NULL, SYSDATE, NULL );
INSERT INTO MEM VALUES( 2, 'user02', 'pass02', '김길똥', '여', NULL, NULL, SYSDATE, 10 );
INSERT INTO MEM VALUES( 3, 'user03', 'pass03', '여길녀', '여', NULL, NULL, SYSDATE, 20 );
INSERT INTO MEM VALUES( 4, 'user04', 'pass04', '나길똥', '남', NULL, NULL, SYSDATE, 10 );

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
--자식테이블은 NULL이됨

CREATE TABLE MEM2 (
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN ('남', '여')),
    PHONE VARCHAR2(20),
    EMAIL VARCHAR(20),
    MEM_DATE DATE,
    GRADE_ID NUMBER REFERENCES MEM_GRADE ON DELETE CASCADE  --CASCADE 삭제하면 자식까지 싹 삭제
);
INSERT INTO MEM2 VALUES( 1, 'user01', 'pass01', '홍길동', '남', NULL, NULL, SYSDATE, NULL );
INSERT INTO MEM2 VALUES( 2, 'user02', 'pass02', '김길똥', '여', NULL, NULL, SYSDATE, 10 );
INSERT INTO MEM2 VALUES( 3, 'user03', 'pass03', '여길녀', '여', NULL, NULL, SYSDATE, 20 );
INSERT INTO MEM2 VALUES( 4, 'user04', 'pass04', '나길똥', '남', NULL, NULL, SYSDATE, 10 );

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 10;
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    <DEFAULT 기본값> : 제약조건 아님
    데이터 삽입시 데이터를 넣지 않을 경우 DEFAULT값으로 삽입되게 함
*/
CREATE TABLE MEMBER2(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PW VARCHAR2(20) NOT NULL,
    MEM_AGE NUMBER,
    HOBBY VARCHAR2(20) DEFAULT '없음',
    MEM_DATE DATE DEFAULT SYSDATE
);
INSERT INTO MEMBER2 VALUES(1, 'user01', 'p01', 24, '공부', '23/11/16');
INSERT INTO MEMBER2 VALUES(2, 'user02', 'p02', NULL, NULL, NULL);
INSERT INTO MEMBER2 VALUES(3, 'user03', 'p03', NULL, DEFAULT, DEFAULT);


--=========================================================================================================================================

--================================================================= aie 계정 ================================================================

/*
    <SUBQUERY를 이용한 테이블 생성>
    테이블 복사하는 개념
    
    [표현식]
    CREATE TABLE 테이블명
    AS 서브쿼리;
*/
--EMPLOYEE 테이블을 복제한 새로운 테이블 생성
CREATE TABLE EMPLOYEE_COPY
    AS SELECT * FROM EMPLOYEE;
-- 컬럼, 데이터값, 제약조건 같은 경우 NOT NULL만 복사됨
-- DEFAULT, COMMENT는 복사안됨


CREATE TABLE EMPLOYEE_COPY2
    AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
          FROM EMPLOYEE;

CREATE TABLE EMPLOYEE_COPY3
    AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS
          FROM EMPLOYEE
          WHERE 1 = 0;      --테이블의 구조만 복사하고자 할 때 쓰이는 구문 (데이터값이 필요 없을 때)

CREATE TABLE EMPLOYEE_COPY4
    AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS, SALARY * 12  -- 오류 컬럼의 별칭을 반드시 줘야한다
          FROM EMPLOYEE;
--서브쿼리 SELECT절에 산술식 또는 함수식이 기술된 경우 반드시 별칭을 부여해야함

CREATE TABLE EMPLOYEE_COPY4
    AS SELECT EMP_ID, EMP_NAME, SALARY, BONUS, SALARY * 12 연봉  
          FROM EMPLOYEE;
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    테이블을 다 생성한 후에 제약조건 추가
    ALTER TABLE 테이블명 변경할내용;
     - PRIMARY KEY: ALTER TABLE 테이블명 ADD RRIMARY KEY( 컬럼명 );
     - FOREIGN KEY : ALTER TABLE 테이블명 ADD FOREIGN KEY( 컬럼명 ) REFERENCES 참조할테이블명[( 참조할컬럼명 )];
     - UNIQUE       :    ALTER TABLE 테이블명 ADD UNIQUE( 컬러명 );
     - CHECK         :    ALTER TABLE 테이블명 ADD CHECK( 컬럼에 대한 조건식 );
     - NOT NULL   :    ALTER TABLE 테이블명 MODIFY 컬럼명 NOT NULL;
*/
--EMPLOYEE_COPY 테이블에 PRIAMRY KEY 제약조건 추가
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY( EMP_ID );


--EMPLOYEE 테이블에 DEPT_CODE에 외래키 제약조건 추가(부모테이블 DEPARTMENT)



















