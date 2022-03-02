/**

		글쓰기 JavaScript

 */
let currentFileCnt = 0;		//파일 수정 시 필요
let rmFileModiList = [];
$(document).ready(function() {
	console.log('수정상태는?'+$('#modifyState').val())
	
	//수정상태면
	if($('#modifyState').val()=='true'){
		console.log('true')
		addContextPathToImgTag()	//본문에 있는 이미지태그 src에 리소스 매핑을 위하여 contextPath를 붙인다 
		setMap();		//수정상태면 불러온 주소로 맵셋팅
		setImgList()	//수정상태면 불러온 이미지 셋팅
		//이미지리스트 뿌려주기
	
	}
	//글쓰기상태면 현재위치 기준으로 맵셋팅
	else{
		console.log('false')
		callCurrentMap();
	}
	
	/*
	
		글 수정시 파일 처리
		
			1. 파일첨부할 때의 흐름은 
					(1) 파일을 첨부한다
					(2) 임시경로로 사용자에게 이미지를 보여준다
					(3) 자바스크립스 상에서 존재하는 fileBuffer로 파일의 추가/삭제상태가 이루어진다
					(4) 작성완료 시점에서 비동기식으로 fileBuffer에 있는 파일을 외부경로에 생성해준다
			
			1. 수정한 상태에서 불러온 이미지들은 이미 외부파일에 저장되어 있는 상태임으로 흐름이 다르다
					(1) 불러온 게시글 안의 img 태그들을 읽어와서 파일첨부리스트에 추가시켜준다.(따로변수에저장x, 파일첨부리스트에만 추가된다)
					(2) 삭제할 때, 삭제할 이미지들의 경로를 rmfileModiList배열에 모아둔다
					(3) 수정완료할 때, 삭제할 이미지 경로 배열을 비동기식으로 외부경로에서 삭제시켜준다
			
		비고1) 새로운 파일을 첨부할 때, 이미 불러진 이미지들의 갯수를 포함하여 파일첨부 갯수 제한을둔다.
			ex) 최대 파일첨부갯수는 10개인데 이미 2개가 있으면 새로 첨부할 수 있는 파일을 8개
		
		비고2) 삭제할때, 작성완료할 때 첨부한파일과 불러온파일들의 구분을 잘해줘야한다
	
	*/
	
	

})
/* (수정)이미지를 불러올 때 contextPath를 붙여서 불러온다.*/

function addContextPathToImgTag(){

	
	$('.postInputTCom').find('img').each(function(index,item){
		console.log('add contextPath To Img');
		$(this).attr('src',getContextPath()+$(this).attr('src'));
	})
	
	
}
/*	(수정)수정완료전 본문 안에있는 기존 이미지 태그들에 추가한 contextPath를 지워줘야 한다 */
function removeContextPathToImgTag(){
	$('.postInputTCom').find('img').each(function(index,item){
		console.log('remove contextPath To Img');
		let temp = $(this).attr('src');
		if(temp.includes(getContextPath())){
			temp = temp.split(getContextPath())[1];
			$(this).attr('src',temp);
		}
		
	})
}

console.log('post_write in')

/**
		이미지 첨부
			1) 이미지 첨부하면 리스트에 띄워준다
			2) 이미지 첨부하면 글쓰기 칸에 넣어준다
			
		- 제약사항
			1) 파일은 10개까지
			2) jpg, jpeg, png, gif만 가능
			3) 중복된 파일 허용 한다
		
		- 설명
			1) input type file을 불러온다(멀티파일)
				$('#multiFileInput')[0] : HTMLInputElement 객체
				$('#multiFileInput')[0].files : fileList
			2) fileList를 Ajax로 보내야한다
				이유 : form 형태로 보내버리면, 단순 파일첨부형태가 되며,
				이미지를 1개씩 추가할 수가 없다 ( 첨부하기 누르면 이전에 첨부했던거 날라감 )
				기존의 $('#multiFileInput')[0].files의  fileList는
				readOnly라 수정삭제도 불가능하다
				그래서 따로 가공한 형태의 fileList를 ajax로 보내줘야하는데
			3) 따로 만든 fileList를 보내주기 위하여 fileBuffer를 만든다
			
		- fileBuffer의 역할
			1) 파일의 갯수 count
			2) 중복된 파일 허용
			3) 파일 추가/삭제 가능하도록
				
 */
