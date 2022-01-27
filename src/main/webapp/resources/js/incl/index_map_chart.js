let nowLat, nowLng, map, geocoder, sMarker, eMarker, ps, nowAddress, circle;
let wtmY, wtmX; // y = lat, x = lng
let sInfoW, eInfoW;
let earth = 6371000;

// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
if (navigator.geolocation) {
    
    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
    navigator.geolocation.getCurrentPosition(function(position) {
        
    	nowLat = position.coords.latitude, // 위도
    	nowLng = position.coords.longitude; // 경도

		let mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = { 
	    center: new kakao.maps.LatLng(nowLat, nowLng), // 지도의 중심좌표
	    level: 3 // 지도의 확대 레벨
		};
		map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
		geocoder = new kakao.maps.services.Geocoder(); // 주소-좌표 변환 객체를 생성합니다
		ps = new kakao.maps.services.Places(); // 장소 검색 객체를 생성합니다
		
		geocoder.coord2Address(nowLng, nowLat, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				nowAddress = result[0].address.address_name;
				$('#presentAddress').text(nowAddress);
				//$("#memberPosition").text(nowAddress);
			}
		});
		
        // 마커와 인포윈도우를 표시합니다
        displayStartMarker(); // user position
		displayArriveMarker(nowLat, nowLng); // click position
		// click marker hide
		eMarker.setVisible(false);
		$("#eInfoW").hide();
/*
		// 지도에 표시할 원을 생성합니다
		circle = new kakao.maps.Circle({
		    center : new kakao.maps.LatLng(nowLat, nowLng),  // 원의 중심좌표 입니다 
		    radius: 0, // 미터 단위의 원의 반지름입니다 
		    strokeWeight: 1, // 선의 두께입니다 
		    strokeColor: '#f23f3f', // 선의 색깔입니다
		    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
		    strokeStyle: 'solid', // 선의 스타일 입니다
		    fillColor: '#ffecec', // 채우기 색깔입니다
		    fillOpacity: 0.5  // 채우기 불투명도 입니다   
		});
		
		circle.setMap(map);
*/    
		/*
		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    // 클릭한 위도, 경도 정보를 가져옵니다 
		    let latlng = mouseEvent.latLng;

			// 실제 동작 시에는 클릭이벤트 대신 여기다가 좌표값을 넣어서 팝업이 닫힐 때 동작시키면 된다*****************
			displayRestaurantInfo(latlng.getLat(), latlng.getLng());
		
		});*/
	});
} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
    
    let locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
        message = 'geolocation을 사용할수 없어요..'
        
    displayMarker(locPosition, message);
}

$(".radius").click(function() {
	let diffM = Number($(this).val());
	let json = {"nowLat" : nowLat, "nowLng" : nowLng, "diffM" : diffM};
	
	$.ajax({
		url: "calculateMap",
		type: "get",
		data: json,
		dataType: 'json',
		success: function(data){
			let points = [
			    new kakao.maps.LatLng(data[0], data[1]),
			    new kakao.maps.LatLng(data[2], data[3])
			];
			let bounds = new kakao.maps.LatLngBounds();
			for(i=0; i<points.length; i++){
				bounds.extend(points[i]);
			}
			map.setBounds(bounds);
			//circle.setRadius(diffM);
		}
	})
	
	
})

// 지도에 마커와 인포윈도우를 표시하는 함수입니다
function setMarkerImg(imgName, marker) {
	let imageSrc = getContextPath() + '/resources/img/map/' + imgName + '.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(40, 40), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(20, 35)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
 
	let markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)
	
    // 마커를 생성합니다

    marker.setImage(markerImage);
}

function displayArriveMarker(lat, lng) {
	let locPosition = new kakao.maps.LatLng(lat, lng), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
        message = '<div id="eInfoW">여기로 가시면돼요!!</div>'; // 인포윈도우에 표시될 내용입니다
	eMarker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    });

	// 커스텀 오버레이를 생성합니다
	eInfoW = new kakao.maps.CustomOverlay({
	    position: locPosition,
	    content: message   
	});
	
	// 커스텀 오버레이를 지도에 표시합니다
	eInfoW.setMap(map);
	
	setMarkerImg("emarker", eMarker);
}

