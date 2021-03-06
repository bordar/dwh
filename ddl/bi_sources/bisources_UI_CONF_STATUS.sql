DROP TABLE IF EXISTS `borhandw_bisources`.`bisources_ui_conf_status`;

CREATE TABLE `borhandw_bisources`.`bisources_ui_conf_status` (
  `ui_conf_status_id` SMALLINT NOT NULL ,
  `ui_conf_status_name` VARCHAR(50) DEFAULT 'missing value',
   PRIMARY KEY (`ui_conf_status_id`)
) ENGINE=MYISAM  DEFAULT CHARSET=utf8;

	
INSERT INTO borhandw_bisources.bisources_ui_conf_status(ui_conf_status_id,ui_conf_status_name) VALUES(1,'PENDING'); 
INSERT INTO borhandw_bisources.bisources_ui_conf_status(ui_conf_status_id,ui_conf_status_name) VALUES(2,'READY'); 
INSERT INTO borhandw_bisources.bisources_ui_conf_status(ui_conf_status_id,ui_conf_status_name) VALUES(3,'DELETED'); 
