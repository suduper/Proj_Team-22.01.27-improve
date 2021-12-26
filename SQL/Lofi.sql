create database LofiP;
use LofiP;
/*---------------------유저 테이블--------------------*/
create table userInfo(
Nationality   char(10),
Certify         char(10), 
uID        char(20),
uPw             char(20),
uZip             char(100),
uAddr1         char(100),
uAddr2         char(100),
authority      char(5),
primary key(uID)
);
/*---------------------상품 테이블--------------------*/
create table GoodsInfo(
goodsNum          int     auto_increment     primary key,
goodsName      varchar(200),
goodsType       varchar(20),
goodsPrice       int,
goodsSPrice     int,
goodsImages   varchar(1000),
goodsContent   varchar(5000),
regDate 			varchar(20),
count        			int,
goodsLike      double
);

/*---------------------리뷰 테이블--------------------*/
create table tblReview (
    num          int                    auto_increment,
    uName		char(20)			not null,
    subject     char(50)			not null,
    content		text					null		,    
    ref			int					not null,
    pos			int					not null,
    depth		int					not null,
    regDate		date					not null,
    pass			char(20)			null,
    ip				char(15)			null,    
    count			int					not null,
    fileName	char(50)			null,
    fileSize		int					null,
    constraint		primary key(num)
);
/*------------------------------------------------------*/
select now();
-- --///////////////desc 문/////////////--  -- 
desc userInfo;
desc Goodsinfo;
-- --////////////// 선택문 //////////////--  -- 

select*from userInfo;
select*from GoodsInfo;
select*from tblReview;


-- --/////////////////////////////////--  -- 

select max(goodsNum) from GoodsInfo;

-- --///////////// 명령어 /////////////--  --
select uPw from userInfo where uID ='test1231';
update userInfo set authority = 'admin' where uID = 'test1231';
insert into GoodsInfo (goodsName,goodsType,goodsPrice,goodsSPrice,goodsContent,regDate)values('겨울옷','test2',10000,5000,'test', now());
select * from goodsInfo order by goodsnum desc limit 0, 10;
delete from GoodsInfo where goodsNum =2;

-- --////////////// 업데이트 //////////////--  -- 
set SQL_SAFE_UPDATES = 0;
select * from goodsinfo where goodsName='123';
update goodsInfo set goodsImages1=null,goodsImages2=null where goodsName='123';

-- --//////////////!!!드랍!!!///////////////--  -- 
drop database !lofip;
drop table !UserInfo;
drop table !GoodsInfo;
drop table !tblReview;