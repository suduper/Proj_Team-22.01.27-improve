<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_user.User" %>
<%@ page import="pack_user.UserDAO" %>
<%@ page import="pack_goods.GoodsProc" %>

<%@page import="java.text.NumberFormat"%>

<jsp:useBean id="walletInfo" class="pack_user.UserDAO" scope="page"/>
<jsp:useBean id="useWallet" class="pack_goods.GoodsProc" scope="page" />

<%request.setCharacterEncoding("UTF-8"); %>

<% 
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
String YouHaveToPay = money.format(pay);
String PayedWalletMoney = money.format(walletMoney - sum);
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>CheckYourWallet</title>
</head>
<body>
<h1>결제정보</h1>
<%=uID %><br>
<%=result %><br>
현재 내 지갑 <%=MyWalletMoney %><br>
결재 금액 : <%=YouHaveToPay %><br>
결제후 내 지갑 <%=PayedWalletMoney %><br>
</body>
</html>