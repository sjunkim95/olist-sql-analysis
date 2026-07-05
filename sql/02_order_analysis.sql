-- ==========================================
-- 1. Monthly Order Trend
-- 월별 주문량을 집계하여, 주문 추이를 확인한다.
-- ==========================================

SELECT
    SUBSTR(order_purchase_timestamp, 1, 7) AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_month
ORDER BY order_month;

-- ==========================================
-- 2. Monthly Sales Trend
-- 월별 매출을 집계하여 매출의 변화 추이를 분석한다.
-- ==========================================

SELECT
    SUBSTR(o.order_purchase_timestamp, 1, 7) AS order_month,
    SUM(oi.price) AS total_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY order_month
ORDER BY order_month;

-- ==========================================
-- 3. Order Status Analysis
-- 주문 상태를 집계하여, 주문 처리 현황을 확인한다.
-- ==========================================

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- ==========================================
-- 4. Weekly Order Trend
-- 요일별 주문량을 집계하여, 요일별 주문 패턴을 확인한다.
-- ==========================================
SELECT
    CASE
        WHEN strftime('%w', order_purchase_timestamp) = '0' THEN 'Sunday'
        WHEN strftime('%w', order_purchase_timestamp) = '1' THEN 'Monday'
        WHEN strftime('%w', order_purchase_timestamp) = '2' THEN 'Tuesday'
        WHEN strftime('%w', order_purchase_timestamp) = '3' THEN 'Wednesday'
        WHEN strftime('%w', order_purchase_timestamp) = '4' THEN 'Thursday'
        WHEN strftime('%w', order_purchase_timestamp) = '5' THEN 'Friday'
        WHEN strftime('%w', order_purchase_timestamp) = '6' THEN 'Saturday'
    END AS weekday,
    COUNT(*) AS total_orders
FROM orders
GROUP BY weekday
ORDER BY COUNT(*) DESC;

-- ==========================================
-- 5. Customer Purchase Analysis
-- 고객별 주문 횟수를 집계하여, 구매 빈도를 확인한다.
-- ==========================================

-- customer_id 기준 주문 횟수 분석
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC
LIMIT 10;


-- customer_unique_id 기준 주문 횟수 분석
SELECT
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c
ON o.customer_id = c.customer_id
GROUP BY c.customer_unique_id
ORDER BY total_orders DESC
LIMIT 10;

-- ==========================================
-- 6. Top Selling Products
-- 상품별 판매량을 집계하여, 많이 판매된 상품을 확인한다.
-- ==========================================
SELECT
    p.product_id,
    COUNT(*) AS total_sales
FROM products p
JOIN order_items oi
ON oi.product_id = p.product_id
GROUP BY p.product_id
ORDER BY total_sales DESC
LIMIT 15;

-- ==========================================
-- 7. Sales by Product Category
-- 카테고리별 판매량을 집계하여, 많이 판매된 높은 카테고리를 확인한다.
-- ==========================================
SELECT
    p.product_category_name ,
    COUNT(*) AS total_sales
FROM products p
JOIN order_items oi
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;

-- ==========================================
-- 8. Average Delivery Time
-- 평균 배송 기간을 계산하여, 주문부터 배송 완료까지 소요 시간을 확인한다.
-- ==========================================
SELECT
    AVG(
        julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)
    ) AS avg_delivery_days
FROM orders;


-- ==========================================
-- 9. Delayed Delivery Analysis
-- 배송 지연 여부를 집계하여, 배송 지연 현황을 확인한다.
-- ==========================================
SELECT
	CASE
    	WHEN order_delivered_customer_date > order_estimated_delivery_date
	    THEN 'LATE'
	    ELSE 'ON TIME'
	END AS delivery_status,
	COUNT(*) AS total_orders		
FROM orders
WHERE order_delivered_customer_date IS NOT NULL
GROUP BY delivery_status
ORDER BY delivery_status;


-- ==========================================
-- 10. Average Order Value
-- 주문별 총 구매 금액을 계산하고, 주문 1건 당 평균 구매 금액을 확인한다.
-- ==========================================
SELECT
    ROUND(AVG(order_total), 2) AS avg_order_value
FROM (
    SELECT
        order_id,
        SUM(price) AS order_total
    FROM order_items
    GROUP BY order_id
) AS order_summary;


-- ==========================================
-- 11. Sales by Product Category
-- 카테고리별 매출을 집계하여, 매출이 높은 상품 카테고리를 확인한다.
-- ==========================================
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC
LIMIT 10;


-- ==========================================
-- 12. Monthly Average Order Value
-- 월별 평균 주문 금액을 계산하여, 주문 1건당 평균 구매 금액의 변화를 확인한다.
-- ==========================================
SELECT
    monthly_total.order_month,
    ROUND(AVG(monthly_total.order_total), 2) AS avg_order_value
FROM (
    SELECT
        SUBSTR(o.order_purchase_timestamp, 1, 7) AS order_month,
        oi.order_id,
        SUM(oi.price) AS order_total
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    GROUP BY order_month, oi.order_id
) AS monthly_total
GROUP BY monthly_total.order_month
ORDER BY monthly_total.order_month;


-- ==========================================
-- 13. Repeat Customer Rate
-- 고객별 주문 횟수를 집계하여, 재구매 고객의 비율을 확인한다.
-- ==========================================
SELECT
    COUNT(*) AS total_customers,
    SUM(CASE WHEN total_orders >= 2 THEN 1 ELSE 0 END) AS repeat_customers,
    ROUND(
        SUM(CASE WHEN total_orders >= 2 THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_rate
FROM (
    SELECT
        c.customer_unique_id,
        COUNT(*) AS total_orders
    FROM customers c
    JOIN orders o
    ON o.customer_id = c.customer_id
    GROUP BY c.customer_unique_id
) AS customer_order_summary;


















