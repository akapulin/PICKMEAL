drop table AlarmReord

CREATE TABLE AlarmReord (
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# sql 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	friendId	BIGINT,														# 상대방 아이디
	alarmType	CHAR(1)			NOT NULL,									# 알람 타입
	content		VARCHAR(200)	NOT NULL,									# 알람 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 알람이 들어간 날짜
	CONSTRAINT	AlarmReord_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
)

select * from AlarmReord;