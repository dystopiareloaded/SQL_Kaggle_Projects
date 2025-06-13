# 🎬 Netflix Movies and TV Shows Data Analysis using SQL

![](logo.png)

## 📊 Overview
This project involves an extensive analysis of Netflix's movies and TV shows dataset using SQL. The analysis covers 50 queries ranging from beginner to advanced levels, extracting valuable insights about content distribution, ratings, genres, directors, and more.

## 📊 Objectives

- Explore the complete Netflix content dataset
- Analyze content distribution between movies and TV shows
- Investigate release patterns over time
- Examine content by country, rating, and genre
- Identify top directors, actors, and production countries
- Perform advanced analytics using window functions and complex queries

## 📦 Dataset
The data for this project is sourced from the Kaggle dataset:
- **Dataset Link:** [Netflix Movies and TV Shows](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## 🧱 SQL Schema Assumption
```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## 🧾 SQL Questions with Solutions

### Beginner Level Queries (1-15)

1. **Show all records from the dataset**
```sql
SELECT * FROM netflix;
```
🎯 Objective: Get a complete view of all data in the Netflix dataset.

2. **Show the first 10 records**
```sql
SELECT * FROM netflix LIMIT 10;
```
🎯 Objective: Quickly preview a sample of the dataset.

3. **Show all movies in the dataset**
```sql
SELECT * FROM netflix WHERE type = 'movie';
```
🎯 Objective: Filter and view only movie content from the dataset.

4. **Show all TV Shows released after 2015**
```sql
SELECT * FROM netflix
WHERE type = 'TV Show' AND release_year >= 2015;
```
🎯 Objective: Identify recent TV shows added to Netflix.

5. **Count the total number of records**
```sql
SELECT COUNT(*) FROM netflix;
```
🎯 Objective: Determine the total volume of content in the dataset.

6. **Count the total number of Movies**
```sql
SELECT COUNT(*) FROM netflix WHERE type = 'Movie';
```
🎯 Objective: Quantify the movie content available.

7. **Show distinct content types**
```sql
SELECT DISTINCT type FROM netflix;
```
🎯 Objective: Identify the different categories of content available.

8. **Show all unique ratings**
```sql
SELECT DISTINCT rating FROM netflix;
```
🎯 Objective: Understand the content rating system used by Netflix.

9. **Show titles with PG-13 rating**
```sql
SELECT title, rating FROM netflix WHERE rating = 'PG-13';
```
🎯 Objective: Find content suitable for teenagers under parental guidance.

10. **Show titles released in 2020**
```sql
SELECT title FROM netflix WHERE release_year = 2020;
```
🎯 Objective: Identify the most recent content available.

11. **Show titles in alphabetical order**
```sql
SELECT title FROM netflix ORDER BY title ASC;
```
🎯 Objective: Organize content for easier browsing.

12. **Show top 5 longest descriptions by character length**
```sql
SELECT title, LENGTH(description) AS desc_length 
FROM netflix 
ORDER BY desc_length DESC 
LIMIT 5;
```
🎯 Objective: Find content with the most detailed descriptions.

13. **Show titles containing the word 'love'**
```sql
SELECT title FROM netflix WHERE title LIKE '%love%';
```
🎯 Objective: Identify romantic-themed content.

14. **Show Indian movies**
```sql
SELECT * FROM netflix 
WHERE country = 'India' AND type = 'Movie';
```
🎯 Objective: Analyze Bollywood and regional Indian cinema content.

15. **Show all countries available in the dataset**
```sql
SELECT DISTINCT country FROM netflix;
```
🎯 Objective: Understand the geographical distribution of content.

### Intermediate Level Queries (16-35)

16. **Count number of records by type (Movie/TV Show)**
```sql
SELECT type, COUNT(*) AS count 
FROM netflix
GROUP BY type;
```
🎯 Objective: Compare the quantity of movies versus TV shows.

17. **Top 5 countries by number of contents**
```sql
SELECT country, COUNT(*) AS count 
FROM netflix
WHERE country IS NOT NULL
GROUP BY country 
ORDER BY count DESC 
LIMIT 5;
```
🎯 Objective: Identify the most productive content-creating nations.

18. **Number of releases per year**
```sql
SELECT release_year, COUNT(*)
FROM netflix
GROUP BY release_year;
```
🎯 Objective: Analyze content release trends over time.

19. **Average number of releases per year**
```sql
SELECT AVG(count) 
FROM (
    SELECT release_year, COUNT(*) AS count 
    FROM netflix
    GROUP BY release_year
) AS yearly;
```
🎯 Objective: Calculate the average annual content production.

20. **Most recently added 10 titles**
```sql
SELECT title, date_added
FROM netflix
WHERE date_added IS NOT NULL
ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC
LIMIT 10;
```
🎯 Objective: Find the newest additions to Netflix's library.

21. **Count number of records by rating**
```sql
SELECT rating, COUNT(*) AS count 
FROM netflix
GROUP BY rating;
```
🎯 Objective: Understand the distribution of content ratings.

22. **Show records with multiple genres listed**
```sql
SELECT * FROM netflix WHERE listed_in LIKE '%,%';
```
🎯 Objective: Identify content that crosses multiple genres.

23. **Count distinct directors**
```sql
SELECT COUNT(DISTINCT director) 
FROM netflix 
WHERE director IS NOT NULL;
```
🎯 Objective: Measure the diversity of creative talent.

24. **Show records with missing director names**
```sql
SELECT * FROM netflix WHERE director IS NULL;
```
🎯 Objective: Identify data quality issues in the director field.

25. **Show titles and year when added**
```sql
SELECT title, EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added 
FROM netflix
WHERE date_added IS NOT NULL;
```
🎯 Objective: Analyze when content was added to Netflix.

26. **Show records added between 2019 and 2021**
```sql
SELECT title, STR_TO_DATE(date_added, '%M %d, %Y') AS real_date,
EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added
FROM netflix
WHERE date_added IS NOT NULL 
AND EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) BETWEEN 2019 AND 2021;
```
🎯 Objective: Focus on recent content additions during peak streaming years.

27. **Count Stand-Up Comedy titles**
```sql
SELECT COUNT(*) AS Count 
FROM netflix 
WHERE listed_in LIKE '%Stand-Up%';
```
🎯 Objective: Quantify comedy specials available.

28. **Top 5 genres with most content**
```sql
SELECT listed_in, COUNT(*) AS count 
FROM netflix
GROUP BY listed_in 
ORDER BY count DESC 
LIMIT 5;
```
🎯 Objective: Identify the most popular content categories.

29. **Count Children & Family content**
```sql
SELECT COUNT(*) 
FROM netflix 
WHERE listed_in LIKE '%Children%';
```
🎯 Objective: Measure family-friendly content availability.

30. **Show titles with Tom Hanks in cast**
```sql
SELECT title 
FROM netflix 
WHERE casts LIKE '%Tom Hanks%';
```
🎯 Objective: Find content featuring this popular actor.

31. **Top 5 longest movies by duration**
```sql
SELECT title, CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) AS minutes
FROM netflix
WHERE type = 'Movie'
ORDER BY minutes DESC
LIMIT 5;
```
🎯 Objective: Identify the most lengthy movie content.

32. **Year with highest number of releases**
```sql
SELECT release_year, COUNT(*) AS count 
FROM netflix 
GROUP BY release_year 
ORDER BY count DESC 
LIMIT 1;
```
🎯 Objective: Find the peak year for content production.

33. **Top 10 directors by number of contents**
```sql
SELECT director, COUNT(*) AS count 
FROM netflix 
WHERE director IS NOT NULL 
GROUP BY director 
ORDER BY count DESC 
LIMIT 10;
```
🎯 Objective: Recognize the most prolific directors.

34. **Monthly content additions**
```sql
SELECT 
    DATE_FORMAT(STR_TO_DATE(date_added, '%M %d, %Y'), '%Y-%m') AS month_added,
    COUNT(*) AS total
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY month_added
ORDER BY month_added;
```
🎯 Objective: Analyze seasonal patterns in content additions.

35. **Show TV Shows with only 1 season**
```sql
SELECT * 
FROM netflix 
WHERE type = 'TV Show' AND duration = '1 Season';
```
🎯 Objective: Identify limited series or cancelled shows.

### Advanced Level Queries (36-50)

36. **Categorize content by rating level**
```sql
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
```
🎯 Objective: Create audience-specific content groupings.

37. **Top 5 directors with most titles**
```sql
SELECT director, COUNT(*) AS total 
FROM netflix 
WHERE director IS NOT NULL 
GROUP BY director 
ORDER BY total DESC 
LIMIT 5;
```
🎯 Objective: Highlight the most influential directors.

38. **Countries with more than 100 titles**
```sql
SELECT country, COUNT(*) AS count 
FROM netflix 
WHERE country IS NOT NULL 
GROUP BY country 
HAVING COUNT(*) > 100 
ORDER BY count DESC;
```
🎯 Objective: Identify major content-producing nations.

39. **Top 3 recent titles by type using RANK()**
```sql
SELECT title, type, date_added, rnk
FROM (
    SELECT *, 
           RANK() OVER (PARTITION BY type ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC) AS rnk
    FROM netflix
    WHERE date_added IS NOT NULL
) AS ranked
WHERE rnk <= 3;
```
🎯 Objective: Find the newest movies and shows using window functions.

40. **Show single-genre content only**
```sql
SELECT * FROM netflix WHERE listed_in NOT LIKE '%,%';
```
🎯 Objective: Identify content with focused genre classification.

41. **First-ever release for each type**
```sql
SELECT type, title, release_year 
FROM (
    SELECT *, RANK() OVER(PARTITION BY type ORDER BY release_year ASC) AS rnk 
    FROM netflix
    WHERE release_year IS NOT NULL
) AS ranked 
WHERE rnk <= 1;
```
🎯 Objective: Discover the earliest content in Netflix's library.

42. **Use CTE to extract Drama titles**
```sql
WITH drama_titles AS (
    SELECT * 
    FROM netflix 
    WHERE listed_in LIKE '%Drama%'
)
SELECT * FROM drama_titles;
```
🎯 Objective: Demonstrate CTE usage while analyzing popular dramas.

43. **Show Romantic Comedies**
```sql
SELECT * 
FROM netflix 
WHERE listed_in LIKE '%Romantic%' AND listed_in LIKE '%Comedy%';
```
🎯 Objective: Identify Rom-Com genre content.

44. **Directors with more than 5 titles**
```sql
SELECT director, COUNT(*) AS total_count
FROM netflix
WHERE director IS NOT NULL
GROUP BY director
HAVING COUNT(*) > 5
ORDER BY total_count DESC;
```
🎯 Objective: Find established directors with significant contributions.

45. **Top 3 recent titles per country using ROW_NUMBER()**
```sql
SELECT title, TRIM(BOTH ',' FROM TRIM(country)) AS country, rnk 
FROM (
    SELECT *, 
           ROW_NUMBER() OVER(PARTITION BY country ORDER BY STR_TO_DATE(date_added, '%M %d, %Y') DESC) AS rnk 
    FROM netflix
    WHERE country IS NOT NULL
) AS ranked 
WHERE rnk <=3;
```
🎯 Objective: Analyze recent additions by country using advanced window functions.

46. **Number of releases by type per year**
```sql
SELECT release_year, type, COUNT(*) AS count 
FROM netflix 
GROUP BY type, release_year 
ORDER BY release_year;
```
🎯 Objective: Track content type trends over time.

47. **Movies longer than 2 hours**
```sql
SELECT title, duration
FROM netflix
WHERE type = 'Movie' AND duration LIKE '%min%'
    AND CAST(SUBSTRING_INDEX(duration, ' ', 1) AS UNSIGNED) > 120;
