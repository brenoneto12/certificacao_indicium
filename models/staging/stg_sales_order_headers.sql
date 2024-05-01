{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        SALESORDERID AS order_id,
        REVISIONNUMBER AS revision_number,
        ORDERDATE AS order_date,
        DUEDATE AS due_date,
        SHIPDATE AS ship_date,
        STATUS,
        ONLINEORDERFLAG AS online_order_flag,
        PURCHASEORDERNUMBER AS purchase_order_number,
        ACCOUNTNUMBER,  -- Verificado anteriormente
        CUSTOMERID AS customer_id,
        SALESPERSONID AS salesperson_id,
        TERRITORYID AS territory_id,
        BILLTOADDRESSID AS bill_to_address_id,
        SHIPTOADDRESSID AS ship_to_address_id,
        SHIPMETHODID AS ship_method_id,
        CREDITCARDID AS "credit_card_id",
        CREDITCARDAPPROVALCODE AS "credit_card_approval_code",
        CURRENCYRATEID AS currency_rate_id,
        SUBTOTAL,
        TAXAMT AS tax_amt,
        FREIGHT,
        TOTALDUE AS total_due,
        COMMENT,
        ROWGUID AS row_guid,
        MODIFIEDDATE AS modified_date
    FROM EQUATORIAL.SAP_ADW.salesorderheader
)
SELECT
    order_id,
    revision_number,
    order_date,
    due_date,
    ship_date,
    status,
    online_order_flag,
    purchase_order_number,
    ACCOUNTNUMBER,
    customer_id,
    salesperson_id,
    territory_id,
    bill_to_address_id,
    ship_to_address_id,
    ship_method_id,
    "credit_card_id",
    "credit_card_approval_code",
    currency_rate_id,
    subtotal,
    tax_amt,
    freight,
    total_due,
    comment,
    row_guid,
    modified_date
FROM source_data