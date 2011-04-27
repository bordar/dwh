CREATE TABLE kalturadw.dwh_fact_events
     (
	  file_id INT NOT NULL
	, event_id INT  NOT NULL
	, event_type_id SMALLINT  NOT NULL
	, client_version VARCHAR(31)
	, event_time DATETIME
	, event_date_id INT
	, event_hour_id TINYINT
	, session_id VARCHAR(50)
	, partner_id INT
	, entry_id VARCHAR(20)
	, unique_viewer VARCHAR(40)
	, widget_id VARCHAR(31)
	, ui_conf_id INT
	, uid VARCHAR(64)
	, current_point INT
	, duration INT
	, user_ip VARCHAR(15)
	, user_ip_number INT UNSIGNED
	, country_id INT
	, location_id INT
	, process_duration INT
	, control_id VARCHAR(15)
	, seek INT
	, new_point INT
	, domain_id INT
	, entry_media_type_id INT
	, entry_partner_id INT
	, referrer_id INT(11)
	,PRIMARY KEY (file_id,event_id,event_date_id)
	,KEY Entry_id (Entry_id)
	,KEY partner_id_event_type_id_time (`partner_id`,`event_type_id`,`event_time` )
	,KEY event_date_id (event_date_id)
	,KEY domain_id (domain_id)
     ) ENGINE=INNODB  DEFAULT CHARSET=utf8  
     PARTITION BY RANGE (events_date_id)
	(PARTITION p_20100101 VALUES LESS THAN (20100102));