```
🎯 Objective: Identify feature-length films.

48. **Content additions per year grouped by type**
```sql
SELECT 
    EXTRACT(YEAR FROM STR_TO_DATE(date_added, '%M %d, %Y')) AS year_added,
    type,
    COUNT(*) AS total_count
FROM netflix
WHERE date_added IS NOT NULL
GROUP BY year_added, type
ORDER BY year_added;
```
🎯 Objective: Analyze Netflix's acquisition strategy over time.

---

### Key Findings
- **Content Distribution:** Movies significantly outnumber TV shows in Netflix's library.
- **Production Trends:** The United States dominates content production, followed by India.
- **Rating Patterns:** TV-MA (Mature) content is most prevalent, indicating adult-oriented programming.
- **Genre Popularity:** International content and dramas are the most common categories.
- **Temporal Analysis:** Content additions have grown exponentially in recent years.
- **Creative Talent:** A small group of directors account for a large portion of content.

---

### Conclusion
This comprehensive SQL analysis provides valuable insights into Netflix's content strategy, revealing:
- The platform's emphasis on movies over TV shows
- The global nature of its content library
- Trends in content acquisition and production
- Popular genres and rating distributions

The 50 queries demonstrate a wide range of SQL techniques from basic filtering to advanced analytical functions, showcasing the power of SQL for business intelligence and data analysis in the entertainment industry.

---

## 👨‍💻 Author

**Kaustav Roy Chowdhury**  
📧 Data Analyst | SQL Enthusiast | Python | Streamlit  
✍️ *"When SQL speaks, everything else becomes a footnote."*    
    
