{{ config(materialized='table') }}

WITH source_data AS (
    SELECT
        employee_id AS id_funcionario,
        national_id_number AS numero_identidade,
        login_id AS id_login,
        job_title AS cargo,
        birth_date AS data_nascimento,
        marital_status AS estado_civil,
        gender AS genero,
        hire_date AS data_contratacao,
        salaried_flag AS flag_salarial,
        vacation_hours AS horas_ferias,
        sick_leave_hours AS horas_licenca_medica,
        current_flag AS flag_atual,
        row_guid AS guid_linha,
        modified_date AS data_modificacao,
        ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY modified_date DESC) AS rn
    FROM {{ ref('stg_employees') }}
)
SELECT
    MD5(id_funcionario || data_modificacao) AS sk_funcionarios,
    id_funcionario,
    numero_identidade,
    id_login,
    cargo,
    data_nascimento,
    estado_civil,
    genero,
    data_contratacao,
    flag_salarial,
    horas_ferias,
    horas_licenca_medica,
    flag_atual,
    guid_linha,
    data_modificacao
FROM source_data
WHERE rn = 1