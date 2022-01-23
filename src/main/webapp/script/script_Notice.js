

/* function ReviewRead(param) {
	location.href="ReviewRead.jsp?num="+param;
} */

function NoticeRead(p1, p2) {
	let param = "NoticeRead.jsp?num="+p1;
	     param += "&nowPage="+p2;
	location.href=param;
}	

function movePage(p1){

	let param = "NoticeList.jsp?nowPage="+p1;
	location.href = param;
}

function moveBlock(p1, p2) {    // 블럭 이동

	let pageNum = parseInt(p1);
	let pagePerBlock = parseInt(p2);	
	
	let param = "NoticeList.jsp?nowPage="+(pagePerBlock*(pageNum-1)+1);
	location.href=param;

}

function deleteCheck(){
	
	if(confirm("정말 삭제하시겠습니까?")==true){
		document.delFrm.submit();
		let param = "NoticeList.jsp";
		location.href = param;
	}else{
		return false;
	}
}

$(function(){
// 헤더푸터
    $("#goods").mouseover(function(){
        $(".goods1").css({"display" : "block"});
    });

    $("#goods").mouseout(function(){
        $(".goods1").css({"display" : "none"});
    });

    $("#board1").mouseover(function(){
        $(".board").css({"display" : "block"});
    });

    $("#board1").mouseout(function(){
        $(".board").css({"display" : "none"});
    });

    $("#search1").mouseover(function(){
        $(".search2").css({"display" : "block"});
    });

    $("#search1").mouseout(function(){
        $(".search2").css({"display" : "none"});
    });

// 헤더푸터 끝

// 게시판 등록
	$("#regBtn").click(function(){
		let content = $("#content").val().trim();
		let subject = $("#subject").val().trim();
		
		if(subject == ""){
			alert("제목을 입력하세요");
			$("#subject").focus;
		} else if(content == ""){
			alert("내용을 입력하세요");
			$("#content").focus;
		}else{
			$("#postFrm").submit();
		}
		
	});
// 게시판 등록 끝

	$("#modBtn").click(function(){
		
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
		
		let url = "../Notice/NoticeUpdate.jsp?num="+num+"&nowPage="+nowPage;
		location.href=url;
		
	})
	
		$("#regBtnMod").click(function(){
		let uName = $("#uName").val().trim();
		let subject = $("#subject").val().trim();
		let content = $("#content").val().trim();
		
		if(uName == ""){
			alert("이름을 입력하세요");
			$("#uName").focus;
		} else if(subject == ""){
			alert("제목을 입력하세요");
			$("#subject").focus;
		}else if(content == ""){
			alert("내용을 입력하세요");
			$("#content").focus;
		}else{
			$("#UpdateFrm").submit();
		}
		
	});
	
		$("#delBtn").click(function(){
		
		let nowPage = $("input#nowPage").val().trim();
		let num = $("input#num").val().trim();
		
		if(confirm("정말 삭제하시겠습니까?")==true){
				let url = "../Notice/NoticeDelete.jsp?num="+num+"&nowPage="+nowPage;
				location.href=url;
	}else{
		return false;
	}
		
	});

		
		$("#searchBtn").click(function(){
		let keyWord = $("#keyWord").val().trim();
		if (keyWord=="") {
			alert("검색어를 입력해주세요.");
			$("#keyWord").focus();			
		} else {
			$("#searchFrm").submit();
		}
	});
	
		$("#modSbmBtn").click(function(){
		
		let pass = $("input#modpass").val().trim();
		
		if(pass == ""){
			$("input#modpass").focus();
			alert("비밀번호를 입력하세요");
			return;
		}else{
			$("#modFrm").submit();
		}
	});
	
		$("#listBtn").click(function(){
		let param = $("#nowPage").val().trim();
	     
		let url = "../Notice/NoticeList.jsp?nowPage=" + param;
		location.href=url;
	});





});