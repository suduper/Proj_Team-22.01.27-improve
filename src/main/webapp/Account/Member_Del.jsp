<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:useBean id="mMgr" class="pack_user.UserDAO" scope="page" />
    
<%
String uID = (String)session.getAttribute("uID");
boolean res = mMgr.deleteMember(uID);

if (res) {
	session.invalidate();
}
%>

<script>
	alert("정상적으로 처리되었습니다.\n확인을 눌러주세요.");
	location.href = "../Main/Main.jsp";
</script>