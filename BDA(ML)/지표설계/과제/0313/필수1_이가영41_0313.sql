# 전주문 테이블 날짜 검증
SELECT 
    o.orderDate,
    SUM(od.quantityOrdered * od.priceEach) AS calculated_total_revenue,
    COUNT(DISTINCT o.orderNumber) AS calculated_total_orders,
    SUM(od.quantityOrdered) AS calculated_total_quantity_sold,
    COUNT(DISTINCT o.customerNumber) AS calculated_distinct_customers,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS calculated_avg_order_value,
    ROUND(SUM(od.quantityOrdered) / COUNT(DISTINCT o.orderNumber), 2) AS calculated_avg_quantity_per_order
FROM 
    orders AS o
JOIN 
    orderdetails AS od ON o.orderNumber = od.orderNumber
WHERE 
    o.orderDate = '2003-01-06'
GROUP BY 
    o.orderDate;

# 고객테이블 검증 : 103번 고객 검증
SELECT 
    c.customerNumber,
    c.customerName,
    COUNT(DISTINCT o.orderNumber) AS calculated_total_orders,
    COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) AS calculated_total_revenue,
    COALESCE(ROUND(SUM(od.quantityOrdered * od.priceEach) / NULLIF(COUNT(DISTINCT o.orderNumber), 0), 2), 0) AS calculated_avg_order_value,
    MAX(o.orderDate) AS calculated_last_order_date,
    DATEDIFF(CURDATE(), MAX(o.orderDate)) AS calculated_day_since_last_order,
    CASE
        WHEN COUNT(DISTINCT o.orderNumber) > 20 AND SUM(od.quantityOrdered * od.priceEach) > 50000 THEN 'VIP 고객'
        WHEN COUNT(DISTINCT o.orderNumber) BETWEEN 5 AND 20 THEN '일반 고객'
        WHEN DATEDIFF(CURDATE(), MAX(o.orderDate)) > 365 THEN '휴면 고객'
    END AS calculated_customer_seg
FROM 
    customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
LEFT JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
WHERE 
    c.customerNumber = 103
GROUP BY 
    c.customerNumber;
