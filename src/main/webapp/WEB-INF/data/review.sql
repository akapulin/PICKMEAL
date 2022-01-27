
SELECT * FROM Review;
DELETE FROM Review;


CREATE TABLE Review (
	id				BIGINT			PRIMARY KEY	AUTO_INCREMENT,
	restaurantId	BIGINT,
	bathroom		INT,
	kind			INT,
	specialDay		INT,
	clean			INT,
	parking			INT,
	goodgroup		INT,
	alone			INT,
	big				INT,
	interior		INT
)

ALTER TABLE Review ADD userCount INT NOT NULL DEFAULT '1';


INSERT INTO Review(restaurantId, bathroom, kind, specialDay, clean, parking, goodgroup, alone, big, interior, usercount)
VALUES 
(119, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ),
(?, 19, 11, 3, 2, 7, 9, 4, 5, 8, 19 ),
(?, 13, 8, 7, 1, 4, 7, 0, 0, 10, 13 ),
(?, 9, 5, 7, 4, 5, 11, 0, 7, 4, 21 ),
(?, 13, 17, 4, 9, 13, 0, 1, 9, 1, 17 ),
(?, 15, 13, 0, 12, 0, 4, 7, 8, 11, 16 ),
(?, 4, 14, 0, 12, 6, 8, 3, 2, 1, 14 ),
(?, 11, 9, 5, 3, 5, 6, 2, 1, 0, 13 ),
(?, 22, 24, 1, 16, 18, 21, 5, 11, 7, 27 ),
(?, 3, 4, 26, 11, 9, 13, 18, 0, 7, 26 ),
(?, 67, 61, 22, 18, 109, 103, 81, 77, 68, 132 ),
(?, 15, 89, 91, 43, 15, 62, 17, 33, 35, 97 ),
(?, 12, 15, 17, 19, 21, 21, 31, 41, 13, 55 ),
(?, 11, 21, 31, 17, 21, 5, 7, 1, 13, 38 ),
(?, 13, 51, 23, 45, 13, 27, 55, 6, 3, 59 ),
(?, 21, 51, 15, 9, 21, 43, 12, 0, 13, 51 ),
(?, 14, 41, 51, 52, 1, 21, 0, 11, 32, 63 ),
(?, 121, 101, 25, 63, 72, 44, 32, 16, 82, 122 ),
(?, 51, 121, 142, 13, 76, 21, 131, 68, 91, 157 ),
(?, 42, 63, 152, 43, 101, 13, 181, 21, 13, 193 ),
(?, 22, 133, 152, 91, 56, 48, 121, 81, 65, 201 ),
(?, 56, 13, 22, 41, 5, 6, 12, 8, 21, 60),
(?, 66, 37, 22, 33, 44, 9, 12, 106, 79, 131),
(?, 0, 0, 0, 2, 1, 0, 2, 2, 1, 2),
(?, 3702, 1203, 344, 507, 1375, 5424, 3555, 512, 2136, 6782),
(?, 5783, 2895, 3810, 846, 512, 9001, 10004, 371, 6125, 10101),
(?, 21, 38, 124, 221, 457, 56, 217, 215, 52, 678),
(?, 51, 0, 8123, 6521, 537, 2185, 3850, 1286, 3125, 8125),
(?, 3714, 1258, 718, 913, 4525, 7138, 120, 4378, 1512, 7631),
(?, 910, 1258, 5158, 6913, 2525, 7002, 1207, 4068, 11012, 11023),
(?, 5600, 29, 6678, 913, 2305, 138, 1405, 2358, 2192, 9192);

delete from Review where id = 6;
SELECT * FROM Review
UPDATE Review SET bathroom = 1, kind = 1, specialDay = 1, clean = 1, parking = 1, goodgroup = 1, alone = 1, big = 1,interior = 1 WHERE restaurantId = 119

SELECT EXISTS (SELECT id FROM Review WHERE restaurantId = 1);

