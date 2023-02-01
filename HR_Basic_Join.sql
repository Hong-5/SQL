# 2023/02/01

-- Q. Given the CITY and COUNTRY tables, query the sum of the populations of all cities where the CONTINENT is 'Asia'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

SELECT SUM(CITY.POPULATION)
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.CONTINENT = 'Asia'

-- Q. Given the CITY and COUNTRY tables, query the names of all cities where the CONTINENT is 'Africa'.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

SELECT CITY.NAME
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
WHERE COUNTRY.CONTINENT = 'Africa'

-- Q. Given the CITY and COUNTRY tables, query the names of all the continents (COUNTRY.Continent) and their respective average city populations (CITY.Population) rounded down to the nearest integer.
-- Note: CITY.CountryCode and COUNTRY.Code are matching key columns.

SELECT COUNTRY.Continent, FLOOR(SUM(CITY.Population) / COUNT(CITY.ID))
FROM CITY
JOIN COUNTRY ON CITY.CountryCode = COUNTRY.Code
GROUP BY COUNTRY.Continent

-- Q. Ketty gives Eve a task to generate a report containing three columns: Name, Grade and Mark. Ketty doesn't want the NAMES of those students who received a grade lower than 8. 
-- The report must be in descending order by grade -- i.e. higher grades are entered first. If there is more than one student with the same grade (8-10) assigned to them, order those particular students by their name alphabetically. Finally, if the grade is lower than 8, use "NULL" as their name and list them by their grades in descending order. If there is more than one student with the same grade (1-7) assigned to them, order those particular students by their marks in ascending order.

WITH tmp as
(SELECT NAME,
            (CASE 
                WHEN Marks BETWEEN 0 AND 9 THEN 1
                WHEN Marks BETWEEN 10 AND 19 THEN 2
                WHEN Marks BETWEEN 20 AND 29 THEN 3
                WHEN Marks BETWEEN 30 AND 39 THEN 4
                WHEN Marks BETWEEN 40 AND 49 THEN 5
                WHEN Marks BETWEEN 50 AND 59 THEN 6
                WHEN Marks BETWEEN 60 AND 69 THEN 7
                WHEN Marks BETWEEN 70 AND 79 THEN 8
                WHEN Marks BETWEEN 80 AND 89 THEN 9
                WHEN Marks BETWEEN 90 AND 100 THEN 10
            END) AS GRADE, Marks     
FROM Students)

SELECT * 
FROM
(SELECT NAME, GRADE, MARKS
FROM tmp
WHERE GRADE >= 8
ORDER BY GRADE DESC, NAME) z
UNION ALL
SELECT *
FROM 
(SELECT NULL AS NAME, GRADE, MARKS
FROM tmp
WHERE GRADE < 8
ORDER BY Marks) z
ORDER BY GRADE DESC, NAME, Marks