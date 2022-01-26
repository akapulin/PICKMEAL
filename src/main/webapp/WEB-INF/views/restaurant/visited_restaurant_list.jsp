<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/restaurant/visited_restaurant_list.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/visited_restaurant/visited_restaurant_list.js" defer></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/incl/header.jsp"/>
	<jsp:include page="/WEB-INF/views/member/my_page.jsp"/>
    <main>
        <section>
            <h3 id="divName">${member.getNickName()}님 방문리스트</h3>
           	<div id="basket">
	            <div id="leftdiv">
	                <h3>내가 간 식당</h3>
	                <form action="" method="post">
	                	<c:forEach var="vrlist" items="${vrlist}" varStatus="status">
		                    <div class="vrdiv" id="vrdivs${vrlist.getId()}">
		                        <div class="vrmain">
		                            <input id="restaurantNameis${vrlist.getId()}" type="text" class="vrName" value="${vrlist.getRestaurant().getRName()}" disabled/>
		                            <input type="text" class="vrRegDate" value="${vrlist.getRegDate()}" disabled/>
		                            <input type="radio" id="mainlabel${vrlist.getId()}" class="vrRadio" name="vrmainradio"  value="${vrlist.getId()}">
		                            <label id="mainInlabel${vrlist.getId()}" for="mainlabel${vrlist.getId()}" class="mainInlabel"></label>
		                        </div>
		                        <div class="buttonWrap">
			                        <div class="favoritebuttonWrap favoritebutton${vrlist.getRestaurant().getId()}" id="jjimdiv${vrlist.getId()}" >
				                        <c:choose>
				                        	<c:when test="${flist.get(status.index) eq 'false'}">
					                        	<input type="hidden" value="${flist.get(status.index)}">
					                        	<div class="heart"></div>
					                            <input type="radio" id="favoritelabel${vrlist.getId()}" class="vrfavoriteradio" name="vrfavoriteradio" value="${vrlist.getId()}" data-restaurantid="${vrlist.getRestaurant().getId()}" onclick="jjimrestaurant(this)">
					                            <label id="favoriteInlabel${vrlist.getId()}" for="favoritelabel${vrlist.getId()}" class="favoriteInlabel"></label>
				                        	</c:when>
				                        </c:choose>
			                        </div>
			                        <div class="reviewbuttonWrap" id="reviewdiv${vrlist.getId()}">
			                        	<c:choose>
			                        		<c:when test="${vrlist.isReview() eq 'false'}">
			                        			<input type="hidden" id="restaurantrealid${vrlist.getId()}"value="${vrlist.getRestaurant().getId()}"/>
				                            	<input type="text" class="goreview" value="리뷰!" disabled/>
				                            	<input type="radio" id="reviewlabel${vrlist.getId()}" class="reviewBtn" name="vrreviewradio" value="${vrlist.getId()}" onclick="reviewClick(this)">
				                            	<label id="reviewInlabel${vrlist.getId()}" for="reviewlabel${vrlist.getId()}" class="reviewInlabel"></label>
			                            	</c:when>
			                            </c:choose>
			                        </div>
			                        <div class="removebuttonWrap" id="removediv${vrlist.getId()}">
				                        <input type="text" class="goremove" value="삭제.." disabled/>
				                        <input type="radio" id="removelabel${vrlist.getId()}" class="reviewBtn" name="removeradio" value="${vrlist.getId()}" onclick="removeClick(this)">
				                    	<label id="removeInlabel${vrlist.getId()}" for="removelabel${vrlist.getId()}" class="removeInlabel"></label>
			                        </div>
		                        </div>
		                    </div>
	                    </c:forEach>
	                </form>
	            </div>
	            <div id="rightdiv">
	            	<h3 >리뷰 하기</h3>
	                <form action="	reviewSeccess" method="post" name="reviewinform" onsubmit="return false">
	                    <div id="Reviewcheck">
	                    	<input type="hidden" id="visitedRestaurantId" name="visitedRestaurantId" value=""/>
	                    	<input type="hidden" id="submititem" name="restaurantId" value=""/>
	                        <input type="text" id="reviewRName" value="" disabled/>
	                        <div id="bathroomWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="bathroomBtn" class="reviewCheckbox" name="bathroom" value="0" />
	                            <label id="bathroomin" for="bathroomBtn" class="checklabel"></label>
	                            <p class="reviewMessage">3시간에 한 번씩 화장실 청소하는 듯</p>
	                        </div>
	                        <div id="kindWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="kindBtn" class="reviewCheckbox" name="kind" value="0" />
	                            <label id="kindin" for="kindBtn" class="checklabel"></label>
	                            <p class="reviewMessage">너무너무 친절해서 부담스러움</p>
	                        </div>
	                        <div id="specialdayWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="specialdayBtn" class="reviewCheckbox" name="specialDay" value="0" />
	                            <label id="specialdayin" for="specialdayBtn" class="checklabel"></label>
	                            <p class="reviewMessage">너와 나의 특별한 날에</p>
	                        </div>
	                        <div id="cleanWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="cleanBtn" class="reviewCheckbox" name="clean" value="0" />
	                            <label id="cleanin" for="cleanBtn" class="checklabel"></label>
	                            <p class="reviewMessage">걍 먼지 한톨 없음ㅇㅇ</p>
	                        </div>
	                        <div id="parkingWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="parkingBtn" class="reviewCheckbox" name="parking" value="0" />
	                            <label id="parkingin" for="parkingBtn" class="checklabel"></label>
	                            <p class="reviewMessage">초보운전 주차 쌉가능</p>
	                        </div>
	                        <div id="goodgroupWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="goodgroupBtn" class="reviewCheckbox" name="goodgroup" value="0"/>
	                            <label id="goodgroupin" for="goodgroupBtn" class="checklabel"></label>
	                            <p class="reviewMessage">친구들끼리 단체로 수다떨기 좋아요</p>
	                        </div>
	                        <div id="aloneWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="aloneBtn" class="reviewCheckbox" name="alone" value="0" "/>
	                            <label id="alonein" for="aloneBtn" class="checklabel"></label>
	                            <p class="reviewMessage">혼자가서 둘이 나올 수 있어요</p>
	                        </div>
	                        <div id="bigWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="bigBtn" class="reviewCheckbox" name="big" value="0" />
	                            <label id="bigin" for="bigBtn" class="checklabel"></label>
	                            <p class="reviewMessage">직원이 날 못찾을 정도의 크기</p>
	                        </div>
	                        <div id="interiorWrap" class= "checkboxWrap">
	                            <img src="/pickmeal/resources/img/restaurant/review/icon_heart.png" alt="" class="reviewImg">
	                            <input type="checkbox" id="interiorBtn" class="reviewCheckbox" name="interior" value="0"/>
	                            <label id="interiorin" for="interiorBtn" class="checklabel"></label>
	                            <p class="reviewMessage">사진찍기 조아욤</p>
	                        </div>
	                    </div>
	                    <div id="reviewButtonWrap">
	                    	<input type="hidden" value="" id="clickVal">
	                        <button type="submit" id="reviewButton">리뷰제출</button>
	                    </div>
	                    <div id="explainWrap">
	                    	<p class="p1">리뷰! 버튼을 클릭하면</p>
	                    	<p class="p2" >해당 식당의 리뷰화면이 나옵니다.</p>
	                    </div>
	                </form>
	            </div>
            </div>
        </section>
    </main>
    <footer></footer>
</body>
</html>