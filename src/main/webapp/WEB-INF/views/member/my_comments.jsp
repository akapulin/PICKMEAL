<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 댓글</title>
<link href="${pageContext.request.contextPath}/resources/css/member/my_comments.css" rel="stylesheet" type="text/css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	<section id="my_page_section">
		<div id="comments_area">
			<div id="rComments" class="comments">
				<h3>식당추천</h3>
				<c:forEach var="comment" items="${rComments }">
					<div class="commentBox">
						<%-- <p>댓글id : ${comment.id }</p>
						<p>게시글id : ${comment.posting.id }</p>--%>
						<span class="nameAndRegDate">${comment.member.nickName } . ${comment.regDate }</span> 
						<p class="content">댓글내용 : ${comment.content }</p>
						<span class="postTitle">게시글제목</span>
					</div>
				</c:forEach>
			</div>
			<div id="eComments" class="comments">
				<h3>같이먹자</h3>
				<c:forEach var="comment" items="${eComments }">
					<div class="commentBox">
						<%-- <p>댓글id : ${comment.id }</p>
						<p>게시글id : ${comment.posting.id }</p>--%>
						<span class="nameAndRegDate">${comment.member.nickName } . ${comment.regDate }</span> 
						<p class="content">댓글내용 : ${comment.content }</p>
						<span class="postTitle">게시글제목</span>
					</div>
				</c:forEach>
			</div>
		</div>
	</section>
</body>
</html>