CREATE TABLE Member (															# 사용자
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# SQL 아이디
	memberType		CHAR(1)			NOT NULL,									# 사용자 타입 (M : 일반 사용자 / A : 관리자)
	email			VARCHAR(30)		NOT NULL	UNIQUE,							# 이메일(아이디 형식)	
	passwd			VARCHAR(60)		NOT NULL,									# 비밀번호
	nickName		VARCHAR(30)		NOT NULL	UNIQUE,							# 닉네임
	birth			CHAR(8)			NOT NULL,									# 생년월일
	gender			CHAR(1)			NOT NULL,									# 성별
	profileImgPath	VARCHAR(100)	NOT NULL,									# 프로필 이미지 경로
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP		# 회원가입 날짜
);

CREATE TABLE FoodPowerPoint (													# 식력 포인트
	id			BIGINT		PRIMARY KEY	AUTO_INCREMENT,							# SQL 아이디
	memberId	BIGINT		NOT NULL,											# 사용자 아이디
	point		INT			NOT NULL,											# 적립 포인트
	detail		INT			NOT NULL,											# 내용
	regDate		TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,				# 등록 날짜
	CONSTRAINT	FoodPowerPoint_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
);

CREATE TABLE MannerTemperature (												# 신뢰 온도
	id			BIGINT		PRIMARY KEY	AUTO_INCREMENT,							# SQL 아이디
	memberId	BIGINT		NOT NULL,											# 사용자 아이디
	temperature	DOUBLE		NOT NULL,											# 온도
	CONSTRAINT	MannerTemperature_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
);

CREATE TABLE Attendance (														# 출석
	id			BIGINT		PRIMARY KEY	AUTO_INCREMENT,							# SQL 아이디
	memberId	BIGINT		NOT NULL,											# 사용자 아이디
	attendance	INT			NOT NULL	DEFAULT 1,								# 연속 출석 수
	regDate		TIMESTAMP	NOT NULL	DEFAULT CURRENT_TIMESTAMP,				# 마지막 출석 날짜
	CONSTRAINT	Attendance_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
);

CREATE TABLE CouponCategory (
	id			BIGINT			PRIMARY KEY AUTO_INCREMENT,
	couponName	VARCHAR(20)		NOT NULL,
	couponType	CHAR(1)			NOT NULL
);
INSERT INTO CouponCategory(couponName,couponType,limitPrice) VALUES("2,000원",'A',"10,000");
INSERT INTO CouponCategory(couponName,couponType,limitPrice) VALUES("3,000원",'B',"20,000");
INSERT INTO CouponCategory(couponName,couponType,limitPrice) VALUES("5,000원",'C',"25,000");

CREATE TABLE Coupon(
	id				BIGINT			PRIMARY KEY AUTO_INCREMENT,
	memberId		BIGINT			NOT NULL,
	couponId		BIGINT			NOT NULL,
	restaurantId	BIGINT			NOT NULL,
	couponNumber	VARCHAR(13)		NOT NULL,
	used			BOOLEAN			DEFAULT FALSE,
	regDate			TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (memberId) REFERENCES Member (id) ON DELETE CASCADE,
	FOREIGN KEY (couponId) REFERENCES CouponCategory (id) ON DELETE CASCADE,
	FOREIGN KEY (restaurantId) REFERENCES Restaurant (id) ON DELETE CASCADE
);

#개인채팅
CREATE TABLE Chat(
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# sql 아이디
	writerId	BIGINT			NOT NULL,									# 게시글 작성자 아이디
	commenterId	BIGINT			NOT NULL,									# 댓글 작성자 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	readType	CHAR(1)			NOT NULL,									# R: 읽음 / N: 읽지 않은 메시지 있음
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 마지막 채팅 날짜
	CONSTRAINT	Chat_writerId_FK	FOREIGN KEY(writerId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	Chat_commenterId_FK	FOREIGN KEY(commenterId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	Chat_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
);

DROP TABLE Coupon;
DROP TABLE CouponCategory;
DROP TABLE Attendance;
DROP TABLE MannerTemperature;
DROP TABLE FoodPowerPoint;
DROP TABLE Member;

DELETE FROM Coupon;
DELETE FROM CouponCategory;
DELETE FROM Attendance;
DELETE FROM MannerTemperature;
DELETE FROM FoodPowerPoint;
DELETE FROM Member;
delete from Chat;

SELECT * FROM Coupon;
SELECT * FROM CouponCategory;
SELECT * FROM Attendance;
SELECT * FROM MannerTemperature;
SELECT * FROM FoodPowerPoint;
SELECT * FROM Member;
SELECT * from Chat;

