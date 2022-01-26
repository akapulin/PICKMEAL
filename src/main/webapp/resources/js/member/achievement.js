$(document).ready(function(){
	let presentTemp = parseInt($('#presentTemp').text());
	let presentP = $('#presentP').text();
	let fppMinPoint = $('#fppMinPoint').text();
	let fppMaxPoint = $('#fppMaxPoint').text();
	let necessaryPoint = fppMaxPoint-fppMinPoint;
	let PointWithNowlevel = (presentP - fppMinPoint);
	
	//console.log(presentTemp);
	//console.log("현재 점수 : "+presentP);
	//console.log("최저 점수 : " + fppMinPoint);
	//console.log("최고 점수 : " + fppMaxPoint);
	//console.log("필요 점수 : " + necessaryPoint);
	//console.log("레벨포인트 : " + PointWithNowlevel);
	
	let numForFppPosition = 0;
	let numForMannerPosition = 0;
	
	numForFppPosition = ((presentP-fppMinPoint)/(necessaryPoint))*100;
	
	
	$("#presentTemp").css('left', ''+presentTemp+'%');
	
	$("#presentP").css('left', ''+numForFppPosition+'%');
	$("#progressForP").val(PointWithNowlevel);
	
	console.log(numForFppPosition);
})



