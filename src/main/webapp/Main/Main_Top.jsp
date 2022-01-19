<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MainTop</title>
<link rel="stylesheet" href="../style/style_index.css">
</head>
<body>

<% // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
    String uID = null;
    if(session.getAttribute("uID") != null){
    	uID = (String)session.getAttribute("uID"); 
    	} 
    String authority = null;
    if(session.getAttribute("authority") != null){ 
    	authority = (String)session.getAttribute("authority"); 
    	}
    %> 
    <div id="wrap">
    
    <!-- HTML템플릿(Template, Templet) 헤더 시작 -->

        <header id="header" class="flex-container">
            <div id="logo">
                <a href="../Main/Main.jsp"></a>
            </div>
            <nav id="nav1" class="flex-container">
            <ul>  
                <li id="goods"><a href="../Main/Main.jsp">shop</a>
                    <ul class="goods1"><a href="../Goods/Goods1.jsp"> Lookbook</a></ul>
                    <ul class="goods1"><a href="#">21A/W 신상품</a></ul>
                    <ul class="goods1"><a href="#">Leather</a></ul>
                    <ul class="goods1"><a href="#">Blazer</a></ul>
                    <ul class="goods1"><a href="#">Outers</a>
                    <li>자켓</li>
                    <li>레더</li>
                    <li>코트</li>
                    </ul>
                </li>
              
                <li><a href="#">LookBook</a></li>
                <li><a href="#">About</a></li>
                <li id="board1"><a href="#">Board</a>
                    <ul class="board"><a href="#">Notice</a></ul>
                    <ul class="board"><a href="#">Q&A</a></ul>
                    <ul class="board"><a href="#">Review</a></ul>
                </li>
                </ul>
            </nav>
            
            <nav id="nav2" class="flex-container">
            <% if(uID == null){ /* 로그인 안되있을때 */ %>
                <ul><a href="../Account/Login.jsp">Login</a></ul>
                <ul><a href="../Account/Join.jsp">Account</a></ul>
			<%  }
            
            else if(uID !=null && authority.equals("user")){ %> <!-- 로그인이 되있을때 -->
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
                <ul><a href="#">Cart</a></ul>
			<% } 
            else if(uID !=null && authority.equals("admin")){
			%>
			<p>안녕하세요 <%=uID %>님! 관리자 권한입니다!</p>
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
				<ul><a href="../GoodsUpload/OrderShow.jsp">OrderManagement</a></ul>
				<ul><a href="../GoodsUpload/GoodsUpload.jsp">GoodsUpload</a></ul>
			<% } %>
                <ul id="search1"><a href="#">Search</a>
                    <li class="search2"><input type="text" placeholder="검색어를 입력해주세요"><a href="#" id="searcha">검색</a></li>
                </ul>
            </nav>
        </header>
        </div>
</body>
</html>