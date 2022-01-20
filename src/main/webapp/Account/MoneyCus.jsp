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
Vector<User> vList = mDAO.modifyMember(uID);
if (uID != null) {   // 현재 로그인 상태라면  %>
<!-- ////////////////  로그인 상태 시작  ////////////////// -->


	<%
	User user = (User)vList.get(0);
	String uIDD = user.getuID();
	String uPw = user.getuPw();
	String uName = user.getuName();

	%>
        
<div id="wrap">
	<form action="Moneycharge.jsp" method="get" id="regFrm" name="regFrm">
		<table>
			<tbody>
			<caption><%=uName%>님! 적립금 충전을 확인을 위해 비밀번호를 입력해주세요</caption>
				
				<tr>
					<td><input type="text" name="uID" id="uID" value="충전할 회원아이디: <%=uIDD%>"class="full" readonly="readonly" style="border-style: none;"></td>
				</tr>

				
				<tr>
					<td><input type="password" name="uPw_Re" id="uPw_Re" placeholder="비밀번호 확인" class="full"></td>
				</tr>
<tr>
					<td><input type="password" name="uPw" id="uPw" value="<%=uPw%>"class="full" style="display: none;"></td>
				</tr>

	            <tr class="infor">
					<td ><button type="button" id="btn-Join" class="Join_btn" style="background-color: #000; color: #fff">확인</button></td>
					<td><button type="button" id="btn-Cancel" class="Join_btn"style="background-color: #fff; color: #000">결제취소</button></td>
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
		

		let uPw = $("#uPw").val();
		let uPw_Re = $("#uPw_Re").val();
if (uPw != uPw_Re) {     // 비밀번호 동일검사 시작
			alert("비밀번호가 다릅니다. 확인 후 다시 입력하세요.");
			$("#uPw_Re").val("");
			$("#uPw_Re").focus();
		} else {
			
			$("#regFrm").submit();		
			
		}
	
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
