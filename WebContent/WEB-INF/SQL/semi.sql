select *
from joinevent;

select *
from tab;
SELECT * FROM purchase;
select * from productoption;
select * from product;
select * from PURCHASEdetail;
desc PURCHASEdetail;

insert into PURCHASE (PURCHASENO, FK_MEMBERNO, RECEIVER, POSTCODE, ADDRESS, DETAILADDRESS, EXTRAADDRESS, PAYMENT, PURCHASEDAY, TOTALPRICE)
values(PURCHASE_SEQ.nextval, '2', '박수빈', '21413', '주소1', '주소2', '주소3', 'card', '2020-11-16', '25000');

insert into PURCHASEdetail (purchasedetailid, fk_purchaseno, fk_productid, fk_productserialid, volume)
values(PURCHASEDETAIL_SEQ.nextval, '4', 'X100', 'X100_2', 5);


select fk_productid,  sum(volume)
from PURCHASEdetail
group by fk_productid;

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

insert into event (SEQ_EVENT, EVENTNAME, FK_PRODUCTID, CAROUSELIMG)
values(EVENT_SEQ.nextval, '슬림한 디자인의 무소음 무선 마우스', 'Logitech Pebble M350', 'https://resource.logitech.com/w_1206,c_limit,q_auto,f_auto,dpr_1.0/content/dam/logitech/en/products/mice/m350/m350-carousel-04.png?v=1!@#https://resource.logitech.com/w_1206,c_limit,q_auto,f_auto,dpr_1.0/content/dam/logitech/en/products/mice/m350/m350-carousel-05.png?v=1!@#https://resource.logitech.com/w_1206,c_limit,q_auto,f_auto,dpr_1.0/content/dam/logitech/en/products/mice/m350/m350-carousel-03.png?v=1!@#https://resource.logitech.com/w_1206,c_limit,q_auto,f_auto,dpr_1.0/content/dam/logitech/en/products/mice/m350/m350-carousel-01.png?v=1');

String sql = "insert into joinevent(seq_joinevent, fk_event, fk_memberno, eventcomment)\n"+
"values(joinevent_seq.nextval, ?, ?, ?)";

commit;
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