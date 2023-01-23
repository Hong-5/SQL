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


# 2023/01/20

Q. PATIENT, DOCTOR 그리고 APPOINTMENT 테이블에서 2022년 4월 13일 취소되지 않은 흉부외과(CS) 진료 예약 내역을 조회하는 SQL문을 작성해주세요.
 진료예약번호, 환자이름, 환자번호, 진료과코드, 의사이름, 진료예약일시 항목이 출력되도록 작성해주세요. 결과는 진료예약일시를 기준으로 오름차순 정렬해주세요.

SELECT tmp.APNT_NO, PATIENT.PT_NAME, tmp.PT_NO, tmp.MCDP_CD, tmp.DR_NAME, tmp.APNT_YMD
FROM 
(SELECT APPOINTMENT.APNT_NO, APPOINTMENT.PT_NO, APPOINTMENT.MCDP_CD, DOCTOR.DR_NAME, APPOINTMENT.APNT_YMD
FROM APPOINTMENT
JOIN DOCTOR ON DOCTOR.DR_ID = APPOINTMENT.MDDR_ID
WHERE DOCTOR.MCDP_CD = 'CS' AND DATE_FORMAT(APPOINTMENT.APNT_YMD, "%Y-%m-%d") = "2022-04-13" AND APPOINTMENT.APNT_CNCL_YN = 'N') AS tmp
JOIN PATIENT ON PATIENT.PT_NO = tmp.PT_NO
ORDER BY APNT_YMD;


# 2023/01/22

Q. CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여 시작일이 2022년 9월에 속하는 대여 기록에 대해서 대여 기간이 30일 이상이면 '장기 대여' 그렇지 않으면 '단기 대여' 로 표시하는 컬럼(컬럼명: RENT_TYPE)을 추가하여 대여기록을 출력하는 SQL문을 작성해주세요.
결과는 대여 기록 ID를 기준으로 내림차순 정렬해주세요.

SELECT history_id, car_id , DATE_FORMAT(start_date, "%Y-%m-%d") AS START_DATE, 
    DATE_FORMAT(end_date, "%Y-%m-%d") AS END_DATE, 
    (CASE WHEN DATEDIFF(END_DATE, START_DATE) >= 29 THEN "장기 대여"
        ELSE "단기 대여"
    END ) AS RENT_TYPE
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
WHERE START_DATE LIKE "2022-09-%" 
ORDER BY history_id DESC;


# 2023/01/23

Q. CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블과 CAR_RENTAL_COMPANY_DISCOUNT_PLAN 테이블에서 자동차 종류가 '트럭'인 자동차의 대여 기록에 대해서 대여 기록 별로 대여 금액(컬럼명: FEE)을 구하여 대여 기록 ID와 대여 금액 리스트를 출력하는 SQL문을 작성해주세요. 
결과는 대여 금액을 기준으로 내림차순 정렬하고, 대여 금액이 같은 경우 대여 기록 ID를 기준으로 내림차순 정렬해주세요.

SELECT history_id, 
    ROUND(CASE 
        WHEN B.PERIOD < 7 THEN B.PERIOD*A.daily_fee
        WHEN B.PERIOD < 30 THEN B.PERIOD*A.daily_fee*0.95
        WHEN B.PERIOD < 90 THEN B.PERIOD*A.daily_fee*0.92
        ELSE B.PERIOD*A.daily_fee*0.85
    END, 0) AS FEE
FROM 
    (SELECT car_id, daily_fee
    FROM CAR_RENTAL_COMPANY_CAR
    WHERE car_type = "트럭") AS A
    JOIN
    (SELECT history_id, car_id, DATEDIFF(end_date, start_date) + 1 AS PERIOD
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY) AS B
ON A.car_id = B.car_id
ORDER BY FEE DESC, HISTORY_ID DESC;