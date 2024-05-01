
{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        PRODUCTID AS product_id,
        NAME AS product_name,
        PRODUCTNUMBER,
        MAKEFLAG,
        FINISHEDGOODSFLAG,
        COLOR,
        SAFETYSTOCKLEVEL,
        REORDERPOINT,
        STANDARDCOST,
        LISTPRICE,
        SIZE,
        SIZEUNITMEASURECODE,
        WEIGHTUNITMEASURECODE,
        WEIGHT,
        DAYSTOMANUFACTURE,
        PRODUCTLINE,
        CLASS,
        STYLE,
        PRODUCTSUBCATEGORYID,
        PRODUCTMODELID,
        SELLSTARTDATE,
        SELLENDDATE,
        DISCONTINUEDDATE,
        ROWGUID AS row_guid,
        MODIFIEDDATE AS modified_date
    FROM {{ source('sap_adw', 'product') }}
)
SELECT * FROM source_data