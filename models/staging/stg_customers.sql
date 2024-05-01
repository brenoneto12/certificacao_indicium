
{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        CUSTOMERID AS customer_id,
        PERSONID AS person_id,
        STOREID AS store_id,
        TERRITORYID AS territory_id,
        ROWGUID AS row_guid,
        MODIFIEDDATE AS modified_date
    FROM {{ source('sap_adw', 'customer') }}
)
SELECT * FROM source_data