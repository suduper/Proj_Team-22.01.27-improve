<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="pack_goods.GoodsProc"%>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
<%request.setCharacterEncoding("UTF-8"); %>

<%@ page import="java.io.PrintWriter"%>

<%
int count = Integer.parseInt(request.getParameter("count"));
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
String val =null;
int res = 0;
//String DelBasketInfo = request.getParameter("count");
for(int i = 0; i < count ; i++){
	val = request.getParameter("buyThis"+i);
	if(val != null){
		String[] valSplit = val.split(" / ");
		String addDate = valSplit[0];
		String goodsName = valSplit[1];
		int Scount = Integer.parseInt(valSplit[2]);
		int Mcount = Integer.parseInt(valSplit[3]);
		int Lcount = Integer.parseInt(valSplit[4]);
		int XLcount = Integer.parseInt(valSplit[5]);
		int eachPay = Integer.parseInt(valSplit[6]);
		int Allcount = Scount + Mcount + Lcount + XLcount;
		
		res += goods.DelBasketProc(uID,goodsName,addDate,Scount,Mcount,Lcount,XLcount,Allcount,eachPay);
		if(res == count){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='../GoodsUpload/MyBasket.jsp'");
			script.println("</script>");
		} else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('죄송합니다. 장바구니 오류입니다. 잠시후 다시 시도해주세요')");
			script.println("history.back()");
			script.println("</script>");
		}
	}
}
		%>
