
  
    

        create or replace transient table TASTY_BYTES_DBT_DB.dev_tofansahoo.customer_loyalty_metrics
         as
        (SELECT 
    cl.customer_id,
    cl.city,
    cl.country,
    cl.first_name,
    cl.last_name,
    cl.phone_number,
    cl.e_mail,
    SUM(oh.order_total) AS total_sales,
    ARRAY_AGG(DISTINCT oh.location_id) AS visited_location_ids_array
FROM TASTY_BYTES_DBT_DB.dev.raw_customer_customer_loyalty cl
JOIN TASTY_BYTES_DBT_DB.dev.raw_pos_order_header oh
ON cl.customer_id = oh.customer_id
GROUP BY cl.customer_id, cl.city, cl.country, cl.first_name,
cl.last_name, cl.phone_number, cl.e_mail
        );
      
  