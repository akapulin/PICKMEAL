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
)

drop table Menu;
SELECT * FROM Menu;

INSERT INTO TogetherEatingPosting(memberId, restaurantId, title, content, likes, views, mealTime, recruitment, mealChk )

INSERT INTO Menu(menuName, weather, temperature, soupy, hot_ice, carbohydrate, mainFood, spicy)
VALUES ("웨더1템퍼0",1,0,1,1,1,1,1),
("웨더1템퍼1",1,1,1,1,1,1,1),
("웨더1템퍼2",1,2,1,1,1,1,1),
("웨더2템퍼0",2,0,1,1,1,1,1),
("웨더2템퍼1",2,1,1,1,1,1,1),
("웨더2템퍼2",2,2,1,1,1,1,1),
("웨더3템퍼0",3,0,1,1,1,1,1),
("웨더3템퍼1",3,1,1,1,1,1,1),
("웨더3템퍼2",3,2,1,1,1,1,1),
("웨더4템퍼0",4,0,1,1,1,1,1),
("웨더4템퍼1",4,1,1,1,1,1,1),
("웨더4템퍼2",4,2,1,1,1,1,1);

INSERT INTO Menu(menuName, weather, temperature, imgPath, soupy, hot_ice, carbohydrate, mainFood, spicy)
VALUES ("웨더2템퍼2이미지O",2,2,"/pickmeal/resources/img/menu/찜닭.jpg",1,1,1,1,1);