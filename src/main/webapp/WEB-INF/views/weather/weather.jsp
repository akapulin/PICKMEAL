<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<!-- 현재시간(페이지 켠 순간만) - 김재익 -->
<c:set var="today" value="<%=new java.util.Date()%>" />
<c:set var="now"><fmt:formatDate value="${today}" pattern="HH" /></c:set>
<body>
	<div id="weatherWrap">
        <div id="weather">
            <c:choose>
        		<c:when test="${weather.sky eq 1 }">
        			<c:if test="${now gt 6 && now lt 18}">
	            		<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_sun.gif"/>
        			</c:if>
        			<c:if test="${now gt 18 || now lt 6 }">
        				<img src="https://img.icons8.com/dusk/256/000000/bright-moon.png"/>
	            		<%-- <img src="${pageContext.request.contextPath}/resources/img/weather/icons8_moon_and_stars_64.png"/> --%>
        			</c:if>
        		</c:when>
        		<c:when test="${weather.sky eq 2 }">
        			<img src="https://img.icons8.com/dusk/256/000000/cloud.png"/>
        			<%-- <img src="${pageContext.request.contextPath}/resources/img/weather/icons8_cloud_64.png"/> --%>
        		</c:when>
        		<c:when test="${weather.sky eq 3 }">
        			<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_rain.gif"/>
        		</c:when>
        		<c:when test="${weather.sky eq 4 }">
        			<img src="https://img.icons8.com/dusk/256/000000/snow-storm.png"/>
        			<%-- <img src="${pageContext.request.contextPath}/resources/img/weather/icons8_snow_64.png"/> --%>
        		</c:when>
        	</c:choose>
            <div class="temperatureWrap"><span class="temperature">${weather.temperature }</span><span class="symbol">&#8451;</span></div>
        </div>
        <div id="forecast">
        	<c:forEach var="forecastItem" items="${forecast.pmwList}" varStatus="timeOrder" >
        		<div class="forecastItem">
        			<span>
        				<c:if test="${timeOrder.index eq 0 }">오전 8시</c:if>
        				<c:if test="${timeOrder.index eq 1 }">오후 12시</c:if>
        				<c:if test="${timeOrder.index eq 2 }">오후 18시</c:if>
        				<c:if test="${timeOrder.index eq 3 }">오후 22시</c:if>
	                </span>
	        		<c:if test="${forecastItem.sky eq 1 }">
        				<c:if test="${timeOrder.index gt 1 }"> <!-- 1보다 큰 = 오후18시 오후22시 -->
        					<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_moon_and_stars_64.png"/>
        				</c:if>
        				<c:if test="${timeOrder.index lt 2 }"> <!-- 2보다 작은 = 오전8시 오후12시 -->
	            			<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_sun.gif"/>
        				</c:if>
	        		</c:if>
	        		<c:if test="${forecastItem.sky eq 2 }">
	        			<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_cloud_64.png"/>
	        		</c:if>
	        		<c:if test="${forecastItem.sky eq 3 }">
	        			<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_rain.gif"/>
	        		</c:if>
	        		<c:if test="${forecastItem.sky eq 4 }">
	        			<img src="${pageContext.request.contextPath}/resources/img/weather/icons8_snow_64.png"/>
	        		</c:if>
	                <div class="temperatureWrap">
	                	<span class="temperature">${forecastItem.temperature }</span><span class="symbol">&#8451;</span>
	                </div>
            	</div>
        	</c:forEach>
        </div>
        <div id="howAboutThis">
        	<c:choose>
        		<c:when test="${weather.sky eq 1 }">
        			맑고
        		</c:when>
        		<c:when test="${weather.sky eq 2 }">
        			흐리고
        		</c:when>
        		<c:when test="${weather.sky eq 3 }">
        			비오고
        		</c:when>
        		<c:when test="${weather.sky eq 4 }">
        			눈오고
        		</c:when>
        	</c:choose>
        	<c:choose>
        		<c:when test="${weather.temperature lt 10 }">
        			춥네
        		</c:when>
        		<c:when test="${weather.temperature gt 25 }">
        			덥네
        		</c:when>
        		<c:otherwise>
        			적당하네
        		</c:otherwise>
        	</c:choose>
        	이거 어때?
        </div>
        <div id="wetherMenu">
            <img src="${weatherMenu.imgPath }"/>
            <span class="weatherMenuName">${weatherMenu.menuName }</span>
        </div>
    </div>
</body>
</html>