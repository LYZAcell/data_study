select * from customers;
select * from orders;
select * from products;
select * from orderdetails;

#### 지표를 설계해야 한다. 
#### 매출을 기준으로 크게 전사의 차원에서 지표를 본다. (전사 차원 : 회사 전체의 사정을 고려하다)
#### 고려할만한 지표: 총 매출 , 총 주문 수, 총 판매된 수량, 주문당 평균 매출, 주문당 평균 수량, 해당 날짜의 주문한 고객 수 
#### 항상 필요한 일자 기준 yyyyMMdd 날짜는 꼭 필요하다. ord_ymd, ord_ym 두 개의 컬럼을 만든다.

# 총매출을 주문 수량으로 나눠보자! -> 판매량을 알 수 있음
# 전체 주문(매출) 테이블
select 	
	o.orderDate, # order을 o로 별칭 붙임
    sum(od.quantityOrdered * od.priceEach) as total_revenue,## 총 매출 
    count(distinct o.orderNumber) as total_orders, 
    sum(od.quantityOrdered) as totl_quantity_sold,
    count(distinct o.customerNumber) as ditinct_customers,
    round(sum(od.quantityOrdered * od.priceEach) / count(distinct o.orderNumber), 2) as avg_order_value,
    round(sum(od.quantityOrdered) / count(distinct o.orderNumber), 2) as avg_quantity_per_order
from 
	orders as o #별칭 붙인 곳
join orderdetails od on o.orderNumber = od.orderNumber # orderdetails = od
group by o.orderDate # 그룹짓는 기준
order by 1;


#### 고객 테이블 - 마스터 테이블
#### 고객ID, 고객명, 고객의 총 주문 횟수, 고객의 주문금액, 고객의 평균 주문금액, 마지막 주문 날짜, 마지막 주문 이후 경과된 일수 , 고객 등급 (우리가 정한 고객의 등급)
#### 고객 등급 기준이 없어서 준님이 임의로 그냥 진행했음 
select 
	c.customerNumber,
    c.customerName,
    count(distinct o.orderNumber) as total_orders, 
    coalesce(sum(od.quantityOrdered * od.priceEach),0) as total_revenue, 
    coalesce(round(sum(od.quantityOrdered * od.priceEach) / nullif(count(distinct o.orderNumber), 0),2),0) as avg_order_value,
    max(o.orderDate) as last_order_date,
    datediff(curdate(), max(o.orderDate)) as day_since_last_order,
    case
		when count(distinct o.orderNumber) > 20 and sum(od.quantityOrdered * od.priceEach) > 50000 then 'VIP 고객'
        when count(distinct o.orderNumber) between 5 and 20 then '일반 고객'
		when datediff(curdate(), max(o.orderDate)) > 365 then '휴면 고객'
	end as customer_seg
from 
    customers as c # order은 위에서 o로 별칭 지정 완료. customer만 c로 지정
left join orders as o on o.customerNumber = c.customerNumber # left join으로 맨끝에
left join orderdetails as od on od.orderNumber = o.orderNumber    #od=  orderdetails
group by c.customerNumber; # 고객 정보 기준 merging
