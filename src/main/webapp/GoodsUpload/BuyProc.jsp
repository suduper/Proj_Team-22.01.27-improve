<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>

<jsp:useBean id="order" class="pack_goods.GoodsProc" scope="page" />

<jsp:useBean id="SessionCheck" class="pack_goods.Goods" scope="page" />
 
<jsp:setProperty name="SessionCheck" property="sessionChecker"/>
<%
if(session.getAttribute("sessionChecker") != null){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('구매 세션이 만료되었습니다.')");
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
<title>BuyProc</title>
</head>
<link rel="stylesheet" href="../style/style_goods.css">
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<%
	String uID = request.getParameter("uID");
	String orderName = request.getParameter("who");
	int sendCount = Integer.parseInt(request.getParameter("sendCount"));
	int sum = Integer.parseInt(request.getParameter("sum"));
	
	int Zip = Integer.parseInt(request.getParameter("Zip"));
	String Addr1 = request.getParameter("Addr1");
	String Addr2 = request.getParameter("Addr2");
	String phone = request.getParameter("phone");
	String notice = request.getParameter("notice");
	 
	int delCheckers = 0;
	String goodsName = null;
	int setInfoNum = 0;
	String buyThis = null;
	for(int i =0 ; i < sendCount ; i++){ 
		buyThis = request.getParameter("buyThis"+setInfoNum);
		if(request.getParameter("buyThis"+setInfoNum) == null){
			setInfoNum++;
			if(i == 0){
				i--;
			}
		} else {
			goodsName = order.userOrder(uID,orderName, buyThis, Zip, Addr1, Addr2, phone, notice);
			delCheckers += order.set0Basket(uID, goodsName);
			setInfoNum++;
		}
	} 
	if(delCheckers == sendCount){
%>
<jsp:setProperty name="SessionCheck" property="sessionChecker" value="impossible"/>

<div id="wrap">
<% session.setAttribute("sessionChecker","impossible");%>
	<hr id="crossLine" />
	<h1 id="BuyProcH1">구매완료</h1>
	<hr id="crossLine" />
</div>
<%
	} else {
%>

<div id="wrap">
	<hr id="crossLine" />
	<h1 id="BuyProcH1">구매 정보 오류</h1>
	<p id="sorryMsg">대단히 죄송합니다. 관리자에게 문의해 주세요.</p>
	<hr id="crossLine" />
</div>
<%			
	}
%>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

</body>
</html>