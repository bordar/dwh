INSERT INTO borhandw.aggr_managment (aggr_name, aggr_day, hour_id, aggr_day_int, is_calculated)
SELECT 'devices_bandwidth_usage', aggr_day, hour_id, aggr_day_int, is_calculated
FROM borhandw.aggr_managment
WHERE aggr_name = 'bandwidth_usage'