function displayStartMarker() {
	let locPosition = new kakao.maps.LatLng(nowLat, nowLng), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
        message = '<div id="sInfoW">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다
	sMarker = new kakao.maps.Marker({  
        map: map, 
        position: locPosition
    });

	// 커스텀 오버레이를 생성합니다
	sInfoW = new kakao.maps.CustomOverlay({
	    position: locPosition,
	    content: message   
	});
	
	// 커스텀 오버레이를 지도에 표시합니다
	sInfoW.setMap(map);
	
	setMarkerImg("smarker", sMarker);
}

// 좌표를 인자로 넣어 식당 정보를 가져와 표시하는 함수
// 이 함수를 발생시키면 된다.===============================================
function displayRestaurantInfo(lat, lng, restaurantName, restaurantId) {
	console.log("hihihihihihihihihihihihihihihihihihihihihihi");
	console.log("lat : " + lat);
	console.log("lng : " + lng);
	let latlng = new kakao.maps.LatLng(lat, lng);
	// 마커 위치를 좌표 위치로 옮깁니다
    eMarker.setPosition(latlng);
 	// click marker show
	eMarker.setVisible(true);
	$("#eInfoW").show();
	eInfoW.setPosition(latlng);
	// 식당 정보 페이지 url 가져오기
	let callback = function(result, status) {
	    if (status === kakao.maps.services.Status.OK) {
	        console.log(result[0].address.address_name);
		
			$.ajax({
				url: "https://dapi.kakao.com/v2/local/search/keyword.json?query="
				 + restaurantName + "&x=" + latlng.getLng() + "&y=" + latlng.getLat(),
				type: "get",
				headers: {"Authorization" : "KakaoAK f3ae310b0340ac2069e5e0685938a62b"},
				dataType: "json",
				success: function(data){
					let urlArr = data["documents"][0].place_url.split(":");
					
					$("#restaurantUrl").attr("src", urlArr[0] + "s:" + urlArr[1]);
					$("#weatherWrap").hide();
					
					$("#open").show();
				}
			})
	    }
	};
	
	/*
	
		index식당정보 - 선호도 표시하기
		윤효심
		
	*/
	console.log("레스토랑아이디!!!"+restaurantId);
	getStoreInfoWithChart(restaurantId);
	
	
	geocoder.coord2Address(latlng.getLng(), latlng.getLat(), callback);

	
	


}


// 보기 버튼 클릭 시 식당 정보 표시 section 커지기
$("#open").click(function() {
	if ($(this).val() == "open"){
		$("#restaurantWrap").css({"width":"55%"});
		$("#restaurantUrl").css({"transform":"translateX(-20%)"});
		$(this).val("close");
		$(this).text("닫기");
	} else {
		$("#restaurantWrap").css({"width":"375px"});
		$("#restaurantUrl").css({"transform":"translateX(-36.5%)"});
		$(this).val("open");
		$(this).text("펼치기");
	}
})

function makeRetryMsg(cntForRetry){
	console.log("makeRetryMsg : " + cntForRetry);
	if(cntForRetry == 0){
		
	}else if(cntForRetry == 1){
		
	}else if(cntForRetry == 2){
		$("#retryMsg").text("한 번 더");
	}else if(cntForRetry == 3){
		$("#retryMsg").text("한 번 더어~?");
	}else if(cntForRetry == 4){
		$("#retryMsg").text("또..?");
	}else if(cntForRetry == 5){
		$("#retryMsg").text("까다로우시네");
	}else if(cntForRetry == 6){
		$("#retryMsg").text("곱게 먹으러 가지?");
	}else{
		$("#retryMsg").text("그냥 라면 먹어");	
	}
}
/*
$("#gameDone").click(function() {
	displayFindWay("서울시청", "광화문");
})

// https://map.kakao.com/?sName=서울시청&eName=광화문
function displayFindWay(sName, eName) {
	let findUrl = 'https://map.kakao.com/?sName=' + sName + '&eName=' + eName;
	$("#findUrl").attr("src", findUrl);
}
*/


















/*
	
		index식당정보 - 선호도 표시하기
		윤효심
		
*/
	

