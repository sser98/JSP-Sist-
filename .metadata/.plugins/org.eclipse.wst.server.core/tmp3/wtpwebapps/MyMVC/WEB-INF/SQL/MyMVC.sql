show user;
-- USER이(가) "SYS"입니다.

create user mymvc_user identified by cclass;
-- User MYMVC_USER이(가) 생성되었습니다.

grant connect, resource, create view, unlimited tablespace to mymvc_user;
-- Grant을(를) 성공했습니다.

show user;
-- USER이(가) "MYMVC_USER"입니다.


create table tbl_main_image
(imgno           number not null
,imgfilename     varchar2(100) not null
,constraint PK_tbl_main_image primary key(imgno)
);

create sequence seq_main_image
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '미샤.png');  
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '원더플레이스.png'); 
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '레노보.png'); 
insert into tbl_main_image(imgno, imgfilename) values(seq_main_image.nextval, '동원.png'); 

commit;

select imgno, imgfilename
from tbl_main_image 
order by imgno asc;


----- **** 회원 테이블 생성 **** ------
-- drop table tbl_member purge;
alter table tbl_member
modify userid varchar2(40);

create table tbl_member
(userid             varchar2(40)   not null  -- 회원아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,name               varchar2(30)   not null  -- 회원명
,email              varchar2(200)  not null  -- 이메일 (AES-256 암호화/복호화 대상)
,mobile             varchar2(200)            -- 연락처 (AES-256 암호화/복호화 대상) 
,postcode           varchar2(5)              -- 우편번호
,address            varchar2(200)            -- 주소
,detailaddress      varchar2(200)            -- 상세주소
,extraaddress       varchar2(200)            -- 참고항목
,gender             varchar2(1)              -- 성별   남자:1  / 여자:2
,birthday           varchar2(10)             -- 생년월일   
,coin               number default 0         -- 코인액
,point              number default 0         -- 포인트 
,registerday        date default sysdate     -- 가입일자 
,lastpwdchangedate  date default sysdate     -- 마지막으로 암호를 변경한 날짜  
,status             number(1) default 1 not null     -- 회원탈퇴유무   1: 사용가능(가입중) / 0:사용불능(탈퇴) 
,idle               number(1) default 0 not null     -- 휴면유무      0 : 활동중  /  1 : 휴면중 
,constraint PK_tbl_member_userid primary key(userid)
,constraint UQ_tbl_member_email  unique(email)
,constraint CK_tbl_member_gender check( gender in('1','2') )
,constraint CK_tbl_member_status check( status in(0,1) )
,constraint CK_tbl_member_idle check( idle in(0,1) )
);

select *
from tbl_member
order by registerday desc;

delete from tbl_member
where userid = 'hongkd';

select userid 
from tbl_member
where userid = 'leess';

select userid 
from tbl_member
where userid = 'sfdsfdf';

delete from tbl_member;
commit;

delete from tbl_member where userid = 'hanmailrg@naver.com';
commit;

select *
from tbl_member;

---------------------------------------------------------------------
alter table tbl_loginhistory
modify fk_userid   varchar2(40);

create table tbl_loginhistory
(fk_userid   varchar2(40) not null 
,logindate   date default sysdate not null
,clientip    varchar2(20) not null
,constraint FK_tbl_loginhistory foreign key(fk_userid) 
                                references tbl_member(userid)  
);


select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
     , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd
     , coin, point, to_char(registerday, 'yyyy-mm-dd') AS registerday
     , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap
from tbl_member
where status = 1 and  userid = 'eomjh' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382';


select *
from tbl_loginhistory;


select *
from tbl_member;

--- 암호를 변경한지 3개월이 초과한 경우 
--- 로그인시 "비밀번호를 변경하신지 3개월이 지났습니다. 암호를 변경하세요!!" 라는 alert 를 띄우기 위해 아래와 같이 한다.
update tbl_member set registerday = add_months(registerday, -4)
                    , lastpwdchangedate = add_months(lastpwdchangedate, -4)
where userid = 'eomjh';

commit;