// ContextPath 구하는 함수
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
}


let fileBuffer = [];
let fileBufferIndex = 0;
let maxFileCnt = 10;

//정적 이미지 파일들 경로 지정
let wPostAttachedImgIconSrc = getContextPath() + "/resources/img/posting/attached_picture.png";
let wPostattachedImgDelIconSrc = getContextPath() + "/resources/img/posting/close.png";
let wPostattachedImgDelOnclickIconSrc = getContextPath() + "/resources/img/posting/close_onclick.png";
//본문에 들어가는 클래스 이름 지정
let wPostImgName = "imgList"

//파일 첨부하면
$('#multiFileInput').on('change', function() {

	const target = $('#multiFileInput');

	//총 file 갯수
	let totalFileCnt = target[0].files.length + fileBuffer.length;
	//총 file갯수(수정용)
	let totalFileCnt2 = target[0].files.length + fileBuffer.length + currentFileCnt;
	console.log('총 파일 갯수는 ?' + totalFileCnt);

	//제약사항 - 파일 10개까지 등록
	if (totalFileCnt > maxFileCnt || totalFileCnt2 > maxFileCnt) {
		alert('파일은 최대 10개까지 등록가능합니다');
		//파일리셋
		resetFileToPwrite();
		return false;
	}
	
	//수정할 때, 이미 이미지가 있다면 새로운 파일을 첨부할 때는 그 갯수부터 이미지 갯수카운트를 한다
	fileBufferIndex = currentFileCnt;
	
	
	/*
	
		페이지를 직접 여러번 새로 바꿔야하는 append코드는 브라우저 성능에
		상당한 부담을 가한다.
		
		그래서 가상메모리에서 append 기능을 수행해주는 documentfragment를
		사용하여, for문을 다 돈다음 태그에 append를 사용한다
	
	*/

	var $imgListFrag = $(document.createDocumentFragment());
	var $contentFrag = $(document.createDocumentFragment());


	$.each(target[0].files, function(index, file) {
		//제약사항 - 이미지파일은 jpg, png, gif만
		const fileName = file.name;
		const fileEx = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
		if (fileEx != "jpg" && fileEx != "png" && fileEx != "gif" && fileEx != "jpeg") {
			alert("파일은 (jpg, png, gif, jpeg) 형식만 등록 가능합니다.");
			resetFileToPwrite();
			return false;
		}

		let imgList_html = '';
		let content_html = '';

		
		


		//파일 첨부 리스트에 보여주기
		imgList_html += '<li>';
		imgList_html += '<img src="' + wPostAttachedImgIconSrc + '" class="wPostAttachImgIcon" alt="이미지파일 아이콘">';
		imgList_html += '<p class="wPostAttachImgTitle">';
		imgList_html += fileName;
		imgList_html += '<span>("' + file.size + '")</span></p>';
		imgList_html += '<img src="' + wPostattachedImgDelIconSrc + '" data-imgindex="' + fileBufferIndex + '"';
		imgList_html += 'class="wPostAttachImgDelIcon" alt="이미지파일 삭제아이콘">';
		imgList_html += '</li>';
		console.log('fileBuffer Counter' + index);
		//$('.wPostAttachedImgList').append(imgList_html);
		$imgListFrag.append(imgList_html);

		//글 본문에 사진 넣어주기
		//class Name에 index 값을 부여한
		content_html += '<br>';
		content_html += '<img src="' + URL.createObjectURL(file) + '" alt="' + fileName + '" class="' + wPostImgName + fileBufferIndex + '" data-imgsize="'+file.size+'">';
		content_html += '<br><br>';
		//$('.wPostContentInput').append(content_html);
		$contentFrag.append(content_html);

		//고유한 class name을 주기위한 값 추가
		fileBufferIndex++;


	});
	$('.wPostAttachedImgList').append($imgListFrag);
	$('.wPostContentInput').append($contentFrag);





	//fileBuffer에 첨부된 파일들을 붙인다
	//2번째 인자의 배열을 1번째 인자의 배열에 이어서 붙이기
	Array.prototype.push.apply(fileBuffer, target[0].files);
	console.log('fileBuffer?')
	console.log(fileBuffer)

	//file리셋을 해줘야 이미지 중복을 허용한다
	resetFileToPwrite();
});

