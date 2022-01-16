<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>
 
<%
	String uID = null;
	if(session.getAttribute("uID") != null){
		uID = (String)session.getAttribute("uID"); 
	} 
	String authority = null;
	if(session.getAttribute("authority").equals("admin")){ 
		authority = (String)session.getAttribute("authority");		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	}

%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsUpload</title>

<style>
div#Thumb_drop {
width: 200px;
height: 200px;
border: 1px solid #000;
}
div#Img_drop {
width: 800px;
height: 120px;
border: 1px solid #000;
}
div#Preview_Thumb {
display: flex;
flex-wrap: wrap;
}
div#Preview_Img {
display: flex;
flex-wrap: wrap;
}
div#write {
width: 200px; 
height: 200px; 
border: 2px solid #000;
}
img#thumb {
	border :1px solid #000;
	width: 150px;
	height: 150px;
	object-fit: contain;
	margin-left: 5px;
}
img#Img {
	border :1px solid #000;
	width: 90px;
	height: 90px;
	object-fit: contain;
	margin-left: 5px;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
  -webkit-appearance: none;
  margin: 0;
} 
</style>

</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">
	<form action="GoodsUploadProc.jsp" method="post" id="send" enctype="multipart/form-data">
	상품명 : <input type="text" name="goodsName" id="goodsName" />
	
	상품 입고일 : 
	<input type="text" name="goodsWarehousing" id="goodsWarehousing" placeholder="yy.mm.dd"/>
	
	상품 종류 : 
		<select name="goodsType" id="goodsType">
			<option value='1' selected>-- 선택 --</option>
  			<option value='정장'>정장</option>
  			<option value='패딩'>패딩</option>
  			<option value='기타'>기타</option>
		</select>
	상품 판매 가격 : 
		<input type="number" name="goodsPrice" id="goodsPrice" min="1000" max="9999999"/>
		
	상품 세일 가격 :
		<input type="number" name="goodsSPrice" id="goodsSPrice" placeholder="미입력시 세일가격은 0원입니다." min="1000" max="9999999"/>
	<br>
	<br>
	<div id="inventoryList">
		재고량 
		S재고 : <input type="number" name="inventoryS" id="inventoryS" max="999"/>
		M재고 : <input type="number" name="inventoryM" id="inventoryM" max="999"/>
		L재고 : <input type="number" name="inventoryL" id="inventoryL" max="999"/>
		XL재고 : <input type="number" name="inventoryXL" id="inventoryXL" max="999"/>
	</div>
	<br>
	썸네일 : <input type="file" id="goodsThumbnail" name="goodsThumbnail" multiple="multiple" accept='.png, .jpg' required="required"/>
	 <div id="Thumb_drop">
	 	<p>썸네일 drag & drop</p>
		<div id="Preview_Thumb">
		</div>
	</div>	
	<br> 
	상품 이미지 : 
	<input type="file" id="goodsImages" name="goodsImages" multiple="multiple" accept='.png, .jpg' required="required">
	 <div id="Img_drop">
	 	<p>이미지 drag & drop</p>
		<div id="Preview_Img">
		</div>
	</div>
	<input type="button" id="reset" value="이미지 재선택" />
	<br>
	상품 내용
		<div id="write" contenteditable="true" spellcheck="true" ></div>
		<div id="hider">
			<textarea name="goodsContent" id="goodsContent" placeholder="테스트"></textarea> 
		</div>
	<br>
	<input type="button" id="btnSubmit" value="업로드"/>
</form>
</div>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_GoodsImg.js"></script>

</body>
</html>