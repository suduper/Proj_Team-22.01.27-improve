<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice</title>
    <link rel="stylesheet" href="../style/style_postNotice.css">
</head>
<body>

<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">



<div id="review">
<h4>NOTICE</h4>
<br><br>

<form action="NoticeProc.jsp" method="post" id="postFrm" name="postFrm">

<table id="center">
	<tbody>
		<tr>
			<td>
			<input type="text" name="subject" placeholder="제목" size = "80" id="subject">
			</td>
		</tr>
		<tr>
			<td>
			<input type="text" name="uName" value="<%=uID %>"  size = "80" id="uName" readonly="readonly">
			</td>
		</tr>
		<tr>
			<td>
			<textarea rows="30" cols="79" name="content" size="80" id="content"></textarea>
			</td>
		</tr>
		<tr>
			<td>
			<button type="button" id="cancel" class="pBtn" onclick="history.back()">취소</button>
			<button type="button" id="regBtn" class="pBtn">등록하기</button>
			</td>
		</tr>
	</tbody>
</table>
				<input type="hidden" name="ip" value="<%=request.getRemoteAddr()%>">
</form>

</div>

</div>
  <%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Notice.js"></script>
</body>
</html>