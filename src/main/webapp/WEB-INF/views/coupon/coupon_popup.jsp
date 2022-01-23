<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰사용 팝업창</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
	section{width: 400px; height:520px;  border: 3px solid #000; box-sizing: border-box; margin: 0 auto;}
	#coupondiv{ width: 400px; height: 500px; text-align: center;}
	#RestaurantName{font-size: 25px; height: 30px; line-height: 30px;}
	img{margin: 0 auto; width: 250px; height: 250px;  border: 2px solid red; border-radius: 10px;}
	#couponprice{font-size: 18px; width: 100%; height: 18px;}
	#couponNumber{font-size: 18px; width: 100%; height: 18px;}
	#couponlimit{font-size: 18px; width: 100%; height: 18px;}
	#submitBtn{background-color: #fff; border: 1px solid #000; width:100px; height: 40px;}
</style>
</head>
<body>
	<section>
        <div id="coupondiv">
        	<form action="usedCoupon" method="Post">
        		<input type="hidden"  name="close" value="${close}"/>
                <p id="RestaurantName">${coupon.getRestaurant().getRName()}</p>
                <img src="/pickmeal/resources/img/coupon/CouponQR.png" alt="" width="250px" height="250px"/>
                <p id="couponprice">${coupon.getCouponCategory().getCouponName()} 쿠폰</p>
                <p id="couponNumber">${coupon.getCouponNumber()}</p>
                <p id="couponlimit">${coupon.getCouponCategory().getLimitPrice()}이상 결제가능</p>
                <input type="hidden" value="${coupon.getId()}" name="couponid">
                <button id="submitBtn" type="submit">USE COUPON</button>
            </form>
        </div>
    </section>
    <script>
    	window.onload = function() {
			if($("input[name=close]").val() == "close"){
				opener.parent.reloadPage();
				self.close();
			}
		}
    </script>
</body>
</html>