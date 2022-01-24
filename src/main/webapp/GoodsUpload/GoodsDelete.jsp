<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.PrintWriter"%>
    
<jsp:useBean id="goods" class="pack_goods.GoodsProc" scope="page" />

<% // 메인 페이지로 이동했을 때 세션에 값이 담겨있는지 체크 
String uID = null; 
if(session.getAttribute("uID") != null){
	uID = (String)session.getAttribute("uID"); 
}  
String authority = null;
if(session.getAttribute("authority") != null){ 
	authority = (String)session.getAttribute("authority"); 
	int res = goods.GoodsDelete(request.getParameter("goodsName"));
	if(res == 1){ 
		response.sendRedirect("GoodsList.jsp");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("history.back()");
		script.println("</script>");
	}
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('권한이 없습니다!!!')");
	script.println("location.href='../Main/Main.jsp'");
	script.println("</script>");
}
%> 