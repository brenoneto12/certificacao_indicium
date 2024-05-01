
{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        BUSINESSENTITYID AS person_id,
        PERSONTYPE,
        NAMESTYLE,
        TITLE,
        FIRSTNAME AS first_name,
        MIDDLENAME AS middle_name,
        LASTNAME AS last_name,
        SUFFIX,
        EMAILPROMOTION AS email_promotion,
        ADDITIONALCONTACTINFO,
        DEMOGRAPHICS,
        ROWGUID AS row_guid,
        MODIFIEDDATE AS modified_date
    FROM {{ source('sap_adw', 'person') }}
)
SELECT * FROM source_data