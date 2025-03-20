# 주문횟수 및 주문일자, 총매출로 고객 구분

SELECT 
    c.customerNumber,
    c.customerName,
    COUNT(DISTINCT o.orderNumber) AS total_orders,
    COALESCE(SUM(od.quantityOrdered * od.priceEach), 0) AS total_revenue,
    COALESCE(ROUND(SUM(od.quantityOrdered * od.priceEach) / NULLIF(COUNT(DISTINCT o.orderNumber), 0), 2), 0) AS avg_order_value,
    MAX(o.orderDate) AS last_order_date,
    DATEDIFF(CURDATE(), MAX(o.orderDate)) AS day_since_last_order,
    CASE
        WHEN COUNT(DISTINCT o.orderNumber) > 30 AND SUM(od.quantityOrdered * od.priceEach) > 100000 THEN 'VIP 고객'
        WHEN COUNT(DISTINCT o.orderNumber) BETWEEN 20 AND 30 AND SUM(od.quantityOrdered * od.priceEach) > 50000 THEN '우수 고객'
        WHEN COUNT(DISTINCT o.orderNumber) BETWEEN 5 AND 19 THEN '일반 고객'
        WHEN COUNT(DISTINCT o.orderNumber) BETWEEN 1 AND 4 THEN '신규 고객'
        WHEN DATEDIFF(CURDATE(), MAX(o.orderDate)) > 365 THEN '휴면 고객'
    END AS customer_seg
FROM 
    customers AS c
LEFT JOIN orders AS o ON o.customerNumber = c.customerNumber
LEFT JOIN orderdetails AS od ON od.orderNumber = o.orderNumber
GROUP BY 
    c.customerNumber;
