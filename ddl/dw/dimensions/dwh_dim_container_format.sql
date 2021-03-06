/*
SQLyog Community v8.7 
MySQL - 5.1.47 : Database - borhandw_ds
*********************************************************************
*/


/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
USE `borhandw`;

/*Table structure for table `dwh_dim_container_format` */

DROP TABLE IF EXISTS `dwh_dim_container_format`;
		      
CREATE TABLE `dwh_dim_container_format` (`container_format_id` INT(11) AUTO_INCREMENT,
				   `container_format` VARCHAR(333) DEFAULT NULL,
				PRIMARY KEY(`container_format_id`),
				UNIQUE KEY(`container_format`)
)  ENGINE=MYISAM DEFAULT CHARSET=utf8;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
