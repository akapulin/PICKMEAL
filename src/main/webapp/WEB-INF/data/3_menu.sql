CREATE TABLE Menu (
	id				BIGINT			PRIMARY KEY AUTO_INCREMENT,					#SQL 아이디
	menuName		VARCHAR(20),												#메뉴의 이름
	weather			INT,														#메뉴의 날씨값
	temperature		INT,														#메뉴의 온도값
	imgPath			VARCHAR(100),												#메뉴의 사진
	soupy			INT,														#메뉴의 국있/없
	hot_ice			INT,														#메뉴의 뜨거움/차가움
	carbohydrate	INT,														#메뉴의 밥/빵/면/떡
	mainFood		INT, 														#메뉴의 고기/해물/채소
	spicy			INT															#메뉴의 맵기/안맵기
);


DROP TABLE Menu;

DELETE FROM Menu;

SELECT * FROM Menu;

#한식

INSERT INTO Menu(menuName,weather,temperature,imgPath,soupy,hot_ice,carbohydrate,mainFood,spicy)  
 VALUES ("오마카세",1,0,"/pickmeal/resources/img/menu/오마카세.jpg",2,2,4,3,2),
("찜닭",1,0,"/pickmeal/resources/img/menu/찜닭.jpg",0,0,0,0,0),
("돼지국밥",2,1,"/pickmeal/resources/img/menu/돼지국밥.jpg",0,0,0,0,1),
("제육볶음",1,0,"/pickmeal/resources/img/menu/제육볶음.jpg",1,0,0,0,1),
("김치찜",2,0,"/pickmeal/resources/img/menu/김치찜.jpg",0,0,0,0,1),
("삼겹살",3,0,"/pickmeal/resources/img/menu/삼겹살.jpg",1,0,0,0,1),
("매운갈비찜",1,0,"/pickmeal/resources/img/menu/.매운갈비찜jpg",1,0,0,0,0),
("갈비찜",1,0,"/pickmeal/resources/img/menu/.갈비찜jpg",1,0,0,0,1),
("냉면",1,2,"/pickmeal/resources/img/menu/냉면.jpg",0,1,2,2,1),
("비빔냉면",1,2,"/pickmeal/resources/img/menu/비빔냉면.jpg",1,1,2,2,1),
("된장찌개",2,1,"/pickmeal/resources/img/menu/된장찌개.jpg",0,0,0,2,1),
("김치찌개",2,1,"/pickmeal/resources/img/menu/김치찌개.jpg",0,0,0,2,0),
("부대찌개",2,1,"/pickmeal/resources/img/menu/부대찌개.jpg",0,0,0,0,0),
("해물찜",1,1,"/pickmeal/resources/img/menu/해물찜.jpg",1,0,0,1,1),
("보쌈정식",1,0,"/pickmeal/resources/img/menu/보쌈정식.jpg",1,0,0,0,1),
("육회비빔밥",1,0,"/pickmeal/resources/img/menu/육회비빔밥.jpg",1,1,0,0,1),
("죽",1,1,"/pickmeal/resources/img/menu/죽.jpg",0,0,0,2,1),
("굴국밥",1,1,"/pickmeal/resources/img/menu/굴국밥.jpg",0,0,0,1,1),
("칼국수",3,1,"/pickmeal/resources/img/menu/칼국수.jpg",0,0,2,2,1),
("수제비",3,1,"/pickmeal/resources/img/menu/수제비.jpg",0,0,2,2,1),
("잔치국수",3,1,"/pickmeal/resources/img/menu/잔치국수.jpg",0,0,2,2,1),
("곰탕",4,1,"/pickmeal/resources/img/menu/곰탕.jpg",0,0,0,0,1),
("비빔밥",1,0,"/pickmeal/resources/img/menu/비빔밥.jpg",1,1,0,2,1),
("생선구이",1,0,"/pickmeal/resources/img/menu/생선구이.jpg",1,0,0,1,1),
("감자탕",4,1,"/pickmeal/resources/img/menu/감자탕.jpg",0,0,0,0,1);


#양식
INSERT INTO Menu(menuName,weather,temperature,imgPath,soupy,hot_ice,carbohydrate,mainFood,spicy)  
 VALUES ("크림파스타",1,0,"/pickmeal/resources/img/menu/크림파스타.jpg",1,0,2,0,1),
