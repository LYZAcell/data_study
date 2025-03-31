#### 필수과제 1
#### 위의 2개의 마트 쿼리를 검증해 주세요.
#### 명확한 검증 로직을 작성하고 -> 해당 값을 검증할 수 있는 코드와 함께 정리해서 주세요.
#### 둘 다 모두 검증해야 하고 예시는 최소 2개 이상씩 해야 합니다. - 총 최소 4개 이상 진행

# 1. 특정 날짜 매출합과 개별 주문합의 일치 확인
SELECT 
    o.orderDate,
    SUM(od.quantityOrdered * od.priceEach) AS expected_total_revenue,
    (SELECT total_revenue 
     FROM (
         SELECT o.orderDate, SUM(od.quantityOrdered * od.priceEach) AS total_revenue
         FROM orders AS o
         JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
         GROUP BY o.orderDate
     ) AS revenue_summary
     WHERE orderDate = '2004-11-25'  -- YYYY-MM-DD 형식으로 입력
    ) AS calculated_total_revenue
FROM orders AS o
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
WHERE o.orderDate = '2004-11-25'  -- YYYY-MM-DD 형식으로 입력
GROUP BY o.orderDate;

#2. 주문당 평균매출 _ total_revenue와 total_orders 검증
-- 검증: 주문당 평균 매출 비교
SELECT 
    STR_TO_DATE(o.orderDate, '%Y-%m-%d') AS orderDate,
    SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber) AS expected_avg_order_value,
    (SELECT avg_order_value
     FROM (
         SELECT STR_TO_DATE(o.orderDate, '%Y-%m-%d') AS orderDate, 
                ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_order_value
         FROM orders AS o
         JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
         GROUP BY orderDate
     ) AS order_avg
     WHERE orderDate = STR_TO_DATE('YYYY-MM-DD', '%Y-%m-%d')
    ) AS calculated_avg_order_value
FROM orders AS o
JOIN orderdetails AS od ON o.orderNumber = od.orderNumber
WHERE STR_TO_DATE(o.orderDate, '%Y-%m-%d') = STR_TO_DATE('YYYY-MM-DD', '%Y-%m-%d')
GROUP BY orderDate;

#검증 3. 특정 고객의 총주문 횟수와 실제 주문 수 비교
-- 검증: 특정 고객의 총 주문 횟수 비교
SELECT 
    c.customerNumber, 
    COUNT(DISTINCT o.orderNumber) AS expected_total_orders,
    (SELECT total_orders 
     FROM (
         SELECT c.customerNumber, COUNT(DISTINCT o.orderNumber) AS total_orders
         FROM customers AS c
         LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
         GROUP BY c.customerNumber
     ) AS customer_order_summary
     WHERE customerNumber = 103
    ) AS calculated_total_orders
FROM customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
WHERE c.customerNumber = 103
GROUP BY c.customerNumber;


# 검증4. 고객등급 검증
-- 검증: 특정 고객이 VIP 고객인지 확인 _ 주문수로 등급 검증 
SELECT 
    c.customerNumber,
    COUNT(DISTINCT o.orderNumber) AS total_orders,
    SUM(od.quantityOrdered * od.priceEach) AS total_revenue,
    CASE 
        WHEN COUNT(DISTINCT o.orderNumber) > 20 AND SUM(od.quantityOrdered * od.priceEach) > 50000 THEN 'VIP 고객'
        WHEN COUNT(DISTINCT o.orderNumber) BETWEEN 5 AND 20 THEN '일반 고객'
        WHEN DATEDIFF(CURDATE(), MAX(o.orderDate)) > 365 THEN '휴면 고객'
    END AS expected_customer_seg,
    (SELECT customer_seg 
     FROM (
         SELECT c.customerNumber, 
                CASE 
                    WHEN COUNT(DISTINCT o.orderNumber) > 20 AND SUM(od.quantityOrdered * od.priceEach) > 50000 THEN 'VIP 고객'
                    WHEN COUNT(DISTINCT o.orderNumber) BETWEEN 5 AND 20 THEN '일반 고객'
                    WHEN DATEDIFF(CURDATE(), MAX(o.orderDate)) > 365 THEN '휴면 고객'
                END AS customer_seg
         FROM customers AS c
         LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
         LEFT JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
         GROUP BY c.customerNumber
     ) AS customer_segment_summary
     WHERE customer_segment_summary.customerNumber = c.customerNumber  -- ✅ 수정된 부분
    ) AS calculated_customer_seg
FROM customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
LEFT JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
GROUP BY c.customerNumber;
