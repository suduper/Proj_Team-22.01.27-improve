<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="pack_notice.NoticeBean"%>
    
    <jsp:useBean id="nMgr" class="pack_notice.NoticeMgr" scope="page"/>
    
    <%
    request.setCharacterEncoding("utf-8");
    
    int numParam = Integer.parseInt(request.getParameter("num"));
    
    NoticeBean bean = nMgr.getNotice(numParam);
    
    String nowPage = request.getParameter("nowPage");
    
    int num = bean.getNum();
    
    String uName = bean.getuName();
    String subject = bean.getSubject();
    String content = bean.getContent();
    String regData = bean.getRegDate();

    String ip = bean.getIp();
    
    session.setAttribute("bean", bean);
    %>
    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NOTICE</title>
    <link rel="stylesheet" href="../style/style_ReadNotice.css">
</head>
<body>

<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">

    <!-- HTML템플릿(Template, Templet) 헤더 시작 -->


<!-- HTML템플릿(Template, Templet) 헤더 끝 -->

<main id="main">
<table id = "read">
	<tbody>
		<tr>
		<td class="rContent"><span>작성일</span><span><%=regData %></span></td>
		</tr>
		<tr>
			<td class="rContent"><span>제목</span><span><%=subject %></span></td>
		</tr>
		<tr>
			<td class="rContent"><span>작성자</span><span><%=uName %></span></td>
		</tr>
		<tr>
			<td id="readContents" >
			<textarea name="txtArea" id="txtArea" cols="30" rows="10" readonly><%=content %></textarea>
			</td>
		</tr>
	</tbody>
</table>

<button type="button" id="listBtn" class="reviewBtn">리스트</button>
<%if(authority.equals("admin")){ %>
<button type="button" id="modBtn"  class="reviewBtn">수정</button>
<button type="button" id="delBtn"  class="reviewBtn">삭제</button>
<%} %>
			<input type="hidden" name="nowPage" value="<%=nowPage%>" id="nowPage">
			<input type="hidden" name="num" value="<%=num%>" id="num">


</main>


</div>
<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Notice.js"></script>
</body>
</html>