<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 게시글</title>
<link href="${pageContext.request.contextPath}/resources/css/member/my_postings.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	<section id="my_page_section">
		<div id="postings">
            <h3>내 게시글</h3>
            <div class="postings_wrap">
                <div class="postBtnWrap">
                    <a href="#" class="postBtn">같이먹자</a>    
                    <a href="#" class="postBtn">식당추천</a>
                </div>
                <c:forEach var="posting" items="${myPostings }">
	                <div class="postBox">
	                    <span class="postType">
	                    	<c:if test="${posting.category eq 'R'.charAt(0) }">식당추천</c:if>
	                    	<c:if test="${posting.category eq 'E'.charAt(0) }">같이먹자</c:if>
	                    </span>
	                    <div class="post">
	                        <span class="nameAndRegDate">${posting.member.nickName } . ${posting.regDate }</span>
	                        <p class="postTitle"><a href="#">${posting.title }</a></p>
	                    </div>
	                    <form action="#" method="post">
	                        <input type="hidden" value="">
	                        <input type="hidden" value="">
	                        <input type="hidden" value="">
	                        <input type="submit" value="삭제" class="postDelBtn">
	                    </form>
	                </div>
                </c:forEach>
            </div>
            <div class="pageNumBox">처음 이전 1 / 2 / 3 / 4 / 5 / 6 / 7 / 8 / 9 / 10 다음 맨끝</div>
        </div>
	</section>
</body>
</html>