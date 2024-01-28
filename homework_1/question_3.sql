SELECT COUNT(*) 
FROM green_taxi_trips
WHERE lpep_pickup_datetime >= '2019-09-18 00:00:00' 
AND lpep_dropoff_datetime <= '2019-09-18 23:59:59' 
