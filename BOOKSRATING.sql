Select * from dbo.Ratings

--Average ratingas per ISBN
SELECT ISbn ,AVG(Book_rating) as Avg_Ratig FROM ProjectPortfolio.DBO.Ratings GROUP BY ISBN ORDER BY Avg_Ratig DESC

--Top 5 Users with Highest Average Ratings:

SELECT TOP 10( USER_ID) ,AVG(BOOK_RATING) AS AVG_RATING 
FROM DBO.Ratings 
GROUP BY User_ID 
ORDER BY AVG_RATING DESC 

--Count of the Ratings Each Book Has Received:

SELECT ISBN ,COUNT(BOOK_RATING) AS NO_RATING
FROM DBO.Ratings 
GROUP BY ISBN

--Books that Have Received a Rating of 5 from More Than 10 Different Users:

SELECT ISBN FROM DBO.Ratings
WHERE Book_Rating = 10
GROUP BY ISBN 
HAVING COUNT(DISTINCT User_ID) > 10
--User Who Has Rated the Most Books:

SELECT TOP 1 USER_ID ,COUNT(ISBN) COUNTOFRATING 
FROM DBO.Ratings
GROUP BY User_ID
ORDER BY COUNTOFRATING DESC

-- Books That Have Ratings Spread Across All Possible Ratings
	
	SELECT ISBN
	FROM DBO.Ratings 
	GROUP BY ISBN
	HAVING COUNT(DISTINCT "Book_Rating") = 10

--Most Frequently Rated Book by Each User
SELECT USER_ID,ISBN,COUNT(*) AS NO_OFRATING
FROM Ratings
GROUP BY USER_ID,ISBN
ORDER BY User_ID,NO_OFRATING DESC

--Users Who Have Rated More Than 20 Books
SELECT USER_ID, COUNT(*) AS NO_OFRATING
FROM Ratings 
GROUP BY User_ID HAVING COUNT(USER_ID) > 20
ORDER BY NO_OFRATING DESC

--ISBNs and Average Ratings of Books with More Than 10 Ratings

SELECT ISBN , AVG(BOOK_RATING) AS AVG_RATING
FROM Ratings
GROUP BY ISBN HAVING COUNT(*) > 10
ORDER BY AVG_RATING DESC

--Distribution of Ratings

SELECT BOOK_RATING ,COUNT(*) AS RATINGCOUNT 
FROM Ratings
GROUP BY Book_Rating 
ORDER BY RATINGCOUNT

--DESCRIPTIVE ANALYSIS

SELECT COUNT(*) AS TOTALRATINGS FROM Ratings

--Average Rating Given by Each User
SELECT USER_ID,AVG(BOOK_RATING) AS AVG_RATING
FROM Ratings
GROUP BY User_ID
--Analyze Zero Ratings Separately
SELECT COUNT(*) as Zerorating FROM ProjectPortfolio.DBO.Ratings
WHERE Book_Rating ='0'

--Analyze Non-Zero Ratings
SELECT ISBN , AVG(BOOK_RATING) AS AVG_RATING
FROM ProjectPortfolio.DBO.Ratings 
WHERE Book_Rating > 0
GROUP BY ISBN;

--Finding median Value and replacing with 0

WITH MEDIANCTE AS (
					SELECT BOOK_RATING,PERCENTILE_CONT(0.3)WITHIN GROUP (ORDER BY BOOK_RATING) OVER() AS MEDIANRATING
					FROM ProjectPortfolio.DBO.Ratings WHERE Book_Rating > 0
					)
SELECT DISTINCT MEDIANRATING FROM MEDIANCTE

update ProjectPortfolio.dbo.Ratings
set Book_Rating = 8 
where Book_Rating = 0




