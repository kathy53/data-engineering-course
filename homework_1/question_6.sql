SELECT t.tip_amount, zl."Zone"
FROM (
SELECT g."DOLocationID", tip_amount
FROM green_taxi_trips g
JOIN zone_lookup zl
ON g."PULocationID" = zl."LocationID"
WHERE zl."Zone" = 'Astoria' 
ORDER BY tip_amount DESC
LIMIT 3
) AS t
JOIN zone_lookup zl
ON t."DOLocationID" = zl."LocationID"
