const hideT = document.getElementById('hider');
	hideT.style.display = 'none';

var goodsThumbnail = document.getElementById('goodsThumbnail'); //썸네일 input file 지정
var Thumbdrop = $('#Thumb_drop'); // 썸네일 드래그 앤 드롭 영역 지정
var ThumbIdx = 0; //썸네일 갯수 초기화

var goodsImages = document.getElementById('goodsImages'); //상품 이미지 input file 지정
var Imagedrop = $('#Img_drop'); //상품 이미지 드래그 앤 드롭 영역 지정
var ImgIdx = 0;  // 상품이미지 갯수 초기화

var regex = new RegExp("(.*?)\.(exe|sh|zip|alz|txt)$");
   
//////////// 썸네일 드래그 앤 드롭 영역 /////////////
Thumbdrop
  .on('dragenter', function (e1) { //드래그 요소가 들어왔을떄
    $(this).addClass('drag-over');
  })
  .on('dragleave', function (e1) { //드래그 요소가 나갔을때
    $(this).removeClass('drag-over');
  }) 
  .on('dragover', function (e1) { //드래그 요소 위에 있을때
    e1.stopPropagation();
    e1.preventDefault();
  })
  .on('drop', function (e1) { //드래그한 항목을 떨어뜨렸을때
    e1.preventDefault();
    $(this).removeClass('drag-over');
    $('.goodsThumb').remove();
  	$('#goodsThumbnail').val('');

    var files_Thumb = e1.originalEvent.dataTransfer.files; //드래그&드랍 항목
     console.dir(files_Thumb);
   	ThumbIdx = files_Thumb.length; //상품 이미지 갯수 확인

    if (ThumbIdx > 1) {
      alert('썸네일은 하나만 지정 가능합니다');
      $('.goodsThumb').remove();
      $('#goodsThumbnail').val('');
    } else {
		for (var i = 0; i < ThumbIdx; i++) {
        var file_T = files_Thumb[i];
        goodsThumbnail.files = files_Thumb; //input file 영역에 드랍된 파일들로 대체
        Preview_Thumb(file_T, i ); //미리보기 만들기
        }
    }
  });
 //////////// 썸네일 드래그 앤 드롭 영역 /////////////
 
 
 

//////////// 썸네일 미리보기 생성 /////////////
function Preview_Thumb(file_T,idx_T) {
	var reader_T = new FileReader();
  reader_T.onload = (function (file_T , idx_T) {
	if(regex.test(file_T.name)){
		alert('.jpg 또는 .png 파일만 업로드 가능합니다.');
		$('.goodsThumb').remove();
      	$('#goodsThumbnail').val('');
	} else {
    return function (e1) {
      var div_Thumb = 
      '<div class="goodsThumb"> \
		<img id="thumb" src="' + e1.target.result + '" title="' + escape(file_T.name) + '"/> \
		</div>';
      $('#Preview_Thumb').append(div_Thumb); //thumbnails 내용을 var div내용으로 교체
    };
    }
  })(file_T, idx_T); 
reader_T.readAsDataURL(file_T); // 미리보기 적용(해당파일데이터를 읽음)
  
}
//////////// 썸네일 미리보기 생성 /////////////





//////////// 상품 이미지 드래그 앤 드롭 영역 /////////////
Imagedrop
  .on('dragenter', function (e) { //드래그 요소가 들어왔을떄
    $(this).addClass('drag-over');
  })
  .on('dragleave', function (e) { //드래그 요소가 나갔을때
    $(this).removeClass('drag-over');
  })
  .on('dragover', function (e) { //드래그 요소 위에 있을때
    e.stopPropagation();
    e.preventDefault();
  })
  .on('drop', function (e) { //드래그한 항목을 떨어뜨렸을때
    e.preventDefault();
    $(this).removeClass('drag-over');
    $('.goodsImg').remove();
  	$('#goodsImages').val('');

    var files_Img = e.originalEvent.dataTransfer.files; //드래그&드랍 항목
     console.dir(files_Img);
   	ImgIdx = files_Img.length; //상품 이미지 갯수 확인

    if (ImgIdx > 10) {
      alert('상품 이미지는 최대 10개만 넣을 수 있습니다.');
      $('.goodsImg').remove();
      $('#goodsImages').val('');
    } else {
      for (var i = 0; i < ImgIdx; i++) {
        var file = files_Img[i];
        goodsImages.files = files_Img; //input file 영역에 드랍된 파일들로 대체
        Preview_Img(file, i); //미리보기 만들기
      }
    }
  });
 //////////// 상품 이미지 드래그 앤 드롭 영역 /////////////

//////////// 상품 이미지 미리보기 생성 /////////////
function Preview_Img(file, idx) {
	var reader = new FileReader();
 	reader.onload = (function (file, idx) {
	if(regex.test(file.name)){
		alert('.jpg 또는 .png 파일만 업로드 가능합니다.');
		$('.goodsImg').remove();
      	$('#goodsImages').val('');
	} else {
    return function (e) {
      var div = 
      '<div class="goodsImg"> \
		<img id="Img" src="' + e.target.result + '" title="' + escape(file.name) + '"/> \
		</div>';
      $('#Preview_Img').append(div); //thumbnails 내용을 var div내용으로 교체
    };
    }
  })(file, idx); // file과 인덱스 처리
  reader.readAsDataURL(file); // 미리보기 적용(해당파일데이터를 읽음)
  
}
//////////// 상품 이미지 미리보기 생성 /////////////






////////////// 버튼 동작 ///////////////
$('#btnSubmit').on('click', function () {
	var Timage = document.getElementById('goodsThumbnail').value; //썸네일 내용 여부
	var goodsType = $("#goodsType").val().trim();
	var goodsPrice = $("#goodsPrice").val().trim();
	var goodsSPrice = $("#goodsSPrice").val().trim();
	var priceCheck = parseInt(goodsPrice) - parseInt(goodsSPrice);
	var inventoryS = $("#inventoryS").val().trim();
	var inventoryM = $("#inventoryM").val().trim();
	var inventoryL = $("#inventoryL").val().trim();
	var inventoryXL = $("#inventoryXL").val().trim();

	if (goodsType == "1") {
		alert("상품 종류 미선택."); 
		$("#goodsType").focus();
	} else if (goodsPrice == "" || goodsPrice > 9999999) {
		alert("상품 가격을 확인해주세요.");
		$("#goodsPrice").focus();
	    } else if (priceCheck < 0){
        alert("상품 세일가격을 확인해주세요");
        $("#goodsSPrice").focus();
    } else if (inventoryS > 999 || inventoryM > 999 || inventoryL > 999 || inventoryXL > 999){
        alert("상품 재고를 확인해주세요"); 
    } else if (Timage == ""){
		alert("썸네일을 확인할 수 없습니다. 다시 첨부해 주세요")
	} else if (ImgIdx == 0){
        alert("상품 이미지를 확인할 수 없습니다. 상품이미지를 첨부해 주세요");
    } else {
	if (goodsSPrice == "") {
		$("#goodsSPrice").val(0)
	}
	const writer = jQuery.trim(document.getElementById('write').innerHTML);
		const setT = document.all("goodsContent");
		setT.innerHTML = writer;
		alert('ImgIdx : ' + ImgIdx);
		alert('thumb : ' + Timage);
		alert(writer);
  	$('#send').submit();
  }
});

$('#reset').on('click', function () {
  $('.goodsImg').remove();
  $('#goodsImages').val('');
  $('#goodsThumbnail').val('');
});
////////////// 버튼 동작 ///////////////