("로제파스타",1,0,"/pickmeal/resources/img/menu/로제파스타.jpg",1,0,2,0,1),
("토마토파스타",1,0,"/pickmeal/resources/img/menu/토마토파스타.jpg",1,0,2,0,1),
("오일파스타",1,0,"/pickmeal/resources/img/menu/오일파스타.jpg",1,0,2,0,1),
("햄버거",1,0,"/pickmeal/resources/img/menu/햄버거.jpg",1,1,1,0,1),
("샌드위치",1,0,"/pickmeal/resources/img/menu/샌드위치.jpg",1,1,1,0,1),
("피자",1,0,"/pickmeal/resources/img/menu/피자.jpg",1,1,1,0,1),
("스테이크",1,0,"/pickmeal/resources/img/menu/스테이크.jpg",1,0,1,0,1),
("리조또",1,0,"/pickmeal/resources/img/menu/리조또.jpg",1,0,0,0,1),
("필라프",1,0,"/pickmeal/resources/img/menu/필라프.jpg",1,0,0,0,1),
("샐러드",1,0,"/pickmeal/resources/img/menu/샐러드.jpg",1,1,1,2,1),
("감바스",1,0,"/pickmeal/resources/img/menu/감바스.jpg",1,0,1,1,1),
("치킨",1,0,"/pickmeal/resources/img/menu/치킨.jpg",1,0,0,0,1),
("핫도그",1,0,"/pickmeal/resources/img/menu/핫도그.jpg",1,0,1,0,1),
("프렌치토스트",1,0,"/pickmeal/resources/img/menu/프렌치토스트.jpg",1,0,1,0,1),
("피쉬앤칩스",1,0,"/pickmeal/resources/img/menu/피쉬앤칩스.jpg",1,0,1,1,1),
("함박스테이크",1,0,"/pickmeal/resources/img/menu/함박스테이크.jpg",1,0,1,0,1),
("타코",1,0,"/pickmeal/resources/img/menu/타코.jpg",1,1,1,0,1),
("맥앤치즈",1,0,"/pickmeal/resources/img/menu/맥앤치즈.jpg",1,0,1,0,1),
("바베큐",1,0,"/pickmeal/resources/img/menu/바베큐.jpg",1,0,1,0,1),
("잠발라야",1,0,"/pickmeal/resources/img/menu/잠발라야.jpg",1,0,0,0,1),
("브리또",1,0,"/pickmeal/resources/img/menu/브리또.jpg",1,1,1,0,1);

#중식
INSERT INTO Menu(menuName,weather,temperature,imgPath,soupy,hot_ice,carbohydrate,mainFood,spicy)  
 VALUES ("탕수육",1,0,"/pickmeal/resources/img/menu/탕수육.jpg",1,0,3,0,1),
("짜장면",1,0,"/pickmeal/resources/img/menu/짜장면.jpg",1,0,3,2,1),
("짬뽕",2,1,"/pickmeal/resources/img/menu/짬뽕.jpg",0,0,3,0,0),
("볶음밥",1,0,"/pickmeal/resources/img/menu/볶음밥.jpg",1,0,0,0,1),
("마라탕",1,0,"/pickmeal/resources/img/menu/마라탕.jpg",0,0,3,0,0),
("동파육",3,0,"/pickmeal/resources/img/menu/동파육.jpg",1,0,1,0,1),
("우육면",4,1,"/pickmeal/resources/img/menu/우육면.jpg",0,0,0,0,1),
("소롱포",1,1,"/pickmeal/resources/img/menu/소롱포.jpg",1,0,2,0,1),
("훠궈",1,0,"/pickmeal/resources/img/menu/훠궈.jpg",0,0,3,0,0),
("마라롱샤",1,0,"/pickmeal/resources/img/menu/마라롱샤.jpg",1,0,0,1,0),
("마라샹궈",1,0,"/pickmeal/resources/img/menu/마라샹궈.jpg",1,0,0,0,0),
("멘보샤",1,0,"/pickmeal/resources/img/menu/멘보샤.jpg",0,0,1,1,1),
("짬뽕밥",1,1,"/pickmeal/resources/img/menu/짬뽕밥.jpg",0,0,0,0,0),
("중화비빔밥",2,0,"/pickmeal/resources/img/menu/중화비빔밥.jpg",1,0,0,0,1),
("탄탄면",1,1,"/pickmeal/resources/img/menu/탄탄면.jpg",0,0,3,0,1),
("야끼우동",1,0,"/pickmeal/resources/img/menu/야끼우동.jpg",0,0,3,0,1),
("야끼덮밥",1,0,"/pickmeal/resources/img/menu/야끼덮밥.jpg",1,0,0,1,1),
("마파두부",3,0,"/pickmeal/resources/img/menu/마파두부.jpg",1,0,0,0,0),
("울면",1,0,"/pickmeal/resources/img/menu/울면.jpg",0,0,3,1,1),
("잡채밥",4,0,"/pickmeal/resources/img/menu/잡채밥.jpg",1,0,0,2,1)


#일식
INSERT INTO Menu(menuName,weather,temperature,imgPath,soupy,hot_ice,carbohydrate,mainFood,spicy)  
 VALUES ("가츠동",1,0,"/pickmeal/resources/img/menu/가츠동.jpg",1,0,0,0,1),
