CREATE TABLE NoticePosting (									# 식당 추천 게시판
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,				# SQL 아이디
	memberId		BIGINT			NOT NULL,								# 사용자 아이디							# 식당 아이디
	title			VARCHAR(100)	NOT NULL,								# 제목
	content			MEDIUMTEXT		NOT NULL,								# 내용				# 좋아요 수
	views			INT				NOT NULL	DEFAULT 0,					# 조회 수
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,	# 글 등록 날짜
	CONSTRAINT		NoticePosting_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
	
);
DROP TABLE NoticePosting;
SELECT * FROM NoticePosting;

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
	
)

DROP TABLE TogetherEatingPosting;
SELECT * FROM TogetherEatingPosting;


INSERT INTO NoticePosting(memberId, title, content, views)
VALUES (1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1),
(1,"제목","본문",1);




INSERT INTO RecommendRestaurantPosting(memberId, address, title, content, likes, views)
VALUES (1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20),
(1,"제주특별자치도 제주시 첨단로 242","제목2","본문2",10,20);

SELECT * FROM RecommendRestaurantPosting;



INSERT INTO TogetherEatingPosting(memberId, address, title, content, likes, views, mealTime, recruitment, mealChk )
VALUES (1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',false,false),
(1,"제주특별자치도 제주시 첨단로 242","제목5","본문3",11,22,'2022-01-30 12:02:11',false,true),
(1,"제주특별자치도 제주시 첨단로 242","제목5","본문3",11,22,'2022-01-25 18:55:11',true,false),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',true,false),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',true,false),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',false,true),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',false,true),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',false,false),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 00:02:11',false,false),
(1,"제주특별자치도 제주시 첨단로 242","제목3","본문3",11,22,'2022-01-21 13:02:11',false,false);


SELECT * FROM TogetherEatingPosting;


