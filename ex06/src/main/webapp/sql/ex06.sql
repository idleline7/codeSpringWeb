create table users(
      username varchar2(50) not null primary key,
      password varchar2(50) not null,
      enabled char(1) default '1');

      
 create table authorities (
      username varchar2(50) not null,
      authority varchar2(50) not null,
      constraint fk_authorities_users foreign key(username) references users(username));
      
 create unique index ix_auth_username on authorities (username,authority);


insert into users (username, password) values ('user00','pw00');
insert into users (username, password) values ('member00','pw00');
insert into users (username, password) values ('admin00','pw00');

insert into authorities (username, authority) values ('user00','ROLE_USER');
insert into authorities (username, authority) values ('member00','ROLE_MANAGER'); 
insert into authorities (username, authority) values ('admin00','ROLE_MANAGER'); 
insert into authorities (username, authority) values ('admin00','ROLE_ADMIN');
commit;

--인증/권한을 위한 테이블 설계
create table tbl_member( --회원 관련
    userid varchar2(50) not null primary key,
    userpw varchar2(100) not null,
    username varchar2(100) not null,
    regdate date default sysdate,
    updatedate date default sysdate,
    enabled char(1) default '1');
    
create table tbl_member_auth( --권한
    userid varchar2(50) not null,
    auth varchar2(50) not null,
    constraint fk_member_auth foreign key(userid) references
tbl_member(userid)
);

select
    userid username, userpw password, enabled
from
    tbl_member
where userid='admin90';

select
    userid username, auth authority
from
    tbl_member_auth
where userid = 'admin90';

--스프링 시큐리티의 공식 문서에 나오는 로그인 정보를 유지하는 테이블
create table persistent_logins(
     username varchar(64) not null,
     series varchar(64) primary key,
     token varchar(64) not null,
     last_used timestamp not null
);