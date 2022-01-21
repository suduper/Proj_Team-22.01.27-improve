function forUpdate(goodsName){
	location.href="GoodsUpdate.jsp?goodsName="+goodsName;
}
function forList(){
	location.href="GoodsList.jsp";
}
function forReview(){
	location.href="../Review/ReviewList.jsp";
}
let origPrice = null;
let nowday = new Date();   
let weekday = nowday.getDay();
let hours = nowday.getHours(); 
let arrival = null;
let send = null;

let uID = document.getElementById('uID').value;

if(10 < hours && hours < 16){ //오늘발송
	if(weekday == 5 || weekday == 6){
		send = '월요일';
	} else {
		send = '오늘';
	}
	arrival = weekday + 2;
	alert(weekday);
	alert(arrival);
} else {    //내일발송
	if(weekday == 4){
		send = '월요일'; 
	}
	send = '내일'
}
 
window.onload = function(){
	$('#arriveDate').append(send);
};



let SALL = 0;
let MALL = 0;
let LALL = 0;
let XLALL = 0;
let sum = 0;

function choice(size,sellPrice){
	let selector = '#'+'add'+size;
	let buyCount = 
		'<div id="buyCount'+size+'" style="display: flex;"> \
		<p id="plus'+size+'" class="no-drag" onclick='+'count("plus'+size+'","'+sellPrice+'","'+size+'")'+'\
			style="border: 1px solid #000; width: 40px; \
				   height: 40px; line-height: 40px; text-align: center; border-radius:3px;">+</p> \
		<p id="result'+size+'" \
			style="border: 1px solid #000; width: 40px; \
				   height: 40px; line-height: 40px; text-align: center; border-radius:3px;">1</p> \
		<p id="minus'+size+'" class="no-drag" onclick='+'count("minus'+size+'","'+sellPrice+'","'+size+'")'+'\
			style="border: 1px solid #000; width: 40px; \
				   height: 40px; line-height: 40px; text-align: center; border-radius:3px;">-</p> \
		<p id="delete'+size+'" style="border: 1px solid #000; width: 40px; \
			height: 40px; line-height: 40px; text-align: center; margin-left:15px; border-radius:3px;" \
			onclick='+'del("'+size+'","'+sellPrice+'")'+'>취소</p> \
		</div> ' ;
	$(selector).append(buyCount);
	document.getElementById("P"+size).setAttribute("onclick","del('"+size+"','"+sellPrice+"')");
	if(size == 'S'){
		SALL = 1;
		calc(sellPrice);
	} else if(size == 'M') {
		MALL = 1;
		calc(sellPrice);
	} else if(size == 'L') {
		LALL = 1;
		calc(sellPrice);
	} else {
		XLALL = 1;
		calc(sellPrice);
	}
}

function del(size,sellPrice){
	let resetter = document.getElementById("P"+size);
	$('#buyCount'+size+'').remove();
	resetter.setAttribute("onclick","choice('"+size+"','"+sellPrice+"')");
	if(size == 'S'){
		SALL = 0;
		calc(sellPrice);
	} else if(size == 'M') {
		MALL = 0;
		calc(sellPrice);
	} else if(size == 'L') {
		LALL = 0;
		calc(sellPrice);
	} else {
		XLALL = 0;
		calc(sellPrice);
	}
}

function count(type,sellPrice,size)  {

	// 결과를 표시할 element
	let resultElement = document.getElementById('result'+size);
  
 	// 현재 화면에 표시된 값
  	let number = resultElement.innerText;
  	expP = /plus/;
  	expM = /minus/;
  	// 더하기/빼기
  	if(expP.test(type))	{
    	number = parseInt(number) + 1;
  	} else if(expM.test(type))	{
    	if(parseInt(number) == 1){
		number = parseInt(number)
		} else {
			number = parseInt(number) - 1;
		}
  	}
  	
  	if(size == 'S'){
		SALL = number;
		calc(sellPrice);
	} else if(size == 'M') {
		MALL = number;
		calc(sellPrice);
	} else if(size == 'L') {
		LALL = number;
		calc(sellPrice);
	} else {
		XLALL = number;
		calc(sellPrice);
	}
	
	// 결과 출력
  	resultElement.innerText = number;
  
}

function calc(sellPrice){
	let fullCalc = SALL + MALL + LALL + XLALL;
	let allCount = document.getElementById('Allcount');
	let calcRes = document.getElementById('calcRes');
	let SallCount = document.getElementById('SAllcount');
	let ScalcRes = document.getElementById('ScalcRes');
	
	let res = sellPrice * fullCalc;
	allCount.value = fullCalc;
	SallCount.value = fullCalc;
	if(res == 0){
		res = 0;
	}
	document.getElementById('Scount').value = SALL;
	document.getElementById('Mcount').value = MALL;
	document.getElementById('Lcount').value = LALL;
	document.getElementById('XLcount').value = XLALL;
	calcRes.value = res;
	let resCG = res.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	ScalcRes.value = resCG;
}

function addBasket(){
	if(uID == 'null'){
		if(confirm("로그인 하셔야 합니다. 로그인하시겠습니까?")) {
        location.href='../Account/Login.jsp';
        } 
	} else if(SALL == 0 && MALL == 0 && LALL == 0 && XLALL == 0){
		alert('상품의 사이즈와 갯수를 선택해주세요.');
	} else {
		$("#addBasket").submit(); 
	}
}
/*
$(document).ready(function(){ 
	var currentPosition = parseInt($(".buyOption").css("top"));
	$(window).scroll(function() {
		var position = $(window).scrollTop();
		$(".buyOption").stop().animate({"top":position+currentPosition+"px"},1000); 
	});
});
*/
