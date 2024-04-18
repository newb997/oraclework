create table boardtest1(
    no number PRIMARY KEY,
    title varchar2(50),
    writer varchar2(100),
    content varchar2(500)     
);

create sequence boardtest1_seq;