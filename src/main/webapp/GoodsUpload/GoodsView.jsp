<%@page import="pack_goods.GoodsProc"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="pack_goods.Goods" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
    
<%
request.setCharacterEncoding("UTF-8");

int numParam = Integer.parseInt(request.getParameter("num"));

goods.upCount(numParam);
GoodsProc view =goods.getGoodsView(numParam);
     
int num =  view.getNum();
String uName	=	view.getuName();
String subject	= view.getSubject();
String content	= view.getContent();
int pos	= view.getPos();
int ref	= view.getRef();
int depth	= view.getDepth();
String regDate	= view.getRegDate();
String uPw	= view.getuPw();
int count 	= view.getCount();
String fileName	= view.getFileName();
double fileSize 	= view.getFileSize();
String ip	= view.getIp();
session.setAttribute("view", view);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsView</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

</body>
</html>