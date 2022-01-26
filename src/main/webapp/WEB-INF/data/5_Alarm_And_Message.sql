CREATE TABLE AlarmRecord (
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# sql 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	friendId	BIGINT,														# 상대방 아이디
	alarmType	CHAR(1)			NOT NULL,									# 알람 타입 (M:신뢰 온도, C:채팅, L:먹안먹)
	content		VARCHAR(200)	NOT NULL,									# 알람 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 알람이 들어간 날짜
	CONSTRAINT	AlarmReord_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	AlarmReord_friendId_FK	FOREIGN KEY(friendId)	REFERENCES Member(id) ON DELETE CASCADE
);

CREATE TABLE Message(
	id				BIGINT			PRIMARY KEY AUTO_INCREMENT,
	messageType		CHAR(1)			NOT NULL,
	content			VARCHAR(200)	
);

CREATE TABLE LastGameRecord (
	id				BIGINT			PRIMARY KEY AUTO_INCREMENT,
	restaurantId	BIGINT			NOT NULL,
	memberID		BIGINT			UNIQUE KEY,
	regDate			TIMESTAMP		DEFAULT CURRENT_TIMESTAMP	
);


DROP TABLE AlarmRecord;
DROP TABLE Message;
DROP TABLE LastGameRecord;

DELETE FROM AlarmRecord;
DELETE FROM Message;
DELETE FROM LastGameRecord;

SELECT * FROM AlarmRecord;
SELECT * FROM Message;
SELECT * FROM LastGameRecord;




INSERT INTO Message(messageType, content)
VALUES
('O',"안녀엉엉2"),
('O',"안녀엉엉3");

INSERT INTO Message(messageType, content)
VALUES
('O',"안녀엉엉"),
('F',"오늘은 당신에게 날씨의 행운이 깃들까?"),
('F',"길가다가 넘어 질 듯"),
('F',"새똥이 눈앞에 떨어질지도"),
('F',"오늘은 밥 맛 떨어지는 날"),
('F',"3일 안에 비즈니즈 행운 +100");


