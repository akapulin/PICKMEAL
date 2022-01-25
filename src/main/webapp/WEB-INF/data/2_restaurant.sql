CREATE TABLE Restaurant (
	id			BIGINT 			PRIMARY KEY AUTO_INCREMENT,
	apiId		BIGINT			UNIQUE KEY, 
	rType		BOOLEAN			DEFAULT FALSE,
	lat			DOUBLE			NOT NULL,
	lng			DOUBLE			NOT	NULL,
	address		VARCHAR(100)	NOT NULL,
	rName		VARCHAR(50)		NOT NULL
);

CREATE TABLE FavoriteRestaurant (
	id				BIGINT			PRIMARY KEY AUTO_INCREMENT,					#식당고유 아이디
	memberId		BIGINT			NOT NULL,									#멤버 아이디
	restaurantId	BIGINT			NOT NULL,									#레스토랑 아이디
	FOREIGN KEY (memberId) REFERENCES Member (id),								#아래 쭉 포링키
	FOREIGN KEY (restaurantId) REFERENCES Restaurant (id)	
);

CREATE TABLE VisitedRestaurant(
	id				BIGINT			PRIMARY KEY AUTO_INCREMENT,
	memberId		BIGINT			NOT NULL,
	restaurantId	BIGINT			NOT NULL,
	Review			boolean			DEFAULT FALSE,
	regDate			TIMESTAMP		NOT NULL		DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (memberId) REFERENCES Member (id),								#아래 쭉 포링키
	FOREIGN KEY (restaurantId) REFERENCES Restaurant (id)
);

CREATE TABLE RestaurantPreference (
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,
	restaurantId	BIGINT,
	gender CHAR(1),
	age CHAR(3)
);

CREATE TABLE Review (
	id				BIGINT		PRIMARY KEY	AUTO_INCREMENT,
	restaurantId	BIGINT		NOT NULL,
	userCount		INT			NOT NULL	DEFAULT '1',
	bathroom		INT			NOT NULL,
	kind			INT			NOT NULL,
	specialDay		INT			NOT NULL,
	clean			INT			NOT NULL,
	parking			INT			NOT NULL,
	goodgroup		INT			NOT NULL,
	alone			INT			NOT NULL,
	big				INT			NOT NULL,
	interior		INT			NOT NULL,
	FOREIGN KEY (restaurantId) REFERENCES Restaurant (id)
);

DROP TABLE Review;
DROP TABLE RestaurantPreference;
DROP TABLE VisitedRestaurant;
DROP TABLE FavoriteRestaurant;
DROP TABLE Restaurant;

SELECT * FROM Review;
SELECT * FROM RestaurantPreference;
SELECT * FROM VisitedRestaurant;
SELECT * FROM FavoriteRestaurant;
SELECT * FROM Restaurant;
