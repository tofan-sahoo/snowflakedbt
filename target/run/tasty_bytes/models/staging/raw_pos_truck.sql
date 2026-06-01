
  create or replace   view TASTY_BYTES_DBT_DB.dev.raw_pos_truck
  
   as (
    SELECT *
FROM tasty_bytes_dbt_db.RAW.TRUCK
  );