("곱창전골",3,1,"/pickmeal/resources/img/menu/곱창전골.jpg",0,0,0,0,0),
("규동",1,0,"/pickmeal/resources/img/menu/규동.jpg",1,0,0,0,1),
("돈까스",1,0,"/pickmeal/resources/img/menu/돈까스.jpg",1,0,0,0,0),
("라멘",3,0,"/pickmeal/resources/img/menu/라멘.jpg",0,0,2,0,0),
("메밀국수",2,2,"/pickmeal/resources/img/menu/메밀국수.jpg",0,1,2,2,1),
("메밀소바",2,2,"/pickmeal/resources/img/menu/메밀소바.jpg",1,1,2,2,1),
("밀푀유나베",4,1,"/pickmeal/resources/img/menu/밀푀유나베.jpg",0,0,0,2,1),
("사시미",1,1,"/pickmeal/resources/img/menu/사시미.jpg",1,1,0,1,1),
("생선구이",2,0,"/pickmeal/resources/img/menu/생선구이2.jpg",1,0,0,1,1),
("샤브샤브",1,2,"/pickmeal/resources/img/menu/샤브샤브.jpg",0,0,0,2,1),
("샤브샤브",1,2,"/pickmeal/resources/img/menu/샤브샤브.jpg",0,0,0,2,0),
("샤브샤브",1,2,"/pickmeal/resources/img/menu/샤브샤브.jpg",0,0,2,2,1),
("알밥",1,0,"/pickmeal/resources/img/menu/알밥.jpg",1,0,0,1,1),
("오므라이스",1,0,"/pickmeal/resources/img/menu/오므라이스.jpg",1,0,0,2,1),
("우동",4,1,"/pickmeal/resources/img/menu/우동.jpg",0,0,2,2,1),
("일식카레",1,0,"/pickmeal/resources/img/menu/일식카레.jpg",1,0,0,0,0),
("장어덮밥",3,2,"/pickmeal/resources/img/menu/장어덮밥.jpg",1,0,0,1,1),
("초밥",2,0,"/pickmeal/resources/img/menu/초밥.jpg",1,1,0,1,1),
("츠케멘",1,0,"/pickmeal/resources/img/menu/츠케멘.jpg",1,1,2,0,1),
("연어덮밥",1,0,"/pickmeal/resources/img/menu/연어덮밥.jpg",1,1,0,1,1)

INSERT INTO Menu(menuName,weather,temperature,imgPath,soupy,hot_ice,carbohydrate,mainFood,spicy)  
 VALUES ("갈비탕",4,0,"/pickmeal/resources/img/menu/갈비탕.jpg",0,0,0,0,1),
("김밥",1,0,"/pickmeal/resources/img/menu/김밥.jpg",1,1,0,2,1),
("떡볶이",1,0,"/pickmeal/resources/img/menu/떡볶이.jpg",0,0,3,0,0),
("뚝배기불고기",3,1,"/pickmeal/resources/img/menu/뚝배기불고기.jpg",0,0,0,0,1),
("라면",1,0,"/pickmeal/resources/img/menu/라면.jpg",0,0,2,2,0),
("물회",1,1,"/pickmeal/resources/img/menu/물회.jpg",1,1,0,1,1),
("쌀국수",2,0,"/pickmeal/resources/img/menu/쌀국수.jpg",0,0,2,2,1),
("월남쌈",1,0,"/pickmeal/resources/img/menu/월남쌈.jpg",1,1,0,2,1),
("유부초밥",1,0,"/pickmeal/resources/img/menu/유부초밥.jpg",1,1,0,0,1),
("족발",1,0,"/pickmeal/resources/img/menu/족발.jpg",1,0,0,0,1),
("쫄면",1,0,"/pickmeal/resources/img/menu/쫄면.jpg",1,1,2,2,0),
("커리",1,0,"/pickmeal/resources/img/menu/커리.jpg",1,0,0,2,0),
("탄두리치킨",1,0,"/pickmeal/resources/img/menu/탄두리치킨.jpg",1,0,0,0,0),
("팟타이",1,0,"/pickmeal/resources/img/menu/팟타이.jpg",1,0,2,2,1),
("나시고랭",1,0,"/pickmeal/resources/img/menu/나시고랭.jpg",1,0,0,0,1),
("똠양꿍",2,1,"/pickmeal/resources/img/menu/똠양꿍.jpg",0,0,0,2,0),
("미고랭",1,0,"/pickmeal/resources/img/menu/미고랭.jpg",1,0,2,0,1),
("반미",1,0,"/pickmeal/resources/img/menu/반미.jpg",0,0,1,0,1),
("분짜",1,0,"/pickmeal/resources/img/menu/분짜.jpg",1,0,0,0,1),
("짜조",2,0,"/pickmeal/resources/img/menu/짜조.jpg",1,0,3,2,1)