

function read(param) {
	location.href="Read.jsp?num="+param;
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
		let uName = $("#uName").val().trim();
		let subject = $("#subject").val().trim();
		let pass = $("#pass").val().trim();
		
		if(uName == ""){
			alert("이름을 입력하세요");
			$("#uName").focus;
		} else if(subject == ""){
			alert("제목을 입력하세요");
			$("#subject").focus;
		}else if(pass == ""){
			alert("비밀번호를 입력하세요");
			$("#pass").focus;
		}else{
			$("#postFrm").submit();
		}
		
	});
// 게시판 등록 끝


});