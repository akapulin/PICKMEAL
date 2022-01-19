<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
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
		테스트
		${memberId }
	</section>
</body>
</html>