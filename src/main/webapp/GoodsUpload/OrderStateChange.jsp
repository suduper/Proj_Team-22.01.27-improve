<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
    
<%@ page import="pack_AdminOption.AdminOptionProc" %> 
    
<%	request.setCharacterEncoding("UTF-8"); %>
 
<%@ page import="java.io.PrintWriter"%>

<jsp:useBean id="StateSet" class="pack_AdminOption.AdminOptionProc" scope="page" />

<%

int changeState = Integer.parseInt(request.getParameter("changeState"));
int listSize = Integer.parseInt(request.getParameter("listSize"));
String info = null;

int res = 0;
int getRes = 0;
int tryCounter = 0;

for(int i = 0; i < listSize ; i++){
	info = request.getParameter("check"+i);
	if(info == null){
		continue;
	} else {
		getRes = StateSet.changeState(changeState,info);
		if(getRes == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('에러가 발생하였습니다. 관리자에게 문의해주세요.')");
			script.println("</script>");
			continue;
		} else {
			res += getRes;
		}
	}
	tryCounter++;
}

PrintWriter script = response.getWriter();
script.println("<script>");
script.println("alert('"+tryCounter+"개의 요청변환 중"+res+"개의 변환 완료')");
script.println("location.href='../GoodsUpload/OrderShow.jsp'");
script.println("</script>");
%>

