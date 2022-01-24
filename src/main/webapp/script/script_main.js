 $(document).ready(function(){
	$("#nav1>ul>a").click(function(){
		$(this).next("li").toggleClass("hide");
	});
});