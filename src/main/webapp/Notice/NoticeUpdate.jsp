<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_notice.*"
    %>
    <%
    request.setCharacterEncoding("utf-8");
    
    int num = Integer.parseInt(request.getParameter("num"));
    String nowPage = request.getParameter("nowPage");
    
    
    NoticeBean bean = (NoticeBean)session.getAttribute("bean");
    String subject = bean.getSubject();
    String uName = bean.getuName();
    String content = bean.getContent();
    
    %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice</title>
    <link rel="stylesheet" href="../style/style_UpdateNotice.css">
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>

<div id="wrap">

        
        <div id="mod">
        <h4>NOTICE</h4>
<br><br>
<form action="NoticeUpdateProc.jsp" method="get" id="UpdateFrm" name="UpdateFrm">

<table id="center">
	<tbody>
		<tr>
			<td>
			<input type="text" name="subject" value="<%=subject %>"  size = "80" id="subject">
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="uName" value="<%=uName %>" size = "80" id="uName">
			</td>
		</tr>
		<tr>
			<td>
			<textarea rows="30" cols="79" name="content" size="80" id="content"><%=content %></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<button type="button" id="cancel" class="modBtn" onclick="history.back()">취소</button>
			<button type="button" id="regBtnMod" class="modBtn">등록하기</button>
			</td>
		</tr>
	</tbody>
</table>
				<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
				<input type="hidden" name="num" value="<%=num%>" id="num">
				
				
</form>
        
        </div>
</div>
<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Notice.js"></script>
</body>
</html>