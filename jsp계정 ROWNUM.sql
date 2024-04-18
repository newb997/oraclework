
-- 실행순서 : from - where - select - order


-- ROWNUM은 기준 1에서 데이터를 상대적인 번호로 검색해온다.
-- 기준 1번이 없어서 검색이 안됨
select * 
from (select * from board order by ref desc, pos)
where ROWNUM >= 11 AND ROWNUM <= 20;



-- ROWNUM을 출력하면서 서브쿼리 테이블의 모든 컬럼을 가져오려면 
-- 반드시 서브쿼리에 별칭을 부여하고 별칭. 해줌  
select ROWNUM, BT1. * 
from (select * from board order by ref desc, pos) BT1
where ROWNUM >= 1 AND ROWNUM <= 10;



-- 서브쿼리에 ROWNUM이 1부터 모두 들어있어야함
select * 
from (select ROWNUM AS  RNUM, BT1. * from (select * from board order by ref desc, pos) BT1)
where RNUM BETWEEN 11 AND 20;

-- ? 1
select * 
from (select ROWNUM AS  RNUM, BT1. * from (select * from board order by ref desc, pos) BT1)
where RNUM BETWEEN ? AND ?;


-- 이름에 동 들어간거 조회
select * 
from (select ROWNUM AS  RNUM, BT1. * from (select * from board order by ref desc, pos) BT1 where name like '%동%')
where RNUM BETWEEN 3 AND 7;


-- ?? 2
select * 
from (select ROWNUM AS  RNUM, BT1. * from (select * from board order by ref desc, pos) BT1 where " + keyField + " like ?)
where RNUM BETWEEN ? AND ?;










