--The most popular movies based on the rating
select m.TITLE, m.YEAR, AVG(r.Rating) AS AVG_Rating, Count(r.Rating) AS Number_of_Ratings
from MOVIE_INMEM m INNER JOIN RATING_INMEM r
ON m.MOVIE_ID = r.MOVIE_ID
GROUP BY (m.TITLE, m.YEAR)
ORDER BY AVG(r.Rating) desc, COUNT(r.Rating) desc
fetch first 15 rows only;


--Most popular movies of a genre (e.g.: Thriller)
SELECT m.TITLE, m.YEAR, ROUND(AVG(r.RATING),2) AS AVG_Rating
FROM MOVIE_INMEM m INNER JOIN RATING_INMEM R
    on m.MOVIE_ID = R.MOVIE_ID
where GENRE = 'Thriller'
GROUP BY (m.TITLE, m.YEAR)
ORDER BY AVG_Rating desc;


--Best rated movies of a user (e.g.: User 1)
select m.TITLE, m.YEAR, r.RATING
from MOVIE_INMEM m INNER JOIN RATING_INMEM r
    on m.MOVIE_ID = r.MOVIE_ID
where r.USER_ID = 1
ORDER BY r.rating desc
fetch first 10 rows only;


--Add a rating
INSERT INTO RATING_INMEM
VALUES ((Select max(RATING_ID) from RATING_INMEM) + 1, 1, 3000, 3, SYSDATE);

Select *
From Rating
order by RATING_ID desc;

ROLLBACK;


--Add a movie
INSERT INTO MOVIE_INMEM
VALUES ((Select max(MOVIE_ID) from MOVIE_INMEM) + 1, 'Evil Dead Rise', 2023, 'Horror');

Select *
From MOVIE_INMEM
order by MOVIE_ID desc;

ROLLBACK;


--Delete a rating
DELETE FROM RATING_INMEM
WHERE RATING_ID = 1;

Select *
FROM RATING_INMEM
order by RATING_ID;

ROLLBACK;


--Update a rating
UPDATE RATING_INMEM
SET RATING = 5
WHERE RATING_ID = 1;

Select *
FROM RATING_INMEM
where RATING_ID = 1
order by RATING_ID;

ROLLBACK;


--Delete a movie
DELETE FROM MOVIE_INMEM
WHERE MOVIE_ID = 1;

Select *
FROM MOVIE_INMEM
order by MOVIE_ID;

ROLLBACK;


--Movie recommendations to a user assuming that the user has watched the movie with the Movie_id = 3000 and that this movie belongs to the genre Drama
SELECT m.GENRE, m.TITLE, m.YEAR, r.RATING
FROM MOVIE_INMEM m INNER JOIN RATING_INMEM R
    on m.MOVIE_ID = R.MOVIE_ID
WHERE GENRE = 'Drama' AND m.MOVIE_ID != 3000
GROUP BY (m.Genre, m.TITLE, m.YEAR, r.RATING)
HAVING AVG(r.RATING) >= 4
fetch first 3 rows only;


--All movies rated better than 4
SELECT DISTINCT m.title, r.RATING
from MOVIE_INMEM m INNER JOIN RATING_INMEM r
    on m.MOVIE_ID = r.MOVIE_ID
where r.rating >= 4
ORDER BY r.Rating desc;


--All movies rated better than 4 for a genre (e.g.: Comedy)
SELECT m.TITLE, m.YEAR, m.GENRE, AVG(r.RATING) AS AVG_Rating
FROM MOVIE_INMEM m INNER JOIN RATING_INMEM R
    on m.MOVIE_ID = R.MOVIE_ID
WHERE GENRE = 'Comedy'
GROUP BY (m.Genre, m.TITLE, m.YEAR, r.RATING)
HAVING AVG(r.RATING) >= 4
ORDER BY AVG(r.RATING) desc;

--Most awarded tags
SELECT Tag, COUNT(TAG) AS Number_Of_Tags
FROM TAG_INMEM
GROUP BY TAG
ORDER BY Number_Of_Tags desc
fetch first 15 rows only;

--Movie with the most tags
SELECT m.TITLE, COUNT(TAG) AS Number_Of_Tags
FROM TAG_INMEM t INNER JOIN MOVIE_INMEM M
 on M.MOVIE_ID = t.MOVIE_ID
GROUP BY (m.TITLE)
ORDER BY Number_Of_Tags desc
fetch first 15 rows only;

--Movie with the most tags in the different years
SELECT m.YEAR, COUNT(TAG) AS Number_Of_Tags
FROM TAG_INMEM t INNER JOIN MOVIE_INMEM M
    on M.MOVIE_ID = t.MOVIE_ID
GROUP BY (m.YEAR)
ORDER BY m.YEAR desc;