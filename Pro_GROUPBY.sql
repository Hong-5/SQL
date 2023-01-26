# 2023/01/05

SELECT NAME, COUNT(ANIMAL_ID) AS COUNT
FROM ANIMAL_INS
GROUP BY NAME
HAVING NAME IS NOT NULL AND COUNT >= 2
ORDER BY NAME;


# 2023/01/07

Q. 동물 보호소에 들어온 동물 중 고양이와 개가 각각 몇 마리인지 조회하는 SQL문을 작성해주세요. 
이때 고양이를 개보다 먼저 조회해주세요.

SELECT ANIMAL_TYPE, COUNT(ANIMAL_ID) as count
FROM ANIMAL_INS
GROUP BY ANIMAL_TYPE
ORDER BY ANIMAL_TYPE;

# 2023/01/09

Q. 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 09:00부터 19:59까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 
이때 결과는 시간대 순으로 정렬해야 합니다.

SELECT HOUR(DATETIME) AS HOUR, COUNT(*) COUNT
FROM ANIMAL_OUTS 
WHERE HOUR(DATETIME) >= 9 AND HOUR(DATETIME) <20
GROUP BY HOUR

# 2023/01/13

Q. APPOINTMENT 테이블에서 2022년 5월에 예약한 환자 수를 진료과코드 별로 조회하는 SQL문을 작성해주세요. 
이때, 컬럼명은 '진료과 코드', '5월예약건수'로 지정해주시고 결과는 진료과별 예약한 환자 수를 기준으로 오름차순 정렬하고, 예약한 환자 수가 같다면 진료과 코드를 기준으로 오름차순 정렬해주세요.

SELECT MCDP_CD AS '진료과 코드', COUNT(MDDR_ID) AS '5월예약건수'
FROM APPOINTMENT
WHERE DATE_FORMAT(APNT_YMD, '%Y-%m') = '2022-05'
GROUP BY MCDP_CD
ORDER BY 2, 1;


# 2023/01/15

Q. PRODUCT 테이블에서 만원 단위의 가격대 별로 상품 개수를 출력하는 SQL 문을 작성해주세요. 
이때 컬럼명은 각각 컬럼명은 PRICE_GROUP, PRODUCTS로 지정해주시고 가격대 정보는 각 구간의 최소금액(10,000원 이상 ~ 20,000 미만인 구간인 경우 10,000)으로 표시해주세요. 
결과는 가격대를 기준으로 오름차순 정렬해주세요.

SELECT FLOOR(PRICE / 10000) * 10000 AS PRICE_GROUP,
    COUNT(PRODUCT_ID) AS PRODUCTS
FROM PRODUCT
GROUP BY PRICE_GROUP
ORDER BY PRICE_GROUP

Q. REST_INFO 테이블에서 음식종류별로 즐겨찾기수가 가장 많은 식당의 음식 종류, ID, 식당 이름, 즐겨찾기수를 조회하는 SQL문을 작성해주세요. 
이때 결과는 음식 종류를 기준으로 내림차순 정렬해주세요.

SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES
FROM 
    (SELECT FOOD_TYPE, REST_ID, REST_NAME, FAVORITES, MAX(FAVORITES) OVER (PARTITION BY FOOD_TYPE) AS FAV
    FROM REST_INFO) AS tmp
WHERE FAVORITES = FAV
ORDER BY FOOD_TYPE DESC;

Q. 상반기 동안 각 아이스크림 성분 타입과 성분 타입에 대한 아이스크림의 총주문량을 총주문량이 작은 순서대로 조회하는 SQL 문을 작성해주세요. 
이때 총주문량을 나타내는 컬럼명은 TOTAL_ORDER로 지정해주세요.

SELECT INGREDIENT_TYPE, SUM(TOTAL_ORDER) AS TOTAL_ORDER
FROM FIRST_HALF
JOIN ICECREAM_INFO ON FIRST_HALF.FLAVOR = ICECREAM_INFO.FLAVOR
GROUP BY INGREDIENT_TYPE
ORDER BY TOTAL_ORDER;



# 2023/01/16

Q. FOOD_PRODUCT 테이블에서 식품분류별로 가격이 제일 비싼 식품의 분류, 가격, 이름을 조회하는 SQL문을 작성해주세요. 
이때 식품분류가 '과자', '국', '김치', '식용유'인 경우만 출력시켜 주시고 결과는 식품 가격을 기준으로 내림차순 정렬해주세요.

SELECT CATEGORY, MAX_PRICE, PRODUCT_NAME
FROM (SELECT PRODUCT_NAME, CATEGORY, PRICE, MAX(PRICE) OVER (PARTITION BY CATEGORY) AS MAX_PRICE
FROM FOOD_PRODUCT) AS tmp
WHERE (PRICE = MAX_PRICE) AND CATEGORY IN ('과자', '국', '김치', '식용유')
ORDER BY MAX_PRICE DESC;


# 2023/01/17

