CREATE TABLE borhandw.dwh_dim_bandwidth_source
(`bandwidth_source_id` INT,
`bandwidth_source_name` VARCHAR(50),
dwh_creation_date DATETIME ,
dwh_update_date DATETIME ,
ri_ind TINYINT DEFAULT 0,
is_live BOOL DEFAULT 0 NOT NULL,
PRIMARY KEY(`bandwidth_source_id`)) ENGINE=MYISAM;

INSERT INTO borhandw.dwh_dim_bandwidth_source (bandwidth_source_id,bandwidth_source_name, is_live) values
(1, 'WWW', 0),(2, 'LLN', 0),(3,'level3', 0),(4,'akamai_vod_http', 0),(5, 'akamai_live_fms', 1),(6, 'akamai_vod_fms',0),(7,'akamai_HD_1.0', 0),(8,'akamai_HD_2.0(HDS)', 0), (9, 'akamai_live_urtmp',1), (10, 'borhan_live' ,1);