//현재 파일첨부한거 초기화
function resetFileToPwrite() {
	$('#multiFileInput').val("");
}



/*

	파일리스트 화면에 보여주기
		- 파일리스트 - 리스트형태
		- 글쓰기폼div - 이미지형태
		- 위 둘에, 고유의 className과 data 값을 부여한다 (삭제위해)

*/


/*
	
		파일리스트 디자인
			- document on 쓰는이유
				1) on click 함수는 script 코드로 append 추가한 tag들에 관해서는
				변화를 일으킬 수 없다.
				2) document on을 쓰면 화면을 한 번 읽은 후에 이벤트를 발생시킴으로
				변화를 줄 수 있다.
				
			- hover, onclick css이벤트 쉽게주기
				과거) 1개의 selected 태그를 클래스로 추가함으로서 조건문이 많이 들어가고
				코드가 길어졌다.
				현재) hover시 변화주는 class와 onclick시 변화는 class를 따로두어
				관리하니 코드가 간단해졌다.

*/
$(document).on("mouseover", ".wPostAttachedImgList li", function() {
	//$('.wPostAttachedImgList li').click(function(){
	//다른 리스트 선택된 효과 지우기
	$('.wPostAttachedImgList li').removeClass('wPostHoverImg');
	//지금 선택된 리스트 선택 효과 주기
	$(this).addClass('wPostHoverImg');
	//삭제버튼 효과주기
	$(this).find($('.wPostAttachImgDelIcon')).attr('src', wPostattachedImgDelOnclickIconSrc);

});
$(document).on("mouseleave", ".wPostAttachedImgList li", function() {
	//효과 지우기
	$('.wPostAttachedImgList li').removeClass('wPostHoverImg');
	//삭제버튼 효과없애
	$(this).find($('.wPostAttachImgDelIcon')).attr('src', wPostattachedImgDelIconSrc);
});



/**

		이미지삭제
			1) 리스트에서 이미지를 삭제하면, 리스트에서도 지워주고 fileBuffer에서도 지워준다
			2) 글작성 div에서 이미지를 삭제해준다

		문제점 발생
			1) 글작성폼에서 특정 이미지를 삭제하기 위해서 div안에 img태그안에 classname을
			imgList+파일추가할 때 index 번호로 주었는데, 이러면 새로운 파일을 추가할 때 index번호가
			추가되서 img classname이 중복이 된다.
			
		문제점 해결  - tag내 data속성
			1) 글작성폼 이미지에 className이 중복되지 않게 만들어주고, 이 className을
			파일리스트에서도 추가해줘서 해당 리스트가 클릭될 때 리스트가 가진 data값을 불러주면
			data의 값으로 글작성폼div 안에 이미지 className을 찾을 수 있다

 */
$(document).on('click', '.wPostAttachImgDelIcon', function() {
	let removeImgIndex = $(this).data('imgindex');
	console.log("removeImgIndex is " + removeImgIndex);

	//수정 상태가 아니라면 fileBuffer에서 삭제
	if(!$(this).hasClass('wPostModifyImgDelIcon')){
		let rmFileBufferIndex = $(this).parent().index();
		fileBuffer.splice(rmFileBufferIndex, 1); //index에서 1개 값지운다 뜻
	
		console.log('rmFileBufferIndex' + rmFileBufferIndex);
		console.log('fileBuffer is' + fileBuffer);
	}
	//수정 상태
	if($(this).hasClass('wPostModifyImgDelIcon')){
		//수정상태에서 초기에 셋팅된 이미지 카운트를 줄어둔다
		currentFileCnt--;
		//외부경로에 지워줄 파일리스트를 모아준다
		let rmFileSrc = $('.imgList'+removeImgIndex).attr('src');
		rmFileModiList.push(rmFileSrc);
	}
	


	//파일첨부리스트에서 삭제
	$(this).parent().remove();



	//글작성div에서 삭제
	let rmImgName = wPostImgName + removeImgIndex;
	$('.wPostContentInput').find($('.' + rmImgName)).remove();


	const target = $('#multiFileInput');
	console.log(fileBuffer);
	console.log(target[0].files);


})

