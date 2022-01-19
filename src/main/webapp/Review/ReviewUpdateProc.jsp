<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="bean" class="pack_review.ReviewBean" scope="session"/>
    <jsp:useBean id="upBean" class="pack_review.ReviewBean" scope="page"/>
	<jsp:useBean id="rMgr" class="pack_review.ReviewMgr" scope="page"/>
    <jsp:setProperty name="upBean" property="*"/>
<%
String nowPage = request.getParameter("nowPage");

String upPass = upBean.getPass();
String realDBPass = bean.getPass();


%>
<%
int exeCnt = 0;

if(upPass.equals(realDBPass)){
	exeCnt = rMgr.updateReview(request, upBean);
	
	if(exeCnt>0){
		String url = "ReviewRead.jsp?nowPage="+nowPage+"&num="+upBean.getNum();
		%>
		<script>
		location.href = "<%= url%>";
		</script>
		
	<%} else{%>
	<script>
	alert("오류발생")
	history.back();
	</script>
	<%}
} else {%>
	<script>
		alert("비밀번호를 확인해주세요!");
		history.back();
	</script>
	
	<% } %>
