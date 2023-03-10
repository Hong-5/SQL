# 2023/02/16

SELECT 
    (CASE 
        WHEN (A = B) AND (B = C) THEN 'Equilateral'
        WHEN (A+B <= C) OR (A+C <= B) OR (B+C <= A) THEN 'Not A Triangle'
        WHEN (A = B) OR (B = C) OR (A = C) THEN 'Isosceles'
        ELSE 'Scalene' 
    END) AS ANSWER
FROM TRIANGLES 


SELECT CONCAT(NAME, '(', LEFT(OCCUPATION,1), ')')
FROM OCCUPATIONS
ORDER BY NAME;
SELECT CONCAT('There are a total of ', COUNT(OCCUPATION), ' ', LOWER(OCCUPATION), 's.')
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY COUNT(OCCUPATION), OCCUPATION;
