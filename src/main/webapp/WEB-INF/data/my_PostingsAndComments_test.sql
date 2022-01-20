CREATE TABLE RecommendRestaurantPosting (									# 식당 추천 게시판
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	memberId		BIGINT			NOT NULL,								# 사용자 아이디
	restaurantId	BIGINT			NOT NULL,								# 식당 아이디
	title			VARCHAR(100)	NOT NULL,								# 제목
	content			MEDIUMTEXT		NOT NULL,								# 내용
	likes			INT				NOT NULL	DEFAULT 0,					# 좋아요 수
	views			INT				NOT NULL	DEFAULT 0,					# 조회 수
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,	# 글 등록 날짜
	CONSTRAINT		RecommendRestaurantPosting_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT		RecommendRestaurantPosting_restaurantId_FK	FOREIGN KEY(restaurantId)	REFERENCES Restaurant(id) ON DELETE CASCADE
);

CREATE TABLE RecommendRestaurantComment (									# 식당 추천 댓글
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# SQL 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	postId		BIGINT			NOT NULL,									# 식당 추천 게시글 아이디
	content		VARCHAR(1000)	NOT NULL,									# 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 등록 날짜
	CONSTRAINT	RecommendRestaurantComment_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	RecommendRestaurantComment_postId_FK	FOREIGN KEY(postId)	REFERENCES RecommendRestaurantPosting(id) ON DELETE CASCADE
);

CREATE TABLE TogetherEatingPosting (										# 밥친구 게시판
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	memberId		BIGINT			NOT NULL,								# 사용자 아이디
	restaurantId	BIGINT			NOT NULL,								# 식당 아이디
	title			VARCHAR(100)	NOT NULL,								# 제목
	content			MEDIUMTEXT		NOT NULL,								# 내용
	likes			INT				NOT NULL	DEFAULT 0,					# 좋아요 수
	views			INT				NOT NULL	DEFAULT 0,					# 조회 수
	mealTime		TIMESTAMP		NOT NULL,								# 식사 시간
	recruitment		BOOLEAN			NOT NULL	DEFAULT	FALSE,				# 모집 완료
	mealChk			BOOLEAN			NOT NULL	DEFAULT	FALSE,				# 식사 완료
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,	# 게시글 등록 날짜
	CONSTRAINT		TogetherEatingPosting_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT		TogetherEatingPosting_restaurantId_FK	FOREIGN KEY(restaurantId)	REFERENCES Restaurant(id) ON DELETE CASCADE
)

CREATE TABLE TogetherEatingComment (										# 밥친구 댓글
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# SQL 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	postId		BIGINT			NOT NULL,									# 밥친구 게시글 아이디
	content		VARCHAR(1000)	NOT NULL,									# 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 등록 날짜
	CONSTRAINT	TogetherEatingComment_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	TogetherEatingComment_postId_FK	FOREIGN KEY(postId)	REFERENCES TogetherEatingPosting(id) ON DELETE CASCADE
)

SELECT * FROM RecommendRestaurantPosting;
SELECT * FROM RecommendRestaurantComment;

SELECT * FROM TogetherEatingPosting;
SELECT * FROM TogetherEatingComment;

INSERT INTO RecommendRestaurantPosting(memberId,restaurantId,title,content)
VALUES(1,1,"도리집이 가성비 짱","이 집이 문을 잘 열지는 않기는 한데 가성비가 좋아서 미워할 수 없네욤");

INSERT INTO TogetherEatingPosting(memberId,restaurantId,title,content,mealTime)
VALUES(1,1,"돈까스 튀기는 오빠 세트 같이 드실 분!","오늘 돈까스 세트에 쫄면이 땡기는데 저는 1인이라서 혼자 먹을 수가 없네욤. 같이 드실 분 댓글용"
, "20220115120000");

INSERT INTO RecommendRestaurantComment(memberId,postId,content)
VALUES(1,2,"도리집이 가성비 짱");

INSERT INTO TogetherEatingComment(memberId,postId,content)
VALUES(1,1,"돈튀오 맛이가 좋다");

INSERT INTO TogetherEatingComment(memberId,postId,content)
VALUES(1,1,"돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다 돈튀오 맛이가 좋다");
