-- 한줄주석 : ctrl + /

/*여러줄 주석 alt + shift + c */ 

-- 커서 놓은 곳 에서 ctrl + enter : 그 줄 실행
-- 나의 계정보기
show user;

-- 사용자 계정조회
select * from DBA_USERS;

-- 계정 만들기
-- [예] create user 사용자명 identified by 비밀번호;
-- 오라클 12번전 부터 일반사용자는 c##을 붙여서 이름을 작명해야한다.
-- create user user1 identified by 1234; 
create user c##user6 identified by "1234";

-- 사용자 이름에 c## 붙이는것을 회피하는 방법 (껏다킬때마다 해줘야함)
alter session set "_oracle_script" = true;

create user user7 identified by "1234";

--사용자 이름은 대소문자 가리지 않는다

--꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 
--실제 사용할 계정 생성
create user aie identified by aie;

--권한생성
--[예] grant 권한명1, 권한2, .... to 계정명;
grant resource, connect to aie;

--테이블스페이스에 얼마만큼의 영역을 할당할 것인지를 부여
alter user aie default tablespace users quota unlimited on users;
--꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 꼭 해줘야함 


--테이블스페이스의 영역을 특정 용량만큼 할당하려면
alter user user2 quota 30M on users;  --잘 사용하지 않음



--user 삭제
--[예] drop user 사용자명; => 테이블이 없는 상태
--     테이블이 있다면 drop user 사용자명 cascade;  => 테이블까지 삭제
drop user user7;
drop user c##user6;






-- WORKBOOK 사용자 계정 만들기
alter session set "_oracle_script" = true;
create user workbook identified by workbook;
grant resource, connect to workbook;
alter user workbook default tablespace users quota unlimited on users;


-- DDL 사용자 계정 만들기
alter session set "_oracle_script" = true; --C## 없애주는거
create user DDL identified by DDL; --대소문자 안가림
grant resource, connect to DDL;
alter user DDL default tablespace users quota unlimited on users;