--- 마지막으로 로그인을 한지 12개월이 초과한 경우 또는 회원을 가입하고서 로그인을 하지 않은지가 12개월이 초과한 경우
--- 로그인시 "로그인을 한지 1년이 지나서 휴면상태로 되었습니다. 관리자에게 문의 바랍니다." 라는 alert 를 띄우기 위해 아래와 같이 한다.
update tbl_member set registerday = add_months(registerday, -13)
                    , lastpwdchangedate = add_months(lastpwdchangedate, -13)
where userid = 'kangkc';


update tbl_loginhistory set logindate = add_months(logindate, -13)
where fk_userid = 'kangkc';


update tbl_member set registerday = add_months(registerday, -14)
                    , lastpwdchangedate = add_months(lastpwdchangedate, -14)
where userid = 'youks';


commit;


select *
from tbl_member;

select *
from tbl_loginhistory;


select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap
from tbl_loginhistory
where fk_userid = 'leess';


select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap
from tbl_loginhistory
where fk_userid = 'kangkc';



--- 회원가입만하고서 로그인을 하지 않은 경우에는 tbl_loginhistory 테이블에 insert 되어진 정보가 없으므로 
--- 마지막으로 로그인한 날짜를 회원가입한 날짜로 보도록 한다.
SELECT userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender,
       birthyyyy, birthmm, birthdd, coin, point, registerday, pwdchangegap, 
       nvl(lastlogingap, trunc( months_between(sysdate, registerday) ) ) AS lastlogingap
FROM 
(
select userid, name, email, mobile, postcode, address, detailaddress, extraaddress, gender
     , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd
     , coin, point, to_char(registerday, 'yyyy-mm-dd') AS registerday
     , trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap
from tbl_member
where status = 1 and  userid = 'youks' and pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
) M 
CROSS JOIN 
(
select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap
from tbl_loginhistory
where fk_userid = 'youks'
) H;


update tbl_member set coin = coin + '300000'
where userid = 'seoyh';

select * 
from tbl_member;

desc tbl_member;

rollback;

-----------------------------------------------------------------------------------------------------------------------------
--- 오라클에서 프로시저를 사용하여 회원을 대량으로 입력(insert)하겠습니다. ---
select * 
from user_constraints
where table_name = 'TBL_MEMBER';

alter table tbl_member
drop constraint UQ_TBL_MEMBER_EMAIL;  -- 이메일을 대량으로 넣기 위해서 어쩔수 없이 email 에 대한 unique 제약을 없애도록 한다. 

select * 
from user_constraints
where table_name = 'TBL_MEMBER';

select *
from user_indexes
where table_name = 'TBL_MEMBER';

drop index UQ_TBL_MEMBER_EMAIL;

select *
from user_indexes
where table_name = 'TBL_MEMBER';

delete from tbl_member 
where name like '홍승의%' or name like '아이유%';

commit;

create or replace procedure pcd_member_insert 
(p_userid  IN  varchar2
,p_name    IN  varchar2
,p_gender  IN  char)
is
begin
     for i in 1..100 loop
         insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, extraaddress, gender, birthday) 
         values(p_userid||i, '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382', p_name||i, 'qz9Aean3wHLs+KzuI626bqHQ5FnIzAWRGn0iu1obVyQ=' , 'c5TbkMv3Bk7viPixbC8fwA==', '15864', '경기 군포시 오금로 15-17', '102동 9004호', ' (금정동)', p_gender, '1991-01-27');
     end loop;
end pcd_member_insert;
-- Procedure PCD_MEMBER_INSERT이(가) 컴파일되었습니다.


exec pcd_member_insert('hongse','홍승의','1');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;

exec pcd_member_insert('iyou','아이유','2');
-- PL/SQL 프로시저가 성공적으로 완료되었습니다.
commit;


---- ==== 페이징 처리를 위한 SQL 문 작성하기 ==== ----
select rownum, userid, name, email, gender 
from tbl_member
where userid != 'admin'
and rownum between 4 and 6;


