<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="../style/style.css">
</head>
<body>

<div id="wrap">
	<form action="JoinAction.jsp" id="regFrm">
		<table>
			<tbody>
			<caption>회원가입</caption>
				<tr>
					<td>
						<label ><input type="radio" name="nationality" value="1_내국인" style="font-size:12px; width:25px;height:22px" checked>내국인회원</label>
						<label ><input type="radio" name="nationality" value="0_외국인" style="font-size:12px; width:25px;height:22px" >외국인회원(foreigner)</label>
					</td>
				</tr>
				<tr>
					<td>
						<label ><input type="radio" name="certify" value="1_휴대폰" style="font-size:12px; width:25px;height:22px" checked>휴대폰인증</label>
						<label ><input type="radio" name="certify" value="2_이메일" style="font-size:12px; width:25px;height:22px">이메일인증</label>
					</td>
				</tr>
				<tr>
					<td>
						<button>휴대폰인증</button>
						<p>본인 명의의 휴대폰으로 본인인증을 진행합니다.</p>
					</td>
				</tr>
				<tr class="infor">
					<td >&nbsp;INFORMATION <!--  인포메이션 시작~~~~~--></td>
					<td>*필수입력사항</td>
				</tr>
				<tr>
					<td><input type="text" name="uID" id="uID" placeholder="아이디"class="full"></td>
				</tr>

				<tr>
					<td><input type="password" name="uPw" id="uPw" placeholder=" 비밀번호 (영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8자~16자)"class="full"></td>
				</tr>

				<tr>
					<td><input type="password" name="uPw_Re" id="uPw_Re" placeholder=" 비밀번호 확인" class="full"></td>
				</tr>

				<tr>
					<td class="uZip"><input type="text" id="uZip" name="uZip" placeholder=" 주소"size="64" readonly>
						<button type="button" id="zipBtn" onclick="kakaopost()">우편번호</button>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="uAddr" name="uAddr1" placeholder=" 기본주소" class="full" readonly>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="uAddr2" name="uAddr2" placeholder=" 나머지주소 (선택입력가능)" class="full">
					</td>
				</tr>
				<tr>
					<td>
						<input type="hidden" name="authority" id="authority" value="user"/>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	<button type="button" id="btn-Join"
	style="position: relative;left:1000px">회원가입</button>
 </div>


 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <!--  카카오 우편번호 예제시작-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function kakaopost() {
    new daum.Postcode({
        oncomplete: function(data) {
           document.querySelector("#uZip").value = data.zonecode;
           document.querySelector("#uAddr").value = data.address;
        }
    }).open();
}
</script>
<!--  카카오 우편번호 예제끝-->

<!-- jquery로 submit -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
$(document).ready(function() {
	$('#btn-Join').click(function () { 
		$("form").submit(); 
	});
});
</script>

</body>
</html>