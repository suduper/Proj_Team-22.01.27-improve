///////////////////////////////////////////////////////////
////////////////////바닐라 JS 영역 시작/////////////////////
///////////////////////////////////////////////////////////


/////////// 뷰페이지(=내용 보기 페이지) 이동 시작 ///////////
function read(param) {
	location.href="Read.jsp?num="+param ;
}	
/////////// 뷰페이지(=내용 보기 페이지) 이동 끝 ///////////
	

///////////////////////////////////////////////////////////
////////////////////바닐라 JS 영역 끝/////////////////////
///////////////////////////////////////////////////////////


$(function(){
/*
	const editor = document.getElementById("write");
	editor.contentEditable ='false';
	$("#info :input").attr("disabled",true); 
	*/

	
	const editor = document.getElementById("write");
	editor.contentEditable ='false';
	

    $('#goodsType').prop('disabled', true);
    $('#goodsPrice').prop('disabled', true);
    $('#goodsSPrice').prop('disabled', true);
    
    $('#insertInfo').click(function (){
		$('#goodsType').prop('disabled', false);
    	$('#goodsPrice').prop('disabled', false);
  		$('#goodsSPrice').prop('disabled', false);
  		editor.contentEditable ='true';
	});
	
	
	
	// 상품정보 아래 textarea 안보이게함 //
	const hideT = document.getElementById('hider');
	hideT.style.display = 'none';
	
	$('#checkC').click(function (){
		this.form.submit();
	});
	
	// 상품등록 버튼 클릭시 실행되는 것들 //
	$('#submit').click(function () { 

		let goodsType = $("#goodsType").val().trim();
		let goodsPrice = $("#goodsPrice").val().trim();
		let goodsSPrice = $("#goodsSPrice").val().trim();
		 if (goodsType == "1") {
			alert("상품 종류 미선택.");
			$("#goodsType").focus();
			
		} else if (goodsPrice == "") {
			alert("상품 가격 미입력.");
			$("#goodsPrice").focus();
		} else {
			if (goodsSPrice == "") {
			$("#goodsSPrice").val(0)
			}
			// 상품정보 아래 textarea에 div#write 복사 //
			const writer = jQuery.trim(document.getElementById('write').innerHTML);
			const setT = document.all("goodsContent");
			setT.innerHTML = writer;
			alert(writer);
			
			
			
			// 전송 //
			//$("#goodsInfo1").submit();
			$("#goodsInfo2").submit();
		}
		
	});
	
	
	
	
});

