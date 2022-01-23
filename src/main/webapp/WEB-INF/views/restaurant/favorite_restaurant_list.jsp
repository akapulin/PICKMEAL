<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="/WEB-INF/views/incl/link.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=001358587c4d106ce5a3702588b8ce85&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/js/favorite_restaurant/favorite_restaurant_list.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restaurant/favorite_restaurant_list.css" />

</head>
<body>

	<header>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	</header>
	<main>
		<section id="favoritelistWrap">
			<div id="favoritelist">
				<h3 id="favoritelistMName">찜 식땅</h3>
	            <form>
	            <c:forEach var="frlist" items="${frlist}">
	              		  <div class="restaurantWrap" id="restaurantWrap${frlist.getId()}">
	                    <div class="restaurantInfoWrap">
	                        <input type= "text" class="frName" id="frName${frlist.getId()}" value="${frlist.getRestaurant().getRName()}" disabled/>
	                        <input type="radio" id="label${frlist.getId()}" value="${frlist.getId()}" name="frRadioBtn" class="frRadio" onclick="goMapRestaurant(this)"/>
	                        <label id="inlabel${frlist.getId()}" for="label${frlist.getId()}" class="frIncubate" ></label>
	                        <input type="hidden" value="${frlist.getRestaurant().getLat()}" id="lat${frlist.getId()}">
	                        <input type="hidden" value="${frlist.getRestaurant().getLng()}" id="lng${frlist.getId()}">
	                        <input type="hidden" value="${frlist.getRestaurant().getAddress()}"id="address${frlist.getId()}" name="address">
	                    </div>
	                    <div class="deleteBtnWrap">
	                    	<input type="radio" id="downlabel${frlist.getId()}" value="${frlist.getId()}" name="frdeleteradioBtn" class="frdeleteradioBtn" onclick="deletefavorite(this)"/>
	                    	<label id="downinlabel${frlist.getId()}" for="downlabel${frlist.getId()}" class="fredeleteIncubate"></label>
	                        <img class="favoriteremoveimg" src="${pageContext.request.contextPath}/resources/img/restaurant/favorite/hart.jpg">
	                    </div>
	            	</div>
				</c:forEach>
				</form>
			</div>
	        <div id="kakaoMapWrap">
	            <h3 id="detailMName">땅 찾기</h3>
	            <div id="kakaoMap"></div>
	            <div id="restaurantDetail">
	                <input type="text" id="detailName" value="식당 이름" disabled/>
	                <input type="text"  id="detailAddress" value="식당 주소" disabled/>
	            </div>
	        </div>
		</section>
	</main>
</body>
</html>