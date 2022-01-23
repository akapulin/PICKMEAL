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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/posting/post.css" />
<title>게시글읽기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
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
	                                	 <div class="rPostTagTogetherIng rPostTagTogetherComp"></div>
	                             		<input type="hidden" value="${post.recruitment }">
	                            </li>
	                            <li>${post.restaurant.address }</li>
	                            <fmt:formatDate var="mealTime" pattern="MM월dd일 HH:mm" value="${post.mealTime }"/>
	                            <li>${mealTime }</li>
	                        </ul>
	                        <ul class="rPostTagDynamicWrap">
	                        	
		                            <li>
		                                <p class="rPostCheckOn rPostCheck">모집중</p>
		                                <p class="rPostCheckOFF rPostCheck">모집완료</p>
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
                            <li><img class="rPostProfileImg" src="${post.member.profileImgPath }" alt="회원프로필아이콘"></li>
                            <li class="rPostProfileNickName">
                                ${post.member.nickName }
                            </li>
                            <li class="rPostProfileTempArea">
                                <div class="rPostProfileTempAreaSub1">
                                    <div class="rPostProfileTempAreaSub2"></div>
                                </div>
                                
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
                                조회<span>${post.views }</span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div id="rPostContentWrap">
                    <div class="rPostContentMapWrap">
                        <div id="rPostContentMap"></div>
                        <div class="rPostContentMapDetails">
                            <table>
                                <tr>
                                    <th>카테고리</th>
                                    <td>식당</td>
                                </tr>
                                <tr>
                                    <th>식사장소</th>
                                    <td>대구 광역시 중구 중앙로77 101호</td>
                                </tr>
                                <tr>
                                    <th>식사시간</th>
                                    <td>2022년 1월 14일 오후 13:00</td>
                                </tr>

                            </table>
                        </div>
                    </div>
                    <div class="rPostContentBody">
                        <!-- 적은거 그대로 보여주기 -->
                        <p>쟁반짜장이 너무 먹고싶은데
                            화무비도는 쟁반짜장이 2인분 이상부터 가능하다네용~
                            조금있다 점심시간에 같이 드실 분 계실까요?? 1분 구해봐욤
                            후식으로는 나랑 홀케이크 1판 먹어야함♥ </p>
                    </div>
                </div>
                <div id="rPostAdditionalInfoWrap">

                    <ul class="rPostAdditioanInfoLeftSide">
                        <li>
                            <img class="rPostLikesImg" src="../heart.png" alt="좋아요아이콘">
                            <p class="rPostLikesText">좋아요<span>101</span></p>
                        </li>
                        <li>
                            <img class="rPostCommentCountImg" src="../bubble-chat.png" alt="댓글아이콘">
                            <p class="rPostCommentCountText">댓글<span>2</span></p>
                        </li>
                    </ul>
                    <ul class="rPostAdditioanInfoRightSide">
                        <li>수정</li>
                        <li>삭제</li>
                    </ul>


                </div>
                <div id="rPostCommentWrap">
                    <!-- 코멘트 들어갈 영역 -->
                </div>
            </div>

        </div>

    </section>
</body>
</html>