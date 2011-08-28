ALTER TABLE kalturadw_ds.fms_incomplete_sessions ADD session_os_id int(11), add session_browser_id int(11);
ALTER TABLE kalturadw_ds.fms_stale_sessions ADD session_os_id int(11), add session_browser_id int(11);

DELIMITER $$

USE `kalturadw_ds`$$

DROP PROCEDURE IF EXISTS `fms_sessionize`$$

CREATE DEFINER=`etl`@`localhost` PROCEDURE `fms_sessionize`(
  partition_id INTEGER)
BEGIN
  DECLARE FMS_STALE_SESSION_PURGE DATETIME;
 
  SELECT SUBDATE(NOW(),INTERVAL int_value DAY) INTO FMS_STALE_SESSION_PURGE FROM parameters WHERE id=3; 
 
  DROP TABLE IF EXISTS ds_temp_fms_session_aggr;
  DROP TABLE IF EXISTS ds_temp_fms_sessions;
 
  CREATE TEMPORARY TABLE ds_temp_fms_session_aggr (
    agg_session_id       	VARCHAR(20) NOT NULL,
    agg_session_time     	DATETIME    NOT NULL,
    agg_client_ip	 	VARCHAR(15),
    agg_client_ip_number 	INT(10),
    agg_client_country_id 	INT(10),
    agg_client_location_id 	INT(10),
    agg_os_id 			INT(11),
    agg_browser_id 		INT(11),
    agg_session_date_id  	INT(11),
    agg_con_cs_bytes     	BIGINT,
    agg_con_sc_bytes     	BIGINT,
    agg_dis_cs_bytes     	BIGINT,
    agg_dis_sc_bytes     	BIGINT,
    agg_partner_id       	INT(10),
    agg_bandwidth_source_id     INT(11)
  ) ENGINE = MEMORY;
 
  CREATE TEMPORARY TABLE ds_temp_fms_sessions (
    session_id         		VARCHAR(20) NOT NULL,
    session_time       		DATETIME    NOT NULL,
    session_date_id    		INT(11),
    session_client_ip	 	VARCHAR(15),
    session_client_ip_number 	INT(10),
    session_client_country_id 	INT(10),
    session_client_location_id 	INT(10),
    session_os_id	 	INT(11),
    session_browser_id 		INT(11),
    session_partner_id 		INT(10),
    bandwidth_source_id		INT(11),
    total_bytes        		BIGINT
   ) ENGINE = MEMORY;
    
  INSERT INTO ds_temp_fms_session_aggr (agg_session_id,agg_session_time,agg_session_date_id, agg_client_ip, agg_client_ip_number, agg_client_country_id, agg_client_location_id, agg_os_id, agg_browser_id,
              agg_con_cs_bytes,agg_con_sc_bytes,agg_dis_cs_bytes,agg_dis_sc_bytes,agg_partner_id, agg_bandwidth_source_id)
