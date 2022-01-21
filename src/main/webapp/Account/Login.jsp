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
    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
<link rel="stylesheet" href="../style/style.css"/>
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
        
        
	<form action="LoginAction.jsp" id="LoginAction" >
		<table>
			<tbody>
			<caption>로그인</caption>
				<tr>
					<td><input type="text" name="uID" id="uID" placeholder=" ID"class="full"></td>
				</tr>

				<tr>
					<td><input type="password" name="uPw" id="uPw" placeholder=" PW"class="full"></td>
				</tr>
				<tr>
					<td id="Td_Id_save"><input type="checkbox" id="Input_Id_save"><span style="font-size: 13px;">아이디저장</span></td>
				</tr>
				<tr>
				<td><a href="#" style="font-size: 7px; text-decoration-line:outline;">아이디 찾기</a>
				         <a href="#"style="font-size: 7px; text-decoration-line:outline;">비밀번호 찾기</a></td>
				</tr>
					<tr class="infor" id="LoginOrAccount">
					<td><button type="button" id="btn-Login" class="Join_btn"style="background-color: #fff; color: #000">로그인</button></td>
					<td ><button type="button" id="btn-Account" class="Join_btn" style="background-color: #000; color: #fff">회원가입</button></td>
				</tr>
					<tr class="infor2" id="infor2">
					<td><button type="button" id="Naver_Login" class="Join_btn2"style="background-color: #fff; color: #000">NAVER</button></td>
					<td ><button type="button" id="Kakao_Login" class="Join_btn2" style="background-color: #fff; color: #000">KAKAO</button></td>
				</tr>
			</tbody>
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
<script>
$("#btn-Account").click(function(){
	location.href = "Join.jsp";
});
$("#btn-Login").click(function() {
	let uID = $("#uID").val();
	let uPw = $("#uPw").val();
	if(uID==""){
		alert("아이디 입력값은 필수입니다");
		$("#uID").focus();
	}else if (uPw == "") {     // 비밀번호 검사 시작
		alert("비밀번호를 입력하세요.");
		$("#uPw").focus();
	}else{
		$(document).ready(function() {
			$('#btn-Login').click(function () { 
				$("form").submit(); 
			});
		});
	}
})

</script>
</body>
</html>