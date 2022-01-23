<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_review.ReviewBean"
    import="java.util.Vector"
    %>
    
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
    
    int totalRecord = 0; // 전체 레코드 
    int numPerPage = 5; // 페이지 당 레코드
    int pagePerBlock = 5; // 블럭 당 페이지
    
    int totalPage = 0;
    int totalBlock = 0;
    
    
    int nowPage = 1; // 현재 페이지
    int nowBlock = 1;// 현재 블럭
    
    int start = 0; // DB의 select 시작 번호
    int end = 5; // 시작번호로부터 가져올 select 수

    int listSize = 0; // 현재 읽어온 게시물 수
    
    String keyField = "";
    String keyWord = "";
    
    if (request.getParameter("keyWord") != null) {
    	keyField = request.getParameter("keyField");
    	keyWord = request.getParameter("keyWord");
    }
    
    if (request.getParameter("nowPage") != null) {
    	nowPage = Integer.parseInt(request.getParameter("nowPage"));
    	start = (nowPage * numPerPage) - numPerPage;
    	end = numPerPage;
    }
    
    totalRecord = rMgr.getTotalCount(keyField, keyWord);
    
    totalPage = (int)Math.ceil((double)totalRecord/numPerPage);
    nowBlock = (int)Math.ceil((double)nowPage/pagePerBlock);
    totalBlock = (int)Math.ceil((double)totalPage/pagePerBlock);
    
    Vector<ReviewBean> vList = null;
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="../style/style_List.css">
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

<main id="main">

<div id="top"><h4>REVIEW</h4></div>

<%
vList = rMgr.getReviewList(keyField, keyWord, start, end);
listSize = vList.size();
%>

<table id="rList">
	<tbody>
	<%
	if(vList.isEmpty()){
	%>
	<tr>
	<td colspan="3">
	<%= "리뷰가 없습니다." %>
	</td>
	</tr>
	<%}
	else{
	%> 
	
	<%
	for(int i = 0; i<listSize; i++){
		
		if(i==listSize) break;
		
		ReviewBean bean = vList.get(i);
		
		int num = bean.getNum();
		String subject = bean.getSubject();
		String uName = bean.getuName();
		String regDate = bean.getRegDate();
		String content = bean.getContent();
		String filename = bean.getFileName();
		String email = bean.getuEmail();
	
	%>
		<tr class="prnTr" >
			<td class="List" id="listNum" onclick="ReviewRead('<%=num%>', '<%=nowPage%>')"><%= num %></td>
						<td class="List">
			<%if(filename != null){ %>
			<img src="../Resource/ReviewImg/1234/<%=filename%>" alt="" width="90px" height="90px">
			<%} else{ 
			out.print("");
			}
			%>
			</td>
			<td class="List" id="listSub"><%= subject %>
			<br><br>
			<input type="text" placeholder="<%=content%>" readonly id="listContent" maxlength="20">
			</td>
			<td class="List" id="listName"><%= uName %></td>
		</tr>
		
		<%
		}
	}
		%>
		
		<tr>
			<td colspan="4"><button type="button" id="writeBtn" onclick="location.href='ReviewWrite.jsp'">리뷰 남기기</button></td>
		</tr>


		<tr>
		<td colspan="4" id="pagingTd">
		<%
		int pageStart = (nowBlock-1)*pagePerBlock+1;
		
		int pageEnd = (nowBlock<totalBlock) ?
				pageStart + pagePerBlock-1 : totalPage;
		
		if(totalPage != 0) {%>
		
		<%
		if(nowBlock>1){
		%>
		<span onclick="moveBlock('<%=nowBlock-1%>', '<%=pagePerBlock%>')">
		&lt;
		</span>
		<%} else{ %>
		<span></span>
		<% } %>
		
		<%
		for( ; pageStart<=pageEnd; pageStart++) {		%>
		<%
		if(pageStart == nowPage){%>
		<span class="mBtn" id="nowView" onclick="movePage('<%=pageStart%>')">
		<%=pageStart %>
		</span>
		<%} else{%>
		<span class="mBtn" onclick="movePage('<%=pageStart%>')">
		<%=pageStart %>
		</span>
		<%} %>
		<%} %>
		
		<%if(totalBlock>nowBlock) { %>
		<span onclick="moveBlock('<%=nowBlock+1%>', '<%=pagePerBlock%>')">
		&gt;
		</span>
		<%} else{ %>
		<span></span>
		<%} %>
		
	<%} %>
		
		</td>
		</tr>
	</tbody>
</table>

<div id="searchArea" class="flex-container">

<form name = "searchFrm" id="searchFrm">
	<select name="keyDate" id="keyDate">
		<option value="week">일주일</option>
		<option value="month">한달</option>
		<option value="threeMonth">세달</option>
		<option value="all">전체</option>
	</select>
	
	<select name="keyField" id="keyField">
		<option value="subject" <% if(keyField.equals("subject")) out.print("selected"); %>>제목</option>
		<option value="content" <% if(keyField.equals("content")) out.print("selected"); %>>내용</option>
		<option value="uName" <% if(keyField.equals("uName")) out.print("selected"); %>>작성자</option>
	</select>
	
	<input type="text" name="keyWord" id="keyWord" value="<%= keyWord%>">
	<button type="button" id="searchBtn">검색</button>
	</form>
</div>
	<input type="hidden" id="pKeyField" value="<%= keyField%>">
	<input type="hidden" id="pKeyWord" value="<%= keyWord%>">

</main>

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


	   
</div>

        
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Review.js"></script>
</body>
</html>