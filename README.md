# Olist SQL Analysis

Olist Brazilian E-Commerce 데이터를 활용하여 SQL 기반의 탐색적 데이터 분석(EDA)을 수행한 프로젝트입니다.

주문, 고객, 상품, 배송 데이터를 분석하여 주요 비즈니스 지표와 데이터의 특성을 확인하였습니다.

---

# Project Information

- **Analysis Type:** Exploratory Data Analysis (EDA)
- **Language:** SQL, Python
- **Database:** SQLite
- **Environment:** DBeaver, Jupyter Notebook
- **Dataset:** Kaggle - Olist Brazilian E-Commerce Dataset

---

# Project Overview

SQL을 활용하여 주문, 고객, 상품, 배송 데이터를 분석하였습니다.

주문 추이, 매출, 고객 구매 패턴, 상품 판매량, 배송 현황 등을 분석하였으며, 이를 위해 JOIN, GROUP BY, CASE WHEN, Subquery 등을 활용하여 다양한 비즈니스 지표를 계산하였습니다.

---

# Skills Used
- JOIN
- GROUP BY
- CASE WHEN
- Subquery

---

# Project Workflow

### 1. Data Quality Check

- 결측치 및 데이터 품질 확인
- 주문 및 배송 데이터 검증

### 2. Order Analysis

- 월별 주문량 분석 (Monthly Order Trend)
- 월별 매출 분석 (Monthly Sales Trend)
- 주문 상태 분석 (Order Status Analysis)
- 요일별 주문 분석 (Weekday Order Analysis)

### 3. Customer Analysis

- 고객 구매 분석 (Customer Purchase Analysis)
- 재구매율 분석 (Repeat Customer Rate)

### 4. Product Analysis

- 상품 판매량 분석 (Product Sales Analysis)
- 카테고리별 판매량 분석 (Sales by Product Category)
- 카테고리별 매출 분석 (Revenue by Product Category)
- 평균 주문 금액 분석 (Average Order Value)

### 5. Delivery Analysis

- 평균 배송 기간 분석 (Average Delivery Days)
- 배송 지연 분석 (Delayed Delivery Analysis)

---

# Business Insights

- 월별 주문량과 매출은 전반적으로 증가하는 추세를 보였다.
- 판매량과 매출의 상위 카테고리가 다르게 나타나, 판매량만으로는 매출을 설명하기 어려운 것을 확인하였다.
- 생활용품(cama_mesa_banho) 카테고리가 가장 높은 판매량을 기록한 반면, 뷰티·건강(beleza_saude) 카테고리가 가장 높은 매출을 기록하였다.
- 대부분의 주문은 예정된 배송일 이전 또는 예정일에 배송되어 배송 서비스가 전반적으로 안정적인 수준을 유지하였다.
- 평균 주문 금액(Average Order Value)은 약 **137.76**으로 확인되었다.
- 전체 고객 중 약 **3.12%**만이 재구매 고객으로 확인되어 고객 유지(Customer Retention) 측면에서 개선 가능성이 있음을 확인하였다.

---

# Conclusion

이번 프로젝트에서는 SQL을 활용하여 주문, 고객, 상품, 배송 데이터를 분석하였습니다.

데이터 품질을 확인한 후 주문 추이, 매출, 고객 구매 패턴, 상품 판매량, 배송 현황 등을 분석하였으며, 이를 통해 주문, 고객, 상품, 배송 관점에서 데이터의 특성과 주요 지표를 확인하였습니다.

또한 판매량과 매출의 카테고리 순위가 다르게 나타나 상품 가격이 매출에 영향을 미칠 수 있음을 확인하였으며, 전체 고객 중 약 **3.12%**만이 재구매 고객으로 나타나 고객 유지 측면에서 개선 가능성이 있음을 확인하였습니다.

향후에는 고객 세분화(RFM), 지역별 배송 분석, 고객별 구매 행동 분석 등을 통해 보다 다양한 비즈니스 인사이트를 도출해보고자 합니다.

---

# Learned

이번 프로젝트를 통해 SQL의 JOIN, GROUP BY, CASE WHEN, Subquery 등을 활용한 데이터 분석 과정을 경험하였습니다.

특히 데이터 구조를 이해하고 적절한 집계 기준을 설정하여 원하는 결과를 도출하는 과정을 학습하였습니다.
