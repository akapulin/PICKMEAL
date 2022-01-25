<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <%@ include file="/WEB-INF/views/incl/link.jsp"%> --%>
<link  rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/achievement.css" />
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/member/achievement.js" defer></script>
</head>
<body>
	<%-- <jsp:include page="/WEB-INF/views/incl/header.jsp"/> --%>
	<jsp:include page="/WEB-INF/views/member/my_page_SJW.jsp"/>
	
	<div id="achieveWrap">
		<h2>업적</h2>
        <div id="firstLineWrap">
            <div id="attendWrap">
                <h4 id="attendH">출석부</h4>
                <div id="spanAtdWrap">
					<span class="spanAtd" id="totalAtd">
						<span class="spanAtd" id="presentAtd">${member.getAttendance()} </span>/ 31
					</span>
                </div>
            </div>
           
            <div id="mannerWrap">
                <h4 id="mannerH">신뢰 온도</h4>
                <div id="maxTemp">100도</div>
                <div id="progressMWrap">
	                <progress id="progressForM" value="${member.getMannerTemperature()}" min="0" max="100"></progress>
	                <div id="presentTemp">${member.getMannerTemperature()}도</div>
                </div>
            </div>
       </div>

        <div id="pointWrap">
            <h4>포인트 적립 내역</h4>
            <div id="pointProgressWrap">
                <div id="leftBorderWrap" class="borderWrap">
                    <p id="fppMinPoint"><fmt:parseNumber value="${fppMin.getPoint()}" integerOnly="true" type="number"/></p> <!-- 값 백에서 받아야 함 -->
                    <span>${fppMin.getImgPath()}</span><!-- level에 맞는 이미지 가져와야 함 -->
                </div>
                <!-- min이랑 max값 백에서 받아야 함 -->
                <div id="progressPWrap">
	                <progress id="progressForP" value="${member.getFoodPowerPoint()}" min="<fmt:parseNumber value="${fppMin.getPoint()}" integerOnly="true" type="number"/>" max="<fmt:parseNumber value="${fppMax.getPoint()}" integerOnly="true" type="number"/>"></progress>
	                <div id="presentP">${member.getFoodPowerPoint()}</div> <!-- 뒤에 max의 값 가져와야 함 -->
                </div>
                <div id="rightBorderWrap" class="borderWrap">
                    <p id="fppMaxPoint"><fmt:parseNumber value="${fppMax.getPoint()}" integerOnly="true" type="number"/></p> <!-- 값 백에서 받아야 함 -->
                    <span>${fppMax.getImgPath()}</span><!-- level에 맞는 이미지 가져와야 함 -->
                </div>
            </div>
            <div id="pointRecordWrap">
                <table id="recordTable">
                    <tr>
                        <th class="thPoint">포인트</th>
                        <th class="thCategory">적립 구분</th>
                        <th class="thDate">적립 날짜</th>
                    </tr>
                    <c:forEach var="f" items="${fppList}">
	                    <tr>
	                    	<td data-fpp="${f.id}" class="tdPoint tdMid td">+${f.getPoint()}</td>
	                        <td class="tdCategory td">${f.getDetail().getKor()}</td>
	                        <td class="tdDate tdMid td">${f.getRegDate()}</td>
						</tr>
                    </c:forEach>
                </table>
            </div>
        </div>
    </div>
	 
</body>
</html>