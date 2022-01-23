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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef48a334aefa8d6e3f9c000a120f8532&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/js/posting/post_read.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/posting/post.css" />
<title>게시글읽기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
<input type="hidden" value="${post.id }" id="postId"/>
<section id="totalPostContainer">
        <h2 class="hidden">글읽기</h2>
        <div id="rwPostContainer">
            <div id="rwPostTitleContainer">
                <div class="rwPostTitleWrap">
               		<c:if test="${fn:contains(post.category,'N')}"><h3>공지사항</h3></c:if>
                    <c:if test="${fn:contains(post.category,'R')}"><h3>식당추천</h3></c:if>
                    <c:if test="${fn:contains(post.category,'E')}"><h3>밥친구</h3></c:if>
                </div>
            </div>
            <div id="rPostContentContainer">
                <div id="rPostHeaderWrap">
                	<!-- 밥친구 게시판일 경우 태그 보여주기 -->
                	<c:if test="${fn:contains(post.category,'E')}">
	                    <div class="rPostTagListWrap">
	                        <ul class="rPostTagStaticWrap">
	                            <li>
	                                <p>모집중</p>
	                                	 <div class="rPostTagTogetherIng"></div>
	                             		<input type="hidden" value="${post.recruitment }" id="postRecruitment">
	                            </li>
	                            <c:set var="addressList" value="${fn:split(post.restaurant.address,' ') }" />
	                			<li>${addressList[0]} ${addressList[1]} ${addressList[2]}</li>
	                            <fmt:formatDate var="mealTime" pattern="MM월dd일 HH:mm" value="${post.mealTime }"/>
	                            <li>${mealTime }</li>
	                        </ul>
	                        <ul class="rPostTagDynamicWrap">
	                        	
		                            <li>
		                                <p class="rPostCheckOn rPostCheck">모집중</p>
		                                <p class="rPostCheckOFF rPostCheck" >모집완료</p>
		                                <label class="switch">
		                                    <input type="checkbox" class="rPostCheckbox">
		                                    <span class="slider round"></span>
		                                </label>
		                                
		                            </li>
	                            
	                            	<li><a href="#">식사완료</a></li>
	                            
	                        </ul>
	                    </div>
                    </c:if>
                    <div class="rPostTitleWrap">
                        <p class="rPostTitle">${post.title }</p>
                    </div>
                    <div class="rPostProfileWrap">
                        <ul>
                            <li><img class="rPostProfileImg" src="${pageContext.request.contextPath}${post.member.profileImgPath }" alt="회원프로필아이콘"></li>
                            <li class="rPostProfileNickName">
                                ${post.member.nickName }
                            </li>
                            <li class="rPostProfileTempArea">
                            	<!-- 
                                <div class="rPostProfileTempAreaSub1">
                                    <div class="rPostProfileTempAreaSub2"></div>
                                </div>
                                 -->
                                 <progress value="${post.member.mannerTemperature }" max="100"></progress>
                            </li>
                            <li class="rPostProfileTempText">
                                ${post.member.mannerTemperature }˚
                            </li>
                            <fmt:formatDate var="regDate" pattern="yyyy.MM.dd" value="${post.regDate }"/>
                            <fmt:formatDate var="regTime" pattern="HH:mm" value="${post.regDate }"/>
                            <li class="rPostContentRegDate">
                                ${regDate } <span>${regTime }</span>
                            </li>
                            <li class="rPostContenHitCount">
                                조회<span> ${post.views }</span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="rPostContentWrap">
                	<c:if test="${fn:contains(post.category,'E') or fn:contains(post.category,'R')}">
	                    <div class="rPostContentMapWrap">
	                        <div id="rPostContentMap"></div>
	                        <input type="hidden" value="${post.restaurant.lat }" id="addressLat">
	                        <input type="hidden" value="${post.restaurant.lng }" id="addressLng">
	                        <div class="rPostContentMapDetails">
	                            <table>
	                                <tr>
	                                    <th>식사장소</th>
	                                    <td>${post.restaurant.address }</td>
	                                    
	                                </tr>
	                                <c:if test="${fn:contains(post.category,'E')}">
		                                <tr>
		                                    <th>식사시간</th>
		                                    <fmt:formatDate var="detailMealTime" pattern="yyyy년 MM월 dd일 HH:mm" value="${post.mealTime }"/>
		                                    <td>${detailMealTime }</td>
		                                </tr>
									</c:if>
	                            </table>
	                        </div>
	                    </div>
                    </c:if>
                    <div class="rPostContentBody">
                        ${post.content }
                    </div>
                </div>
                <div id="rPostAdditionalInfoWrap">

                    <ul class="rPostAdditioanInfoLeftSide">
                        <li>
                            <img class="rPostLikesImg" src="${pageContext.request.contextPath}/resources/img/posting/heart.png" alt="좋아요아이콘">
                            <p class="rPostLikesText">좋아요<span>${post.likes }</span></p>
                        </li>
                        <li>
                            <img class="rPostCommentCountImg" src="${pageContext.request.contextPath}/resources/img/posting/bubble-chat.png" alt="댓글아이콘">
                            <p class="rPostCommentCountText">댓글<span>${post.commentsNumber }</span></p>
                        </li>
                    </ul>
                    <c:if test="${member.id eq post.member.id }">
	                    <ul class="rPostAdditioanInfoRightSide">
	                        <li>수정</li>
	                        <li>삭제</li>
	                    </ul>
					</c:if>

                </div>
                <div id="rPostCommentWrap">
                    <!-- 코멘트 들어갈 영역 -->
                </div>
            </div>

        </div>

    </section>
</body>
</html>