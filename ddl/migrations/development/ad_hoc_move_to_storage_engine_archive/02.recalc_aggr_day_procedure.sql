DELIMITER $$

USE `kalturadw`$$

DROP PROCEDURE IF EXISTS `recalc_aggr_day`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `recalc_aggr_day`(p_date_id DATE, p_hour_id INT(11),p_aggr_name VARCHAR(100))
BEGIN
	DECLARE v_aggr_table VARCHAR(100);
	DECLARE v_aggr_id_field VARCHAR(100);
	DECLARE v_hourly_aggr_table VARCHAR(100);

	if (p_date_id >= date(20110201)) then -- do not re-aggregate anything older than 6 months
		
	SELECT aggr_table, aggr_id_field
	INTO  v_aggr_table, v_aggr_id_field
	FROM kalturadw_ds.aggr_name_resolver
	WHERE aggr_name = p_aggr_name;	
	
	IF (v_aggr_table <> '') THEN 
		SET @s = CONCAT('delete from ',v_aggr_table,'
			where date_id = DATE(''',p_date_id,''')*1 and hour_id = ',p_hour_id);
		PREPARE stmt FROM  @s;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;	
	END IF;
	
	SET @s = CONCAT('UPDATE aggr_managment SET is_calculated = 0 
	WHERE aggr_name = ''',p_aggr_name,''' AND aggr_day = ''',p_date_id,''' AND hour_id=',p_hour_id);
	PREPARE stmt FROM  @s;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	
	CALL calc_aggr_day(p_date_id,p_hour_id,p_aggr_name);
	
	end if; -- end skip old aggregations
	
END$$
	
DELIMITER ;