select rno, userid, name, email, gender
from 
(
    select rownum AS rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender 
        from tbl_member
        where userid != 'admin' 
        order by registerday desc
    ) V
) T 
where rno between 1 and 3;  -- 1 페이지 (한페이지당 3개를 보여줄때)
/*
    currentShowPageNo ==> 1 
    sizePerPage       ==> 3 
    
    (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ==> 1
                     1 * 3            - (3 - 1)           ==> 1
    (currentShowPageNo * sizePerPage) ==> 3
                     1 * 3            ==> 3
*/


select rno, userid, name, email, gender
from 
(
    select rownum AS rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender 
        from tbl_member
        where userid != 'admin' 
        order by registerday desc
    ) V
) T 
where rno between 4 and 6;  -- 2 페이지 (한페이지당 3개를 보여줄때)
/*
    currentShowPageNo ==> 2 
    sizePerPage       ==> 3 
    
    (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ==> 4
                     2 * 3            - (3 - 1)           ==> 4
    (currentShowPageNo * sizePerPage) ==> 6
                     2 * 3            ==> 6
*/


select rno, userid, name, email, gender
from 
(
    select rownum AS rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender 
        from tbl_member
        where userid != 'admin' 
        order by registerday desc
    ) V
) T 
where rno between 7 and 9;  -- 3 페이지 (한페이지당 3개를 보여줄때)
/*
    currentShowPageNo ==> 3 
    sizePerPage       ==> 3 
    
    (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ==> 7
                     3 * 3            - (3 - 1)           ==> 7
    (currentShowPageNo * sizePerPage) ==> 9
                     3 * 3            ==> 9
*/

--- *** 검색어가 있는 경우 *** ---
select rno, userid, name, email, gender
from 
(
    select rownum AS rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender 
        from tbl_member
        where userid != 'admin' 
        and name like '%'|| '승의' ||'%'
        order by registerday desc
    ) V
) T 
where rno between 1 and 3;  -- 1 페이지 (한페이지당 3개를 보여줄때)
/*
    currentShowPageNo ==> 1 
    sizePerPage       ==> 3 
    
    (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ==> 1
                     1 * 3            - (3 - 1)           ==> 1
    (currentShowPageNo * sizePerPage) ==> 3
                     1 * 3            ==> 3
*/


select rno, userid, name, email, gender
from 
(
    select rownum AS rno, userid, name, email, gender
    from 
    (
        select userid, name, email, gender 
        from tbl_member
        where userid != 'admin' 
        and name like '%'|| '승의' ||'%'
        order by registerday desc
    ) V
) T 
where rno between 4 and 6;  -- 2 페이지 (한페이지당 3개를 보여줄때)
/*
    currentShowPageNo ==> 2 
    sizePerPage       ==> 3 
    
    (currentShowPageNo * sizePerPage) - (sizePerPage - 1) ==> 4
                     2 * 3            - (3 - 1)           ==> 4
    (currentShowPageNo * sizePerPage) ==> 6
                     2 * 3            ==> 6
*/

-------------------------------------------------------------------
--- 검색이 있는 총회원수 또는 검색이 없는 총회원수를 알아오기 위한 것
select ceil( count(*)/'10') 
from tbl_member
where userid != 'admin' 
and name like '%'||'홍승의'||'%';

select ceil( count(*)/'10'),  ceil( count(*)/'5'), ceil( count(*)/'3')
from tbl_member
where userid != 'admin'; 

------------------------------------------------------------------------
delete from tbl_member 
where userid = 'hongse17';

commit;
        
--------------------------------------------------------------------
/*
   카테고리 테이블명 : tbl_category 

   컬럼정의 
     -- 카테고리 대분류 번호  : 시퀀스(seq_category_cnum)로 증가함.(Primary Key)
     -- 카테고리 코드(unique) : ex) 전자제품  '100000'
                                  의류      '200000'
                                  도서      '300000' 
     -- 카테고리명(not null)  : 전자제품, 의류, 도서           
  
*/ 
-- drop table tbl_category purge; 
create table tbl_category
(cnum    number(8)     not null  -- 카테고리 대분류 번호
,code    varchar2(20)  not null  -- 카테고리 코드
,cname   varchar2(100) not null  -- 카테고리명
,constraint PK_tbl_category_cnum primary key(cnum)
,constraint UQ_tbl_category_code unique(code)
);

