<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_goods.GoodsProc"%>
<%@ page import="pack_goods.Goods" %>
<%@ page import="pack_user.User" %>
<%@ page import="pack_user.UserDAO" %>

<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>


<jsp:useBean id="user" class="pack_user.UserDAO"  scope="page" />
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
<%	request.setCharacterEncoding("UTF-8"); %>


<% 
Encoder encoder = Base64.getEncoder();
Decoder decoder = Base64.getDecoder();

NumberFormat money = NumberFormat.getNumberInstance();

int listSize = Integer.parseInt(request.getParameter("count"));
String uID=request.getParameter("uID");

User info = user.userInfo(uID);

int sum = 0;
int sendCount= 0;
String goodsName = null;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BuyProc</title>
</head>
<style>
div#content {
	border: 2px solid #000;
	width: 1100px;
	margin: 0px auto;
}

div#BasketList{
border: 1px solid #000;
width: 800px;
margin:0px auto;
display: flex;
justify-content: space-around;
}

div#ShowItem {
border: 1px solid #f00;
width: 650px;
}

div#buyProc {
width : 120px;
height : 190px;
border: 2px solid #0f0;
text-align: center;
line-height: 15px;
position: relative;
top: 30px;
-webkit-user-select:none; 
-moz-user-select:none; 
-ms-user-select:none; 
user-select:none
}

div#buyProc >p {
border: 1px solid #000;
height: 30px;
line-height: 30px;
}
div#buyProc >p:nth-child(2) {
font-size: 18px;
font-weight: bold;
}

table {
width: 100%;
border-top: 1px solid #d3d3d3;
border-collapse: separate;
border-spacing: 0 10px;
}

tbody tr:nth-child(2n) {
background-color: #fff;
}

tbody tr:nth-child(2n+1) {
background-color: #e3f2fd;
}

td#Sizes{
text-decoration: underline;
}

th{
background-color: #e9e9e9;
border : 2px solid #fff;
font-size: 16px;
width: 150px;
height: 35px;
}
th:nth-child(3){
font-size: 14px;
}
th:nth-child(4){
font-size: 14px;
}
th:nth-child(5){
font-size: 13px;
}
th:nth-child(6){
font-size: 5px;
}

td{
text-align: center;
border-left: 3px solid #fff;
}

td#showThumb img{
max-width: 100px;
height: auto;
}

input[type=text]{
width: 500px;
height: 30px;
}

input[type=checkbox] {
transform : scale(1.5);
}

input[type=checkbox]#selectAll {
position: relative;
top:1.5px;
}

div#buyProc li {
border: 1px solid #000;
height: 30px;
line-height: 28px;
border-radius :10px;
font-size: 15px;
font-weight: bold;
margin-top: 10px;
}

div#buyProc li:hover{
background-color: #e9e9e9;
}

span#goodsName {
	font-size: 12px;
	color: #555;
}
h3 {
text-align: center;
width:100%;
height : 40px;
line-height: 40px;
border: 1px solid #00f;
background-color: #EFEFEF;
}
div#sendInfo {
border: 1px solid #000;
width: 80%;
margin: 0px auto;
padding: 20px;
}
div#sendInfo  p {
margin-top: 15px;
font-size: 20px;
}
span#small {
font-size: 15px;
color: #B0B0B0;
}
div#buy li {
border: 1px solid #000;
width:150px;
height: 40px;
line-height: 40px;
border-radius :10px;
font-size: 25px;
font-weight: bold;
margin: 30px auto;
text-align: center;
}

