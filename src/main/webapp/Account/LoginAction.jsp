<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@page import="java.io.PrintWriter"%>
<%@page import="pack_user.UserDAO"%>
<jsp:useBean id="user" class="pack_user.User" scope="page" />
<jsp:setProperty name="user" property="uID" />
<jsp:setProperty name="user" property="uPw" />
<jsp:setProperty name="user" property="authority" value="user"/>

    
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LoginAction</title>
</head>
<body>
<div id="wrap">
	<%
	// 현재 세션 상태를 체크한다
	String uID = null;
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID");
	}
	// 이미 로그인했으면 다시 로그인을 할 수 없게 한다
	if(uID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어 있습니다')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}
	UserDAO userDAO = new UserDAO();
	int result = userDAO.login(user.getuID(), user.getuPw(), null);
	if(result == 1){
		// 일반유저 로그인에 성공하면 세션을 부여
		session.setAttribute("uID", user.getuID());
		session.setAttribute("authority", user.getAuthority());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
		
		//관리자가 로그인에 성공하면 세션을 부여
	}else if(result == 2){
		session.setAttribute("uID", user.getuID());
		%>
		<jsp:setProperty name="user" property="authority" value="admin"/>
		<%
		session.setAttribute("authority", user.getAuthority());
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자 로그인 성공')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 올바르지 않습니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('아이디 또는 비밀번호가 올바르지 않습니다')");
		script.println("history.back()");
		script.println("</script>");
	}
	%>
</div>

</body>
</html>