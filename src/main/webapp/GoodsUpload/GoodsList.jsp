<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
<%@ page import="java.io.*" %>

<%@ page import="pack_goods.Goods, java.util.Vector" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
<% request.setCharacterEncoding("UTF-8");%>
 
<%
Vector<Goods> GoodsList = null;

int listSize = 0;

String SAVEFOLDER
="C:/Users/TridentK/git/Project_Lofi_Co-op/src/main/webapp/Resource/GoodsImg/"; // 경로명 반드시 변경

Encoder encoder = Base64.getEncoder();
Decoder decoder = Base64.getDecoder();
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
				Goods list = GoodsList.get(i);
				int goodsNum = list.getGoodsNum();
				
				String goodsName = list.getGoodsName();
				
				int NL = goodsName.length();	 //NameLength = 서버내 상품이름길이
				int TL = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
				String showName = goodsName.substring(0,TL); //표기할 상품명 생성
				String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
				byte[] getName = showName.getBytes();//바이트로 변환
				String tloc = encoder.encodeToString(getName);//인코딩
				tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
				
				String goodsType = list.getGoodsType();
				int goodsPrice = list.getGoodsPrice();
				int goodsSPrice = list.getGoodsSPrice();
				String regDate = list.getRegDate();
				int count = list.getwCount();
				
				String way = SAVEFOLDER + tloc +"/thumb/"; // 이미지 저장경로 + 서버상품이름 + 썸네일폴더
				String thumbnail =null;
				File TF = new File(way+"thumb_"+list.getGoodsThumbnail());
	%>
	<div id="Show"> 
	<%
	try {
			if(TF.isFile()) {
			     thumbnail = TF.getName();
	%>
		<a href="GoodsView.jsp?goodsName=<%=goodsName%>">
			<img src="../Resource/GoodsImg/<%=tloc %>/thumb/<%=thumbnail %>" alt=""/>
		</a><br>
	<%
	}else{ 
	%>
		<img src="../Resource/GoodsImg/GoodsReady/goods_ready.jpg" alt="상품 준비중"><br>
	<%
	}
	%>
		
		번호 : <%=goodsNum%> <br>
		종류 : <%=goodsType%> <br>
		이름 : <%=showName%> <br>
		가격 : <%=goodsPrice%> <br>
		
		<%
		if(list.getGoodsSPrice() != 0){
		%>
		
		세일 가격 : <%=goodsSPrice%> <br>
		
		<% 
		}
		%>
		
		상품 등록일 : <%=regDate%><br>
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