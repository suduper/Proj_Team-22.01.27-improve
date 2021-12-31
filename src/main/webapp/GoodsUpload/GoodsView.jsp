<%@page import="pack_goods.GoodsProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
    
<%@ page import="pack_goods.Goods" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
     
<% request.setCharacterEncoding("UTF-8");%>
<%
String uID = null; 
if(session.getAttribute("uID") != null){
	uID = (String)session.getAttribute("uID"); 
} else {
	uID = null;
}

String authority = null;
if(session.getAttribute("authority") != null){  
	if(session.getAttribute("authority").equals("admin")){
		authority = (String)session.getAttribute("authority");
	}
	if(session.getAttribute("authority").equals("user")){
		authority = (String)session.getAttribute("authority");
	}
} 
if(session.getAttribute("authority") ==null){
	authority = "not_Login";
}

Encoder encoder = Base64.getEncoder();
Decoder decoder = Base64.getDecoder();

String goodsNameParam = (String)request.getParameter("goodsName");

goods.upCount(goodsNameParam);
Goods view =goods.getGoodsView(goodsNameParam);
     
int goodsnum = view.getGoodsNum(); 			// 상품 번호

String goodsName = view.getGoodsName(); // 상품 이름
int NL = goodsName.length();	 				// Name Length = 서버내 상품이름길이
int TL = NL - 11;                  					 // True length = 서버내 상품이름에서 날짜 빼기
String showName = goodsName.substring(0,TL); 	// 표기할 상품명 생성
String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
byte[] getName = showName.getBytes(); //바이트로 변환
String tloc = encoder.encodeToString(getName); //인코딩
tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
	
String goodsWarehousing = view.getGoodsWarehousing();
String goodsType = view.getGoodsType(); 	// 상품 종류
int goodsPrice = view.getGoodsPrice(); 		// 상품 판매 가격
int goodsSPrice = view.getGoodsSPrice(); 	// 상품 세일 가격

String goodsThumbnail = view.getGoodsThumbnail(); 	// 상품 썸네일 이름

String goodsImages =view.getGoodsImages(); 	// 상품 이미지 이름
String[] imgArray = goodsImages.split(" / ");
int imgL = imgArray.length;

String goodsContent = view.getGoodsContent(); 	// 상품 내용
String regDate = view.getRegDate();			// 상품 등록일
int wCount = view.getwCount();				// 상품 조회수
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsView</title>
<style>
img#thumb {
width: 150px;
height: 150px;
object-fit: contain;
}
img#gImg {
width: 500px;
height: 500px;
object-fit: contain;
background-color: #888;
}
</style>
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<%=authority %>

	<div id="wrap">

		<h2><%=showName %></h2>
		<div id="thumImg">
			<img id="thumb" src="../Resource/GoodsImg/<%=tloc%>/thumb/thumb_<%=view.getGoodsThumbnail() %>" alt="thumbnail" />
		</div>	
<br>
<br>

<table>
	<tbody>
		<tr>
			<td>상품 종류 : </td>
			<td><%=goodsType %></td>
			<td>입고일 : </td>
			<td><%=goodsWarehousing %></td>
			<td>등록일 : </td>
			<td><%=regDate %> </td>
			<td>가격 : </td>
			<%
			if(goodsSPrice != 0){
			%>
			<td style="text-decoration: line-through;"><%=goodsPrice%></td>
			<td><%=goodsSPrice%></td>
			<%
			} else {
			%>
			<td><%=goodsPrice%></td>
			<%	
			}
			%>
		</tr>
		<tr>
			<td>
			<%for(int i = 0 ; i < imgL ; i++){ %>
				<img id="gImg" src="../Resource/GoodsImg/<%=tloc %>/<%=imgArray[i] %>"/><br>
			<%} %>
			</td>
		</tr>
		<tr>
			<td><%=goodsContent %></td>
		</tr>
		<tr>
			<td><%="조회수 : " + wCount %></td>
		</tr>
	</tbody>
</table>
	<%
	if(authority.equals("admin")){
	%>
	<button type="button" id="listBtn">리스트</button>
	<button type="button" id="replyBtn">답 변</button>
	<button type="button" id="goodsUpdate" onclick="forUpdate('<%=goodsName%>')">수 정</button>
	<button type="button" id="delBtn">삭 제</button>
	<% 
	} else {
	%>
	<button type="button" id="listBtn">리스트</button>
	<button type="button" id="replyBtn">답 변</button>
	<% 
	} 
	%>
	</div>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_GoodsView.js"></script>
</body>
</html>