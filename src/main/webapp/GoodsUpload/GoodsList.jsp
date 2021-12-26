<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>

<%@ page import="pack_goods.Goods, java.util.Vector" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
<% request.setCharacterEncoding("UTF-8");%>
<%
Vector<Goods> GoodsList = null;

int listSize = 0;

String SAVEFOLDER
="C:/ShoppingMall/Project_Lofi_Co-op/src/main/webapp/Resource/GoodsImg/";
%> 
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>GoodsList</title>
</head>
<style>
div#wrap {
display: flex;
flex-wrap: wrap;
margin: 0px auto;
justify-content: space-around;
}
div#Show {
border: 1px solid #000;
width: 450px;
height: 450px;
text-align: center;
margin-top: 20px;
}
img {
width: 250px;
height: 250px;
object-fit: contain;
}
</style>
<body>

<%@include file="../Main/Main_Top.jsp" %>

<div id="wrap">
	<%
		GoodsList = goods.getBoardList();
		listSize = GoodsList.size();			
		if (GoodsList.isEmpty()) { // 등록상품이 없을 경우 출력 
	%> 
	
		<h1>등록상품이 없습니다</h1>		
			
	<%	
		} else { // 등록상품이 있을 경우 출력 시작
			for (int i=0; i<listSize; i++) {						
				Goods bean = GoodsList.get(i);
				int num = bean.getGoodsNum();
				
				String goodsName = bean.getGoodsName();
				int NL = goodsName.length();	 //NameLength = 서버내 상품이름길이
				int TR = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
				String showName = goodsName.substring(0,TR); //표기할 상품명 생성
				
				String goodsType = bean.getGoodsType();
				int goodsPrice = bean.getGoodsPrice();
				int goodsSPrice = bean.getGoodsSPrice();
				String regDate = bean.getRegDate();
				int count = bean.getCount();
				
				String way = SAVEFOLDER + goodsName +"/thum/"; // 이미지 저장경로 + 서버상품이름 + 썸네일폴더
				File ichk = new File(way);
				FilenameFilter filter = new FilenameFilter() { 
					public boolean accept(File f, String name) { 
						return name.contains("TNL"); //TNL이라고 적힌 파일들만 반환
					}
				};			
	%>
	<div id="Show"><!-- <img src="../GoodsImg/GoodsReady/goods_ready.jpg" alt="상품 준비중"> -->
		<%
		try {
			String setN = null;  //setN 변수 초기화
			String[] filenames = ichk.list(filter);
			if(filenames == null){
		%>
		<img src="../Resource/GoodsImg/GoodsReady/goods_ready.jpg" alt="상품 준비중"><br>
		<%
			}else{
			for (String filename : filenames) {
				setN = filename;   //TNL이라고 적힌 파일 이름을 setN으로 저장
		%>
		<a href=""><img src="../Resource/GoodsImg/<%=goodsName %>/thum/<%=setN %>" alt=""/></a><br>
		<%
				}
			}
		%>
		종류 : <%=goodsType %><br>
		이름 : <%=showName%><br>
		가격 : <%=goodsPrice %><br>
		<%
		if(bean.getGoodsSPrice() != 0){
		%>
		세일 가격 : <%=goodsSPrice %><br>
		<% 
		}
		%>
		상품 등록일 : <%=regDate %><br>
		조회수 : <%=count %><br>
	</div>			
	<%
		} catch (Exception e) {
			out.println(e);
		}
			}
		}
	%>
</div>
				
<%@include file="../Main/Main_Bottom.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</body>
</html>