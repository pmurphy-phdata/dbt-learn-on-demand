{{
    config(
        materialized="to_external_stage",
        named_stage="cert",
        file_name_prefix="cert_",
    )
}}

select *
from information_schema.tables
