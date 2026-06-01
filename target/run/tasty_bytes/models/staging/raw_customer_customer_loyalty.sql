
  create or replace   view TASTY_BYTES_DBT_DB.dev.raw_customer_customer_loyalty
  
   as (
    select *
from tasty_bytes_dbt_db.RAW.CUSTOMER_LOYALTY
  );

