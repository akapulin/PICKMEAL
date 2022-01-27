<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"  %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko" dir="ltr">

<head>
<meta charset="UTF-8">
<%@ include file="/WEB-INF/views/incl/link.jsp"%>
<!-- 포스팅 - 윤효심 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef48a334aefa8d6e3f9c000a120f8532&libraries=services"></script>
<script src="${pageContext.request.contextPath}/resources/js/posting/post_read.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/posting/post.css" />

<!-- 코멘트 - 김보령  -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/posting/together_eating_comment.css" />
<script src="${pageContext.request.contextPath}/resources/js/posting/together_eating_comment.js" defer></script>


<title>게시글읽기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/incl/header.jsp"/>

<input type="hidden" value="${post.id }" id="postId"/>
<input type="hidden" value="${post.category }" id="postCategory"/>
<section id="totalPostContainer">
        <h2 class="hidden">글읽기</h2>
        <div id="rwPostContainer">
            <div id="rwPostTitleContainer">
                <div class="rwPostTitleWrap">
                	  
               		<c:if test="${fn:contains(post.category,'N')}"><h3 data-category="${post.category }">공지사항</h3></c:if>
                    <c:if test="${fn:contains(post.category,'R')}"><h3 data-category="${post.category }">식당추천</h3></c:if>
                    <c:if test="${fn:contains(post.category,'E')}"><h3 data-category="${post.category }">밥친구</h3></c:if>
                	
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
	                            <c:set var="addressList" value="${fn:split(post.address,' ') }" />
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
	                            
	                            	<li><a href="#" id="rPostCompMealBtn">식사완료</a></li>
	                            
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
	                        <div class="rPostContentMapDetails">
	                            <table>
	                                <tr>
	                                <c:choose>
	                                	<c:when test="${fn:contains(post.category,'R')}">
	                                		<th>추천장소</th>
	                                	</c:when>
	                                	<c:otherwise>
	                                		<th>식사장소</th>
	                                	</c:otherwise>
	                                </c:choose>
	                                    <td id="rAddress">${post.address }</td>
	                                    
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
                        	<c:if test="${memberLikeState eq true }">
                        		<img class="rPostLikesImg rPostLikesImgSelected" src="${pageContext.request.contextPath}/resources/img/posting/heart_onclick.png" alt="좋아요아이콘">
                        	</c:if>
                        	<c:if test="${memberLikeState eq false }">
                        		<img class="rPostLikesImg" src="${pageContext.request.contextPath}/resources/img/posting/heart.png" alt="좋아요아이콘">
                        	</c:if>
                            
                            <p class="rPostLikesText">좋아요<span class="rPostLikesCnt">${post.likes }</span></p>
                        </li>
                        <li>
                            <img class="rPostCommentCountImg" src="${pageContext.request.contextPath}/resources/img/posting/bubble-chat.png" alt="댓글아이콘">
                            <p class="rPostCommentCountText">댓글<span class="rPostCommentCnt">${post.commentsNumber }</span></p>
                        </li>
                    </ul>
                     
                    <c:if test="${member.id eq post.member.id or fn:contains(member.memberType,'A')}"> 
	                   <ul class="rPostAdditioanInfoRightSide">
	                        <li id="rPostModifyBtn">수정</li>
	                        <li id="rPostRemoveBtn">삭제</li>
	                    </ul>
					</c:if> 

                </div>
                <div id="rPostCommentWrap">
                    
                </div>
            </div>

        </div>
    <form action="" method="get" name="goModifyBoard"></form>   
	<form action="${pageContext.request.contextPath}/posting/notice" method="get" id="goNoticeBoard"></form>
    <form action="${pageContext.request.contextPath}/posting/recommend" method="get" id="goRecommendBoard"></form>
    <form action="${pageContext.request.contextPath}/posting/together" method="get" id="goTogetherBoard"></form>
    </section>
    <!--
    
    
    		코멘트 - 김보령
    
     -->
    <section id="commentsContainer">
    <div id="commentsWrap">
		<h2 class="hidden">댓글</h2>
		<form name="viewCmtForm" id="viewCmtForm">
			<c:forEach var="c" items="${comments}">
				<div class="commentWrap" id="commentWrap${c.id}">
					<img alt="${c.member.nickName}님의 프로필 이미지" src="${pageContext.request.contextPath}${c.member.profileImgPath}">
					<div class="memberContent">
						<div class="memberInfo">
							<p class="nickName">${c.member.nickName}</p>
							<p class="mannerTemp">${c.member.mannerTemperature}&deg;</p>
							<time datetime="${c.regDate}"><fmt:formatDate value="${c.regDate}" pattern="yyyy-MM-dd hh:mm:ss" /></time>
						</div>
						<input type="hidden" id="cmtMemberId${c.id}" value="${c.member.id}"/>
						<input type="text" id="comment${c.id}" class="viewCmt viewCmtContent" name="cmtContent" value="${c.content}" disabled />
						<button type="button" id="modifyContent${c.id}" value="${c.id}" class="modifyContent" onclick="modifyComment(this)">수정하기</button>
					</div>
					<div class="moreWrap">
						<div class="popUpdate">
							<c:if test="${member.id eq c.member.id}">
								<input onclick="oneChkBox(this); displayUpdate(this)" class="choiceCmt" type="checkbox" name="id" value="${c.id}" id="choiceCmt${c.id}" /> 
								<label for="choiceCmt${c.id}">
									<span class="point1"></span>
									<span class="point2"></span>
									<span class="point3"></span>
								</label>
							</c:if>
						</div>
						<div class="updateWrap updateWrap${c.id}">
							<button type="button" name="update" class="update" value="modify${c.id}" onclick="modifyCommentOpen(this)">수정하기</button>
							<button type="button" name="update" class="update" value="delete${c.id}" onclick="deleteComment(this)">삭제하기</button>
						</div>
						<c:if test="${member.id eq post.member.id}">
							<c:if test="${not empty member}">
								<c:if test="${post.category eq 'E'.charAt(0) }">
									<c:if test="${post.member.id ne c.member.id}">
										<c:if test="${c.member.memberType ne 'D'.charAt(0)}">
											<button type="button" class="chat" onclick="goChat(this)" value="${c.member.id}">채팅하기</button>
										</c:if>
									</c:if>
								</c:if>
							</c:if>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</form>
		<input type="hidden" value="${viewPageNum}" id="viewPageNum" />
		<input type="hidden" value="${allPageNum}" id="allPageNum"/>
		<input type="hidden" value="${allCmtNum}" id="allCmtNum"/>
		<input type="hidden" value="${cpageNum}" id="cpageNum"/>
		<section id="cmtBtnWrap">
			<button type="button" id="firstPage">&lt;&lt;</button>
			<button type="button" id="leftPage">&lt;</button>
			<div id="cmtPageNumWrap">
				<div id="pageWrap">
					<c:forEach begin="1" end="${allPageNum}" varStatus="status">
						<button onclick="changePageNumBtnColor(this); moveCommentPage(this)" type="button" name="cpageNum" class="cpageNum cpageNum${status.count}" value="${status.count}">${status.count}</button>
					</c:forEach>
				</div>
			</div>
			<button type="button" id="rightPage">&gt;</button>
			<button type="button" id="lastPage">&gt;&gt;</button>
		</section>
		<form:form name="writeCmtForm" modelAttribute="commentCommand">
			<input type="hidden" name="memberId" value="${member.id}"/>
			<input type="hidden" name="postId" value="${post.id}"/>
			<input type="hidden" name="post_memberId" data-writer="${post.member.email}" value="${post.member.id}"/>
			<input type="hidden" name="category" value="${post.category}"/>
			<c:if test="${not empty member }">
				<section id="writeCommentWrap">
					<h3 class="hidden">댓글 작성란</h3>
					<p id="writerNickName">${member.nickName}</p>
					<textarea id="writeCmt" name="content" rows="4" cols="50" placeholder="댓글을 등록해주세요."></textarea>
					<input type="button" name="update" onclick="writeComment();" value="등록" id="writeOk" />
				</section>
			</c:if>
		</form:form>
		</div>
	</section>
</body>
</html>