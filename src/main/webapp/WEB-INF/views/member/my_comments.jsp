<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
				<div class="comments_wrap">
					<c:forEach var="comment" items="${rComments }">
						<fmt:formatDate var="commentDate" pattern="yyyy-MM-dd a hh:mm" value="${comment.regDate }"/>
						<div class="commentBox">
							<span class="nameAndRegDate">${comment.member.nickName } . ${commentDate }</span>
							<p class="content">${comment.content }</p>
							<span class="postTitle"><a href="#">게시글제목</a></span>
							<form action="${pageContext.request.contextPath}/member/delComment" method="post">
								<input type="hidden" value="${comment.id }" name="id">
								<input type="hidden" value="${comment.posting.id }" name="postId">
								<input type="hidden" value="R" name="category">
								<input type="submit" value="삭제" class="myCmtDelBtn">
							</form>
						</div>
					</c:forEach>
				</div>
			</div>
			<div id="eComments" class="comments">
				<h3>같이먹자</h3>
				<div class="comments_wrap">
					<c:forEach var="comment" items="${eComments }">
						<fmt:formatDate var="commentDate" pattern="yyyy-MM-dd a hh:mm" value="${comment.regDate }"/>
						<div class="commentBox">
							<span class="nameAndRegDate">${comment.member.nickName } . ${commentDate }</span> 
							<p class="content">${comment.content }</p>
							<span class="postTitle"><a href="#">게시글제목</a></span>
							<form action="${pageContext.request.contextPath}/member/delComment" method="post">
								<input type="hidden" value="${comment.id }" name="id">
								<input type="hidden" value="${comment.posting.id }" name="postId">
								<input type="hidden" value="E" name="category">
								<input type="submit" value="삭제" class="myCmtDelBtn">
							</form>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</section>
</body>
</html>