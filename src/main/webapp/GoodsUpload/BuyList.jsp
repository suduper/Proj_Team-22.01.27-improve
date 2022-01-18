<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_goods.GoodsProc"%>
<%@ page import="pack_goods.Goods" %>
<%@ page import="pack_goods.MyBasket" %>

<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
<%@ page import="java.io.*" %>

<%@ page import="java.io.PrintWriter"%>
<%@ page import="pack_goods.MyBasket, java.util.Vector" %>

<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />

<jsp:useBean id="SessionCheck" class="pack_goods.Goods" scope="page" />

<% request.setCharacterEncoding("UTF-8");%>

<%
	String uID = null; 
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID"); 
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 해주세요')");
		script.println("location.href='../Account/Login.jsp'");
		script.println("</script>");
	}
	
	int BasketCount = goods.BasketCount(uID);
	
	Vector<MyBasket> BuyList = null;
	
	int listSize = 0;
	
	Encoder encoder = Base64.getEncoder();
	Decoder decoder = Base64.getDecoder();
	
	NumberFormat money = NumberFormat.getNumberInstance();
	
	int sum = 0;
	String allBuyCost = null;
	String display = "no";
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BuyList</title>
</head>
<link rel="stylesheet" href="../style/style_goods.css">
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">
	<div id="BuyListContent">
	
		<h3 id="BuyListH3"><%=uID %> 님의 구매목록</h3>
		<%
			BuyList = goods.showBuyList(uID);
			listSize = BuyList.size();
			if(BuyList.isEmpty()){
		%>
		<hr id="crossLine" />
		<h1 id="noBuyList">내 구매목록 없음</h1>
		<hr id="crossLine" />
		<% 
			} else {
			session.setAttribute("sessionChecker", SessionCheck.getSessionChecker());
			display = "yes";
		%>
		
		<div id="BuyList">
		
			<div id="ShowBuyItem">
			
				<table id="BuyListTable">
					<thead>
						<tr>
							<th>상품 이미지</th>
							<th>상품명</th>
							<th>각 사이즈 갯수</th>
							<th>전체 상품 갯수</th>
							<th>해당 상품 전체 가격</th>
							<th id="location">배송지</th>
							<th>상품 선택</th>
						</tr>
					</thead>
					<tbody>
						<form action="BuyCancel.jsp?count=<%=listSize%>" method="post" id="CancelGoods">
							<input type="hidden" name="uID" id="uID" value="<%=uID %>" />
							<%
									for (int i = 0; i < listSize; i++){
									MyBasket list = BuyList.get(i);
									
									String goodsName = list.getGoodsName();
									
									Goods view =goods.getGoodsView(goodsName);
									
									int NL = goodsName.length(); //NameLength = 서버내 상품이름길이
									int TL = NL - 11;                   //true length 서버내 상품이름에서 날짜 빼기
									String showName = goodsName.substring(0,TL); //표기할 상품명 생성
									String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
									byte[] getName = showName.getBytes();//바이트로 변환
									String tloc = encoder.encodeToString(getName);//인코딩
									tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
									
									int Scount = list.getScount();
									int Mcount = list.getMcount();
									int Lcount = list.getLcount();
									int XLcount = list.getXLcount();
									int Allcount = Scount + Mcount + Lcount + XLcount;
									int calcRes = list.getCalcRes();
									String buyCost = money.format(calcRes);
									 
									sum +=calcRes;
									allBuyCost = money.format(sum);
									%>
									<tr>
										<td id="showThumb">
											<img id="BuyListImg" src="../Resource/GoodsImg/<%=tloc %>/thumb/thumb_<%=view.getGoodsThumbnail() %>"/>
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
										<td id="locationList">
											<p id="Zip"><%=list.getZip()%></p>
											<p id="Addr"><%=list.getAddr1()%></p>
											<p id="Addr"><%=list.getAddr2()%></p>
										</td>
										<td>
										<%if(list.getDelivery() == 1){ %>
											<p id="deliNotice">배송중</p>
										
										<% } else { %> 
												<input type="hidden" name="calcRes<%=i %>" id="calcRes<%=i %>" value="<%=calcRes%>"/>
												<input type="checkbox"
															value="<%=list.getAddDate()%> / <%=goodsName %> / <%=Scount %> / <%=Mcount %> / <%=Lcount %> / <%=XLcount %> / <%=calcRes %>"
															name="buyThis<%=i %>" id="buyThis<%=i %>" 
															onclick="PayCalc(<%=listSize%>,<%=i %>)" />
											<p id="deliNotice">배송 준비중</p>
										<% } %>
										</td>
									</tr>
									
									<%
									}
								}
									%>
							<input type="hidden" name="forSubmitPrice" id="forSubmitPrice" value=""/>
						</form>
					</tbody>
				</table>
				
			</div> <!-- <div id="ShowBuyItem"> -->
			
				<%
				if(display.equals("yes")){ 
				%>
				<div id="CancelProc">
					<p>전체 금액</p>
					<hr id="crossLine" />
					<p><span id="AllBuyCost">0</span>원</p>
					<hr id="crossLine" />
					<ul id="BuyListUl">
						<li><span >전체 선택 &nbsp;&nbsp;<input type="checkbox" name="selectAll" id="selectAll" onclick='selectAll(this,<%=listSize %>)'></span></li>
						<li><span onclick="CancelIt()" id="cancel">선택 상품 구매취소</span></li>
					</ul>
				</div> <!-- <div id="buyProc"> -->
				<%
				} 
				%>
		</div> <!-- <div id="ShowItem"> -->
	</div>
</div>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_MyBasket.js"></script>
</body>
</html>