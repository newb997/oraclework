/*
    <DCL : DATA CONTROL LANGUAGE>
    데이터 제어어
    계정에게 시스템 권한 또는 객체에 접근건한 부여( GRANT )하거나 회수( REVOKE )하는 구문
    
    >> 시스템권한    : DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
    >> 객체접근권한 : 특정 객체들을 조작할 수 있는 권한
*/

/*
    1. 시스템 권한의 종류
        - CERATE SESSION : 접속할 수 있는 권한
        - CREATE TABLE : 테이블을 생성할 수 있는 권한
        - CREATE VIEW : 뷰를 생성할 수 있는 권한
        - CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
        ....등 ㅈㄴ많음
*/

-- 1.1 SAMPLE / sample 계정 생성
alter session set "_oracle_script" = true;
create user sample identified by sample;
--접속권한이 없어 접속 못함

--1.2  접속을 위한 CREATE SESSION 권한 부여
GRANT CREATE SESSION TO SAMPLE;  --접속권한

--SAMPLE계정에서 테이블생성 불가 : 권한부여를 안해서( 접속권한만 줫음 ) 
CREATE TABLE TEST(
    ID VARCHAR2(30),
    NAME VARCHAR2(20)
);

--1.3 테이블을 생성할 수 있는 권한 CREATE TABLE 권한부여( 안해주면 테이블 생성 못함 )
GRANT CREATE TABLE TO SAMPLE;


-- 1.4 TABLESPACE 할당 : 안해주면 데이터 삽입 안됨
ALTER USER SAMPLE QUOTA 2M ON USERS;
----------------------------------------------------------------------------------------------------------------------------------------------

/*
    2. 객체 접근 권한
        특정 객체에 접근하여 조작할 수 있는 권한
        
        권한종류
        SELECT      TABLE, VIEW, SEQUENCE
        INSERT       TABLE, VIEW
        UPDATE     TABLE, VIEW
        DELETE      TABLE, VIEW
        ....
        
        [표현식]
        GRANT 권한종류 ON 특정객체 TO 계정명;
         - GRANT 권한종류 ON 권한을 가지고 있는 USER.특정객체 TO 권한을줄USER;
*/
-- 2.1 SAMPLE계정에게 AIE계정 EMPLOYEE테이블을 SELECT할 수 있는 권한부여
GRANT SELECT ON AIE.EMPLOYEE TO SAMPLE;

--2.2 SAMPLE계정에게 AIE계정의 DEPARTMENT 테이블에 INSERT할 수 있는 권한부여
GRANT INSERT ON AIE.DEPARTMENT TO SAMPLE;
GRANT SELECT ON AIE.DEPARTMENT TO SAMPLE;



-- 권한 회수
-- REVOKE 회수할권한 ON FROM 계정명;
REVOKE SELECT ON AIE.EMPLOYEE FROM SAMPLE;
REVOKE INSERT ON AIE.DEPARTMENT FROM SAMPLE;
REVOKE SELECT ON AIE.DEPARTMENT FROM SAMPLE;

-----------------------------------------------------------------------------------------
/*
    <ROLE 롤>
    - 특정 권한들을 하나의 집합으로 모아놓은 것
    
    CONNECT : CREATE, SESSION
    RESOURCE : CAEATE 객체, INSERT, UPDATE....
    DBA : 시스템 및 객 관리에 대한 모든 권한을 갖고 있는 롤
*/

ALTER SESSION set "_oracle_script" = true;
create user SAMPLE2 identified by SAMPLE2;
grant DBA to SAMPLE2;
alter user SAMPLE2 default TABLESPACE users quota UNLIMITED on users;

































