-- drop sequence seq_category_cnum;
create sequence seq_category_cnum 
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '100000', '전자제품');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '200000', '의류');
insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '300000', '도서');
commit;

-- 나중에 넣습니다.
--insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '400000', '식품');
--commit;

-- insert into tbl_category(cnum, code, cname) values(seq_category_cnum.nextval, '500000', '신발');
-- commit;

/*
delete from tbl_category
where code = '500000';

commit;
*/

select cnum, code, cname
from tbl_category
order by cnum asc;

-- drop table tbl_spec purge;
create table tbl_spec
(snum    number(8)     not null  -- 스펙번호       
,sname   varchar2(100) not null  -- 스펙명         
,constraint PK_tbl_spec_snum primary key(snum)
,constraint UQ_tbl_spec_sname unique(sname)
);

-- drop sequence seq_spec_snum;
create sequence seq_spec_snum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

insert into tbl_spec(snum, sname) values(seq_spec_snum.nextval, 'HIT');
insert into tbl_spec(snum, sname) values(seq_spec_snum.nextval, 'NEW');
insert into tbl_spec(snum, sname) values(seq_spec_snum.nextval, 'BEST');

commit;

select snum, sname
from tbl_spec
order by snum asc;


---- *** 제품 테이블 : tbl_product *** ----
-- drop table tbl_product purge; 
create table tbl_product
(pnum           number(8) not null       -- 제품번호(Primary Key)
,pname          varchar2(100) not null   -- 제품명
,fk_cnum        number(8)                -- 카테고리코드(Foreign Key)의 시퀀스번호 참조
,pcompany       varchar2(50)             -- 제조회사명
,pimage1        varchar2(100) default 'noimage.png' -- 제품이미지1   이미지파일명
,pimage2        varchar2(100) default 'noimage.png' -- 제품이미지2   이미지파일명 
,pqty           number(8) default 0      -- 제품 재고량
,price          number(8) default 0      -- 제품 정가
,saleprice      number(8) default 0      -- 제품 판매가(할인해서 팔 것이므로)
,fk_snum        number(8)                -- 'HIT', 'NEW', 'BEST' 에 대한 스펙번호인 시퀀스번호를 참조
,pcontent       varchar2(4000)           -- 제품설명  varchar2는 varchar2(4000) 최대값이므로
                                         --          4000 byte 를 초과하는 경우 clob 를 사용한다.
                                         --          clob 는 최대 4GB 까지 지원한다.
                                         
,point          number(8) default 0      -- 포인트 점수                                         
,pinputdate     date default sysdate     -- 제품입고일자
,constraint  PK_tbl_product_pnum primary key(pnum)
,constraint  FK_tbl_product_fk_cnum foreign key(fk_cnum) references tbl_category(cnum)
,constraint  FK_tbl_product_fk_snum foreign key(fk_snum) references tbl_spec(snum)
);

-- drop sequence seq_tbl_product_pnum;
create sequence seq_tbl_product_pnum
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 아래는 fk_snum 컬럼의 값이 1 인 'HIT' 상품만 입력한 것임. 
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '스마트TV', 1, '삼성', 'tv_samsung_h450_1.png','tv_samsung_h450_2.png', 100,1200000,800000, 1,'42인치 스마트 TV. 기능 짱!!', 50);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북', 1, '엘지', 'notebook_lg_gt50k_1.png','notebook_lg_gt50k_2.png', 150,900000,750000, 1,'노트북. 기능 짱!!', 30);  

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '바지', 2, 'S사', 'cloth_canmart_1.png','cloth_canmart_2.png', 20,12000,10000, 1,'예뻐요!!', 5);       

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '남방', 2, '버카루', 'cloth_buckaroo_1.png','cloth_buckaroo_2.png', 50,15000,13000, 1,'멋져요!!', 10);       
       
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '세계탐험보물찾기시리즈', 3, '아이세움', 'book_bomul_1.png','book_bomul_2.png', 100,35000,33000, 1,'만화로 보는 세계여행', 20);       
       
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '만화한국사', 3, '녹색지팡이', 'book_koreahistory_1.png','book_koreahistory_2.png', 80,130000,120000, 1,'만화로 보는 이야기 한국사 전집', 60);
       
