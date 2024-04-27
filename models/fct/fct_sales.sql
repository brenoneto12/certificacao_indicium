-- models/fct/fct_sales.sql

{{ config(materialized='table') }}

SELECT
    sales_order_id,
    order_date,
    customer_id,
    SUM(total_price) as total_revenue
FROM {{ ref('stg_sales') }}
GROUP BY 1, 2, 3