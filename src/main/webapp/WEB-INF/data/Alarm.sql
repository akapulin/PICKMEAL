drop table AlarmRecord

CREATE TABLE AlarmRecord (
	id			BIGINT			PRIMARY KEY	AUTO_INCREMENT,					# sql 아이디
	memberId	BIGINT			NOT NULL,									# 사용자 아이디
	friendId	BIGINT,														# 상대방 아이디
	alarmType	CHAR(1)			NOT NULL,									# 알람 타입 (M:신뢰 온도, C:채팅, L:먹안먹)
	content		VARCHAR(200)	NOT NULL,									# 알람 내용
	regDate		TIMESTAMP		NOT NULL	DEFAULT CURRENT_TIMESTAMP,		# 알람이 들어간 날짜
	CONSTRAINT	AlarmReord_memberId_FK	FOREIGN KEY(memberId)	REFERENCES Member(id) ON DELETE CASCADE,
	CONSTRAINT	AlarmReord_friendId_FK	FOREIGN KEY(friendId)	REFERENCES Member(id) ON DELETE CASCADE
)

select * from AlarmRecord;

insert into AlarmRecord(memberId, friendId, alarmType, content) values (1, 2, 'M', '향기언니')
insert into AlarmRecord(memberId, friendId, alarmType, content) values (1, 2, 'C', '향기언니')
insert into AlarmRecord(memberId, alarmType, content) values (1, 'L', '화무비도')
