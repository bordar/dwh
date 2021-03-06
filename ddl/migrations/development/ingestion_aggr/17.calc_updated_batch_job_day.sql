DELIMITER $$

USE `borhandw`$$

DROP PROCEDURE IF EXISTS `calc_updated_batch_job_day`$$

CREATE PROCEDURE `calc_updated_batch_job_day`(p_date_id INT(11))
BEGIN
                DECLARE v_date DATETIME;
                DECLARE v_ignore_partner_ids TEXT;
                SET v_ignore_partner_ids = '';
				
                
                SELECT IFNULL(GROUP_CONCAT(ignore_partner.partner_id),'')
				INTO v_ignore_partner_ids
				FROM 
				(SELECT partner_id FROM borhandw.dwh_dim_batch_job_sep WHERE job_type_id = 0 AND job_sub_type_id IN (1,2,3,99) AND updated_date_id = p_date_id
				GROUP BY partner_id
				HAVING COUNT(*) > 10000) ignore_partner;
                                
                
                SET @s = CONCAT("INSERT INTO borhandw.dwh_fact_convert_job(id, job_type_id, status_id, created_date_id, updated_date_id, finish_date_id, partner_id, entry_id, dc, wait_time, conversion_time, is_ff)
				SELECT id, job_type_id, status_id, created_date_id, updated_date_id, DATE(finish_time)*1, partner_id, entry_id, dc, time_to_sec(timediff(queue_time, created_at)) wait_time, IF(finish_time IS NULL, -1, time_to_sec(timediff(finish_time, queue_time))) conversion_time, 0
				FROM borhandw.dwh_dim_batch_job_sep WHERE job_type_id = 0 AND job_sub_type_id IN (1,2,3,99) AND priority <> 10 AND queue_time IS NOT NULL AND updated_date_id = ", p_date_id, IF(LENGTH(v_ignore_partner_ids)=0,"",CONCAT(" AND partner_id NOT IN (" , v_ignore_partner_ids, ")")),
				" ON DUPLICATE KEY UPDATE 
					status_id = VALUES(status_id),
					updated_date_id = VALUES(updated_date_id),
					finish_date_id = VALUES(finish_date_id),
					wait_time = VALUES(wait_time),
					conversion_time = VALUES(conversion_time);");
					
				PREPARE stmt FROM  @s;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;	
					
				SELECT IFNULL(GROUP_CONCAT(ignore_partner.partner_id),'')
				INTO v_ignore_partner_ids
				FROM 
				(SELECT partner_id FROM borhandw.dwh_dim_batch_job_sep WHERE job_type_id = 10 AND updated_date_id = p_date_id
				GROUP BY partner_id
				HAVING COUNT(*) > 10000) ignore_partner;
				
                SET @s = CONCAT("INSERT INTO borhandw.dwh_fact_convert_job(id, job_type_id, status_id, created_date_id, updated_date_id, finish_date_id, partner_id, entry_id, dc, wait_time, conversion_time, is_ff)
                                SELECT id, job_type_id, status_id, created_date_id, updated_date_id, DATE(finish)*1, partner_id, c.entry_id, dc, TIME_TO_SEC(TIMEDIFF(queue_time, created_at)) wait_time, IF(finish IS NULL, -1, TIME_TO_SEC(TIMEDIFF(finish, queue_time))) conversion_time, 1 
				FROM (SELECT entry_id, root_job_id, MIN(finish_time) AS finish 
                FROM borhandw.dwh_dim_batch_job_sep WHERE root_job_id IN (SELECT id FROM borhandw.dwh_dim_batch_job_sep WHERE job_type_id = 10 AND priority <> 10 AND updated_date_id = ", p_date_id, IF(LENGTH(v_ignore_partner_ids)=0,"",CONCAT(" AND partner_id NOT IN (" , v_ignore_partner_ids, ")")),
                ") AND job_type_id = 0 AND job_sub_type_id IN (1,2,3,99) GROUP BY entry_id)
                AS c INNER JOIN borhandw.dwh_dim_batch_job_sep batch_job ON c.root_job_id = batch_job.root_job_id AND c.finish =  batch_job.finish_time
                GROUP BY c.entry_id
				ON DUPLICATE KEY UPDATE 
					status_id = VALUES(status_id),
					updated_date_id = VALUES(updated_date_id),
					finish_date_id = VALUES(finish_date_id),
					wait_time = VALUES(wait_time),
					conversion_time = VALUES(conversion_time),
					is_ff = VALUES(is_ff);");
                
                PREPARE stmt FROM  @s;
				EXECUTE stmt;
				DEALLOCATE PREPARE stmt;
				
                                
                BEGIN
                                DECLARE v_created_date_id INT(11);
                                DECLARE done INT DEFAULT 0;
                                DECLARE days_to_aggregate CURSOR FOR 
                                SELECT DISTINCT(created_date_id) FROM borhandw.dwh_fact_convert_job WHERE updated_date_id = p_date_id;
                                DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
                                
                                OPEN days_to_aggregate;
								
                                read_loop: LOOP
                                                FETCH days_to_aggregate INTO v_created_date_id;
                                                IF done THEN
                                                                LEAVE read_loop;
                                                END IF;
                                                INSERT INTO borhandw.aggr_managment(aggr_name,date_id,hour_id,data_insert_time) 
												VALUES ("ingestion", v_created_date_id, 0 ,NOW())
                                                ON DUPLICATE KEY UPDATE
                                                                data_insert_time = VALUES(data_insert_time);
                                END LOOP;
                                CLOSE days_to_aggregate;
                END;
				
END$$

DELIMITER ;