/**

		파일 데이터 전송
			1) 파일을 서버에 올려서 외부파일로 저장한다
			2) 본문에 들어가 있는 img의 임시 src를 외부파일 경로로 바꿔준다
			
			1-1)
 */

/*

		1. 파일을 서버에 올려서 외부파일로 저장하기
			1) 기존의 file tag의 fileList 형태와 내가 만든 fileBuffer는 데이터 형식이 다르기 때문에
			fileBuffer를 fileList에 맞게 가공해야한다 ★★★★★
			
			2) fileList는 기존의 ajax 데이터로 보내는게 아니라
			ajax-form을 이용해 인코딩타입이 multipart로 보내야한다
			
			3) return으로 외부파일 경로 리스트를 받는다
*/



$(document).on('click', '.wPostSubmitBtn', function(e) {
	e.preventDefault();
	//수정시 불러온 이미지들에 추가한 contextPath를 지워준다
	removeContextPathToImgTag();
	
	//수정상태에서 불러온 이미지들이 삭제가 된게 있다면 외부파일에서 지워준다
	if(rmFileModiList.length!=0){
		removeImg(rmFileModiList);
	}
	
	//파일을 미리 외부경로에 저장하고 & 본문 img src 업데이트
	//form sumbit은 ajax가 성공한 뒤에 한다
	if (fileBuffer.length!=0) {
		if ($('#postType').val() == 'N') {
			sendFileToSave("noticeBoard");
		} else if ($('#postType').val() == 'R') {
			sendFileToSave("reviewBoard");
		}
	}
	else{
		//제목과 내용이 없으면 전송x
		let title = $('.wPostSubTitleConInput').val();
		let content = $('.wPostContentInput').text();
		if(title.replace(/\s| /gi, "").length == 0){
			alert('제목을 입력해주세요');
			return;
		}else if(content.replace(/\s| /gi, "").length == 0){
			alert('본문을 입력해주세요');
			return;
		}else{
			//modelAttribute로 전송하기 위해서 div 값 input value에 넣어주기
			$('#wPostContentValue').val($('.wPostContentInput').html());

			$('#wPostForm').submit();		//첨부파일없으면 바로 전송
		}

	} 
	
	
	





});

function sendFileToSave(board_name) {
	//let file = $('#multifileInput')[0].files;
	let file = fileBuffer;
	$('#' + board_name).ajaxForm({
		contentType: false,
		processData: false,
		enctype: "multipart/form-data",
		dataType: "POST",
		dataType: 'json',

		beforeSubmit: function(data, form, option) {
			var fileSize = file.length;
			if (fileSize > 0) {
				for (var i = 0; i < fileSize; i++) {
					var obj = {
						name: "files",
						value: file[i],
						type: "file"
					};
					data.push(obj);
				}
			}
			console.log('beforeSubmit');
			console.log('data');
			console.log(data);

		},
		//일반으로 보냈을 때랑 값비교
		/*beforeSubmit: function(data, form, option) {
			console.log('beforeSubmit');
			console.log('data');
			console.log(data);
				},
		*/

		success: function(data) {
			//글쓰기 폼에 있는 이미지들의 임시경로를 외부경로로 바꿔준다
			for (let i = 0; i < data.length; i++) {
				//$('.imgList' + i).attr('src', getContextPath() + data[i]);
				$('.imgList' + i).attr('src', data[i]);
			}

			//div 값 input value에 넣어주기
			$('#wPostContentValue').val($('.wPostContentInput').html());

			//나머지 submit
			$('#wPostForm').submit();
		},
		error: function() {
			alert('이미지 임시저장 실패');
		}

	});

	//ajax submit이다 
	//ajaxForm에서는 별도로 sumbit을 꼭해줘야한다
	$('#' + board_name).submit();

}


// ContextPath 구하는 함수
function getContextPath() {
	var hostIndex = location.href.indexOf(location.host) + location.host.length;
	return location.href.substring(hostIndex, location.href.indexOf('/', hostIndex + 1));
}




