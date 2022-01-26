<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="pack_notice.*"
    %>
    <jsp:useBean id = "nMgr" class = "pack_notice.NoticeMgr" scope="page"/>
    <%

    request.setCharacterEncoding("utf-8");
    
    String nowPage = request.getParameter("nowPage");
    String num = request.getParameter("num");
    
    int numParam = Integer.parseInt(num);
    
	NoticeBean bean = (NoticeBean)session.getAttribute("bean");
	
	int exeCnt = nMgr.deleteNotice(numParam);
   %>
   <script>
   alert("삭제 완료");
   location.href = "NoticeList.jsp";
   </script>


    
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notice</title>
    <link rel="stylesheet" href="../style/style_DeleteNotice.css">
</head>
<body>

<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">

        
        <div id="delete">
        
        <h3>NOTICE</h3>
			<br><br>
		<form id="delFrm" name="delFrm">

		<button type="button" id="delSbmBtn" class="delBtn" onclick="deleteCheck()">삭제하기</button>
		<button type="button" onclick="history.back()" class="delBtn">돌아가기</button>
		
		</form>	
		
        
        </div>
        


</div>
<%@include file="../Main/Main_Bottom.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../script/script_Notice.js"></script>
</body>
</html>
