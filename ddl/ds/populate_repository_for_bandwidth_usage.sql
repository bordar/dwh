﻿INSERT INTO borhandw_ds.processes (id, process_name, max_files_per_cycle) VALUE (4, 'bandwidth_usage_AKAMAI', 50);
INSERT INTO borhandw_ds.processes (id, process_name, max_files_per_cycle) VALUE (5, 'bandwidth_usage_LLN', 50);
INSERT INTO borhandw_ds.processes (id, process_name, max_files_per_cycle) VALUE (6, 'bandwidth_usage_LEVEL3', 1000);
INSERT INTO borhandw_ds.processes (id, process_name, max_files_per_cycle) VALUE (10, 'bandwidth_usage_AKAMAI_LIVE_URTMP', 50);
INSERT INTO borhandw_ds.processes (id, process_name, max_files_per_cycle) VALUE (12, 'borhan_live_bandwidth', 20);

INSERT INTO `borhandw_ds`.`staging_areas`
        (`id`,
        `process_id`,
        `source_table`,
        `target_table_id`,
        `on_duplicate_clause`,
        `staging_partition_field`,
        `post_transfer_sp`,
	`post_transfer_aggregations`,
	`aggr_date_field`,
	`hour_id_field`
        )
        VALUES
        (4,      4,
         'ds_bandwidth_usage',
         2,
         NULL,
         'cycle_id',
         NULL,
	'(\'bandwidth_usage\',\'devices_bandwidth_usage\')',
	'activity_date_id',
	'activity_hour_id'
        );


INSERT INTO `borhandw_ds`.`staging_areas`
        (`id`,
        `process_id`,
        `source_table`,
        `target_table_id`,
        `on_duplicate_clause`,
        `staging_partition_field`,
        `post_transfer_sp`,
	`post_transfer_aggregations`,
	`aggr_date_field`,
	`hour_id_field`
        )
        VALUES
        (5,      5,
         'ds_bandwidth_usage',
         2,
         NULL,
         'cycle_id',
         NULL,
	'(\'bandwidth_usage\',\'devices_bandwidth_usage\')',
	'activity_date_id',
	'activity_hour_id'
        );

INSERT INTO `borhandw_ds`.`staging_areas`
        (`id`,
        `process_id`,
        `source_table`,
        `target_table_id`,
        `on_duplicate_clause`,
        `staging_partition_field`,
        `post_transfer_sp`,
	`post_transfer_aggregations`,
	`aggr_date_field`,
	`hour_id_field`
        )
        VALUES
        (6,      6,
         'ds_bandwidth_usage',
         2,
         NULL,
         'cycle_id',
         NULL,
	'(\'bandwidth_usage\',\'devices_bandwidth_usage\')',
	'activity_date_id',
	'activity_hour_id'
        );

INSERT INTO `borhandw_ds`.`staging_areas`
        (`id`,
        `process_id`,
        `source_table`,
        `target_table_id`,
        `on_duplicate_clause`,
        `staging_partition_field`,
        `post_transfer_sp`,
	`post_transfer_aggregations`,
	`aggr_date_field`,
	`hour_id_field`
        )
        VALUES
        (7,      1,
         'ds_bandwidth_usage',
         2,
         NULL,
         'cycle_id',
         NULL,
	'(\'bandwidth_usage\',\'devices_bandwidth_usage\')',
	'activity_date_id',
	'activity_hour_id'
        );


INSERT INTO `borhandw_ds`.`staging_areas`
        (`id`,
        `process_id`,
        `source_table`,
        `target_table_id`,
        `on_duplicate_clause`,
        `staging_partition_field`,
        `post_transfer_sp`,
	`post_transfer_aggregations`,
	`aggr_date_field`,
	`hour_id_field`
        )
        VALUES
        (12,      10,
         'ds_bandwidth_usage',
         2,
         NULL,
         'cycle_id',
         NULL,
	'(\'bandwidth_usage\',\'devices_bandwidth_usage\')',
	'activity_date_id',
	'activity_hour_id'
        );
		
INSERT INTO borhandw_ds.staging_areas
        (id,
        process_id,
        source_table,
        target_table_id,
        on_duplicate_clause,
        staging_partition_field,
        post_transfer_sp,
                post_transfer_aggregations,
                aggr_date_field,
                hour_id_field)
VALUES
        (14,      12,
         'ds_bandwidth_usage',
         2,
         NULL,
         'cycle_id',
         NULL,
        '(\'bandwidth_usage\')',
        'activity_date_id',
        'activity_hour_id');