/**





		지도
			1) 맵의 초기위치를 현재위치로 잡기 위해서는 현재위치 읽어오는 함수에
			맵을 생성해서 만든다
			
			
			
			
*/


let initPos;
var currentPos;
var mapContainer;
var map;
var geocoder;
var marker;


/*

		콜백함수

*/

function callCurrentMap() {
	navigator.geolocation.getCurrentPosition(locationLoadSuccess, locationLoadError);
	console.log('자동실행 callCurrentMap')
}


function locationLoadSuccess(pos) {
	// 현재 위치 받아오기
	currentPos = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);

	//주소검색했을 때, 초기값 위해서
	initPos = currentPos;
	console.log('자동실행 locationLoadSuccess')
	
	


	mapContainer = document.getElementById('wPostMap'), // 지도를 표시할 div
		mapOption = {
			center: new daum.maps.LatLng(pos.coords.latitude, pos.coords.longitude), // 지도의 중심좌표
			level: 5 // 지도의 확대 레벨
		};

	//지도를 미리 생성
	map = new daum.maps.Map(mapContainer, mapOption);

	// 지도 이동(기존 위치와 가깝다면 부드럽게 이동)
	map.panTo(currentPos);

	//주소-좌표 변환 객체를 생성
	geocoder = new daum.maps.services.Geocoder();

	// 마커 생성
	marker = new kakao.maps.Marker({
		position: currentPos
	});

	// 기존에 마커가 있다면 제거
	marker.setMap(null);
	marker.setMap(map);


	//kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
	searchDetailAddrFromCoords(currentPos, function(result, status) {
		console.log('result & status')
		console.log(currentPos)
		console.log(result)
		console.log(status)
		if (status === kakao.maps.services.Status.OK) {
			$('#wPostDetailAddress').val(result[0].address.address_name);
			
			console.log(result[0].address.address_name);
		}
		else {
			alert('결과값을 불러올 수 없습니다')
		}
	});
	//});


	function searchDetailAddrFromCoords(coords, callback) {
		// 좌표로 상세 주소 정보를 요청합니다
		geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}


	// 지도를 클릭했을 때 클릭 위치 좌표에 대한 주소정보를 표시하도록 이벤트를 등록합니다
	kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		searchDetailAddrFromCoords(mouseEvent.latLng, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				$('#wPostDetailAddress').val(result[0].address.address_name);
				
				// 마커를 클릭한 위치에 표시합니다
				marker.setPosition(mouseEvent.latLng);
				marker.setMap(map);
			}
		});
	});

};

/*
		콜백함수 사용법
		

function temp(temp2){
	console.log("1");
	temp2();
}

temp(function(){
	console.log("2");
})

*/






function locationLoadError(pos) {
	alert('위치 정보를 가져오는데 실패했습니다.');
};

/*




	주소 입력하기 버튼 누르기
			- 우편번호서비스이용
	
	
	
*/

$('.wPostMapSetAddressBtn').click(function(e) {
	e.preventDefault();
	//기존맵 초기화
	console.log('initpos');
	console.log(initPos);

	new daum.Postcode({
		oncomplete: function(data) {
			var addr = data.address; // 최종 주소 변수

			// 주소 정보를 해당 필드에 넣는다.
			document.getElementById("wPostDetailAddress").value = addr;


			// 주소로 상세 정보를 검색
			geocoder.addressSearch(data.address, function(results, status) {
				console.log('hihi')
				console.log(results)
				// 정상적으로 검색이 완료됐으면
				if (status === daum.maps.services.Status.OK) {

					var result = results[0]; //첫번째 결과의 값을 활용
					


					// 해당 주소에 대한 좌표를 받아서
					var coords = new daum.maps.LatLng(result.y, result.x);
					// 지도를 보여준다.
					// mapContainer.style.display = "block";
					map.relayout();
					// 지도 중심을 변경한다.
					map.setCenter(coords);
					// 마커를 결과값으로 받은 위치로 옮긴다.
					marker.setPosition(coords);



				}
			});
		}
	}).open();
})


/*

	현재 위치에서 찾기

*/

