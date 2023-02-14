# 2023/01/27

Q. Query all columns for all American cities in the CITY table with populations larger than 100000. 
The CountryCode for America is USA.

SELECT *
FROM CITY
WHERE CountryCode = 'USA' AND POPULATION >= 100000

Q. Query the NAME field for all American cities in the CITY table with populations larger than 120000. 
The CountryCode for America is USA.

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = 'USA' AND POPULATION >= 120000

Q. Query all columns (attributes) for every row in the CITY table.

SELECT *
FROM CITY


Q. Query all columns for a city in CITY with the ID 1661.

SELECT *
FROM CITY
WHERE ID = 1661


Q. Query all attributes of every Japanese city in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT *
FROM CITY
WHERE COUNTRYCODE = "JPN"

Q. Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

SELECT NAME
FROM CITY
WHERE COUNTRYCODE = "JPN"

Q. Query a list of CITY and STATE from the STATION table.

SELECT CITY, STATE
FROM STATION


Q. Query a list of CITY names from STATION for cities that have an even ID number.
Print the results in any order, but exclude duplicates from the answer.

SELECT DISTINCT CITY
FROM STATION
WHERE ID % 2 = 0

Q. Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

SELECT COUNT(CITY) - COUNT(DISTINCT CITY)
FROM STATION


# 2023/01/28

Q. Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
When ordered alphabetically, the CITY names are listed as ABC, DEF, PQRS, and WXY, with lengths  and . The longest name is PQRS, but there are  options for shortest named city. 
Choose ABC, because it comes first alphabetically.

    (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY), CITY
    LIMIT 1)
UNION ALL (SELECT CITY, LENGTH(CITY)
    FROM STATION
    ORDER BY LENGTH(CITY) DESC, CITY
    LIMIT 1)


Q. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ("a", "e", "i", "o", "u")

Q. Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. 
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) in ("a", 'e', 'i', 'o', 'u') 
    and RIGHT(CITY, 1) in ("a", 'e', 'i', 'o', 'u')


Q. Query the list of CITY names from STATION that do not start with vowels. 
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ("a", 'e', 'i', 'o', 'u')

Q. Query the list of CITY names from STATION that do not end with vowels. 
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE RIGHT(CITY, 1) NOT IN ("a", 'e', 'i', 'o', 'u')

Q. Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. 
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ("a", 'e', 'i', 'o', 'u') 
    or RIGHT(CITY, 1) NOT IN ("a", 'e', 'i', 'o', 'u')


Q. Query the list of CITY names from STATION that do not start with vowels and do not end with vowels.
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY, 1) NOT IN ("a", 'e', 'i', 'o', 'u') 
    and RIGHT(CITY, 1) NOT IN ("a", 'e', 'i', 'o', 'u')

# 2023/01/31

Q. Query the Name of any student in STUDENTS who scored higher than 75  Marks.Order your output by the last three characters of each name. 
If two or more students both have names ending in the same last three characters (i.e.: Bobby, Robby, etc.), secondary sort them by ascending ID.

SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID

Q. Write a query that prints a list of employee names (i.e.: the name attribute) from the Employee table in alphabetical order.

SELECT name
FROM Employee
ORDER BY name

Q. Write a query that prints a list of employee names (i.e.: the name attribute) for employees in Employee having a salary greater than  per month who have been employees for less than  months. 
Sort your result by ascending employee_id.

SELECT NAME
FROM Employee
WHERE MONTHS < 10 AND SALARY > 2000
ORDER BY employee_id;

Q. Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. 
Your result cannot contain duplicates.

SELECT DISTINCT CITY
FROM STATION
WHERE LEFT(CITY,1) IN ("a", "e", "i", "o", "u")

