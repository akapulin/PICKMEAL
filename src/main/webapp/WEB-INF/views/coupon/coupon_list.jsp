<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메인-쿠폰 리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
        body, html {height: 100%;}
        body, h1, h2, h3, h4, h5, h6, p, ul, dl, dd, figure, fieldset, input, th, td,img,div,p {margin: 0; padding: 0;}
        body, input, button {font-family: 'Noto Sans KR';}
        input[type="text"] {text-indent: 5px;}
        input[type="submit"] {cursor: pointer;}
        li {list-style: none;}
        a {text-decoration: none; color: #000;}
        address, small, em, th {font: normal normal 1em 'Noto Sans KR', sans-serif;}
        .hidden {position: absolute; left: -9999px;}
        .text_hidden {text-indent: -9999px;}
        fieldset, img {border: 0;}
        table {border-collapse: collapse;}
        body{
        font-family: 'Noto Sans KR', sans-serif;    
        }
        @font-face {
            font-family: 'DungGeunMo';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_six@1.2/DungGeunMo.woff') format('woff');
            font-weight: normal;
            font-style: normal;
        }
                /*상단 유저명*/
        #CouponList{width: 70%; height: 100%; margin: 180px auto 0; }
        #nickName{width: 90%; height: 50px; font-size: 35px; margin-left: 40px;}
        
        /*라디오버튼*/
        .hiddenclass{display: none;}

        /*미사용 쿠폰*/
        #unusedCouponsWrap{width: 400px; height: 750px; float: left; margin-right: 30px; margin-top: 40px;}
        #divName1{margin: 15px;font-weight: 900; font-size: 22px;}
        /*색깔 : #f23f3f (적) /  #ffecec (분) / #f5f5f5 (회)*/
        /*미사용 쿠폰 상세*/
        .couponWrap{ position: relative; width: 370px; height: 130px;  padding: 10px; float: left; margin-left: 15px; margin-top: 20px; border-top:3px solid #f23f3f; border-bottom: 3px solid #f23f3f;  background-color: #f1f1f0;}
        .rName{margin-left: 15px; width: 365px; height: 25px; font-size: 20px; margin-top: 5px; font-weight: 900;}
        .cName{margin-left: 15px; width: 365px; height: 40px; font-size: 33px;  float: left;  font-weight: 900; color: #f23f3f; }
        .cNumber{font-size: 14px; margin-left: 15px; margin-top: 10px; width: 365px; height: 20px;  float: left; font-family: 'Noto Sans KR', sans-serif; }
        .cLimit{text-indent: 15px; font-size: 12px; width: 180px; height: 15px; float: left; margin-top: 20px; }
        .cregDate{ text-align: right; font-size: 12px;  width: 175px; height: 15px;  float: left; margin-top: 20px; color: red;}
        /*미사용쿠폰 라벨*/
        .couponIncubate{position: absolute; top: 0; left: 0; width: 100%; height: 100%;}

        #line{width: 2px;height: 800px;; float: left; background-color: black; padding-top: 25px; margin-left: 15px;}
        
        /*사용 쿠폰*/
        #usedCouponsWrap{width: 700px; height: 750px;float: left; overflow: scroll;  margin-left: 10px; padding-left:30px; margin-top: 40px;}
        #divName2{margin: 15px;font-weight: 900; font-size: 22px; margin-bottom: 25px;}
        /*사용 쿠폰 목록 테이블*/
        #usedCouponTable{width:650px; margin-left: 5px;}
       /*컬럼 제목 상세*/
        .ColumnWrap{ width:650px; height:45px; border-top: 2px solid #ffecec;}
        .Column{border: 2px solid #ffecec; height: 45px; font-weight: 800; background-color: #f23f3f; color: #fff;}
        .CouponName{width: 120px; border-left: 4px solid #369;}
        .RestaurantName{width: 220px;}
        .CouponNumber{width: 192px; }
        .CouponregDate{width: 115px;}

        /* 컬럼 내부 상세*/
        .ColumnInWrap{width: 650px; height: 38px; border-left: 4px solid #369; border-bottom: 1px solid #ffecec;}
        .ColumnIn{text-align: left; text-indent: 10px; font-size: 15px;}
        .CouponNameIn{width: 130px; font-weight: 800; color: #369; font-size: 17px; text-align: center; text-indent: 0;}
        .RestaurantNameIn{width: 270px; height: 15px; font-size: 15px;}
        .CouponNumberIn{width: 180px; font-size: 15px; }
        .CouponregDateIn{width: 115px; font-size: 15px; border-right: 2px solid #ffecec; text-align: center; text-indent: 0;}
        
    </style>
</head>
<body>
	<header>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	</header>
	<main>
		<section id="CouponList">
	            <h2 id="nickName">${member.nickName}회원님 쿠폰</h2>
	            	<div id="unusedCouponsWrap">
	            		<form method ="get" name="usedCouponPopup">
	                	<h3>미사용 쿠폰</h3>
	                        <c:forEach var="unusedcoupons" items="${unusedcoupons}">
	                            <div class="couponWrap">
	                        		<p class="rName">"${unusedcoupons.getRestaurant().getRName()}"</p>
	                        		<p class="cName">${unusedcoupons.getCouponCategory().getCouponName()} 쿠폰</p>
	                        		<p class="cNumber">${unusedcoupons.getCouponNumber()}</p>
	                        		<p class="cLimit">${unusedcoupons.getCouponCategory().getLimitPrice()} 이상 사용가능</p>
	                        		<p class="cregDate">${unusedcoupons.getRegDate()}</p>
	                        		<label id="inlabel${unusedcoupons.id}" for="label${unusedcoupons.id}" class="couponIncubate"></label>
	                        		<input id="label${unusedcoupons.id}" class="hiddenclass" type="radio" name="couponId" value="${unusedcoupons.id}" />
	                    		</div>
	                    		
	                        </c:forEach>
	                	</form>
	            	</div>
	            <div id="usedCouponsWrap">
	                <h3>사용 쿠폰</h3>
	                <table id="userSaleslisttable">
	                    <tr class="ColumnWrap">
		                    <th class="Column CouponName">쿠폰명</th>
		                    <th class="Column RestaurantName">식당명</th>
		                    <th class="Column CouponNumber">쿠폰번호</th>
		                    <th class="Column CouponregDate">사용가능일자</th>
	                    </tr>
	                    <c:forEach var="usedcoupons" items="${usedcoupons}">
	                        <tr class="ColumnInWrap">
	                            <td class="CouponNameIn ColumnIn">${usedcoupons.getCouponCategory().getCouponName()}</td>
	                            <td class="RestaurantNameIn ColumnIn">${usedcoupons.getRestaurant().getRName()}</td>
	                            <td class="CouponNumberIn ColumnIn">${usedcoupons.getCouponNumber()}</td>
	                            <td class="CouponregDateIn ColumnIn">${usedcoupons.getRegDate()}</td>
	                        </tr>
	                    </c:forEach>
	                </table>
	            </div>
	        </section>
        </main>
        <footer>
        </footer>
</body>
</html>

<script>
		/*
		$(".couponIncubate").click(function(){
			$("#submitBtn").click();
		})*/
		
      	$(".hiddenclass").click(function(e){
    		e.preventDefault();
    		console.log($('.hiddenclass').val());
    		usedPopupCoupon("usedCouponPopup");
    		
    		})
 
      	function usedPopupCoupon(Url){
            let windowWidth = window.screen.width;
            let windowHeight = window.screen.height;
            
            let popupX = (windowWidth/2) - 420;
            let popupY = (windowHeight/2) -269;
            
            let popUpdateUrl = "http://localhost:8080/pickmeal/" + Url;
            let popUpdateOption = "width=420px, height=538px, top=" + popupY + "px, left=" + popupX + "px";
            let popUpdateTitle = "쿠폰 사용"
            	
            window.open(popUpdateUrl, popUpdateTitle, popUpdateOption);
            
            
            let usedCouponPopup = document.usedCouponPopup;
            
            usedCouponPopup.target = popUpdateTitle;
            usedCouponPopup.action = popUpdateUrl;
            usedCouponPopup.method ="get";
            
            usedCouponPopup.submit();
            
        }
		
      	function reloadPage() {
            location.reload();
        }
</script>