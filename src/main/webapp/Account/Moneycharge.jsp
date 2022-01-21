  <%@page import="pack_user.User"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%
  String uID = null;
  if(session.getAttribute("uID") != null){
  	uID = (String)session.getAttribute("uID"); 
  	} 
  String authority = null;
  if(session.getAttribute("authority") != null){ 
  	authority = (String)session.getAttribute("authority"); 
  	}
  %>
<jsp:useBean  id="mDAO"   class="pack_user.UserDAO"  scope="page" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>적립금충전확인</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

        <% 

if (uID != null) {   // 현재 로그인 상태라면  %>
<!-- ////////////////  로그인 상태 시작  ////////////////// -->

        
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
            <% if(uID == null){ /* 로그인 안되있을때 */ %>
                <ul><a href="../Account/Login.jsp">Login</a></ul>
                <ul><a href="../Account/Join.jsp">Account</a></ul>
			<%  }
            
            else if(uID !=null && authority.equals("user")){ %> <!-- 로그인이 되있을때 -->
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
                <ul><a href="../GoodsUpload/MyBasket.jsp">Cart</a></ul>
                <ul><a href="../Account/Mypage.jsp">MyPage</a></ul>
			<% } 
            else if(uID !=null && authority.equals("admin")){
			%>
			<p>안녕하세요 <%=uID %>님! 관리자 권한입니다!</p>
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
				<ul><a href="../GoodsUpload/GoodsUpload.jsp">GoodsUpload</a></ul>
			<% } %>
                <ul id="search1"><a href="#">Search</a>
                    <li class="search2"><input type="text" placeholder="검색어를 입력해주세요"><a href="#" id="searcha">검색</a></li>
                </ul>
                
            </nav>
            

        </header>
        
        
<%=uID %>
	<form action="MoneyAction.jsp" method="post" id="moneyFrm" name="moneyFrm">
		<table>
			<tbody>
			<caption> 충전하실 적립금 금액을 입력해주세요</caption>
				
				<tr>
					<td><input type="number" name="Wallet" id="Wallet" class="full"></td>
				</tr>


	            <tr class="infor">
					<td ><button type="button" id="btn-Join" class="Join_btn" style="background-color: #000; color: #fff">충전</button></td>
					<td><button type="button" id="btn-Cancel" class="Join_btn"style="background-color: #fff; color: #000">충전취소</button></td>
				</tr>

			<!-- 체크박스 끝 -->
		</table>
	</form>
	
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
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <script src="../script/script_HeaderFooter.js"></script>
<!-- jquery로 submit -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>


//아이디 유효성검사시작
	$("#btn-Join").click(function(){
		
			
			$("#moneyFrm").submit();		
			
		});
	
//////////////유효성 검사 시작//////////////////////
	
//////////////유효성 검사 끝 //////////////////////
	$("#btn-Cancel").click(function(){
		location.href = "../Index.jsp";
	});


</script>

</body>
</html>

<% } else { %>

	<script>
		alert("비정상적인 접속입니다.\n"
				 +"메인페이지로 이동합니다."); 
		           // 현재 메인페이지는 없기 때문에 로그인페이지로 이동
		location.href="../Index.jsp";
	
	</script>

<% } %>
