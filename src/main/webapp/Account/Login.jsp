<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
<link rel="stylesheet" href="../style/style.css"/>
</head>
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">
	<form action="LoginAction.jsp" id="LoginAction" >
		<table>
			<tbody>
			<caption>로그인</caption>
				<tr>
					<td><input type="text" name="uID" id="uID" placeholder=" ID"class="full"></td>
				</tr>

				<tr>
					<td><input type="password" name="uPw" id="uPw" placeholder=" PW"class="full"></td>
				</tr>
				<tr>
					<td id="Td_Id_save"><input type="checkbox" id="Input_Id_save"><span style="font-size: 13px;">아이디저장</span></td>
				</tr>
				<tr>
				<td><a href="#" style="font-size: 7px; text-decoration-line:outline;">아이디 찾기</a>
				         <a href="#"style="font-size: 7px; text-decoration-line:outline;">비밀번호 찾기</a></td>
				</tr>
					<tr class="infor" id="LoginOrAccount">
					<td><button type="button" id="btn-Login" class="Join_btn"style="background-color: #fff; color: #000">로그인</button></td>
					<td ><button type="button" id="btn-Account" class="Join_btn" style="background-color: #000; color: #fff">회원가입</button></td>
				</tr>
					<tr class="infor2" id="infor2">
					<td><button type="button" id="Naver_Login" class="Join_btn2"style="background-color: #fff; color: #000">NAVER</button></td>
					<td ><button type="button" id="Kakao_Login" class="Join_btn2" style="background-color: #fff; color: #000">KAKAO</button></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>
<%@include file="../Main/Main_Bottom.jsp" %>
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$("#btn-Account").click(function(){
	location.href = "Join.jsp";
});
$("#btn-Login").click(function() {
	let uID = $("#uID").val();
	let uPw = $("#uPw").val();
	if(uID==""){
		alert("아이디 입력값은 필수입니다");
		$("#uID").focus();
	}else if (uPw == "") {     // 비밀번호 검사 시작
		alert("비밀번호를 입력하세요.");
		$("#uPw").focus();
	}else{
		$(document).ready(function() {
			$('#btn-Login').click(function () { 
				$("form").submit(); 
			});
		});
	}
})

</script>
</body>
</html>