<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_goods.GoodsProc"%>
<%@ page import="pack_goods.Goods" %>
<%@ page import="pack_goods.MyBasket" %>

<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
<%@ page import="java.io.*" %>

<%@page import="java.io.PrintWriter"%>
<%@ page import="pack_goods.MyBasket, java.util.Vector" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />

<% request.setCharacterEncoding("UTF-8");%>

<%
String uID = null; 
if(session.getAttribute("uID") != null){
	uID = (String)session.getAttribute("uID"); 
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인 해주세요')");
	script.println("location.href='../Account/Login.jsp'");
	script.println("</script>");
}
int BasketCount = goods.BasketCount(uID);

Vector<MyBasket> BasketList = null;

int listSize = 0;

Encoder encoder = Base64.getEncoder();
Decoder decoder = Base64.getDecoder();

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MyBasket</title>
</head>
<style>
div#ShowItem {
margin : 0px auto;
width : 800px;
height : 170px;
border : 2px solid #080;
display: flex;
}
th{
font-size: 12px;
height: 30px;
line-height: 30px;
}
td{
width: 120px;
height: 100px;
border: 1px solid #000;
text-align: center;
object-fit: contain;
}
td#showThumb {
border: 1px dashed #00f;
}
td#showThumb img{
max-width: 100px;
height: auto;
}
input[type=checkbox] {
transform : scale(1.5);
}


</style>
<body>
	<%
		BasketList = goods.showBasket(uID);
		listSize = BasketList.size();
		if(BasketList.isEmpty()){
	%>
	<h1>내옷바구니 없음</h1>
	<% 
		} else {
			for (int i = 0; i < listSize; i++){
				MyBasket list = BasketList.get(i);
				
				String goodsName = list.getGoodsName();
				
				Goods view =goods.getGoodsView(goodsName);
				
				int NL = goodsName.length();	 //NameLength = 서버내 상품이름길이
				int TL = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
				String showName = goodsName.substring(0,TL); //표기할 상품명 생성
				String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
				byte[] getName = showName.getBytes();//바이트로 변환
				String tloc = encoder.encodeToString(getName);//인코딩
				tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
					
				int Scount = list.getScount();
				int Mcount = list.getMcount();
				int Lcount = list.getLcount();
				int XLcount = list.getXLcount();
				int Allcount = list.getAllcount();
				int calcRes = list.getCalcRes();
	%>
			<div id="ShowItem">
				<table>
					<thead>
						<tr>
							<th>상품 이미지</th>
							<th>각 사이즈 갯수</th>
							<th>전체 상품 갯수</th>
							<th>해당 상품 전체 가격</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td id="showThumb">
								<img src="../Resource/GoodsImg/<%=tloc %>/thumb/thumb_<%=view.getGoodsThumbnail() %>" alt="" />
							</td>
							<td>
								<span>S : <%=Scount %></span><br />
								<span>M : <%=Mcount %></span><br />
								<span>L : <%=Lcount %></span><br />
								<span>XL : <%=XLcount %></span><br />
							</td>
							<td> <%=Allcount %></td>
							<td><%=calcRes %></td>
							<td>
								<input type="checkbox" name="buy" id="buy" />
							</td>
						</tr>
					</tbody>
				</table>
			</div>
	<%		
			}
		}
	%>
	<div id="buyProc">
		<button type="button">장바구니 구매</button>
	</div>
</body>
</html>