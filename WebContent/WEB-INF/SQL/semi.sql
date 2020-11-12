select *
from abc;

select *
from tab;

select *
from review;

SELECT * FROM USER_SEQUENCES;

drop table abc purge;

desc KEYWORDSEARCH;

select *
from PRODUCT;

select *
from PURCHASEDETAIL;
-- 여기에 productid 가 들어가야함

------ 구매디테일 테이블 제품넘버 추가
drop table PURCHASEDETAIL purge;
create table purchasedetail
(purchasedetailid number not null
,fk_purchaseno number not null
,fk_productid     varchar2(30) not null
,fk_productserialid varchar2(30) not null
,volume number(5) not null
,constraint PK_purchasedetail primary key(purchasedetailid)
,constraint FK_purchasedetail_pur foreign key(fk_purchaseno) references purchase(purchaseno)
,constraint FK_productid_pur foreign key(fk_productid) references PRODUCT(productid)
,constraint FK_purchasedetail_pro foreign key(fk_productserialid) references productoption(productserialid)
);
-- Table PURCHASEDETAIL이(가) 생성되었습니다.
drop sequence purchasedetail_seq;
create sequence purchasedetail_seq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select * from purchasedetail;
--------------------

commit;


--- KEYWORDSEARCH 테이블에 키워드 넣는 쿼리
insert into KEYWORDSEARCH(KEYWORD, SEARCHCNT)
values('사무용', 0);

무선
유선
게이밍
사무용

--- select 인기검색어 쿼리
select keyword, searchcnt
from keywordsearch
order by searchcnt desc;
--
String sql = "select keyword, searchcnt\n"+
"from keywordsearch\n"+
"order by searchcnt desc";

-- update 인기검색어 cnt 제어 쿼리
update keywordsearch set searchcnt= searchcnt + 1
where keyword='무선';
--
String sql = "update keywordsearch set searchcnt= searchcnt + 1\n"+
"where keyword=?";

select *
from keywordsearch;

select userid
from member
where userid = 'hjun34' and mobile='X8MAf5MHC2yJl8K95HOrCA==';
--
String sql = "select userid\n"+
"from member\n"+
"where userid = ? and mobile = ?";

insert into member (memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)
values(member_seq.nextval, 'userid', 'pwd', 'name', 'email', 'mobile', 'birthday', 1, 1, 1);

 insert into member(memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)
 values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)

desc member;


--- 물품 검색(키워드) 쿼리
select keyword, searchcnt
from keywordsearch
order by searchcnt desc;
commit;
-- 제품검색쿼리
select *
from product
where productid like '%MX%' or productname like '%mx%' ;
--(rank)
select *
from product
where character like '%게이밍%' ;
--
String sql = "select productid, productname, fk_category, character, price, imgfilename\n"+
"from product\n"+
"where character like '%' || ? || '%' ";
--(search)
String sql = "select productid, productname, fk_category, character, price, imgfilename\n"+
"from product\n"+
"where productid like '%' || ? || '%' or productname like '%' || ? || '%' ";




-- loginhistory 테이블 생성
drop table loginhistory purge;
create table loginhistory
(
    fk_userid           VARCHAR2(20)      not null
    ,logindate          DATE                   default sysdate      not null
    ,clientip             VARCHAR2(20)      not null
    ,constraint FK_loginhistory foreign key(fk_userid) references member(userid)
);

-- loginuser
select memberno, userid, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, point, registerday, pwdchangegap
        , nvl(lastlogingap, trunc(months_between(sysdate, registerday))) as lastlogingap
from 
(
    select memberno, userid, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, point, registerday
            , trunc(months_between(sysdate, lastpwdchangeday)) as pwdchangegap
    from member
    where status = 0 and userid = ? and pwd = ?
) M
cross join
(
    select trunc(months_between(sysdate, max(logindate))) as lastlogingap
    from loginhistory
    where fk_userid = ?
) H;
--
String sql = "select memberno, userid, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, point, registerday, pwdchangegap\n"+
"        , nvl(lastlogingap, trunc(months_between(sysdate, registerday))) as lastlogingap\n"+
"from \n"+
"(\n"+
"    select memberno, userid, name, email, mobile, birthday, postcode, address, detailaddress, extraaddress, point, registerday\n"+
"            , trunc(months_between(sysdate, lastpwdchangeday)) as pwdchangegap\n"+
"    from member\n"+
"    where status = 0 and userid = ? and pwd = ?\n"+
") M\n"+
"cross join\n"+
"(\n"+
"    select trunc(months_between(sysdate, max(logindate))) as lastlogingap\n"+
"    from loginhistory\n"+
"    where fk_userid = ?\n"+
") H";


select *
from member
order by memberno;

select *
from loginhistory;

-- 3개월 비번 변경, 1년 휴면 됐는지 확인하기 위한 쿼리
update member set registerday = add_months(registerday, 13), lastpwdchangeday = add_months(lastpwdchangeday, 13)
where userid='hjun342';
update loginhistory set logindate = add_months(logindate, -13)
where fk_userid='hjun342';

update member set idle = 0
where userid = 'hjun341';
commit;