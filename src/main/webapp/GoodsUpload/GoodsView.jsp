<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_goods.GoodsProc"%>
<%@ page import="pack_goods.Goods" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
    
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
    

<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
     
<% request.setCharacterEncoding("UTF-8");%>
<%
String uID = null; 
if(session.getAttribute("uID") != null){
	uID = (String)session.getAttribute("uID"); 
} else {
	uID = null;
}

String authority = null;
if(session.getAttribute("authority") != null){  
	if(session.getAttribute("authority").equals("admin")){
		authority = (String)session.getAttribute("authority");
	}
	if(session.getAttribute("authority").equals("user")){
		authority = (String)session.getAttribute("authority");
	}
} 
if(session.getAttribute("authority") ==null){
	authority = "not_Login";
}

Encoder encoder = Base64.getEncoder();
Decoder decoder = Base64.getDecoder();

String goodsNameParam = (String)request.getParameter("goodsName");

goods.upCount(goodsNameParam);
Goods view =goods.getGoodsView(goodsNameParam);
     
int goodsnum = view.getGoodsNum(); 			// 상품 번호

String goodsName = view.getGoodsName(); // 상품 이름
int NL = goodsName.length();	 				// Name Length = 서버내 상품이름길이
int TL = NL - 11;                  					 // True length = 서버내 상품이름에서 날짜 빼기
String showName = goodsName.substring(0,TL); 	// 표기할 상품명 생성
String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
byte[] getName = showName.getBytes(); //바이트로 변환
String tloc = encoder.encodeToString(getName); //인코딩
tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
	
String goodsWarehousing = view.getGoodsWarehousing();
String goodsType = view.getGoodsType(); 	// 상품 종류
int goodsPrice = view.getGoodsPrice(); 		// 상품 판매 가격
int goodsSPrice = view.getGoodsSPrice(); 	// 상품 세일 가격
int sellPrice = 0;
if(goodsSPrice != 0){
	sellPrice = goodsSPrice;
} else {
	sellPrice = goodsPrice;
}

String goodsThumbnail = view.getGoodsThumbnail(); 	// 상품 썸네일 이름

String goodsImages =view.getGoodsImages(); 	// 상품 이미지 이름
String[] imgArray = goodsImages.split(" / ");
int imgL = imgArray.length;

String goodsContent = view.getGoodsContent(); 	// 상품 내용
String regDate = view.getRegDate();			// 상품 등록일
int wCount = view.getwCount();				// 상품 조회수

int discount = view.getGoodsPrice() - view.getGoodsSPrice();

int BasketCount = goods.BasketCount(uID);

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsView</title>
<style>
img#thumb {
	width: 600px;
	height: 600px;
	object-fit: contain;
}
img#gImg {
	width: 600px;
	height: 600px;
	object-fit: contain;
	background-color: #888;
}
div#Content {
	border: 2px solid #000;
}
div#goodsShow {
	border: 1px solid #000;
	display: flex;
}
span#arriveDate {
	font-weight: bold;
}
p#result{
	border: 1px solid #000;
	width: 40px;
	height: 40px;
	line-height: 40px;
	text-align: center;
}
p#plus {
	border: 1px solid #000;
	width: 40px;
	height: 40px;
	line-height: 40px;
	text-align: center;
}
p#minus {
	border: 1px solid #000;
	width: 40px;
	height: 40px;
	line-height: 40px;
	text-align: center;
}
.no-drag {
	-ms-user-select: none; 
	-moz-user-select: -moz-none; 
	-webkit-user-select: none; 
	-khtml-user-select: none; 
	user-select:none;
}
div#size > p{
	width : 200px;
	height : 30px;
	border: 1px solid #000;
	text-align: center;
	line-height: 30px;
}
input#origPrice {
	text-align: center;
	border: none;
	font-size: 16px;
	width: 60px;
	height: 20px;
	line-height: 20px;
	border: 1px solid #000;
}
p#addBasket_btn {
	border: 1px solid #000;
	width: 150px;
	height: 40px;
	font-size: 20px;
	line-height: 40px;
	text-align: center;
}
div#calc > input{
	text-align: center;
	border: none;
	font-size: 16px;
	width: 60px;
	height: 20px;
	line-height: 20px;
	border: 1px solid #000;
}
div#buyOption {
	border: 2px solid #00f;
	width: 500px;
	display: flex;
}
div#goAddBasket {
	border: 1px dotted #f00;
	display: none;
}
div#watchOption {
	border: 1px solid #f0f;
}
div#myOption{	
	margin-left: 10px;
	border: 1px solid #f05;
}

</style>
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<%=authority %>
<%=BasketCount %>

