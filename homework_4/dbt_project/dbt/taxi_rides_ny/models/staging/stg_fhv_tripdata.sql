{{
    config(
        materialized='view'
    )
}}

with tripdata as 
(
  select *,
  row_number() over(partition by dispatching_base_num, pickup_datetime) as rn
  from {{ source('staging','fhv_tripsdata') }}
  where dispatching_base_num is not null 
)
select
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} as tripid,
    {{ dbt.safe_cast("dispatching_base_num", api.Column.translate_type("integer")) }} as dispatching_base_num,
    {{ dbt.safe_cast("Affiliated_base_number", api.Column.translate_type("integer")) }} as Affiliated_base_number,
    {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("integer")) }} as PUlocationID,
    {{ dbt.safe_cast("DOlocationID", api.Column.translate_type("integer")) }} as DOlocationID,
    
    -- timestamps
    cast(pickup_datetime as timestamp) as pickup_datetime,
    cast(dropOff_datetime as timestamp) as dropOff_datetime,
    
    -- trip info
    SR_Flag,

from tripdata
where rn = 1 AND date(pickup_datetime) >= '2019-01-01' AND date(pickup_datetime) <= '2019-12-31'
