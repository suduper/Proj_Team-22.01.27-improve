<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_goods.GoodsProc"%>
<%@ page import="pack_goods.Goods" %>

<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.NumberFormat"%>

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
	
	NumberFormat money = NumberFormat.getNumberInstance();
	
	String goodsNameParam = (String)request.getParameter("goodsName");
	
	goods.upCount(goodsNameParam);
	Goods view =goods.getGoodsView(goodsNameParam);
	     
	int goodsnum = view.getGoodsNum(); // 상품 번호
	
	String goodsName = view.getGoodsName(); // 상품 이름
	int NL = goodsName.length(); // Name Length = 서버내 상품이름길이
	int TL = NL - 11;                   // True length = 서버내 상품이름에서 날짜 빼기
	String showName = goodsName.substring(0,TL); // 표기할 상품명 생성
	String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
	byte[] getName = showName.getBytes(); //바이트로 변환
	String tloc = encoder.encodeToString(getName); //인코딩
	tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
	
	String goodsWarehousing = view.getGoodsWarehousing(); // 상품 입고일
	String goodsType = view.getGoodsType(); // 상품 종류
	
	int Price = view.getGoodsPrice();
	if(view.getGoodsSPrice() != 0){
		Price = view.getGoodsSPrice();
	}
	String sellPrice = money.format(view.getGoodsPrice());
	String sellSPrice = money.format(view.getGoodsSPrice());
	
	
	String goodsThumbnail = view.getGoodsThumbnail(); // 상품 썸네일 이름
	
	String goodsImages =view.getGoodsImages(); // 상품 이미지 이름
	String[] imgArray = goodsImages.split(" / ");
	int imgL = imgArray.length;
	
	String goodsContent = view.getGoodsContent(); // 상품 내용
	String regDate = view.getRegDate();// 상품 등록일
	int wCount = view.getwCount();// 상품 조회수
	
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
<link rel="stylesheet" href="../style/style_goods.css">
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap" ><!-- div#wrap -->

	<div id="Content"><!-- div#Content ///////////////////-->
	
		<div id="Thumb_and_info"><!-- 상품 썸네일 및 정보 시작 //////////////////////////////-->
			
			<!-- 썸네일 영역 -->
			<div id="thumbImg">
				<img id="thumb" src="../Resource/GoodsImg/<%=tloc%>/thumb/thumb_<%=view.getGoodsThumbnail() %>" alt="thumbnail" />
			</div>
			<!-- 썸네일 영역 -->
			
			<!-- 메인컨텐츠 영역 -->
			<div id="mainContent">
			
				<h2 id="ViewH2"><%=showName %></h2>
				<hr />
				<!-- 테이블 영역 -->
				<table id="ViewInfoTable">
					<tbody>
						<tr>
							<td>상품 종류 : <%=goodsType %></td>
							<td>입고일 : <%=goodsWarehousing %></td>
						</tr>	
						<% if(view.getGoodsSPrice() != 0){ %>
						<tr>
							<td style="text-decoration: line-through;">가격 : </td>
							<td style="text-decoration: line-through;font-size: 25px;"><%=sellPrice%>원</td>
						</tr>
						<tr>
							<td>세일 가격 : </td>
							<td><span id="discount"><%=sellSPrice%>원</span> (<%=discount %>원 할인)</td>
						</tr>
						<% } else { %>
						<tr>
							<td>가격 : </td>
							<td style="font-size: 25px;"><%=sellPrice%>원</td>
						</tr>
						<% } %>
						<tr>
							<td>배송정보</td>
							<td id="WhenArrive">지금 주문시 <span id="arriveDate"></span> 발송</td>
						</tr>
					</tbody>
				</table>
				<!-- 테이블 영역 -->
				
				<div id="ViewContent">
					<%=goodsContent %>
				</div>
				
				<hr />
				
				<div id="reg_and_wCount">
					<span id="ViewRegDate_wCount"><%="등록일 : " + regDate %>&nbsp/&nbsp<%="조회수 : " + wCount %></span>
				</div>
				
			</div>
			<!-- 메인컨텐츠 영역 -->
		
		</div><!-- 상품 썸네일 및 정보 끝 //////////////////////////////-->
		
		<hr id="crossLine"/>
		
		<div id="Img_and_buyOption"><!-- Img_and_buyOption -->

			<div id="goodsImgZone"><!-- 상품 이미지 시작 //////////////////////////////-->
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
			</div><!-- 상품 이미지 끝 //////////////////////////////-->
			
			
			<!-- 상품 구매옵션 시작 -->
			<div id="buyOption">
				<!-- 옵션 영역-->
				<div id="watchOption">
					<!-- 옵션 / 사이즈 -->
					<div id="size">
						<p id="sizeNotice">사이즈 & 갯수</p>
						<hr />
						<%if(view.getInventoryS() != 0) {%>
						<p id="PS" onclick="choice('S','<%=Price %>')">S 사이즈 (재고 :<%=view.getInventoryS()%>)</p>
						<span id="addS"></span>
						<%} %>
						
						<%if(view.getInventoryM() != 0) {%>
						<p id="PM" onclick="choice('M','<%=Price %>')">M 사이즈 (재고:<%=view.getInventoryM()%>)</p>
						<span id="addM"></span>
						<%} %>
						
						<%if(view.getInventoryL() != 0) {%>
						<p id="PL" onclick="choice('L','<%=Price %>')">L 사이즈 (재고:<%=view.getInventoryL()%>)</p>
						<span id="addL"></span>
						<% } %>
						
						<% if(view.getInventoryXL() != 0) {%>
						<p id="PXL" onclick="choice('XL','<%=Price %>')" >XL 사이즈 (재고:<%=view.getInventoryXL()%>)</p>
						<span id="addXL"></span>
						<% } %>
						
					</div>
					<!-- 옵션 / 사이즈 -->
					
					<!-- 장바구니로 보내는 내용 -->
					<div id="addBasket_Content">
						<form action="GoodsAddBasketProc.jsp" id="addBasket" target="param">
							<input type="hidden" name="Allcount" id="Allcount" value=""/>
							<input type="hidden" name="calcRes" id="calcRes" value=""/>
							<!-- 계산 -->
							<div id="calc">
								<p>전체 갯수</p>
								<p><input type="text" name="SAllcount" id="SAllcount" value="" readonly="readonly" /><span>개</span></p>
								<hr />
								<p>전체 가격</p>
								<p><input type="text" name="ScalcRes" id="ScalcRes" value="" readonly="readonly" /><span>원</span></p>
							</div>
							<!-- 계산 -->
							
							<!-- !보이지않는! 보내는내용 -->
							<div id="goAddBasket">
								uID<input type="text" name="uID" id="uID" value="<%=uID%>" readonly="readonly"/>
								goodsName<input type="text" name="goodsName" id="goodsName" value="<%=goodsName %>" readonly="readonly"/>
								S: <input type="text" name="Scount" id="Scount" value="" readonly="readonly"/>
								M: <input type="text" name="Mcount" id="Mcount" value="" readonly="readonly"/>
								L: <input type="text" name="Lcount" id="Lcount" value="" readonly="readonly"/>
								XL : <input type="text" name="XLcount" id="XLcount" value="" readonly="readonly"/>
							</div>
							<!-- !보이지않는! 보내는내용 -->
							
							<p id="addBasket_btn" onclick="addBasket()">옷바구니에 담기</p>
						</form>
						<iframe id="if" name="param" style="display: none"></iframe>
					</div>
					<!-- 장바구니로 보내는 내용 -->	
				</div>
				<!-- 옵션 영역-->
				
				<!-- 내 옵션 -->
				<div id="myOption">
				<hr />
					<ul>
						<% if(uID != null){ %>
						<li><a href="MyBasket.jsp">내 옷바구니</a></li>
						<li><a href="BuyList.jsp">내 구매목록</a></li>
						<% } %>
						<li><a href="../Review/ReviewList.jsp">리뷰보기</a></li>
					</ul>
					<hr />
				</div>
				<!-- 내 옵션 -->
			</div>
			<!-- 상품 구매옵션 끝 -->
			
		</div><!-- Img_and_buyOption -->
		
	</div><!-- div#Content ///////////////////-->
	
	<div id="userOption"><!-- 사용자 옵션 -->
	<hr id="crossLine"/>
		<% if(authority.equals("admin")){ %>
		<button type="button" id="goodsUpdate" onclick="forUpdate('<%=goodsName%>')"> 상품 정보 수정</button>
		<button type="button" id="delBtn">상품 삭 제</button>
		<% } %>
		<button type="button" id="listBtn">상품 리스트</button>
		<button type="button" id="replyBtn">상품 리 뷰</button>
	</div><!-- 사용자 옵션 -->
	
</div><!-- div#wrap -->

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_GoodsView.js"></script>
</body>
</html>