{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        SALESORDERID AS order_id,
        SALESORDERDETAILID AS detail_id,
        CARRIERTRACKINGNUMBER AS carrier_tracking_number,
        ORDERQTY AS order_qty,
        PRODUCTID AS product_id,
        SPECIALOFFERID AS special_offer_id,
        UNITPRICE AS unit_price,
        UNITPRICEDISCOUNT AS unit_price_discount,
        ROWGUID AS row_guid,
        MODIFIEDDATE AS modified_date
    FROM {{ source('sap_adw', 'salesorderdetail') }}
)
SELECT
    order_id,
    detail_id,
    carrier_tracking_number,
    order_qty,
    product_id,
    special_offer_id,
    unit_price,
    unit_price_discount,
    row_guid,
    modified_date
FROM source_data