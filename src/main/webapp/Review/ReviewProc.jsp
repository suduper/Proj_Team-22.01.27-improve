<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="rMgr" class="pack_review.ReviewMgr" scope="page"/>
<%
String subject = request.getParameter("subject");
rMgr.insertReview(request, subject);
response.sendRedirect("ReviewList.jsp");
%>
