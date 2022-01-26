
$(document).ready(function() {

	
	//포춘쿠키 화면에 랜덤 위치잡아주기
	let fortune_left = Math.floor(Math.random() * (window.innerWidth-510)); 
	let fortune_top = Math.floor(Math.random() * (window.innerHeight-210));
	$('.fortune').css({top:fortune_top,left:fortune_left});
	showFortune();
	
})

$('.fortune').click(function(){
	//포춘쿠키 뿌려주기
	openFortune()
	
})


//포춘쿠키 발생이벤트
function showFortune(){
	var tl = new TimelineMax({yoyo:false, repeat:0, repeatDelay:1});
   $('.fortune-message span').hide();

   tl.to($('.fortune'),0.1,{rotation:5});	
	tl.to($('.fortune'),0.1,{rotation:-5});
}

function openFortune(){
	var tl = new TimelineMax({yoyo:false, repeat:0, repeatDelay:1});
   $('.fortune-message span').show();
   tl.to($('.fortune'),0.1,{rotation:-5, delay:1});
   tl.to($('.fortune'),0.1,{rotation:5});
   tl.to($('.fortune'),0.1,{rotation:-5});
   tl.to($('.fortune'),0.1,{rotation:5});
   tl.to($('.fortune'),0.1,{rotation:-5});
   tl.to($('.fortune'),0.1,{rotation:0});
   tl.addLabel("break", "+=0.3");
   tl.to($('.fortune-left'),0.5,{rotation:-45, x:-70, y:70},"break");
   tl.to($('.fortune-right'),0.5,{rotation:45, x:70, y:70},"break");
   tl.from($('.fortune-message span'),1,{x:'110%'},"break");
   tl.to($('.fortune'),1,{display:'none'});

}


	
	
	