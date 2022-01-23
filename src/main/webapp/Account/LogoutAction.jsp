<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Logout Action</title>
 
</head>
<body>
<div id="wrap">
<%
session.invalidate();
%>
<script>
alert("로그아웃 되었습니다.");
location.href="../Main/Main.jsp";
</script>

</div>

</body>
</html>