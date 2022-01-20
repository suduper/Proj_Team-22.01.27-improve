<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     
<%@page import="java.io.File"%> 
<%@ page import="java.util.Base64" %>
<%@ page import="java.util.Base64.Encoder" %>
<%@ page import="java.util.Base64.Decoder" %>
  
<%@ page import="pack_goods.Goods" %>
<jsp:useBean id="goods" class="pack_goods.GoodsProc"  scope="page" />
    
<%	request.setCharacterEncoding("UTF-8"); %>

<%@page import="java.io.PrintWriter"%>
 
<%
	String uID = null;
	if(session.getAttribute("uID") != null){ 
		uID = (String)session.getAttribute("uID"); 
	} 
	/* String authority = null;
	if(session.getAttribute("authority") == "admin"){ 
		authority = (String)session.getAttribute("authority");		
	} else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다!!!')");
		script.println("location.href='../Main/Main.jsp'");
		script.println("</script>");
	} */
	String goodsNameParam = null;
	 
	if((String)request.getParameter("goodsName") != null){
		goodsNameParam = (String)request.getParameter("goodsName");
	}
	
	
	Encoder encoder = Base64.getEncoder();
	Decoder decoder = Base64.getDecoder();
	
	Goods view =goods.getGoodsView(goodsNameParam);
	
	String goodsName = view.getGoodsName(); // 상품 이름
	int NL = goodsName.length();	 				// Name Length = 서버내 상품이름길이
	int TL = NL - 11;                  					 // True length = 서버내 상품이름에서 날짜 빼기
	String showName = goodsName.substring(0,TL); 	// 표기할 상품명 생성
	String dates = goodsName.substring(TL,NL); // 상품 등록 날짜
	byte[] getName = showName.getBytes(); //바이트로 변환
	String tloc = encoder.encodeToString(getName); //인코딩
	tloc = (tloc + dates).replaceAll("/", "{"); //이름 내의/를 {로 변환
		
	
	String goodsImages =view.getGoodsImages(); 	// 상품 이미지 이름
	String[] imgArray = goodsImages.split(" / ");
	int imgL = imgArray.length;
	
	/*
	String SAVEFOLDER ="C:/ShoppingMall/"
			   						+ "Project_Lofi_Co-op/"
			   						+ "src/main/webapp/"
			  						+ "Resource/GoodsImg/";
	String DirImg = SAVEFOLDER+view.getGoodsName();
	String DirThumb = DirImg+"/thumb/";

	String[] oldImgS;
	int imgC = 0;
	File oldImg = new File(DirImg);
	if(oldImg.isDirectory()){
		File[] oldImgList  = oldImg.listFiles();
		oldImgS = new String[oldImgList.length];
		for(int i = 0 ; i < oldImgList.length; i++){
			if(oldImgList[i].getName().equals("thumb")){
				continue;
			}
			oldImgS[i] = oldImgList[i].getName();
			out.println(oldImgS[i]);
			imgC ++;
		}
	}
	String Tset = null;
	String[] oldThumbS;
	int thumbC = 0;
	File oldThumb = new File(DirThumb);
	if(oldThumb.isDirectory()){
		File[] oldThumbList = oldThumb.listFiles(); 
		oldThumbS = new String[oldThumbList.length];
		for(int i = 0; i < oldThumbList.length; i++){
			oldThumbS[i] = oldThumbList[i].getName();
			out.println(oldThumbS[i]);
			if(i == 0){
				Tset = oldThumbS[0];
			}
			thumbC++;
		}
	}
	*/
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>GoodsUpdate</title>

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
div#oldImg {
	width: 800px;
	height: 120px;
	border: 1px solid #000;
	display: flex;
}
img#gImg {
	border :1px solid #000;
	width: 90px;
	height: 90px;
	object-fit: contain;
	margin-left: 5px;
}
</style>

</head>
<body>

<jsp:include page="../Main/Main_Top.jsp" flush="true"/>

<div id="wrap">

	<form action="GoodsUpdateProc.jsp
							?oldGoodsInfo=
							<%=view.getGoodsName() %>//
							<%=view.getGoodsThumbnail() %>//
							<%=view.getGoodsImages() %>//"
							 method="post" id="send" enctype="multipart/form-data">	
	
	현재 썸네일
	<img id="thumb" src="../Resource/GoodsImg/<%=tloc %>/thumb/thumb_<%=view.getGoodsThumbnail() %>" alt="" />

	<br>
	<br>
	
	<div id="newThumb">
		변경 썸네일 : <input type="file" id="goodsThumbnail" name="goodsThumbnail" multiple="multiple" accept='.png, .jpg' required="required"/>
		 <div id="Thumb_drop">
		 	<p>썸네일 drag & drop</p>
			<div id="Preview_Thumb">
			</div>
		</div>	
		<br>
	</div>
	
	현재 이미지
	<div id="oldImg">
		<%for(int i = 0 ; i < imgL ; i++){ %>
			<img id="gImg" src="../Resource/GoodsImg/<%=tloc %>/<%=imgArray[i] %>"/><br>
		<%} %>
	</div>
	
	<br>
	<br>
	
	<div id="newImg">
		상품 이미지 : 
		<input type="file" id="goodsImages" name="goodsImages" multiple="multiple" accept='.png, .jpg' required="required">
		<div id="Img_drop">
		 	<p>이미지 drag & drop</p>
			<div id="Preview_Img">
			</div>
		</div>
	</div>
	
	<input type="button" id="reset" value="모든 이미지 재선택" />
	<br>
	<br>
	
	상품 내용
		<div id="write" contenteditable="true" spellcheck="true" >
		<%=view.getGoodsContent() %>
		</div>
		<div id="hider">
			<textarea name="goodsContent" id="goodsContent" placeholder="테스트"></textarea> 
		</div>
		
		상품명 : 
	<input type="text" name="goodsName" id="goodsName" 
				value="<%=showName%>"/>
	
	상품 입고일 : 
	<input type="text" name="goodsWarehousing" id="goodsWarehousing" placeholder="yy.mm.dd"
				value="<%= view.getGoodsWarehousing()%>"/>
	
	현재 상품 종류 : 
	<%=view.getGoodsType() %>
	
	상품 종류 : 
		<select name="goodsType" id="goodsType">
			<option value='1' selected="selected">-- 선택 --</option>
  			<option value='정장' >정장</option>
  			<option value='패딩' >패딩</option>
  			<option value='기타'>기타</option>
		</select>
		
	상품 판매 가격 : 
		<input type="text" name="goodsPrice" id="goodsPrice"
					value="<%=view.getGoodsPrice()%>" maxlength="7"/>
		
	상품 세일 가격 :
		<input type="text" name="goodsSPrice" id="goodsSPrice" placeholder="미입력시 세일가격은 0원입니다."
					value="<%=view.getGoodsSPrice()%>" maxlength="7"/>
	<br>
		
	<br>
	<input type="button" id="btnSubmit" value="상품 수정"/>
	</form>
</div>
<button type="button" id="goback" onclick='history.back();'>뒤로가기</button>

<jsp:include page="../Main/Main_Bottom.jsp" flush="true"/>


<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
<script src="../script/script_GoodsUpdateImg.js"></script>
<script type="text/javascript">
	var oldGT = '<%=view.getGoodsType()%>';
	if(oldGT == '정장'){
		$("#goodsType option:eq(1)").prop("selected",true);
	} else if (oldGT == '패딩'){
		$("#goodsType option:eq(2)").prop("selected",true);
	} else if (oldGT == '기타'){
		$("#goodsType option:eq(3)").prop("selected",true);
	}
</script>
</body>
</html>