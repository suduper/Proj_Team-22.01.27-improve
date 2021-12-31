<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_review.*"
    %>
    <%
    request.setCharacterEncoding("utf-8");
    
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("nowPage");
    
    ReviewBean bean = (ReviewBean)session.getAttribute("bean");
    String subject = bean.getSubject();
    String uName = bean.getuName();
    String content = bean.getContent();
    
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Review Update</title>
    <link rel="stylesheet" href="../style/style_Update.css">
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
                    <li class="board"><a href="#">Notice</a></li>
                    <li class="board"><a href="#">Q&A</a></li>
                    <li class="board"><a href="#">Review</a></li>
                </ul>
            </nav>
             
            <nav id="nav2" class="flex-container">
                <ul><a href="#">Login</a></ul>
                <ul><a href="#">Account</a></ul>
                <ul><a href="#">Cart</a></ul>
                <ul id="search1"><a href="#">Search</a>
                    <li class="search2"><input type="text" placeholder="검색어를 입력해주세요"><a href="#" id="searcha">검색</a></li>
                </ul>
                
            </nav>
            

        </header>
        
        <div id="mod">
        
        <h3>REVIEW</h3>
<br><br>
<form action="ReviewUpdateProc.jsp" method="Post" id="UpdateFrm" enctype="multipart/form-data" name="UpdateFrm">

<table id="center">
	<tbody>
		<tr>
			<td>
			<input type="text" name="subject" placeholder="<%=subject %>>"  size = "80" id="subject">
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="uName" placeholder="<%=uName %>" size = "80" id="uName">
			</td>
		</tr>
		<tr>
			<td>
			<input type="email" name="email" placeholder="이메일" size = "80" id="email">
			</td>
		</tr>
		<tr>
			<td>
			<textarea rows="30" cols="79" name="content" size="80" di="content">
			<%=content %>
			</textarea>
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="file" placeholder="파일 선택" size = "71" id="fileName" readonly>
			<input type="file" name="file" id="file"><label for="file">첨부하기</label>
			</td>
		</tr>
		<tr>
			<td>
			<input type="password" name="pass" placeholder="비밀번호" size = "80"  id="pass">
			</td>
		</tr>
		<tr>
			<td>
			<button type="button" id="cancel" class="modBtn" onclick="history.back()">취소</button>
			<button type="button" id="regBtnMod" class="modBtn">등록하기</button>
			</td>
		</tr>
	</tbody>
</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="num" value="<%=num%>" id="num">
				
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Review.js"></script>
</body>
</html>