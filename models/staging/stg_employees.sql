{{ config(materialized='table') }}
WITH source_data AS (
    SELECT
        BUSINESSENTITYID AS employee_id,
        NATIONALIDNUMBER AS national_id_number,
        LOGINID AS login_id,
        JOBTITLE AS job_title,
        BIRTHDATE AS birth_date,
        MARITALSTATUS AS marital_status,
        GENDER,
        HIREDATE AS hire_date,
        SALARIEDFLAG AS salaried_flag,
        VACATIONHOURS AS vacation_hours,
        SICKLEAVEHOURS AS sick_leave_hours,
        CURRENTFLAG AS current_flag,
        ROWGUID AS row_guid,
        MODIFIEDDATE AS modified_date
    FROM {{ source('sap_adw', 'employee') }}
)
SELECT * FROM source_data