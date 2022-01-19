<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_AdminOption.AdminOption"%>
<%@ page import="pack_AdminOption.AdminOptionProc" %> 
    
<%@ page import="pack_AdminOption.AdminOption, java.util.Vector" %>
<%@ page import="java.text.NumberFormat"%>
<%@ page import="java.io.PrintWriter"%>


<jsp:useBean id="Order" class="pack_AdminOption.AdminOptionProc"  scope="page" /> 

<%	request.setCharacterEncoding("UTF-8"); %>

<%
String uID = null;
if(session.getAttribute("uID") != null){ 
	uID = (String)session.getAttribute("uID"); 
} 
String SA = null;
if(session.getAttribute("authority") == "admin"){ 
	String authority = (String)session.getAttribute("authority"); 
	SA = authority;
} else if(session.getAttribute("authority") == null ||
			session.getAttribute("authority") == "user"){
	String authority = "not allowed";
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('"+authority+"')");
	script.println("alert('권한이 없습니다!!!')");
	script.println("location.href='../Main/Main.jsp'");
	script.println("</script>");
} 

Vector<AdminOption> AllOrderList = null;

int listSize = 0;

NumberFormat money = NumberFormat.getNumberInstance();

%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>OrderShow</title>
<link rel="stylesheet" href="../style/style_AdminOption.css">
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">
	
	<div id="Option"><!-- div id="Option" -->
			<select>
				<option value="전체">전체</option>
				<option value="정장">정장</option>
				<option value="패딩">패딩</option>
				<option value="기타">기타</option>
			</select>
			<input type="text" name="serch" id="serch" placeholder="검색어 입력" />
			<p id="goSerch" onclick="goSerch()">검색</p>
	</div><!-- div id="Option" -->
		
	<div id="OrderShowWrap"><!-- div id="OrderShowWrap" -->
		
		<div id="OrderShowContent"><!-- div id="OrderShowContent" -->
		<% 
			AllOrderList = Order.OrderList();
			listSize = AllOrderList.size();
			if(AllOrderList.isEmpty()){
		%>
		<h1>ERROR경고 / 유저 구매리스트에 내용없음</h1>
		<%
			} else {
		%>
			<table id="OrderShowTable">
				<thead>
					<th>번호</th>
					<th>구매자ID</th>
					<th>상품명</th>
					<th>사이즈<br>(S / M / L / XL)</th>
					<th>전체 갯수</th>
					<th>구매 가격(원)</th>
					<th>우편번호</th>
					<th>배송주소</th>
					<th>전화번호</th>
					<th>배송 메세지</th>
					<th>제품 출하 상태</th>
					<th>선택</th>
				</thead>
				<tbody>
					<form action="OrderStateChange.jsp?listSize=<%=listSize %>" method="post" id="OrderStateChange">
						<input type="hidden" name="changeState" id="changeState" value=""/>
				<%
					for (int i = 0; i < listSize; i++){
						AdminOption list = AllOrderList.get(i);
						String calcRes = money.format(list.getCalcRes());
						int Zip = list.getZip();
						String Addr = list.getAddr1()+"<br>"+list.getAddr2();
						String phone = list.getPhone();
						String Notice = list.getNotice();
						int delivery = list.getDelivery();
				%>
						<tr>
							<td><%=list.getNum() %></td>
							<td><%=list.getuID() %></td>
							<td><%=list.getGoodsName()%></td>
							<td><%=list.getScount() +" / "+ list.getMcount() +" / "+ list.getLcount() +" / "+ list.getXLcount() %></td>
							<td><%=list.getScount() + list.getMcount() + list.getLcount() + list.getXLcount() %></td>
							<td><%=calcRes %></td>
							<td><%=Zip %></td>
							<td><%=Addr %></td>
							<td><%=phone %></td>
							<td><%=Notice %></td>
							<td style="background-color: 
							<%
							if(delivery == 0){
							%>
							#fff">배송전</td>
							<td>
								<input type="checkbox" 
										   name="check<%=i%>" id="check<%=i%>" 
										   value="<%=list.getNum() +" / "+ 
												   			   list.getuID() +" / "+ 
										   					   list.getGoodsName()%>"/>
							</td>
							<%
							} else if(delivery == 1) {
							%>
							#00FF80">배송중</td>
							<td>
								<input type="checkbox" 
										   name="check<%=i%>" id="check<%=i%>" 
										   value="<%=list.getNum() +" / "+ 
												   			   list.getuID() +" / "+ 
										   					   list.getGoodsName()%>"/>
							</td>
							<%
							} else if(delivery == 2) {
							%>
							#4AA8D8">배송완료</td>
							<td>
								<input type="checkbox" name="check" id="check"  disabled="disabled"/>
							</td>
							<%
							} else if(delivery == -99 ) {
							%>
							#FFD400">구매취소</td>
							<td>
								<input type="checkbox" name="check" id="check"  disabled="disabled"/>
							</td>
							<%
							} else if(delivery == 404){
							%>
							#DC143C">확인불가</td>
							<td>
								<input type="checkbox" name="check" id="check"  disabled="disabled"/>
							</td>
							<%
							}
							%>
							</td>
						</tr>
				<%
					}
				}
				%>
					</form>
				</tbody>
			</table>
		</div><!-- div id="OrderShowContent" -->
		
		<div id="OrderOption"> <!-- div id="OrderOption" -->
		
			<div id="changeState"> <!-- div id="changeState" -->
				<h4>상태변경</h4>
				<hr id="crossLine"/>
				<p id="Depa" onclick="changeState(1)">배송중</p>
				<p id="Comp" onclick="changeState(2)">배송완료</p>
				<p id="Canc" onclick="changeState(-99)">구매취소</p>
				<p id="Unkn" onclick="changeState(404)">확인불가</p>
			</div> <!-- div id="changeState" -->
			
		</div> <!-- div id="OrderOption" -->
		
	</div><!-- div id="OrderShowWrap" -->
	여기<span id="test"></span>
</div><!-- div id="wrap" -->

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_OrderShow.js"></script>
</body>
</html>