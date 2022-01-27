let gameDataForm = document.gameDataForm;
	
$('.radiusLabel').on('click',function(){
	$(this).siblings().removeClass('radiusOn');
	$(this).addClass('radiusOn');
})
$('.categoryLabel').on('click', function(){
	$(this).siblings().removeClass('categoryOn');
	$(this).addClass('categoryOn');	
})

$('.gamePlayBtn').on('click', function(e){
	e.preventDefault();
	let popupWidth = 1050;
	let popupHeight = 1000;
	let radius = $(".radius:checked").val();
	let category = $(".category:checked").val();
	var input1;
	var input2;

	createLatLng(nowLat, input1, "nowLat");
	createLatLng(nowLng, input2, "nowLng");
	if(radius == null || category == null){
		Swal.fire({
			icon: 'error',
			title: '입력 오류',
			text: '반경과 식당 카테고리를 선택해주세요',
			confirmButtonColor: '#b7cae1',
			heightAuto: false
		})	
	}else{
		let popupX = (window.screen.width / 2) - (popupWidth / 2);
	// 만들 팝업창 width 크기의 1/2 만큼 보정값으로 빼주었음

	let popupY = (window.screen.height / 2) - (popupHeight / 2);
	// 만들 팝업창 height 크기의 1/2 만큼 보정값으로 빼주었음
	
	window.open("openGamePopUp", "게임하기", "width=1060, height = 1000, top=" + popupY + ", left=" + popupX + ""); //선언과 초기화 동시에 해도 됨
	//popUp.document.getElement("") = document.getElementById();
	
	console.log(radius);
	console.log(category);
	let popUpUrl = getContextPath() + "/sendDataToPopUp";
	
	gameDataForm.action = popUpUrl;
	gameDataForm.target = "게임하기";
	gameDataForm.method = "get";
	
	gameDataForm.submit();
	}

})

function createLatLng(data, input, name){
	$('input').remove('#'+name+'');
	gameDataForm.remove
	input = document.createElement('input');
	input.type = 'hidden';
	input.name = name;
	input.id = name;
	input.value = data;
	
	gameDataForm.appendChild(input);
}
	
	 