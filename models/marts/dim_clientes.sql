{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        customerid AS id_cliente,
        personid AS id_pessoa,
        storeid AS id_loja,
        territoryid AS id_territorio,
        rowguid AS guid_linha,
        modifieddate AS data_modificacao,
        ROW_NUMBER() OVER (PARTITION BY customerid ORDER BY modifieddate DESC) AS rn
    FROM EQUATORIAL.SAP_ADW.CUSTOMER
)
SELECT
    MD5(id_cliente || data_modificacao) AS sk_clientes,
    id_cliente,
    id_pessoa,
    id_loja,
    id_territorio,
    guid_linha,
    data_modificacao
FROM source_data
WHERE rn = 1