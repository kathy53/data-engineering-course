SELECT zl."Borough", SUM(total_amount) AS TS
FROM green_taxi_trips g
JOIN zone_lookup zl
ON g."PULocationID" = zl."LocationID"
WHERE lpep_pickup_datetime >= '2019-09-18' 	 
GROUP BY zl."Borough"
HAVING SUM(total_amount) > 50000
ORDER BY TS DESC
LIMIT 3
