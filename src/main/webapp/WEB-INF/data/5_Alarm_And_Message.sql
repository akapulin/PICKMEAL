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
('O',"인사박습니다 형 or 누님"),
('O',"재방문 감사합니다 형 or 누님"),
('O',"뽑기 준비물은 챙겼어? 너의 열정 두 스푼.."),
('O',"대선보다더 신중히 뽑아드리겠습니다."),
('O',"어떤 것을 먹어야 할지 고민고민 하지마~"),
('O',"행님덜 카드 뽑으세요!! 맛난거 뽑아줄겡!!"),
('O',"행님덜 사다리 타세요!! 맛난거 뽑아줄겡!!"),
('O',"뭐먹지? 할뗀 밥찡코 뽑기"),
('O',"좋은 사람과 좋은 시간 좋은 밥찡코와 함께");



INSERT INTO Message(messageType, content)
VALUES
('F',"이승렬선생님 사랑합니다<3"),
('F',"영어공부 할땐? 야! 너두 fico 할 수 있어."),
('F',"설마.. 오늘만 오겠어..?"),
('F',"오늘 먹고 허벅지 조지자."),
('F',"맛있게 먹으면 0칼로리."),
('F',"어쩔티비! 저쩔비스 포크스테이크!"),
('F',"솔직히 넌 먹을 때만 이뻐..!"),
('F',"널, 표현하면.. 뒤룩돼룩."),
('F',"피할 수 없으면 먹어라."),
('F',"어제보다 오늘 더 먹자"),
('F',"끓는건 청춘이 아니라 찌개다"),
('F',"다이어트 한다고 굶다보면.. 요요올껄?"),
('F',"좋은 일은 기다리는 사람에게 찾아온다."),
('F',"부먹 찍먹 나눌 시간에 하나라도 더 먹자."),
('F',"숨 쉬니까 배고프다.."),
('F',"굶주림은 날카로운 가시보다 더 예민하다."),
('F',"새로운 맛있는 요리는 나의 행복이다."),
('F',"아무리 맛있어도 먹기전, 그것을 모른다."),
('F',"먹는건 필수지만 현명하게 먹는건 예술이다."),
('F',"당신의 배가 마음을 지배한다."),
('F',"13,14,15..십삼..십사.. 십사? 식사하러가자."),
('F',"몇 칼로리인지 알아서 뭐할래? 밥이나 먹자."),
('F',"음식은 종류는 딱 2가지래여. 먹어본 것, 먹어볼 것"),
('F',"다들!! 묵고 살자고 하는 일 아임미꼬!?"),
('F',"낮저밤이 : 낮에는 저거먹고, 밤에는 이거먹자."),
('F',"진짜 맛있는건 배가 불러도 생각난다."),
('F',"묵으라! 오늘이 마지막인 것처럼!"),
('F',"다가올 미래를 위하지 말고, 당장부터 행복하자"),
('F',"메뉴 고르느라 고생했어, 이제 쉬어도 돼."),
('F',"밥찡이들 포기는 내가 살게, 사장님! 10포기 주세요."),
('F',"밥찡이들 포기는 내가 살게, 사장님! 5포기 주세요."),
('F',"뭐 할지 맞춰볼게 뽑기 할거지??"),
('F',"마법의 소라고동님은 밥찡코의 선생님이양."),
('F',"내 이름을 불러봐 넌 행복해지고.. 외쳐~! 밥찡코!!"),
('F',"오늘도 밥찡이는 밥찡코가 응원 할게요."),
('F',"찾아와줘서 고마워 행운받아라 얍!"),
('F',"오늘은 당신에게 날씨의 행운이 깃들까?"),
('F',"길가다가 넘어 질 듯"),
('F',"새똥이 눈앞에 떨어질지도"),
('F',"오늘은 밥 맛 떨어지는 날"),
('F',"3일 안에 비즈니즈 행운 +100");




