#식당추천 - 게시글
CREATE TABLE RecommendRestaurantPosting (									# 식당 추천 게시판
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	memberId		BIGINT			NOT NULL,								# 사용자 아이디
	address			VARCHAR(100)	NOT NULL,								# 주소
	title			VARCHAR(100)	NOT NULL,								# 제목
	content			MEDIUMTEXT		NOT NULL,								# 내용
	likes			INT				NOT NULL	DEFAULT 0,					# 좋아요 수
	views			INT				NOT NULL	DEFAULT 0,					# 조회 수
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,	# 글 등록 날짜
	CONSTRAINT		RecommendRestaurantPosting_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
);

#식당추천 - 댓글
CREATE TABLE RecommendRestaurantComment (									# 식당 추천 댓글
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# SQL 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	postId		BIGINT			NOT NULL,									# 식당 추천 게시글 아이디
	content		VARCHAR(1000)	NOT NULL,									# 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 등록 날짜
	CONSTRAINT	RecommendRestaurantComment_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	RecommendRestaurantComment_postId_FK	FOREIGN KEY(postId)	REFERENCES RecommendRestaurantPosting(id) ON DELETE CASCADE
);

#밥친구 - 게시글
CREATE TABLE TogetherEatingPosting (										# 밥친구 게시판
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	memberId		BIGINT			NOT NULL,								# 사용자 아이디
	address			VARCHAR(100)	NOT NULL,								# 주소
	title			VARCHAR(100)	NOT NULL,								# 제목
	content			MEDIUMTEXT		NOT NULL,								# 내용
	likes			INT				NOT NULL	DEFAULT 0,					# 좋아요 수
	views			INT				NOT NULL	DEFAULT 0,					# 조회 수
	mealTime		TIMESTAMP		NOT NULL,								# 식사 시간
	recruitment		BOOLEAN			NOT NULL	DEFAULT	FALSE,				# 모집 완료
	mealChk			BOOLEAN			NOT NULL	DEFAULT	FALSE,				# 식사 완료
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,	# 게시글 등록 날짜
	CONSTRAINT		TogetherEatingPosting_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
);

#밥친구 - 댓글
CREATE TABLE TogetherEatingComment (										# 밥친구 댓글
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# SQL 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	postId		BIGINT			NOT NULL,									# 밥친구 게시글 아이디
	content		VARCHAR(1000)	NOT NULL,									# 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 등록 날짜
	CONSTRAINT	TogetherEatingComment_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	TogetherEatingComment_postId_FK	FOREIGN KEY(postId)	REFERENCES TogetherEatingPosting(id) ON DELETE CASCADE
);

#공지사항
CREATE TABLE NoticePosting (												# 식당 추천 게시판
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	memberId		BIGINT			NOT NULL,								# 사용자 아이디							# 식당 아이디
	title			VARCHAR(100)	NOT NULL,								# 제목
	content			MEDIUMTEXT		NOT NULL,								# 내용				# 좋아요 수
	views			INT				NOT NULL	DEFAULT 0,					# 조회 수
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,	# 글 등록 날짜
	CONSTRAINT		NoticePosting_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
	
);


#식당추천 게시글 좋아요 
CREATE TABLE RecommendRestaurantPostingLikes(
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	postingId		BIGINT			NOT NULL,								# 게시글 아이디
	memberId		BIGINT			NOT NULL,								# 좋아요 누른 사용자 아이디
	CONSTRAINT		RecommendRestaurantPostingLikes_postingId_FK	FOREIGN KEY(postingId)	REFERENCES RecommendRestaurantPosting(id) ON DELETE CASCADE,
	CONSTRAINT		RecommendRestaurantPostingLikes_memberId_FK		FOREIGN KEY(memberId)	REFERENCES Member(id)
);

#밥친구 게시글 좋아요 
CREATE TABLE TogetherEatingPostingLikes(
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	postingId		BIGINT			NOT NULL,								# 게시글 아이디
	memberId		BIGINT			NOT NULL,								# 좋아요 누른 사용자 아이디
	CONSTRAINT		TogetherEatingPostingLikes_postingId_FK	FOREIGN KEY(postingId)	REFERENCES TogetherEatingPosting(id) ON DELETE CASCADE,
	CONSTRAINT		TogetherEatingPostingLikes_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id)
);







DROP TABLE RecommendRestaurantPostingLikes;
DROP TABLE TogetherEatingPostingLikes;
DROP TABLE RecommendRestaurantComment;
DROP TABLE TogetherEatingComment;
DROP TABLE RecommendRestaurantPosting;
DROP TABLE TogetherEatingPosting;
DROP TABLE NoticePosting;


DELETE FROM RecommendRestaurantPostingLikes;
DELETE FROM TogetherEatingPostingLikes;
DELETE FROM RecommendRestaurantComment;
DELETE FROM TogetherEatingComment;
DELETE FROM RecommendRestaurantPosting;
DELETE FROM TogetherEatingPosting;
DELETE FROM NoticePosting;


SELECT * FROM RecommendRestaurantPostingLikes;
SELECT * FROM TogetherEatingPostingLikes;
SELECT * FROM RecommendRestaurantComment;
SELECT * FROM TogetherEatingComment;
SELECT * FROM RecommendRestaurantPosting;
SELECT * FROM TogetherEatingPosting;
SELECT * FROM NoticePosting;


INSERT INTO RecommendRestaurantPosting(memberId,address,title,content) VALUES(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"), (1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥"),(1,"중구 덕산동", "뻠삥뻠삥","뻠삥");