<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <!-- 템플릿 설정 윈도우->프리펀서시즈-> jsp New JSP File (html 5) -->
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>마이페이지</title>
<link rel="stylesheet" href="../style/style.css">
<body>
<%@include file="../Main/Main_Top.jsp" %>
<div id="wrap">
<table>
	<tbody>
	<caption>마이페이지</caption>
		<tr>
			<td id="ifLogin">
			<span style="font-size: 11px;">회원 로그인 시 주문처리 현황을 확인하실 수 있습니다. <br> (클릭 시 비회원 주문 조회가 가능합니다.)</span>
			</td>
		</tr>
		<tr class="Mytr">
			<td class="Mytd" id="orderCus">주문조회</td>
			<td class="Mytd" id="inforCus">회원정보</td>
		</tr>
		<tr class="Mytr">
			<td class="Mytd" id="wishCus">위시리스트</td>
			<td class="Mytd" id="moneyCus">적립금</td>
		</tr>
		<tr class="Mytr">
			<td  class="Mytd" id="couponCus">쿠폰</td>
			<td  class="Mytd" id="myCus">내게시물</td>
		</tr>
		<tr class="Mytr">
			<td  class="Mytd" id="addrCus">배송주소록</td>
			<td  class="Mytd" id="deliCus">정기배송 관리</td>
		</tr>
	
	</tbody>
</table>
</div>
<%@include file="../Main/Main_Bottom.jsp" %>
</body>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <script>
 $("#ifLogin").click(function(){
		location.href = "../Account/Login.jsp";
	});
 </script>
</body>
</html>