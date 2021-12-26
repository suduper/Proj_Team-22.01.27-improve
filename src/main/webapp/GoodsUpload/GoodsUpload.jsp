<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%	request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>

<%
	String uID = null;
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID"); 
	} 
	String authority = null;
	if(session.getAttribute("authority") != null){ 
		authority = (String)session.getAttribute("authority");		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}
	
	
	int filecounter = 0;
	if(request.getParameter("addcnt") != null){
		filecounter = Integer.parseInt(request.getParameter("addcnt"));
	}
	
	String goodsName= null;
	if(request.getParameter("goodsName") !=null){
		goodsName = request.getParameter("goodsName");
	}
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsUpload</title>
</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">
	<form name="FC" id="FC" method="post">
		<div>
				상품 이름 : 
				<input type="text" name="goodsName" id="goodsName" />
 				상품 이미지 갯수
 				<input type="number" name="addcnt" id="addcnt" min="1" max="10" step="1">
 				<button type="button" name="checkC" id="checkC">추가</button>
 		</div>
	</form>
	
	<form method="post" action="GoodsUploadProc.jsp?GNF=<%=goodsName %>" id="goodsInfo2" enctype="multipart/form-data">
	<input type="hidden" name="goodsName" id="goodsName" value="<%=goodsName %>" />
		<%
		for(int i =0; i<filecounter; i++){
			if(i == filecounter-1){
		%>
			썸네일 :
			<input type="file" name="goodsImages<%=i%>" id="goodsImages<%=i%>" accept=".jpg , .png , .webp"/><br>
		<% 
			} else { %>
		상품 이미지 :
			<input type="file" name="goodsImages<%=i%>" id="goodsImages<%=i%>" accept=".jpg , .png , .webp"/><br>
		<%
			}
		}
		%>
	<%
	if(filecounter != 0){
		%>
		<button type="button" id="insertInfo">상품정보 입력</button>
	<%	
	}
	%>
		상품 종류 : 
		<select name="goodsType" id="goodsType">
			<option value='1' selected>-- 선택 --</option>
  			<option value='정장'>정장</option>
  			<option value='패딩'>패딩</option>
  			<option value='기타'>기타</option>
		</select>
		
		상품 판매 가격 : 
		<input type="text" name="goodsPrice" id="goodsPrice"/>
		
		상품 세일 가격 :
		<input type="text" name="goodsSPrice" id="goodsSPrice" placeholder="미입력시 세일가격은 0원입니다."/>
		
		<br>	
		상품 내용
		<div id="write" contenteditable="true" style="width: 200px; height: 200px; border: 2px solid #000" spellcheck="true" ></div>
		<div id="hider">
			<textarea name="goodsContent" id="goodsContent" placeholder="테스트"></textarea> 
		</div>
	</form>
	<button id="submit">상품 등록</button>
</div>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_Goods.js"></script>

</body>
</html>