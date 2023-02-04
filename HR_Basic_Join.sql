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

# 2023/02/02

-- Q. Harry Potter and his friends are at Ollivander's with Ron, finally replacing Charlie's old broken wand. 
-- Hermione decides the best way to choose is by determining the minimum number of gold galleons needed to buy each non-evil wand of high power and age. 
-- Write a query to print the id, age, coins_needed, and power of the wands that Ron's interested in, sorted in order of descending power. 
-- If more than one wand has same power, sort the result in order of descending age.

-- 이렇게 서브쿼리로 group by 하지 않고도 하는 방법이 있었다!

SELECT  W.ID, P.AGE, W.COINS_NEEDED, W.POWER
FROM WANDS W
JOIN WANDS_PROPERTY P ON W.CODE = P.CODE
WHERE P.IS_EVIL = 0
AND W.COINS_NEEDED = 
    (SELECT MIN(W1.COINS_NEEDED)
    FROM WANDS W1
    JOIN WANDS_PROPERTY P1 ON W1.CODE = P1.CODE
    WHERE P.IS_EVIL = 0
    AND W.POWER = W1.POWER
    AND P.AGE = P1.AGE)
ORDER BY POWER DESC, AGE DESC;



-- Q. Julia just finished conducting a coding contest, and she needs your help assembling the leaderboard! 
-- Write a query to print the respective hacker_id and name of hackers who achieved full scores for more than one challenge. 
-- Order your output in descending order by the total number of challenges in which the hacker earned a full score. 
-- If more than one hacker received full scores in same number of challenges, then sort them by ascending hacker_id.

SELECT H.hacker_id, H.name
FROM Submissions S
JOIN Challenges C ON S.challenge_id = C.challenge_id
JOIN Difficulty D ON C.difficulty_level = D.difficulty_level
JOIN Hackers H ON S.hacker_id = H.hacker_id
WHERE S.score = D.score
GROUP BY H.hacker_id, H.name
HAVING COUNT(H.hacker_id) > 1
ORDER BY COUNT(H.hacker_id) DESC, H.hacker_id


-- Q. Julia asked her students to create some coding challenges. Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
-- Sort your results by the total number of challenges in descending order. If more than one student created the same number of challenges, then sort the result by hacker_id. 
-- If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

SELECT H3.hacker_id, H3.name, COUNT(C3.challenge_id) AS COUNT_NUM
FROM HACKERS H3
JOIN Challenges C3 ON H3.hacker_id = C3.hacker_id
GROUP BY H3.hacker_id, H3.name
HAVING COUNT_NUM IN
    ((SELECT COUNT_NUM
    FROM
        (SELECT H.hacker_id, H.name, COUNT(C.challenge_id) AS COUNT_NUM
        FROM HACKERS H
        JOIN Challenges C ON H.hacker_id = C.hacker_id
        GROUP BY H.hacker_id, H.name
        ORDER BY COUNT_NUM DESC, H.hacker_id) as tmp
    GROUP BY COUNT_NUM
    HAVING COUNT(tmp.hacker_id) = 1)
    UNION ALL
    (SELECT MAX(COUNT_NUM)
    FROM 
        (SELECT COUNT(C2.challenge_id) AS COUNT_NUM
        FROM HACKERS H1
        JOIN Challenges C2 ON H1.hacker_id = C2.hacker_id
        GROUP BY H1.hacker_id, H1.name) AS tmp1))
ORDER BY COUNT_NUM DESC, H3.hacker_id;


# 2023/02/04

-- Q. Julia asked her students to create some coding challenges. 
-- Write a query to print the hacker_id, name, and the total number of challenges created by each student. 
-- Sort your results by the total number of challenges in descending order. 
-- If more than one student created the same number of challenges, then sort the result by hacker_id. 
-- If more than one student created the same number of challenges and the count is less than the maximum number of challenges created, then exclude those students from the result.

SELECT H.hacker_id, H.name, COUNT(challenge_id) AS COUNT
FROM Hackers H
JOIN Challenges C ON H.hacker_id = C.hacker_id
GROUP BY H.hacker_id, H.name
HAVING COUNT IN 
(
        (SELECT COUNT
    FROM
        (SELECT H.hacker_id, H.name, COUNT(challenge_id) AS COUNT
        FROM Hackers H
        JOIN Challenges C ON H.hacker_id = C.hacker_id
        GROUP BY H.hacker_id, H.name) AS tmp
    GROUP BY COUNT
    HAVING COUNT(hacker_id) = 1)
    UNION ALL
    (SELECT MAX(COUNT) AS COUNT
    FROM
        (SELECT COUNT(challenge_id) AS COUNT
        FROM Hackers H
        JOIN Challenges C ON H.hacker_id = C.hacker_id
        GROUP BY H.hacker_id, H.name) AS tmp1)
)
ORDER BY COUNT DESC, H.hacker_id;


-- Q. You did such a great job helping Julia with her last coding contest challenge that she wants you to work on this one, too!
-- The total score of a hacker is the sum of their maximum scores for all of the challenges. 
-- Write a query to print the hacker_id, name, and total score of the hackers ordered by the descending score. 
-- If more than one hacker achieved the same total score, then sort the result by ascending hacker_id. 
-- Exclude all hackers with a total score of  from your result.

SELECT H.hacker_id, H.name, SUM(MAX_SOCRE) AS FINAL_SCORE
FROM 
(SELECT S.hacker_id, S.challenge_id, MAX(score) AS MAX_SOCRE
FROM Submissions S
GROUP BY S.hacker_id, S.challenge_id) AS TMP
JOIN Hackers H ON TMP.hacker_id = H.hacker_id
GROUP BY H.hacker_id, H.name
HAVING FINAL_SCORE > 0
ORDER BY FINAL_SCORE DESC, hacker_id;