commit;


-- 아래는 fk_cnum 컬럼의 값이 1 인 '전자제품' 중 fk_snum 컬럼의 값이 1 인 'HIT' 상품만 입력한 것임. 
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북1', 1, 'DELL', '1.jpg','2.jpg', 100,1200000,1000000,1,'1번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북2', 1, '에이서','3.jpg','4.jpg',100,1200000,1000000,1,'2번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북3', 1, 'LG전자','5.jpg','6.jpg',100,1200000,1000000,1,'3번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북4', 1, '레노버','7.jpg','8.jpg',100,1200000,1000000,1,'4번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북5', 1, '삼성전자','9.jpg','10.jpg',100,1200000,1000000,1,'5번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북6', 1, 'HP','11.jpg','12.jpg',100,1200000,1000000,1,'6번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북7', 1, '레노버','13.jpg','14.jpg',100,1200000,1000000,1,'7번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북8', 1, 'LG전자','15.jpg','16.jpg',100,1200000,1000000,1,'8번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북9', 1, '한성컴퓨터','17.jpg','18.jpg',100,1200000,1000000,1,'9번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북10', 1, 'MSI','19.jpg','20.jpg',100,1200000,1000000,1,'10번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북11', 1, 'LG전자','21.jpg','22.jpg',100,1200000,1000000,1,'11번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북12', 1, 'HP','23.jpg','24.jpg',100,1200000,1000000,1,'12번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북13', 1, '레노버','25.jpg','26.jpg',100,1200000,1000000,1,'13번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북14', 1, '레노버','27.jpg','28.jpg',100,1200000,1000000,1,'14번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북15', 1, '한성컴퓨터','29.jpg','30.jpg',100,1200000,1000000,1,'15번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북16', 1, '한성컴퓨터','31.jpg','32.jpg',100,1200000,1000000,1,'16번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북17', 1, '레노버','33.jpg','34.jpg',100,1200000,1000000,1,'17번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북18', 1, '레노버','35.jpg','36.jpg',100,1200000,1000000,1,'18번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북19', 1, 'LG전자','37.jpg','38.jpg',100,1200000,1000000,1,'19번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북20', 1, 'LG전자','39.jpg','40.jpg',100,1200000,1000000,1,'20번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북21', 1, '한성컴퓨터','41.jpg','42.jpg',100,1200000,1000000,1,'21번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북22', 1, '에이서','43.jpg','44.jpg',100,1200000,1000000,1,'22번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북23', 1, 'DELL','45.jpg','46.jpg',100,1200000,1000000,1,'23번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북24', 1, '한성컴퓨터','47.jpg','48.jpg',100,1200000,1000000,1,'24번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북25', 1, '삼성전자','49.jpg','50.jpg',100,1200000,1000000,1,'25번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북26', 1, 'MSI','51.jpg','52.jpg',100,1200000,1000000,1,'26번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북27', 1, '애플','53.jpg','54.jpg',100,1200000,1000000,1,'27번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북28', 1, '아수스','55.jpg','56.jpg',100,1200000,1000000,1,'28번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북29', 1, '레노버','57.jpg','58.jpg',100,1200000,1000000,1,'29번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북30', 1, '삼성전자','59.jpg','60.jpg',100,1200000,1000000,1,'30번 노트북', 60);

commit;


