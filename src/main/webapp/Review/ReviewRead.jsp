<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pack_review.ReviewBean"%>
    
    <jsp:useBean id="rMgr" class="pack_review.ReviewMgr" scope="page"/>
    
    <%
    request.setCharacterEncoding("utf-8");
    
    String uID = null;
    if(session.getAttribute("uID") != null){
    	uID = (String)session.getAttribute("uID"); 
    	} 
    String authority = null;
    if(session.getAttribute("authority") != null){ 
    	authority = (String)session.getAttribute("authority"); 
    	}
    
    int numParam = Integer.parseInt(request.getParameter("num"));
    
    String keyField = request.getParameter("keyField");
    String keyWord = request.getParameter("keyWord");
    
    ReviewBean bean = rMgr.getReview(numParam);
    
    String nowPage = request.getParameter("nowPage");
    
    int num = bean.getNum();
    
    String uName = bean.getuName();
    String subject = bean.getSubject();
    String content = bean.getContent();
    String email = bean.getuEmail();
    
    int pos = bean.getPos();
    int ref = bean.getRef();
    int depth = bean.getDepth();
    String regData = bean.getRegDate();
    String pass = bean.getPass();
    String fileName = bean.getFileName();
    double fileSize = bean.getFileSize();
    String fUnit = "Bytes";
    if(fileSize>1024){
    	fileSize /= 1024;
    	fUnit = "KBytes";
    }
    
    String ip = bean.getIp();
    
    session.setAttribute("bean", bean);
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>REVIEW</title>
    <link rel="stylesheet" href="../style/style_Read.css">
</head>
<body>

<div id="wrap">

    <!-- HTML템플릿(Template, Templet) 헤더 시작 -->

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

<!-- HTML템플릿(Template, Templet) 헤더 끝 -->

<main id="main">
<table id = "read">
	<tbody>
		<tr>
			<td class="rContent"><span>제목</span><span><%=subject %></span></td>
		</tr>
		<tr>
			<td class="rContent"><span>작성자</span><span><%=uName %></span></td>
		</tr>
		<tr>
			<td id="readContents" >
			
			<div id="readContent">
			
			<img src="../Resource/ReviewImg/1234/<%=fileName%>" width="auto" height="auto" alt="">
			<textarea name="txtArea" id="txtArea" cols="30" rows="10" readonly><%=content %></textarea>
			
			</div>
			
			</td>
		</tr>
	</tbody>
</table>

<button type="button" id="listBtn" class="reviewBtn">리스트</button>
<button type="button" id="modBtn"  class="reviewBtn">수정</button>
<button type="button" id="delBtn"  class="reviewBtn">삭제</button>

			<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
			<input type="hidden" name="num" value="<%=num%>" id="num">
			<input type="hidden" id="pKeyField" value="<%=keyField%>">
			<input type="hidden" id="pKeyWord" value="<%=keyWord%>">
			<input type="hidden" name="email" value="<%=email%>" id="email">


</main>

<!-- HTML템플릿(Template, Templet) 푸터 시작 -->
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
    <!-- HTML템플릿(Template, Templet) 푸터 끝 -->

</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Review.js"></script>
</body>
</html>