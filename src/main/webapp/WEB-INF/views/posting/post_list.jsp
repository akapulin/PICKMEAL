<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/incl/link.jsp"%>
<script src="${pageContext.request.contextPath}/resources/js/posting/post_list.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/posting/post.css" />
<!-- 
	java char type은  jstl eq로 비교시 에러남!!
	fn:contain로 비교할 것	
 -->
 <c:set var="postType" value="${pageMaker.criteria.type }"/>
<c:choose>
	<c:when test="${fn:contains(postType,'N')}"><title>밥찡코 - 공지사항</title></c:when>
	<c:when test="${fn:contains(postType,'R')}"><title>밥찡코 - 식당추천</title></c:when>
	<c:when test="${fn:contains(postType,'E')}"><title>밥찡코 - 밥친구</title></c:when>
	<c:otherwise><title>밥찡코</title></c:otherwise>
</c:choose>

</head>
<body>
<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
 <section id="totalPostContainer">
    <h2 class="hidden">게시판목록</h2>
    <c:if test="${not empty postType }">
    <div id="postListContainer">
    <c:if test="${fn:contains(postType,'N')}">
    	<a href="${pageContext.request.contextPath}/posting/notice/write" class="postListWriteBtn">글쓰기</a>
    </c:if>
   <c:if test="${fn:contains(postType,'R')}">
    	<a href="${pageContext.request.contextPath}/posting/recommend/write" class="postListWriteBtn">글쓰기</a>
    </c:if>
    <c:if test="${fn:contains(postType,'E')}">
    	<a href="${pageContext.request.contextPath}/posting/together/write" class="postListWriteBtn">글쓰기</a>
    </c:if>
    
      <div id="postListTitleContainer">
        <div class="postListTitleWrap">
          <c:if test="${fn:contains(postType,'N')}">
          	<h3>공지사항</h3>
          	<p>읽어주시면 밥찡코를 더 잘 활용할 수 있어요</p>
          </c:if>
          <c:if test="${fn:contains(postType,'R')}">
          	<h3>식당추천</h3>
          	<p>나만 알고 있는 찐 맛집을 추천해주세요!</p>
          </c:if>
          <c:if test="${fn:contains(postType,'E')}">
          	<h3>밥친구</h3>
          	<p>우리는 칭구칭구 밥칭구~ 혼자라도 2인세트 먹을 수 있지!</p>
          </c:if>
        </div>
		<!--<c:if test="${fn:contains(postType,'R') || fn:contains(postType,'E')}">
	        <div class="postListTitleBtnWrap">
	          <ul>
	            <li><a href="#" class="postListTitleBtnOn">식당</a></li>
	            <li><a href="#">카페</a></li>
	            <li><a href="#">술집</a></li>
	          </ul>
	        </div>
        </c:if>-->
      </div>
      <div id="postListContentContainer">
        <table class="postListContentTable">
          <tr>
            <th>제목</th>
            <th>작성자</th>
            <th>작성일</th>
            <th>조회</th>
            <th>좋아요</th>
          </tr>
          <c:forEach var="post" items="${postings }">
            <tr>
            <td>
              <!-- 밥친구 게시판 -->
              <c:if test="${fn:contains(postType,'E') }">
	              <ul class="postListContentTitleTagsWrap">
	              <!-- 식사완료 상태이면 -->
	              <c:if test="${post.mealChk eq true }">
	              	<li class="postListComTagTogetherCompMeal">
	                  <p>식사완료</p>
	              	</li>
	              </c:if>
	              <!-- 식사완료 상태가 아니면 -->
	              <c:if test="${post.mealChk eq false }">
	                <li>
	                  <p>모집중</p>
	                  <!-- 모집중상태 -->
	                  <c:if test="${post.recruitment eq true }">
	                  	<div class="postListComTagTogetherIng"></div>
	                  </c:if>
	                  <!-- 모집완료상태 -->
	                  <c:if test="${post.recruitment eq false }">
	                  	<div class="postListComTagTogetherComp"></div>
	                  </c:if>
	                </li>
	             </c:if> 
	             	<!-- 주소 잘라주기 --> 
	             	<c:set var="addressList" value="${fn:split(post.address,' ') }" />
	                <li>${addressList[0]} ${addressList[1]} ${addressList[2]}</li>
	                <fmt:formatDate var="mealTime" pattern="MM-dd HH:mm" value="${post.mealTime }"/>
	                <li>${mealTime }</li>
	              </ul>
              </c:if>
              <!-- 제목 & 댓글 수-->
              <c:if test="${fn:contains(postType,'N') }">
              	  <a href="${pageContext.request.contextPath}/posting/notice/${post.id}" class="postListContentTitle">${post.title } (${post.commentsNumber})</a>
              </c:if>
              <c:if test="${fn:contains(postType,'R') }">
              	  <a href="${pageContext.request.contextPath}/posting/recommend/${post.id}" class="postListContentTitle">${post.title } (${post.commentsNumber})</a>
              </c:if>
              <c:if test="${fn:contains(postType,'E') }">
              	  <a href="${pageContext.request.contextPath}/posting/together/${post.id}" class="postListContentTitle">${post.title } (${post.commentsNumber})</a>
              </c:if>
              
            </td>
            <td>${post.member.nickName }</td>
            <fmt:formatDate var="postDate" pattern="yy-MM-dd" value="${post.regDate }"/>
            <td>${postDate }</td>
            <td>${post.views }</td>
            <td>${post.likes }</td>
          </tr>
          </c:forEach>
        </table>
      </div>
      <div id="postListSubInfoContainer">
        <div class="postListSortWrap">
          <ul>
            <li><a href="#" class="postListSortOn">모집중</a></li>
            <li><a href="#">최신순</a></li>
            <li><a href="#">조회순</a></li>
            <li><a href="#">좋아요순</a></li>
          </ul>
        </div>
        <div class="postListSearchWrap">
          <ul>
            <li>
              <select class="postListSearchSelectBox postInputTCom" name="">
                <option value="pTitle">제목</option>
                <option value="PWriter">작성자</option>
              </select>
            </li>
            <li>
              <input type="text" class="postListSearchInput postInputTCom">
            </li>
            <li><a href="#" class="postListSearchBtn postBtnCom">검색</a></li>
          </ul>
        </div>
      </div>
      <div id="postListNaviContainer">
        <div class="postListNaviWrap">
          <ul>
            <!-- 공지사항게시판 페이징 -->
          	<c:if test="${fn:contains(postType,'N') }">
          		<!-- 이전버튼 여부 -->
	          	<c:if test="${pageMaker.prevBtn eq true }">
	            	<li><a href="${pageContext.request.contextPath}/posting/notice?page=${pageMaker.startNum - 1 }">&lt;</a></li>
	            </c:if>
	            <!-- 페이징 숫자 -->
	            <c:forEach var="i" begin="${pageMaker.startNum }" end="${pageMaker.endNum }">
	 					<!-- 현재 선택된 페이지 색찐하게 표현 -->
	 					<c:if test="${pageMaker.criteria.page eq i }">
	 						<li><a href="${pageContext.request.contextPath}/posting/notice?page=${i }" class="postListNaviSelected">${i }</a></li>
	 					</c:if>
	 					<!-- 현재 비선택된 페이지들 -->
						<c:if test="${pageMaker.criteria.page ne i }">
	 						<li><a href="${pageContext.request.contextPath}/posting/notice?page=${i }">${i }</a></li>
	 					</c:if>
				</c:forEach>
				<!-- 이후버튼 여부ㅡ -->
				<c:if test="${pageMaker.nextBtn eq true }">
	            	<li><a href="${pageContext.request.contextPath}/posting/notice?page=${pageMaker.endNum + 1 }">&gt;</a></li>
	            </c:if>
            </c:if>
            <!-- 식당추천 게시판 페이징 -->
          	<c:if test="${fn:contains(postType,'R') }">
	          	<c:if test="${pageMaker.prevBtn eq true }">
	            	<li><a href="${pageContext.request.contextPath}/posting/recommend?page=${pageMaker.startNum - 1 }">&lt;</a></li>
	            </c:if>
	            <c:forEach var="i" begin="${pageMaker.startNum }" end="${pageMaker.endNum }">
	 					<c:if test="${pageMaker.criteria.page eq i }">
	 						<li><a href="${pageContext.request.contextPath}/posting/recommend?page=${i }" class="postListNaviSelected">${i }</a></li>
	 					</c:if>
						<c:if test="${pageMaker.criteria.page ne i }">
	 						<li><a href="${pageContext.request.contextPath}/posting/recommend?page=${i }">${i }</a></li>
	 					</c:if>
				</c:forEach>
				<c:if test="${pageMaker.nextBtn eq true }">
	            	<li><a href="${pageContext.request.contextPath}/posting/recommend?page=${pageMaker.endNum + 1 }">&gt;</a></li>
	            </c:if>
            </c:if>
            <!-- 밥친구 게시판 페이징 -->
          	<c:if test="${fn:contains(postType,'E') }">
	          	<c:if test="${pageMaker.prevBtn eq true }">
	            	<li><a href="${pageContext.request.contextPath}/posting/together?page=${pageMaker.startNum - 1 }">&lt;</a></li>
	            </c:if>
	            <c:forEach var="i" begin="${pageMaker.startNum }" end="${pageMaker.endNum }">	 					
	 					<c:if test="${pageMaker.criteria.page eq i }">
	 						<li><a href="${pageContext.request.contextPath}/posting/together?page=${i }" class="postListNaviSelected">${i }</a></li>
	 					</c:if>	 				
						<c:if test="${pageMaker.criteria.page ne i }">
	 						<li><a href="${pageContext.request.contextPath}/posting/together?page=${i }">${i }</a></li>
	 					</c:if>
				</c:forEach>
				<c:if test="${pageMaker.nextBtn eq true }">
	            	<li><a href="${pageContext.request.contextPath}/posting/together?page=${pageMaker.endNum + 1 }">&gt;</a></li>
	            </c:if>
            </c:if>
			
          </ul>
        </div>
      </div>
    </div>
	</c:if>
  </section>
</body>
</html>