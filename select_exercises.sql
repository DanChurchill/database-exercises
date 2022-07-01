-- #2 utilize the albums_db database
use albums_db;

-- #3 
DESCRIBE albums;
	-- a. How many rows are in the albums table: 31
SELECT * FROM albums;

	-- b. How many unique artist names are in the albums table:  23
SELECT DISTINCT artist FROM albums;

    -- c. What is the primary key for the albums table: id
DESCRIBE albums;

	-- d. What is the oldest release date for any album in the albums table? 1967
SELECT min(release_date) FROM albums;
    -- 	  What is the most recent release date? 2011
SELECT max(release_date) FROM albums;

-- 4 Write queries to find the following information:
	-- a. The name of all albums by Pink Floyd
SELECT name FROM albums WHERE artist = "Pink Floyd";

	-- b. The year Sgt. Pepper's Lonely Hearts Club Band was released
SELECT release_date FROM albums WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

	-- c. The genre for the album Nevermind
SELECT genre FROM albums WHERE name = "Nevermind";

	-- d. Which albums were released in the 1990s
SELECT name, release_date FROM albums WHERE release_date < 2000 AND release_date > 1989;

	-- e. Which albums had less than 20 million certified sales
SELECT name, sales FROM albums WHERE sales < 20;

	-- f. All the albums with a genre of "Rock"
SELECT name, genre FROM albums WHERE genre = "Rock";
	-- Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
	-- Because we used "=" with no wild cards.





