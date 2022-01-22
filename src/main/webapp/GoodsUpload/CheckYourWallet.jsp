<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String uIDD = null;
    if(session.getAttribute("uID") != null){
    	uIDD = (String)session.getAttribute("uID"); 
    	} 
    String authority = null;
    if(session.getAttribute("authority") != null){ 
    	authority = (String)session.getAttribute("authority"); 
    	}
 %>
      
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
<div id="wrap">

           <header id="header" class="flex-container">
            
            <div id="logo">
                <a href="index.html"><img src="/logoB.jpg" alt=""></a>

            </div>
            <nav id="nav1" class="flex-container">
                <ul id="goods"><a href="#">shop</a>
                    <li class="goods1"><a href="#">품목1</a></li>
                    <li class="goods1"><a href="#">품목2</a></li>
                    <li class="goods1"><a href="#">품목3</a></li>
                    <li class="goods1"><a href="#">품목4</a></li>
                    <li class="goods1"><a href="#">품목5</a></li>
                </ul>
                <ul><a href="#">LookBook</a></ul>
                <ul><a href="#">About</a></ul>
                <ul id="board1"><a href="#">Board</a>
                    <li class="board"><a href="../Notice/NoticeList.jsp">Notice</a></li>
                    <li class="board"><a href="../Q&A/QnAList.jsp">Q&A</a></li>
                    <li class="board"><a href="../Review/ReviewList.jsp">Review</a></li>
                </ul>
            </nav>
             
            <nav id="nav2" class="flex-container">
            <% if(uIDD == null){ /* 로그인 안되있을때 */ %>
                <ul><a href="../Account/Login.jsp">Login</a></ul>
                <ul><a href="../Account/Join.jsp">Account</a></ul>
			<%  }
            
            else if(uIDD !=null && authority.equals("user")){ %> <!-- 로그인이 되있을때 -->
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
                <ul><a href="../GoodsUpload/MyBasket.jsp">Cart</a></ul>
                <ul><a href="../Account/Mypage.jsp">MyPage</a></ul>
			<% } 
            else if(uIDD !=null && authority.equals("admin")){
			%>
			<p>안녕하세요<br><%=uIDD %>님! 관리자 권한입니다!</p>
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
				<ul><a href="../GoodsUpload/GoodsUpload.jsp">GoodsUpload</a></ul>
			<% } %>
                <ul id="search1"><a href="#">Search</a>
                    <li class="search2"><input type="text" placeholder="검색어를 입력해주세요"><a href="#" id="searcha">검색</a></li>
                </ul>
                
            </nav>
            

        </header>


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

	    <footer id="footer">


            <div id="info" class="flex-container">
            
            <div id="cs">
                <h4>C.S CENTER</h4>
                <ul>고객센터 -070-4131-0032</ul>
                <ul>OPEN : MON - FIR 10:30AM - 18:00PM</ul> 
                <ul>LUNCH : 12:30PM - 13:30PM</ul>
                <ul>EVERY WEEKEND, HOLIDAY OFF</ul>
                <br>
                <ul>협찬/CS 문의 : peace@lofi.co.kr</ul>
            </div>
            <div id="bank">
                <h4>BANK ACOOUNT</h4>
                <ul>국민은행 022201-04-252808</ul>
                <ul>예금주 : 주식회사 슬랜빌리지</ul>
            </div>
            <div id="links">
                <h4>LINKS</h4>
                <ul><a href="#">회사소개</a></ul>
                <ul><a href="#">이용약관</a></ul>
                <ul><a href="#">개인정보취급방침</a></ul>
                <ul><a href="#">이용안내</a></ul>
            </div>
            <div id="follow">
                <h4>FOLLOW</h4>
                <ul><a href="#">대충 인스타그램 이미지</a></ul>
            </div>
        </div>

            <div id="info2">
                <p>&copy; <b>로파이</b> / site bt the 131DESIGN </p>
                <br>
                <p>주식회사 슬랜빌리지 Ceo : 고혁준 Address : 서울시 광진구 동일로66길 14 2층 슬랜빌리지 (반품 주소 아님) Business License : 485-88-01590 E-Connerce Permit:제 2013-서울중랑-0431 호 Email : 김도윤(team@lofi.co.kr)</p>
            </div>

        </footer>

</div>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_HeaderFooter.js"></script>
<script src="../script/script_MyBasket.js"></script>
<script src="../script/script_Purchase.js"></script>
</body>
</html>