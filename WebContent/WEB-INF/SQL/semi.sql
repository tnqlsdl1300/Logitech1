select *
from abc;

select *
from tab;

SELECT * FROM USER_SEQUENCES;

drop table abc purge;

select *
from member;

insert into member (memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)
values(member_seq.nextval, 'userid', 'pwd', 'name', 'email', 'mobile', 'birthday', 1, 1, 1);

 insert into member(memberno, userid, pwd, name, email, mobile, birthday, agreethird, agreesms, agreeemail)
 values(member_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?)

desc member;