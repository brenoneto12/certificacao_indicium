-- models/stg/stg_customers.sql

{{ config(materialized='view') }}

SELECT
    customer_id,
    first_name || ' ' || last_name as full_name,
    email_address,
    phone
FROM {{ source('sap_raw', 'customers') }}