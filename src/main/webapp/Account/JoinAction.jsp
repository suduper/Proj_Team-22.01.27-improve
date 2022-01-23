<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="pack_user.UserDAO"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="pack_user.User" scope="page" />
<jsp:setProperty name="user" property="nationality" />
<jsp:setProperty name="user" property="certify"/>
<jsp:setProperty name="user" property="uID" />
<jsp:setProperty name="user" property="uPw" />
<jsp:setProperty name="user" property="uZip" />
<jsp:setProperty name="user" property="uAddr1" />
<jsp:setProperty name="user" property="uAddr2" />
<jsp:setProperty name="user" property="authority" />
<jsp:setProperty name="user" property="uEmail" />
<jsp:setProperty name="user" property="phoneNum1" />
<jsp:setProperty name="user" property="phoneNum2" />
<jsp:setProperty name="user" property="phoneNum3" />
<jsp:setProperty name="user" property="birthYear" />
<jsp:setProperty name="user" property="birthMonth" />
<jsp:setProperty name="user" property="birthDay" />
<jsp:setProperty name="user" property="recommend" />
<jsp:setProperty name="user" property="uName" />
<!-- 앞서 기록된 모든것들을 멤버객체에 저장 -->
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JoinAction</title>
</head>
<body>
<!-- ------------------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------------- -->
	<%
	
	/*<!-- //////////////////////// 세션 체크 //////////////////////// -->*/
		String uID= null;
		if(session.getAttribute("uID") != null){
			uID = (String)session.getAttribute("uID");
		}
	/*<!-- //////////////////////// 세션 체크 //////////////////////// -->*/
	
	
	/*<!-- ///////// 이미 로그인 되있으면 회원가입 불가하게 함 ///////// -->*/
		if(uID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어 있습니다')");
			script.println("location.href='../Main/Main.jsp'");
			script.println("</script>");
		}
	/*<!-- ///////// 이미 로그인 되있으면 회원가입 불가하게 함 ///////// -->*/
	 
	/*<!-- ///////// 입력사항확인 ///////// -->*/
		if(user.getuID() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('ID')");
			script.println("history.back()");
			script.println("</script>");
		}
		if(user.getuPw() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Pw')");
					script.println("history.back()");
					script.println("</script>");
				}
		if(user.getuZip() == null ){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('Zip')");
					script.println("history.back()");
					script.println("</script>");
				}
		if(user.getuAddr1() == null){
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('uAddr1')");
					script.println("history.back()");
					script.println("</script>");
				}
		if(user.getPhoneNum1() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('PhoneNum1')");
			script.println("history.back()");
			script.println("</script>");
		}
	/*<!-- ///////// 입력사항확인 ///////// -->*/

		else{
	
	/*<!-- ///////// 입력사항 확인 후 진행사항 ///////// -->*/
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(user);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 존재하는 아이디입니다')");
				script.println("history.back()");
				script.println("</script>");
			}else {
				session.setAttribute("uID", user.getuID());
				session.setAttribute("authority", user.getAuthority());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('회원가입 성공')");
				script.println("location.href='../Main/Main.jsp'");
				script.println("</script>");
			}
	/*<!-- ///////// 입력사항 확인 후 진행사항 ///////// -->*/
		}
	%>
<!-- ------------------------------------------------------------------------------------- -->
<!-- ------------------------------------------------------------------------------------- -->

</body>
</html>