<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="bean" class="pack_notice.NoticeBean" scope="session"/>
    <jsp:useBean id="upBean" class="pack_notice.NoticeBean" scope="page"/>
	<jsp:useBean id="nMgr" class="pack_notice.NoticeMgr" scope="page"/>
    <jsp:setProperty name="upBean" property="*"/>
<%
String nowPage = request.getParameter("nowPage");

String authority = null;
if(session.getAttribute("authority") != null){ 
	authority = (String)session.getAttribute("authority"); 
	}

%>
<%
int exeCnt = nMgr.updateNotice(upBean);
	
		if(exeCnt>0){
			String url = "NoticeRead.jsp?nowPage="+nowPage+"&num="+upBean.getNum();
		%>
		<script>
		location.href = "<%= url%>";
		</script>
		
	<%}%>