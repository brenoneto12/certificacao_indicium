-- models/stg/stg_sales.sql

{{ config(materialized='view') }}

SELECT
    sales_order_id,
    order_date,
    customer_id,
    product_id,
    order_qty,
    unit_price,
    (unit_price * order_qty) * (1 - unit_discount) as total_price
FROM {{ source('sap_raw', 'sales_order_detail') }}