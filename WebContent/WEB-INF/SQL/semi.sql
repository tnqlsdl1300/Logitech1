select *
from joinevent;

select *
from tab;
SELECT * FROM event;
select * from product;
select * from productcategory;
select * from PURCHASEdetail;
desc PURCHASEdetail;

create table productcategory
(category   varchar2(10) not null
,constraint PK_productcategory primary key(category)
);

-- 찜하기 제품아이디별 찜 수량
select fk_productid, sum(status)
from LIKEPRODUCT
group by fk_productid;

insert into PURCHASE (PURCHASENO, FK_MEMBERNO, RECEIVER, POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, PAYMENT, PURCHASEDAY, TOTALPRICE)
values(PURCHASE_SEQ.nextval, '2', '박수빈', '21413', '주소1', '주소2', '주소3', 'card', '2020-11-16', '25000');

insert into PURCHASEdetail (purchasedetailid, fk_purchaseno, fk_productid, fk_productserialid, volume)
values(PURCHASEDETAIL_SEQ.nextval, '4', 'X100', 'X100_2', 5);

--where lower(character) like '%게이밍%' 

desc LIKEPRODUCT;
select * from likeproduct;
select * from member;

insert into likeproduct (fk_memberno, fk_productid, status)
values('121', 'Logitech Pebble M350', 1);

select productid, productname, fk_category, character, price, imgfilename, status
from
(
    select fk_productid, sum(status) as status
from likeproduct
group by fk_productid
) C
inner join product P
on C.fk_productid = P.productid
where lower(character) like '%무선%' 
order by status desc;
--
String sql = "select productid, productname, fk_category, character, price, imgfilename, status\n"+
"from\n"+
"(\n"+
"    select fk_productid, sum(status) as status\n"+
"from likeproduct\n"+
"group by fk_productid\n"+
") C\n"+
"inner join product P\n"+
"on C.fk_productid = P.productid\n"+
"where lower(character) like '%무선%' \n"+
"order by status desc";


--- 판매수 별 물품
select productid, productname, fk_category, character, price, imgfilename, volume
from
(
    select fk_productid,  sum(volume) as volume
    from PURCHASEdetail
    group by fk_productid
) C
inner join product P
on C.fk_productid = P.productid
order by volume desc;
-- sql문
String sql = "select productid, productname, fk_category, character, price, imgfilename, volume\n"+
"from\n"+
"(\n"+
"    select fk_productid,  sum(volume) as volume\n"+
"    from PURCHASEdetail\n"+
"    group by fk_productid\n"+
") C\n"+
"inner join product P\n"+
"on C.fk_productid = P.productid\n"+
"order by volume desc";


-- 컬럼 추가
ALTER TABLE joinevent ADD eventcomment VARCHAR2(300) NOT NULL;
select * from productoption;
desc productoption;
insert into productoption(productserialid, fk_productid, color, stock)
values('MX ANYWHERE 3 1', 'MX ANYWHERE 3', 'black', 0);

commit;

select productid
from product
where productid in('MX ANYWHERE 3','MX ERGO','Logitech Pebble M350')
ORDER BY decode(productid, 'MX ANYWHERE 3', 1,  'MX ERGO', 2, 'Logitech Pebble M350', 3);
ORDER BY decode(productid, ?, 1, ?, 2, ?, 3)
--
String sql = "select productid\n"+
"from product\n"+
"where productid in(?)\n"+
"ORDER BY decode(productid, 'MX ANYWHERE 3', 1,  'MX ERGO', 2, 'Logitech Pebble M350', 3)";

-- 전체 시퀀스 보기
SELECT * FROM PRODUCTOPTION;

String sql = "select seq_event, eventname, fk_productid, startday, endday, carouselimg \n"+
"from event\n"+
"where SEQ_EVENT = ? ";

SELECT * FROM USER_SEQUENCES;

drop table abc purge;

desc KEYWORDSEARCH;

select *
from product;

--- 기간 내 이벤트만 보여주는 쿼리
select *
from event 
WHERE trunc(sysdate) BETWEEN TO_DATE(STARTDAY, 'YY/MM/DD') AND
                                TO_DATE(ENDDAY, 'YY/MM/DD');
--
String sql = "select seq_event, eventname, fk_productid, startday, endday, carouselimg\n"+
"from event \n"+
"WHERE trunc(sysdate) BETWEEN TO_DATE(STARTDAY, 'YY/MM/DD') AND\n"+
"                                TO_DATE(ENDDAY, 'YY/MM/DD')";
                                
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
values('가정용', 0);

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

-- 제품검색쿼리
select *
from product
where productid like '%MX%' or productname like '%mx%'

--(rank)
select *
from product
where character like '%무선%' 
order by price;
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

--- 비밀번호 변경 쿼리
update member set pwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
where userid = 'hjun343';
--
String sql = "update member set pwd = ?\n"+
"where userid = ?";
rollback
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

-- 회원 삭제
delete from member 
where userid = 'test123';

commit;

----------------------------------------------------------------------------------------------------

select *
from product
where productid in ('MX ANYWHERE 3','Logitech Pebble M350','MX ERGO');


select *
from product
where productid = 'MX ANYWHERE 3'
UNION ALL 
select *
from product
where productid = 'Logitech Pebble M350'
UNION ALL 
select *
from product
where productid = 'MX ERGO';



sql=> select productid, productname, fk_category, character, price, imgfilename from product where productid = 'Logitech Pebble M350'  select productid, productname, fk_category, character, price, imgfilename from product where productid = 'MX ERGO'  UNION ALL  select productid, productname, fk_category, character, price, imgfilename from product where productid = 'MX ANYWHERE 3' 








