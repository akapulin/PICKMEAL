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
<!-- 우편번호서비스 -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js" ></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ef48a334aefa8d6e3f9c000a120f8532&libraries=services"></script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.form/4.2.2/jquery.form.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/resources/js/posting/post_write.js" defer></script>

 <!--<script src="https://malsup.github.com/jquery.form.js" type="text/javascript"></script>-->

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/posting/post.css" />
<title>게시글쓰기</title>
</head>
<body>
<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
<section id="totalPostContainer">
		
        <h2 class="hidden">글쓰기</h2>
        <div id="rwPostContainer">
            <div id="rwPostTitleContainer">
                <div class="rwPostTitleWrap">
               		<c:if test="${modifyState eq true }">
                   	    <c:if test="${fn:contains(postType,'N') }"><h3>공지사항 글수정</h3></c:if>
                    	<c:if test="${fn:contains(postType,'R') }"><h3>식당추천 글수정</h3></c:if>
                    	<c:if test="${fn:contains(postType,'E') }"><h3>밥친구 글수정</h3></c:if>
                   	</c:if>
                   	<c:if test="${modifyState eq false }">
                   		<c:if test="${fn:contains(postType,'N') }"><h3>공지사항 글쓰기</h3></c:if>
                    	<c:if test="${fn:contains(postType,'R') }"><h3>식당추천 글쓰기</h3></c:if>
                    	<c:if test="${fn:contains(postType,'E') }"><h3>밥친구 글쓰기</h3></c:if>
                   	</c:if>
                	
                </div>
            </div>
           <form action="${pageContext.request.contextPath}/posting/completeWritingPost" method="post" id="wPostForm">
            <input type="hidden" value="${modifyState }" name = "modifyState" id="modifyState">
            <c:if test="${not empty postId }">
            	<input type="hidden" value="${postId }" name = "postId" id="postId">
            </c:if>
            
            <input type="hidden" id="postType" value="${postType }" name="category"/>
            <div id="wPostContentContainer">
                <div class="wPostSubTitleWrap wPostLineCommon">
                    <p class="wPostLeftSideSubTitle">제목</p>
                    <div class="wPostSubTitleInputWrap wPostComInputArea">
                    	<c:if test="${modifyState eq true }">
                    	    <input type="text" name="title" class="wPostSubTitleConInput postInputTCom" value="${post.title }" placeholder="식당이름과 메뉴를 적어주시면 좋아요">
                    	</c:if>
                    	<c:if test="${modifyState eq false }">
                    		<input type="text" name="title" class="wPostSubTitleConInput postInputTCom" placeholder="식당이름과 메뉴를 적어주시면 좋아요">
                    	</c:if>
                    </div>
                </div>
                <div class="wPostContentWrap wPostLineCommon">
                    <p class="wPostLeftSideSubTitle">본문</p>
                    <div class="wPostContentInputWrap wPostComInputArea">
                    	<c:if test="${modifyState eq true }">
                    	    <div class="wPostContentInput postInputTCom" contentEditable="true" >
                    	    ${post.content }
                    	    </div>
                    	</c:if>
                    	<c:if test="${modifyState eq false }">
                    		<div class="wPostContentInput postInputTCom" contentEditable="true" ></div>
                    	</c:if>
                        <input type="hidden" name="content" id="wPostContentValue"/>
                    </div>
                </div>
                <c:if test="${fn:contains(postType,'R') or fn:contains(postType,'N')}">
	                <div class="wPostImgWrap wPostLineCommon">
	                    <p class="wPostLeftSideSubTitle">사진첨부</p>
	                    <div class="wPostImgInputWrap wPostComInputArea">
	                        <div class="wPostAttachImgBtnWrap">
								<label for="multiFileInput" class="wPostAttachBtn postBtnCom">첨부하기</label>
	                        	<input multiple="multiple"  type="file" name="postImgFiles" required="required" id="multiFileInput" >
	                            <!-- <a href="#" class="wPostAttachBtn postBtnCom">첨부하기</a> -->
	                            <p class="wPostAttachBtnRefer">(지원 포맷 : jpg, jpeg, png / 최대 20개까지 첨부 가능)</p>
	                        </div>
	                        <div class="wPostAttachedImgListWrap postInputTCom" >
	                            <ul class="wPostAttachedImgList">
	                            	<!--  임시 
	                                <li class="wPostSelectedImg">
	                                    <img src="posting/attached_picture.png" class="wPostAttachImgIcon" alt="이미지파일 아이콘">
	                                    <p class="wPostAttachImgTitle">sky.jpg<span>(20Mbyte)</span></p>
	                                    <img src="posting/close.png" class="wPostAttachImgDelIcon" alt="이미지파일 삭제아이콘">
	                                </li>
	                            	-->
	                            </ul>
	                        </div>
	                    </div>
	                </div>
                </c:if><!-- 보류
                <div class="wPostCateWrap wPostLineCommon">
                    <p class="wPostLeftSideSubTitle">카테고리</p>
                    <div class="wPostCateInputWrap wPostComInputArea">
                        <!-- select 박스 만들기--><!--
                         
                        <div class="wPostCateSelectBoxWrap">
                            <!-- select 박스 만들 예정
                            <span>식당</span>
                            <ul>
                                <li>식당</li>
                                <li>카페</li>
                                <li>술집</li>
                            </ul>--><!--
                            <select class="wPostCateSelectBox postInputTCom" name="category">
                                <option value="R">식당</option>
                                <option value="C">카페</option>
                                <option value="B">술집</option>
                            </select>
                        </div>
                        
                    </div>
                </div>-->
                <c:if test="${fn:contains(postType,'E')}">
	                <div class="wPostDateTimeWrap wPostLineCommon">
	                    <p class="wPostLeftSideSubTitle">날짜/시간</p>
	                    <div class="wPostDateTimeInputWrap wPostComInputArea">
	                        <!-- datepicker-->
	                        <c:if test="${modifyState eq true }">
	                        	<fmt:formatDate var="mealDate" pattern="yyyy-MM-dd" value="${post.mealTime }"/>
	                        	<fmt:formatDate var="mealTime" pattern="HH:mm:ss" value="${post.mealTime }"/>
	                    	   	<input type="date" name="date" class="wPostDateInput postInputTCom" value="${mealDate }">
	                        	<input type="time" name="time" class="wPostTimeInput postInputTCom" value="${mealTime }">
	                    	</c:if>
	                    	<c:if test="${modifyState eq false }">
	                    		<input type="date" name="date" class="wPostDateInput postInputTCom" >
	                        	<input type="time" name="time" class="wPostTimeInput postInputTCom" >
	                    	</c:if>
	                        
	                    </div>
	                </div>
	            </c:if>
	            <c:if test="${fn:contains(postType,'R') or fn:contains(postType,'E')}">
	                <div class="wPostMapWrap wPostLineCommon">
	                    <p class="wPostLeftSideSubTitle">장소</p>
	                    <div class="wPostMapInputWrap wPostComInputArea">
	                        <div class="wPostMapBtnWrap">
	                            <a href="#" class="wPostMapSetAddressBtn postBtnCom">주소 입력하기</a>
	                            <a href="#" class="wPostMapCurrentPlaceBtn postBtnCom">현재 위치에서 찾기</a>
	                        </div>
	                         <c:if test="${modifyState eq true }">
	                        	<input type="text" id="wPostDetailAddress" name="address" value="${post.address }" data-isvalue="true"class="wPostMapDetailAddressInput postInputTCom" readonly placeholder="상세주소가 입력됩니다.">
	                    	</c:if>
	                    	<c:if test="${modifyState eq false }">
	                    		<input type="text" id="wPostDetailAddress" name="address" class="wPostMapDetailAddressInput postInputTCom" readonly placeholder="상세주소가 입력됩니다.">
	                    	</c:if>
	                        

	                        <div class="wPostMapArea postInputTCom">
	                            <div id="wPostMap"></div>
	                        </div>
	                    </div>
	                </div>
	            </c:if>
                <div class="wPostSubmitBtnWrap wPostLineCommon">
                    <p class="wPostLeftSideSubTitle"></p>
                    <div class="wPostSubmitBtnInputWrap wPostComInputArea">
                        <a href="#" class="wPostSubmitBtn postBtnCom">작성완료</a>
                    </div>
                </div>

            </div>
			</form>
        </div>
	<form action="${pageContext.request.contextPath}/saveImgToNoticeBoard" method="post" enctype="multipart/form-data" id="noticeBoard">
		<!-- 멀티파일 form으로 넘겼을 때 test -->
		<!-- 
		<label for="multifileInput">하이</label>
		  <input multiple="multiple"  type="file" name="picFile" required="required" id="multifileInput">
		  --> 
	</form>
	<form action="${pageContext.request.contextPath}/saveImgToReviewBoard" method="post" enctype="multipart/form-data" id="reviewBoard">
	</form>

	
    </section>
</body>
</html>