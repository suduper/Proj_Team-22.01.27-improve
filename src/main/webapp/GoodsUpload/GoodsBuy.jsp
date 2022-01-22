<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="pack_goods.GoodsProc"%>
<%@ page import="pack_goods.Goods" %>
<%@ page import="pack_user.User" %>
<%@ page import="pack_user.UserDAO" %>
  
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>


<jsp:useBean id="user" class="pack_user.UserDAO"  scope="page" />
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
<%request.setCharacterEncoding("UTF-8"); %>

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


<% 
	Encoder encoder = Base64.getEncoder();
	Decoder decoder = Base64.getDecoder();
	
	NumberFormat money = NumberFormat.getNumberInstance();
	
	int listSize = Integer.parseInt(request.getParameter("count"));
	
	String uID=request.getParameter("uID");
	
	User info = user.userInfo(uID);
	
	int sum = 0;
	int sendCount= 0;
	String goodsName = null;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BuyProc</title>
</head>
<link rel="stylesheet" href="../style/style_goods.css">
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
	
	<div id="BuyList"><!-- BuyList -->
		<table id="GoodsBuyTable">
			<tbody>
				<%
				for(int i = 0 ; i <listSize ; i++){
					String val = request.getParameter("buyThis"+i);
					if(val != null){
						sendCount ++;
						String[] valSplit = val.split(" / ");
						String addDate = valSplit[0];
						String Split_goodsName = valSplit[1];
						goodsName = Split_goodsName;
						int Scount = Integer.parseInt(valSplit[2]);
						int Mcount = Integer.parseInt(valSplit[3]);
						int Lcount = Integer.parseInt(valSplit[4]);
						int XLcount = Integer.parseInt(valSplit[5]);
						int eachPay = Integer.parseInt(valSplit[6]);
						int Allcount = Scount + Mcount + Lcount + XLcount;
						Goods view =goods.getGoodsView(Split_goodsName);
						int NL = Split_goodsName.length(); //NameLength = 서버내 상품이름길이
						int TL = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
						String showName = Split_goodsName.substring(0,TL); //표기할 상품명 생성
						String dates = Split_goodsName.substring(TL,NL); // 상품 등록 날짜
						byte[] getName = showName.getBytes();//바이트로 변환
						String tloc = encoder.encodeToString(getName);//인코딩
						tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
						String buyCost = money.format(eachPay);
				%>
				<tr>
					<td id="showThumb">
						<img id="BuyThumb" src="../Resource/GoodsImg/<%=tloc %>/thumb/thumb_<%=view.getGoodsThumbnail() %>" />
					</td>
					<td><span id="goodsName"><%=showName %></span></td>
					<td id="Sizes">
						<span>S : <%=Scount %></span><br />
						<span>M : <%=Mcount %></span><br />
						<span>L : <%=Lcount %></span><br />
						<span>XL : <%=XLcount %></span><br />
					</td>
					<td> <%=Allcount %> <span>개</span></td>
					<td> <%=buyCost %> <span>원</span></td>
				</tr>
				<%
						sum += eachPay;
					}
				}
				%>
			</tbody>
		</table>
	</div><!-- BuyList -->
	
	<hr id="crossLine" />
	
	<div id="sendInfo"><!-- sendInfo -->
		<form action="BuyProc.jsp?sendCount=<%=sendCount %>" method="post" id="BuyFin">
		<%
		for(int i = 0; i <listSize; i++){
			String val = request.getParameter("buyThis"+i);
			if(val != null){
		%>
			<input type="hidden" name="buyThis<%=i%>" id="buyThis<%=i%>" value="<%=request.getParameter("buyThis"+i)%>"/>
		<%
			}
		}  
		%>
		<input type="hidden" name="sum" id="sum" value="<%=sum%>"/>
		<input type="hidden" name="uID" id="uID" value="<%=uID %>" />
		<p>받는사람 : <input type="text" name="who" id="who" value="<%=uID %>" placeholder="받는분 이름" style="width: 100px"/></p>
		<p>결제금액 : <span id="AllBuyCost"><%=money.format(sum) %></span> 원</p>
		<p>배송지<input type="checkbox" name="ZipChange" id="ZipChange" onclick="changeZip()"/><span id="small">(배송지 변경)</span></p>
		<p>
			<input type="text" name="Zip" id="Zip" value="<%=info.getuZip() %>" readonly="readonly"/>
			<span id="changeZip" onclick="kakaopost()" style="background-color: #D9D9D9">우편주소</span>
		</p> 
		<p><input type="text" name="Addr1" id="Addr1" value="<%=info.getuAddr1() %>" readonly="readonly"/></p>
		<p><span id="rest">나머지 주소:</span><input type="text" name="Addr2" id="Addr2" value="<%=info.getuAddr2() %>"/></p>
		<p>받는사람 전화번호 : <input type="text" name="phone" id="phone" value="전번"/></p> 
		<p>배송 전달 사항 : <input type="text" name="notice" id="notice" /></p>
		</form>
	</div><!-- sendInfo -->
	
	<div id="buy"><!-- buy -->
		<ul>
			<li><span onclick="Purchase('<%=uID%>',<%=sum%>)">구매 하기</span></li>
		</ul>
	</div><!-- buy -->
	
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
	
</div><!-- wrap -->



<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_HeaderFooter.js"></script>
<script src="../script/script_MyBasket.js"></script>


<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function kakaopost() {
    new daum.Postcode({
        oncomplete: function(data) {
           document.querySelector("#Zip").value = data.zonecode;
           document.querySelector("#Addr1").value = data.address;
        }
    }).open();
}
</script>
<!--  카카오 우편번호 예제끝-->
</body>
</html>