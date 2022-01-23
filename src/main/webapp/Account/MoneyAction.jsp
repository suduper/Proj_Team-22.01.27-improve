<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="java.io.PrintWriter"%>
<%@page import="pack_user.UserDAO"%>
<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="pack_user.User" scope="page" />
<jsp:useBean id="money" class="pack_user.UserDAO" scope="page" />


<%
	String uID = null;
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID");
	}
	int  Wallet = Integer.parseInt(request.getParameter("Wallet"));

/*<!-- //////////////////////// 세션 체크 //////////////////////// -->*/
	if (uID== null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인이 필요한 서비스입니다.')");
		script.println("location.href='../Account/Login.jsp'");
		script.println("</script>");
	} else{
	/* <!-- 진행시작 --> */
		UserDAO userDAO = new UserDAO();
		int result = userDAO.money(uID, Wallet);
		if(result == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('성공적으로 입금되었습니다.')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert(' 서버오류로 입금에 실패했습니다 관계자에게 문의해주세요.')");
		script.println("history.back()'");
		script.println("</script>");
	}
	}
%>