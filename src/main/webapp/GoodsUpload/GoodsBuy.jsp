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

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">

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
	
</div><!-- wrap -->

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
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