-- 아래는 fk_cnum 컬럼의 값이 1 인 '전자제품' 중 fk_snum 컬럼의 값이 2 인 'NEW' 상품만 입력한 것임. 
insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북31', 1, 'MSI','61.jpg','62.jpg',100,1200000,1000000,2,'31번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북32', 1, '삼성전자','63.jpg','64.jpg',100,1200000,1000000,2,'32번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북33', 1, '한성컴퓨터','65.jpg','66.jpg',100,1200000,1000000,2,'33번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북34', 1, 'HP','67.jpg','68.jpg',100,1200000,1000000,2,'34번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북35', 1, 'LG전자','69.jpg','70.jpg',100,1200000,1000000,2,'35번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북36', 1, '한성컴퓨터','71.jpg','72.jpg',100,1200000,1000000,2,'36번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북37', 1, '삼성전자','73.jpg','74.jpg',100,1200000,1000000,2,'37번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북38', 1, '레노버','75.jpg','76.jpg',100,1200000,1000000,2,'38번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북39', 1, 'MSI','77.jpg','78.jpg',100,1200000,1000000,2,'39번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북40', 1, '레노버','79.jpg','80.jpg',100,1200000,1000000,2,'40번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북41', 1, '레노버','81.jpg','82.jpg',100,1200000,1000000,2,'41번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북42', 1, '레노버','83.jpg','84.jpg',100,1200000,1000000,2,'42번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북43', 1, 'MSI','85.jpg','86.jpg',100,1200000,1000000,2,'43번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북44', 1, '한성컴퓨터','87.jpg','88.jpg',100,1200000,1000000,2,'44번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북45', 1, '애플','89.jpg','90.jpg',100,1200000,1000000,2,'45번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북46', 1, '아수스','91.jpg','92.jpg',100,1200000,1000000,2,'46번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북47', 1, '삼성전자','93.jpg','94.jpg',100,1200000,1000000,2,'47번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북48', 1, 'LG전자','95.jpg','96.jpg',100,1200000,1000000,2,'48번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북49', 1, '한성컴퓨터','97.jpg','98.jpg',100,1200000,1000000,2,'49번 노트북', 60);

insert into tbl_product(pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point)
values(seq_tbl_product_pnum.nextval, '노트북50', 1, '레노버','99.jpg','100.jpg',100,1200000,1000000,2,'50번 노트북', 60);

commit;        

-----------------------------------------------------------------------------------------------------------------------        
--- HIT 상품의 전체개수를 알아온다.
select count(*)
from tbl_product
where fk_snum = '1';  -- 36 

select count(*)
from tbl_product
where fk_snum = (select snum from tbl_spec where sname = 'HIT');  -- 36





select cnum, code, cname
from tbl_category
order by cnum asc;


select snum, sname
from tbl_spec
order by snum asc;

select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate
from 
(
 select row_number() over(order by pnum asc) AS RNO 
      , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point  
      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate 
 from tbl_product P 
 JOIN tbl_category C 
 ON P.fk_cnum = C.cnum 
 JOIN tbl_spec S 
 ON P.fk_snum = S.snum
 where S.sname = 'HIT'
) V
where RNO between 1 and 8;


select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate
from 
(
 select row_number() over(order by pnum asc) AS RNO 
      , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point  
      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate 
 from tbl_product P 
 JOIN tbl_category C 
 ON P.fk_cnum = C.cnum 
 JOIN tbl_spec S 
 ON P.fk_snum = S.snum
 where S.sname = 'HIT'
) V
where RNO between 9 and 16;


select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate
from 
(
 select row_number() over(order by pnum asc) AS RNO 
      , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point  
      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate 
 from tbl_product P 
 JOIN tbl_category C 
 ON P.fk_cnum = C.cnum 
 JOIN tbl_spec S 
 ON P.fk_snum = S.snum
 where S.sname = 'HIT'
) V
where RNO between 17 and 24;     


select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate
from 
(
 select row_number() over(order by pnum asc) AS RNO 
      , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point  
      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate 
 from tbl_product P 
 JOIN tbl_category C 
 ON P.fk_cnum = C.cnum 
 JOIN tbl_spec S 
 ON P.fk_snum = S.snum
 where S.sname = 'HIT'
) V
where RNO between 25 and 32;


select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate
from 
(
 select row_number() over(order by pnum asc) AS RNO 
      , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point  
      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate 
 from tbl_product P 
 JOIN tbl_category C 
 ON P.fk_cnum = C.cnum 
 JOIN tbl_spec S 
 ON P.fk_snum = S.snum
 where S.sname = 'HIT'
) V
where RNO between 33 and 40;


