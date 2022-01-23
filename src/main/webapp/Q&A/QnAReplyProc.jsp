<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="qMgr" class="pack_QnA.QnAMgr" scope="page" />
<jsp:useBean id="reBean" class="pack_QnA.QnABean" scope="page" />
<jsp:setProperty name="reBean" property="*" />
<%
int repUpCnt = qMgr.replyUpQnA(reBean.getRef(), reBean.getPos());
int repInsCnt = qMgr.replyQnA(reBean);

String nowPage = request.getParameter("nowPage");
String keyField = request.getParameter("keyField");
String keyWord = request.getParameter("keyWord");

if(repInsCnt > 0) { 
	
	String url = "QnAList.jsp?nowPage="+nowPage;
	url += "&keyField="+keyField; 
	url += "&keyWord="+keyWord;
%>    
	<script>
		location.href="QnAList.jsp";
	</script>
<%
} else {
%>	

	<script>
		let msg = "답변글 등록중 오류가 발생했습니다.\n";
		     msg += "다시 시도해주세요\n";
		     msg += "오류가 지속되면 관리자에게 연락바랍니다.";
		alert(msg);
		history.back();
	</script>

<%
}
%>