{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        BUSINESSENTITYID AS person_id,
        PERSONTYPE AS tipo_pessoa,
        NAMESTYLE AS estilo_nome,
        TITLE AS titulo,
        FIRSTNAME AS nome,
        MIDDLENAME AS nome_do_meio,
        LASTNAME AS sobrenome,
        SUFFIX AS sufixo,
        EMAILPROMOTION AS promocao_email,
        ADDITIONALCONTACTINFO AS info_contato_adicional,
        DEMOGRAPHICS AS demograficos,
        ROWGUID AS guid_linha,
        MODIFIEDDATE AS data_modificacao,
        ROW_NUMBER() OVER (PARTITION BY BUSINESSENTITYID ORDER BY MODIFIEDDATE DESC) AS rn
    FROM EQUATORIAL.SAP_ADW.PERSON
)
SELECT
    MD5(person_id || data_modificacao) AS sk_pessoas,
    person_id AS id_pessoa,
    tipo_pessoa,
    estilo_nome,
    titulo,
    nome,
    nome_do_meio,
    sobrenome,
    sufixo,
    promocao_email,
    info_contato_adicional,
    demograficos,
    guid_linha,
    data_modificacao
FROM source_data
WHERE rn = 1