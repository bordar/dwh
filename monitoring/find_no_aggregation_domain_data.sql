/*Search if no new data was added to dwh_hourly_events_domain in the day before yesterday*/
SELECT 'Domain aggregation did not enter any new data' stat, (DATE(NOW())-INTERVAL 2 DAY)*1 DAY
FROM borhandw.dwh_hourly_events_domain
WHERE date_id = (DATE(NOW())-INTERVAL 2 DAY)*1
HAVING COUNT(*)  = 0