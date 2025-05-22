-- models/stg_orders.sql

{{

    config (
        materialized = 'table'
    )
}}

WITH source AS (
    SELECT
        order_id::INT AS order_id,
        customer_id::INT AS customer_id,
        order_date::DATE AS order_date,
        LOWER(status) AS status,
        total_amount::NUMERIC(10,2) AS total_amount,
        payment_method::STRING AS payment_method
   
    FROM 
        dbt_cloud.raw_schema.orders
),

cleaned AS (
    SELECT
        order_id,
        customer_id,
        order_date,
        EXTRACT(YEAR FROM order_date) AS order_year,
        status,
        total_amount,
        payment_method
    FROM source
    WHERE status != 'cancelled'
)

SELECT * FROM cleaned
