DELIMITER $$

USE `borhandw_ds`$$

DROP PROCEDURE IF EXISTS `agg_new_fms_to_bandwidth_usage`$$

CREATE PROCEDURE `agg_new_fms_to_bandwidth_usage`()
BEGIN
  DECLARE FMS_BANDWIDTH_SOURCE INTEGER;
  SET FMS_BANDWIDTH_SOURCE = 5;
  UPDATE borhandw.aggr_managment
  SET start_time = NOW()
  WHERE aggr_name = 'fms_sessions' AND aggr_day <= NOW() AND is_calculated = 0;
  
 INSERT INTO borhandw.dwh_fact_bandwidth_usage
	(file_id,	cycle_id,	partner_id,		activity_date, 		activity_date_id,	activity_hour_id,	bandwidth_source_id,	url,	bandwidth_kb)
  SELECT NULL, 		NULL, 		session_partner_id, 	DATE(session_time),	session_date_id,	0,			FMS_BANDWIDTH_SOURCE,	NULL,	SUM(total_bytes)
  FROM borhandw.dwh_fact_fms_sessions
  WHERE session_date_id IN (
	SELECT DISTINCT aggr_day_int
	FROM borhandw.aggr_managment
	WHERE aggr_name = 'fms_sessions' AND is_calculated = 0 AND aggr_day <= NOW())
  GROUP BY session_partner_id,DATE(session_time),session_date_id
  ON DUPLICATE KEY UPDATE
	bandwidth_kb=VALUES(bandwidth_kb);
  
  UPDATE borhandw.aggr_managment
  SET is_calculated = 1, end_time = NOW()
  WHERE aggr_name = 'fms_sessions' AND aggr_day <= NOW() AND is_calculated = 0;
END$$

DELIMITER ;