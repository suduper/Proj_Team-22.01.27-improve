
window.onload = function(){
	let res = document.getElementById('res').value;
	let parent = window.opener;
	if(res == 999){
		alert('정상');
	}
	if(res == 1){
		alert('성공');
		parent.document.getElementById('BuyFin').submit();	
		self.close();
	} else if(res == 2){
		alert('구매세션이 만료되었습니다.');
		parent.location.href="../Main/Main.jsp";
		self.close();
	} else if(res == 0){
		alert('대단히 죄송합니다. 결제 관련 오류입니다. 나중에 다시 시도해 주십시오.' + res);
		self.close();
	}
}