Q. 2022년 1월의 카테고리 별 도서 판매량을 합산하고, 카테고리(CATEGORY), 총 판매량(TOTAL_SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 카테고리명을 기준으로 오름차순 정렬해주세요.

SELECT BOOK.category, SUM(BOOK_SALES.SALES) AS TOTAL_SALES
FROM BOOK
JOIN BOOK_SALES ON BOOK.BOOK_ID = BOOK_SALES.BOOK_ID
WHERE SALES_DATE LIKE "2022-01-%"
GROUP BY category
ORDER BY category;


# 2023/01/18

Q. CAR_RENTAL_COMPANY_CAR 테이블에서 '통풍시트', '열선시트', '가죽시트' 중 하나 이상의 옵션이 포함된 자동차가 자동차 종류 별로 몇 대인지 출력하는 SQL문을 작성해주세요. 
이때 자동차 수에 대한 컬럼명은 CARS로 지정하고, 결과는 자동차 종류를 기준으로 오름차순 정렬해주세요.

SELECT car_type, COUNT(car_id) AS CARS
FROM CAR_RENTAL_COMPANY_CAR
WHERE (OPTIONS LIKE "%통풍시트%") or (OPTIONS LIKE "%열선시트%") or (OPTIONS LIKE "%가죽시트%")
GROUP BY car_type
ORDER BY CAR_TYPE;




# 2023/01/19

Q. USER_INFO 테이블과 ONLINE_SALE 테이블에서 년, 월, 성별 별로 상품을 구매한 회원수를 집계하는 SQL문을 작성해주세요.
결과는 년, 월, 성별을 기준으로 오름차순 정렬해주세요. 이때, 성별 정보가 없는 경우 결과에서 제외해주세요.



SELECT YEAR(B.SALES_DATE) AS YEAR, MONTH(B.SALES_DATE) AS MONTH
        , A.GENDER, COUNT(DISTINCT B.USER_ID) AS 'USERS'
FROM USER_INFO A, ONLINE_SALE B
WHERE A.USER_ID = B.USER_ID AND A.GENDER IS NOT NULL 
GROUP BY YEAR, MONTH, GENDER
ORDER BY YEAR, MONTH, GENDER;


SELECT YEAR, MONTH, GENDER, COUNT(user_id) AS USERS
FROM 
    (SELECT DISTINCT DATE_FORMAT(sales_date, "%Y") AS YEAR, DATE_FORMAT(sales_date, "%c") AS MONTH, 
            gender AS GENDER, USER_INFO.user_id
    FROM USER_INFO
    JOIN ONLINE_SALE ON USER_INFO.user_id = ONLINE_SALE.user_id
    WHERE USER_INFO.gender IS NOT NULL) AS tmp
GROUP BY YEAR, MONTH, GENDER
ORDER BY YEAR, MONTH, GENDER;



# 2023/01/23

Q. 2022년 1월의 도서 판매 데이터를 기준으로 저자 별, 카테고리 별 매출액(TOTAL_SALES = 판매량 * 판매가) 을 구하여, 저자 ID(AUTHOR_ID), 저자명(AUTHOR_NAME), 카테고리(CATEGORY), 매출액(SALES) 리스트를 출력하는 SQL문을 작성해주세요.
결과는 저자 ID를 오름차순으로, 저자 ID가 같다면 카테고리를 내림차순 정렬해주세요.

SELECT AUTHOR.AUTHOR_ID, AUTHOR.AUTHOR_NAME, T.CATEGORY, SUM(TOTAL_SALE*PRICE) AS TOTAL_SALES
FROM
    (SELECT A.book_id, A.TOTAL_SALE, B.category, B.author_id, B.PRICE
    FROM 
        (SELECT book_id, SUM(sales) AS TOTAL_SALE
        FROM BOOK_SALES
        WHERE YEAR(sales_date) = 2022 AND MONTH(sales_date) = 1
        GROUP BY book_id) as A
    JOIN BOOK AS B ON A.book_id = B.book_id) AS T
JOIN AUTHOR ON T.AUTHOR_ID = AUTHOR.AUTHOR_ID
GROUP BY AUTHOR_NAME,CATEGORY
ORDER BY AUTHOR_ID ASC, CATEGORY DESC;



# 2023/01/25

Q. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일을 기준으로 2022년 8월부터 2022년 10월까지 총 대여 횟수가 5회 이상인 자동차들에 대해서 해당 기간 동안의 월별 자동차 ID 별 총 대여 횟수(컬럼명: RECORDS) 리스트를 출력하는 SQL문을 작성해주세요. 
결과는 월을 기준으로 오름차순 정렬하고, 월이 같다면 자동차 ID를 기준으로 내림차순 정렬해주세요. 특정 월의 총 대여 횟수가 0인 경우에는 결과에서 제외해주세요.

SELECT MONTH(START_DATE) AS MONTH, CAR_ID, COUNT(HISTORY_ID) AS RECORDS
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE CAR_ID IN
    (SELECT car_id
        FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
        WHERE MONTH(start_date) IN (8,9,10)
        GROUP BY car_id
        HAVING COUNT(history_id) >= 5)# 대여 횟수가 5회 이상인 자동차
        AND MONTH(START_DATE) IN (8,9,10)
GROUP BY MONTH(START_DATE), CAR_ID
ORDER BY MONTH, CAR_ID DESC;

# 2023/01/26

Q. 보호소에서는 몇 시에 입양이 가장 활발하게 일어나는지 알아보려 합니다. 
0시부터 23시까지, 각 시간대별로 입양이 몇 건이나 발생했는지 조회하는 SQL문을 작성해주세요. 이때 결과는 시간대 순으로 정렬해야 합니다.

WITH RECURSIVE TMP AS (
    SELECT 0 AS HOUR
    UNION ALL
    SELECT HOUR + 1 FROM TMP
    WHERE HOUR <23
)

SELECT TMP.HOUR,
    (CASE 
        WHEN A.COUNT IS NULL THEN 0
        ELSE A.COUNT
    END) AS COUNT
FROM TMP
LEFT JOIN (SELECT HOUR(DATETIME) AS HOUR, COUNT(ANIMAL_ID) AS COUNT
FROM ANIMAL_OUTS
GROUP BY HOUR) AS A
ON TMP.HOUR = A.HOUR
ORDER BY HOUR;