select *
from abc;

select *
from tab;

SELECT * FROM USER_SEQUENCES;

drop table abc purge;

select *
from member
order by memberno;

insert into member (memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)
values(member_seq.nextval, 'userid', 'pwd', 'name', 'email', 'mobile', 'birthday', 1, 1, 1);

 insert into member(memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)
 values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)

desc member;



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