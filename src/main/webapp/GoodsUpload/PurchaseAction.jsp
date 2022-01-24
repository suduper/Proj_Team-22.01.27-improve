<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.io.PrintWriter"%>
    
<%request.setCharacterEncoding("UTF-8"); %>
 
<jsp:useBean id="purchase" class="pack_user.UserDAO" scope="page"/>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<% 
String uID = request.getParameter("uID");
int pay = Integer.parseInt(request.getParameter("sum"));
int res = purchase.Pay(uID,pay);
%> 
<input type="hidden" name="res" id="res" value="<%=res %>" onload="resulter(<%=res %>)" />
 
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_Purchase.js"></script>