<div id="wrap">
	
	<div id="Content">
	
		<!-- 상품 썸네일 및 정보 시작 -->
		<div id="goodsShow">
		
		
			
			<div id="thumImg">
				<img id="thumb" src="../Resource/GoodsImg/<%=tloc%>/thumb/thumb_<%=view.getGoodsThumbnail() %>" alt="thumbnail" />
			</div>	
			
			<div id="mainContent">
			
				<h2><%=showName %></h2>
				
				<table>
					<tbody>
						<tr>
							<td>상품 종류 : </td>
							<td><%=goodsType %></td>
							<td>입고일 : </td>
							<td><%=goodsWarehousing %></td>
						<tr>
							<td>등록일 : </td>
							<td><%=regDate %> </td>
						</tr>
							<%
							if(goodsSPrice != 0){
							%>
						<tr>
							<td>가격 : </td>
							<td style="text-decoration: line-through;"><%=goodsPrice%>원</td>
						</tr>
						<tr>
							<td>세일상품입니다. </td>
						</tr>
						<tr>
							<td>
								<p>세일 가격 : </p>
								<input type="text" id="origPrice" value="<%=goodsSPrice%>" />
								<span id="discount">원 (<%=discount %>원 할인)</span>
							</td>
						</tr>
						
						
							<%
							} else {
							%>
							
						<tr>
							<td>가격 : </td>
							<td><input type="text" id="origPrice" value="<%=goodsPrice%>" /></td>
						</tr>
							<%
							}
							%>
						<tr>
							<td>배송정보</td>
							<td id="WhenArrive">지금 주문시 <span id="arriveDate"></span> 발송</td>
						</tr>
						<tr>
							<td><%=goodsContent %></td>
						</tr>
						<tr>
							<td><%="조회수 : " + wCount %></td>
						</tr>
					</tbody>
				</table>
				
			</div>
				<!-- 상품 구매옵션 시작 -->
	<div id="buyOption">
	
		<div id="watchOption">
			<div id="size">
				<p>사이즈 & 갯수</p>
				
				<%if(view.getInventoryS() != 0) {%>
				<p id="PS" onclick="choice('S','<%=sellPrice %>')">S 사이즈 (재고 :<%=view.getInventoryS()%>)</p>
				<span id="addS"></span>
				<%} %>
				
				<%if(view.getInventoryM() != 0) {%>
				<p id="PM" onclick="choice('M','<%=sellPrice %>')">M 사이즈 (재고:<%=view.getInventoryM()%>)</p>
				<span id="addM"></span>
				<%} %>
				
				<%if(view.getInventoryL() != 0) {%>
				<p id="PL" onclick="choice('L','<%=sellPrice %>')">L 사이즈 (재고:<%=view.getInventoryL()%>)</p>
				<span id="addL"></span>
				<%} %>
				
				<%if(view.getInventoryXL() != 0) {%>
				<p id="PXL" onclick="choice('XL','<%=sellPrice %>')" >XL 사이즈 (재고:<%=view.getInventoryXL()%>)</p>
				<span id="addXL"></span>
				<%} %>
				
			</div>
		
			<!-- 보내는 내용 -->
			<div id="addBasket_Content">
				<form action="GoodsAddBasketProc.jsp" id="addBasket" target="param">
				
					<div id="calc">
						<p>전체 갯수 : </p>
						<input type="text" name="Allcount" id="Allcount" value="" readonly="readonly"/>
						<span>개</span>
						<p>전체 가격 : </p>
						<input type="text" name="calcRes" id="calcRes" value="" readonly="readonly"/>
						<span>원</span>
					</div>
					
					<div id="goAddBasket">
						uID<input type="text" name="uID" id="uID" value="<%=uID%>" readonly="readonly"/>
						goodsName<input type="text" name="goodsName" id="goodsName" value="<%=goodsName %>" readonly="readonly"/>
						S: <input type="text" name="Scount" id="Scount" value="" readonly="readonly"/>
						M: <input type="text" name="Mcount" id="Mcount" value="" readonly="readonly"/>
						L: <input type="text" name="Lcount" id="Lcount" value="" readonly="readonly"/>
						XL : <input type="text" name="XLcount" id="XLcount" value="" readonly="readonly"/>
					</div>
		
					<p id="addBasket_btn" onclick="addBasket()">옷바구니에 담기</p>
				</form>
				<iframe id="if" name="param" style="display: none"></iframe>
			</div>
			<!-- 보내는 내용 -->
		</div>
		<div id="myOption">
		<ul>
			<%
			if(uID != null){
			%>
			<li>
				<a href="MyBasket.jsp">내 옷바구니</a>
			</li>
			<%
			}
			%>
			<li><a href="../Review/ReviewList.jsp">리뷰보기</a></li>
			<li><a href="#">옵션1</a></li>
			<li><a href="#">옵션2</a></li>
			<li><a href="#">옵션3</a></li>
		</ul>
		</div>
	</div>
	<!-- 상품 구매옵션 끝 -->
			
		</div>
		<!-- 상품 썸네일 및 정보 끝 -->
		
		<!-- 상품 이미지 시작 -->
		<div id="goodsImgZone">
			<table>
					<tbody>
					<%for(int i = 0 ; i < imgL ; i++){ %>
						<tr>
							<td>
								<img id="gImg" src="../Resource/GoodsImg/<%=tloc %>/<%=imgArray[i] %>"/>
							</td>
						</tr>
					<%} %>
					</tbody>
				</table>
		</div>
		<!-- 상품 이미지 끝 -->
		

	</div>
	
	<div id="userOption">
			<%
			if(authority.equals("admin")){
			%>
			<button type="button" id="listBtn">리스트</button>
			<button type="button" id="replyBtn">답 변</button>
			<button type="button" id="goodsUpdate" onclick="forUpdate('<%=goodsName%>')">수 정</button>
			<button type="button" id="delBtn">삭 제</button>
			<% 
			} else {
			%>
			<button type="button" id="listBtn">리스트</button>
			<button type="button" id="replyBtn">답 변</button>
			<% 
			} 
			%>
		</div>
</div>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_GoodsView.js"></script>
</body>
</html>