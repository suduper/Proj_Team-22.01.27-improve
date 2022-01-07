<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%	request.setCharacterEncoding("UTF-8"); %>

<% 
int count = Integer.parseInt(request.getParameter("count")); 
String[] buys = new String[count];
for(int i = 0; i<count ; i++){
	buys[i] = request.getParameter("buyThis"+i);
}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>BuyProc</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
<%=count%> <br>
<%
for(int i = 0; i<count ; i++){
	buys[i] = request.getParameter("buyThis"+i); %>
<%=buys[i] %><br>
<%} %>
</body>
</html>