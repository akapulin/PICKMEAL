$(document).ready(function(){
	let presentTemp = parseInt($('#presentTemp').text());
	let presentP = $('#presentP').text();
	let fppMinPoint = $('#fppMinPoint').text();
	let fppMaxPoint = $('#fppMaxPoint').text();
	
	
	
	console.log(presentTemp);
	console.log(presentP);
	console.log(fppMinPoint);
	console.log(fppMaxPoint);
	
	let numForFppPosition = 0;
	let numForMannerPosition = 0;
	
	numForFppPosition = ((presentP-fppMinPoint)/(fppMaxPoint-presentP))*100;
	
	$("#presentTemp").css('left', ''+presentTemp+'%');
	$("#presentP").css('left', ''+numForFppPosition+'%');
	
	console.log(numForFppPosition);
})



