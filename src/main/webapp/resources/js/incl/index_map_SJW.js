let gameDataForm = document.gameDataForm;
	
function searchResList(radius, keword){				
	$.ajax({
		url: "https://dapi.kakao.com/v2/local/search/keyword.json?query="
		 + keword,
		x: nowLat,
		y: nowLng,
		radius: radius,
		type: "get",
		headers: {"Authorization" : "KakaoAK f3ae310b0340ac2069e5e0685938a62b"},
		dataType: "json",
		success: function(data){
			for(let m=0; m<data["documents"].length; m++){
				totalArr.push(data["documents"][i]);
			}
		}
	})
}
$('.radiusLabel').on('click',function(){
	$(this).siblings().removeClass('radiusOn');
	$(this).addClass('radiusOn');
})
$('.categoryLabel').on('click', function(){
	$(this).siblings().removeClass('categoryOn');
	$(this).addClass('categoryOn');	
})

//button[name=radius]
$('.gamePlayBtn').on('click', function(e){
	e.preventDefault();
	let popupWidth = 1050;
	let popupHeight = 1000;
	let radius = $(".radius:checked").val();
	let category = $(".category:checked").val();
	var input1;
	var input2;
	
	/*
	var inputForLat = document.createElement('input');
	div.createTextNode('This is div');
	*/

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
	
	window.open("openGamePopUp", "게임하기", "width=1050, height = 1000, top=" + popupY + ", left=" + popupX + ""); //선언과 초기화 동시에 해도 됨
	//popUp.document.getElement("") = document.getElementById();
	
	console.log(radius);
	console.log(category);
	let popUpUrl = getContextPath() + "/sendDataToPopUp";
	
	//let gameDataForm = document.gameDataForm;
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

/*
	let json = { "radius": radius, "category": category};
	$.ajax({
		url: getContextPath() + "/sendDataToPopUp",
		type: "get",
		data: json,
		dataType: 'json',
		success: function(){
			console.log("successssssssssssss")
			window.open("openGamePopUp", "게임하기", "width=600, height = 600, top=" + popupY + ", left=" + popupX + ""); //선언과 초기화 동시에 해도 됨
		}	
	}) */	
	
	
	 