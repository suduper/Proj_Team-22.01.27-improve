<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_user.User" %>
<%@ page import="pack_user.UserDAO" %>
<%@ page import="pack_goods.GoodsProc" %>

<%@page import="java.text.NumberFormat"%>

<%@page import="java.io.PrintWriter"%>

<jsp:useBean id="walletInfo" class="pack_user.UserDAO" scope="page"/>
<jsp:useBean id="useWallet" class="pack_goods.GoodsProc" scope="page" />
 
<%request.setCharacterEncoding("UTF-8"); %>

<% 
int res = 999;
if(session.getAttribute("sessionChecker") != null){
	res = 2;
}

String info = request.getParameter("info");

String[] infoSplit = info.split("/");
String uID = infoSplit[0];
int sum = Integer.parseInt(infoSplit[1]);

UserDAO userDAO = new UserDAO();
int walletMoney = userDAO.Wallet(uID);
String result = null;
if(walletMoney > 0){
	result = "성공";
}  

int pay = walletMoney - sum;

NumberFormat money = NumberFormat.getNumberInstance();
String MyWalletMoney = money.format(walletMoney);
String YouHaveToPay = money.format(sum);
String PayedWalletMoney = money.format(pay);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CheckYourWallet</title>
<link rel="stylesheet" href="../style/style_goods.css">
</head>
<body>
<h1>결제정보</h1>
<input type="hidden" name="res" id="res" value="<%=res%>"/>
<div id="purchaseInfo">
	<p><%=uID %> 님의 지갑정보 불러오기 <%=result %></p>
	<p>현재 내 지갑 : <span id="showInfo"><%=MyWalletMoney %></span>원</p>
	<p>결재 금액 : <span id="showInfo"><%=YouHaveToPay %></span>원</p>
	<p>결제후 내 지갑 : <span id="showInfo"><%=PayedWalletMoney %></span>원</p>
</div>

<div id="purchaseCheck">
	<p>구매하시겠습니까?</p>
	<ul class="choice">
		<li><span onclick="callWallet()">Yes</span></li>
		<li><span onclick="window.close()">No</span></li>
	</ul>
</div>

<div id="hiddenForm">
	<form action="PurchaseAction.jsp" id="Purchase">
		<input type="hidden" name="uID" id="uID" 	value="<%=uID %>" />
		<input type="hidden" name="sum" id="sum" value="<%=sum %>" />
	</form>
</div>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_MyBasket.js"></script>
<script src="../script/script_Purchase.js"></script>
</body>
</html>