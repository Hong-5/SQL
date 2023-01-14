# 2023/01/05

SELECT ANIMAL_ID, NAME
FROM ANIMAL_INS
WHERE NAME LIKE "%el%" AND ANIMAL_TYPE = 'Dog'
ORDER BY NAME;

# 2023/01/07

Q. ANIMAL_INS 테이블에 등록된 모든 레코드에 대해, 각 동물의 아이디와 이름, 들어온 날짜1를 조회하는 SQL문을 작성해주세요. 
이때 결과는 아이디 순으로 조회해야 합니다.

SELECT ANIMAL_ID, NAME, LEFT(DATETIME, 10) as 날짜
FROM ANIMAL_INS
ORDER BY ANIMAL_ID;



Q. 보호소의 동물이 중성화되었는지 아닌지 파악하려 합니다. 중성화된 동물은 SEX_UPON_INTAKE 컬럼에 'Neutered' 또는 'Spayed'라는 단어가 들어있습니다. 
동물의 아이디와 이름, 중성화 여부를 아이디 순으로 조회하는 SQL문을 작성해주세요. 이때 중성화가 되어있다면 'O', 아니라면 'X'라고 표시해주세요.

SELECT ANIMAL_ID, NAME,
    (CASE 
        WHEN SEX_UPON_INTAKE LIKE "Neutered %" THEN "O"
        WHEN SEX_UPON_INTAKE LIKE "Spayed %" THEN "O"
        ELSE "X"
     END
    ) as 중성화
FROM ANIMAL_INS
ORDER BY ANIMAL_ID


# 2023/01/10

Q. 입양을 간 동물 중, 보호 기간이 가장 길었던 동물 두 마리의 아이디와 이름을 조회하는 SQL문을 작성해주세요. 
이때 결과는 보호 기간이 긴 순으로 조회해야 합니다.

SELECT ANIMAL_OUTS.ANIMAL_ID, ANIMAL_OUTS.NAME
FROM ANIMAL_OUTS
JOIN ANIMAL_INS ON ANIMAL_OUTS.ANIMAL_ID = ANIMAL_INS.ANIMAL_ID
ORDER BY ANIMAL_OUTS.DATETIME - ANIMAL_INS.DATETIME DESC
LIMIT 2;

# 2023/01/11

Q. PRODUCT 테이블에서 상품 카테고리 코드(PRODUCT_CODE 앞 2자리) 별 상품 개수를 출력하는 SQL문을 작성해주세요.
결과는 상품 카테고리 코드를 기준으로 오름차순 정렬해주세요.

SELECT LEFT(PRODUCT_CODE,2) AS CATEGORY, COUNT(PRODUCT_ID) AS PRODUCTS
FROM PRODUCT
GROUP BY CATEGORY;


Q. 동물 보호소에 들어온 동물 중 이름이 Lucy, Ella, Pickle, Rogan, Sabrina, Mitty인 동물의 아이디와 이름, 성별 및 중성화 여부를 조회하는 SQL 문을 작성해주세요.

SELECT ANIMAL_ID, NAME, SEX_UPON_INTAKE
FROM ANIMAL_INS
WHERE NAME IN ('Lucy', 'Ella', 'Pickle', 'Rogan', 'Sabrina', 'Mitty');


# 2023/01/14

Q. FOOD_ORDER 테이블에서 5월 1일을 기준으로 주문 ID, 제품 ID, 출고일자, 출고여부를 조회하는 SQL문을 작성해주세요. 
출고여부는 5월 1일까지 출고완료로 이 후 날짜는 출고 대기로 미정이면 출고미정으로 출력해주시고, 결과는 주문 ID를 기준으로 오름차순 정렬해주세요.

SELECT ORDER_ID, PRODUCT_ID, DATE_FORMAT(OUT_DATE, "%Y-%m-%d") AS 'OUT_DATE',
    (CASE 
        WHEN OUT_DATE >= "2022-05-11" THEN "출고대기"
        WHEN OUT_DATE IS NULL THEN "출고미정"
        WHEN OUT_DATE < "2022-05-11" THEN "출고완료"
    END)
    AS "출고여부" 
FROM FOOD_ORDER
ORDER BY ORDER_ID;