div#buy li:hover{
background-color: #e9e9e9;
}
span#AllBuyCost {
border: 3px inset #B0B0B0;
font-weight: bold;
}
span#changeZip {
border: 1px solid #000;
border-radius: 10px;
width: 100px;
height: 23px;
line-height: 23px;
font-size: 20px;
margin-left: 10px;
position: relative;
top: 2px;
}
</style>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="content">
	<div id="BasketList">
		<div id="ShowItem">
			<table>
				<tbody>
					<%
					for(int i = 0 ; i <listSize ; i++){
						
						String val = request.getParameter("buyThis"+i);
						if(val != null){
						sendCount ++;
						String[] valSplit = val.split(" / ");
						
						String Split_goodsName = valSplit[0];
						goodsName = Split_goodsName;
						int Scount = Integer.parseInt(valSplit[1]);
						int Mcount = Integer.parseInt(valSplit[2]);
						int Lcount = Integer.parseInt(valSplit[3]);
						int XLcount = Integer.parseInt(valSplit[4]);
						int eachPay = Integer.parseInt(valSplit[5]);
						int Allcount = Scount + Mcount + Lcount + XLcount;
						
						Goods view =goods.getGoodsView(Split_goodsName);
						
						int NL = Split_goodsName.length();	 //NameLength = 서버내 상품이름길이
						int TL = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
						String showName = Split_goodsName.substring(0,TL); //표기할 상품명 생성
						String dates = Split_goodsName.substring(TL,NL); // 상품 등록 날짜
						byte[] getName = showName.getBytes();//바이트로 변환
						String tloc = encoder.encodeToString(getName);//인코딩
						tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
							
						String buyCost = money.format(eachPay);
					%>
					<tr>
						<td id="showThumb">
							<img src="../Resource/GoodsImg/<%=tloc %>/thumb/thumb_<%=view.getGoodsThumbnail() %>" style="width: 80px;"/>
						</td>
						<td><span id="goodsName"><%=showName %></span></td>
						<td id="Sizes">
							<span>S : <%=Scount %></span><br />
							<span>M : <%=Mcount %></span><br />
							<span>L : <%=Lcount %></span><br />
							<span>XL : <%=XLcount %></span><br />
						</td>
						<td> <%=Allcount %> <span>개</span></td>
						<td> <%=buyCost %> <span>원</span></td>
					</tr>
					<%
					sum += eachPay;
						}
					}
					%>
				</tbody>
			</table>
		</div>
	</div>
</div>

<div id="sendInfo">
	<form action="BuyProc.jsp?sendCount=<%=sendCount %>" method="post" id="BuyFin">
		<%
			for(int i = 0; i <listSize; i++){
				String val = request.getParameter("buyThis"+i);
				if(val != null){
		%>
		<%=sendCount %>
		<%=i %>
			<input type="text" name="buyThis<%=i%>" id="buyThis<%=i%>" value="<%=request.getParameter("buyThis"+i)%>"/>
		<%
				}
			} 
		%>
		<input type="text" name="sum" id="sum" value="<%=sum%>"/>
		<input type="text" name="uID" id="uID" value="<%=uID %>" />
		<p>받는사람 : <input type="text" name="who" id="who" value="<%=uID %>" placeholder="받는분 이름" style="width: 100px"/></p>
		<p>결제금액 : <span id="AllBuyCost"><%=money.format(sum) %></span> 원</p>
		<p>	배송지&nbsp;&nbsp;&nbsp;&nbsp;<span id="small"><input type="checkbox" name="change" id="change" onclick="change()"/>&nbsp;(배송지 변경)</span></p>
		<p><input type="text" name="Zip" id="Zip" value="<%=info.getuZip() %>" readonly="readonly"/><span id="changeZip" onclick="" style="background-color: #D9D9D9">우편주소</span></p> 
		<p><input type="text" name="Addr1" id="Addr1" value="<%=info.getuAddr1() %>" readonly="readonly"/></p>
		<p><input type="text" name="Addr2" id="Addr2" value="<%=info.getuAddr2() %>"/></p>
		<p>받는사람 전화번호 : <input type="text" name="phone" id="phone" value="전번"/></p> 
		<p>배송 전달 사항 : <input type="text" name="notice" id="notice" /></p>
	</form>
</div>
<%=session.getAttribute("sessionChecker") %>
<div id="buy">
	<ul>
		<li><span onclick="Purchase('<%=uID%>',<%=sum%>)">구매 하기</span></li>
	</ul>
</div>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_MyBasket.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function kakaopost() {
    new daum.Postcode({
        oncomplete: function(data) {
           document.querySelector("#Zip").value = data.zonecode;
           document.querySelector("#Addr1").value = data.address;
        }
    }).open();
}
</script>
<!--  카카오 우편번호 예제끝-->
</body>
</html>