-- Beginner Level (1–15)
USE sql_kaggle;
-- 1. Show all records from the dataset.
SELECT * FROM netflix;

-- 2. Show the first 10 records.
SELECT * FROM netflix LIMIT 10;

-- 3. Show all movies in the dataset.
SELECT * FROM netflix WHERE type = 'movie';

-- 4. Show all TV Shows released after 2015.
SELECT * FROM netflix
WHERE type = 'TV Show' AND release_year >= 2015;

-- 5. Count the total number of records.
SELECT COUNT(*) FROM netflix;

-- 6. Count the total number of Movies.
SELECT COUNT(*) FROM netflix WHERE type = 'Movie';

-- 7. Show distinct content types.
SELECT DISTINCT type FROM netflix;

-- 8. Show all unique ratings.
SELECT DISTINCT rating FROM netflix;

-- 9. Show titles with PG-13 rating.
SELECT title, rating FROM netflix WHERE rating = 'PG-13';

-- 10. Show titles released in 2020.
SELECT title FROM netflix WHERE release_year = 2020;

-- 11. Show titles in alphabetical order.
SELECT title FROM netflix ORDER BY title ASC;

-- 12. Show top 5 longest descriptions by character length.
SELECT title, LENGTH(description) AS desc_length FROM netflix ORDER BY desc_length DESC LIMIT 5;

-- 13. Show titles containing the word 'love'.
SELECT title FROM netflix WHERE title LIKE '%love%';

-- 14. Show Indian movies.
SELECT * FROM netflix WHERE country = 'India' AND type = 'Movie';

-- 15. Show all countries available in the dataset.
SELECT DISTINCT country FROM netflix;

-- Intermediate Level (16–35)

-- 16. Count number of records by type (Movie/TV Show).

SELECT type, COUNT(*) AS count FROM netflix
GROUP BY type;

-- 17. Top 5 countries by number of contents.

SELECT country, COUNT(*) AS count FROM netflix
WHERE country IS NOT NULL
GROUP BY country ORDER BY count DESC LIMIT 5;

-- 18. Number of releases per year.

SELECT 
    release_year, COUNT(*)
FROM
    netflix
GROUP BY release_year;

-- 19. Average number of releases per year.

SELECT AVG(count) FROM (SELECT release_year, COUNT(*) AS count FROM netflix
GROUP BY release_year) AS yearly;

-- 20. Most recently added 10 titles.

SELECT 
    title,
    EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added
FROM
    netflix
WHERE
    date_added IS NOT NULL;
    
-- 20. Most recently added 10 titles.

SELECT 
    title, date_added
FROM
    netflix
WHERE
    date_added IS NOT NULL
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC
LIMIT 10;

-- 21. Count number of records by rating.

SELECT rating, COUNT(*) AS count FROM netflix
GROUP BY rating;

-- 22. Show records with multiple genres listed.

SELECT * FROM netflix WHERE listed_in LIKE '%,%';

-- 23. Count distinct directors.

SELECT COUNT(DISTINCT director) FROM netflix WHERE director IS NOT NULL;

-- 24. Show records with missing director names.

SELECT * FROM netflix WHERE director IS NULL;

-- 25. Show titles and year when added.

SELECT title, EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added FROM netflix
WHERE date_added IS NOT NULL;


-- 26. Show records added between 2019 and 2021.

SELECT title, STR_TO_DATE(date_added, '%M %d, %Y') AS real_date,
EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added
FROM netflix
WHERE date_added IS NOT NULL 
AND EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) BETWEEN 2019 AND 2021; 

-- 27. Count Stand-Up Comedy titles.

SELECT COUNT(*) AS Count FROM netflix WHERE listed_in LIKE '%Stand-Up%';

-- 28. Top 5 genres with most content.

SELECT listed_in, COUNT(*) AS count FROM netflix
GROUP BY listed_in 
ORDER BY count DESC LIMIT 5;

-- 29. Count Children & Family content.

SELECT COUNT(*) FROM netflix WHERE listed_in LIKE '%Children%';

-- 30. Show titles with Tom Hanks in cast.

SELECT title FROM netflix WHERE cast LIKE '%Tom Hanks%';

-- 31. Top 5 longest movies by duration.

SELECT title, duration FROM netflix WHERE type = 'Movie'
ORDER BY CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) DESC LIMIT 5;

SELECT title, CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS minutes
FROM netflix
WHERE type = 'Movie'
ORDER BY minutes DESC
LIMIT 5;
 
