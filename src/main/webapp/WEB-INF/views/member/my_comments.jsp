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
			<div id="rComments">
				<c:forEach var="comment" items="${rComments }">
					<p>댓글id : ${comment.id }</p>
					<p>게시글id : ${comment.posting.id }</p>
					<p>멤버id : ${comment.member.id }</p>
					<p>댓글내용 : ${comment.content }</p>
					<p>시간 : ${comment.regDate }</p>
				</c:forEach>
			</div>
			<div id="eComments">
				<c:forEach var="comment" items="${eComments }">
					<p>댓글id ${comment.id }</p>
					<p>게시글id ${comment.posting.id }</p>
					<p>멤버id ${comment.member.id }</p>
					<p>댓글내용 ${comment.content }</p>
					<p>시간 ${comment.regDate }</p>
				</c:forEach>
			</div>
		</div>
	</section>
</body>
</html>