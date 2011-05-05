SET @from_date='2010-01-01';
SET @to_date='2014-12-31';

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'entry' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'country' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'domain' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'partner' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'widget' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'plays_views' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'uid' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'domain_referrer' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, is_calculated,start_time,end_time)
SELECT 'storage_usage' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time
WHERE date_field BETWEEN @from_date AND @to_date;

INSERT INTO kalturadw.aggr_managment (aggr_name,aggr_day_int,aggr_day, hour_id, is_calculated,start_time,end_time)
SELECT 'partner_usage' tn,DATE_FORMAT(DATE(date_field), '%Y%m%d'),DATE(date_field) d, hour_id, 0 i,NULL ts,NULL  te
FROM kalturadw.dwh_dim_time, 
(SELECT 0 hour_id UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 UNION
SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23) hours
WHERE date_field BETWEEN @from_date AND @to_date;
