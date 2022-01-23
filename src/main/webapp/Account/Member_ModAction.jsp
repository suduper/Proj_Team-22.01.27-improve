<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("UTF-8");
String uPw = request.getParameter("uPw");
String uName = request.getParameter("uName");
String uZip = request.getParameter("uZip");
String uAddr1 = request.getParameter("uAddr1");
String uAddr2 = request.getParameter("uAddr2");
String uEmail = request.getParameter("uEmail");
%>   

<jsp:useBean id="mMgr" class="pack_user.UserDAO" scope="page" />
<%
String sessionuID = (String)session.getAttribute("uID");
boolean res = mMgr.modifyMember(uPw, uName, uZip, uAddr1,uAddr2, uEmail, sessionuID);
%>

<script> 
<% if (res) { %>
	alert("회원정보 수정완료!");
	location.href = "../Main/Main.jsp";
<% } else { %>
    let msg = "회원정보 수정중에 오류가 발생하였습니다. 다시 시도해주십시오.\n";
         msg += "만일 오류가 계속된다면 관리자에게 연락부탁드립니다.";
	alert(msg);
	history.back();	
<% } %> 
</script>