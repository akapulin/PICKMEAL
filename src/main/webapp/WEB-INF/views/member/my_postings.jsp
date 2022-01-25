<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 게시글</title>
<link href="${pageContext.request.contextPath}/resources/css/member/my_postings.css" rel="stylesheet" type="text/css">
<c:set var="postType" value="${pageMaker.criteria.type }"/>
</head>
<body>
	<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
	<section id="my_page_section">
		<div id="postings">
            <h3>내 게시글</h3>
            <div class="postings_wrap">
                <div class="postBtnWrap">
                   	<c:if test="${postType eq 'R'.charAt(0) }">
						<a href="${pageContext.request.contextPath}/member/myPostings/recommend" class="postBtn recommend on">식당추천</a>
	                    <a href="${pageContext.request.contextPath}/member/myPostings/together" class="postBtn together">밥친구</a>
					</c:if>
                   	<c:if test="${postType eq 'E'.charAt(0) }">
						<a href="${pageContext.request.contextPath}/member/myPostings/recommend" class="postBtn recommend">식당추천</a>
	                    <a href="${pageContext.request.contextPath}/member/myPostings/together" class="postBtn together on">밥친구</a>
					</c:if>
                </div>
                <c:forEach var="posting" items="${myPostings }">
                	<fmt:formatDate var="postDate" pattern="yyyy-MM-dd a hh:mm" value="${posting.regDate }"/>
	                <div class="postBox">
                    	<c:if test="${posting.category eq 'R'.charAt(0) }">
                    		<span class="postType">식당추천</span>
                    		<div class="post">
	                        	<span class="nameAndRegDate">${posting.member.nickName } . ${postDate }</span>
		                        <p class="postTitle"><a href="${pageContext.request.contextPath}/posting/recommend/${posting.id}">${posting.title }</a></p>
	                    	</div>
	                    	<form action="${pageContext.request.contextPath}/member/delPost/recommend" method="post">
		                        <input type="hidden" value="${posting.id}" name="postId">
		                        <input type="submit" value="삭제" class="postDelBtn">
		                    </form>
                    	</c:if>
                    	
                    	<c:if test="${posting.category eq 'E'.charAt(0) }">
                    		<span class="postType">밥친구</span>
                    		<div class="post">
	                        	<span class="nameAndRegDate">${posting.member.nickName } . ${postDate }</span>
		                        <p class="postTitle"><a href="${pageContext.request.contextPath}/posting/together/${posting.id}">${posting.title }</a></p>
	                    	</div>
	                    	<form action="${pageContext.request.contextPath}/member/delPost/together" method="post">
		                        <input type="hidden" value="${posting.id}" name="postId">
		                        <input type="submit" value="삭제" class="postDelBtn">
		                    </form>
                    	</c:if>
	                </div>
                </c:forEach>
            </div>
            <div id="postListNaviContainer">
		        <div class="postListNaviWrap">
		          <ul>
		            <!-- 식당추천 게시판 페이징 -->
		          	<c:if test="${fn:contains(postType,'R') }">
			          	<c:if test="${pageMaker.prevBtn eq true }">
			            	<li><a href="${pageContext.request.contextPath}/member/myPostings/recommend?page=${pageMaker.startNum - 1 }">&lt;</a></li>
			            </c:if>
			            <c:forEach var="i" begin="${pageMaker.startNum }" end="${pageMaker.endNum }">
			 					<c:if test="${pageMaker.criteria.page eq i }">
			 						<li><a href="${pageContext.request.contextPath}/member/myPostings/recommend?page=${i }" class="postListNaviSelected">${i }</a></li>
			 					</c:if>
								<c:if test="${pageMaker.criteria.page ne i }">
			 						<li><a href="${pageContext.request.contextPath}/member/myPostings/recommend?page=${i }">${i }</a></li>
			 					</c:if>
						</c:forEach>
						<c:if test="${pageMaker.nextBtn eq true }">
			            	<li><a href="${pageContext.request.contextPath}/member/myPostings/recommend?page=${pageMaker.endNum + 1 }">&gt;</a></li>
			            </c:if>
		            </c:if>
		            <!-- 밥친구 게시판 페이징 -->
		          	<c:if test="${fn:contains(postType,'E') }">
			          	<c:if test="${pageMaker.prevBtn eq true }">
			            	<li><a href="${pageContext.request.contextPath}/member/myPostings/together?page=${pageMaker.startNum - 1 }">&lt;</a></li>
			            </c:if>
			            <c:forEach var="i" begin="${pageMaker.startNum }" end="${pageMaker.endNum }">	 					
			 					<c:if test="${pageMaker.criteria.page eq i }">
			 						<li><a href="${pageContext.request.contextPath}/member/myPostings/together?page=${i }" class="postListNaviSelected">${i }</a></li>
			 					</c:if>	 				
								<c:if test="${pageMaker.criteria.page ne i }">
			 						<li><a href="${pageContext.request.contextPath}/member/myPostings/together?page=${i }">${i }</a></li>
			 					</c:if>
						</c:forEach>
						<c:if test="${pageMaker.nextBtn eq true }">
			            	<li><a href="${pageContext.request.contextPath}/member/myPostings/together?page=${pageMaker.endNum + 1 }">&gt;</a></li>
			            </c:if>
		            </c:if>
		          </ul>
		        </div>
	      </div>
        </div>
	</section>
</body>
</html>