DELIMITER $$

DROP FUNCTION IF EXISTS `borhandw`.`calc_month_id`$$

CREATE  FUNCTION `borhandw`.`calc_month_id`(date_id INT(11)) 
	RETURNS INT DETERMINISTIC
BEGIN
	RETURN FLOOR(date_id/100);
    END$$

DELIMITER ;
