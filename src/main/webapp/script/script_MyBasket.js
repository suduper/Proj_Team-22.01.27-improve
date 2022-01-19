

let checkboxes =null;
let sum = 0;
let val = null;
let rs = null;
let checkCount = 0;
let selectAllCnt = 0;
let AllBuyCost = document.getElementById('AllBuyCost');
let childOpenWindow; // 자식 창 오픈 
let uID = null;
let insertDiv =null;

if(document.getElementById('uID')){ 
	if(document.getElementById('uID').value != null){
		uID = document.getElementById('uID').value;
	}	
}

//전체선택
function selectAll(selectAll,listSize)  {
  	for(let i = 0; i < listSize ; i++){
		checkboxes = document.getElementsByName('buyThis'+i);
		$(checkboxes).prop('checked',true);
		checkboxes.forEach((checkbox) => { 
			checkbox.checked = selectAll.checked;
		})
	}
	if(selectAllCnt == 0){	
		checkNum = listSize; 
		selectAllCnt++;
	} else if(selectAllCnt == 1){
		checkNum = -1; selectAllCnt = 0;
	}
	PayCalc(listSize,checkNum);
}
//전체선택 및 삭제 전송

//일부선택 및 삭제 and 전체선택/삭제 전송처리
function PayCalc(listSize,checkNum){
	if(checkNum == -1){
		rs = " 전체 감소 : "
		val =" all 0 ";
		sum = 0;
		console.log(checkNum + rs + val + " 전체 : " + sum);
		AllBuyCostCalc(sum);
		
	} else if(listSize == checkNum){
		sum = 0;
		for(let i = 0; i < checkNum; i++){
			checkboxes = document.getElementsByName('buyThis'+i);
			rs = "전체 추가 : "
			val = $("#calcRes"+i).val();
			if(val == undefined){
				val = 0;
			}
			sum = sum + parseInt(val);
			AllBuyCostCalc(sum);
		}
		console.log(checkNum + rs + " 전체 : " + sum);
	} else {
		checkboxes = document.getElementsByName('buyThis'+checkNum);
		val = $("#calcRes"+checkNum).val();
		isThisChecked = $(checkboxes).is(":checked");
		if(isThisChecked == true){
			rs = "추가 : ";
			sum = sum + parseInt(val);
			AllBuyCostCalc(sum);
		} 
		if(isThisChecked == false) {
			rs = "감소 : "
			sum = sum - parseInt(val);
			$('.goods'+checkNum).remove();
			AllBuyCostCalc(sum);
		}
		console.log(checkNum + rs + val + " 전체 : " + sum);
	}
}
//일부선택 및 삭제


//금액 계산 결과 변환기
function AllBuyCostCalc(sum){
	document.getElementById('forSubmitPrice').value = sum;
	let res = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	document.getElementById('AllBuyCost').innerHTML = res;
}
//금액 계산 결과 변환기

function DelBasket(listSize){
	let form = document.getElementById('buyGoods');
	if(document.getElementById('AllBuyCost').innerHTML == 0){
		alert('장바구니에서 삭제할 상품을 선택해주세요');
		return false;	
	}
	alert("DelBasketProc.jsp?count="+listSize);
	form.action="DelBasketProc.jsp?count="+listSize;
	form.submit();
	 
}

function BuyIt(listSize){
	let form = document.getElementById('buyGoods');
	if(document.getElementById('AllBuyCost').innerHTML == 0){
		alert('구매하실 상품을 선택해 주세요');
		return false;	
	}
	form.action="GoodsBuy.jsp?count="+listSize;
	form.submit();
}



let CC = 0;
let Zip = document.getElementById('Zip');
let Addr1 = document.getElementById('Addr1');
let Addr2 = document.getElementById('Addr2');
let origZip = document.getElementById('Zip').value;
let origAddr1 = document.getElementById('Addr1').value;
let origAddr2 = document.getElementById('Addr2').value;

function changeZip(){
	if(CC == 0){
		CC++;
		Zip.value = null;
		Addr1.value = null;
		Addr2.value = null;
		console.log(CC);
		$('#changeZip').attr('onclick','kakaopost()');
		$('#changeZip').attr('style','background-color: #fff');
	}else if(CC != 0){
		Zip.value = origZip;
		Addr1.value = origAddr1;
		Addr2.value = origAddr2;
		CC = 0;
		console.log(CC);
		$('#changeZip').attr('onclick','')
		$('#changeZip').attr('style','background-color: #D9D9D9');
	}
	
}

//상품구매
function Purchase(getUID,sum){
	window.name = getUID+'payment'; 
	childOpenWindow = window.open('../GoodsUpload/CheckYourWallet.jsp?info='+getUID+"/"+sum, 
								"CheckYourWallet", "width=500, height=500, \
								resizable = no, scrollbars = no");
}
//상품구매

function callWallet() { 
	alert('확인');
	$('#Purchase').submit();
    //self.close();
}


////////
/*function CselectAll(selectAll,listSize){
	for(let i = 0; i < listSize ; i++){
		checkboxes = document.getElementsByName('CancelThis'+i);
		$(checkboxes).prop('checked',true);
		checkboxes.forEach((checkbox) => {
			checkbox.checked = selectAll.checked;
		})
	}
	if(selectAllCnt == 0){	
		checkNum = listSize; 
		selectAllCnt++;
	} else if(selectAllCnt == 1){
		checkNum = -1; selectAllCnt = 0;
	}
	PayCalc(listSize,checkNum);	
}
*/
function CancelIt(){
	alert('작동')
	if(document.getElementById('AllBuyCost').innerHTML == 0){
		alert('구매 취소하실 상품이 선택되지 않았습니다.');
		return false;	
	}
	$("#CancelGoods").submit();
}