//접혔을 때 마지막으로 보이는 li 순서
let last_liNum;
let li_count;
let li_margin;
let li_initHeight;
let li_height;
let li_totalHeight;



/**
 * 	성별별 파이차트
 */
function drawGenderChartWrap() {
	google.charts.load("current", { packages: ["corechart"] });
	google.charts.setOnLoadCallback(drawGenderChart);
	function drawGenderChart() {
		var data = google.visualization.arrayToDataTable([
			['Task', 'count'],
			['여자', femaleCount],
			['남자', maleCount]
		]);

		var options = {
			pieHole: 0.4,
			chartArea: { width: '80%', height: '70%' },
			legend: { position: 'bottom', alignment: 'center', textStyle: { color: '#c2c9cd', fontsize: 14 } },
			slices: { 0: { color: '#ff6d6d' }, 1: { color: '#78c1ff' } },
			tooltip: { trigger: 'none' },
		};

		var chart = new google.visualization.PieChart(document.getElementById('genderChart'));
		chart.draw(data, options);

		
	}
}



/**
 * 	나이별 막대차트
 */
function drawAgeChartWrap() {
	google.charts.load('current', { packages: ['corechart', 'bar'] });
	google.charts.setOnLoadCallback(drawAgeChart);
	function drawAgeChart() {
		var data = google.visualization.arrayToDataTable([
			['Element', 'Age', { role: 'style' }],
			['10대', ages[0], 'color:' + color[0]],
			['20대', ages[1], 'color:' + color[1]],
			['30대', ages[2], 'color:' + color[2]],
			['40대', ages[3], 'color:' + color[3]],
			['50대', ages[4], 'color:' + color[4]],
			['60대', ages[5], 'color:' + color[5]]
		]);

		var options = {
			legend: { position: "none" },
			titlePosition: 'none', axisTitlesPosition: 'none',
			vAxis: {
				textPosition: 'none', baselineColor: '#fff', gridlines: { color: '#fff', minSpacing: 10 },
			},
			hAxis: { textStyle: { color: '#c2c9cd', fontsize: 8 } },
			chartArea: { width: '90%', height: '70%' },
			tooltip: { trigger: 'none' },
		};


		var chart = new google.visualization.ColumnChart(
			document.getElementById('ageChart'));

		chart.draw(data, options);
	}
}


//let restaurantId = 1;
let femaleCount, maleCount;
let ages = [];
let userCount;
let bathroom, specialDay, clean, parkinig, goodgroup, alone, big, interior;
let mBathroom, mSpecialDay, mClean, mParkinig, mGoodgroup, mAlone, mBig, mInterior;
//배열예정
let reviews;
let color = new Array(6);
$(document).ready(function() {

	$('.ageAndGenderGraphArea').hide();
	$('.userReviewGraphArea').hide();
	
})