SELECT session_id, MAX(event_time), MAX(event_date_id), MAX(client_ip), MAX(client_ip_number), MAX(client_country_id), MAX(client_location_id), MAX(os_id), MAX(browser_id),
    SUM(IF(t.event_type='connect',client_to_server_bytes,0)) con_cs_bytes,
    SUM(IF(t.event_type='connect',server_to_client_bytes,0)) con_sc_bytes,
    SUM(IF(t.event_type='disconnect',client_to_server_bytes,0)) dis_cs_bytes,
    SUM(IF(t.event_type='disconnect',server_to_client_bytes,0)) dis_sc_bytes,
    MAX(partner_id) partner_id, MAX(bandwidth_source_id)
  FROM ds_fms_session_events e 
 INNER JOIN kalturadw.dwh_dim_fms_event_type t ON e.event_type_id = t.event_type_id
 INNER JOIN cycles c ON e.cycle_id = c.cycle_id
 LEFT OUTER JOIN kalturadw.dwh_dim_fms_bandwidth_source fbs ON (e.fms_app_id = fbs.fms_app_id AND c.process_id = fbs.process_id)
  WHERE e.cycle_id = partition_id
  GROUP BY session_id
 HAVING MAX(bandwidth_source_id) IS NOT NULL;
 
  INSERT INTO ds_temp_fms_sessions (session_id,session_time,session_date_id, session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id, 
				    session_os_id, session_browser_id, session_partner_id, bandwidth_source_id, total_bytes)
  SELECT agg_session_id,agg_session_time,agg_session_date_id,agg_client_ip, agg_client_ip_number, agg_client_country_id, agg_client_location_id, agg_os_id, agg_browser_id, agg_partner_id,agg_bandwidth_source_id,
  GREATEST(agg_dis_sc_bytes - agg_con_sc_bytes + agg_dis_cs_bytes - agg_con_cs_bytes, 0)
  FROM ds_temp_fms_session_aggr
  WHERE agg_partner_id IS NOT NULL AND agg_partner_id NOT IN (100  , -1  , -2  , 0 , 99 ) AND agg_dis_cs_bytes >0 AND agg_con_cs_bytes > 0;
  
  
  INSERT INTO fms_incomplete_sessions (session_id,session_time,updated_time,session_date_id, session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id, session_os_id, session_browser_id, con_cs_bytes,con_sc_bytes,dis_cs_bytes,dis_sc_bytes,partner_id)
  SELECT agg_session_id,agg_session_time,NOW() AS agg_update_time,agg_session_date_id,agg_client_ip, agg_client_ip_number, agg_client_country_id, agg_client_location_id, agg_os_id, agg_browser_id,
         agg_con_cs_bytes,agg_con_sc_bytes,agg_dis_cs_bytes,agg_dis_sc_bytes,agg_partner_id
  FROM ds_temp_fms_session_aggr
  WHERE agg_con_cs_bytes = 0 OR agg_dis_cs_bytes = 0 OR agg_partner_id IS NULL
  ON DUPLICATE KEY UPDATE
    session_time=GREATEST(session_time,VALUES(session_time)),
    session_date_id=GREATEST(session_date_id,VALUES(session_date_id)),
    session_client_ip=VALUES(session_client_ip),
    session_client_ip_number=VALUES(session_client_ip_number), 
    session_client_location_id=VALUES(session_client_location_id),
    session_client_country_id=VALUES(session_client_country_id),
    session_os_id=VALUES(session_os_id),
    session_browser_id=VALUES(session_browser_id),
    con_cs_bytes=con_cs_bytes+VALUES(con_cs_bytes),
    con_sc_bytes=con_sc_bytes+VALUES(con_sc_bytes),
    dis_cs_bytes=dis_cs_bytes+VALUES(dis_cs_bytes),
    dis_sc_bytes=dis_sc_bytes+VALUES(dis_sc_bytes),
    partner_id=IF(partner_id IS NULL,VALUES(partner_id),partner_id),
    bandwidth_source_id=VALUES(bandwidth_source_id),
    updated_time=GREATEST(updated_time,VALUES(updated_time));
  
  INSERT INTO ds_temp_fms_sessions (session_id,session_time,session_date_id,session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id,session_os_id, session_browser_id,session_partner_id,bandwidth_source_id,total_bytes)
  SELECT session_id,session_time,session_date_id,session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id,session_os_id, session_browser_id,partner_id,bandwidth_source_id,
  GREATEST(dis_sc_bytes - con_sc_bytes + dis_cs_bytes -con_cs_bytes, 0)
  FROM fms_incomplete_sessions
  WHERE partner_id IS NOT NULL AND partner_id NOT IN (100  , -1  , -2  , 0 , 99 ) AND dis_cs_bytes >0 AND con_cs_bytes > 0;
    
  INSERT INTO fms_stale_sessions (partner_id, bandwidth_source_id, session_id, session_time,session_date_id,session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id,session_os_id, session_browser_id,con_cs_bytes,con_sc_bytes,dis_cs_bytes,dis_sc_bytes,last_update_time,purge_time)
  SELECT partner_id,bandwidth_source_id, session_id,session_time,session_date_id,session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id,session_os_id, session_browser_id,con_cs_bytes,con_sc_bytes,dis_cs_bytes,dis_sc_bytes,updated_time,NOW()
  FROM fms_incomplete_sessions
  WHERE GREATEST(session_time,updated_time) < FMS_STALE_SESSION_PURGE AND (partner_id IS NULL OR dis_cs_bytes =0 OR con_cs_bytes = 0);
  
  DELETE FROM fms_incomplete_sessions
  WHERE (partner_id IS NOT NULL AND dis_cs_bytes >0 AND con_cs_bytes > 0) OR
        GREATEST(session_time,updated_time) < FMS_STALE_SESSION_PURGE;
  
  INSERT INTO kalturadw.dwh_fact_fms_sessions (session_id,session_time,session_date_id,session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id,session_os_id, session_browser_id,session_partner_id,bandwidth_source_id,total_bytes)
  SELECT session_id,session_time,session_date_id,session_client_ip, session_client_ip_number, session_client_country_id, session_client_location_id,session_os_id, session_browser_id,session_partner_id,bandwidth_source_id,total_bytes
  FROM ds_temp_fms_sessions
  ON DUPLICATE KEY UPDATE
	total_bytes=VALUES(total_bytes),
	session_partner_id=VALUES(session_partner_id),
	session_time=VALUES(session_time),
	session_client_ip=VALUES(session_client_ip),
	session_client_ip_number=VALUES(session_client_ip_number),
	session_client_country_id=VALUES(session_client_country_id),
	session_client_location_id=VALUES(session_client_location_id),
	session_os_id=VALUES(session_os_id),
	session_browser_id=VALUES(session_browser_id),
	bandwidth_source_id=VALUES(bandwidth_source_id);
END$$

DELIMITER ;