-- SELECT All records from netflix_titles
USE Netflix;
SELECT * FROM netflix_titles
ORDER BY year_added;

SELECT * FROM netflix_country
ORDER BY country;

SELECT * FROM netflix_cast;

SELECT * FROM netflix_genre;

SELECT * FROM netflix_directors;


-- DOES netflix have more movies or tv shows
USE Netflix;
SELECT type, COUNT(*) as num_items
FROM netflix_titles
GROUP BY type;

-- Most common ratings?

SELECT rating, COUNT(show_id) as num_items
FROM netflix_titles
GROUP BY rating
ORDER BY num_items desc;

-- AVERAGE duration of movies and tv shows(season)

SELECT type, AVG(duration) as average_duration
FROM netflix_titles
GROUP BY type
ORDER BY type;

SELECT * FROM netflix_titles
ORDER BY year_added;

-- Shows_Movies that were in the most countries

SELECT b.title, COUNT(a.country) as num_countries
FROM netflix_country a
INNER JOIN netflix_titles b 
on a.show_id = b.show_id
GROUP BY b.title
ORDER BY num_countries desc;

-- Show titles and country names for titles were in 5+ countries
SELECT a.title, a.type, a.year_added,b.country
FROM
netflix_titles a
INNER JOIN netflix_country b
on a.show_id=b.show_id
WHERE a.show_id in (SELECT show_id
FROM (SELECT show_id,COUNT(show_id) as count_countries FROM netflix_country  GROUP BY show_id HAVING COUNT(show_id)>=5) c ) 
ORDER BY a.year_added asc;

-- 10 top actors on netflix

SELECT cast, count(cast) as num_titles
FROM netflix_cast
GROUP BY cast
ORDER BY num_titles desc
LIMIT 10;

-- Find titles that feature these 10 top actors

SELECT a.title,b.cast
FROM netflix_titles a
INNER JOIN netflix_cast b
on a.show_id=b.show_id
WHERE b.cast IN (SELECT cast FROM (SELECT cast,count(cast) as num_cast FROM netflix_cast
GROUP BY cast ORDER BY num_cast DESC LIMIT 10) c );

-- Genre 
-- Top 5 most common genres

SELECT genre, count(genre) as num_titles
FROM netflix_genre
GROUP BY genre
ORDER BY num_titles desc
LIMIT 5;

-- TOP 5 most common genres in tv shows
WITH temp as (
SELECT a.show_id,a.genre,b.type
FROM netflix_genre a
INNER JOIN netflix_titles b on a.show_id=b.show_id)
SELECT genre, count(show_id) as count_tvshows
FROM temp
WHERE type='TV Show'
GROUP BY genre
ORDER BY count_tvshows desc
LIMIT 5;

-- Finding titles where actor is same as director
SELECT a.title, b.cast, c.director
FROM netflix_titles a
INNER JOIN netflix_cast b on a.show_id=b.show_id
INNER JOIN netflix_directors c on a.show_id=c.show_id
WHERE b.cast=c.director;
















