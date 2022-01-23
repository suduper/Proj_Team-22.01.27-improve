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
<title>회원가입수정</title>
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
	String uEmail = user.getuEmail();
	String uZip = user.getuZip();
	String uAddr1 = user.getuAddr1();
	String uAddr2 = user.getuAddr2();
	String PhoneNum1 = user.getPhoneNum1();
	String PhoneNum2 = user.getPhoneNum2();
	String PhoneNum3 = user.getPhoneNum3();
/* 	Int      BirthYear =user.getBirthYear();
	Int      BirthMonth =user.getBirthMonth();
	Int      BirthDay =user.getBirthDay(); */
	%>
        
<div id="wrap">
	<form action="Member_ModAction.jsp" method="get" id="regFrm" name="regFrm">
		<table>
			<tbody>
			<caption>회원가입수정</caption>
				
				<tr>
					<td><input type="text" name="uID" id="uID" value="<%=uIDD%>"class="full" readonly="readonly"></td>
				</tr>

				<tr>
					<td><input type="password" name="uPw" id="uPw" value="<%=uPw%>"class="full"></td>
				</tr>
				<tr>
					<td><input type="password" name="uPw_Re" id="uPw_Re" placeholder="비밀번호 확인" class="full"></td>
				</tr>

				<tr>
					<td class="uZip"><input type="text" id="uZip" name="uZip" size="64"value="<%=uZip%>" readonly>
						<button type="button" id="zipBtn" onclick="kakaopost()" style="cursor: pointer;">우편번호</button>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="uAddr1" name="uAddr1" value="<%=uAddr1%>" class="full" readonly>
					</td>
				</tr>
				<tr>
					<td>
						<input type="text" id="uAddr2" name="uAddr2" value="<%=uAddr2%>" class="full">
					</td>
				</tr>
				<tr>
				<td>
				
				<select name="phoneNum1" id="phoneNum1" style="width:150px;height:40px; padding: 5px;  border: 1px solid #000; value="<%=PhoneNum1%>">
					<option value="010" >010</option>
					<option value="011">011</option>
					<option value="016">016</option>
					<option value="017">017</option>
					<option value="018">018</option>
					<option value="019">019</option>
				</select>
				
				<span style="margin-left: 5px; margin-right: 5px;">-</span>
				<input type="text" placeholder="휴대전화"id="" style="padding-left: 5px;font-size: 12px; width: 155px" id="phoneNum2" name="phoneNum2" value="<%=PhoneNum2%>" >
				
				<span style="margin-left: 5px; margin-right: 5px;">-</span>
				<input type="text" style="padding-left: 5px;font-size: 12px;" id="phoneNum3" name="phoneNum3" value="<%=PhoneNum3%>">
				
				</td>
				</tr>
				<tr>
				<td>
						<input type="text" id="uEmail" name="uEmail" placeholder="이메일" class="full" style="padding: 8px" value="<%=uEmail%>">
				</td>
				</tr>
				<tr>
				<td>배송 받으실 성함</td>
				</tr>
			<!--	<tr>
				<td >
				<input type="number" id="birthYear" name="birthYear"> <span>년</span>
				<input type="number" id="birthMonth" name="birthMonth"> <span>월</span>
				<input type="number" id="birthDay" name="birthDay"> <span>일</span>
				</td>
				</tr>  생일-->
				<tr>
					<td>
						<input type="text" id="uName" name="uName" placeholder="배송받으실 성함" class="full" style="padding: 5px;" value="<%=uName%>">
					</td>
				</tr>

	            <tr class="infor">
					<td ><button type="button" id="btn-Join" class="Join_btn" style="background-color: #000; color: #fff">정보수정</button></td>
					<td><button type="button" id="btn-Cancel" class="Join_btn"style="background-color: #fff; color: #000">정보수정취소</button></td>
				</tr>

			<!-- 체크박스 끝 -->
		</table>
	</form>
	
	
 </div>
<%@include file="../Main/Main_Bottom.jsp" %>

 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <!--  카카오 우편번호 예제시작-->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function kakaopost() {
    new daum.Postcode({
        oncomplete: function(data) {
           document.querySelector("#uZip").value = data.zonecode;
           document.querySelector("#uAddr1").value = data.address;
        }
    }).open();
}
</script>
<!--  카카오 우편번호 예제끝-->

<!-- jquery로 submit -->
<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script>


//아이디 유효성검사시작
	$("#btn-Join").click(function(){
		
		let uID = $("#uID").val();
		let uIdLen  = uID.length;
		let uIdReg = /[^a-z|A-Z|0-9|_]/;
		if (uIdLen < 5) {
			alert("ID는 영어, 숫자, 특수기호(_), 5글자 이상 20글자 이하");
			$("#uID").focus();
			return;
		} else if(uIdReg.test(uID)) {
			alert("ID는 영어, 숫자, 특수기호(_), 5글자 이상 20글자 이하");
			$("#uID").focus();
			return;
		}
		//아이디 검사끝
		//비밀번호 및 회원가입필수들 시작
		let uPw = $("#uPw").val();
		let uPw_Re = $("#uPw_Re").val();
		let uName = $("#uName").val();
		let uEmail = $("#uEmail").val();
		let uAddr1 = $("#uAddr1").val();
		let uAddr2 = $("#uAddr2").val();
		let uAddr = uAddr1 + " " + uAddr2;

		//let uIdBtnClickChk = $("#uIdBtnClickChk").val();
		if(uID == "") {    	// 아이디 검사 시작
			alert("ID를 입력해주세요");
			$("#uID").focus();
			
			$("#uID").focus(function(){
				$(this).css({"outline": "1px solid #555"});	
			}).blur(function(){
				$(this).css({"outline": "none"});	
			});					
			// 아이디 검사 끝
		} else if (uPw == "") {     // 비밀번호 검사 시작
			alert("비밀번호를 입력하세요.");
			$("#uPw").focus();
		} else if (uPw != uPw_Re) {     // 비밀번호 동일검사 시작
			alert("비밀번호가 다릅니다. 확인 후 다시 입력하세요.");
			$("#uPw_Re").val("");
			$("#uPw").focus();
		} else if (uEmail == "") {     // 이메일 검사 시작
			alert("이메일을 입력하세요.");
			$("#uEmail").focus();
		} else if (uEmail.indexOf("@") < 0 || uEmail.indexOf(".") < 0) {     // 이메일 검사 시작
			alert("이메일주소를 확인하세요.");
			$("#uEmail").focus();
		} else {
			$("#uAddr").val(uAddr);
			
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
