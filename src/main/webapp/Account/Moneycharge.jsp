  <%@page import="pack_user.User"%>
<%@page import="java.util.Vector"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  
<jsp:useBean  id="mDAO"   class="pack_user.UserDAO"  scope="page" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>적립금충전확인</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>
        <%@include file="../Main/Main_Top.jsp" %>
        <% 

if (uID != null) {   // 현재 로그인 상태라면  %>
<!-- ////////////////  로그인 상태 시작  ////////////////// -->

        
<div id="wrap">
<%=uID %>
	<form action="MoneyAction.jsp" method="post" id="moneyFrm" name="moneyFrm">
		<table>
			<tbody>
			<caption> 충전하실 적립금 금액을 입력해주세요</caption>
				
				<tr>
					<td><input type="number" name="Wallet" id="Wallet" class="full"></td>
				</tr>


	            <tr class="infor">
					<td ><button type="button" id="btn-Join" class="Join_btn" style="background-color: #000; color: #fff">충전</button></td>
					<td><button type="button" id="btn-Cancel" class="Join_btn"style="background-color: #fff; color: #000">충전취소</button></td>
				</tr>

			<!-- 체크박스 끝 -->
		</table>
	</form>
	
	
 </div>
<%@include file="../Main/Main_Bottom.jsp" %>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 
<!-- jquery로 submit -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>


//아이디 유효성검사시작
	$("#btn-Join").click(function(){
		
			
			$("#moneyFrm").submit();		
			
		});
	
//////////////유효성 검사 시작//////////////////////
	
//////////////유효성 검사 끝 //////////////////////
	$("#btn-Cancel").click(function(){
		location.href = "../Index.jsp";
	});


</script>

</body>
</html>

<% } else { %>

	<script>
		alert("비정상적인 접속입니다.\n"
				 +"메인페이지로 이동합니다."); 
		           // 현재 메인페이지는 없기 때문에 로그인페이지로 이동
		location.href="../Index.jsp";
	
	</script>

<% } %>
