drop table AlarmReord

CREATE TABLE AlarmReord (
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# sql 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	content		VARCHAR(200)	NOT NULL,									# R: 읽음 / N: 읽지 않은 메시지 있음
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 마지막 채팅 날짜
	CONSTRAINT	Chat_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE
)

select * from AlarmReord;