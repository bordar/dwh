DELIMITER $$

USE `kalturadw`$$

DROP PROCEDURE IF EXISTS `calc_partner_overage`$$

CREATE DEFINER=`etl`@`localhost` PROCEDURE `calc_partner_overage`(p_month_id INTEGER)
BEGIN
		DROP TABLE IF EXISTS partner_quotas;
		CREATE TEMPORARY TABLE partner_quotas AS
		SELECT 	q.partner_id partner_id,
			IFNULL(p.partner_id,q.partner_id) usage_partner_id,
			q.max_monthly_bandwidth_kb,
			q.charge_monthly_bandwidth_kb_usd,
			q.charge_monthly_bandwidth_kb_unit,
			q.max_monthly_storage_mb,
			q.charge_monthly_storage_mb_usd,
			q.charge_monthly_storage_mb_unit,
			q.max_monthly_total_usage_mb,
			q.charge_monthly_total_usage_mb_usd,
			q.charge_monthly_total_usage_mb_unit,
			q.max_monthly_plays,
			q.charge_monthly_plays_usd,
			q.charge_monthly_plays_unit,
			q.max_monthly_entries,
			q.charge_monthly_entries_usd,
			q.charge_monthly_entries_unit
		FROM kalturadw.dwh_dim_partners q LEFT OUTER JOIN kalturadw.dwh_dim_partners p ON (q.partner_id = p.partner_parent_id AND q.partner_group_type_id = 3)
		WHERE (q.max_monthly_bandwidth_kb IS NOT NULL AND q.charge_monthly_bandwidth_kb_usd IS NOT NULL AND q.charge_monthly_bandwidth_kb_unit IS NOT NULL);
	
		DROP TABLE IF EXISTS partner_overages;
		CREATE TEMPORARY TABLE partner_overages (
				    partner_id       			INT(11),
				    included_bandwidth_kb    		BIGINT(20),
				    actual_bandwidth_kb	 		BIGINT(20),
				    charge_overage_bandwidth_kb		DECIMAL(15,3),
				    included_storage_mb    		BIGINT(20),
				    actual_storage_mb	 		BIGINT(20),
				    charge_overage_storage_mb 		DECIMAL(15,3),
				    included_total_usage_mb    		BIGINT(20),
				    actual_total_usage_mb		BIGINT(20),
				    charge_overage_total_usage_mb 	DECIMAL(15,3),
				    included_entries			BIGINT(20),
				    actual_entries			BIGINT(20),
				    charge_overage_entries		DECIMAL(15,3),
				    included_plays			BIGINT(20),
				    actual_plays			BIGINT(20),
				    charge_overage_plays		DECIMAL(15,3),
				    PRIMARY KEY (partner_id)
				  ) ENGINE = MEMORY;
	
		INSERT INTO partner_overages (partner_id, included_bandwidth_kb, actual_bandwidth_kb, charge_overage_bandwidth_kb, included_storage_mb, actual_storage_mb, charge_overage_storage_mb, included_total_usage_mb, actual_total_usage_mb, charge_overage_total_usage_mb)
			SELECT pq.partner_id, 
				MAX(max_monthly_bandwidth_kb) included_bandwidth_kb,
				@BANDWIDTH:=IFNULL(SUM(count_bandwidth_kb),0) actual_bandwidth_kb,
				get_overage_charge(MAX(max_monthly_bandwidth_kb), @BANDWIDTH, MAX(charge_monthly_bandwidth_kb_unit), MAX(charge_monthly_bandwidth_kb_usd)) charge_overage_bandwidth_kb,
				MAX(charge_monthly_storage_mb_unit) included_storage_mb,
				@STORAGE:=calc_partner_monthly_storage(p_month_id , pq.partner_id) actual_storage_mb,
				get_overage_charge(MAX(max_monthly_storage_mb), @STORAGE, MAX(charge_monthly_storage_mb_unit), MAX(charge_monthly_storage_mb_usd)) charge_overage_storage_mb, 
				MAX(charge_monthly_total_usage_mb_unit) included_total_usage_mb,
				@BANDWIDTH + @STORAGE actual_total_usage_mb,
				get_overage_charge(MAX(max_monthly_total_usage_mb), @BANDWIDTH + @STORAGE, MAX(charge_monthly_total_usage_mb_unit), MAX(charge_monthly_total_usage_mb_usd)) charge_overage_total_usage_mb
			FROM partner_quotas pq LEFT OUTER JOIN kalturadw.dwh_hourly_partner_usage partner_usage 
					ON (pq.usage_partner_id = partner_usage.partner_id AND partner_usage.date_id BETWEEN DATE(p_month_id*100+1)*1 AND LAST_DAY(DATE(p_month_id*100+1))*1)
			GROUP BY pq.partner_id
			HAVING 	@BANDWIDTH > MAX(max_monthly_bandwidth_kb) OR 
				@STORAGE > MAX(max_monthly_bandwidth_kb) OR 
				(@BANDWIDTH+@STORAGE) > MAX(max_monthly_bandwidth_kb)
		ON DUPLICATE KEY UPDATE 
			included_bandwidth_kb=VALUES(included_bandwidth_kb),
			actual_bandwidth_kb=VALUES(actual_bandwidth_kb),
			charge_overage_bandwidth_kb=VALUES(charge_overage_bandwidth_kb),
			included_storage_mb=VALUES(included_storage_mb),
			charge_overage_storage_mb=VALUES(charge_overage_storage_mb),
			charge_overage_bandwidth_kb=VALUES(charge_overage_bandwidth_kb),
			included_total_usage_mb=VALUES(included_total_usage_mb),
			actual_total_usage_mb=VALUES(actual_total_usage_mb),
			charge_overage_total_usage_mb=VALUES(charge_overage_total_usage_mb);
		INSERT INTO partner_overages (partner_id, included_entries, actual_entries, charge_overage_entries)
			SELECT 	pq.partner_id, 
				MAX(max_monthly_entries) included_entries,
				COUNT(*) actual_entries,
				get_overage_charge(MAX(max_monthly_entries), COUNT(*), MAX(charge_monthly_entries_unit), MAX(charge_monthly_entries_usd)) charge_overage_entries
			FROM partner_quotas pq, kalturadw.dwh_dim_entries entries
			WHERE 	pq.usage_partner_id = entries.partner_id AND 
				entries.created_at < LAST_DAY(DATE(p_month_id*100+1)) + INTERVAL 1 DAY AND
				entries.entry_type_id IN (1,7) /*Media and Live streams*/
				AND entry_status_id NOT IN (-2,-1,3) /*Remove failed and deleted*/
			GROUP BY pq.partner_id
			HAVING COUNT(*) > MAX(max_monthly_entries)
		ON DUPLICATE KEY UPDATE 
			included_entries=VALUES(included_entries),
			actual_entries=VALUES(actual_entries),
			charge_overage_entries=VALUES(charge_overage_entries);
	
	
		INSERT INTO partner_overages (partner_id, included_plays, actual_plays, charge_overage_plays)
			SELECT 	pq.partner_id, 
				MAX(max_monthly_plays) included_plays,
				SUM(count_plays) actual_plays,
				get_overage_charge(MAX(max_monthly_plays), SUM(count_plays), MAX(charge_monthly_plays_unit), MAX(charge_monthly_plays_usd)) charge_overage_plays
			FROM partner_quotas pq, kalturadw.dwh_hourly_partner plays
			WHERE 	pq.usage_partner_id = plays.partner_id AND
				date_id BETWEEN DATE(p_month_id*100+1)*1 AND LAST_DAY(DATE(p_month_id*100+1))*1
			GROUP BY pq.partner_id
			HAVING 	SUM(count_plays) > MAX(max_monthly_plays)
		ON DUPLICATE KEY UPDATE 
			included_plays=VALUES(included_plays),
			actual_plays=VALUES(actual_plays),
			charge_overage_plays=VALUES(charge_overage_plays);
	
		SELECT 	IF(children.partner_group_type_id=3,children.partner_id,parents.partner_id) parent_partner_id,
			IF(children.partner_group_type_id=3,children.partner_name,parents.partner_name) parent_partner_name,
			group_types.partner_group_type_name,
			IF(children.partner_group_type_id=3,NULL,children.partner_id) publisher_id,
			IF(children.partner_group_type_id=3,NULL,children.partner_name) publisher_name,
			IF(children.partner_group_type_id=3,children.class_of_service_id,parents.partner_id) parent_partner_id,
			d_cos.partner_class_of_service_name,
			d_vertical.partner_vertical_name,
			included_bandwidth_kb,
			actual_bandwidth_kb,
			charge_overage_bandwidth_kb,
			included_storage_mb, 
			actual_storage_mb, 
			charge_overage_storage_mb, 
			included_total_usage_mb, 
			actual_total_usage_mb, 
			charge_overage_total_usage_mb,
			included_entries, 
			actual_entries, 
			charge_overage_entries,
			included_plays, 
			actual_plays, 
			charge_overage_plays			
		FROM partner_overages po 
		INNER JOIN kalturadw.dwh_dim_partners children ON (po.partner_id = children.partner_id)
		LEFT OUTER JOIN kalturadw.dwh_dim_partners parents ON (children.partner_parent_id = parents.partner_id)
		INNER JOIN kalturadw.dwh_dim_partner_group_type group_types ON (IF(parents.partner_id IS NOT NULL, parents.partner_group_type_id,children.partner_group_type_id) = group_types.partner_group_type_id)
		LEFT OUTER JOIN kalturadw.dwh_dim_partner_class_of_service d_cos ON (children.class_of_service_id = d_cos.partner_class_of_service_id)
		LEFT OUTER JOIN kalturadw.dwh_dim_partner_vertical d_vertical ON (children.vertical_id = d_vertical.partner_vertical_id)
		WHERE parents.partner_group_type_id <> 3 OR parents.partner_group_type_id IS NULL;
END$$

DELIMITER ;