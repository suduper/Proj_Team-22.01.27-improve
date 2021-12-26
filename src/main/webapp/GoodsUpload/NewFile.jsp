<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.util.Date" %>
<%@page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>날짜와 시간</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<%
 Date now = new Date();
 SimpleDateFormat fm = new SimpleDateFormat("yyMMddhhmm");
 String today = fm.format(now);
%>
<%= now %><br>
<%= today %>
</body>
</html>
