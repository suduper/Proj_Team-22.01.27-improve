<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>

<jsp:useBean id="order" class="pack_goods.GoodsProc" scope="page" />

<jsp:useBean id="SessionCheck" class="pack_goods.Goods" scope="page" />

<jsp:setProperty name="SessionCheck" property="sessionChecker"/>
<%
if(session.getAttribute("sessionChecker") != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('구매 세션이 만료되었습니다.')");
	script.println("location.href='../Main/Main.jsp'");
	script.println("</script>");
}
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
div#res {
margin: 20px auto;
}
</style>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>
<%
	String uID = request.getParameter("uID");
	String orderName = request.getParameter("who");
	int sendCount = Integer.parseInt(request.getParameter("sendCount"));
	int sum = Integer.parseInt(request.getParameter("sum"));
	
	int Zip = Integer.parseInt(request.getParameter("Zip"));
	String Addr1 = request.getParameter("Addr1");
	String Addr2 = request.getParameter("Addr2");
	String phone = request.getParameter("phone");
	String notice = request.getParameter("notice");
	
	int delCheckers = 0;
	String goodsName = null;
	int setInfoNum = 0;
	String buyThis = null;
	for(int i =0 ; i < sendCount ; i++){ 
		buyThis = request.getParameter("buyThis"+setInfoNum);
		if(request.getParameter("buyThis"+setInfoNum) == null){
			setInfoNum++;
			if(i == 0){
				i--;
			}
		} else {
			goodsName = order.userOrder(orderName, buyThis, Zip, Addr1, Addr2, phone, notice);
			delCheckers += order.set0Basket(uID, goodsName);
			out.print(delCheckers);
			setInfoNum++;
		}
	} 
	if(delCheckers == sendCount){
%>
<jsp:setProperty name="SessionCheck" property="sessionChecker" value="impossible"/>
<div id="res">
<% session.setAttribute("sessionChecker","impossible");%>
<%=session.getAttribute("sessionChecker") %>
	<h1>구매완료</h1>
</div>
<%
	} else {
%>

<div id="res">
	<h1>구매 정보 오류</h1>
	<p>대단히 죄송합니다. 관리자에게 문의해 주세요.</p>
</div>
<%			
	}
%>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

</body>
</html>