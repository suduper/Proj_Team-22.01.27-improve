<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8"); %>
 
<%@page import="java.io.PrintWriter"%>
  
<%
	String uID = null;
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID"); 
	} 
	String authority = null;
	if(session.getAttribute("authority").equals("admin")){ 
		authority = (String)session.getAttribute("authority");		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsUpload</title>
<link rel="stylesheet" href="../style/style_GoodsUpdate&Upload.css">
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
			<p>안녕하세요<br><%=uID %>님! 관리자 권한입니다!</p>
				<ul><a href="../Account/LogoutAction.jsp">LogOut</a></ul>
				<ul><a href="../GoodsUpload/GoodsUpload.jsp">GoodsUpload</a></ul>
			<% } %>
                <ul id="search1"><a href="#">Search</a>
                    <li class="search2"><input type="text" placeholder="검색어를 입력해주세요"><a href="#" id="searcha">검색</a></li>
                </ul>
                
            </nav>
            

        </header>
        
        
	<hr id="crossLine" />
	<form action="GoodsUploadProc.jsp" method="post" id="send" enctype="multipart/form-data">
		
		<div id="InputInfo"><!-- <div id="InputInfo"> -->
		
			<div id="Gcontents">
				<h2>상품 내용</h2>
				<div id="write" contenteditable="true" spellcheck="true" ></div>
				<div id="hider">
					<textarea name="goodsContent" id="goodsContent" placeholder="테스트"></textarea> 
				</div>
			</div>
			
			<div id="must">
				<div id="goodsTextInfo"><!-- goodsTextInfo -->
					<div id="NIT">
						<span id="InfoSpan">상품명 : <input type="text" name="goodsName" id="goodsName" /></span>
						<span id="InfoSpan">상품 입고일 : <input type="text" name="goodsWarehousing" id="goodsWarehousing" placeholder="yy.mm.dd"/></span>
						<span id="InfoSpan">
							상품 종류 : 
							<select name="goodsType" id="goodsType">
								<option value='1' selected>-- 선택 --</option>
			  					<option value='정장'>정장</option>
			  					<option value='패딩'>패딩</option>
			  					<option value='기타'>기타</option>
							</select>
						</span>
					</div>
					
					<div id="priceArea">
						<p id="Price" >상품 판매 가격 : <input type="number" name="goodsPrice" id="goodsPrice" 
							  	   							maxlength="7" min="1000" max="9999999"/></p>
						<p id="SPrice">상품 세일 가격 : <input type="number" name="goodsSPrice" id="goodsSPrice"  
								   							maxlength="7" min="1000" max="9999999"/><span id="SPriceNotice">미입력시 세일가격은 0원입니다.</span>
						</p>
						
					</div>
				</div> <!-- goodsTextInfo -->
			
				<div id="inventoryList"> <!-- inventoryList -->
					<table id="inventory">
						<tbody>
							<tr>
								<td>S 사이즈 재고 : <input type="number" name="inventoryS" id="inventoryS" max="999" value="0"/></td>
								<td>M 사이즈 재고 : <input type="number" name="inventoryM" id="inventoryM" max="999" value="0"/></td>
								<td>L 사이즈 재고 : <input type="number" name="inventoryL" id="inventoryL" max="999" value="0"/></td>
								<td>XL 사이즈 재고 : <input type="number" name="inventoryXL" id="inventoryXL" max="999" value="0"/></td>
							</tr>
						</tbody>
					</table>
				</div> <!-- inventoryList -->
			</div>
		</div><!-- <div id="InputInfo"> -->
		
		<hr id="crossLine" />
		
		<div id="resetbtnArea">
			<p id="reset">전체 이미지 재선택</p>
		</div>
		
		<div id="GoodsUpload_Imgs"> <!--GoodsUpload_Imgs-->
		
			<div id="GoodsUploadThumb">
				<h2>썸네일</h2>
							
				 <div id="Thumb_drop">
					<div id="Preview_Thumb"></div>
					<p id="T_here">drag & drop</p>
				</div>
				
				<span id="or">or</span><br />
				<input type="file" id="goodsThumbnail" name="goodsThumbnail" multiple="multiple" accept='.png, .jpg' required="required"/>
			</div>
			
			<div id="GoodsUploadImg">
				<h2>상품 이미지</h2>
				
				 <div id="Img_drop">
					<div id="Preview_Img"></div>
					<p id="I_here">drag & drop</p>
				</div>
				 
				<span id="or">or</span><br />
				<input type="file" id="goodsImages" name="goodsImages" multiple="multiple" accept='.png, .jpg' required="required">
			</div>
		</div> <!--GoodsUpload_Imgs-->
		
	</form>
	<hr id="crossLine" />
	<p id="btnSubmit">업로드</p>
	
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
<script src="../script/script_GoodsUpload.js"></script>

</body>
</html>