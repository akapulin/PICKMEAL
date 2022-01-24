<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>밥찡코</title>
<style>
#map {
	width: 500px; height: 500px;
	border: 5px solid #ffecec;
}
</style>
<%@ include file="/WEB-INF/views/incl/link.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=001358587c4d106ce5a3702588b8ce85&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/js/incl/index_map_SJW.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/incl/index_SJW.css" />

</head>˙
<body>
<section id="mapContent">
	<h2>사용자 위치 표시</h2>
	<form id="gameDataForm" name="gameDataForm" method="GET">
		<div id="mapRadius">
			<input type="radio" class="radius" name="radius" value="300">300m
			<input type="radio" class="radius" name="radius" value="600">600m
			<input type="radio" class="radius" name="radius" value="1000">1000m
			 
		</div>
		<div id="resCategory">
			<input type="radio" class="category" name="category" value="혼밥">혼밥
			<input type="radio" class="category" name="category" value="카페">카페
			<input type="radio" class="category" name="category" value="술집">술집
			<input type="radio" class="category" name="category" value="밥집">밥집
			
			<input type="submit" class="gamePlayBtn" value="게임하기">
			
		</div>
	</form>
		
	
	<p id="memberPosition"></p>
	<div id="map"></div>
</section>
<section id="restaurantWrap">
		<h3 class="hidden">식당 정보 표시</h3>
		<div id="restaurantInfo"><iframe id="restaurantUrl"></iframe></div>
	</section>
</body>
</html>

<%-- <c:if test="${not empty cntForRetry}">
			<input type="hidden" id="cntForRetry" name="cntForRetry" value="${cntForRetry}">
			<c:choose>
					<c:when test="${cntForRetry eq 0}"></c:when>
					<c:when test="${cntForRetry eq 1}"></c:when>					
					<c:when test="${cntForRetry eq 2}">
						<div class="retryMsg">한 번 더~</div>
					</c:when>
					<c:when test="${cntForRetry eq 3}">
						<div class="retryMsg">한 번 더어~?</div>
					</c:when>
					<c:when test="${cntForRetry eq 4}">
						<div class="retryMsg">또..?</div>
					</c:when>
					<c:when test="${cntForRetry eq 5}">
						<div class="retryMsg">입맛이 까다로우시네</div>
					</c:when>
					<c:when test="${cntForRetry eq 6}">
						<div class="retryMsg">그만 하고 먹으러 가라</div>
					</c:when>
					<c:otherwise>
						<div class="retryMsg">그냥 라면 먹어</div>
					</c:otherwise>
			</c:choose>	
		</c:if> --%>
