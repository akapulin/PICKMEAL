<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/incl/link.jsp"%>
<title>메인-쿠폰 리스트</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/coupon/coupon_list.css" />
</head>
<body>
	
	<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	
	<main>
		<section id="CouponList">
	            
	            	<div id="unusedCouponsWrap">
	            		<form method ="get" name="usedCouponPopup">
	                	<h3 id="divName1">미사용 쿠폰</h3>
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
	                <h3 id="divName2">사용 쿠폰</h3>
	                <table id="usedCouponlisttable">
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