function goSerch(){
	alert('작동');
}
function changeState(state){
	document.getElementById('changeState').value = state;
	alert(document.getElementById('changeState').value);
	$('#OrderStateChange').submit();
}
