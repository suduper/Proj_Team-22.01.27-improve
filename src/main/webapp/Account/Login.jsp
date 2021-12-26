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

<div id="wrap">
	<nav>
		<ul class="flex-container">
		    <li><a href="../Main/Main.jsp">메인으로</a></li>
			<li><a href="../Account/Login.jsp">로그인</a></li>
			<li><a href="#">글쓰기</a></li>
			<li><a href="#">자유게시판</a></li>
		</ul>
	</nav>

	<form action="LoginAction.jsp" id="LoginAction" >
		<table>
			<tbody>
			<caption>로그인</caption>
				<tr>
					<td><input type="text" name="uID" id="uID" placeholder="아이디"class="full"></td>
				</tr>

				<tr>
					<td><input type="password" name="uPw" id="uPw" placeholder=" 비밀번호 (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)"class="full"></td>
				</tr>
				<tr>
					<td><button type="button" id="btn-Login">로그인</button></td>
				</tr>
			</tbody>
		</table>
	</form>
</div>

<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function() {
	$('#btn-Login').click(function () { 
		$("form").submit(); 
	});
});
</script>
</body>
</html>