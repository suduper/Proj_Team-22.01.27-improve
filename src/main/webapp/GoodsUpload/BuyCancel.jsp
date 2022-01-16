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
	script.println("alert('구매취소 세션이 만료되었습니다.')");
	script.println("location.href='../GoodsUpload/BuyList.jsp'");
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
	
	String addDate = request.getParameter("addDate");
	
	int delCheckers = 0;
	String goodsName = null;
	int setInfoNum = 0;
	String CancelThis = null;
	for(int i =0 ; i < sendCount ; i++){ 
		CancelThis = request.getParameter("cancelThis"+setInfoNum);
		if(request.getParameter("cancelThis"+setInfoNum) == null){
			setInfoNum++;
			if(i == 0){
				i--;
			}
		} else {
			goodsName = order.userOrder(uID,orderName,CancelThis);
			delCheckers += order.set0Basket(uID, goodsName);
			setInfoNum++;
		}
	} 
	if(delCheckers == sendCount){
%>
<jsp:setProperty name="SessionCheck" property="sessionChecker" value="impossible"/>
<div id="res">
<% session.setAttribute("sessionChecker","impossible");%>
	<h1>구매 취소 완료</h1>
</div>
<%
	} else {
%>

<div id="res">
	<h1>구매 취소 오류</h1>
	<p>대단히 죄송합니다. 관리자에게 문의해 주세요.</p>
</div>
<%			
	}
%>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>

</body>
</html>