-- 01_data_quality.sql
-- Data Quality Check
-- 데이터가 분석 가능한 상태인지 검증한다

-- ==========================================
-- 1. Row Count
-- 각 테이블의 데이터 개수(Row)를 확인한다.
-- 데이터가 정상적으로 로드되었는지 검증한다.
-- ==========================================

SELECT COUNT(*) AS total_orders FROM orders;
SELECT COUNT(*) AS total_customers FROM customers;
SELECT COUNT(*) AS total_order_items FROM order_items;
SELECT COUNT(*) AS total_products FROM products;

-- ==========================================
-- 2. Missing Values
-- 각 테이블의 결측치(Null)를 확인한다.
-- 데이터 전처리가 필요한 컬럼을 파악한다.
-- ==========================================

-- orders 테이블 결측치
SELECT
    SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN order_status IS NULL OR order_status = '' THEN 1 ELSE 0 END) AS missing_order_status,
    SUM(CASE WHEN order_purchase_timestamp IS NULL OR order_purchase_timestamp = '' THEN 1 ELSE 0 END) AS missing_purchase_timestamp,
    SUM(CASE WHEN order_approved_at IS NULL OR order_approved_at = '' THEN 1 ELSE 0 END) AS missing_order_approved_at,
    SUM(CASE WHEN order_delivered_carrier_date IS NULL OR order_delivered_carrier_date = '' THEN 1 ELSE 0 END) AS missing_carrier_date,
    SUM(CASE WHEN order_delivered_customer_date IS NULL OR order_delivered_customer_date = '' THEN 1 ELSE 0 END) AS missing_customer_date,
    SUM(CASE WHEN order_estimated_delivery_date IS NULL OR order_estimated_delivery_date = '' THEN 1 ELSE 0 END) AS missing_estimated_delivery_date
FROM orders;

-- customers 테이블 결측치
SELECT
    SUM(CASE WHEN customer_id IS NULL OR customer_id = '' THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN customer_unique_id IS NULL OR customer_unique_id = '' THEN 1 ELSE 0 END) AS missing_customer_unique_id,
    SUM(CASE WHEN customer_zip_code_prefix IS NULL THEN 1 ELSE 0 END) AS missing_zip,
    SUM(CASE WHEN customer_city IS NULL OR customer_city = '' THEN 1 ELSE 0 END) AS missing_city,
    SUM(CASE WHEN customer_state IS NULL OR customer_state = '' THEN 1 ELSE 0 END) AS missing_state
FROM customers;

-- order_items 테이블 결측치
SELECT
    SUM(CASE WHEN order_id IS NULL OR order_id = '' THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_item_id IS NULL THEN 1 ELSE 0 END) AS missing_order_item_id,
    SUM(CASE WHEN product_id IS NULL OR product_id = '' THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN seller_id IS NULL OR seller_id = '' THEN 1 ELSE 0 END) AS missing_seller_id,
    SUM(CASE WHEN shipping_limit_date IS NULL OR shipping_limit_date = '' THEN 1 ELSE 0 END) AS missing_shipping_limit_date,
    SUM(CASE WHEN price IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN freight_value IS NULL THEN 1 ELSE 0 END) AS missing_freight_value
FROM order_items;

-- products 테이블 결측치
SELECT
    SUM(CASE WHEN product_id IS NULL OR product_id = '' THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN product_category_name IS NULL OR product_category_name = '' THEN 1 ELSE 0 END) AS missing_product_category_name,
    SUM(CASE WHEN product_name_lenght IS NULL THEN 1 ELSE 0 END) AS missing_product_name_lenght,
    SUM(CASE WHEN product_description_lenght IS NULL THEN 1 ELSE 0 END) AS missing_product_description_lenght,
    SUM(CASE WHEN product_photos_qty IS NULL THEN 1 ELSE 0 END) AS missing_product_photos_qty,
    SUM(CASE WHEN product_weight_g IS NULL THEN 1 ELSE 0 END) AS missing_product_weight_g,
    SUM(CASE WHEN product_length_cm IS NULL THEN 1 ELSE 0 END) AS missing_product_length_cm,
    SUM(CASE WHEN product_height_cm IS NULL THEN 1 ELSE 0 END) AS missing_product_height_cm,
    SUM(CASE WHEN product_width_cm IS NULL THEN 1 ELSE 0 END) AS missing_product_width_cm
FROM products;

-- ==========================================
-- 3. Duplicate Check
-- Primary Key로 사용할 컬럼의 중복 여부를 확인한다.
-- 테이블별 고유 식별자가 정상적으로 관리되는지 확인한다.
-- ==========================================

-- orders 테이블 중복 확인
SELECT
    COUNT(*) AS total_orders,
    COUNT(DISTINCT order_id) AS unique_orders
FROM orders;

-- customers 테이블 중복 확인
SELECT
    COUNT(*) AS total_customers,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM customers;

-- order_items 테이블 중복 확인
SELECT
    COUNT(*) AS total_order_items,
    COUNT(DISTINCT order_id || '-' || order_item_id) AS unique_order_items
FROM order_items;

-- products 테이블 중복 확인
SELECT
    COUNT(*) AS total_products,
    COUNT(DISTINCT product_id) AS unique_products
FROM products;

-- 전체 행 수와 고유 식별자 수를 비교하여 PK 후보 컬럼의 중복 여부를 확인하였다.
-- 중복이 없으며 해당 PK로 사용할 수 있음을 확인하였다.

-- ==========================================
-- 4. Order Status
-- 주문 상태별 주문 건수를 확인한다.
-- 주문 처리 현황과 주문 상태의 분포를 파악한다.
-- ==========================================

SELECT
    order_status,
    COUNT(*) AS order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- ==========================================
-- 5. Date Range
-- 주문 데이터의 분석 기간을 파악하기 위해 시작일과 종료일을 확인한다.
-- ==========================================
SELECT
    MIN(order_purchase_timestamp) AS start_date,
    MAX(order_purchase_timestamp) AS end_date
FROM orders;

