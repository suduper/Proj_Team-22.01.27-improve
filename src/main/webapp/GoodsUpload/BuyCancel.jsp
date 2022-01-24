<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
      
<%@page import="pack_goods.GoodsProc"%>

<%	request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>

<jsp:useBean id="CancelOrder" class="pack_goods.GoodsProc" scope="page" />

<jsp:useBean id="SessionCheck" class="pack_goods.Goods" scope="page" />

<jsp:setProperty name="SessionCheck" property="sessionChecker"/>
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
	
	if(session.getAttribute("sessionChecker") != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('구매취소 세션이 만료되었습니다.')");
		script.println("location.href='../GoodsUpload/BuyList.jsp'");
		script.println("</script>");
	}
	
	int listSize = Integer.parseInt(request.getParameter("count"));
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('"+listSize+"')");
	script.println("</script>");
	String CancelBuyThis = null;
	int res = 0;
	int checker = 0;
	for(int i = 0; i < listSize ; i++){
		CancelBuyThis = request.getParameter("buyThis"+i);
		if(CancelBuyThis == null){
			continue;
		} else {
		res += CancelOrder.cancelOrder(uID, CancelBuyThis);
		checker++;
		}
		
	}
%>
<!DOCTYPE html>	
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BuyCancel</title>
</head>
<link rel="stylesheet" href="../style/style_goods.css">
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<%if(res >= checker){
		session.setAttribute("sessionChecker","impossible");%>
	<div id="res">
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