$('.wPostMapCurrentPlaceBtn').click(function(e) {
	e.preventDefault();
	callCurrentMap();
})
/*
	 
	주소로 맵설정하기
	
*/
function setMap(){
	// 식당 좌표 받아오기(좌표로)
	//let lat = $('#addressLat').val();
	//let lng = $('#addressLng').val();
    //let currentPos = new kakao.maps.LatLng(lat, lng);

    var mapContainer = document.getElementById('wPostMap'), // 지도를 표시할 div
        mapOption = {
            //enter: new daum.maps.LatLng(lat, lng), // 지도의 중심좌표
             center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
			level: 3 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption);

    // 마커 생성(좌표로)
    //let marker = new kakao.maps.Marker({
    //    position: currentPos
    //});

    // 마커표시(좌표로)
    //marker.setMap(map);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	//맵의 주소값
	let address = $('#wPostDetailAddress').val();
	console.log('address'+address);
	//let address="경북 경산시 펜타힐즈4로 1";
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(address, function(result, status) {

	    // 정상적으로 검색이 완료됐으면 
	     if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            position: coords
	        });
			marker.setMap(map);
			
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	})
	
}

/*

	글 삭제할 때 외부파일 이미지 지워주기
		- 글 작성 폼 안에 있는 img태그들 모아서 완려 버튼 누르면 파일 삭제 해준다	
		- 최대 업로드 갯수만큼 for문 돌려서(imgList0, imgList1...)
		  있으면 img src를 저장한다
*/

/*

	글 삭제할 때 이미지 삭제
	
*/
function removeAllImg(){
	let rmFileListAll =[];
	for(let i=0;i<maxFileCnt;i++){
		rmFileList[i]=$('.wPostContentInput').find($('.imgList'+i)).attr('src');
	}
	
	removeImg(rmFileListAll);
}

/*
	글 수정& 글 삭제 이미지 삭제
*/

function removeImg(rmFileList){
	/*
	
		RequestParam List로 받기 위해 2차원 배열생성
		array[maxFileCnt][0]
		=> List.getIndex(0).val() = src;
	*/
	
	let rmFileBuffer = new Array(maxFileCnt);
	//for (var i = 0; i < arr.length; i++) {
	    
	//}
	
	console.log('removeImgList');
	for(let i=0;i<maxFileCnt;i++){
		rmFileBuffer[i] = new Array(1);
		rmFileBuffer[i] = rmFileList[i];
		//rmFileBuffer[i]=$('.wPostContentInput').find($('.imgList'+i)).attr('src');
	}
	console.log(rmFileBuffer);	
	
	
	$.ajax({
		url: getContextPath()+"/removeImg",
		type: "post",
		data:{imgSrc:rmFileBuffer},
		success: function(data) {
			
			},
			error:function(){			
			}
		})
}

/**

	수정하기 폼에 들어왔을 때, 이미 글작성폼에 들어가 있는 이미지들을 읽어와서
	파일첨불 리스트에 다시 뿌려준다

 */
function setImgList(){
	
	var $imgListFrag = $(document.createDocumentFragment());
	
	for(let i=0;i<maxFileCnt;i++){
		let imgList_html = '';
		let imgTitle = $('.wPostContentInput').find($('.imgList'+i)).attr('alt');
		let imgSize = $('.wPostContentInput').find($('.imgList'+i)).data('imgsize');
		
		if(imgTitle!=''&&imgTitle!=null){
			//현재 이미지 파일 갯수 카운트
			currentFileCnt++;
			
			//파일 첨부 리스트에 보여주기
			imgList_html += '<li>';
			imgList_html += '<img src="' + wPostAttachedImgIconSrc + '" class="wPostAttachImgIcon" alt="이미지파일 아이콘">';
			imgList_html += '<p class="wPostAttachImgTitle">';
			imgList_html += imgTitle;
			imgList_html += '<span>("' + imgSize + '")</span></p>';
			imgList_html += '<img src="' + wPostattachedImgDelIconSrc + '" data-imgindex="' + i + '"';
			imgList_html += 'class="wPostAttachImgDelIcon wPostModifyImgDelIcon" alt="이미지파일 삭제아이콘">';
			imgList_html += '</li>';
			$imgListFrag.append(imgList_html);

		}
		$('.wPostAttachedImgList').append($imgListFrag);
		
	}

	
}


















