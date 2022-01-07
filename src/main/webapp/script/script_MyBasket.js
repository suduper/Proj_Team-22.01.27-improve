

let checkboxes =null;
let sum = 0;
let val = null;
let rs = null;
let checkCount = 0;
let selectAllCnt = 0;
let AllBuyCost = document.getElementById('AllBuyCost');
let childOpenWindow; // 자식 창 오픈 
let uID = document.getElementById('uID').value;

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
		for(let i = 0; i < checkNum; i++){
			checkboxes = document.getElementsByName('buyThis'+i);
			rs = "전체 추가 : "
			val = $(checkboxes).val();
			sum = sum + parseInt(val);
			AllBuyCostCalc(sum);
		}
		console.log(checkNum + rs + val + " 전체 : " + sum);
	} else {
		checkboxes = document.getElementsByName('buyThis'+checkNum);
		val = $(checkboxes).val();
		isThisChecked = $(checkboxes).is(":checked");
		if(isThisChecked == true){
			rs = "추가 : ";
			sum = sum + parseInt(val);
			AllBuyCostCalc(sum);
		} 
		if(isThisChecked == false) {
			rs = "감소 : "
			sum = sum - parseInt(val);
			AllBuyCostCalc(sum);
		}
		console.log(checkNum + rs + val + " 전체 : " + sum);
	}
}
//일부선택 및 삭제


//금액 계산 결과 변환기
function AllBuyCostCalc(sum){
	let res = sum.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	document.getElementById('AllBuyCost').innerHTML = res;
}
//금액 계산 결과 변환기


//상품구매
function submit(){
	window.name = uID; 
	childOpenWindow = window.open('../GoodsUpload/CheckYourWallet.jsp?info='+uID+"/"+sum, "CheckYourWallet", "width=500, height=500, resizable = no, scrollbars = no"); 
	
	//$("#buyGoods").submit();
}
//상품구매

function openWindow() { 
	window.name = 'parentForm'; 
	childOpenWindow = window.open(url, windowName, [windowFeatures]); 
} // 자식에게 값 전달 

function sendChildText() { 
	
}
