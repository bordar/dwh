use kalturadw;

CREATE TABLE `dwh_fact_bandwidth_usage_archive` (
  `file_id` INT(11) NOT NULL,
  `line_number` INT(11) DEFAULT NULL,
  `partner_id` INT(11) NOT NULL DEFAULT '-1',
  `activity_date_id` INT(11) DEFAULT '-1',
  `activity_hour_id` TINYINT(4) DEFAULT '-1',
  `bandwidth_source_id` BIGINT(20) DEFAULT NULL,
  `url` VARCHAR(2000) DEFAULT NULL,
  `bandwidth_bytes` BIGINT(20) DEFAULT '0',
  `user_ip` VARCHAR(15) DEFAULT NULL,
  `user_ip_number` INT(10) UNSIGNED DEFAULT NULL,
  `country_id` INT(11) DEFAULT NULL,
  `location_id` INT(11) DEFAULT NULL
) ENGINE=ARCHIVE DEFAULT CHARSET=utf8
/*!50100 PARTITION BY RANGE (activity_date_id)
(PARTITION p_20080531 VALUES LESS THAN (20080601) ENGINE = ARCHIVE,
 PARTITION p_20080630 VALUES LESS THAN (20080701) ENGINE = ARCHIVE,
 PARTITION p_20080731 VALUES LESS THAN (20080801) ENGINE = ARCHIVE,
 PARTITION p_20080831 VALUES LESS THAN (20080901) ENGINE = ARCHIVE,
 PARTITION p_20080930 VALUES LESS THAN (20081001) ENGINE = ARCHIVE,
 PARTITION p_20081031 VALUES LESS THAN (20081101) ENGINE = ARCHIVE,
 PARTITION p_20081130 VALUES LESS THAN (20081201) ENGINE = ARCHIVE,
 PARTITION p_20081231 VALUES LESS THAN (20090101) ENGINE = ARCHIVE,
 PARTITION p_20090131 VALUES LESS THAN (20090201) ENGINE = ARCHIVE,
 PARTITION p_20090228 VALUES LESS THAN (20090301) ENGINE = ARCHIVE,
 PARTITION p_20090331 VALUES LESS THAN (20090401) ENGINE = ARCHIVE,
 PARTITION p_20090430 VALUES LESS THAN (20090501) ENGINE = ARCHIVE,
 PARTITION p_20090531 VALUES LESS THAN (20090601) ENGINE = ARCHIVE,
 PARTITION p_20090630 VALUES LESS THAN (20090701) ENGINE = ARCHIVE,
 PARTITION p_20090731 VALUES LESS THAN (20090801) ENGINE = ARCHIVE,
 PARTITION p_20090831 VALUES LESS THAN (20090901) ENGINE = ARCHIVE,
 PARTITION p_20090930 VALUES LESS THAN (20091001) ENGINE = ARCHIVE,
 PARTITION p_20091031 VALUES LESS THAN (20091101) ENGINE = ARCHIVE,
 PARTITION p_20091130 VALUES LESS THAN (20091201) ENGINE = ARCHIVE,
 PARTITION p_20091231 VALUES LESS THAN (20100101) ENGINE = ARCHIVE,
 PARTITION p_20100131 VALUES LESS THAN (20100201) ENGINE = ARCHIVE,
 PARTITION p_20100228 VALUES LESS THAN (20100301) ENGINE = ARCHIVE,
 PARTITION p_20100331 VALUES LESS THAN (20100401) ENGINE = ARCHIVE,
 PARTITION p_20100430 VALUES LESS THAN (20100501) ENGINE = ARCHIVE,
 PARTITION p_20100531 VALUES LESS THAN (20100601) ENGINE = ARCHIVE,
 PARTITION p_20100630 VALUES LESS THAN (20100701) ENGINE = ARCHIVE,
 PARTITION p_20100731 VALUES LESS THAN (20100801) ENGINE = ARCHIVE,
 PARTITION p_20100831 VALUES LESS THAN (20100901) ENGINE = ARCHIVE,
 PARTITION p_20100930 VALUES LESS THAN (20101001) ENGINE = ARCHIVE,
 PARTITION p_20101031 VALUES LESS THAN (20101101) ENGINE = ARCHIVE,
 PARTITION p_20101130 VALUES LESS THAN (20101201) ENGINE = ARCHIVE,
 PARTITION p_20101231 VALUES LESS THAN (20110101) ENGINE = ARCHIVE,
 PARTITION p_20110101 VALUES LESS THAN (20110102) ENGINE = ARCHIVE,
 PARTITION p_20110102 VALUES LESS THAN (20110103) ENGINE = ARCHIVE,
 PARTITION p_20110103 VALUES LESS THAN (20110104) ENGINE = ARCHIVE,
 PARTITION p_20110104 VALUES LESS THAN (20110105) ENGINE = ARCHIVE,
 PARTITION p_20110105 VALUES LESS THAN (20110106) ENGINE = ARCHIVE,
 PARTITION p_20110106 VALUES LESS THAN (20110107) ENGINE = ARCHIVE,
 PARTITION p_20110107 VALUES LESS THAN (20110108) ENGINE = ARCHIVE,
 PARTITION p_20110108 VALUES LESS THAN (20110109) ENGINE = ARCHIVE,
 PARTITION p_20110109 VALUES LESS THAN (20110110) ENGINE = ARCHIVE,
 PARTITION p_20110110 VALUES LESS THAN (20110111) ENGINE = ARCHIVE,
 PARTITION p_20110111 VALUES LESS THAN (20110112) ENGINE = ARCHIVE,
 PARTITION p_20110112 VALUES LESS THAN (20110113) ENGINE = ARCHIVE,
 PARTITION p_20110113 VALUES LESS THAN (20110114) ENGINE = ARCHIVE,
 PARTITION p_20110114 VALUES LESS THAN (20110115) ENGINE = ARCHIVE,
 PARTITION p_20110115 VALUES LESS THAN (20110116) ENGINE = ARCHIVE,
 PARTITION p_20110116 VALUES LESS THAN (20110117) ENGINE = ARCHIVE,
 PARTITION p_20110117 VALUES LESS THAN (20110118) ENGINE = ARCHIVE,
 PARTITION p_20110118 VALUES LESS THAN (20110119) ENGINE = ARCHIVE,
 PARTITION p_20110119 VALUES LESS THAN (20110120) ENGINE = ARCHIVE,
 PARTITION p_20110120 VALUES LESS THAN (20110121) ENGINE = ARCHIVE,
 PARTITION p_20110121 VALUES LESS THAN (20110122) ENGINE = ARCHIVE,
 PARTITION p_20110122 VALUES LESS THAN (20110123) ENGINE = ARCHIVE,
 PARTITION p_20110123 VALUES LESS THAN (20110124) ENGINE = ARCHIVE,
 PARTITION p_20110124 VALUES LESS THAN (20110125) ENGINE = ARCHIVE,
 PARTITION p_20110125 VALUES LESS THAN (20110126) ENGINE = ARCHIVE,
 PARTITION p_20110126 VALUES LESS THAN (20110127) ENGINE = ARCHIVE,
 PARTITION p_20110127 VALUES LESS THAN (20110128) ENGINE = ARCHIVE,
 PARTITION p_20110128 VALUES LESS THAN (20110129) ENGINE = ARCHIVE,
 PARTITION p_20110129 VALUES LESS THAN (20110130) ENGINE = ARCHIVE,
 PARTITION p_20110130 VALUES LESS THAN (20110131) ENGINE = ARCHIVE,
 PARTITION p_20110131 VALUES LESS THAN (20110201) ENGINE = ARCHIVE,
 PARTITION p_20110201 VALUES LESS THAN (20110202) ENGINE = ARCHIVE,
 PARTITION p_20110202 VALUES LESS THAN (20110203) ENGINE = ARCHIVE,
 PARTITION p_20110203 VALUES LESS THAN (20110204) ENGINE = ARCHIVE,
 PARTITION p_20110204 VALUES LESS THAN (20110205) ENGINE = ARCHIVE,
 PARTITION p_20110205 VALUES LESS THAN (20110206) ENGINE = ARCHIVE,
 PARTITION p_20110206 VALUES LESS THAN (20110207) ENGINE = ARCHIVE,
 PARTITION p_20110207 VALUES LESS THAN (20110208) ENGINE = ARCHIVE,
 PARTITION p_20110208 VALUES LESS THAN (20110209) ENGINE = ARCHIVE,
 PARTITION p_20110209 VALUES LESS THAN (20110210) ENGINE = ARCHIVE,
 PARTITION p_20110210 VALUES LESS THAN (20110211) ENGINE = ARCHIVE,
 PARTITION p_20110211 VALUES LESS THAN (20110212) ENGINE = ARCHIVE,
 PARTITION p_20110212 VALUES LESS THAN (20110213) ENGINE = ARCHIVE,
 PARTITION p_20110213 VALUES LESS THAN (20110214) ENGINE = ARCHIVE,
 PARTITION p_20110214 VALUES LESS THAN (20110215) ENGINE = ARCHIVE,
 PARTITION p_20110215 VALUES LESS THAN (20110216) ENGINE = ARCHIVE,
 PARTITION p_20110216 VALUES LESS THAN (20110217) ENGINE = ARCHIVE,
 PARTITION p_20110217 VALUES LESS THAN (20110218) ENGINE = ARCHIVE,
 PARTITION p_20110218 VALUES LESS THAN (20110219) ENGINE = ARCHIVE,
 PARTITION p_20110219 VALUES LESS THAN (20110220) ENGINE = ARCHIVE,
 PARTITION p_20110220 VALUES LESS THAN (20110221) ENGINE = ARCHIVE,
 PARTITION p_20110221 VALUES LESS THAN (20110222) ENGINE = ARCHIVE,
 PARTITION p_20110222 VALUES LESS THAN (20110223) ENGINE = ARCHIVE,
 PARTITION p_20110223 VALUES LESS THAN (20110224) ENGINE = ARCHIVE,
 PARTITION p_20110224 VALUES LESS THAN (20110225) ENGINE = ARCHIVE,
 PARTITION p_20110225 VALUES LESS THAN (20110226) ENGINE = ARCHIVE,
 PARTITION p_20110226 VALUES LESS THAN (20110227) ENGINE = ARCHIVE,
 PARTITION p_20110227 VALUES LESS THAN (20110228) ENGINE = ARCHIVE,
 PARTITION p_20110228 VALUES LESS THAN (20110301) ENGINE = ARCHIVE,
 PARTITION p_20110301 VALUES LESS THAN (20110302) ENGINE = ARCHIVE,
 PARTITION p_20110302 VALUES LESS THAN (20110303) ENGINE = ARCHIVE,
 PARTITION p_20110303 VALUES LESS THAN (20110304) ENGINE = ARCHIVE,
 PARTITION p_20110304 VALUES LESS THAN (20110305) ENGINE = ARCHIVE,
 PARTITION p_20110305 VALUES LESS THAN (20110306) ENGINE = ARCHIVE,
 PARTITION p_20110306 VALUES LESS THAN (20110307) ENGINE = ARCHIVE,
 PARTITION p_20110307 VALUES LESS THAN (20110308) ENGINE = ARCHIVE,
 PARTITION p_20110308 VALUES LESS THAN (20110309) ENGINE = ARCHIVE,
 PARTITION p_20110309 VALUES LESS THAN (20110310) ENGINE = ARCHIVE,
 PARTITION p_20110310 VALUES LESS THAN (20110311) ENGINE = ARCHIVE,
 PARTITION p_20110311 VALUES LESS THAN (20110312) ENGINE = ARCHIVE,
 PARTITION p_20110312 VALUES LESS THAN (20110313) ENGINE = ARCHIVE,
 PARTITION p_20110313 VALUES LESS THAN (20110314) ENGINE = ARCHIVE,
 PARTITION p_20110314 VALUES LESS THAN (20110315) ENGINE = ARCHIVE,
 PARTITION p_20110315 VALUES LESS THAN (20110316) ENGINE = ARCHIVE,
 PARTITION p_20110316 VALUES LESS THAN (20110317) ENGINE = ARCHIVE,
 PARTITION p_20110317 VALUES LESS THAN (20110318) ENGINE = ARCHIVE,
 PARTITION p_20110318 VALUES LESS THAN (20110319) ENGINE = ARCHIVE,
 PARTITION p_20110319 VALUES LESS THAN (20110320) ENGINE = ARCHIVE,
 PARTITION p_20110320 VALUES LESS THAN (20110321) ENGINE = ARCHIVE,
 PARTITION p_20110321 VALUES LESS THAN (20110322) ENGINE = ARCHIVE,
 PARTITION p_20110322 VALUES LESS THAN (20110323) ENGINE = ARCHIVE,
 PARTITION p_20110323 VALUES LESS THAN (20110324) ENGINE = ARCHIVE,
 PARTITION p_20110324 VALUES LESS THAN (20110325) ENGINE = ARCHIVE,
 PARTITION p_20110325 VALUES LESS THAN (20110326) ENGINE = ARCHIVE,
 PARTITION p_20110326 VALUES LESS THAN (20110327) ENGINE = ARCHIVE,
 PARTITION p_20110327 VALUES LESS THAN (20110328) ENGINE = ARCHIVE,
 PARTITION p_20110328 VALUES LESS THAN (20110329) ENGINE = ARCHIVE,
 PARTITION p_20110329 VALUES LESS THAN (20110330) ENGINE = ARCHIVE,
 PARTITION p_20110330 VALUES LESS THAN (20110331) ENGINE = ARCHIVE,
 PARTITION p_20110331 VALUES LESS THAN (20110401) ENGINE = ARCHIVE,
 PARTITION p_20110401 VALUES LESS THAN (20110402) ENGINE = ARCHIVE,
 PARTITION p_20110402 VALUES LESS THAN (20110403) ENGINE = ARCHIVE,
 PARTITION p_20110403 VALUES LESS THAN (20110404) ENGINE = ARCHIVE,
 PARTITION p_20110404 VALUES LESS THAN (20110405) ENGINE = ARCHIVE,
 PARTITION p_20110405 VALUES LESS THAN (20110406) ENGINE = ARCHIVE,
 PARTITION p_20110406 VALUES LESS THAN (20110407) ENGINE = ARCHIVE,
 PARTITION p_20110407 VALUES LESS THAN (20110408) ENGINE = ARCHIVE,
 PARTITION p_20110408 VALUES LESS THAN (20110409) ENGINE = ARCHIVE,
 PARTITION p_20110409 VALUES LESS THAN (20110410) ENGINE = ARCHIVE,
 PARTITION p_20110410 VALUES LESS THAN (20110411) ENGINE = ARCHIVE,
 PARTITION p_20110411 VALUES LESS THAN (20110412) ENGINE = ARCHIVE,
 PARTITION p_20110412 VALUES LESS THAN (20110413) ENGINE = ARCHIVE,
 PARTITION p_20110413 VALUES LESS THAN (20110414) ENGINE = ARCHIVE,
 PARTITION p_20110414 VALUES LESS THAN (20110415) ENGINE = ARCHIVE,
 PARTITION p_20110415 VALUES LESS THAN (20110416) ENGINE = ARCHIVE,
 PARTITION p_20110416 VALUES LESS THAN (20110417) ENGINE = ARCHIVE,
 PARTITION p_20110417 VALUES LESS THAN (20110418) ENGINE = ARCHIVE,
 PARTITION p_20110418 VALUES LESS THAN (20110419) ENGINE = ARCHIVE,
 PARTITION p_20110419 VALUES LESS THAN (20110420) ENGINE = ARCHIVE,
 PARTITION p_20110420 VALUES LESS THAN (20110421) ENGINE = ARCHIVE,
 PARTITION p_20110421 VALUES LESS THAN (20110422) ENGINE = ARCHIVE,
 PARTITION p_20110422 VALUES LESS THAN (20110423) ENGINE = ARCHIVE,
 PARTITION p_20110423 VALUES LESS THAN (20110424) ENGINE = ARCHIVE,
 PARTITION p_20110424 VALUES LESS THAN (20110425) ENGINE = ARCHIVE,
 PARTITION p_20110425 VALUES LESS THAN (20110426) ENGINE = ARCHIVE,
 PARTITION p_20110426 VALUES LESS THAN (20110427) ENGINE = ARCHIVE,
 PARTITION p_20110427 VALUES LESS THAN (20110428) ENGINE = ARCHIVE,
 PARTITION p_20110428 VALUES LESS THAN (20110429) ENGINE = ARCHIVE,
 PARTITION p_20110429 VALUES LESS THAN (20110430) ENGINE = ARCHIVE,
 PARTITION p_20110430 VALUES LESS THAN (20110501) ENGINE = ARCHIVE,
 PARTITION p_20110501 VALUES LESS THAN (20110502) ENGINE = ARCHIVE,
 PARTITION p_20110502 VALUES LESS THAN (20110503) ENGINE = ARCHIVE,
 PARTITION p_20110503 VALUES LESS THAN (20110504) ENGINE = ARCHIVE,
 PARTITION p_20110504 VALUES LESS THAN (20110505) ENGINE = ARCHIVE,
 PARTITION p_20110505 VALUES LESS THAN (20110506) ENGINE = ARCHIVE,
 PARTITION p_20110506 VALUES LESS THAN (20110507) ENGINE = ARCHIVE,
 PARTITION p_20110507 VALUES LESS THAN (20110508) ENGINE = ARCHIVE,
 PARTITION p_20110508 VALUES LESS THAN (20110509) ENGINE = ARCHIVE,
 PARTITION p_20110509 VALUES LESS THAN (20110510) ENGINE = ARCHIVE,
 PARTITION p_20110510 VALUES LESS THAN (20110511) ENGINE = ARCHIVE,
 PARTITION p_20110511 VALUES LESS THAN (20110512) ENGINE = ARCHIVE,
 PARTITION p_20110512 VALUES LESS THAN (20110513) ENGINE = ARCHIVE,
 PARTITION p_20110513 VALUES LESS THAN (20110514) ENGINE = ARCHIVE,
 PARTITION p_20110514 VALUES LESS THAN (20110515) ENGINE = ARCHIVE,
 PARTITION p_20110515 VALUES LESS THAN (20110516) ENGINE = ARCHIVE,
 PARTITION p_20110516 VALUES LESS THAN (20110517) ENGINE = ARCHIVE,
 PARTITION p_20110517 VALUES LESS THAN (20110518) ENGINE = ARCHIVE,
 PARTITION p_20110518 VALUES LESS THAN (20110519) ENGINE = ARCHIVE,
 PARTITION p_20110519 VALUES LESS THAN (20110520) ENGINE = ARCHIVE,
 PARTITION p_20110520 VALUES LESS THAN (20110521) ENGINE = ARCHIVE,
 PARTITION p_20110521 VALUES LESS THAN (20110522) ENGINE = ARCHIVE,
 PARTITION p_20110522 VALUES LESS THAN (20110523) ENGINE = ARCHIVE,
 PARTITION p_20110523 VALUES LESS THAN (20110524) ENGINE = ARCHIVE,
 PARTITION p_20110524 VALUES LESS THAN (20110525) ENGINE = ARCHIVE,
 PARTITION p_20110525 VALUES LESS THAN (20110526) ENGINE = ARCHIVE,
 PARTITION p_20110526 VALUES LESS THAN (20110527) ENGINE = ARCHIVE,
 PARTITION p_20110527 VALUES LESS THAN (20110528) ENGINE = ARCHIVE,
 PARTITION p_20110528 VALUES LESS THAN (20110529) ENGINE = ARCHIVE,
 PARTITION p_20110529 VALUES LESS THAN (20110530) ENGINE = ARCHIVE,
 PARTITION p_20110530 VALUES LESS THAN (20110531) ENGINE = ARCHIVE,
 PARTITION p_20110531 VALUES LESS THAN (20110601) ENGINE = ARCHIVE,
 PARTITION p_20110601 VALUES LESS THAN (20110602) ENGINE = ARCHIVE,
 PARTITION p_20110602 VALUES LESS THAN (20110603) ENGINE = ARCHIVE,
 PARTITION p_20110603 VALUES LESS THAN (20110604) ENGINE = ARCHIVE,
 PARTITION p_20110604 VALUES LESS THAN (20110605) ENGINE = ARCHIVE,
 PARTITION p_20110605 VALUES LESS THAN (20110606) ENGINE = ARCHIVE,
 PARTITION p_20110606 VALUES LESS THAN (20110607) ENGINE = ARCHIVE,
 PARTITION p_20110607 VALUES LESS THAN (20110608) ENGINE = ARCHIVE,
 PARTITION p_20110608 VALUES LESS THAN (20110609) ENGINE = ARCHIVE,
 PARTITION p_20110609 VALUES LESS THAN (20110610) ENGINE = ARCHIVE,
 PARTITION p_20110610 VALUES LESS THAN (20110611) ENGINE = ARCHIVE,
 PARTITION p_20110611 VALUES LESS THAN (20110612) ENGINE = ARCHIVE,
 PARTITION p_20110612 VALUES LESS THAN (20110613) ENGINE = ARCHIVE,
 PARTITION p_20110613 VALUES LESS THAN (20110614) ENGINE = ARCHIVE,
 PARTITION p_20110614 VALUES LESS THAN (20110615) ENGINE = ARCHIVE,
 PARTITION p_20110615 VALUES LESS THAN (20110616) ENGINE = ARCHIVE,
 PARTITION p_20110616 VALUES LESS THAN (20110617) ENGINE = ARCHIVE,
 PARTITION p_20110617 VALUES LESS THAN (20110618) ENGINE = ARCHIVE,
 PARTITION p_20110618 VALUES LESS THAN (20110619) ENGINE = ARCHIVE,
 PARTITION p_20110619 VALUES LESS THAN (20110620) ENGINE = ARCHIVE,
 PARTITION p_20110620 VALUES LESS THAN (20110621) ENGINE = ARCHIVE,
 PARTITION p_20110621 VALUES LESS THAN (20110622) ENGINE = ARCHIVE,
 PARTITION p_20110622 VALUES LESS THAN (20110623) ENGINE = ARCHIVE,
 PARTITION p_20110623 VALUES LESS THAN (20110624) ENGINE = ARCHIVE,
 PARTITION p_20110624 VALUES LESS THAN (20110625) ENGINE = ARCHIVE,
 PARTITION p_20110625 VALUES LESS THAN (20110626) ENGINE = ARCHIVE,
 PARTITION p_20110626 VALUES LESS THAN (20110627) ENGINE = ARCHIVE,
 PARTITION p_20110627 VALUES LESS THAN (20110628) ENGINE = ARCHIVE,
 PARTITION p_20110628 VALUES LESS THAN (20110629) ENGINE = ARCHIVE,
 PARTITION p_20110629 VALUES LESS THAN (20110630) ENGINE = ARCHIVE,
 PARTITION p_20110630 VALUES LESS THAN (20110701) ENGINE = ARCHIVE,
 PARTITION p_20110701 VALUES LESS THAN (20110702) ENGINE = ARCHIVE,
 PARTITION p_20110702 VALUES LESS THAN (20110703) ENGINE = ARCHIVE,
 PARTITION p_20110703 VALUES LESS THAN (20110704) ENGINE = ARCHIVE,
 PARTITION p_20110704 VALUES LESS THAN (20110705) ENGINE = ARCHIVE,
 PARTITION p_20110705 VALUES LESS THAN (20110706) ENGINE = ARCHIVE,
 PARTITION p_20110706 VALUES LESS THAN (20110707) ENGINE = ARCHIVE,
 PARTITION p_20110707 VALUES LESS THAN (20110708) ENGINE = ARCHIVE,
 PARTITION p_20110708 VALUES LESS THAN (20110709) ENGINE = ARCHIVE,
 PARTITION p_20110709 VALUES LESS THAN (20110710) ENGINE = ARCHIVE,
 PARTITION p_20110710 VALUES LESS THAN (20110711) ENGINE = ARCHIVE,
 PARTITION p_20110711 VALUES LESS THAN (20110712) ENGINE = ARCHIVE,
 PARTITION p_20110712 VALUES LESS THAN (20110713) ENGINE = ARCHIVE,
 PARTITION p_20110713 VALUES LESS THAN (20110714) ENGINE = ARCHIVE,
 PARTITION p_20110714 VALUES LESS THAN (20110715) ENGINE = ARCHIVE,
 PARTITION p_20110715 VALUES LESS THAN (20110716) ENGINE = ARCHIVE,
 PARTITION p_20110716 VALUES LESS THAN (20110717) ENGINE = ARCHIVE,
 PARTITION p_20110717 VALUES LESS THAN (20110718) ENGINE = ARCHIVE,
 PARTITION p_20110718 VALUES LESS THAN (20110719) ENGINE = ARCHIVE,
 PARTITION p_20110719 VALUES LESS THAN (20110720) ENGINE = ARCHIVE,
 PARTITION p_20110720 VALUES LESS THAN (20110721) ENGINE = ARCHIVE,
 PARTITION p_20110721 VALUES LESS THAN (20110722) ENGINE = ARCHIVE,
 PARTITION p_20110722 VALUES LESS THAN (20110723) ENGINE = ARCHIVE,
 PARTITION p_20110723 VALUES LESS THAN (20110724) ENGINE = ARCHIVE,
 PARTITION p_20110724 VALUES LESS THAN (20110725) ENGINE = ARCHIVE,
 PARTITION p_20110725 VALUES LESS THAN (20110726) ENGINE = ARCHIVE,
 PARTITION p_20110726 VALUES LESS THAN (20110727) ENGINE = ARCHIVE,
 PARTITION p_20110727 VALUES LESS THAN (20110728) ENGINE = ARCHIVE,
 PARTITION p_20110728 VALUES LESS THAN (20110729) ENGINE = ARCHIVE,
 PARTITION p_20110729 VALUES LESS THAN (20110730) ENGINE = ARCHIVE,
 PARTITION p_20110730 VALUES LESS THAN (20110731) ENGINE = ARCHIVE,
 PARTITION p_20110731 VALUES LESS THAN (20110801) ENGINE = ARCHIVE) */


