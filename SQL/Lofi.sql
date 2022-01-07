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
goodsNum       			int     				auto_increment     primary key,
goodsName     			varchar(200)			not null,
goodsWarehousing 		varchar(8)				,
goodsType      		 	varchar(20)				,
goodsPrice      			int(7)						,
goodsSPrice    			int(7)						,
goodsThumbnail   		varchar(1000)			,
goodsImages   			varchar(1000)			,
goodsContent   			varchar(5000)			,
regDate 					varchar(20)			not null,
inventoryS					int(3)						,
inventoryM					int(3)						,
inventoryL					int(3)						,
inventoryXL				int(3)						,
wCount        				int default 0,
goodsLike      			double
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

/*---------------------장바구니 테이블--------------------*/

create table userBasket (
uID        			char(20),
goodsName     	varchar(200)			not null,
Scount 				int(3),
Mcount 				int(3),
Lcount 				int(3),
XLcount 			int(3),
allcount 			int(4),
calcRes 				int(9)
);
/*----------------초기 입력----------------*/

insert into userInfo(uID,uPw,authority) values ('test1234','1234','admin');  /*관리자 권한 계정 임시 생성*/

/*------------------------------------------------------*/
select now();
-- --///////////////desc 문/////////////--  -- 
desc userInfo;
desc Goodsinfo;
desc tblReview;
desc userBasket;
-- --////////////// 선택문 //////////////--  -- 

select*from userInfo;
select*from GoodsInfo; 
select*from tblReview;
select*from userBasket;

-- --///////////// 명령어 /////////////--  --

select * from goodsInfo where goodsNum=1;
insert into userBasket value ('a123','b234',123,123,123,123,23231,223123);

select count(*) from userbasket where uID = 'user1234';

select * from userBasket where uID = 'user1234';

delete from userBasket where uID = 'user1234';



update userBasket set Scount = 3 , Mcount = 2,  Lcount = 1 , XLcount = 0 ,  allCount = 6, calcRes = 300000 where uID = 'user1234' and goodsName = '겨울옷시리즈_2201040857' ;
 SELECT EXISTS(SELECT * FROM MYTABLE where MYCOLUMN = VALUE ) as isHava;
select exists (select * from userBasket where uID = 'user1234' and goodsName = '겨울옷시리즈_2201040857' limit 1) as RES;
-- select EXISTS (select * from 테이블이름 where 컬럼=찾는 값 limit 1) as success;
select count(case when uID = 'user1234' and goodsName ='겨울옷시리즈_2201040857' then 1 end) as uID from userBasket; 

SELECT column_name(s)
FROM table_name
WHERE EXISTS
(SELECT column_name FROM table_name WHERE condition);


-- --////////////// 업데이트 //////////////--  -- 
set SQL_SAFE_UPDATES = 0;

update GoodsInfo set goodsName = '봄옷 시리즈시험_2112310953',goodsPrice=12321231 where goodsName='봄옷 시리즈시험';
update GoodsInfo set goodsThumbnail = '67SE7Ji3MQ==.jpg' where goodsName = '봄옷 시즌1_2201011215';
update GoodsInfo set goodsImages = '67SE7Ji3Mg==.jpg / 67SE7Ji3Mw==.jpg / 67SE7Ji3MQ==.jpg / 67SE7Ji3Mg==3.jpg / ' where goodsName = '완전변경 봄옷시즌!_2201011215';
update GoodsInfo set inventoryM = 0 where goodsName='겨울옷시리즈_2201040838';

delete from GoodsInfo where goodsName= '전체변경 _2201010238';

-- --//////////////!!!드랍!!!///////////////--  -- 
drop database !lofip;
drop table !UserInfo;
drop table GoodsInfo;
drop table !tblReview;
drop table !userBasket;