function getStoreInfoWithChart(restaurantId){
	//메인에 gif지워주기
	$('.storeSubInfoBeforeWrap').hide();
	
	
	
	
	/*
		RestaurantReference & RestaurantReview
		ModelAndView 값(서버측)이 JSP 단에 뿌려주고 JS(클라이언트측)에서 그 값을 끌어 사용해야한다
		input type hidden으로 RestaurantReference 관련 값들을 다 넣어주기가 좀 그래서 ajax 사용해서 
		그래프 그리기에 필요한 값들을 셋팅해본다
	*/
	//let restaurantId=1;
	
	
	
	//연령별/성별 선호도불러오기
	
	let reference = $.ajax({
		url: "restaurant_sub_info_reference",
		type: "post",
		//data: $('#restaurantId').serialize(),
		data: {restaurantId:restaurantId},
		success: function(data) {
			
			
			//성별 데이터 받기
			femaleCount = data["restReference"].femaleCount;
			maleCount = data["restReference"].maleCount;

			if(femaleCount == 0 && maleCount == 0){
				$('.ageAndGenderGraphArea').hide();
				return;
			}
			else{
				$('.ageAndGenderGraphArea').show();
			}

			//연령별 데이터 받기
			for (let i in data["restReference"].ageCount) {
				ages[i] = data["restReference"].ageCount[i];
			}


		},
		error : function(){
			//정보 없으면 
			$('.ageAndGenderGraphArea').hide();
		}
	});
	//리뷰 불러오기
	
	let review = $.ajax({
		url: "restaurant_sub_info_review",
		type: "post",
		//data: $('#restaurantId').serialize(),
		data: {restaurantId:restaurantId},
		success: function(data) {
			
			//리뷰 데이터 받기
			userCount = data["review"].userCount;
			
			if(userCount==0){
				$('.userReviewGraphArea').hide();
				return;
			}else{
				$('.userReviewGraphArea').show();
			}
			
			let reviewCount = data["review"].reviewItem.length;
			//rKeyword = new Array(reviewCount);
			//rMessage = new Array(reviewCount);
			let review;
			reviews = new Array(reviewCount);

			for (let i = 0; i < reviewCount; i++) {
				review = new Object();
				review.rCount = data["review"].reviewItem[i].reviewCount;
				review.rMessage = data["review"].reviewItem[i].message;
				review.rImgPath = data["review"].reviewItem[i].imgPath;

				reviews[i] = review;

			}

		},
		error : function(){
			//정보 없으면 
			$('.userReviewGraphArea').hide();
		}
	});
	
	
	/*
		ajax - promise 패턴이 있다. 
		비동기방식인만큼, 실행되는 순서를 보장해 주지 않는데 순서가 필요할 때 사용하는게 promise
		ajax -> 성공하면 실행되는 success 함수 fail함수(순서보장)
		
		제이쿼리에서 여러개의 promise 패턴을 처리하는 방법으로 when이라는 함수를 제공한다
		참고 : https://bemeal2.tistory.com/246
		
		=> 순서를 보장해주기 때문에 쿼리 내의 전역변수 사용이 가능하다
		
	*/
	$.when(reference,review).done(function() {
		//성별 차트그리기
		drawGenderChartWrap()

		//연령별 차트그리기
		//1.컬러초기화
		setAgeChartColor()

		//2.1등 컬러 셋팅하기
		setBestAgeChartColor()

		//3.연령별 차트 그리기
		drawAgeChartWrap()

		//리뷰 그리기
		drawReviews()

		//리뷰 디자인 적용 전 값 셋팅
		setReviewVariable()

		//리뷰 디자인
		setReviewView()
	});
}





function setReviewVariable() {

	last_liNum = 3;		//초기에 보여지는 li 갯수
	li_margin = 3;
	li_count = Number($('.userReviewGraph ul li').length);
	li_height = Number($('.userReviewGraph ul li').eq(0).height());
	li_totalHeight = (li_margin + li_height) * ($('.userReviewGraph ul li').length);
}


function drawReviews() {
	//리뷰그리기
	if(reviews!=null){
		for (let i = 0; i < reviews.length; i++) {
		if (reviews[i].rCount != '' && reviews != null && reviews[i].rCount > 0) {
			$('.userReviewGraph ul').append(
				'<li>'
				+ '<div class="userReviewDeepArea"></div>'
				+ '<div class="userReviewLeftSide">'
				+ '<img src="' + reviews[i].rImgPath + '" alt="icon" class="userReviewOneRow">'
				+ '<p class="reviewText userReviewOneRow">"' + reviews[i].rMessage + '"</p>'
				+ '</div>'
				+ '<p class="countNum userReviewOneRow">' + reviews[i].rCount + '</p>'
				+  '</li>'
			)
		}
	}
	}
	

}



//연령별 그래프 컬러 초기화
function setAgeChartColor() {
	//향상된 for문 안됨 왜?? 추측1) 배열이 빈값이라서 (사이즈와상관없이)
	for (let i = 0; i < color.length; i++) {
		color[i] = "#c2c9cd";
	}
}