select pnum, pname, code, pcompany, pimage1, pimage2, pqty, price, saleprice, sname, pcontent, point, pinputdate
from 
(
 select row_number() over(order by pnum asc) AS RNO 
      , pnum, pname, C.code, pcompany, pimage1, pimage2, pqty, price, saleprice, S.sname, pcontent, point  
      , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate 
 from tbl_product P 
 JOIN tbl_category C 
 ON P.fk_cnum = C.cnum 
 JOIN tbl_spec S 
 ON P.fk_snum = S.snum
 where S.sname = 'HIT'
) V
where RNO between 41 and 48;
        
        
----- >>> 하나의 제품속에 여러개의 이미지 파일 넣어주기 <<< ------ 
select *
from tbl_product
order by pnum;  

create table tbl_product_imagefile
(imgfileno     number         not null   -- 시퀀스로 입력받음.
,fk_pnum       number(8)      not null   -- 제품번호(foreign key)
,imgfilename   varchar2(100)  not null   -- 제품이미지파일명
,constraint PK_tbl_product_imagefile primary key(imgfileno)
,constraint FK_tbl_product_imagefile foreign key(fk_pnum) references tbl_product(pnum)
);


create sequence seqImgfileno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select imgfileno, fk_pnum, imgfilename
from tbl_product_imagefile
order by imgfileno desc;


select C.cname, pnum, pname, fk_cnum, pcompany, pimage1, pimage2, pqty, price, saleprice, fk_snum, pcontent, point 
	 , to_char(pinputdate, 'yyyy-mm-dd') as pinputdate
from tbl_category C left join tbl_product P  
on C.cnum = P.fk_cnum  
where C.code = '400000' 
order by pnum desc;        
        

select *
from tbl_product
order by pnum desc;

select seq_tbl_product_pnum.nextval
from dual; -- 제품번호 채번해오기

commit;


-------- **** 상품구매 후기 테이블 생성하기 **** ----------
create table tbl_purchase_reviews
(review_seq          number 
,fk_userid           varchar2(20)   not null   -- 사용자ID       
,fk_pnum             number(8)      not null   -- 제품번호(foreign key)
,contents            varchar2(4000) not null
,writeDate           date default sysdate
,constraint PK_purchase_reviews primary key(review_seq)
,constraint FK_purchase_reviews_userid foreign key(fk_userid) references tbl_member(userid)
,constraint FK_purchase_reviews_pnum foreign key(fk_pnum) references tbl_product(pnum)
);

create sequence seq_purchase_reviews
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_purchase_reviews
order by review_seq desc;


select review_seq, name, fk_pnum, contents, to_char(writeDate, 'yyyy-mm-dd hh24:mi:ss') AS writeDate
from tbl_purchase_reviews R join tbl_member M
on R.fk_userid = M.userid 
where R.fk_pnum = 3
order by review_seq desc; 


drop table tbl_purchase_like;
create table tbl_purchase_like
(
fk_userid         varchar2(40)   not null   -- 사용자ID       
,fk_pnum             number(8)      not null   -- 제품번호(foreign key)
,constraint PK_purchase_like primary key (fk_userid, fk_pnum)
,constraint FK_purchase_like_pnum foreign key(fk_pnum) references tbl_product(pnum)
);

drop table tbl_purchase_dislike;
create table tbl_purchase_dislike
(
fk_userid           varchar2(40)   not null   -- 사용자ID       
,fk_pnum             number(8)      not null   -- 제품번호(foreign key)
,constraint PK_purchase_dislike primary key (fk_userid, fk_pnum)
,constraint FK_purchase_dislike_pnum foreign key(fk_pnum) references tbl_product(pnum)
);


---------------------------------------------------------------------------------------
select * from tab;
select * from tbl_member;
-- seoyh 이라는 사용자가 제품번호 58 제품을 좋아한다에 투표를 한다. 
-- 먼저 사용자가 제품번호 58 제품에 싫어한다에 투표를 했을 수도 있다.
-- 그러므로 먼저 tbl_product_dislike 테이블에서 seoyh 이라는 사용자가 제품번호 58 제품이 insert 되어진 것을 delete 해야한다.

delete from tbl_purchase_dislike where fk_userid= 'cjh201475' and fk_pnum = 56;


insert into tbl_purchase_like(fk_userid, fk_pnum) values('cjh201475', 56);
commit;



-- seoyh 이라는 사용자가 제품번호 58 제품을 싫어한다에 투표를 한다. 
insert into tbl_product_dislike(fk_userid, fk_pnum) values('cjh201475', 58);
commit;

