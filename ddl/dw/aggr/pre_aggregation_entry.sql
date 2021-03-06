DELIMITER $$

USE `borhandw`$$

DROP PROCEDURE IF EXISTS `pre_aggregation_entry`$$

CREATE PROCEDURE `pre_aggregation_entry`(date_val DATE, p_hour_id INT(11))
BEGIN
	CALL remove_plays_views(date_val*1, p_hour_id);
END$$

DELIMITER ;
