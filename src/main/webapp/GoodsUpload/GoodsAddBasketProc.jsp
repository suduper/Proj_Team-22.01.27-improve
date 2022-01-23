<%@page import="pack_goods.GoodsProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ page import="java.io.PrintWriter"%>
 
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="goods" class="pack_goods.GoodsProc" scope="page" />
  
<%
String uID = null; 
if(session.getAttribute("uID") != null){
	uID = (String)session.getAttribute("uID"); 
} else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하지 않으셨습니다.')");
	script.println("location.href='../Account/Login.jsp'");
	script.println("</script>");
}

String goodsName = request.getParameter("goodsName");
String Scount = request.getParameter("Scount");
String Mcount = request.getParameter("Mcount");
String Lcount = request.getParameter("Lcount");
String XLcount = request.getParameter("XLcount");
String Allcount = request.getParameter("Allcount");
String calcRes = request.getParameter("calcRes");

// String addBasket = uID +" / " +goodsName +" / " + Scount +" / " + Mcount +" / " + Lcount+" / " + XLcount+" / " + Allcount + " / " + calcRes;
int res = 0;
if(!uID.equals(null)){
	GoodsProc goodsProc = new GoodsProc();
	res = goods.addBasket(uID, goodsName, Scount, Mcount, Lcount, XLcount, Allcount, calcRes);
}

if(res == 1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('옷바구니에 추가되었습니다.')");
	script.println("</script>");
} else if(res == 2){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('옷바구니가 수정되었습니다.')");
	script.println("</script>");
} else if(res == -1) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('상품을 옷바구니에 담지 못했습니다. 잠시후 다시 넣어주세요')");
	script.println("</script>");
} else if(res == 0){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('이용에 불편을 드려 대단히 죄송합니다. 오류로 인하여 옷바구니를 갱신하지 못했습니다. 빠른 시일내에 정상적으로 사용 가능하도록 노력하겠습니다.')");
	script.println("</script>");
}
%>