-- 32. Year with highest number of releases.

SELECT release_year, COUNT(*) AS count FROM netflix GROUP BY release_year ORDER BY count DESC LIMIT 1;

-- 33. Top 10 directors by number of contents.

SELECT director, COUNT(*) AS count FROM netflix WHERE director IS NOT NULL GROUP BY director ORDER BY count DESC LIMIT 10; 

-- 34. Monthly content additions.

SELECT 
    DATE_FORMAT(STR_TO_DATE(date_added, '%M %d, %Y'),
            '%Y-%m') AS month_added,
    COUNT(*) AS total
FROM
    netflix
WHERE
    date_added IS NOT NULL
GROUP BY month_added
ORDER BY month_added;

-- 35. Show TV Shows with only 1 season.
SELECT * FROM netflix WHERE type = 'TV Show' AND  duration = '1 Season';

--  Titles Added Between 2019–2021 — Line Plot or Bar Plot

SELECT EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
       COUNT(*) AS count
FROM netflix
WHERE date_added IS NOT NULL
AND EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) BETWEEN 2019 AND 2021
GROUP BY year_added
ORDER BY year_added;

-- Advanced Level (36–50)

-- 36. Categorize content by rating level.

SELECT 
  title, 
  rating, 
  CASE
    WHEN rating IN ('G', 'PG', 'TV-G', 'TV-Y', 'TV-Y7', 'TV-Y7-FV') THEN 'Family'
    WHEN rating IN ('PG-13', 'TV-14', 'TV-PG') THEN 'Teen'
    WHEN rating IN ('R', 'TV-MA', 'NC-17') THEN 'Adult'
    ELSE 'Other'
  END AS category
FROM netflix
WHERE rating NOT LIKE '%min%' AND rating IS NOT NULL;

-- 37. Top 5 directors with most titles.

SELECT director, COUNT(*) AS total FROM netflix WHERE director IS NOT NULL GROUP BY director ORDER BY total DESC LIMIT 5;

-- 38. Countries with more than 100 titles.

SELECT country, COUNT(*) AS count FROM netflix WHERE country IS NOT NULL GROUP BY country HAVING COUNT(*) > 100 ORDER BY count DESC;

-- 39. Top 3 recent titles by type using RANK().

SELECT title, type, date_added, rnk
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY type ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC) AS rnk
    FROM netflix
    WHERE date_added IS NOT NULL
) AS ranked
WHERE rnk <= 3;


-- 40. Show single-genre content only.

SELECT * FROM netflix WHERE listed_in NOT LIKE '%,%';

-- 41. First-ever release for each type.

SELECT type, title, release_year FROM (SELECT *, RANK() OVER(PARTITION BY type ORDER BY release_year ASC) AS rnk 
FROM netflix
WHERE release_year IS NOT NULL) AS ranked 
WHERE rnk <= 1;

-- 42. Use CTE to extract Drama titles.

WITH drama_titles AS (
    SELECT * 
    FROM netflix 
    WHERE listed_in LIKE '%Drama%'
)
SELECT * 
FROM drama_titles;

-- 43. Show Romantic Comedies.

SELECT * FROM netflix WHERE listed_in LIKE '%Romantic%' AND listed_in LIKE '%Comedy%';

-- 44. Directors with more than 5 titles.

SELECT 
    director, COUNT(*) AS total_count
FROM
    netflix
WHERE
    director IS NOT NULL
GROUP BY director
HAVING COUNT(*) > 5
ORDER BY total_count DESC; 

-- 45. Top 3 recent titles per country using ROW_NUMBER().

SELECT title, TRIM(BOTH ',' FROM TRIM(country)) AS country , 
rnk FROM(SELECT *, ROW_NUMBER() OVER(PARTITION BY country ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC) AS rnk 
FROM netflix
WHERE country IS NOT NULL) AS ranked 
WHERE rnk <=3; 



-- 47. Number of releases by type per year.

SELECT release_year, type, COUNT(*) AS count FROM netflix GROUP BY type, release_year ORDER BY release_year;

-- 48. Movies longer than 2 hours.

SELECT 
    title, duration
FROM
    netflix
WHERE
    type = 'Movie' AND duration LIKE '%min%'
        AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 120;

-- 49. Content additions per year grouped by type.

SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
    type,
    COUNT(*) AS total_count
FROM
    netflix
WHERE
    date_added IS NOT NULL
GROUP BY year_added , type
ORDER BY year_added;  


-- 46. (Advanced) Frequent actors – Requires ETL.
