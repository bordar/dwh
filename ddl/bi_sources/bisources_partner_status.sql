DROP TABLE IF EXISTS `borhandw_bisources`.`bisources_partner_status`;

CREATE TABLE `borhandw_bisources`.`bisources_partner_status` (
  `partner_status_id` SMALLINT NOT NULL ,
  `partner_status_name` VARCHAR(50),
  PRIMARY KEY (`partner_status_id`)
  
) ENGINE=MYISAM  DEFAULT CHARSET=utf8;


INSERT INTO `borhandw_bisources`.`bisources_partner_status` (PARTNER_STATUS_id,PARTNER_STATUS_name) VALUES(1,'status_one');
INSERT INTO `borhandw_bisources`.`bisources_partner_status` (PARTNER_STATUS_id,PARTNER_STATUS_name) VALUES(2,'status_two');
