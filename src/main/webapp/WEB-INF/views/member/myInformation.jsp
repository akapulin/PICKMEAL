<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%-- <%@ include file="/WEB-INF/views/incl/link.jsp"%> --%>
<link  rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/myInformation.css" />
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/member/myInformation.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	<section id="content">
	<!-- <h2>내 정보</h2> -->
	<section id="informationWrap">
		<div class="eachInfoWrap">
			<div class="infoTab">이메일</div>
			<div class="info emailTab">${member.getEmail()}</div>
		</div>
		<div id="passwdWrap" class="eachInfoWrap">
			<div class="infoTab">비밀번호</div>
			<button id="changePasswdBtn" class="changeBtn">변경하기</button>
			<div id="checkOriginPwWrap">
				<input type="password" id="originPw" placeholder="기존 비밀번호를 입력하세요"/>
				<button type="button" id="checkOriginPasswdBtn">확인</button>
			</div>
			<div id="changePwWrap">
				<input type="password" id="newPw" placeholder="새 비밀번호를 입력하세요"/><br>
				<input type="password" id="checkNewPw" placeholder="한번 더 입력하세요"/>
				<button type="button" id="changePwBtn">확인</button>
			</div>
		</div>
		<div class="eachInfoWrap">
			<div class="infoTab">닉네임</div>
			<div class="info nicknameTab">${member.getNickName()}</div>
		</div>
		<div class="eachInfoWrap">
			<div class="infoTab">생년월일</div>
			<div class="info birthTab">
				<fmt:parseDate value="${member.getBirth()}" var="birth" pattern="yyyyMMdd"/>
				<fmt:formatDate value="${birth}" pattern="yyyy-MM-dd" />
			</div>
			
		</div>
		<div class="eachInfoWrap">
			<div class="infoTab">성별</div>
			<c:choose>
				<c:when test="${member.getGender() eq 'M'.charAt(0)}">
					<div class="info genderTab">남자</div>	
				</c:when>
				<c:otherwise>
					<div class="info genderTab">여자</div>
				</c:otherwise>
			</c:choose>
			
		</div>
		<div class="eachInfoWrap">
			<form id="deleteForm" name="deleteForm" action="signOutMember" method="GET">
				<button type="button" id="deleteBtn">탈퇴하기</button>
			</form>
		</div>
	</section>
</section>
</body>
</html>