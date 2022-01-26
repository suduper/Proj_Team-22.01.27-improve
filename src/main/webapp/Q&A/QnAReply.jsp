<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <jsp:useBean id="bean" class="pack_QnA.QnABean" scope="session" />
    
    <%
    request.setCharacterEncoding("utf-8");
    int num = Integer.parseInt(request.getParameter("num"));
    
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord");

    String nowPage = request.getParameter("nowPage");
    String uName = bean.getuName();
    String subject = bean.getSubject();
    String content = bean.getContent();
    String ref = String.valueOf(bean.getRef());
    String depth = String.valueOf(bean.getDepth());
    String pos = String.valueOf(bean.getPos());
    
    %>  
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QnA</title>
    <link rel="stylesheet" href="../style/style_post.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
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


<div id="QnA">
<h4>QnA</h4>
<br><br>
<form action="QnAReplyProc.jsp" method="get" id="replyFrm" name="replyFrm">

<table id="center">
	<tbody>
		<tr>
			<td>
			<input type="text" name="subject" value="<%=subject %>"  size = "80" id="subject">
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="uName" value="<%=uID %>" size = "80" id="uName">
			</td>
		</tr>
		<tr>
			<td>
			<textarea rows="30" cols="79" name="content" size="80" di="content"></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<button type="button" id="cancel" class="pBtn" onclick="history.back()">취소</button>
			<button type="button" id="replySubBtn" class="pBtn">등록하기</button>
			</td>
		</tr>
	</tbody>
</table>
				<input type="hidden" name="num" value="<%=num%>" id="num">				
				
				<input type="hidden" name="ref" value="<%=ref%>">				
				<input type="hidden" name="depth" value="<%=depth%>">				
				<input type="hidden" name="pos" value="<%=pos%>">
				
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
				
				<input type="hidden" name="keyField" id="keyField" value="<%=keyField%>">
				<input type="hidden" name="keyWord" id="keyWord" value="<%=keyWord%>">
</form>


</div>

</div>

<%@include file="../Main/Main_Bottom.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_QnA.js"></script>
</body>
</html>