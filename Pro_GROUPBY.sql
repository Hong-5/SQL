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