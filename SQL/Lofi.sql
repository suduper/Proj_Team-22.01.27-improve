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
/*----------------초기 입력----------------*/

insert into userInfo(uID,uPw,authority) values ('test1234','1234','admin');  /*관리자 권한 계정 임시 생성*/

/*------------------------------------------------------*/
select now();
-- --///////////////desc 문/////////////--  -- 
desc userInfo;
desc Goodsinfo;
desc tblReview;
-- --////////////// 선택문 //////////////--  -- 

select*from userInfo;
select*from GoodsInfo; 
select*from tblReview;

-- --///////////// 명령어 /////////////--  --

select * from goodsInfo where goodsNum=1;

-- --////////////// 업데이트 //////////////--  -- 
set SQL_SAFE_UPDATES = 0;

update GoodsInfo set goodsName = '봄옷 시리즈시험_2112310953',goodsPrice=12321231 where goodsName='봄옷 시리즈시험';
update GoodsInfo set goodsThumbnail = '67SE7Ji3MQ==.jpg' where goodsName = '봄옷 시즌1_2201011215';
update GoodsInfo set goodsImages = '67SE7Ji3Mg==.jpg / 67SE7Ji3Mw==.jpg / 67SE7Ji3MQ==.jpg / 67SE7Ji3Mg==3.jpg / ' where goodsName = '완전변경 봄옷시즌!_2201011215';

delete from GoodsInfo where goodsName= '전체변경 _2201010238';

-- --//////////////!!!드랍!!!///////////////--  -- 
drop database !lofip;
drop table !UserInfo;
drop table GoodsInfo;
drop table !tblReview;