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

<div id="wrap">
<table>
	<tbody>
	<caption>마이페이지</caption>
		<tr>
			<td style="border: 1px solid #000; cursor: pointer; text-align:center; height: 130px;" id="ifLogin"  >
			<span style="font-size: 11px;">회원 로그인 시 주문처리 현황을 확인하실 수 있습니다. <br> (클릭 시 비회원 주문 조회가 가능합니다.)</span>
			</td>
		</tr>
		<tr style="display: flex;justify-content:space-between; margin-top: 20px; height: 70px; text-align:center;" class="Mytr">
			<td style="border: 1px solid #000; width:49%; font-size:11px ;"class="Mytd">주문조회</td>
			<td style="border: 1px solid #000;  width:49%; font-size: 11px;"class="Mytd">회원정보</td>
		</tr>
		<tr style="display: flex;justify-content:space-between; margin-top: 20px; height: 70px; text-align:center;" class="Mytr">
			<td style="border: 1px solid #000; width:49%; font-size:11px ;"class="Mytd">위시리스트</td>
			<td style="border: 1px solid #000;  width:49%; font-size: 11px;"class="Mytd">적립금</td>
		</tr>
		<tr style="display: flex;justify-content:space-between; margin-top: 20px; height: 70px; text-align:center;" class="Mytr">
			<td style="border: 1px solid #000; width:49%; font-size:11px ;" class="Mytd">쿠폰</td>
			<td style="border: 1px solid #000;  width:48%; font-size: 11px;"class="Mytd">내게시물</td>
		</tr>
		<tr style="display: flex;justify-content:space-between; margin-top: 20px; height: 70px; text-align:center;" class="Mytr">
			<td style="border: 1px solid #000; width:49%; font-size:11px ;" class="Mytd">배송주소록</td>
			<td style="border: 1px solid #000;  width:49%; font-size: 11px;" class="Mytd">정기배송 관리</td>
		</tr>
	</tbody>
</table>
</div>

</body>
 <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 <script>
 $(function(){
	 
 });
 </script>
</body>
</html>