/*
	연령별 그래프에서 1등 컬러 셋팅하기
		[규칙] 1등이 여러개 값일 때는 색깔을 따로 지정해주지 않는다 
 
*/
function setBestAgeChartColor() {
	//1. 배열내에 최대값 찾기
	let maxNum = Math.max.apply(null, ages);

	//2. 최대값 중복검사
	//2-1. 최대값이 포함되어 있는 배열의 index값 리턴
	let maxNumIndex = ages.indexOf(maxNum);

	//2-2. 배열 복사후 배열에서 최대값을 빼준다
	let newAges = ages.filter(() => true);
	newAges.splice(maxNumIndex, 1);

	//2-3. 최대값을 빼준 배열에서 똑같은 값이 있다면, 최대값이 중복이라 색깔 지정 x,
	//없으면 최대값은 유일한 값을 가짐으로 색깔을 준다.
	if (newAges.includes(maxNum)) {
		return;
	}
	else {
		//2-4. 연령별 최대값을 가지는 1개 열에만 컬러를 준다
		color[maxNumIndex] = "#508fe8";
	}


}


/**
	
	디자인 부분
	
 */


function setReviewView() {



	//처음 리뷰 ul 높이 셋팅
	//처음 li 길이는 4개까지 보여지도록한다.
	let multi_liNum;
	if (li_count > 4) {
		multi_liNum = 4;
	} else {
		multi_liNum = li_count;
	}
	li_initHeight = multi_liNum * (li_margin + li_height);
	$('.userReviewGraph ul').css({ height: li_initHeight });


	//총 투표 수
	let count = userCount;
	//1개열에 따른 디자인 다르게 해주기
	for (let i = 0; i < $('.userReviewGraph ul li').length; i++) {
		//1열에 숫자 불러오기
		let divCount = Number($('.userReviewGraph ul li').eq(i).find('.countNum').text());
		//총 넓이 값이 될 숫자 구하기
		let graphWidth = (divCount / count) * 100;
		//div값에 넓이 설정해주기
		$('.userReviewGraph ul li').eq(i).find('.userReviewDeepArea').css({
			width: graphWidth + '%'
		});
		//div값 배경 순서대로 셋팅해주기
		if (i == 0) {
			$('.userReviewGraph ul li').eq(i).find('.userReviewDeepArea').css({
				backgroundColor: '#ffc5c5'
			});
		} else if (i == 1) {
			$('.userReviewGraph ul li').eq(i).find('.userReviewDeepArea').css({
				backgroundColor: '#ffdada'
			});
		} else if (i == 2) {
			$('.userReviewGraph ul li').eq(i).find('.userReviewDeepArea').css({
				backgroundColor: '#ffe4e4'
			});
		}

	}
	//맨 마지막 li 그라데이션 효과주기
	$('.userReviewGraph ul li').eq(last_liNum).css({
		background: 'linear-gradient(180deg, #fff4f4, rgba(255,255,255,0.5))'
	});
	$('.userReviewGraph ul li').eq(last_liNum).find('.userReviewDeepArea').css({
		background: 'linear-gradient(180deg, #ffe4e4, rgba(255,255,255,0.5))'
	});

}



// 리뷰 리스트 클릭하면 목록 늘어나기
$('.openBtn').click(function() {
	$('.userReviewGraph ul').animate({
		height: li_totalHeight + 'px'
	}, 300, 'linear', function() {
		//접기버튼 생기기
		$('.closeReviewGraphWrap').show();
	});
	//맨 마지막 li 그라데이션 효과 없애주기
	$('.userReviewGraph ul li').eq(last_liNum).css({
		background: '#fff4f4'
	});
	$('.userReviewGraph ul li').eq(last_liNum).find('.userReviewDeepArea').css({
		background: '#ffe4e4'
	});
	//열기버튼숨기기
	$('.openReviewGraphWrap').hide();
})

//접기버튼 누르면 접기
$('.closeBtn').click(function() {
	$('.userReviewGraph ul').animate({
		height: li_initHeight + 'px'
	}, 300, 'linear', function() {
		//열기버튼 생기기
		$('.openReviewGraphWrap').show();

		//맨 마지막 li 그라데이션 효과주기
		$('.userReviewGraph ul li').eq(last_liNum).css({
			background: 'linear-gradient(180deg, #fff4f4, rgba(255,255,255,0.5))'
		});
		$('.userReviewGraph ul li').eq(last_liNum).find('.userReviewDeepArea').css({
			background: 'linear-gradient(180deg, #ffe4e4, rgba(255,255,255,0.5))'
		});
	});
	//접기버튼 숨기기
	$('.closeReviewGraphWrap').hide();
})