-----------------------------------------------------------------------------------

select * from tbl_purchase_like;
select * from tbl_product;

select (
select count(*) 
from tbl_purchase_like
where fk_pnum='56'
) as LIKECNT,
(
select count(*) 
from tbl_purchase_dislike
where fk_pnum='56'
) as DISLIKECNT
from dual;


String sql = "select (\n"+
"select count(*) \n"+
"from tbl_purchase_like\n"+
"where fk_pnum='56'\n"+
") as LIKECNT,\n"+
"(\n"+
"select count(*) \n"+
"from tbl_purchase_dislike\n"+
"where fk_pnum='56'\n"+
") as DISLIKECNT\n"+
"from dual;";

String sql = "delete from tbl_product_dislike where fk_userid= 'cjh201475' and fk_pnum = 58;\n"+
"\n"+
"insert into tbl_purchase_like(fk_userid, fk_pnum) values('cjh201475', 56);\n"+
"";


select * from tbl_purchase_dislike;

create table tbl_purchase_dislike
(
fk_userid           varchar2(40)   not null   -- 사용자ID       
,fk_pnum             number(8)      not null   -- 제품번호(foreign key)
,constraint PK_purchase_dislike primary key (fk_userid, fk_pnum)
,constraint FK_purchase_dislike_pnum foreign key(fk_pnum) references tbl_product(pnum)
);



select * from REVIEW;

-- review table insert
insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '2', 'MX ERGO', '강력 추천합니다.', '5')

insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '2', 'MX ERGO', '다시 사도 훌륭합니다.', '5')

insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '2', 'MX ERGO', '다시 다시 사도 훌륭합니다.', '5')

insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '4', 'MX ERGO', '강력 추천합니다.', '4')

insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '6', 'MX ERGO', '강력 추천합니다.', '3')

insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '7', 'MX ERGO', '강력 추천합니다.', '2')

insert into REVIEW (seq_review, fk_memberno, fk_productid, content, score)
values ( seq_review.nextval,  '9', 'MX ERGO', '강력 추천합니다.', '1')


select seq_review, fk_memberno, fk_productid, content, score
from review;

select 
(
select count(*)
from review
where fk_productid = 'MX ERGO'
) as count,

(
select sum(score)
from review
where fk_productid = 'MX ERGO'
) as sum
from dual;




-- 해당 상품 평점 평균 3자리 까지 보여주기.
select round (sum(score) / count(*), 2 ) 
from review
where fk_productid = 'MX ERGO';

-- 해당 상품의 리뷰에 참여한 사람의 수 
select count(*)
from review
where fk_productid = 'MX ERGO';

-- 해당 제품에 대한 리뷰 게시판 vo list로 만들 쿼리. 세부내용은 더 추가하면됨.
select seq_review, A.fk_productid, color, userid, score, content, review_image, to_char(writeday, 'yyyy-mm-dd') 
from review A join member B
on A.fk_memberno = B.memberno
join productoption C
on A.fk_productid = C.fk_productid
order by 1;

-- where A.fk_memberno = '2';

select * from review;
select * from product;
select * from member;
select * from productoption;

-----------------------------------------------------------------

1	jun34	5	        강력 추천합니다.		2020-11-19
2	fjwomew34	4	강력 추천합니다.		2020-11-19
3	fqjkm23	3	강력 추천합니다.		2020-11-19
----------------------------------------------------------------------------------------------

select * 
from productoption
where fk_productid = 'MX ERGO'; 
-- MX ERGO_1	MX ERGO	black	0	


select color 
from productoption
where fk_productid = 'MX ERGO'; 
-- black
-- red
-- white
-- blue


select * 
from review 
where fk_productid = 'MX ERGO'; 













select * from 
review;



select * from 
product;

select * from
productoption;

(
select color from
productoption
where fk_productid = 'X50' ) 


select * from
productoption
where fk_productid = 'X50'; 






select * from member;
select *
from review;


alter table review
add review_image varchar2(60);

alter table review
add writeday date default sysdate;




















select * from member
order by memberno;

select * from product;



select * from member;
create sequence seq_review
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

