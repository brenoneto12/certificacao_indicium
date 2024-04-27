-- models/dim/dim_customers.sql

{{ config(materialized='table') }}

SELECT
    customer_id,
    full_name,
    email_address,
    phone,
    MIN(order_date) as first_purchase_date
FROM {{ ref('stg_customers') }}
JOIN {{ ref('stg_sales') }} ON stg_customers.customer_id = stg_sales.customer_id
GROUP BY 1, 2, 3, 4