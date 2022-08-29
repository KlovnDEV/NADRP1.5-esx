-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.18-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for s1873_ffrp
CREATE DATABASE IF NOT EXISTS `s1873_ffrp` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `s1873_ffrp`;

-- Dumping structure for table s1873_ffrp.addon_account
CREATE TABLE IF NOT EXISTS `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.addon_account: ~0 rows (approximately)
/*!40000 ALTER TABLE `addon_account` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_account` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.addon_account_data
CREATE TABLE IF NOT EXISTS `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(22) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_account_data_account_name` (`account_name`),
  KEY `IDX_addon_account_data_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.addon_account_data: ~0 rows (approximately)
/*!40000 ALTER TABLE `addon_account_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_account_data` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.addon_inventory
CREATE TABLE IF NOT EXISTS `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.addon_inventory: ~393 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory` DISABLE KEYS */;
INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES
	('BayviewLodgeMotel_1', 'BAYVIEW LODGE MOTEL Room 1 Motel Storage', 1),
	('BayviewLodgeMotel_10', 'BAYVIEW LODGE MOTEL Room 10 Motel Storage', 1),
	('BayviewLodgeMotel_10_bed', 'BAYVIEW LODGE MOTEL Room 10 Motel Bed Storage', 1),
	('BayviewLodgeMotel_1_bed', 'BAYVIEW LODGE MOTEL Room 1 Motel Bed Storage', 1),
	('BayviewLodgeMotel_2', 'BAYVIEW LODGE MOTEL Room 2 Motel Storage', 1),
	('BayviewLodgeMotel_2_bed', 'BAYVIEW LODGE MOTEL Room 2 Motel Bed Storage', 1),
	('BayviewLodgeMotel_3', 'BAYVIEW LODGE MOTEL Room 3 Motel Storage', 1),
	('BayviewLodgeMotel_3_bed', 'BAYVIEW LODGE MOTEL Room 3 Motel Bed Storage', 1),
	('BayviewLodgeMotel_4', 'BAYVIEW LODGE MOTEL Room 4 Motel Storage', 1),
	('BayviewLodgeMotel_4_bed', 'BAYVIEW LODGE MOTEL Room 4 Motel Bed Storage', 1),
	('BayviewLodgeMotel_5', 'BAYVIEW LODGE MOTEL Room 5 Motel Storage', 1),
	('BayviewLodgeMotel_5_bed', 'BAYVIEW LODGE MOTEL Room 5 Motel Bed Storage', 1),
	('BayviewLodgeMotel_6', 'BAYVIEW LODGE MOTEL Room 6 Motel Storage', 1),
	('BayviewLodgeMotel_6_bed', 'BAYVIEW LODGE MOTEL Room 6 Motel Bed Storage', 1),
	('BayviewLodgeMotel_7', 'BAYVIEW LODGE MOTEL Room 7 Motel Storage', 1),
	('BayviewLodgeMotel_7_bed', 'BAYVIEW LODGE MOTEL Room 7 Motel Bed Storage', 1),
	('BayviewLodgeMotel_8', 'BAYVIEW LODGE MOTEL Room 8 Motel Storage', 1),
	('BayviewLodgeMotel_8_bed', 'BAYVIEW LODGE MOTEL Room 8 Motel Bed Storage', 1),
	('BayviewLodgeMotel_9', 'BAYVIEW LODGE MOTEL Room 9 Motel Storage', 1),
	('BayviewLodgeMotel_9_bed', 'BAYVIEW LODGE MOTEL Room 9 Motel Bed Storage', 1),
	('BilingsgateMotel_1', 'BILINGSGATE MOTEL Room 1 Motel Storage', 1),
	('BilingsgateMotel_10', 'BILINGSGATE MOTEL Room 10 Motel Storage', 1),
	('BilingsgateMotel_10_bed', 'BILINGSGATE MOTEL Room 10 Motel Bed Storage', 1),
	('BilingsgateMotel_11', 'BILINGSGATE MOTEL Room 11 Motel Storage', 1),
	('BilingsgateMotel_11_bed', 'BILINGSGATE MOTEL Room 11 Motel Bed Storage', 1),
	('BilingsgateMotel_12', 'BILINGSGATE MOTEL Room 12 Motel Storage', 1),
	('BilingsgateMotel_12_bed', 'BILINGSGATE MOTEL Room 12 Motel Bed Storage', 1),
	('BilingsgateMotel_14', 'BILINGSGATE MOTEL Room 14 Motel Storage', 1),
	('BilingsgateMotel_14_bed', 'BILINGSGATE MOTEL Room 14 Motel Bed Storage', 1),
	('BilingsgateMotel_15', 'BILINGSGATE MOTEL Room 15 Motel Storage', 1),
	('BilingsgateMotel_15_bed', 'BILINGSGATE MOTEL Room 15 Motel Bed Storage', 1),
	('BilingsgateMotel_1_bed', 'BILINGSGATE MOTEL Room 1 Motel Bed Storage', 1),
	('BilingsgateMotel_2', 'BILINGSGATE MOTEL Room 2 Motel Storage', 1),
	('BilingsgateMotel_2_bed', 'BILINGSGATE MOTEL Room 2 Motel Bed Storage', 1),
	('BilingsgateMotel_3', 'BILINGSGATE MOTEL Room 3 Motel Storage', 1),
	('BilingsgateMotel_3_bed', 'BILINGSGATE MOTEL Room 3 Motel Bed Storage', 1),
	('BilingsgateMotel_4', 'BILINGSGATE MOTEL Room 4 Motel Storage', 1),
	('BilingsgateMotel_4_bed', 'BILINGSGATE MOTEL Room 4 Motel Bed Storage', 1),
	('BilingsgateMotel_5', 'BILINGSGATE MOTEL Room 5 Motel Storage', 1),
	('BilingsgateMotel_5_bed', 'BILINGSGATE MOTEL Room 5 Motel Bed Storage', 1),
	('BilingsgateMotel_6', 'BILINGSGATE MOTEL Room 6 Motel Storage', 1),
	('BilingsgateMotel_6_bed', 'BILINGSGATE MOTEL Room 6 Motel Bed Storage', 1),
	('BilingsgateMotel_7', 'BILINGSGATE MOTEL Room 7 Motel Storage', 1),
	('BilingsgateMotel_7_bed', 'BILINGSGATE MOTEL Room 7 Motel Bed Storage', 1),
	('BilingsgateMotel_8', 'BILINGSGATE MOTEL Room 8 Motel Storage', 1),
	('BilingsgateMotel_8_bed', 'BILINGSGATE MOTEL Room 8 Motel Bed Storage', 1),
	('CrownJewelsMotel_1', 'CROWN JEWELS MOTEL Room 1 Motel Storage', 1),
	('CrownJewelsMotel_10', 'CROWN JEWELS MOTEL Room 10 Motel Storage', 1),
	('CrownJewelsMotel_10_bed', 'CROWN JEWELS MOTEL Room 10 Motel Bed Storage', 1),
	('CrownJewelsMotel_11', 'CROWN JEWELS MOTEL Room 11 Motel Storage', 1),
	('CrownJewelsMotel_11_bed', 'CROWN JEWELS MOTEL Room 11 Motel Bed Storage', 1),
	('CrownJewelsMotel_12', 'CROWN JEWELS MOTEL Room 12 Motel Storage', 1),
	('CrownJewelsMotel_12_bed', 'CROWN JEWELS MOTEL Room 12 Motel Bed Storage', 1),
	('CrownJewelsMotel_13', 'CROWN JEWELS MOTEL Room 13 Motel Storage', 1),
	('CrownJewelsMotel_13_bed', 'CROWN JEWELS MOTEL Room 13 Motel Bed Storage', 1),
	('CrownJewelsMotel_14', 'CROWN JEWELS MOTEL Room 14 Motel Storage', 1),
	('CrownJewelsMotel_14_bed', 'CROWN JEWELS MOTEL Room 14 Motel Bed Storage', 1),
	('CrownJewelsMotel_15', 'CROWN JEWELS MOTEL Room 15 Motel Storage', 1),
	('CrownJewelsMotel_15_bed', 'CROWN JEWELS MOTEL Room 15 Motel Bed Storage', 1),
	('CrownJewelsMotel_16', 'CROWN JEWELS MOTEL Room 16 Motel Storage', 1),
	('CrownJewelsMotel_16_bed', 'CROWN JEWELS MOTEL Room 16 Motel Bed Storage', 1),
	('CrownJewelsMotel_17', 'CROWN JEWELS MOTEL Room 17 Motel Storage', 1),
	('CrownJewelsMotel_17_bed', 'CROWN JEWELS MOTEL Room 17 Motel Bed Storage', 1),
	('CrownJewelsMotel_1_bed', 'CROWN JEWELS MOTEL Room 1 Motel Bed Storage', 1),
	('CrownJewelsMotel_2', 'CROWN JEWELS MOTEL Room 2 Motel Storage', 1),
	('CrownJewelsMotel_2_bed', 'CROWN JEWELS MOTEL Room 2 Motel Bed Storage', 1),
	('CrownJewelsMotel_3', 'CROWN JEWELS MOTEL Room 3 Motel Storage', 1),
	('CrownJewelsMotel_3_bed', 'CROWN JEWELS MOTEL Room 3 Motel Bed Storage', 1),
	('CrownJewelsMotel_4', 'CROWN JEWELS MOTEL Room 4 Motel Storage', 1),
	('CrownJewelsMotel_4_bed', 'CROWN JEWELS MOTEL Room 4 Motel Bed Storage', 1),
	('CrownJewelsMotel_5', 'CROWN JEWELS MOTEL Room 5 Motel Storage', 1),
	('CrownJewelsMotel_5_bed', 'CROWN JEWELS MOTEL Room 5 Motel Bed Storage', 1),
	('CrownJewelsMotel_6', 'CROWN JEWELS MOTEL Room 6 Motel Storage', 1),
	('CrownJewelsMotel_6_bed', 'CROWN JEWELS MOTEL Room 6 Motel Bed Storage', 1),
	('CrownJewelsMotel_7', 'CROWN JEWELS MOTEL Room 7 Motel Storage', 1),
	('CrownJewelsMotel_7_bed', 'CROWN JEWELS MOTEL Room 7 Motel Bed Storage', 1),
	('CrownJewelsMotel_8', 'CROWN JEWELS MOTEL Room 8 Motel Storage', 1),
	('CrownJewelsMotel_8_bed', 'CROWN JEWELS MOTEL Room 8 Motel Bed Storage', 1),
	('CrownJewelsMotel_9', 'CROWN JEWELS MOTEL Room 9 Motel Storage', 1),
	('CrownJewelsMotel_9_bed', 'CROWN JEWELS MOTEL Room 9 Motel Bed Storage', 1),
	('DreamViewMotel_1', 'DREAM VIEW MOTEL Room 1 Motel Storage', 1),
	('DreamViewMotel_11', 'DREAM VIEW MOTEL Room 11 Motel Storage', 1),
	('DreamViewMotel_11_bed', 'DREAM VIEW MOTEL Room 11 Motel Bed Storage', 1),
	('DreamViewMotel_12', 'DREAM VIEW MOTEL Room 12 Motel Storage', 1),
	('DreamViewMotel_12_bed', 'DREAM VIEW MOTEL Room 12 Motel Bed Storage', 1),
	('DreamViewMotel_13', 'DREAM VIEW MOTEL Room 13 Motel Storage', 1),
	('DreamViewMotel_13_bed', 'DREAM VIEW MOTEL Room 13 Motel Bed Storage', 1),
	('DreamViewMotel_14', 'DREAM VIEW MOTEL Room 14 Motel Storage', 1),
	('DreamViewMotel_14_bed', 'DREAM VIEW MOTEL Room 14 Motel Bed Storage', 1),
	('DreamViewMotel_15', 'DREAM VIEW MOTEL Room 15 Motel Storage', 1),
	('DreamViewMotel_15_bed', 'DREAM VIEW MOTEL Room 15 Motel Bed Storage', 1),
	('DreamViewMotel_16', 'DREAM VIEW MOTEL Room 16 Motel Storage', 1),
	('DreamViewMotel_16_bed', 'DREAM VIEW MOTEL Room 16 Motel Bed Storage', 1),
	('DreamViewMotel_17', 'DREAM VIEW MOTEL Room 17 Motel Storage', 1),
	('DreamViewMotel_17_bed', 'DREAM VIEW MOTEL Room 17 Motel Bed Storage', 1),
	('DreamViewMotel_18', 'DREAM VIEW MOTEL Room 18 Motel Storage', 1),
	('DreamViewMotel_18_bed', 'DREAM VIEW MOTEL Room 18 Motel Bed Storage', 1),
	('DreamViewMotel_19', 'DREAM VIEW MOTEL Room 19 Motel Storage', 1),
	('DreamViewMotel_19_bed', 'DREAM VIEW MOTEL Room 19 Motel Bed Storage', 1),
	('DreamViewMotel_1_bed', 'DREAM VIEW MOTEL Room 1 Motel Bed Storage', 1),
	('DreamViewMotel_2', 'DREAM VIEW MOTEL Room 2 Motel Storage', 1),
	('DreamViewMotel_20', 'DREAM VIEW MOTEL Room 20 Motel Storage', 1),
	('DreamViewMotel_20_bed', 'DREAM VIEW MOTEL Room 20 Motel Bed Storage', 1),
	('DreamViewMotel_21', 'DREAM VIEW MOTEL Room 21 Motel Storage', 1),
	('DreamViewMotel_21_bed', 'DREAM VIEW MOTEL Room 21 Motel Bed Storage', 1),
	('DreamViewMotel_22', 'DREAM VIEW MOTEL Room 22 Motel Storage', 1),
	('DreamViewMotel_22_bed', 'DREAM VIEW MOTEL Room 22 Motel Bed Storage', 1),
	('DreamViewMotel_2_bed', 'DREAM VIEW MOTEL Room 2 Motel Bed Storage', 1),
	('DreamViewMotel_3', 'DREAM VIEW MOTEL Room 3 Motel Storage', 1),
	('DreamViewMotel_3_bed', 'DREAM VIEW MOTEL Room 3 Motel Bed Storage', 1),
	('DreamViewMotel_4', 'DREAM VIEW MOTEL Room 4 Motel Storage', 1),
	('DreamViewMotel_4_bed', 'DREAM VIEW MOTEL Room 4 Motel Bed Storage', 1),
	('DreamViewMotel_5', 'DREAM VIEW MOTEL Room 5 Motel Storage', 1),
	('DreamViewMotel_5_bed', 'DREAM VIEW MOTEL Room 5 Motel Bed Storage', 1),
	('DreamViewMotel_6', 'DREAM VIEW MOTEL Room 6 Motel Storage', 1),
	('DreamViewMotel_6_bed', 'DREAM VIEW MOTEL Room 6 Motel Bed Storage', 1),
	('DreamViewMotel_7', 'DREAM VIEW MOTEL Room 7 Motel Storage', 1),
	('DreamViewMotel_7_bed', 'DREAM VIEW MOTEL Room 7 Motel Bed Storage', 1),
	('DreamViewMotel_8', 'DREAM VIEW MOTEL Room 8 Motel Storage', 1),
	('DreamViewMotel_8_bed', 'DREAM VIEW MOTEL Room 8 Motel Bed Storage', 1),
	('DreamViewMotel_9', 'DREAM VIEW MOTEL Room 9 Motel Storage', 1),
	('DreamViewMotel_9_bed', 'DREAM VIEW MOTEL Room 9 Motel Bed Storage', 1),
	('EasternMotel_1', 'EASTERN MOTEL Room 1 Motel Storage', 1),
	('EasternMotel_10', 'EASTERN MOTEL Room 10 Motel Storage', 1),
	('EasternMotel_10_bed', 'EASTERN MOTEL Room 10 Motel Bed Storage', 1),
	('EasternMotel_1_bed', 'EASTERN MOTEL Room 1 Motel Bed Storage', 1),
	('EasternMotel_2', 'EASTERN MOTEL Room 2 Motel Storage', 1),
	('EasternMotel_2_bed', 'EASTERN MOTEL Room 2 Motel Bed Storage', 1),
	('EasternMotel_3', 'EASTERN MOTEL Room 3 Motel Storage', 1),
	('EasternMotel_3_bed', 'EASTERN MOTEL Room 3 Motel Bed Storage', 1),
	('EasternMotel_4', 'EASTERN MOTEL Room 4 Motel Storage', 1),
	('EasternMotel_4_bed', 'EASTERN MOTEL Room 4 Motel Bed Storage', 1),
	('EasternMotel_5', 'EASTERN MOTEL Room 5 Motel Storage', 1),
	('EasternMotel_5_bed', 'EASTERN MOTEL Room 5 Motel Bed Storage', 1),
	('EasternMotel_6', 'EASTERN MOTEL Room 6 Motel Storage', 1),
	('EasternMotel_6_bed', 'EASTERN MOTEL Room 6 Motel Bed Storage', 1),
	('EasternMotel_7', 'EASTERN MOTEL Room 7 Motel Storage', 1),
	('EasternMotel_7_bed', 'EASTERN MOTEL Room 7 Motel Bed Storage', 1),
	('EasternMotel_8', 'EASTERN MOTEL Room 8 Motel Storage', 1),
	('EasternMotel_8_bed', 'EASTERN MOTEL Room 8 Motel Bed Storage', 1),
	('EasternMotel_9', 'EASTERN MOTEL Room 9 Motel Storage', 1),
	('EasternMotel_9_bed', 'EASTERN MOTEL Room 9 Motel Bed Storage', 1),
	('housing', 'Housing', 0),
	('motels', 'Motels Inventory', 0),
	('motels_bed', 'Motels Bed Inventory', 0),
	('PerreraBeachMotel_1', 'PERRERA BEACH MOTEL Room 1 Motel Storage', 1),
	('PerreraBeachMotel_10', 'PERRERA BEACH MOTEL Room 10 Motel Storage', 1),
	('PerreraBeachMotel_10_bed', 'PERRERA BEACH MOTEL Room 10 Motel Bed Storage', 1),
	('PerreraBeachMotel_11', 'PERRERA BEACH MOTEL Room 11 Motel Storage', 1),
	('PerreraBeachMotel_11_bed', 'PERRERA BEACH MOTEL Room 11 Motel Bed Storage', 1),
	('PerreraBeachMotel_12', 'PERRERA BEACH MOTEL Room 12 Motel Storage', 1),
	('PerreraBeachMotel_12_bed', 'PERRERA BEACH MOTEL Room 12 Motel Bed Storage', 1),
	('PerreraBeachMotel_13', 'PERRERA BEACH MOTEL Room 13 Motel Storage', 1),
	('PerreraBeachMotel_13_bed', 'PERRERA BEACH MOTEL Room 13 Motel Bed Storage', 1),
	('PerreraBeachMotel_14', 'PERRERA BEACH MOTEL Room 14 Motel Storage', 1),
	('PerreraBeachMotel_14_bed', 'PERRERA BEACH MOTEL Room 14 Motel Bed Storage', 1),
	('PerreraBeachMotel_15', 'PERRERA BEACH MOTEL Room 15 Motel Storage', 1),
	('PerreraBeachMotel_15_bed', 'PERRERA BEACH MOTEL Room 15 Motel Bed Storage', 1),
	('PerreraBeachMotel_16', 'PERRERA BEACH MOTEL Room 16 Motel Storage', 1),
	('PerreraBeachMotel_16_bed', 'PERRERA BEACH MOTEL Room 16 Motel Bed Storage', 1),
	('PerreraBeachMotel_17', 'PERRERA BEACH MOTEL Room 17 Motel Storage', 1),
	('PerreraBeachMotel_17_bed', 'PERRERA BEACH MOTEL Room 17 Motel Bed Storage', 1),
	('PerreraBeachMotel_18', 'PERRERA BEACH MOTEL Room 18 Motel Storage', 1),
	('PerreraBeachMotel_18_bed', 'PERRERA BEACH MOTEL Room 18 Motel Bed Storage', 1),
	('PerreraBeachMotel_19', 'PERRERA BEACH MOTEL Room 19 Motel Storage', 1),
	('PerreraBeachMotel_19_bed', 'PERRERA BEACH MOTEL Room 19 Motel Bed Storage', 1),
	('PerreraBeachMotel_1_bed', 'PERRERA BEACH MOTEL Room 1 Motel Bed Storage', 1),
	('PerreraBeachMotel_2', 'PERRERA BEACH MOTEL Room 2 Motel Storage', 1),
	('PerreraBeachMotel_20', 'PERRERA BEACH MOTEL Room 20 Motel Storage', 1),
	('PerreraBeachMotel_20_bed', 'PERRERA BEACH MOTEL Room 20 Motel Bed Storage', 1),
	('PerreraBeachMotel_21', 'PERRERA BEACH MOTEL Room 21 Motel Storage', 1),
	('PerreraBeachMotel_21_bed', 'PERRERA BEACH MOTEL Room 21 Motel Bed Storage', 1),
	('PerreraBeachMotel_22', 'PERRERA BEACH MOTEL Room 22 Motel Storage', 1),
	('PerreraBeachMotel_22_bed', 'PERRERA BEACH MOTEL Room 22 Motel Bed Storage', 1),
	('PerreraBeachMotel_23', 'PERRERA BEACH MOTEL Room 23 Motel Storage', 1),
	('PerreraBeachMotel_23_bed', 'PERRERA BEACH MOTEL Room 23 Motel Bed Storage', 1),
	('PerreraBeachMotel_24', 'PERRERA BEACH MOTEL Room 24 Motel Storage', 1),
	('PerreraBeachMotel_24_bed', 'PERRERA BEACH MOTEL Room 24 Motel Bed Storage', 1),
	('PerreraBeachMotel_25', 'PERRERA BEACH MOTEL Room 25 Motel Storage', 1),
	('PerreraBeachMotel_25_bed', 'PERRERA BEACH MOTEL Room 25 Motel Bed Storage', 1),
	('PerreraBeachMotel_26', 'PERRERA BEACH MOTEL Room 26 Motel Storage', 1),
	('PerreraBeachMotel_26_bed', 'PERRERA BEACH MOTEL Room 26 Motel Bed Storage', 1),
	('PerreraBeachMotel_27', 'PERRERA BEACH MOTEL Room 27 Motel Storage', 1),
	('PerreraBeachMotel_27_bed', 'PERRERA BEACH MOTEL Room 27 Motel Bed Storage', 1),
	('PerreraBeachMotel_28', 'PERRERA BEACH MOTEL Room 28 Motel Storage', 1),
	('PerreraBeachMotel_28_bed', 'PERRERA BEACH MOTEL Room 28 Motel Bed Storage', 1),
	('PerreraBeachMotel_29', 'PERRERA BEACH MOTEL Room 29 Motel Storage', 1),
	('PerreraBeachMotel_29_bed', 'PERRERA BEACH MOTEL Room 29 Motel Bed Storage', 1),
	('PerreraBeachMotel_2_bed', 'PERRERA BEACH MOTEL Room 2 Motel Bed Storage', 1),
	('PerreraBeachMotel_3', 'PERRERA BEACH MOTEL Room 3 Motel Storage', 1),
	('PerreraBeachMotel_30', 'PERRERA BEACH MOTEL Room 30 Motel Storage', 1),
	('PerreraBeachMotel_30_bed', 'PERRERA BEACH MOTEL Room 30 Motel Bed Storage', 1),
	('PerreraBeachMotel_31', 'PERRERA BEACH MOTEL Room 31 Motel Storage', 1),
	('PerreraBeachMotel_31_bed', 'PERRERA BEACH MOTEL Room 31 Motel Bed Storage', 1),
	('PerreraBeachMotel_32', 'PERRERA BEACH MOTEL Room 32 Motel Storage', 1),
	('PerreraBeachMotel_32_bed', 'PERRERA BEACH MOTEL Room 32 Motel Bed Storage', 1),
	('PerreraBeachMotel_33', 'PERRERA BEACH MOTEL Room 33 Motel Storage', 1),
	('PerreraBeachMotel_33_bed', 'PERRERA BEACH MOTEL Room 33 Motel Bed Storage', 1),
	('PerreraBeachMotel_34', 'PERRERA BEACH MOTEL Room 34 Motel Storage', 1),
	('PerreraBeachMotel_34_bed', 'PERRERA BEACH MOTEL Room 34 Motel Bed Storage', 1),
	('PerreraBeachMotel_35', 'PERRERA BEACH MOTEL Room 35 Motel Storage', 1),
	('PerreraBeachMotel_35_bed', 'PERRERA BEACH MOTEL Room 35 Motel Bed Storage', 1),
	('PerreraBeachMotel_36', 'PERRERA BEACH MOTEL Room 36 Motel Storage', 1),
	('PerreraBeachMotel_36_bed', 'PERRERA BEACH MOTEL Room 36 Motel Bed Storage', 1),
	('PerreraBeachMotel_37', 'PERRERA BEACH MOTEL Room 37 Motel Storage', 1),
	('PerreraBeachMotel_37_bed', 'PERRERA BEACH MOTEL Room 37 Motel Bed Storage', 1),
	('PerreraBeachMotel_38', 'PERRERA BEACH MOTEL Room 38 Motel Storage', 1),
	('PerreraBeachMotel_38_bed', 'PERRERA BEACH MOTEL Room 38 Motel Bed Storage', 1),
	('PerreraBeachMotel_3_bed', 'PERRERA BEACH MOTEL Room 3 Motel Bed Storage', 1),
	('PerreraBeachMotel_4', 'PERRERA BEACH MOTEL Room 4 Motel Storage', 1),
	('PerreraBeachMotel_4_bed', 'PERRERA BEACH MOTEL Room 4 Motel Bed Storage', 1),
	('PerreraBeachMotel_5', 'PERRERA BEACH MOTEL Room 5 Motel Storage', 1),
	('PerreraBeachMotel_5_bed', 'PERRERA BEACH MOTEL Room 5 Motel Bed Storage', 1),
	('PerreraBeachMotel_6', 'PERRERA BEACH MOTEL Room 6 Motel Storage', 1),
	('PerreraBeachMotel_6_bed', 'PERRERA BEACH MOTEL Room 6 Motel Bed Storage', 1),
	('PerreraBeachMotel_7', 'PERRERA BEACH MOTEL Room 7 Motel Storage', 1),
	('PerreraBeachMotel_7_bed', 'PERRERA BEACH MOTEL Room 7 Motel Bed Storage', 1),
	('PerreraBeachMotel_8', 'PERRERA BEACH MOTEL Room 8 Motel Storage', 1),
	('PerreraBeachMotel_8_bed', 'PERRERA BEACH MOTEL Room 8 Motel Bed Storage', 1),
	('PerreraBeachMotel_9', 'PERRERA BEACH MOTEL Room 9 Motel Storage', 1),
	('PerreraBeachMotel_9_bed', 'PERRERA BEACH MOTEL Room 9 Motel Bed Storage', 1),
	('property', 'PropriÃƒÆ’Ã‚Â©tÃƒÆ’Ã‚Â©', 0),
	('society_ambulance', 'Ambulance', 1),
	('society_ballas', 'Polizei', 1),
	('society_biker', 'Biker', 1),
	('society_cardealer', 'Cardealer', 1),
	('society_cartel', 'Cartel', 1),
	('society_fire', 'fire', 1),
	('society_gang', 'Gang', 1),
	('society_lawyer', 'lawyer', 1),
	('society_mafia', 'Mafia', 1),
	('society_mechanic', 'Mechanic', 1),
	('society_pizza', 'pizza', 1),
	('society_pizza_fridge', 'pizza (frigo)', 1),
	('society_police', 'Police', 1),
	('society_taxi', 'Taxi', 1),
	('TheMotorMotel_1', 'THE MOTOR MOTEL Room 1 Motel Storage', 1),
	('TheMotorMotel_10', 'THE MOTOR MOTEL Room 10 Motel Storage', 1),
	('TheMotorMotel_10_bed', 'THE MOTOR MOTEL Room 10 Motel Bed Storage', 1),
	('TheMotorMotel_11', 'THE MOTOR MOTEL Room 11 Motel Storage', 1),
	('TheMotorMotel_11_bed', 'THE MOTOR MOTEL Room 11 Motel Bed Storage', 1),
	('TheMotorMotel_12', 'THE MOTOR MOTEL Room 12 Motel Storage', 1),
	('TheMotorMotel_12_bed', 'THE MOTOR MOTEL Room 12 Motel Bed Storage', 1),
	('TheMotorMotel_1_bed', 'THE MOTOR MOTEL Room 1 Motel Bed Storage', 1),
	('TheMotorMotel_2', 'THE MOTOR MOTEL Room 2 Motel Storage', 1),
	('TheMotorMotel_2_bed', 'THE MOTOR MOTEL Room 2 Motel Bed Storage', 1),
	('TheMotorMotel_3', 'THE MOTOR MOTEL Room 3 Motel Storage', 1),
	('TheMotorMotel_3_bed', 'THE MOTOR MOTEL Room 3 Motel Bed Storage', 1),
	('TheMotorMotel_4', 'THE MOTOR MOTEL Room 4 Motel Storage', 1),
	('TheMotorMotel_4_bed', 'THE MOTOR MOTEL Room 4 Motel Bed Storage', 1),
	('TheMotorMotel_5', 'THE MOTOR MOTEL Room 5 Motel Storage', 1),
	('TheMotorMotel_5_bed', 'THE MOTOR MOTEL Room 5 Motel Bed Storage', 1),
	('TheMotorMotel_6', 'THE MOTOR MOTEL Room 6 Motel Storage', 1),
	('TheMotorMotel_6_bed', 'THE MOTOR MOTEL Room 6 Motel Bed Storage', 1),
	('TheMotorMotel_7', 'THE MOTOR MOTEL Room 7 Motel Storage', 1),
	('TheMotorMotel_7_bed', 'THE MOTOR MOTEL Room 7 Motel Bed Storage', 1),
	('TheMotorMotel_8', 'THE MOTOR MOTEL Room 8 Motel Storage', 1),
	('TheMotorMotel_8_bed', 'THE MOTOR MOTEL Room 8 Motel Bed Storage', 1),
	('TheMotorMotel_9', 'THE MOTOR MOTEL Room 9 Motel Storage', 1),
	('TheMotorMotel_9_bed', 'THE MOTOR MOTEL Room 9 Motel Bed Storage', 1),
	('ThePinkCageMotel_1', 'THE PINK CAGE MOTEL Room 1 Motel Storage', 1),
	('ThePinkCageMotel_11', 'THE PINK CAGE MOTEL Room 11 Motel Storage', 1),
	('ThePinkCageMotel_11_bed', 'THE PINK CAGE MOTEL Room 11 Motel Bed Storage', 1),
	('ThePinkCageMotel_12', 'THE PINK CAGE MOTEL Room 12 Motel Storage', 1),
	('ThePinkCageMotel_12_bed', 'THE PINK CAGE MOTEL Room 12 Motel Bed Storage', 1),
	('ThePinkCageMotel_13', 'THE PINK CAGE MOTEL Room 13 Motel Storage', 1),
	('ThePinkCageMotel_13_bed', 'THE PINK CAGE MOTEL Room 13 Motel Bed Storage', 1),
	('ThePinkCageMotel_14', 'THE PINK CAGE MOTEL Room 14 Motel Storage', 1),
	('ThePinkCageMotel_14_bed', 'THE PINK CAGE MOTEL Room 14 Motel Bed Storage', 1),
	('ThePinkCageMotel_15', 'THE PINK CAGE MOTEL Room 15 Motel Storage', 1),
	('ThePinkCageMotel_15_bed', 'THE PINK CAGE MOTEL Room 15 Motel Bed Storage', 1),
	('ThePinkCageMotel_16', 'THE PINK CAGE MOTEL Room 16 Motel Storage', 1),
	('ThePinkCageMotel_16_bed', 'THE PINK CAGE MOTEL Room 16 Motel Bed Storage', 1),
	('ThePinkCageMotel_17', 'THE PINK CAGE MOTEL Room 17 Motel Storage', 1),
	('ThePinkCageMotel_17_bed', 'THE PINK CAGE MOTEL Room 17 Motel Bed Storage', 1),
	('ThePinkCageMotel_18', 'THE PINK CAGE MOTEL Room 18 Motel Storage', 1),
	('ThePinkCageMotel_18_bed', 'THE PINK CAGE MOTEL Room 18 Motel Bed Storage', 1),
	('ThePinkCageMotel_19', 'THE PINK CAGE MOTEL Room 19 Motel Storage', 1),
	('ThePinkCageMotel_19_bed', 'THE PINK CAGE MOTEL Room 19 Motel Bed Storage', 1),
	('ThePinkCageMotel_1_bed', 'THE PINK CAGE MOTEL Room 1 Motel Bed Storage', 1),
	('ThePinkCageMotel_2', 'THE PINK CAGE MOTEL Room 2 Motel Storage', 1),
	('ThePinkCageMotel_20', 'THE PINK CAGE MOTEL Room 20 Motel Storage', 1),
	('ThePinkCageMotel_20_bed', 'THE PINK CAGE MOTEL Room 20 Motel Bed Storage', 1),
	('ThePinkCageMotel_21', 'THE PINK CAGE MOTEL Room 21 Motel Storage', 1),
	('ThePinkCageMotel_21_bed', 'THE PINK CAGE MOTEL Room 21 Motel Bed Storage', 1),
	('ThePinkCageMotel_22', 'THE PINK CAGE MOTEL Room 22 Motel Storage', 1),
	('ThePinkCageMotel_22_bed', 'THE PINK CAGE MOTEL Room 22 Motel Bed Storage', 1),
	('ThePinkCageMotel_23', 'THE PINK CAGE MOTEL Room 23 Motel Storage', 1),
	('ThePinkCageMotel_23_bed', 'THE PINK CAGE MOTEL Room 23 Motel Bed Storage', 1),
	('ThePinkCageMotel_24', 'THE PINK CAGE MOTEL Room 24 Motel Storage', 1),
	('ThePinkCageMotel_24_bed', 'THE PINK CAGE MOTEL Room 24 Motel Bed Storage', 1),
	('ThePinkCageMotel_25', 'THE PINK CAGE MOTEL Room 25 Motel Storage', 1),
	('ThePinkCageMotel_25_bed', 'THE PINK CAGE MOTEL Room 25 Motel Bed Storage', 1),
	('ThePinkCageMotel_26', 'THE PINK CAGE MOTEL Room 26 Motel Storage', 1),
	('ThePinkCageMotel_26_bed', 'THE PINK CAGE MOTEL Room 26 Motel Bed Storage', 1),
	('ThePinkCageMotel_27', 'THE PINK CAGE MOTEL Room 27 Motel Storage', 1),
	('ThePinkCageMotel_27_bed', 'THE PINK CAGE MOTEL Room 27 Motel Bed Storage', 1),
	('ThePinkCageMotel_28', 'THE PINK CAGE MOTEL Room 28 Motel Storage', 1),
	('ThePinkCageMotel_28_bed', 'THE PINK CAGE MOTEL Room 28 Motel Bed Storage', 1),
	('ThePinkCageMotel_29', 'THE PINK CAGE MOTEL Room 29 Motel Storage', 1),
	('ThePinkCageMotel_29_bed', 'THE PINK CAGE MOTEL Room 29 Motel Bed Storage', 1),
	('ThePinkCageMotel_2_bed', 'THE PINK CAGE MOTEL Room 2 Motel Bed Storage', 1),
	('ThePinkCageMotel_3', 'THE PINK CAGE MOTEL Room 3 Motel Storage', 1),
	('ThePinkCageMotel_30', 'THE PINK CAGE MOTEL Room 30 Motel Storage', 1),
	('ThePinkCageMotel_30_bed', 'THE PINK CAGE MOTEL Room 30 Motel Bed Storage', 1),
	('ThePinkCageMotel_31', 'THE PINK CAGE MOTEL Room 31 Motel Storage', 1),
	('ThePinkCageMotel_31_bed', 'THE PINK CAGE MOTEL Room 31 Motel Bed Storage', 1),
	('ThePinkCageMotel_32', 'THE PINK CAGE MOTEL Room 32 Motel Storage', 1),
	('ThePinkCageMotel_32_bed', 'THE PINK CAGE MOTEL Room 32 Motel Bed Storage', 1),
	('ThePinkCageMotel_33', 'THE PINK CAGE MOTEL Room 33 Motel Storage', 1),
	('ThePinkCageMotel_33_bed', 'THE PINK CAGE MOTEL Room 33 Motel Bed Storage', 1),
	('ThePinkCageMotel_34', 'THE PINK CAGE MOTEL Room 34 Motel Storage', 1),
	('ThePinkCageMotel_34_bed', 'THE PINK CAGE MOTEL Room 34 Motel Bed Storage', 1),
	('ThePinkCageMotel_36', 'THE PINK CAGE MOTEL Room 36 Motel Storage', 1),
	('ThePinkCageMotel_36_bed', 'THE PINK CAGE MOTEL Room 36 Motel Bed Storage', 1),
	('ThePinkCageMotel_37', 'THE PINK CAGE MOTEL Room 37 Motel Storage', 1),
	('ThePinkCageMotel_37_bed', 'THE PINK CAGE MOTEL Room 37 Motel Bed Storage', 1),
	('ThePinkCageMotel_39', 'THE PINK CAGE MOTEL Room 39 Motel Storage', 1),
	('ThePinkCageMotel_39_bed', 'THE PINK CAGE MOTEL Room 39 Motel Bed Storage', 1),
	('ThePinkCageMotel_3_bed', 'THE PINK CAGE MOTEL Room 3 Motel Bed Storage', 1),
	('ThePinkCageMotel_4', 'THE PINK CAGE MOTEL Room 4 Motel Storage', 1),
	('ThePinkCageMotel_4_bed', 'THE PINK CAGE MOTEL Room 4 Motel Bed Storage', 1),
	('ThePinkCageMotel_5a', 'THE PINK CAGE MOTEL Room 5a Motel Storage', 1),
	('ThePinkCageMotel_5a_bed', 'THE PINK CAGE MOTEL Room 5a Motel Bed Storage', 1),
	('ThePinkCageMotel_5b', 'THE PINK CAGE MOTEL Room 5b Motel Storage', 1),
	('ThePinkCageMotel_5b_bed', 'THE PINK CAGE MOTEL Room 5b Motel Bed Storage', 1),
	('ThePinkCageMotel_6', 'THE PINK CAGE MOTEL Room 6 Motel Storage', 1),
	('ThePinkCageMotel_6_bed', 'THE PINK CAGE MOTEL Room 6 Motel Bed Storage', 1),
	('ThePinkCageMotel_7', 'THE PINK CAGE MOTEL Room 7 Motel Storage', 1),
	('ThePinkCageMotel_7_bed', 'THE PINK CAGE MOTEL Room 7 Motel Bed Storage', 1),
	('ThePinkCageMotel_8', 'THE PINK CAGE MOTEL Room 8 Motel Storage', 1),
	('ThePinkCageMotel_8_bed', 'THE PINK CAGE MOTEL Room 8 Motel Bed Storage', 1),
	('ThePinkCageMotel_9', 'THE PINK CAGE MOTEL Room 9 Motel Storage', 1),
	('ThePinkCageMotel_9_bed', 'THE PINK CAGE MOTEL Room 9 Motel Bed Storage', 1),
	('TheRanchoMotel_13', 'THE RANCHO MOTEL Room 13 Motel Storage', 1),
	('TheRanchoMotel_13_bed', 'THE RANCHO MOTEL Room 13 Motel Bed Storage', 1),
	('TheRanchoMotel_14', 'THE RANCHO MOTEL Room 14 Motel Storage', 1),
	('TheRanchoMotel_14_bed', 'THE RANCHO MOTEL Room 14 Motel Bed Storage', 1),
	('TheRanchoMotel_15a', 'THE RANCHO MOTEL Room 15a Motel Storage', 1),
	('TheRanchoMotel_15a_bed', 'THE RANCHO MOTEL Room 15a Motel Bed Storage', 1),
	('TheRanchoMotel_15b', 'THE RANCHO MOTEL Room 15b Motel Storage', 1),
	('TheRanchoMotel_15b_bed', 'THE RANCHO MOTEL Room 15b Motel Bed Storage', 1),
	('TheRanchoMotel_16', 'THE RANCHO MOTEL Room 16 Motel Storage', 1),
	('TheRanchoMotel_16_bed', 'THE RANCHO MOTEL Room 16 Motel Bed Storage', 1),
	('TheRanchoMotel_17', 'THE RANCHO MOTEL Room 17 Motel Storage', 1),
	('TheRanchoMotel_17_bed', 'THE RANCHO MOTEL Room 17 Motel Bed Storage', 1),
	('vault', 'Vault', 0),
	('VonCrastenburgMotel_1', 'VON CRASTENBURG MOTEL Room 1 Motel Storage', 1),
	('VonCrastenburgMotel_10', 'VON CRASTENBURG MOTEL Room 10 Motel Storage', 1),
	('VonCrastenburgMotel_10_bed', 'VON CRASTENBURG MOTEL Room 10 Motel Bed Storage', 1),
	('VonCrastenburgMotel_11', 'VON CRASTENBURG MOTEL Room 11 Motel Storage', 1),
	('VonCrastenburgMotel_11_bed', 'VON CRASTENBURG MOTEL Room 11 Motel Bed Storage', 1),
	('VonCrastenburgMotel_12', 'VON CRASTENBURG MOTEL Room 12 Motel Storage', 1),
	('VonCrastenburgMotel_12_bed', 'VON CRASTENBURG MOTEL Room 12 Motel Bed Storage', 1),
	('VonCrastenburgMotel_13', 'VON CRASTENBURG MOTEL Room 13 Motel Storage', 1),
	('VonCrastenburgMotel_13_bed', 'VON CRASTENBURG MOTEL Room 13 Motel Bed Storage', 1),
	('VonCrastenburgMotel_14', 'VON CRASTENBURG MOTEL Room 14 Motel Storage', 1),
	('VonCrastenburgMotel_14_bed', 'VON CRASTENBURG MOTEL Room 14 Motel Bed Storage', 1),
	('VonCrastenburgMotel_15', 'VON CRASTENBURG MOTEL Room 15 Motel Storage', 1),
	('VonCrastenburgMotel_15_bed', 'VON CRASTENBURG MOTEL Room 15 Motel Bed Storage', 1),
	('VonCrastenburgMotel_16', 'VON CRASTENBURG MOTEL Room 16 Motel Storage', 1),
	('VonCrastenburgMotel_16_bed', 'VON CRASTENBURG MOTEL Room 16 Motel Bed Storage', 1),
	('VonCrastenburgMotel_17', 'VON CRASTENBURG MOTEL Room 17 Motel Storage', 1),
	('VonCrastenburgMotel_17_bed', 'VON CRASTENBURG MOTEL Room 17 Motel Bed Storage', 1),
	('VonCrastenburgMotel_18', 'VON CRASTENBURG MOTEL Room 18 Motel Storage', 1),
	('VonCrastenburgMotel_18_bed', 'VON CRASTENBURG MOTEL Room 18 Motel Bed Storage', 1),
	('VonCrastenburgMotel_19', 'VON CRASTENBURG MOTEL Room 19 Motel Storage', 1),
	('VonCrastenburgMotel_19_bed', 'VON CRASTENBURG MOTEL Room 19 Motel Bed Storage', 1),
	('VonCrastenburgMotel_1_bed', 'VON CRASTENBURG MOTEL Room 1 Motel Bed Storage', 1),
	('VonCrastenburgMotel_2', 'VON CRASTENBURG MOTEL Room 2 Motel Storage', 1),
	('VonCrastenburgMotel_20', 'VON CRASTENBURG MOTEL Room 20 Motel Storage', 1),
	('VonCrastenburgMotel_20_bed', 'VON CRASTENBURG MOTEL Room 20 Motel Bed Storage', 1),
	('VonCrastenburgMotel_21', 'VON CRASTENBURG MOTEL Room 21 Motel Storage', 1),
	('VonCrastenburgMotel_21_bed', 'VON CRASTENBURG MOTEL Room 21 Motel Bed Storage', 1),
	('VonCrastenburgMotel_22', 'VON CRASTENBURG MOTEL Room 22 Motel Storage', 1),
	('VonCrastenburgMotel_22_bed', 'VON CRASTENBURG MOTEL Room 22 Motel Bed Storage', 1),
	('VonCrastenburgMotel_23', 'VON CRASTENBURG MOTEL Room 23 Motel Storage', 1),
	('VonCrastenburgMotel_23_bed', 'VON CRASTENBURG MOTEL Room 23 Motel Bed Storage', 1),
	('VonCrastenburgMotel_2_bed', 'VON CRASTENBURG MOTEL Room 2 Motel Bed Storage', 1),
	('VonCrastenburgMotel_3', 'VON CRASTENBURG MOTEL Room 3 Motel Storage', 1),
	('VonCrastenburgMotel_3_bed', 'VON CRASTENBURG MOTEL Room 3 Motel Bed Storage', 1),
	('VonCrastenburgMotel_4', 'VON CRASTENBURG MOTEL Room 4 Motel Storage', 1),
	('VonCrastenburgMotel_4_bed', 'VON CRASTENBURG MOTEL Room 4 Motel Bed Storage', 1),
	('VonCrastenburgMotel_5', 'VON CRASTENBURG MOTEL Room 5 Motel Storage', 1),
	('VonCrastenburgMotel_5_bed', 'VON CRASTENBURG MOTEL Room 5 Motel Bed Storage', 1),
	('VonCrastenburgMotel_6', 'VON CRASTENBURG MOTEL Room 6 Motel Storage', 1),
	('VonCrastenburgMotel_6_bed', 'VON CRASTENBURG MOTEL Room 6 Motel Bed Storage', 1),
	('VonCrastenburgMotel_7', 'VON CRASTENBURG MOTEL Room 7 Motel Storage', 1),
	('VonCrastenburgMotel_7_bed', 'VON CRASTENBURG MOTEL Room 7 Motel Bed Storage', 1),
	('VonCrastenburgMotel_8', 'VON CRASTENBURG MOTEL Room 8 Motel Storage', 1),
	('VonCrastenburgMotel_8_bed', 'VON CRASTENBURG MOTEL Room 8 Motel Bed Storage', 1),
	('VonCrastenburgMotel_9', 'VON CRASTENBURG MOTEL Room 9 Motel Storage', 1),
	('VonCrastenburgMotel_9_bed', 'VON CRASTENBURG MOTEL Room 9 Motel Bed Storage', 1);
/*!40000 ALTER TABLE `addon_inventory` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.addon_inventory_items
CREATE TABLE IF NOT EXISTS `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB AUTO_INCREMENT=252 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.addon_inventory_items: ~0 rows (approximately)
/*!40000 ALTER TABLE `addon_inventory_items` DISABLE KEYS */;
/*!40000 ALTER TABLE `addon_inventory_items` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.admin_logs
CREATE TABLE IF NOT EXISTS `admin_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `identifier` varchar(50) DEFAULT NULL,
  `type` varchar(50) DEFAULT '',
  `log` varchar(255) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.admin_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `admin_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin_logs` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.announces
CREATE TABLE IF NOT EXISTS `announces` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job` varchar(1000) NOT NULL,
  `pic` varchar(5000) NOT NULL,
  `color` varchar(1000) NOT NULL DEFAULT '0',
  `name` varchar(1000) NOT NULL DEFAULT '0',
  `titlecolor` varchar(50) DEFAULT NULL,
  `colorbar` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.announces: ~0 rows (approximately)
/*!40000 ALTER TABLE `announces` DISABLE KEYS */;
/*!40000 ALTER TABLE `announces` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.arrests_list
CREATE TABLE IF NOT EXISTS `arrests_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.arrests_list: ~0 rows (approximately)
/*!40000 ALTER TABLE `arrests_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `arrests_list` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.billing
CREATE TABLE IF NOT EXISTS `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `sender` varchar(255) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.billing: ~0 rows (approximately)
/*!40000 ALTER TABLE `billing` DISABLE KEYS */;
/*!40000 ALTER TABLE `billing` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.bolos_list
CREATE TABLE IF NOT EXISTS `bolos_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.bolos_list: ~0 rows (approximately)
/*!40000 ALTER TABLE `bolos_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `bolos_list` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.bought_houses
CREATE TABLE IF NOT EXISTS `bought_houses` (
  `houseid` int(50) NOT NULL,
  PRIMARY KEY (`houseid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.bought_houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `bought_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `bought_houses` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.cardealer_vehicles
CREATE TABLE IF NOT EXISTS `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.cardealer_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `cardealer_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `cardealer_vehicles` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.characters
CREATE TABLE IF NOT EXISTS `characters` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `firstname` varchar(255) NOT NULL,
  `lastname` varchar(255) NOT NULL,
  `dateofbirth` varchar(255) NOT NULL,
  `sex` varchar(1) NOT NULL DEFAULT 'M',
  `height` varchar(128) NOT NULL,
  `lastdigits` varchar(255) DEFAULT NULL,
  `callsign` int(11) NOT NULL DEFAULT 0,
  `roomType` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.characters: ~0 rows (approximately)
/*!40000 ALTER TABLE `characters` DISABLE KEYS */;
/*!40000 ALTER TABLE `characters` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.character_current
CREATE TABLE IF NOT EXISTS `character_current` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` varchar(255) NOT NULL DEFAULT '',
  `model` longtext DEFAULT NULL,
  `drawables` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL,
  `drawtextures` longtext DEFAULT NULL,
  `proptextures` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_character_current_id` (`id`),
  KEY `IDX_character_current_model` (`model`(3072)),
  KEY `IDX_character_current_drawables` (`drawables`(3072)),
  KEY `IDX_character_current_props` (`props`(3072)),
  KEY `IDX_character_current_drawtextures` (`drawtextures`(3072)),
  KEY `IDX_character_current_proptextures` (`proptextures`(3072))
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.character_current: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_current` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_current` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.character_face
CREATE TABLE IF NOT EXISTS `character_face` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `hairColor` longtext DEFAULT NULL,
  `headBlend` varchar(255) DEFAULT NULL,
  `headStructure` longtext DEFAULT NULL,
  `headOverlay` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_character_face_id` (`id`),
  KEY `IDX_character_face_identifier` (`identifier`),
  KEY `IDX_character_face_hairColor` (`hairColor`(1024)),
  KEY `IDX_character_face_headBlend` (`headBlend`),
  KEY `IDX_character_face_headStructure` (`headStructure`(1024)),
  KEY `IDX_character_face_headOverlay` (`headOverlay`(1024))
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.character_face: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_face` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_face` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.character_outfits
CREATE TABLE IF NOT EXISTS `character_outfits` (
  `cid` varchar(255) DEFAULT NULL,
  `slot` int(11) NOT NULL,
  `name` varchar(255) DEFAULT '0',
  `model` longtext DEFAULT NULL,
  `drawables` longtext DEFAULT NULL,
  `props` longtext DEFAULT NULL,
  `drawtextures` longtext DEFAULT NULL,
  `proptextures` longtext DEFAULT NULL,
  `hairColor` longtext DEFAULT NULL,
  KEY `IDX_character_outfits_cid` (`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.character_outfits: ~0 rows (approximately)
/*!40000 ALTER TABLE `character_outfits` DISABLE KEYS */;
/*!40000 ALTER TABLE `character_outfits` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.cocaine
CREATE TABLE IF NOT EXISTS `cocaine` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `percent` int(11) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=32768;

-- Dumping data for table s1873_ffrp.cocaine: ~1 rows (approximately)
/*!40000 ALTER TABLE `cocaine` DISABLE KEYS */;
INSERT INTO `cocaine` (`id`, `type`, `status`, `percent`, `amount`) VALUES
	(1, 'cocaine', 0, 84, 83);
/*!40000 ALTER TABLE `cocaine` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.datastore
CREATE TABLE IF NOT EXISTS `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.datastore: ~0 rows (approximately)
/*!40000 ALTER TABLE `datastore` DISABLE KEYS */;
/*!40000 ALTER TABLE `datastore` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.datastore_data
CREATE TABLE IF NOT EXISTS `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.datastore_data: ~0 rows (approximately)
/*!40000 ALTER TABLE `datastore_data` DISABLE KEYS */;
/*!40000 ALTER TABLE `datastore_data` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.disc_ammo
CREATE TABLE IF NOT EXISTS `disc_ammo` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner` text NOT NULL,
  `hash` text NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.disc_ammo: ~0 rows (approximately)
/*!40000 ALTER TABLE `disc_ammo` DISABLE KEYS */;
/*!40000 ALTER TABLE `disc_ammo` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.disc_inventory
CREATE TABLE IF NOT EXISTS `disc_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` text NOT NULL,
  `type` text DEFAULT NULL,
  `data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.disc_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `disc_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `disc_inventory` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.disc_inventory_itemdata
CREATE TABLE IF NOT EXISTS `disc_inventory_itemdata` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text DEFAULT NULL,
  `weight` int(11) NOT NULL DEFAULT 0,
  `closeonuse` tinyint(1) NOT NULL DEFAULT 0,
  `max` int(11) NOT NULL DEFAULT 100,
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.disc_inventory_itemdata: ~0 rows (approximately)
/*!40000 ALTER TABLE `disc_inventory_itemdata` DISABLE KEYS */;
/*!40000 ALTER TABLE `disc_inventory_itemdata` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.dopeplants
CREATE TABLE IF NOT EXISTS `dopeplants` (
  `owner` varchar(50) NOT NULL,
  `plant` longtext NOT NULL,
  `plantid` bigint(20) NOT NULL,
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.dopeplants: ~0 rows (approximately)
/*!40000 ALTER TABLE `dopeplants` DISABLE KEYS */;
/*!40000 ALTER TABLE `dopeplants` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.dpkeybinds
CREATE TABLE IF NOT EXISTS `dpkeybinds` (
  `id` varchar(50) DEFAULT NULL,
  `keybind1` varchar(50) DEFAULT 'num4',
  `emote1` varchar(255) DEFAULT '',
  `keybind2` varchar(50) DEFAULT 'num5',
  `emote2` varchar(255) DEFAULT '',
  `keybind3` varchar(50) DEFAULT 'num6',
  `emote3` varchar(255) DEFAULT '',
  `keybind4` varchar(50) DEFAULT 'num7',
  `emote4` varchar(255) DEFAULT '',
  `keybind5` varchar(50) DEFAULT 'num8',
  `emote5` varchar(255) DEFAULT '',
  `keybind6` varchar(50) DEFAULT 'num9',
  `emote6` varchar(255) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.dpkeybinds: ~0 rows (approximately)
/*!40000 ALTER TABLE `dpkeybinds` DISABLE KEYS */;
/*!40000 ALTER TABLE `dpkeybinds` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.exploiter_logs
CREATE TABLE IF NOT EXISTS `exploiter_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `log` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.exploiter_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `exploiter_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `exploiter_logs` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.fine_types
CREATE TABLE IF NOT EXISTS `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT 0,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=140 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping data for table s1873_ffrp.fine_types: ~96 rows (approximately)
/*!40000 ALTER TABLE `fine_types` DISABLE KEYS */;
INSERT INTO `fine_types` (`id`, `label`, `amount`, `jailtime`, `category`) VALUES
	(1, 'Speeding over 10-25 MPH', 150, 0, 0),
	(2, 'Speeding over 25-50 MPH', 250, 0, 0),
	(3, 'Speeding over 50-75 MPH', 500, 0, 0),
	(4, 'Speeding over 75 > MPH', 1000, 0, 0),
	(5, 'Crossing a continuous line', 250, 0, 0),
	(6, 'Illegal U-Turn', 350, 0, 0),
	(7, 'Illegal Parking', 500, 0, 0),
	(8, 'Failing to stop at a Stop Sign', 350, 0, 0),
	(9, 'Failing to stop at a Red Light', 500, 0, 0),
	(10, 'Impeding traffic flow', 200, 0, 0),
	(11, 'Unroadworthy Vehicle', 1250, 0, 0),
	(12, 'Illegal vehicle modification', 500, 0, 0),
	(13, 'Illegal roadblock', 2500, 6, 0),
	(14, 'Hit and Run', 1000, 6, 1),
	(15, 'Negligent Driving', 800, 0, 0),
	(16, 'Reckless Driving', 1250, 12, 2),
	(17, 'Public Intoxication', 200, 0, 1),
	(18, 'Driving under the Influence', 750, 6, 1),
	(19, 'Jaywalking', 300, 0, 0),
	(20, 'Littering', 996, 0, 0),
	(21, 'Failure To Obey a Lawful Order', 950, 6, 0),
	(22, 'Resisting Arrest', 750, 10, 0),
	(23, 'Disorderly conduct', 600, 0, 1),
	(24, 'Harrasment', 850, 12, 2),
	(25, 'Obstruction of Justice', 1500, 15, 1),
	(26, 'Aiding and Abetting', 1750, 12, 2),
	(27, 'Failure to provide Information', 500, 0, 0),
	(28, 'Fraudelant Misinformation', 1250, 18, 1),
	(29, 'Misuse 911 or 311', 2500, 0, 2),
	(30, 'Bribery', 2500, 0, 2),
	(31, 'Damaging of government property', 950, 0, 0),
	(32, 'Destruction of government property', 1500, 12, 2),
	(33, 'Street racing', 2000, 18, 2),
	(34, 'Fleeing and Eluding ', 1475, 18, 2),
	(35, 'Attempted GTA', 850, 0, 2),
	(36, 'GTA - Grand Theft Auto', 1200, 10, 2),
	(37, 'Brandishing a weapon', 500, 0, 1),
	(38, 'Brandishing a firearm', 750, 0, 1),
	(39, 'Gang shooting', 2000, 18, 3),
	(40, 'Impersonating a Goverment Employee', 2000, 18, 2),
	(41, 'Kidnapping of a Civilan', 1750, 24, 3),
	(42, 'Kidnapping of an Goverment Employee', 5000, 48, 3),
	(43, 'Posession of Burglary tools', 500, 0, 1),
	(44, 'House Burglary', 1250, 12, 2),
	(45, 'Robbery of a Store', 1250, 12, 2),
	(46, 'Armed Robbery of a Store', 1750, 18, 3),
	(47, 'Armed Robbery of a Bank', 3750, 24, 3),
	(48, 'Armed Robbery of the Vangelico Store', 3750, 24, 3),
	(49, 'Assault of an Civillian', 750, 12, 3),
	(50, 'Assault of an Goverment Employee', 1000, 14, 3),
	(51, 'Assault with a Deadly Weapon on an Civillian', 1250, 16, 3),
	(52, 'Assault with a Deadly Weapon on an Goverment Employee', 1500, 20, 3),
	(53, 'Attempted Murder of a Civilian', 2500, 25, 3),
	(54, 'Attempted Murder of an Goverment Employee', 3000, 30, 3),
	(55, 'Criminal Threat', 2500, 12, 2),
	(56, 'Terroristic Threat', 5000, 30, 3),
	(57, 'GTA of a government issued vehicle', 5000, 40, 3),
	(58, 'Possession of a government issued equipment', 2500, 24, 2),
	(59, 'Possession of a government issued firearm', 5000, 48, 3),
	(60, 'Trespassing', 1000, 12, 1),
	(61, 'Trespassing on a Goverment Facility', 2000, 18, 2),
	(62, 'Trespassing on a Powerplant Facility', 3000, 30, 3),
	(63, 'Illegal Possession of Class 1 Firearm ', 4000, 12, 3),
	(64, 'Illegal Possession of Class 2 Firearm ', 8000, 24, 3),
	(65, 'Illegal Possession of Weapon Attachments', 5000, 18, 3),
	(66, 'Distribution of Illegal Class 1 Firearm', 10000, 24, 3),
	(67, 'Distribution of Illegal Class 2 Firearm', 15000, 48, 3),
	(68, 'Distribution of Illegal Weapon Attachments', 12500, 36, 3),
	(69, 'Possession of Marijuana', 1250, 0, 3),
	(70, 'Intent to distribute of Marijuana', 2000, 6, 3),
	(71, 'Distribution of Marijuana', 3000, 12, 3),
	(72, 'Production of Marijuana', 4500, 24, 3),
	(73, 'Possession of Oxy', 1750, 0, 3),
	(74, 'Intent to distribute of Oxy', 2500, 8, 3),
	(75, 'Distribution of Oxy', 3500, 16, 3),
	(76, 'Possession of Cocaine', 2250, 8, 3),
	(77, 'Intent to distribute of Cocaine ', 5000, 16, 3),
	(78, 'Distribution of Cocaine ', 10000, 32, 3),
	(79, 'Possession of Meth', 2000, 6, 3),
	(80, 'Intent to distribute of Meth ', 3500, 12, 3),
	(81, 'Distribution of Meth', 5000, 24, 3),
	(82, 'Production of Meth ', 8500, 32, 3),
	(83, 'Possession of LSD', 2500, 0, 3),
	(84, 'Distribution of LSD', 7500, 24, 3),
	(85, 'Possession of Stolen Goods ', 1000, 3, 1),
	(86, 'Vandalism', 1000, 6, 1),
	(87, 'Unlawful Discharge of a Firearm', 1500, 6, 2),
	(88, 'Fishing of an Endangered Species', 950, 6, 2),
	(89, 'Animal Cruelty', 1000, 6, 3),
	(90, 'Hunting', 3500, 0, 2),
	(91, 'Fraud', 0, 0, 3),
	(92, 'Terrorism', 0, 0, 3),
	(93, 'Corruption', 0, 0, 3),
	(94, 'Perjury', 0, 0, 3),
	(95, 'Murder of a Civilian', 0, 0, 3),
	(96, 'Murder of a Goverment Employee', 0, 0, 3);
/*!40000 ALTER TABLE `fine_types` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.glovebox_inventory
CREATE TABLE IF NOT EXISTS `glovebox_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.glovebox_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `glovebox_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `glovebox_inventory` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.houses
CREATE TABLE IF NOT EXISTS `houses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(55) NOT NULL DEFAULT '',
  `house_id` int(11) NOT NULL,
  `house_model` int(11) DEFAULT NULL,
  `house_name` varchar(255) DEFAULT '',
  `price` int(55) NOT NULL,
  `amountOwed` int(11) DEFAULT NULL,
  `lastpayment` int(50) DEFAULT 0,
  `locked` int(11) NOT NULL DEFAULT 1,
  `furniture` longtext NOT NULL DEFAULT '{}',
  `garage` longtext NOT NULL DEFAULT '{ "x": 0.0, "y": 0.0, "z": 0.0, "h":  0.0  }',
  `storage` longtext NOT NULL DEFAULT '{ "x": 0.0, "y": 0.0, "z": 0.0, "h":  0.0  }',
  `wardrobe` longtext NOT NULL DEFAULT '{ "x": 0.0, "y": 0.0, "z": 0.0, "h":  0.0  }',
  `backdoorinside` longtext DEFAULT '{ "x": 0.0, "y": 0.0, "z": 0.0, "h":  0.0  }',
  `backdooroutside` longtext DEFAULT '{ "x": 0.0, "y": 0.0, "z": 0.0, "h":  0.0  }',
  PRIMARY KEY (`id`),
  KEY `IDX_houses_owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `houses` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.house_inventory
CREATE TABLE IF NOT EXISTS `house_inventory` (
  `house` varchar(50) DEFAULT NULL,
  `item` varchar(50) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `itemslot` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT 'item'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.house_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `house_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `house_inventory` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.items
CREATE TABLE IF NOT EXISTS `items` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `limit` int(11) NOT NULL DEFAULT -1,
  `rare` int(11) NOT NULL DEFAULT 0,
  `can_remove` int(11) NOT NULL DEFAULT 1,
  `price` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `label` (`label`)
) ENGINE=InnoDB AUTO_INCREMENT=968 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.items: ~967 rows (approximately)
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` (`id`, `name`, `label`, `limit`, `rare`, `can_remove`, `price`) VALUES
	(1, '9mm_rounds', '9mm Rounds', -1, 0, 1, 100),
	(2, 'access_key', 'Access Key', 1, 0, 1, 0),
	(3, 'advancedlockpick', 'Multi-pick', -1, 0, 1, 3250),
	(4, 'airbag', 'Airbag', -1, 0, 1, 0),
	(5, 'alive_chicken', 'Alive Chicken', 20, 0, 1, 0),
	(6, 'ammoanalyzer', 'Ammo Analyzer', -1, 0, 1, 0),
	(7, 'arAmmo', 'Assault Rifle Ammo', 5, 0, 1, 180),
	(8, 'armour', 'Armour', 2, 0, 1, 750),
	(9, 'bag', 'Bag', 1, 0, 1, 0),
	(10, 'bagofdope', '4oz Bag of weed', 15, 0, 1, 0),
	(11, 'band', 'Wristband', -1, 0, 1, 0),
	(12, 'bandage', 'Bandage', -1, 0, 1, 25),
	(13, 'bandage2', 'Small Bandage', -1, 0, 1, 0),
	(14, 'bankidcard', 'Bank ID', -1, 0, 1, 0),
	(15, 'barbecue', 'Barbecue Pizza', -1, 0, 1, 0),
	(16, 'battery', 'Car Battery', -1, 0, 1, 0),
	(17, 'beer', 'beer', -1, 0, 1, 8),
	(18, 'binoculars', 'Binoculars', -1, 0, 1, 50),
	(19, 'bloodsample', 'Blood Sample', -1, 0, 1, 0),
	(20, 'blowpipe', 'Blowpipe', -1, 0, 1, 0),
	(21, 'blunt', 'Blunt', -1, 0, 1, 0),
	(22, 'bobbypin', 'Bobbypin', -1, 0, 1, 0),
	(23, 'bread', 'Bread', -1, 0, 1, 5),
	(24, 'bulletsample', 'Bullet Sample', -1, 0, 1, 0),
	(25, 'cajadecamarones', 'Prawn Box', -1, 0, 1, 0),
	(26, 'cajadecangrejos', 'Crab Box', -1, 0, 1, 0),
	(27, 'calzone', 'Calzone', -1, 0, 1, 0),
	(28, 'camarones', 'Prawns', -1, 0, 1, 0),
	(29, 'camera', 'Camera', -1, 0, 1, 0),
	(30, 'cangrejos', 'Crabs', -1, 0, 1, 0),
	(31, 'cannabinoid', 'chemicals', -1, 0, 1, 0),
	(32, 'cannabis', 'Cannabis', 40, 0, 1, 0),
	(33, 'carbon', 'coal', -1, 0, 1, 0),
	(34, 'carokit', 'Body kit', -1, 0, 1, 0),
	(35, 'carotool', 'Body Tools', -1, 0, 1, 0),
	(36, 'cburger', 'Cheese Burger', -1, 0, 1, 2),
	(37, 'cchip', 'Casino Chip', -1, 0, 1, 0),
	(38, 'chicken_a', 'Chicken', 40, 0, 1, 0),
	(39, 'cigarette', 'Cigarette', 20, 0, 1, 1),
	(40, 'clip', 'Weapon Clip', -1, 0, 1, 0),
	(41, 'clothe', 'Clothing', -1, 0, 1, 0),
	(42, 'coffee', 'coffee', -1, 0, 1, 3),
	(43, 'coke', 'Cocaine', 0, 0, 1, 0),
	(44, 'coke_pooch', 'Bag of coke', 0, 0, 1, 0),
	(45, 'cola', 'Can of Cola', -1, 0, 1, 0),
	(46, 'copper', 'Copper', 500, 0, 1, 0),
	(47, 'crack', 'Crack Cocaine', -1, 0, 1, 0),
	(48, 'cutted_wood', 'Cut Wood', 20, 0, 1, 0),
	(49, 'dcburger', 'Double Cheese Burger', -1, 0, 1, 0),
	(50, 'diamond', 'Diamond', 50, 0, 1, 0),
	(51, 'disc_ammo_pistol', 'Pistol Ammo', 10, 0, 1, 0),
	(52, 'disc_ammo_pistol_large', 'Pistol Ammo Large', -10, 0, 1, 0),
	(53, 'disc_ammo_rifle', 'Rifle Ammo', 10, 0, 1, 0),
	(54, 'disc_ammo_rifle_large', 'Rifle Ammo Large', 10, 0, 1, 0),
	(55, 'disc_ammo_shotgun', 'Shotgun Shells', 10, 0, 1, 0),
	(56, 'disc_ammo_shotgun_large', 'Shotgun Shells Large', 10, 0, 1, 0),
	(57, 'disc_ammo_smg', 'SMG Ammo', 10, 0, 1, 0),
	(58, 'disc_ammo_smg_large', 'SMG Ammo Large', 10, 0, 1, 0),
	(59, 'disc_ammo_snp', 'Sniper Ammo', 10, 0, 1, 0),
	(60, 'disc_ammo_snp_large', 'Sniper Ammo Large', 10, 0, 1, 0),
	(61, 'dnaanalyzer', 'Dna Analyzer', 2, 0, 1, 0),
	(62, 'donut', 'Glazed Donut', -1, 0, 1, 50),
	(63, 'donut2', 'Super Donut', -1, 0, 1, 0),
	(64, 'dopebag', 'Haze Bag', -1, 0, 1, 100),
	(65, 'drugscales', 'Drug Scales', -1, 0, 1, 1000),
	(66, 'electronics', 'Electronics', 500, 1, 1, 0),
	(67, 'essence', 'Essence', 24, 0, 1, 0),
	(68, 'fabric', 'Fabric', 80, 0, 1, 0),
	(69, 'firstaid', 'First-Aid Kit', 10, 0, 1, 550),
	(70, 'fish', 'Fish', 100, 0, 1, 0),
	(71, 'fishbait', 'Fish Bait', -1, 0, 1, 0),
	(72, 'fishingrod', 'Fishing Rod', -1, 0, 1, 0),
	(73, 'fixkit', 'Repair Kit', 5, 0, 1, 500),
	(74, 'fixtool', 'Repair Tool', 6, 0, 1, 0),
	(75, 'flashlight', 'Flashlight weapon attachment', -1, 0, 1, 100),
	(76, 'fountain', 'Fountain Firework', -1, 0, 1, 0),
	(77, 'Fried_b', 'Fried Chicken', 40, 0, 1, 0),
	(78, 'fries', 'Small Fries', -1, 0, 1, 2),
	(79, 'fries2', 'Large Fries', -1, 0, 1, 0),
	(80, 'gauze', 'Gauze', 25, 0, 1, 0),
	(81, 'gazbottle', 'Gaz Bottle', 11, 0, 1, 0),
	(82, 'gold', 'Gold', 100, 0, 1, 0),
	(83, 'goldbar', 'Goldbar', -1, 0, 1, 0),
	(84, 'goldNecklace', 'Gold Necklace', -1, 0, 1, 0),
	(85, 'gold_o', 'Scrap gold', -1, 0, 1, 0),
	(86, 'gold_t', 'Gold', -1, 0, 1, 0),
	(87, 'goodbread', 'Bread', -1, 0, 1, 0),
	(88, 'grip', 'Grip', -1, 0, 1, 100),
	(89, 'gunpowder', 'gunpowder', 1, 0, 1, 0),
	(90, 'handcuffs', 'handcuffs', -1, 0, 1, 0),
	(91, 'hatchet_lj', 'hatchet', 1, 0, 1, 800),
	(92, 'HeavyArmor', 'Heavy Body Armor', 3, 0, 1, 0),
	(93, 'hierro', 'iron', 100, 0, 1, 0),
	(94, 'highgradefemaleseed', 'Female Haze Seed+', -1, 0, 1, 0),
	(95, 'highgradefert', 'High-Grade Fertilizer', -1, 0, 1, 100),
	(96, 'highgrademaleseed', 'Male Haze Seed+', -1, 0, 1, 0),
	(97, 'highradio', 'Aftermarket Radio', -1, 0, 1, 0),
	(98, 'highrim', 'Nice Rim', -1, 0, 1, 0),
	(99, 'honey_a', 'Honeycomb', -1, 0, 1, 0),
	(100, 'honey_b', 'honey', -1, 0, 1, 0),
	(101, 'hotdog', 'Hotdog', -1, 0, 1, 0),
	(102, 'hydrocodone', 'Hydrocodone', 5, 0, 1, 0),
	(103, 'ied', 'ied', -1, 0, 1, 0),
	(104, 'ifak', 'IFAK', -1, 0, 1, 70),
	(105, 'ing', 'Ingredients', -1, 0, 1, 0),
	(106, 'iron', 'Iron', 250, 0, 1, 0),
	(107, 'jammeth', 'Meth', -1, 0, 1, 0),
	(108, 'jewels', 'Jewels', -1, 0, 1, 0),
	(109, 'joint', 'Joint', -1, 0, 1, 0),
	(110, 'jumelles', 'Jumelles', 1, 0, 1, 0),
	(111, 'key', 'key', -1, 0, 1, 0),
	(112, 'keycard', 'Keycard', -1, 0, 1, 0),
	(113, 'laptop', 'Laptop', -1, 0, 1, 0),
	(114, 'leather', 'Leather', -1, 0, 1, 0),
	(115, 'licenseplate', 'License plate', -1, 0, 1, 0),
	(116, 'litter', 'Litter', -1, 0, 1, 0),
	(117, 'litter_pooch', 'Litter', -1, 0, 1, 0),
	(118, 'lockpick', 'lockpick', -1, 0, 1, 1000),
	(119, 'lotteryticket', 'Lottery Ticket', -1, 0, 1, 0),
	(120, 'lowgradefemaleseed', 'Female Haze Seed', -1, 0, 1, 0),
	(121, 'lowgradefert', 'Low-Grade Fertilizer', -1, 0, 1, 50),
	(122, 'lowgrademaleseed', 'Male Haze Seed', -1, 0, 1, 0),
	(123, 'lowradio', 'Stock Radio', -1, 0, 1, 0),
	(124, 'lsd', 'Lsd', -1, 0, 1, 0),
	(125, 'lsd_pooch', 'LSD Pouch', -1, 0, 1, 0),
	(126, 'marijuana', 'Bag of weed', 14, 0, 1, 0),
	(127, 'meat', 'Meat', -1, 0, 1, 0),
	(128, 'MedArmor', 'Medium Body Armor', 3, 0, 1, 0),
	(129, 'medikit', 'Medikit', 5, 0, 1, 0),
	(130, 'medkit', 'Medkit', 5, 0, 1, 550),
	(131, 'meth', 'Meth', -1, 0, 1, 0),
	(132, 'meth_pooch', 'Bag Of Meth', -1, 0, 1, 0),
	(133, 'mgAmmo', 'Maching gun ammo', 5, 0, 1, 250),
	(134, 'milkbottle', 'Milk Bottle', -1, 0, 1, 0),
	(135, 'mining_lease', 'Pickaxe', -1, 0, 1, 0),
	(136, 'mleko', 'Milk', -1, 0, 1, 0),
	(137, 'monster', 'Monster Energy', -1, 0, 1, 2),
	(138, 'morphine', 'Morphine', 5, 0, 1, 0),
	(139, 'notepad', 'Notepad', 1, 0, 1, 0),
	(140, 'opium', 'Opium', -1, 0, 1, 0),
	(141, 'opium_pooch', 'Bag Of Opium ', -1, 0, 1, 0),
	(142, 'orientale', 'Orientale Pizza', -1, 0, 1, 0),
	(143, 'oro', 'ore', -1, 0, 1, 0),
	(144, 'oxy', 'Oxy', -1, 0, 1, 0),
	(145, 'oxycutter', 'Plasma Torch', -1, 0, 1, 3000),
	(146, 'oxygen_mask', 'Oxygen Mask', -1, 0, 1, 0),
	(147, 'packaged_chicken', 'chicken fillet', 20, 0, 1, 0),
	(148, 'packaged_plank', 'packaged wood', 100, 0, 1, 0),
	(149, 'pAmmo', 'Pistol Ammo', 5, 0, 1, 200),
	(150, 'papers', 'Rolling Papers', -1, 0, 1, 20),
	(151, 'pate', 'Pate', -1, 0, 1, 0),
	(152, 'petrol', 'oil', 24, 0, 1, 0),
	(153, 'petrol_raffin', 'processed oil', 24, 0, 1, 0),
	(154, 'phone', 'phone', -1, 0, 1, 450),
	(155, 'pickaxe', 'Pickaxe', -1, 0, 1, 800),
	(156, 'pildora', 'Pill', 5, 0, 1, 0),
	(157, 'Pistol MK2', 'WEAPON_PISTOL_MK2', 1, 0, 1, 0),
	(158, 'plantpot', 'Plant Pot', -1, 0, 1, 50),
	(159, 'plastic', 'Plastic', 500, 1, 1, 0),
	(160, 'plata', 'silver', -1, 0, 1, 0),
	(161, 'playersafe', 'Player Safe', 1, 0, 1, 0),
	(162, 'pro_wood', 'Logs', 100, 0, 1, 0),
	(163, 'purifiedwater', 'Purified Water', -1, 0, 1, 100),
	(164, 'radio', 'radio', -1, 0, 1, 1500),
	(165, 'raw_ore', 'Raw Ore', -1, 0, 1, 0),
	(166, 'regine', 'Pizza Pure', -1, 0, 1, 0),
	(167, 'repairkit', 'Repairkit', 3, 0, 1, 500),
	(168, 'ring', 'Ring', -1, 0, 1, 0),
	(169, 'rolex', 'Rolex', -1, 0, 1, 0),
	(170, 'rope', 'Rope', -1, 0, 1, 0),
	(171, 'rubberband', 'rubberband', 1, 0, 1, 0),
	(172, 'samsungS10', 'Samsung Phone', -1, 0, 1, 0),
	(173, 'saumons', 'Salmon Pizza', -1, 0, 1, 0),
	(174, 'Scrap', 'Scrap Metal', 35, 1, 1, 0),
	(175, 'screwdriver', 'Screwdriver', -1, 0, 1, 0),
	(176, 'sgAmmo', 'Shotgun Shells', 5, 0, 1, 130),
	(177, 'shark', 'Shark', -1, 0, 1, 0),
	(178, 'shotburst', 'Shotburst Firework', -1, 0, 1, 0),
	(179, 'shotgun_shells', 'Shotgun Shells', 20, 0, 1, 800),
	(180, 'silencieux', 'Silencer', -1, 0, 1, 0),
	(181, 'sim', 'Sim', -1, 0, 1, 50),
	(182, 'slaughtered_chicken', 'slaughtered chicken', 20, 0, 1, 0),
	(183, 'SmallArmor', 'Light Body Armor', 3, 0, 1, 0),
	(184, 'spice', 'Bag of spice', 5, 0, 1, 0),
	(185, 'sprite', 'Bottle of 7UP', -1, 0, 1, 2),
	(186, 'starburst', 'Starburst Firework', -1, 0, 1, 0),
	(187, 'steel', 'steel', 500, 0, 1, 0),
	(188, 'SteelScrap', 'scrap', -1, 0, 1, 0),
	(189, 'stockrim', 'Stock Rim', -1, 0, 1, 0),
	(190, 'stone', 'Stone', 7, 0, 1, 0),
	(191, 'stones', 'Stones', 40, 0, 1, 0),
	(192, 'taco', 'Taco', -1, 0, 1, 0),
	(193, 'taco2', 'Deluxe Taco', -1, 0, 1, 0),
	(194, 'taco3', 'Steves Special Taco', -1, 0, 1, 0),
	(195, 'taco4', 'Super Taco', -1, 0, 1, 0),
	(196, 'thermite', 'Thermite', 100, 0, 1, 0),
	(197, 'trailburst', 'Trailburst Firework', -1, 0, 1, 0),
	(198, 'trimmedweed', 'Trimmed Weed', -1, 0, 1, 0),
	(199, 'truckcard', 'Security Card', -1, 0, 1, 0),
	(200, 'tuning_laptop', 'Tunable ECU', -1, 0, 1, 0),
	(201, 'turbo', 'Turbo', -1, 0, 1, 0),
	(202, 'turtle', 'Turtle', -1, 0, 1, 0),
	(203, 'turtlebait', 'Turtle Bait', 10, 0, 1, 0),
	(204, 'turtle_pooch', 'Turtles', -1, 0, 1, 0),
	(205, 'tyrekit', 'Tyrekit', 3, 0, 1, 1500),
	(206, 'valuable_goods', 'Valuable Goods', -1, 0, 1, 0),
	(207, 'vicodin', 'Vicodin', 5, 0, 1, 0),
	(208, 'vipband', 'VIP Wristband', -1, 0, 1, 0),
	(209, 'vodka', 'vodka', -1, 0, 1, 8),
	(210, 'warehouse_key', 'Warehouse Key', 1, 0, 1, 0),
	(211, 'washedstones', 'Washed stones', 40, 0, 1, 0),
	(212, 'washed_stone', 'Washed Stone', 7, 0, 1, 0),
	(213, 'water', 'Water', -1, 0, 1, 5),
	(214, 'wateringcan', 'Watering Can', -1, 0, 1, 50),
	(215, 'WEAPON_ADVANCEDRIFLE', 'Advanced Rifle', 1, 0, 1, 0),
	(216, 'WEAPON_APPISTOL', 'AP Pistol', 5, 0, 1, 0),
	(217, 'WEAPON_ASSAULTRIFLE', 'Assault Rifle', 5, 0, 1, 0),
	(218, 'WEAPON_ASSAULTSHOTGUN', 'Assault Shotgun', 1, 0, 1, 0),
	(219, 'WEAPON_ASSAULTSMG', 'Assault SMG', 1, 0, 1, 0),
	(220, 'WEAPON_AUTOSHOTGUN', 'Auto Shotgun', 1, 0, 1, 0),
	(221, 'WEAPON_BALL', 'Ball', 1, 0, 1, 0),
	(222, 'WEAPON_BAT', 'Baseball Bat', -1, 0, 1, 750),
	(223, 'WEAPON_BATTLEAXE', 'Battle Axe', 1, 0, 1, 0),
	(224, 'WEAPON_BOTTLE', 'Bottle', 1, 0, 1, 0),
	(225, 'WEAPON_BULLPUPRIFLE', 'Bullpup Rifle', 1, 0, 1, 0),
	(226, 'WEAPON_BULLPUPSHOTGUN', 'Bullpup Shotgun', 1, 0, 1, 0),
	(227, 'WEAPON_BZGAS', 'BZ Gas', 1, 0, 1, 0),
	(228, 'WEAPON_CARBINERIFLE', 'Carbine Rifle', 1, 0, 1, 0),
	(229, 'WEAPON_COMBATMG', 'Combat MG', 1, 0, 1, 0),
	(230, 'WEAPON_COMBATPDW', 'Combat PDW', 1, 0, 1, 0),
	(231, 'WEAPON_COMBATPISTOL', 'PD Glock', 1, 0, 1, 100),
	(232, 'WEAPON_COMPACTLAUNCHER', 'Compact Launcher', 1, 0, 1, 0),
	(233, 'WEAPON_COMPACTRIFLE', 'Compact Rifle', 1, 0, 1, 0),
	(234, 'WEAPON_CROWBAR', 'Crowbar', 1, 0, 1, 0),
	(235, 'WEAPON_DAGGER', 'Dagger', 1, 0, 1, 0),
	(236, 'WEAPON_DBSHOTGUN', 'Double Barrel Shotgun', 1, 0, 1, 0),
	(237, 'WEAPON_DIGISCANNER', 'Digiscanner', 1, 0, 1, 0),
	(238, 'WEAPON_DOUBLEACTION', 'Double Action Revolver', 1, 0, 1, 0),
	(239, 'WEAPON_FIREEXTINGUISHER', 'Fire Extinguisher', 1, 0, 1, 0),
	(240, 'WEAPON_FIREWORK', 'Firework Launcher', 1, 0, 1, 0),
	(241, 'WEAPON_FLARE', 'Flare', 1, 0, 1, 0),
	(242, 'WEAPON_FLAREGUN', 'Flare Gun', 1, 0, 1, 0),
	(243, 'WEAPON_FLASHLIGHT', 'Flashlight', -1, 0, 1, 350),
	(244, 'WEAPON_GARBAGEBAG', 'Garbage Bag', 1, 0, 1, 0),
	(245, 'WEAPON_GOLFCLUB', 'Golf Club', 1, 0, 1, 0),
	(246, 'WEAPON_GRENADE', 'Grenade', 1, 0, 1, 0),
	(247, 'WEAPON_GRENADELAUNCHER', 'Gernade Launcher', 1, 0, 1, 0),
	(248, 'WEAPON_GUSENBERG', 'Gusenberg', 1, 0, 1, 0),
	(249, 'WEAPON_HAMMER', 'Hammer', -1, 0, 1, 600),
	(250, 'WEAPON_HANDCUFFS', 'Handcuffs', 1, 0, 1, 0),
	(251, 'WEAPON_HATCHET', 'Hatchet', 1, 0, 1, 0),
	(252, 'WEAPON_HEAVYPISTOL', 'Heavy Pistol', 1, 0, 1, 0),
	(253, 'WEAPON_HEAVYSHOTGUN', 'Heavy Shotgun', 1, 0, 1, 0),
	(254, 'WEAPON_HEAVYSNIPER', 'Heavy Sniper', 1, 0, 1, 0),
	(255, 'WEAPON_HOMINGLAUNCHER', 'Homing Launcher', 1, 0, 1, 0),
	(256, 'WEAPON_KNIFE', 'Knife', -1, 0, 1, 400),
	(257, 'WEAPON_KNUCKLE', 'Knuckle Dusters ', 1, 0, 1, 0),
	(258, 'WEAPON_MACHETE', 'Machete', 1, 0, 1, 0),
	(259, 'WEAPON_MACHINEPISTOL', 'Machine Pistol', 5, 0, 1, 0),
	(260, 'WEAPON_MARKSMANPISTOL', 'Marksman Pistol', 1, 0, 1, 0),
	(261, 'WEAPON_MARKSMANRIFLE', 'Marksman Rifle', 1, 0, 1, 0),
	(262, 'WEAPON_MG', 'MG', 1, 0, 1, 0),
	(263, 'WEAPON_MICROSMG', 'Micro SMG', 1, 0, 1, 0),
	(264, 'WEAPON_MINIGUN', 'Minigun', 1, 0, 1, 0),
	(265, 'WEAPON_MINISMG', 'Mini SMG', 1, 0, 1, 0),
	(266, 'WEAPON_MOLOTOV', 'Molotov', 1, 0, 1, 0),
	(267, 'WEAPON_MUSKET', 'Musket', 1, 0, 1, 0),
	(268, 'WEAPON_NIGHTSTICK', 'Police Baton', 1, 0, 1, 0),
	(269, 'WEAPON_PETROLCAN', 'Petrol Can', 1, 0, 1, 0),
	(270, 'WEAPON_PIPEBOMB', 'Pipe Bomb', 1, 0, 1, 0),
	(271, 'WEAPON_PISTOL', 'Pistol', 5, 0, 1, 1000),
	(272, 'WEAPON_PISTOL50', 'Police .50', 5, 0, 1, 0),
	(273, 'WEAPON_POOLCUE', 'Pool Cue', 1, 0, 1, 0),
	(274, 'WEAPON_PROXMINE', 'Proximity Mine', 1, 0, 1, 0),
	(275, 'WEAPON_PUMPSHOTGUN', 'Pump Shotgun', 1, 0, 1, 8000),
	(276, 'WEAPON_RAILGUN', 'Rail Gun', 1, 0, 1, 0),
	(277, 'WEAPON_REVOLVER', 'Revolver', 1, 0, 1, 0),
	(278, 'WEAPON_RPG', 'RPG', 1, 0, 1, 0),
	(279, 'WEAPON_SAWNOFFSHOTGUN', 'Sawn Off Shotgun', 1, 0, 1, 0),
	(280, 'WEAPON_SMG', 'SMG', 1, 0, 1, 0),
	(281, 'WEAPON_SMOKEGRENADE', 'Smoke Gernade', 1, 0, 1, 0),
	(282, 'WEAPON_SNIPERRIFLE', 'Sniper Rifle', 1, 0, 1, 0),
	(283, 'WEAPON_SNOWBALL', 'Snow Ball', 1, 0, 1, 0),
	(284, 'WEAPON_SNSPISTOL', 'SNS Pistol', 1, 0, 1, 0),
	(285, 'WEAPON_SPECIALCARBINE', 'Special Rifle', 1, 0, 1, 0),
	(286, 'WEAPON_STICKYBOMB', 'Sticky Bombs', 1, 0, 1, 0),
	(287, 'WEAPON_STINGER', 'Stinger', 1, 0, 1, 0),
	(288, 'WEAPON_STUNGUN', 'Taser', 1, 0, 1, 100),
	(289, 'WEAPON_SWITCHBLADE', 'Switch Blade', 1, 0, 1, 0),
	(290, 'WEAPON_VINTAGEPISTOL', 'Vintage Pistol', 5, 0, 1, 0),
	(291, 'WEAPON_WRENCH', 'Wrench', 5, 0, 1, 0),
	(292, 'weed', 'Weed', -1, 0, 1, 0),
	(293, 'weedbag', '', -1, 0, 1, 0),
	(294, 'weed_pooch', 'Bag Of Weed ', -1, 0, 1, 0),
	(295, 'wheat', 'Wheat', -1, 0, 1, 0),
	(296, 'wood', 'wood', 100, 0, 1, 0),
	(297, 'wool', 'Wool', 40, 0, 1, 0),
	(298, 'yusuf', 'Weapon Skin', -1, 0, 1, 0),
	(299, 'idcard', 'ID-Card', -1, 0, 1, 500),
	(300, 'watch', 'Watch', -1, 0, 1, 100),
	(301, 'securityblue', 'Security Card', -1, 0, 1, 0),
	(302, 'securityblack', 'Security Card', -1, 0, 1, 0),
	(303, 'securitygreen', 'Security Card', -1, 0, 1, 0),
	(304, 'securitygold', 'Security Card', -1, 0, 1, 0),
	(305, 'securityred', 'Security Card', -1, 0, 1, 0),
	(306, 'decrypterred', 'Decrypter', -1, 0, 1, 0),
	(307, 'electronic-kit', 'Electronic Kit', -1, 0, 1, 0),
	(308, 'contract', 'Contract', 5, 0, 1, 100),
	(309, 'repairkit1', 'Repairkit', 5, 0, 1, 100),
	(310, 'armour2', 'Armour', 3, 0, 1, 50),
	(311, 'mechanic_tools', 'Mechanic Tools', 1, 0, 1, 0),
	(312, 'toolbox', 'Tool Box', 1, 0, 1, 0),
	(313, 'turbo_lvl_1', 'GARET Turbo', 1, 0, 1, 0),
	(314, 'race_transmition', 'Race Transmition', 1, 0, 1, 0),
	(315, 'race_suspension', 'Race Suspension', 1, 0, 1, 0),
	(316, 'v8engine', 'V8 Engine', 1, 0, 1, 0),
	(317, '2jzengine', '2JZ Engine', 1, 0, 1, 0),
	(318, 'michelin_tires', 'Michelin Tires', 1, 0, 1, 0),
	(319, 'race_brakes', 'Race Breaks', 1, 0, 1, 0),
	(320, 'bulbasaur', 'Bulbasaur', 30, 0, 1, 0),
	(321, 'ivysaur', 'Ivysaur', 30, 0, 1, 0),
	(322, 'venusaur', 'Venusaur', 30, 0, 1, 0),
	(323, 'charmander', 'Charmander', 30, 0, 1, 0),
	(324, 'charmeleon', 'Charmeleon', 30, 0, 1, 0),
	(325, 'charizard', 'Charizard', 30, 0, 1, 0),
	(326, 'squirtle', 'Squirtle', 30, 0, 1, 0),
	(327, 'wartortle', 'Wartortle', 30, 0, 1, 0),
	(328, 'blatoise', 'Blatoise', 30, 0, 1, 0),
	(329, 'caterpie', 'Caterpie', 30, 0, 1, 0),
	(330, 'metapod', 'Metapod', 30, 0, 1, 0),
	(331, 'butterfree', 'Butterfree', 30, 0, 1, 0),
	(332, 'weedle', 'Weedle', 30, 0, 1, 0),
	(333, 'kakuna', 'Kakuna', 30, 0, 1, 0),
	(334, 'beedrill', 'Beedrill', 30, 0, 1, 0),
	(335, 'pidgey', 'Pidgey', 30, 0, 1, 0),
	(336, 'pidgeotto', 'Pidgeotto', 30, 0, 1, 0),
	(337, 'rattata', 'Rattata', 30, 0, 1, 0),
	(338, 'raticate', 'Raticate', 30, 0, 1, 0),
	(339, 'spearow', 'Spearow', 30, 0, 1, 0),
	(340, 'fearow', 'Fearow', 30, 0, 1, 0),
	(341, 'ekans', 'Ekans', 30, 0, 1, 0),
	(342, 'arbok', 'Arbok', 30, 0, 1, 0),
	(343, 'pikachu', 'Pikachu', 30, 0, 1, 0),
	(344, 'raichu', 'Raichu', 30, 0, 1, 0),
	(345, 'sandshrew', 'Sandshrew', 30, 0, 1, 0),
	(346, 'sandslash', 'Sandslash', 30, 0, 1, 0),
	(347, 'nidoran', 'Nidoran', 30, 0, 1, 0),
	(348, 'nidorina', 'Nidorina', 30, 0, 1, 0),
	(349, 'nidoqueen', 'Nidoqueen', 30, 0, 1, 0),
	(350, 'nidoking', 'Nidoking', 30, 0, 1, 0),
	(351, 'clefairy', 'Clefairy', 30, 0, 1, 0),
	(352, 'clefable', 'Clefable', 30, 0, 1, 0),
	(353, 'vulpix', 'Vulpix', 30, 0, 1, 0),
	(354, 'ninetales', 'Ninetales', 30, 0, 1, 0),
	(355, 'jigglypuff', 'Jigglypuff', 30, 0, 1, 0),
	(356, 'wigglytuff', 'Wigglytuff', 30, 0, 1, 0),
	(357, 'zubat', 'Zubat', 30, 0, 1, 0),
	(358, 'golbat', 'Golbat', 30, 0, 1, 0),
	(359, 'oddish', 'Oddish', 30, 0, 1, 0),
	(360, 'gloom', 'Gloom', 30, 0, 1, 0),
	(361, 'vileplume', 'Vileplume', 30, 0, 1, 0),
	(362, 'paras', 'Paras', 30, 0, 1, 0),
	(363, 'parasect', 'Parasect', 30, 0, 1, 0),
	(364, 'venonat', 'Venonat', 30, 0, 1, 0),
	(365, 'venomoth', 'Venomoth', 30, 0, 1, 0),
	(366, 'diglett', 'Diglett', 30, 0, 1, 0),
	(367, 'dugtrio', 'Dugtrio', 30, 0, 1, 0),
	(368, 'mewoth', 'Mewoth', 30, 0, 1, 0),
	(369, 'persian', 'Persian', 30, 0, 1, 0),
	(370, 'psyduck', 'Psyduck', 30, 0, 1, 0),
	(371, 'golduck', 'Golduck', 30, 0, 1, 0),
	(372, 'geodude', 'Geodude', 30, 0, 1, 0),
	(373, 'graveler', 'Graveler', 30, 0, 1, 0),
	(374, 'golem', 'Golem', 30, 0, 1, 0),
	(375, 'ponyta', 'Ponyta', 30, 0, 1, 0),
	(376, 'rapidash', 'Rapidash', 30, 0, 1, 0),
	(377, 'slowpoke', 'Slowpoke', 30, 0, 1, 0),
	(378, 'slowbro', 'Slowbro', 30, 0, 1, 0),
	(379, 'magnemite', 'Magnemite', 30, 0, 1, 0),
	(380, 'magneton', 'Magneton', 30, 0, 1, 0),
	(381, 'farfetch', 'Farfetch', 30, 0, 1, 0),
	(382, 'doduo', 'Doduo', 30, 0, 1, 0),
	(383, 'dodrio', 'Dodrio', 30, 0, 1, 0),
	(384, 'seel', 'Seel', 30, 0, 1, 0),
	(385, 'dewgong', 'Dewgong', 30, 0, 1, 0),
	(386, 'grimer', 'Grimer', 30, 0, 1, 0),
	(387, 'muk', 'Muk', 30, 0, 1, 0),
	(388, 'shellder', 'Shellder', 30, 0, 1, 0),
	(389, 'cloyster', 'Cloyster', 30, 0, 1, 0),
	(390, 'gastly', 'Gastly', 30, 0, 1, 0),
	(391, 'haunter', 'Haunter', 30, 0, 1, 0),
	(392, 'mankey', 'Mankey', 30, 0, 1, 0),
	(393, 'primeape', 'Primeape', 30, 0, 1, 0),
	(394, 'growlithe', 'Growlithe', 30, 0, 1, 0),
	(395, 'arcanine', 'Arcanine', 30, 0, 1, 0),
	(396, 'poliwag', 'Poliwag', 30, 0, 1, 0),
	(397, 'poliwhirl', 'Poliwhirl', 30, 0, 1, 0),
	(398, 'poliwrath', 'Poliwrath', 30, 0, 1, 0),
	(399, 'abra', 'Abra', 30, 0, 1, 0),
	(400, 'kadabra', 'Kadabra', 30, 0, 1, 0),
	(401, 'alakazam', 'Alakazam', 30, 0, 1, 0),
	(402, 'machop', 'Machop', 30, 0, 1, 0),
	(403, 'machoke', 'Machoke', 30, 0, 1, 0),
	(404, 'machamp', 'Machamp', 30, 0, 1, 0),
	(405, 'bellsprout', 'Bellsprout', 30, 0, 1, 0),
	(406, 'weepinbell', 'Weepinbell', 30, 0, 1, 0),
	(407, 'victreebel', 'Victreebel', 30, 0, 1, 0),
	(408, 'tentacool', 'Tentacool', 30, 0, 1, 0),
	(409, 'tentacruel', 'Tentacruel', 30, 0, 1, 0),
	(410, 'gengar', 'Gengar', 30, 0, 1, 0),
	(411, 'onix', 'Onix', 30, 0, 1, 0),
	(412, 'drowzee', 'drowzee', 30, 0, 1, 0),
	(413, 'hypno', 'Hypno', 30, 0, 1, 0),
	(414, 'krabby', 'Krabby', 30, 0, 1, 0),
	(415, 'kingler', 'Kingler', 30, 0, 1, 0),
	(416, 'voltorb', 'Voltorb', 30, 0, 1, 0),
	(417, 'electrode', 'Electrode', 30, 0, 1, 0),
	(418, 'exeggcute', 'Exeggcute', 30, 0, 1, 0),
	(419, 'exeggutor', 'Exeggutor', 30, 0, 1, 0),
	(420, 'cubone', 'Cubone', 30, 0, 1, 0),
	(421, 'marowak', 'Marowak', 30, 0, 1, 0),
	(422, 'hitmonlee', 'Hitmonlee', 30, 0, 1, 0),
	(423, 'hitmonchan', 'Hitmonchan', 30, 0, 1, 0),
	(424, 'lickitung', 'Lickitung', 30, 0, 1, 0),
	(425, 'koffing', 'Koffing', 30, 0, 1, 0),
	(426, 'weezing', 'Weezing', 30, 0, 1, 0),
	(427, 'rhyhorn', 'Rhyhorn', 30, 0, 1, 0),
	(428, 'rhydon', 'Rhydon', 30, 0, 1, 0),
	(429, 'chansey', 'Chansey', 30, 0, 1, 0),
	(430, 'tangela', 'Tangela', 30, 0, 1, 0),
	(431, 'kangaskhan', 'kangaskhan', 30, 0, 1, 0),
	(432, 'horsea', 'Horsea', 30, 0, 1, 0),
	(433, 'seadra', 'Seadra', 30, 0, 1, 0),
	(434, 'goldeen', 'Goldeen', 30, 0, 1, 0),
	(435, 'seaking', 'Seaking', 30, 0, 1, 0),
	(436, 'staryu', 'Staryu', 30, 0, 1, 0),
	(437, 'starmie', 'Starmie', 30, 0, 1, 0),
	(438, 'mr. mime', 'Mr. mime', 30, 0, 1, 0),
	(439, 'scyther', 'Scyther', 30, 0, 1, 0),
	(440, 'jynx', 'Jynx', 30, 0, 1, 0),
	(441, 'electabuzz', 'Electabuzz', 30, 0, 1, 0),
	(442, 'magmar', 'Magmar', 30, 0, 1, 0),
	(443, 'pinsir', 'Pinsir', 30, 0, 1, 0),
	(444, 'tauros', 'Tauros', 30, 0, 1, 0),
	(445, 'magikarp', 'Magikarp', 30, 0, 1, 0),
	(446, 'gyarados', 'Gyarados', 30, 0, 1, 0),
	(447, 'lapras', 'Lapras', 30, 0, 1, 0),
	(448, 'ditto', 'Ditto', 30, 0, 1, 0),
	(449, 'eevee', 'Eevee', 30, 0, 1, 0),
	(450, 'vaporeon', 'Vaporeon', 30, 0, 1, 0),
	(451, 'jolteon', 'Jolteon', 30, 0, 1, 0),
	(452, 'flareon', 'Flareon', 30, 0, 1, 0),
	(453, 'porygon', 'Porygon', 30, 0, 1, 0),
	(454, 'omanyte', 'Omanyte', 30, 0, 1, 0),
	(455, 'omastar', 'Omastar', 30, 0, 1, 0),
	(456, 'kabutops', 'Kabutops', 30, 0, 1, 0),
	(457, 'aerodactyl', 'Aerodactyl', 30, 0, 1, 0),
	(458, 'snorlax', 'Snorlax', 30, 0, 1, 0),
	(459, 'articuno', 'Articuno', 30, 0, 1, 0),
	(460, 'zapdos', 'Zapdos', 30, 0, 1, 0),
	(461, 'moltres', 'Moltres', 30, 0, 1, 0),
	(462, 'dratini', 'Dratini', 30, 0, 1, 0),
	(463, 'dragonair', 'Dragonair', 30, 0, 1, 0),
	(464, 'dragonite', 'Dragonite', 30, 0, 1, 0),
	(465, 'mewtwo', 'Mewtwo', 30, 0, 1, 0),
	(466, 'mew', 'Mew', 30, 0, 1, 0),
	(467, 'togepi', 'Togepi', 30, 0, 1, 0),
	(468, 'boulderBadge', 'Boulder Badge', 30, 0, 1, 0),
	(469, 'cascadeBadge', 'Cascade Badge', 30, 0, 1, 0),
	(470, 'thunderBadge', 'Thunder Badge', 30, 0, 1, 0),
	(471, 'rainbowBadge', 'Rainbow Badge', 30, 0, 1, 0),
	(472, 'soulBadge', 'Soul Badge', 30, 0, 1, 0),
	(473, 'marshBadge', 'Marsh Badge', 30, 0, 1, 0),
	(474, 'volcanoBadge', 'Volcano Badge', 30, 0, 1, 0),
	(475, 'earthBadge', 'Earth Badge', 30, 0, 1, 0),
	(476, 'trophyBadge', 'Pokemon League Trophy', 30, 0, 1, 0),
	(477, 'bulbasaur', 'Bulbasaur', 30, 0, 1, 0),
	(478, 'ivysaur', 'Ivysaur', 30, 0, 1, 0),
	(479, 'venusaur', 'Venusaur', 30, 0, 1, 0),
	(480, 'charmander', 'Charmander', 30, 0, 1, 0),
	(481, 'charmeleon', 'Charmeleon', 30, 0, 1, 0),
	(482, 'charizard', 'Charizard', 30, 0, 1, 0),
	(483, 'squirtle', 'Squirtle', 30, 0, 1, 0),
	(484, 'wartortle', 'Wartortle', 30, 0, 1, 0),
	(485, 'blatoise', 'Blatoise', 30, 0, 1, 0),
	(486, 'caterpie', 'Caterpie', 30, 0, 1, 0),
	(487, 'metapod', 'Metapod', 30, 0, 1, 0),
	(488, 'butterfree', 'Butterfree', 30, 0, 1, 0),
	(489, 'weedle', 'Weedle', 30, 0, 1, 0),
	(490, 'kakuna', 'Kakuna', 30, 0, 1, 0),
	(491, 'beedrill', 'Beedrill', 30, 0, 1, 0),
	(492, 'pidgey', 'Pidgey', 30, 0, 1, 0),
	(493, 'pidgeotto', 'Pidgeotto', 30, 0, 1, 0),
	(494, 'rattata', 'Rattata', 30, 0, 1, 0),
	(495, 'raticate', 'Raticate', 30, 0, 1, 0),
	(496, 'spearow', 'Spearow', 30, 0, 1, 0),
	(497, 'fearow', 'Fearow', 30, 0, 1, 0),
	(498, 'ekans', 'Ekans', 30, 0, 1, 0),
	(499, 'arbok', 'Arbok', 30, 0, 1, 0),
	(500, 'pikachu', 'Pikachu', 30, 0, 1, 0),
	(501, 'raichu', 'Raichu', 30, 0, 1, 0),
	(502, 'sandshrew', 'Sandshrew', 30, 0, 1, 0),
	(503, 'sandslash', 'Sandslash', 30, 0, 1, 0),
	(504, 'nidoran', 'Nidoran', 30, 0, 1, 0),
	(505, 'nidorina', 'Nidorina', 30, 0, 1, 0),
	(506, 'nidoqueen', 'Nidoqueen', 30, 0, 1, 0),
	(507, 'nidoking', 'Nidoking', 30, 0, 1, 0),
	(508, 'clefairy', 'Clefairy', 30, 0, 1, 0),
	(509, 'clefable', 'Clefable', 30, 0, 1, 0),
	(510, 'vulpix', 'Vulpix', 30, 0, 1, 0),
	(511, 'ninetales', 'Ninetales', 30, 0, 1, 0),
	(512, 'jigglypuff', 'Jigglypuff', 30, 0, 1, 0),
	(513, 'wigglytuff', 'Wigglytuff', 30, 0, 1, 0),
	(514, 'zubat', 'Zubat', 30, 0, 1, 0),
	(515, 'golbat', 'Golbat', 30, 0, 1, 0),
	(516, 'oddish', 'Oddish', 30, 0, 1, 0),
	(517, 'gloom', 'Gloom', 30, 0, 1, 0),
	(518, 'vileplume', 'Vileplume', 30, 0, 1, 0),
	(519, 'paras', 'Paras', 30, 0, 1, 0),
	(520, 'parasect', 'Parasect', 30, 0, 1, 0),
	(521, 'venonat', 'Venonat', 30, 0, 1, 0),
	(522, 'venomoth', 'Venomoth', 30, 0, 1, 0),
	(523, 'diglett', 'Diglett', 30, 0, 1, 0),
	(524, 'dugtrio', 'Dugtrio', 30, 0, 1, 0),
	(525, 'mewoth', 'Mewoth', 30, 0, 1, 0),
	(526, 'persian', 'Persian', 30, 0, 1, 0),
	(527, 'psyduck', 'Psyduck', 30, 0, 1, 0),
	(528, 'golduck', 'Golduck', 30, 0, 1, 0),
	(529, 'geodude', 'Geodude', 30, 0, 1, 0),
	(530, 'graveler', 'Graveler', 30, 0, 1, 0),
	(531, 'golem', 'Golem', 30, 0, 1, 0),
	(532, 'ponyta', 'Ponyta', 30, 0, 1, 0),
	(533, 'rapidash', 'Rapidash', 30, 0, 1, 0),
	(534, 'slowpoke', 'Slowpoke', 30, 0, 1, 0),
	(535, 'slowbro', 'Slowbro', 30, 0, 1, 0),
	(536, 'magnemite', 'Magnemite', 30, 0, 1, 0),
	(537, 'magneton', 'Magneton', 30, 0, 1, 0),
	(538, 'farfetch', 'Farfetch', 30, 0, 1, 0),
	(539, 'doduo', 'Doduo', 30, 0, 1, 0),
	(540, 'dodrio', 'Dodrio', 30, 0, 1, 0),
	(541, 'seel', 'Seel', 30, 0, 1, 0),
	(542, 'dewgong', 'Dewgong', 30, 0, 1, 0),
	(543, 'grimer', 'Grimer', 30, 0, 1, 0),
	(544, 'muk', 'Muk', 30, 0, 1, 0),
	(545, 'shellder', 'Shellder', 30, 0, 1, 0),
	(546, 'cloyster', 'Cloyster', 30, 0, 1, 0),
	(547, 'gastly', 'Gastly', 30, 0, 1, 0),
	(548, 'haunter', 'Haunter', 30, 0, 1, 0),
	(549, 'mankey', 'Mankey', 30, 0, 1, 0),
	(550, 'primeape', 'Primeape', 30, 0, 1, 0),
	(551, 'growlithe', 'Growlithe', 30, 0, 1, 0),
	(552, 'arcanine', 'Arcanine', 30, 0, 1, 0),
	(553, 'poliwag', 'Poliwag', 30, 0, 1, 0),
	(554, 'poliwhirl', 'Poliwhirl', 30, 0, 1, 0),
	(555, 'poliwrath', 'Poliwrath', 30, 0, 1, 0),
	(556, 'abra', 'Abra', 30, 0, 1, 0),
	(557, 'kadabra', 'Kadabra', 30, 0, 1, 0),
	(558, 'alakazam', 'Alakazam', 30, 0, 1, 0),
	(559, 'machop', 'Machop', 30, 0, 1, 0),
	(560, 'machoke', 'Machoke', 30, 0, 1, 0),
	(561, 'machamp', 'Machamp', 30, 0, 1, 0),
	(562, 'bellsprout', 'Bellsprout', 30, 0, 1, 0),
	(563, 'weepinbell', 'Weepinbell', 30, 0, 1, 0),
	(564, 'victreebel', 'Victreebel', 30, 0, 1, 0),
	(565, 'tentacool', 'Tentacool', 30, 0, 1, 0),
	(566, 'tentacruel', 'Tentacruel', 30, 0, 1, 0),
	(567, 'gengar', 'Gengar', 30, 0, 1, 0),
	(568, 'onix', 'Onix', 30, 0, 1, 0),
	(569, 'drowzee', 'drowzee', 30, 0, 1, 0),
	(570, 'hypno', 'Hypno', 30, 0, 1, 0),
	(571, 'krabby', 'Krabby', 30, 0, 1, 0),
	(572, 'kingler', 'Kingler', 30, 0, 1, 0),
	(573, 'voltorb', 'Voltorb', 30, 0, 1, 0),
	(574, 'electrode', 'Electrode', 30, 0, 1, 0),
	(575, 'exeggcute', 'Exeggcute', 30, 0, 1, 0),
	(576, 'exeggutor', 'Exeggutor', 30, 0, 1, 0),
	(577, 'cubone', 'Cubone', 30, 0, 1, 0),
	(578, 'marowak', 'Marowak', 30, 0, 1, 0),
	(579, 'hitmonlee', 'Hitmonlee', 30, 0, 1, 0),
	(580, 'hitmonchan', 'Hitmonchan', 30, 0, 1, 0),
	(581, 'lickitung', 'Lickitung', 30, 0, 1, 0),
	(582, 'koffing', 'Koffing', 30, 0, 1, 0),
	(583, 'weezing', 'Weezing', 30, 0, 1, 0),
	(584, 'rhyhorn', 'Rhyhorn', 30, 0, 1, 0),
	(585, 'rhydon', 'Rhydon', 30, 0, 1, 0),
	(586, 'chansey', 'Chansey', 30, 0, 1, 0),
	(587, 'tangela', 'Tangela', 30, 0, 1, 0),
	(588, 'kangaskhan', 'kangaskhan', 30, 0, 1, 0),
	(589, 'horsea', 'Horsea', 30, 0, 1, 0),
	(590, 'seadra', 'Seadra', 30, 0, 1, 0),
	(591, 'goldeen', 'Goldeen', 30, 0, 1, 0),
	(592, 'seaking', 'Seaking', 30, 0, 1, 0),
	(593, 'staryu', 'Staryu', 30, 0, 1, 0),
	(594, 'starmie', 'Starmie', 30, 0, 1, 0),
	(595, 'mr. mime', 'Mr. mime', 30, 0, 1, 0),
	(596, 'scyther', 'Scyther', 30, 0, 1, 0),
	(597, 'jynx', 'Jynx', 30, 0, 1, 0),
	(598, 'electabuzz', 'Electabuzz', 30, 0, 1, 0),
	(599, 'magmar', 'Magmar', 30, 0, 1, 0),
	(600, 'pinsir', 'Pinsir', 30, 0, 1, 0),
	(601, 'tauros', 'Tauros', 30, 0, 1, 0),
	(602, 'magikarp', 'Magikarp', 30, 0, 1, 0),
	(603, 'gyarados', 'Gyarados', 30, 0, 1, 0),
	(604, 'lapras', 'Lapras', 30, 0, 1, 0),
	(605, 'ditto', 'Ditto', 30, 0, 1, 0),
	(606, 'eevee', 'Eevee', 30, 0, 1, 0),
	(607, 'vaporeon', 'Vaporeon', 30, 0, 1, 0),
	(608, 'jolteon', 'Jolteon', 30, 0, 1, 0),
	(609, 'flareon', 'Flareon', 30, 0, 1, 0),
	(610, 'porygon', 'Porygon', 30, 0, 1, 0),
	(611, 'omanyte', 'Omanyte', 30, 0, 1, 0),
	(612, 'omastar', 'Omastar', 30, 0, 1, 0),
	(613, 'kabutops', 'Kabutops', 30, 0, 1, 0),
	(614, 'aerodactyl', 'Aerodactyl', 30, 0, 1, 0),
	(615, 'snorlax', 'Snorlax', 30, 0, 1, 0),
	(616, 'articuno', 'Articuno', 30, 0, 1, 0),
	(617, 'zapdos', 'Zapdos', 30, 0, 1, 0),
	(618, 'moltres', 'Moltres', 30, 0, 1, 0),
	(619, 'dratini', 'Dratini', 30, 0, 1, 0),
	(620, 'dragonair', 'Dragonair', 30, 0, 1, 0),
	(621, 'dragonite', 'Dragonite', 30, 0, 1, 0),
	(622, 'mewtwo', 'Mewtwo', 30, 0, 1, 0),
	(623, 'mew', 'Mew', 30, 0, 1, 0),
	(624, 'togepi', 'Togepi', 30, 0, 1, 0),
	(625, 'boulderBadge', 'Boulder Badge', 30, 0, 1, 0),
	(626, 'cascadeBadge', 'Cascade Badge', 30, 0, 1, 0),
	(627, 'thunderBadge', 'Thunder Badge', 30, 0, 1, 0),
	(628, 'rainbowBadge', 'Rainbow Badge', 30, 0, 1, 0),
	(629, 'soulBadge', 'Soul Badge', 30, 0, 1, 0),
	(630, 'marshBadge', 'Marsh Badge', 30, 0, 1, 0),
	(631, 'volcanoBadge', 'Volcano Badge', 30, 0, 1, 0),
	(632, 'earthBadge', 'Earth Badge', 30, 0, 1, 0),
	(633, 'trophyBadge', 'Pokemon League Trophy', 30, 0, 1, 0),
	(634, 'bulbasaur', 'Bulbasaur', 30, 0, 1, 0),
	(635, 'ivysaur', 'Ivysaur', 30, 0, 1, 0),
	(636, 'venusaur', 'Venusaur', 30, 0, 1, 0),
	(637, 'charmander', 'Charmander', 30, 0, 1, 0),
	(638, 'charmeleon', 'Charmeleon', 30, 0, 1, 0),
	(639, 'charizard', 'Charizard', 30, 0, 1, 0),
	(640, 'squirtle', 'Squirtle', 30, 0, 1, 0),
	(641, 'wartortle', 'Wartortle', 30, 0, 1, 0),
	(642, 'blatoise', 'Blatoise', 30, 0, 1, 0),
	(643, 'caterpie', 'Caterpie', 30, 0, 1, 0),
	(644, 'metapod', 'Metapod', 30, 0, 1, 0),
	(645, 'butterfree', 'Butterfree', 30, 0, 1, 0),
	(646, 'weedle', 'Weedle', 30, 0, 1, 0),
	(647, 'kakuna', 'Kakuna', 30, 0, 1, 0),
	(648, 'beedrill', 'Beedrill', 30, 0, 1, 0),
	(649, 'pidgey', 'Pidgey', 30, 0, 1, 0),
	(650, 'pidgeotto', 'Pidgeotto', 30, 0, 1, 0),
	(651, 'rattata', 'Rattata', 30, 0, 1, 0),
	(652, 'raticate', 'Raticate', 30, 0, 1, 0),
	(653, 'spearow', 'Spearow', 30, 0, 1, 0),
	(654, 'fearow', 'Fearow', 30, 0, 1, 0),
	(655, 'ekans', 'Ekans', 30, 0, 1, 0),
	(656, 'arbok', 'Arbok', 30, 0, 1, 0),
	(657, 'pikachu', 'Pikachu', 30, 0, 1, 0),
	(658, 'raichu', 'Raichu', 30, 0, 1, 0),
	(659, 'sandshrew', 'Sandshrew', 30, 0, 1, 0),
	(660, 'sandslash', 'Sandslash', 30, 0, 1, 0),
	(661, 'nidoran', 'Nidoran', 30, 0, 1, 0),
	(662, 'nidorina', 'Nidorina', 30, 0, 1, 0),
	(663, 'nidoqueen', 'Nidoqueen', 30, 0, 1, 0),
	(664, 'nidoking', 'Nidoking', 30, 0, 1, 0),
	(665, 'clefairy', 'Clefairy', 30, 0, 1, 0),
	(666, 'clefable', 'Clefable', 30, 0, 1, 0),
	(667, 'vulpix', 'Vulpix', 30, 0, 1, 0),
	(668, 'ninetales', 'Ninetales', 30, 0, 1, 0),
	(669, 'jigglypuff', 'Jigglypuff', 30, 0, 1, 0),
	(670, 'wigglytuff', 'Wigglytuff', 30, 0, 1, 0),
	(671, 'zubat', 'Zubat', 30, 0, 1, 0),
	(672, 'golbat', 'Golbat', 30, 0, 1, 0),
	(673, 'oddish', 'Oddish', 30, 0, 1, 0),
	(674, 'gloom', 'Gloom', 30, 0, 1, 0),
	(675, 'vileplume', 'Vileplume', 30, 0, 1, 0),
	(676, 'paras', 'Paras', 30, 0, 1, 0),
	(677, 'parasect', 'Parasect', 30, 0, 1, 0),
	(678, 'venonat', 'Venonat', 30, 0, 1, 0),
	(679, 'venomoth', 'Venomoth', 30, 0, 1, 0),
	(680, 'diglett', 'Diglett', 30, 0, 1, 0),
	(681, 'dugtrio', 'Dugtrio', 30, 0, 1, 0),
	(682, 'mewoth', 'Mewoth', 30, 0, 1, 0),
	(683, 'persian', 'Persian', 30, 0, 1, 0),
	(684, 'psyduck', 'Psyduck', 30, 0, 1, 0),
	(685, 'golduck', 'Golduck', 30, 0, 1, 0),
	(686, 'geodude', 'Geodude', 30, 0, 1, 0),
	(687, 'graveler', 'Graveler', 30, 0, 1, 0),
	(688, 'golem', 'Golem', 30, 0, 1, 0),
	(689, 'ponyta', 'Ponyta', 30, 0, 1, 0),
	(690, 'rapidash', 'Rapidash', 30, 0, 1, 0),
	(691, 'slowpoke', 'Slowpoke', 30, 0, 1, 0),
	(692, 'slowbro', 'Slowbro', 30, 0, 1, 0),
	(693, 'magnemite', 'Magnemite', 30, 0, 1, 0),
	(694, 'magneton', 'Magneton', 30, 0, 1, 0),
	(695, 'farfetch', 'Farfetch', 30, 0, 1, 0),
	(696, 'doduo', 'Doduo', 30, 0, 1, 0),
	(697, 'dodrio', 'Dodrio', 30, 0, 1, 0),
	(698, 'seel', 'Seel', 30, 0, 1, 0),
	(699, 'dewgong', 'Dewgong', 30, 0, 1, 0),
	(700, 'grimer', 'Grimer', 30, 0, 1, 0),
	(701, 'muk', 'Muk', 30, 0, 1, 0),
	(702, 'shellder', 'Shellder', 30, 0, 1, 0),
	(703, 'cloyster', 'Cloyster', 30, 0, 1, 0),
	(704, 'gastly', 'Gastly', 30, 0, 1, 0),
	(705, 'haunter', 'Haunter', 30, 0, 1, 0),
	(706, 'mankey', 'Mankey', 30, 0, 1, 0),
	(707, 'primeape', 'Primeape', 30, 0, 1, 0),
	(708, 'growlithe', 'Growlithe', 30, 0, 1, 0),
	(709, 'arcanine', 'Arcanine', 30, 0, 1, 0),
	(710, 'poliwag', 'Poliwag', 30, 0, 1, 0),
	(711, 'poliwhirl', 'Poliwhirl', 30, 0, 1, 0),
	(712, 'poliwrath', 'Poliwrath', 30, 0, 1, 0),
	(713, 'abra', 'Abra', 30, 0, 1, 0),
	(714, 'kadabra', 'Kadabra', 30, 0, 1, 0),
	(715, 'alakazam', 'Alakazam', 30, 0, 1, 0),
	(716, 'machop', 'Machop', 30, 0, 1, 0),
	(717, 'machoke', 'Machoke', 30, 0, 1, 0),
	(718, 'machamp', 'Machamp', 30, 0, 1, 0),
	(719, 'bellsprout', 'Bellsprout', 30, 0, 1, 0),
	(720, 'weepinbell', 'Weepinbell', 30, 0, 1, 0),
	(721, 'victreebel', 'Victreebel', 30, 0, 1, 0),
	(722, 'tentacool', 'Tentacool', 30, 0, 1, 0),
	(723, 'tentacruel', 'Tentacruel', 30, 0, 1, 0),
	(724, 'gengar', 'Gengar', 30, 0, 1, 0),
	(725, 'onix', 'Onix', 30, 0, 1, 0),
	(726, 'drowzee', 'drowzee', 30, 0, 1, 0),
	(727, 'hypno', 'Hypno', 30, 0, 1, 0),
	(728, 'krabby', 'Krabby', 30, 0, 1, 0),
	(729, 'kingler', 'Kingler', 30, 0, 1, 0),
	(730, 'voltorb', 'Voltorb', 30, 0, 1, 0),
	(731, 'electrode', 'Electrode', 30, 0, 1, 0),
	(732, 'exeggcute', 'Exeggcute', 30, 0, 1, 0),
	(733, 'exeggutor', 'Exeggutor', 30, 0, 1, 0),
	(734, 'cubone', 'Cubone', 30, 0, 1, 0),
	(735, 'marowak', 'Marowak', 30, 0, 1, 0),
	(736, 'hitmonlee', 'Hitmonlee', 30, 0, 1, 0),
	(737, 'hitmonchan', 'Hitmonchan', 30, 0, 1, 0),
	(738, 'lickitung', 'Lickitung', 30, 0, 1, 0),
	(739, 'koffing', 'Koffing', 30, 0, 1, 0),
	(740, 'weezing', 'Weezing', 30, 0, 1, 0),
	(741, 'rhyhorn', 'Rhyhorn', 30, 0, 1, 0),
	(742, 'rhydon', 'Rhydon', 30, 0, 1, 0),
	(743, 'chansey', 'Chansey', 30, 0, 1, 0),
	(744, 'tangela', 'Tangela', 30, 0, 1, 0),
	(745, 'kangaskhan', 'kangaskhan', 30, 0, 1, 0),
	(746, 'horsea', 'Horsea', 30, 0, 1, 0),
	(747, 'seadra', 'Seadra', 30, 0, 1, 0),
	(748, 'goldeen', 'Goldeen', 30, 0, 1, 0),
	(749, 'seaking', 'Seaking', 30, 0, 1, 0),
	(750, 'staryu', 'Staryu', 30, 0, 1, 0),
	(751, 'starmie', 'Starmie', 30, 0, 1, 0),
	(752, 'mr. mime', 'Mr. mime', 30, 0, 1, 0),
	(753, 'scyther', 'Scyther', 30, 0, 1, 0),
	(754, 'jynx', 'Jynx', 30, 0, 1, 0),
	(755, 'electabuzz', 'Electabuzz', 30, 0, 1, 0),
	(756, 'magmar', 'Magmar', 30, 0, 1, 0),
	(757, 'pinsir', 'Pinsir', 30, 0, 1, 0),
	(758, 'tauros', 'Tauros', 30, 0, 1, 0),
	(759, 'magikarp', 'Magikarp', 30, 0, 1, 0),
	(760, 'gyarados', 'Gyarados', 30, 0, 1, 0),
	(761, 'lapras', 'Lapras', 30, 0, 1, 0),
	(762, 'ditto', 'Ditto', 30, 0, 1, 0),
	(763, 'eevee', 'Eevee', 30, 0, 1, 0),
	(764, 'vaporeon', 'Vaporeon', 30, 0, 1, 0),
	(765, 'jolteon', 'Jolteon', 30, 0, 1, 0),
	(766, 'flareon', 'Flareon', 30, 0, 1, 0),
	(767, 'porygon', 'Porygon', 30, 0, 1, 0),
	(768, 'omanyte', 'Omanyte', 30, 0, 1, 0),
	(769, 'omastar', 'Omastar', 30, 0, 1, 0),
	(770, 'kabutops', 'Kabutops', 30, 0, 1, 0),
	(771, 'aerodactyl', 'Aerodactyl', 30, 0, 1, 0),
	(772, 'snorlax', 'Snorlax', 30, 0, 1, 0),
	(773, 'articuno', 'Articuno', 30, 0, 1, 0),
	(774, 'zapdos', 'Zapdos', 30, 0, 1, 0),
	(775, 'moltres', 'Moltres', 30, 0, 1, 0),
	(776, 'dratini', 'Dratini', 30, 0, 1, 0),
	(777, 'dragonair', 'Dragonair', 30, 0, 1, 0),
	(778, 'dragonite', 'Dragonite', 30, 0, 1, 0),
	(779, 'mewtwo', 'Mewtwo', 30, 0, 1, 0),
	(780, 'mew', 'Mew', 30, 0, 1, 0),
	(781, 'togepi', 'Togepi', 30, 0, 1, 0),
	(782, 'boulderBadge', 'Boulder Badge', 30, 0, 1, 0),
	(783, 'cascadeBadge', 'Cascade Badge', 30, 0, 1, 0),
	(784, 'thunderBadge', 'Thunder Badge', 30, 0, 1, 0),
	(785, 'rainbowBadge', 'Rainbow Badge', 30, 0, 1, 0),
	(786, 'soulBadge', 'Soul Badge', 30, 0, 1, 0),
	(787, 'marshBadge', 'Marsh Badge', 30, 0, 1, 0),
	(788, 'volcanoBadge', 'Volcano Badge', 30, 0, 1, 0),
	(789, 'earthBadge', 'Earth Badge', 30, 0, 1, 0),
	(790, 'trophyBadge', 'Pokemon League Trophy', 30, 0, 1, 0),
	(791, 'recipe_boulderBadge', 'Boulder Badge Blueprint', 30, 0, 1, 0),
	(792, 'recipe_cascadeBadge', 'Cascade Badge Blueprint', 30, 0, 1, 0),
	(793, 'recipe_thunderBadge', 'Thunder Badge Blueprint', 30, 0, 1, 0),
	(794, 'recipe_rainbowBadge', 'Rainbow Badge Blueprint', 30, 0, 1, 0),
	(795, 'recipe_soulBadge', 'Soul Badge Blueprint', 30, 0, 1, 0),
	(796, 'recipe_marshBadge', 'Marsh Badge Blueprint', 30, 0, 1, 0),
	(797, 'recipe_volcanoBadge', 'Volcano Badge Blueprint', 30, 0, 1, 0),
	(798, 'recipe_earthBadge', 'Earth Badge Blueprint', 30, 0, 1, 0),
	(799, 'bulbasaur', 'Bulbasaur', 30, 0, 1, 0),
	(800, 'ivysaur', 'Ivysaur', 30, 0, 1, 0),
	(801, 'venusaur', 'Venusaur', 30, 0, 1, 0),
	(802, 'charmander', 'Charmander', 30, 0, 1, 0),
	(803, 'charmeleon', 'Charmeleon', 30, 0, 1, 0),
	(804, 'charizard', 'Charizard', 30, 0, 1, 0),
	(805, 'squirtle', 'Squirtle', 30, 0, 1, 0),
	(806, 'wartortle', 'Wartortle', 30, 0, 1, 0),
	(807, 'blatoise', 'Blatoise', 30, 0, 1, 0),
	(808, 'caterpie', 'Caterpie', 30, 0, 1, 0),
	(809, 'metapod', 'Metapod', 30, 0, 1, 0),
	(810, 'butterfree', 'Butterfree', 30, 0, 1, 0),
	(811, 'weedle', 'Weedle', 30, 0, 1, 0),
	(812, 'kakuna', 'Kakuna', 30, 0, 1, 0),
	(813, 'beedrill', 'Beedrill', 30, 0, 1, 0),
	(814, 'pidgey', 'Pidgey', 30, 0, 1, 0),
	(815, 'pidgeotto', 'Pidgeotto', 30, 0, 1, 0),
	(816, 'rattata', 'Rattata', 30, 0, 1, 0),
	(817, 'raticate', 'Raticate', 30, 0, 1, 0),
	(818, 'spearow', 'Spearow', 30, 0, 1, 0),
	(819, 'fearow', 'Fearow', 30, 0, 1, 0),
	(820, 'ekans', 'Ekans', 30, 0, 1, 0),
	(821, 'arbok', 'Arbok', 30, 0, 1, 0),
	(822, 'pikachu', 'Pikachu', 30, 0, 1, 0),
	(823, 'raichu', 'Raichu', 30, 0, 1, 0),
	(824, 'sandshrew', 'Sandshrew', 30, 0, 1, 0),
	(825, 'sandslash', 'Sandslash', 30, 0, 1, 0),
	(826, 'nidoran', 'Nidoran', 30, 0, 1, 0),
	(827, 'nidorina', 'Nidorina', 30, 0, 1, 0),
	(828, 'nidoqueen', 'Nidoqueen', 30, 0, 1, 0),
	(829, 'nidoking', 'Nidoking', 30, 0, 1, 0),
	(830, 'clefairy', 'Clefairy', 30, 0, 1, 0),
	(831, 'clefable', 'Clefable', 30, 0, 1, 0),
	(832, 'vulpix', 'Vulpix', 30, 0, 1, 0),
	(833, 'ninetales', 'Ninetales', 30, 0, 1, 0),
	(834, 'jigglypuff', 'Jigglypuff', 30, 0, 1, 0),
	(835, 'wigglytuff', 'Wigglytuff', 30, 0, 1, 0),
	(836, 'zubat', 'Zubat', 30, 0, 1, 0),
	(837, 'golbat', 'Golbat', 30, 0, 1, 0),
	(838, 'oddish', 'Oddish', 30, 0, 1, 0),
	(839, 'gloom', 'Gloom', 30, 0, 1, 0),
	(840, 'vileplume', 'Vileplume', 30, 0, 1, 0),
	(841, 'paras', 'Paras', 30, 0, 1, 0),
	(842, 'parasect', 'Parasect', 30, 0, 1, 0),
	(843, 'venonat', 'Venonat', 30, 0, 1, 0),
	(844, 'venomoth', 'Venomoth', 30, 0, 1, 0),
	(845, 'diglett', 'Diglett', 30, 0, 1, 0),
	(846, 'dugtrio', 'Dugtrio', 30, 0, 1, 0),
	(847, 'mewoth', 'Mewoth', 30, 0, 1, 0),
	(848, 'persian', 'Persian', 30, 0, 1, 0),
	(849, 'psyduck', 'Psyduck', 30, 0, 1, 0),
	(850, 'golduck', 'Golduck', 30, 0, 1, 0),
	(851, 'geodude', 'Geodude', 30, 0, 1, 0),
	(852, 'graveler', 'Graveler', 30, 0, 1, 0),
	(853, 'golem', 'Golem', 30, 0, 1, 0),
	(854, 'ponyta', 'Ponyta', 30, 0, 1, 0),
	(855, 'rapidash', 'Rapidash', 30, 0, 1, 0),
	(856, 'slowpoke', 'Slowpoke', 30, 0, 1, 0),
	(857, 'slowbro', 'Slowbro', 30, 0, 1, 0),
	(858, 'magnemite', 'Magnemite', 30, 0, 1, 0),
	(859, 'magneton', 'Magneton', 30, 0, 1, 0),
	(860, 'farfetch', 'Farfetch', 30, 0, 1, 0),
	(861, 'doduo', 'Doduo', 30, 0, 1, 0),
	(862, 'dodrio', 'Dodrio', 30, 0, 1, 0),
	(863, 'seel', 'Seel', 30, 0, 1, 0),
	(864, 'dewgong', 'Dewgong', 30, 0, 1, 0),
	(865, 'grimer', 'Grimer', 30, 0, 1, 0),
	(866, 'muk', 'Muk', 30, 0, 1, 0),
	(867, 'shellder', 'Shellder', 30, 0, 1, 0),
	(868, 'cloyster', 'Cloyster', 30, 0, 1, 0),
	(869, 'gastly', 'Gastly', 30, 0, 1, 0),
	(870, 'haunter', 'Haunter', 30, 0, 1, 0),
	(871, 'mankey', 'Mankey', 30, 0, 1, 0),
	(872, 'primeape', 'Primeape', 30, 0, 1, 0),
	(873, 'growlithe', 'Growlithe', 30, 0, 1, 0),
	(874, 'arcanine', 'Arcanine', 30, 0, 1, 0),
	(875, 'poliwag', 'Poliwag', 30, 0, 1, 0),
	(876, 'poliwhirl', 'Poliwhirl', 30, 0, 1, 0),
	(877, 'poliwrath', 'Poliwrath', 30, 0, 1, 0),
	(878, 'abra', 'Abra', 30, 0, 1, 0),
	(879, 'kadabra', 'Kadabra', 30, 0, 1, 0),
	(880, 'alakazam', 'Alakazam', 30, 0, 1, 0),
	(881, 'machop', 'Machop', 30, 0, 1, 0),
	(882, 'machoke', 'Machoke', 30, 0, 1, 0),
	(883, 'machamp', 'Machamp', 30, 0, 1, 0),
	(884, 'bellsprout', 'Bellsprout', 30, 0, 1, 0),
	(885, 'weepinbell', 'Weepinbell', 30, 0, 1, 0),
	(886, 'victreebel', 'Victreebel', 30, 0, 1, 0),
	(887, 'tentacool', 'Tentacool', 30, 0, 1, 0),
	(888, 'tentacruel', 'Tentacruel', 30, 0, 1, 0),
	(889, 'gengar', 'Gengar', 30, 0, 1, 0),
	(890, 'onix', 'Onix', 30, 0, 1, 0),
	(891, 'drowzee', 'drowzee', 30, 0, 1, 0),
	(892, 'hypno', 'Hypno', 30, 0, 1, 0),
	(893, 'krabby', 'Krabby', 30, 0, 1, 0),
	(894, 'kingler', 'Kingler', 30, 0, 1, 0),
	(895, 'voltorb', 'Voltorb', 30, 0, 1, 0),
	(896, 'electrode', 'Electrode', 30, 0, 1, 0),
	(897, 'exeggcute', 'Exeggcute', 30, 0, 1, 0),
	(898, 'exeggutor', 'Exeggutor', 30, 0, 1, 0),
	(899, 'cubone', 'Cubone', 30, 0, 1, 0),
	(900, 'marowak', 'Marowak', 30, 0, 1, 0),
	(901, 'hitmonlee', 'Hitmonlee', 30, 0, 1, 0),
	(902, 'hitmonchan', 'Hitmonchan', 30, 0, 1, 0),
	(903, 'lickitung', 'Lickitung', 30, 0, 1, 0),
	(904, 'koffing', 'Koffing', 30, 0, 1, 0),
	(905, 'weezing', 'Weezing', 30, 0, 1, 0),
	(906, 'rhyhorn', 'Rhyhorn', 30, 0, 1, 0),
	(907, 'rhydon', 'Rhydon', 30, 0, 1, 0),
	(908, 'chansey', 'Chansey', 30, 0, 1, 0),
	(909, 'tangela', 'Tangela', 30, 0, 1, 0),
	(910, 'kangaskhan', 'kangaskhan', 30, 0, 1, 0),
	(911, 'horsea', 'Horsea', 30, 0, 1, 0),
	(912, 'seadra', 'Seadra', 30, 0, 1, 0),
	(913, 'goldeen', 'Goldeen', 30, 0, 1, 0),
	(914, 'seaking', 'Seaking', 30, 0, 1, 0),
	(915, 'staryu', 'Staryu', 30, 0, 1, 0),
	(916, 'starmie', 'Starmie', 30, 0, 1, 0),
	(917, 'mr. mime', 'Mr. mime', 30, 0, 1, 0),
	(918, 'scyther', 'Scyther', 30, 0, 1, 0),
	(919, 'jynx', 'Jynx', 30, 0, 1, 0),
	(920, 'electabuzz', 'Electabuzz', 30, 0, 1, 0),
	(921, 'magmar', 'Magmar', 30, 0, 1, 0),
	(922, 'pinsir', 'Pinsir', 30, 0, 1, 0),
	(923, 'tauros', 'Tauros', 30, 0, 1, 0),
	(924, 'magikarp', 'Magikarp', 30, 0, 1, 0),
	(925, 'gyarados', 'Gyarados', 30, 0, 1, 0),
	(926, 'lapras', 'Lapras', 30, 0, 1, 0),
	(927, 'ditto', 'Ditto', 30, 0, 1, 0),
	(928, 'eevee', 'Eevee', 30, 0, 1, 0),
	(929, 'vaporeon', 'Vaporeon', 30, 0, 1, 0),
	(930, 'jolteon', 'Jolteon', 30, 0, 1, 0),
	(931, 'flareon', 'Flareon', 30, 0, 1, 0),
	(932, 'porygon', 'Porygon', 30, 0, 1, 0),
	(933, 'omanyte', 'Omanyte', 30, 0, 1, 0),
	(934, 'omastar', 'Omastar', 30, 0, 1, 0),
	(935, 'kabutops', 'Kabutops', 30, 0, 1, 0),
	(936, 'aerodactyl', 'Aerodactyl', 30, 0, 1, 0),
	(937, 'snorlax', 'Snorlax', 30, 0, 1, 0),
	(938, 'articuno', 'Articuno', 30, 0, 1, 0),
	(939, 'zapdos', 'Zapdos', 30, 0, 1, 0),
	(940, 'moltres', 'Moltres', 30, 0, 1, 0),
	(941, 'dratini', 'Dratini', 30, 0, 1, 0),
	(942, 'dragonair', 'Dragonair', 30, 0, 1, 0),
	(943, 'dragonite', 'Dragonite', 30, 0, 1, 0),
	(944, 'mewtwo', 'Mewtwo', 30, 0, 1, 0),
	(945, 'mew', 'Mew', 30, 0, 1, 0),
	(946, 'togepi', 'Togepi', 30, 0, 1, 0),
	(947, 'boulderBadge', 'Boulder Badge', 30, 0, 1, 0),
	(948, 'cascadeBadge', 'Cascade Badge', 30, 0, 1, 0),
	(949, 'thunderBadge', 'Thunder Badge', 30, 0, 1, 0),
	(950, 'rainbowBadge', 'Rainbow Badge', 30, 0, 1, 0),
	(951, 'soulBadge', 'Soul Badge', 30, 0, 1, 0),
	(952, 'marshBadge', 'Marsh Badge', 30, 0, 1, 0),
	(953, 'volcanoBadge', 'Volcano Badge', 30, 0, 1, 0),
	(954, 'earthBadge', 'Earth Badge', 30, 0, 1, 0),
	(955, 'trophyBadge', 'Pokemon League Trophy', 30, 0, 1, 0),
	(956, 'recipe_boulderBadge', 'Boulder Badge Blueprint', 30, 0, 1, 0),
	(957, 'recipe_cascadeBadge', 'Cascade Badge Blueprint', 30, 0, 1, 0),
	(958, 'recipe_thunderBadge', 'Thunder Badge Blueprint', 30, 0, 1, 0),
	(959, 'recipe_rainbowBadge', 'Rainbow Badge Blueprint', 30, 0, 1, 0),
	(960, 'recipe_soulBadge', 'Soul Badge Blueprint', 30, 0, 1, 0),
	(961, 'recipe_marshBadge', 'Marsh Badge Blueprint', 30, 0, 1, 0),
	(962, 'recipe_volcanoBadge', 'Volcano Badge Blueprint', 30, 0, 1, 0),
	(963, 'recipe_earthBadge', 'Earth Badge Blueprint', 30, 0, 1, 0),
	(964, 'cannabis', 'Cannabis seed', 10, 0, 1, 0),
	(965, 'marijuana', 'Marijuana', 60, 0, 1, 0),
	(966, 'acqua', 'Water For Plants', 5, 0, 1, 0),
	(967, 'fertilizzante', 'Fertilizzante', 5, 0, 1, 0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.jobs
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.jobs: ~59 rows (approximately)
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` (`id`, `name`, `label`, `whitelisted`) VALUES
	(1, 'ambulance', 'Ambulance', 1),
	(2, 'bikedealer', 'Bikedealer', 1),
	(3, 'biker', 'Biker', 1),
	(4, 'bus', 'busdriver', 1),
	(5, 'cardealer', 'Car Dealer', 1),
	(6, 'deliverer', 'DHL', 1),
	(7, 'fire', 'LSFD', 1),
	(8, 'tuner', 'Tuner Shop', 1),
	(9, 'fueler', 'Fueler', 1),
	(10, 'gang', 'Gang', 1),
	(11, 'garbage', 'Biffa', 0),
	(12, 'gopostal', 'Go Postal', 0),
	(13, 'kfc', 'Kfc', 1),
	(14, 'krowa', 'Farmer', 1),
	(15, 'lazy', 'Sons of Anarchy', 1),
	(16, 'security', 'Security', 1),
	(17, 'mafia', 'Mafia', 1),
	(18, 'markos', 'Markos', 1),
	(19, 'mcdonalds', 'McDonalds', 1),
	(20, 'mecano', 'AA Mechanic', 1),
	(21, 'mechanic', 'Mechanic', 1),
	(23, 'miner', 'Miner', 0),
	(24, 'offambulance', 'Off-Duty', 1),
	(25, 'offmechanic', 'Off-Duty', 1),
	(26, 'offpolice', 'Off-Duty', 1),
	(27, 'pawn', 'Pawn', 1),
	(28, 'pdm', 'PDM - Cardealer', 1),
	(29, 'pizza', 'Dominos', 1),
	(30, 'police', 'LEO', 1),
	(31, 'realestateagent', 'Real Estate Agent', 1),
	(32, 'reporter', 'Reporter', 0),
	(33, 'sky', 'SkyEngineer', 1),
	(34, 'slaughterer', 'Butcher', 0),
	(36, 'tailor', 'Tailor', 1),
	(37, 'taxi', 'Taxi', 0),
	(38, 'trucker', 'Trucker', 0),
	(39, 'unemployed', 'Unemployed', 0),
	(40, 'vagos', 'Vagos', 1),
	(41, 'woodyguns', 'Woodyguns', 1),
	(42, 'ballas', 'Ballas', 1),
	(43, 'DA', 'DA', 1),
	(45, 'lawyer', 'lawyer', 1),
	(46, 'taco', 'Taco', 0),
	(47, 'doc', 'Doc', 0),
	(48, 'offdoc', 'Off DOC', 0),
	(49, 'mayor', 'Mayor', 1),
	(50, 'lawyer', 'Lawyer', 1),
	(51, 'lawyer', 'Lawyer', 1),
	(52, 'lmc', 'Miner', 1),
	(53, 'dispatch', 'Dispatch', 1),
	(54, 'offdispatch', 'Off Dispatch', 1),
	(55, 'vu', 'Vu-Bartender', 1),
	(56, 'vu', 'Vu-Security', 1),
	(57, 'vu', 'Vu-Manager', 1),
	(58, 'vu2', 'VU-Management', 1),
	(59, 'lostmc', 'Lost-MC', 1),
	(60, 'burgershot', 'Burgershot', 1),
	(61, 'cartel', 'Farmer', 1),
	(62, 'pcbuilder', 'PC Builder', 1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.job_grades
CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=275 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.job_grades: ~124 rows (approximately)
/*!40000 ALTER TABLE `job_grades` DISABLE KEYS */;
INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
	(1, 'unemployed', 0, 'unemployed', 'Unemployed', 50, '{}', '{}'),
	(2, 'ambulance', 1, 'ambulance', 'EMS', 500, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(3, 'ambulance', 2, 'doctor', 'Doctor', 700, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(4, 'ambulance', 3, 'chief_doctor', 'Chief Doctor', 900, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(5, 'ambulance', 4, 'boss', 'Boss', 1100, '{"tshirt_2":0,"hair_color_1":5,"glasses_2":3,"shoes":9,"torso_2":3,"hair_color_2":0,"pants_1":24,"glasses_1":4,"hair_1":2,"sex":0,"decals_2":0,"tshirt_1":15,"helmet_1":8,"helmet_2":0,"arms":92,"face":19,"decals_1":60,"torso_1":13,"hair_2":0,"skin":34,"pants_2":5}', '{"tshirt_2":3,"decals_2":0,"glasses":0,"hair_1":2,"torso_1":73,"shoes":1,"hair_color_2":0,"glasses_1":19,"skin":13,"face":6,"pants_2":5,"tshirt_1":75,"pants_1":37,"helmet_1":57,"torso_2":0,"arms":14,"sex":1,"glasses_2":0,"decals_1":0,"hair_2":0,"helmet_2":0,"hair_color_1":0}'),
	(13, 'fueler', 0, 'employee', 'Intern', 100, '{}', '{}'),
	(14, 'reporter', 0, 'employee', 'Intern', 100, '{}', '{}'),
	(15, 'tailor', 0, 'employee', 'Intern', 100, '{"mask_1":0,"arms":1,"glasses_1":0,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":0,"torso_1":24,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":0,"lipstick_2":0,"chain_1":0,"tshirt_1":0,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":36,"tshirt_2":0,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":48,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}', '{"mask_1":0,"arms":5,"glasses_1":5,"hair_color_2":4,"makeup_1":0,"face":19,"glasses":0,"mask_2":0,"makeup_3":0,"skin":29,"helmet_2":0,"lipstick_4":0,"sex":1,"torso_1":52,"makeup_2":0,"bags_2":0,"chain_2":0,"ears_1":-1,"bags_1":0,"bproof_1":0,"shoes_2":1,"lipstick_2":0,"chain_1":0,"tshirt_1":23,"eyebrows_3":0,"pants_2":0,"beard_4":0,"torso_2":0,"beard_2":6,"ears_2":0,"hair_2":0,"shoes_1":42,"tshirt_2":4,"beard_3":0,"hair_1":2,"hair_color_1":0,"pants_1":36,"helmet_1":-1,"bproof_2":0,"eyebrows_4":0,"eyebrows_2":0,"decals_1":0,"age_2":0,"beard_1":5,"shoes":10,"lipstick_1":0,"eyebrows_1":0,"glasses_2":0,"makeup_4":0,"decals_2":0,"lipstick_3":0,"age_1":0}'),
	(17, 'slaughterer', 0, 'employee', 'Intern', 100, '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":67,"pants_1":36,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":0,"torso_1":56,"beard_2":6,"shoes_1":12,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":15,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":0,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}', '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":72,"pants_1":45,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":1,"torso_1":49,"beard_2":6,"shoes_1":24,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":9,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":5,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}'),
	(18, 'mechanic', 0, 'recrue', 'Recruit', 100, '{}', '{}'),
	(19, 'mechanic', 1, 'novice', 'Novice', 100, '{}', '{}'),
	(20, 'mechanic', 2, 'experimente', 'Experienced', 100, '{}', '{}'),
	(21, 'mechanic', 3, 'chief', 'Chief', 150, '{}', '{}'),
	(22, 'mechanic', 4, 'boss', 'Boss', 200, '{}', '{}'),
	(23, 'security', 0, 'employee', 'Employee', 150, '', ''),
	(24, 'security', 1, 'ceo', 'CEO', 150, '', ''),
	(28, 'realestateagent', 0, 'location', 'Location', 10, '{}', '{}'),
	(29, 'realestateagent', 1, 'vendeur', 'Seller', 25, '{}', '{}'),
	(30, 'realestateagent', 2, 'gestion', 'Management', 40, '{}', '{}'),
	(31, 'realestateagent', 3, 'boss', 'Boss', 450, '{}', '{}'),
	(32, 'taxi', 0, 'recrue', 'Recruit', 100, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(33, 'taxi', 1, 'novice', 'Novice', 100, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(34, 'taxi', 2, 'experimente', 'Experienced', 100, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(35, 'taxi', 3, 'uber', 'Uber', 100, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(36, 'taxi', 4, 'boss', 'Boss', 200, '{"hair_2":0,"hair_color_2":0,"torso_1":29,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":31,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":1,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":4,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
	(41, 'bus', 0, 'employee', 'Valores', 200, '{}', '{}'),
	(42, 'offpolice', 0, 'recruit', 'Recrue', 50, '{}', '{}'),
	(43, 'offpolice', 1, 'officer', 'Officer', 50, '{}', '{}'),
	(44, 'offpolice', 2, 'sergeant', 'Sergeant', 50, '{}', '{}'),
	(45, 'offpolice', 3, 'lieutenant', 'Lieutenant', 50, '{}', '{}'),
	(46, 'offpolice', 4, 'boss', 'Commandant', 50, '{}', '{}'),
	(47, 'offambulance', 1, 'ambulance', 'Ambulance', 300, '{}', '{}'),
	(48, 'offambulance', 2, 'doctor', 'Doctor', 300, '{}', '{}'),
	(49, 'offambulance', 3, 'chief_doctor', 'Chief Doctor', 300, '{}', '{}'),
	(50, 'offambulance', 4, 'boss', 'Boss', 300, '{}', '{}'),
	(56, 'fire', 0, 'recruit', 'Recrue', 20, '{"tshirt_1":57,"torso_1":55,"arms":0,"pants_1":35,"glasses":0,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":5,"face":19,"glasses_2":1,"torso_2":0,"shoes":24,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":8}', '{"tshirt_1":34,"torso_1":48,"shoes":24,"pants_1":34,"torso_2":0,"decals_2":0,"hair_color_2":0,"glasses":0,"helmet_2":0,"hair_2":3,"face":21,"decals_1":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"arms":14,"hair_color_1":10,"tshirt_2":0,"helmet_1":57}'),
	(57, 'fire', 1, 'sergeant', 'Sergent', 40, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":1,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":0,"decals_1":8,"torso_2":0,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"hair_color_1":5,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":14,"pants_1":34,"pants_2":0,"decals_2":1,"hair_color_2":0,"shoes":24,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"face":21,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"hair_color_1":10,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(58, 'fire', 2, 'lieutenant', 'Lieutenant', 65, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":2,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"glasses":0,"decals_1":8,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"torso_2":0,"arms":41,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"hair_2":3,"decals_2":2,"hair_color_2":0,"hair_color_1":10,"helmet_2":0,"face":21,"shoes":24,"torso_2":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"decals_1":7,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(59, 'fire', 3, 'boss', 'Commandant', 80, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":41,"torso_2":0,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"decals_1":8,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":21,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"hair_color_1":10,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"shoes":24,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(60, 'krowa', 0, 'employee', 'Farmer', 100, '', ''),
	(61, 'krowa', 0, 'employee', 'Farmer', 10, '', ''),
	(62, 'krowa', 0, 'employee', 'Farmer', 10, '', ''),
	(63, 'cardealer', 0, 'recruit', 'Recrue', 500, '{}', '{}'),
	(64, 'cardealer', 1, 'novice', 'Novice', 25, '{}', '{}'),
	(65, 'cardealer', 2, 'experienced', 'Experimente', 40, '{}', '{}'),
	(66, 'cardealer', 3, 'boss', 'Patron', 500, '{}', '{}'),
	(67, 'pdm', 0, 'recruit', 'Recruit', 100, '{}', '{}'),
	(68, 'pdm', 1, 'novice', 'Novice', 150, '{}', '{}'),
	(69, 'pdm', 2, 'employee', 'Employee', 200, '{}', '{}'),
	(70, 'pdm', 3, 'manager', 'Manager', 250, '{}', '{}'),
	(71, 'pdm', 4, 'boss', 'Boss', 300, '{}', '{}'),
	(72, 'tuner', 0, 'recruit', 'Recruit', 100, '', ''),
	(73, 'tuner', 1, 'novice', 'Novice', 150, '', ''),
	(74, 'tuner', 2, 'employee', 'Employee', 200, '', ''),
	(75, 'tuner', 3, 'manager', 'Manager', 250, '', ''),
	(76, 'tuner', 4, 'boss', 'Boss', 300, '', ''),
	(83, 'fire', 0, 'recruit', 'Recrue', 250, '{"tshirt_1":57,"torso_1":55,"arms":0,"pants_1":35,"glasses":0,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":5,"face":19,"glasses_2":1,"torso_2":0,"shoes":24,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":8}', '{"tshirt_1":34,"torso_1":48,"shoes":24,"pants_1":34,"torso_2":0,"decals_2":0,"hair_color_2":0,"glasses":0,"helmet_2":0,"hair_2":3,"face":21,"decals_1":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"arms":14,"hair_color_1":10,"tshirt_2":0,"helmet_1":57}'),
	(84, 'fire', 1, 'sergeant', 'Sergent', 250, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":1,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":0,"decals_1":8,"torso_2":0,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"hair_color_1":5,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":14,"pants_1":34,"pants_2":0,"decals_2":1,"hair_color_2":0,"shoes":24,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"face":21,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"hair_color_1":10,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(85, 'fire', 2, 'lieutenant', 'Lieutenant', 250, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":2,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"glasses":0,"decals_1":8,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"torso_2":0,"arms":41,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"hair_2":3,"decals_2":2,"hair_color_2":0,"hair_color_1":10,"helmet_2":0,"face":21,"shoes":24,"torso_2":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"decals_1":7,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(86, 'fire', 3, 'boss', 'Commandant', 250, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":41,"torso_2":0,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"decals_1":8,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":21,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"hair_color_1":10,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"shoes":24,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(87, 'gopostal', 0, 'employee', 'RoyalMail', 100, '', ''),
	(89, 'bus', 0, 'employee', 'BusDriver', 260, '{}', '{}'),
	(91, 'deliverer', 0, 'employee', 'Driver', 200, '', ''),
	(98, 'trucker', 0, 'employee', 'Stobarts', 100, '{"tshirt_1":59,"torso_1":89,"arms":31,"pants_1":36,"glasses_1":19,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":2,"glasses_2":0,"torso_2":1,"shoes":35,"hair_1":0,"skin":0,"sex":0,"glasses_1":19,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":5}', '{"tshirt_1":36,"torso_1":0,"arms":68,"pants_1":30,"glasses_1":15,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":27,"glasses_2":0,"torso_2":11,"shoes":26,"hair_1":5,"skin":0,"sex":1,"glasses_1":15,"pants_2":2,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":19}'),
	(99, 'sky', 0, 'employee', 'Engineer', 100, '{"tshirt_1":59,"torso_1":89,"arms":31,"pants_1":36,"glasses_1":19,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":2,"glasses_2":0,"torso_2":1,"shoes":35,"hair_1":0,"skin":0,"sex":0,"glasses_1":19,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":5}', '{"tshirt_1":36,"torso_1":0,"arms":68,"pants_1":30,"glasses_1":15,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":0,"face":27,"glasses_2":0,"torso_2":11,"shoes":26,"hair_1":5,"skin":0,"sex":1,"glasses_1":15,"pants_2":2,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":19}'),
	(100, 'garbage', 0, 'employee', 'Collector', 100, '', ''),
	(110, 'fueler', 0, 'employee', 'IntÃƒÂ©rimaire', 0, '{}', '{}'),
	(111, 'miner', 0, 'employee', 'Intermediate', 0, '}', ''),
	(112, 'slaughterer', 0, 'employee', 'IntÃƒÂ©rimaire', 0, '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":67,"pants_1":36,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":0,"torso_1":56,"beard_2":6,"shoes_1":12,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":15,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":0,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}', '{"age_1":0,"glasses_2":0,"beard_1":5,"decals_2":0,"beard_4":0,"shoes_2":0,"tshirt_2":0,"lipstick_2":0,"hair_2":0,"arms":72,"pants_1":45,"skin":29,"eyebrows_2":0,"shoes":10,"helmet_1":-1,"lipstick_1":0,"helmet_2":0,"hair_color_1":0,"glasses":0,"makeup_4":0,"makeup_1":0,"hair_1":2,"bproof_1":0,"bags_1":0,"mask_1":0,"lipstick_3":0,"chain_1":0,"eyebrows_4":0,"sex":1,"torso_1":49,"beard_2":6,"shoes_1":24,"decals_1":0,"face":19,"lipstick_4":0,"tshirt_1":9,"mask_2":0,"age_2":0,"eyebrows_3":0,"chain_2":0,"glasses_1":5,"ears_1":-1,"bags_2":0,"ears_2":0,"torso_2":0,"bproof_2":0,"makeup_2":0,"eyebrows_1":0,"makeup_3":0,"pants_2":0,"beard_3":0,"hair_color_2":4}'),
	(113, 'cardealer', 0, 'recruit', 'Recruit', 100, '{}', '{}'),
	(114, 'cardealer', 1, 'novice', 'Novice', 200, '{}', '{}'),
	(115, 'cardealer', 2, 'experienced', 'Experienced', 300, '{}', '{}'),
	(116, 'cardealer', 3, 'manager', 'Manager', 500, '{}', '{}'),
	(152, 'krowa', 0, 'employee', 'Farmer', 10, '', ''),
	(153, 'pawn', 0, 'employee', 'Boss', 100, '', ''),
	(181, 'police', 0, 'recruit', 'Recruit', 800, '{}', '{}'),
	(182, 'police', 1, 'officer', 'Officer', 800, '{}', '{}'),
	(183, 'police', 2, 'sergeant', 'Sergeant', 800, '{}', '{}'),
	(184, 'police', 3, 'lieutenant', 'LEO', 900, '{}', '{}'),
	(185, 'police', 4, 'boss', 'Chief', 1100, '{}', '{}'),
	(186, 'miner', 0, 'employee', 'Employee', 0, '{}', '{}'),
	(228, 'offmechanic', 0, 'recruit', 'Recruit', 200, '{}', '{}'),
	(229, 'offmechanic', 1, 'novice', 'Novice', 200, '{}', '{}'),
	(230, 'offmechanic', 2, 'experienced', 'Experienced', 200, '{}', '{}'),
	(231, 'offmechanic', 3, 'chief', 'Head Mechanic', 200, '{}', '{}'),
	(232, 'offmechanic', 4, 'boss', 'Boss', 200, '{}', '{}'),
	(233, 'ballas', 0, 'recruit', 'Recruit', 100, '{"tshirt_1":57,"torso_1":55,"arms":0,"pants_1":35,"glasses":0,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":5,"face":19,"glasses_2":1,"torso_2":0,"shoes":24,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":8}', '{"tshirt_1":34,"torso_1":48,"shoes":24,"pants_1":34,"torso_2":0,"decals_2":0,"hair_color_2":0,"glasses":0,"helmet_2":0,"hair_2":3,"face":21,"decals_1":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"arms":14,"hair_color_1":10,"tshirt_2":0,"helmet_1":57}'),
	(234, 'ballas', 1, 'balla', 'Balla', 100, '{"tshirt_1":57,"torso_1":55,"arms":0,"pants_1":35,"glasses":0,"decals_2":0,"hair_color_2":0,"helmet_2":0,"hair_color_1":5,"face":19,"glasses_2":1,"torso_2":0,"shoes":24,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"pants_2":0,"hair_2":0,"decals_1":0,"tshirt_2":0,"helmet_1":8}', '{"tshirt_1":34,"torso_1":48,"shoes":24,"pants_1":34,"torso_2":0,"decals_2":0,"hair_color_2":0,"glasses":0,"helmet_2":0,"hair_2":3,"face":21,"decals_1":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"arms":14,"hair_color_1":10,"tshirt_2":0,"helmet_1":57}'),
	(236, 'ballas', 3, 'sergeant1', 'Sergeant I', 100, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":1,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":0,"decals_1":8,"torso_2":0,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"hair_color_1":5,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":14,"pants_1":34,"pants_2":0,"decals_2":1,"hair_color_2":0,"shoes":24,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"face":21,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"hair_color_1":10,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(237, 'ballas', 4, 'sergeant2', 'Sergeant II', 100, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":1,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":0,"decals_1":8,"torso_2":0,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"hair_color_1":5,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":14,"pants_1":34,"pants_2":0,"decals_2":1,"hair_color_2":0,"shoes":24,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"face":21,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"hair_color_1":10,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(238, 'ballas', 5, 'lieutenant', 'Lieutenant', 100, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":1,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":0,"decals_1":8,"torso_2":0,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"hair_color_1":5,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":14,"pants_1":34,"pants_2":0,"decals_2":1,"hair_color_2":0,"shoes":24,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"face":21,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"hair_color_1":10,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(239, 'ballas', 6, 'captain', 'Captain', 400, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":2,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"glasses":0,"decals_1":8,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"torso_2":0,"arms":41,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"hair_2":3,"decals_2":2,"hair_color_2":0,"hair_color_1":10,"helmet_2":0,"face":21,"shoes":24,"torso_2":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"decals_1":7,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(240, 'ballas', 7, 'commander', 'Commander', 100, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":2,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"glasses":0,"decals_1":8,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"torso_2":0,"arms":41,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"hair_2":3,"decals_2":2,"hair_color_2":0,"hair_color_1":10,"helmet_2":0,"face":21,"shoes":24,"torso_2":0,"glasses_2":1,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"pants_2":0,"decals_1":7,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(241, 'ballas', 8, 'chief', 'Assistant Balla', 100, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":41,"torso_2":0,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"decals_1":8,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":21,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"hair_color_1":10,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"shoes":24,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(242, 'ballas', 9, 'boss', 'Head Balla', 100, '{"tshirt_1":58,"torso_1":55,"shoes":24,"pants_1":35,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":19,"helmet_2":0,"hair_2":0,"arms":41,"torso_2":0,"hair_color_1":5,"hair_1":2,"skin":34,"sex":0,"glasses_1":0,"glasses_2":1,"decals_1":8,"glasses":0,"tshirt_2":0,"helmet_1":11}', '{"tshirt_1":35,"torso_1":48,"arms":44,"pants_1":34,"pants_2":0,"decals_2":3,"hair_color_2":0,"face":21,"helmet_2":0,"hair_2":3,"decals_1":7,"torso_2":0,"hair_color_1":10,"hair_1":11,"skin":34,"sex":1,"glasses_1":5,"glasses_2":1,"shoes":24,"glasses":0,"tshirt_2":0,"helmet_1":57}'),
	(245, 'DA', 0, 'DA', 'DA', 600, '', ''),
	(247, 'lawyer', 0, 'lawyer', 'Lawyer', 500, '', ''),
	(248, 'taco', 0, 'tac', 'Taco', 75, '', ''),
	(249, 'realestateagent', 4, 'realestateagent', 'Owner', 200, '{}', '{}'),
	(250, 'cardealer', 4, 'Boss', 'Boss', 0, '', ''),
	(251, 'doc', 0, 'doc', 'DOC', 200, '', ''),
	(252, 'offdoc', 0, 'offdoc', 'Off DOC', 100, '', ''),
	(253, 'bikedealer', 0, 'recruit', 'Recruit', 50, '', ''),
	(254, 'bikedealer', 1, 'novice', 'Novice', 50, '', ''),
	(255, 'bikedealer', 2, 'employee', 'Employee', 75, '', ''),
	(256, 'bikedealer', 3, 'manager', 'Manager', 75, '', ''),
	(257, 'bikedealer', 4, 'boss', 'Owner', 750, '', ''),
	(258, 'mayor', 1, 'mayor', 'Mayor', 500, '', ''),
	(259, 'lawyer', 1, 'lawyer', 'Lawyer', 400, '{}', '{}'),
	(260, 'lawyer', 1, 'lawyer', 'Lawyer', 400, '{}', '{}'),
	(261, 'lmc', 1, 'Miner', 'Miner', 100, '[]', '[]'),
	(262, 'lmc', 0, 'lmc', 'Miner', 100, '{}', '{}'),
	(263, 'dispatch', 1, 'dispatch', 'Dispatch', 300, '{}', '{}'),
	(264, 'offdispatch', 1, 'offdispatch', 'Off Dispatch', 300, '{}', '{}'),
	(265, 'vu', 1, 'bartender', 'Vu-Bartender', 200, '{}', '{}'),
	(266, 'vu', 2, 'security', 'Vu-Security', 200, '{}', '{}'),
	(267, 'vu', 3, 'manager', 'Vu-Manager', 200, '{}', '{}'),
	(268, 'vu2', 1, 'management', 'VU-Management', 200, '{}', '{}'),
	(269, 'ambulance', 0, 'recruit', 'EMT Recruit', 400, '{}', '{}'),
	(270, 'lostmc', 0, 'Lost-MC', 'Lost-MC', 75, '{}', '{}'),
	(271, 'burgershot', 1, 'employee', 'Employee', 300, '{}', '{}'),
	(272, 'burgershot', 2, 'manager', 'Manager', 300, '{}', '{}'),
	(273, 'cartel', 1, 'cartel', 'Farmer', 50, '{}', '{}'),
	(274, 'pcbuilder', 0, 'pcbuilder', 'PC Builder', 500, '{}', '{}');
/*!40000 ALTER TABLE `job_grades` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.kicks
CREATE TABLE IF NOT EXISTS `kicks` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `steamid` varchar(255) NOT NULL,
  `kicked` int(11) NOT NULL,
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.kicks: ~0 rows (approximately)
/*!40000 ALTER TABLE `kicks` DISABLE KEYS */;
/*!40000 ALTER TABLE `kicks` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.licenses
CREATE TABLE IF NOT EXISTS `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.licenses: ~10 rows (approximately)
/*!40000 ALTER TABLE `licenses` DISABLE KEYS */;
INSERT INTO `licenses` (`type`, `label`) VALUES
	('bee_processing', 'Bee Processing License'),
	('boat', 'Boat License'),
	('dig_processing', 'dig Processing License'),
	('dmv', 'Traffic Laws'),
	('drive', 'Driver\'s license'),
	('drive_bike', 'Motorcycle licence'),
	('drive_truck', 'Truck license'),
	('gold_processing', 'Gold Processing License'),
	('weapon', 'License to carry a weapon'),
	('weed_processing', 'Weed Processing License');
/*!40000 ALTER TABLE `licenses` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.mdt_reports
CREATE TABLE IF NOT EXISTS `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.mdt_reports: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_reports` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_reports` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.mdt_warrants
CREATE TABLE IF NOT EXISTS `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.mdt_warrants: ~0 rows (approximately)
/*!40000 ALTER TABLE `mdt_warrants` DISABLE KEYS */;
/*!40000 ALTER TABLE `mdt_warrants` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.medical_records
CREATE TABLE IF NOT EXISTS `medical_records` (
  `name` varchar(255) DEFAULT NULL,
  `text` longtext DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.medical_records: ~0 rows (approximately)
/*!40000 ALTER TABLE `medical_records` DISABLE KEYS */;
/*!40000 ALTER TABLE `medical_records` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.owned_vehicles
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(22) COLLATE utf8mb4_bin NOT NULL,
  `plate` varchar(12) COLLATE utf8mb4_bin NOT NULL,
  `vehicle` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `type` varchar(20) COLLATE utf8mb4_bin NOT NULL DEFAULT 'car',
  `stored` tinyint(1) NOT NULL DEFAULT 0,
  `vehiclename` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `state` varchar(50) COLLATE utf8mb4_bin DEFAULT '0',
  `garage` varchar(200) COLLATE utf8mb4_bin DEFAULT 'T',
  `finance` int(32) NOT NULL DEFAULT 0,
  `financetimer` int(32) NOT NULL DEFAULT 0,
  `buy_price` int(32) NOT NULL DEFAULT 0,
  `shop` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `lastpayment` int(50) DEFAULT NULL,
  `harnessDurability` double(2,1) DEFAULT 0.0,
  PRIMARY KEY (`id`),
  KEY `plate` (`plate`) USING BTREE,
  KEY `owner` (`owner`),
  KEY `IDX_owned_vehicles_harnessDurability` (`harnessDurability`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table s1873_ffrp.owned_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `owned_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `owned_vehicles` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.phone_calls
CREATE TABLE IF NOT EXISTS `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Name',
  `num` varchar(10) NOT NULL COMMENT 'Phone Number',
  `incoming` int(11) NOT NULL COMMENT 'Define Incoming Call',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `accepts` int(11) NOT NULL COMMENT 'Accept Call',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.phone_calls: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_calls` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_calls` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.phone_contacts
CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `identifier` varchar(40) NOT NULL,
  `name` longtext NOT NULL,
  `number` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.phone_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_contacts` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.phone_messages
CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL DEFAULT '',
  `sender` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` int(11) NOT NULL DEFAULT 0,
  `owner` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.phone_messages: 0 rows
/*!40000 ALTER TABLE `phone_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_messages` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.phone_yp
CREATE TABLE IF NOT EXISTS `phone_yp` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `advert` varchar(500) DEFAULT NULL,
  `phoneNumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3448 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.phone_yp: ~0 rows (approximately)
/*!40000 ALTER TABLE `phone_yp` DISABLE KEYS */;
/*!40000 ALTER TABLE `phone_yp` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.playerhousing
CREATE TABLE IF NOT EXISTS `playerhousing` (
  `id` int(32) NOT NULL,
  `owner` varchar(50) DEFAULT NULL,
  `rented` tinyint(1) DEFAULT NULL,
  `price` int(32) DEFAULT NULL,
  `wardrobe` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.playerhousing: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerhousing` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerhousing` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.playerhousing_keys
CREATE TABLE IF NOT EXISTS `playerhousing_keys` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `house_id` int(11) DEFAULT NULL,
  `house_model` int(11) DEFAULT NULL,
  `house_name` longtext DEFAULT '',
  `shared` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.playerhousing_keys: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerhousing_keys` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerhousing_keys` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.players
CREATE TABLE IF NOT EXISTS `players` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) DEFAULT NULL,
  `license` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `cash` int(11) DEFAULT NULL,
  `bank` int(11) DEFAULT NULL,
  `bsn` varchar(50) DEFAULT NULL,
  `banknumber` varchar(50) DEFAULT NULL,
  `slotname` varchar(50) DEFAULT NULL,
  `firstname` varchar(50) DEFAULT NULL,
  `tussenvoegsel` varchar(50) DEFAULT 'n.v.t.',
  `lastname` varchar(50) DEFAULT NULL,
  `sex` varchar(50) DEFAULT NULL,
  `dob` varchar(50) DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `job_grade` varchar(50) DEFAULT '0',
  `position` text DEFAULT NULL,
  `usergroup` varchar(50) DEFAULT 'user',
  `phone` text DEFAULT NULL,
  `status` text DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.players: ~0 rows (approximately)
/*!40000 ALTER TABLE `players` DISABLE KEYS */;
/*!40000 ALTER TABLE `players` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.playerstattoos
CREATE TABLE IF NOT EXISTS `playerstattoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `tattoos` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.playerstattoos: ~0 rows (approximately)
/*!40000 ALTER TABLE `playerstattoos` DISABLE KEYS */;
/*!40000 ALTER TABLE `playerstattoos` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.player_clothing
CREATE TABLE IF NOT EXISTS `player_clothing` (
  `identifier` varchar(255) NOT NULL,
  `cid` int(11) NOT NULL,
  `sex` int(11) NOT NULL,
  `face` int(11) NOT NULL DEFAULT 0,
  `dadmumpercent` int(11) NOT NULL DEFAULT 0,
  `skinton` int(11) NOT NULL DEFAULT 0,
  `eyecolor` int(11) NOT NULL DEFAULT 0,
  `acne` int(11) NOT NULL DEFAULT 0,
  `skinproblem` int(11) NOT NULL DEFAULT 0,
  `freckle` int(11) NOT NULL DEFAULT 0,
  `wrinkle` int(11) NOT NULL DEFAULT 0,
  `wrinkleopacity` int(11) NOT NULL DEFAULT 0,
  `eyebrow` int(11) NOT NULL DEFAULT 0,
  `eyebrowopacity` int(11) NOT NULL DEFAULT 0,
  `beard` int(11) NOT NULL DEFAULT 0,
  `beardopacity` int(11) NOT NULL DEFAULT 0,
  `beardcolor` int(11) NOT NULL DEFAULT 0,
  `hair` int(11) NOT NULL DEFAULT 0,
  `hairtext` int(11) NOT NULL DEFAULT 0,
  `torso` int(11) NOT NULL DEFAULT 0,
  `torsotext` int(11) NOT NULL DEFAULT 0,
  `leg` int(11) NOT NULL DEFAULT 0,
  `legtext` int(11) NOT NULL DEFAULT 0,
  `shoes` int(11) NOT NULL DEFAULT 0,
  `shoestext` int(11) NOT NULL DEFAULT 0,
  `accessory` int(11) NOT NULL DEFAULT 0,
  `accessorytext` int(11) NOT NULL DEFAULT 0,
  `undershirt` int(11) NOT NULL DEFAULT 0,
  `undershirttext` int(11) NOT NULL DEFAULT 0,
  `torso2` int(11) NOT NULL DEFAULT 0,
  `torso2text` int(11) NOT NULL DEFAULT 0,
  `prop_hat` int(11) NOT NULL DEFAULT 0,
  `prop_hat_text` int(11) NOT NULL DEFAULT 0,
  `prop_glasses` int(11) NOT NULL DEFAULT 0,
  `prop_glasses_text` int(11) NOT NULL DEFAULT 0,
  `prop_earrings` int(11) NOT NULL DEFAULT 0,
  `prop_earrings_text` int(11) NOT NULL DEFAULT 0,
  `prop_watches` int(11) NOT NULL DEFAULT 0,
  `prop_watches_text` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.player_clothing: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_clothing` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_clothing` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.player_contacts
CREATE TABLE IF NOT EXISTS `player_contacts` (
  `identifier` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `number` int(10) unsigned zerofill DEFAULT NULL,
  `color` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.player_contacts: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_contacts` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_contacts` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.player_houses
CREATE TABLE IF NOT EXISTS `player_houses` (
  `identifier` varchar(50) DEFAULT NULL,
  `cid` int(11) DEFAULT NULL,
  `house` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.player_houses: ~0 rows (approximately)
/*!40000 ALTER TABLE `player_houses` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_houses` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.pw_motels
CREATE TABLE IF NOT EXISTS `pw_motels` (
  `rentalid` bigint(255) NOT NULL AUTO_INCREMENT,
  `ident` varchar(70) NOT NULL DEFAULT '0',
  `motelid` bigint(255) DEFAULT 0,
  `room` varchar(50) DEFAULT '0',
  `days_left` bigint(255) DEFAULT 0,
  PRIMARY KEY (`rentalid`),
  KEY `ident` (`ident`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.pw_motels: ~0 rows (approximately)
/*!40000 ALTER TABLE `pw_motels` DISABLE KEYS */;
/*!40000 ALTER TABLE `pw_motels` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.racing-maps
CREATE TABLE IF NOT EXISTS `racing-maps` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `track_name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `distance` varchar(255) DEFAULT NULL,
  `checkpoints` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=4096;

-- Dumping data for table s1873_ffrp.racing-maps: ~11 rows (approximately)
/*!40000 ALTER TABLE `racing-maps` DISABLE KEYS */;
INSERT INTO `racing-maps` (`id`, `track_name`, `description`, `distance`, `checkpoints`) VALUES
	(17, 'GrandPrix', 'GrandPrix', '16182', '[{"start":true,"flare2x":-98.21,"flare2z":30.45,"flare1x":-116.06,"dist":12.0,"y":6268.01,"x":-107.5,"flare1z":30.57,"z":29.44,"flare1y":6275.88,"flare2y":6259.84},{"start":false,"flare2x":-381.06,"flare2z":30.75,"flare1x":-399.01,"dist":12.0,"y":5982.14,"x":-390.57,"flare1z":30.94,"z":29.79,"flare1y":5990.15,"flare2y":5974.22},{"start":false,"flare2x":-1606.28,"flare2z":60.3,"flare1x":-1619.65,"dist":9.5,"y":4883.53,"x":-1613.48,"flare1z":60.44,"z":59.3,"flare1y":4890.26,"flare2y":4876.77},{"start":false,"flare2x":-2155.64,"flare2z":61.65,"flare1x":-2177.81,"dist":16.0,"y":4441.02,"x":-2167.08,"flare1z":61.59,"z":60.55,"flare1y":4452.39,"flare2y":4429.31},{"start":false,"flare2x":-2552.06,"flare2z":12.56,"flare1x":-2577.73,"dist":13.0,"y":3372.18,"x":-2565.29,"flare1z":12.7,"z":11.57,"flare1y":3374.35,"flare2y":3370.24},{"start":false,"flare2x":-2695.03,"flare2z":17.12,"flare1x":-2725.64,"dist":16.0,"y":2318.85,"x":-2710.73,"flare1z":16.6,"z":15.79,"flare1y":2323.53,"flare2y":2314.21},{"start":false,"flare2x":-2656.16,"flare2z":22.19,"flare1x":-2655.98,"dist":14.5,"y":2285.01,"x":-2655.93,"flare1z":21.81,"z":20.94,"flare1y":2270.88,"flare2y":2299.88},{"start":false,"flare2x":-2159.17,"flare2z":34.69,"flare1x":-2161.52,"dist":12.0,"y":2308.22,"x":-2160.25,"flare1z":34.61,"z":33.6,"flare1y":2296.65,"flare2y":2320.54},{"start":false,"flare2x":-1338.87,"flare2z":25.16,"flare1x":-1323.9,"dist":12.0,"y":2457.95,"x":-1331.05,"flare1z":25.28,"z":24.15,"flare1y":2448.77,"flare2y":2467.53},{"start":false,"flare2x":-1249.0,"flare2z":16.45,"flare1x":-1232.24,"dist":12.0,"y":2551.11,"x":-1240.25,"flare1z":16.45,"z":15.38,"flare1y":2542.68,"flare2y":2559.86},{"start":false,"flare2x":-347.66,"flare2z":43.6,"flare1x":-340.99,"dist":12.0,"y":2884.49,"x":-344.08,"flare1z":43.6,"z":42.55,"flare1y":2873.28,"flare2y":2896.33},{"start":false,"flare2x":294.36,"flare2z":43.95,"flare1x":300.99,"dist":12.0,"y":2639.64,"x":297.93,"flare1z":43.9,"z":42.86,"flare1y":2628.42,"flare2y":2651.48},{"start":false,"flare2x":1230.96,"flare2z":36.92,"flare1x":1231.03,"dist":12.0,"y":2682.23,"x":1231.15,"flare1z":36.94,"z":35.87,"flare1y":2670.61,"flare2y":2694.61},{"start":false,"flare2x":2062.63,"flare2z":44.36,"flare1x":2067.14,"dist":12.0,"y":2996.79,"x":2065.09,"flare1z":44.37,"z":43.3,"flare1y":2985.34,"flare2y":3008.92},{"start":false,"flare2x":2444.77,"flare2z":48.41,"flare1x":2430.51,"dist":9.0,"y":2873.41,"x":2437.43,"flare1z":48.4,"z":47.34,"flare1y":2868.25,"flare2y":2879.23},{"start":false,"flare2x":2456.45,"flare2z":47.84,"flare1x":2469.03,"dist":8.0,"y":2885.46,"x":2463.12,"flare1z":47.29,"z":46.48,"flare1y":2880.64,"flare2y":2890.51},{"start":false,"flare2x":2824.8,"flare2z":54.3,"flare1x":2848.36,"dist":12.5,"y":3473.78,"x":2836.98,"flare1z":54.26,"z":53.21,"flare1y":3469.6,"flare2y":3477.95},{"start":false,"flare2x":2769.8,"flare2z":46.2,"flare1x":2792.96,"dist":12.0,"y":4509.01,"x":2781.7,"flare1z":46.18,"z":45.12,"flare1y":4511.93,"flare2y":4505.63},{"start":false,"flare2x":1700.56,"flare2z":31.91,"flare1x":1706.57,"dist":13.5,"y":6381.14,"x":1703.51,"flare1z":31.88,"z":30.82,"flare1y":6393.91,"flare2y":6367.58},{"start":false,"flare2x":118.07,"flare2z":30.45,"flare1x":94.27,"dist":17.0,"y":6482.64,"x":105.81,"flare1z":30.79,"z":29.56,"flare1y":6494.61,"flare2y":6470.33}]'),
	(18, 'Grapeseed Gas', 'Grapeseed Gas', '3911', '[{"start":true,"flare2y":4912.57,"flare2z":41.43,"flare1x":1645.66,"dist":17.5,"y":4911.44,"x":1662.77,"flare1z":41.28,"z":40.29,"flare1y":4910.63,"flare2x":1680.61},{"start":false,"flare2y":4638.15,"flare2z":42.42,"flare1x":1693.52,"dist":17.5,"y":4626.82,"x":1706.94,"flare1z":42.65,"z":41.47,"flare1y":4616.17,"flare2x":1720.76},{"start":false,"flare2y":4602.98,"flare2z":36.15,"flare1x":1891.06,"dist":17.5,"y":4585.29,"x":1888.92,"flare1z":36.11,"z":35.07,"flare1y":4568.29,"flare2x":1886.43},{"start":false,"flare2y":4760.42,"flare2z":39.83,"flare1x":2201.73,"dist":17.5,"y":4742.97,"x":2205.68,"flare1z":39.91,"z":38.81,"flare1y":4726.3,"flare2x":2209.52},{"start":false,"flare2y":4579.16,"flare2z":36.05,"flare1x":2442.39,"dist":17.5,"y":4571.95,"x":2458.23,"flare1z":36.01,"z":34.96,"flare1y":4565.44,"flare2x":2474.58},{"start":false,"flare2y":4168.72,"flare2z":36.81,"flare1x":2469.03,"dist":17.5,"y":4157.02,"x":2482.2,"flare1z":37.1,"z":35.9,"flare1y":4146.06,"flare2x":2495.71},{"start":false,"flare2y":4189.15,"flare2z":39.15,"flare1x":2552.82,"dist":17.5,"y":4180.56,"x":2537.96,"flare1z":39.18,"z":38.11,"flare1y":4172.03,"flare2x":2522.29},{"start":false,"flare2y":4424.77,"flare2z":47.97,"flare1x":2796.68,"dist":17.5,"y":4407.84,"x":2791.45,"flare1z":48.62,"z":47.24,"flare1y":4391.53,"flare2x":2785.74},{"start":false,"flare2y":4470.5,"flare2z":46.95,"flare1x":2932.44,"dist":17.5,"y":4453.69,"x":2926.9,"flare1z":47.04,"z":45.92,"flare1y":4437.48,"flare2x":2920.86},{"start":false,"flare2y":4948.4,"flare2z":32.94,"flare1x":2796.49,"dist":17.5,"y":4961.48,"x":2784.56,"flare1z":33.01,"z":31.91,"flare1y":4973.78,"flare2x":2772.39},{"start":false,"flare2y":5093.95,"flare2z":44.11,"flare1x":2621.99,"dist":17.5,"y":5111.22,"x":2626.02,"flare1z":44.18,"z":43.08,"flare1y":5127.87,"flare2x":2630.59},{"start":false,"flare2y":5201.72,"flare2z":59.15,"flare1x":2325.33,"dist":17.5,"y":5215.91,"x":2335.53,"flare1z":59.13,"z":58.07,"flare1y":5229.68,"flare2x":2346.39},{"start":false,"flare2y":5128.08,"flare2z":42.93,"flare1x":1957.9,"dist":17.5,"y":5144.78,"x":1951.56,"flare1z":42.8,"z":41.8,"flare1y":5160.68,"flare2x":1945.19}]'),
	(20, 'Docks 1.0', 'Docks to paleto, paleto and back', '27788', '[{"y":-2963.08,"flare2y":-2963.03,"flare2x":722.17,"start":true,"flare1x":759.17,"x":741.04,"flare1y":-2963.4,"flare1z":5.05,"z":3.98,"dist":18.5,"flare2z":5.05},{"y":-2695.87,"flare2y":-2697.55,"flare2x":712.34,"start":false,"flare1x":755.23,"x":734.14,"flare1y":-2694.5,"flare1z":7.65,"z":6.46,"dist":21.5,"flare2z":7.38},{"y":-2083.49,"flare2y":-2081.41,"flare2x":744.24,"start":false,"flare1x":804.08,"x":774.54,"flare1y":-2085.78,"flare1z":28.28,"z":27.48,"dist":30.0,"flare2z":28.82},{"y":-1636.79,"flare2y":-1633.59,"flare2x":809.84,"start":false,"flare1x":869.48,"x":840.04,"flare1y":-1640.18,"flare1z":29.66,"z":28.76,"dist":30.0,"flare2z":29.97},{"y":-1170.06,"flare2y":-1170.08,"flare2x":782.38,"start":false,"flare1x":810.38,"x":796.75,"flare1y":-1170.31,"flare1z":27.98,"z":26.94,"dist":14.0,"flare2z":28.03},{"y":-359.26,"flare2y":-378.17,"flare2x":569.62,"start":false,"flare1x":584.89,"x":577.2,"flare1y":-341.2,"flare1z":42.89,"z":41.83,"dist":20.0,"flare2z":42.89},{"y":-368.35,"flare2y":-384.53,"flare2x":458.87,"start":false,"flare1x":413.02,"x":435.56,"flare1y":-352.38,"flare1z":46.37,"z":45.32,"dist":28.0,"flare2z":46.4},{"y":-794.69,"flare2y":-804.59,"flare2x":207.15,"start":false,"flare1x":154.76,"x":180.56,"flare1y":-784.8,"flare1z":30.69,"z":29.57,"dist":28.0,"flare2z":30.59},{"y":-966.91,"flare2y":-973.97,"flare2x":145.14,"start":false,"flare1x":90.98,"x":117.66,"flare1y":-959.73,"flare1z":28.72,"z":27.71,"dist":28.0,"flare2z":28.84},{"y":-1135.89,"flare2y":-1164.26,"flare2x":-2.75,"start":false,"flare1x":-2.1,"x":-2.56,"flare1y":-1108.27,"flare1z":27.19,"z":26.24,"dist":28.0,"flare2z":27.44},{"y":-1121.13,"flare2y":-1148.88,"flare2x":-400.54,"start":false,"flare1x":-387.99,"x":-394.61,"flare1y":-1094.31,"flare1z":28.11,"z":27.59,"dist":28.0,"flare2z":29.21},{"y":-1001.61,"flare2y":-1003.25,"flare2x":-566.86,"start":false,"flare1x":-510.93,"x":-538.54,"flare1y":-1000.61,"flare1z":22.57,"z":21.48,"dist":28.0,"flare2z":22.5},{"y":-758.88,"flare2y":-774.5,"flare2x":-537.01,"start":false,"flare1x":-489.99,"x":-513.33,"flare1y":-744.09,"flare1z":31.63,"z":30.18,"dist":28.0,"flare2z":30.83},{"y":-658.86,"flare2y":-687.21,"flare2x":-603.02,"start":false,"flare1x":-600.99,"x":-602.16,"flare1y":-631.27,"flare1z":32.27,"z":30.42,"dist":28.0,"flare2z":30.68},{"y":-784.36,"flare2y":-805.58,"flare2x":-1087.97,"start":false,"flare1x":-1124.92,"x":-1106.81,"flare1y":-763.5,"flare1z":18.22,"z":17.11,"dist":28.0,"flare2z":18.14},{"y":-820.45,"flare2y":-841.75,"flare2x":-1376.05,"start":false,"flare1x":-1338.98,"x":-1357.38,"flare1y":-799.92,"flare1z":16.31,"z":17.01,"dist":28.0,"flare2z":19.85},{"y":-560.86,"flare2y":-589.18,"flare2x":-1734.21,"start":false,"flare1x":-1730.63,"x":-1732.65,"flare1y":-533.32,"flare1z":36.05,"z":35.69,"dist":28.0,"flare2z":37.47},{"y":-374.46,"flare2y":-400.1,"flare2x":-2103.77,"start":false,"flare1x":-2079.51,"x":-2091.62,"flare1y":-349.63,"flare1z":11.81,"z":10.7,"dist":28.0,"flare2z":11.72},{"y":-26.84,"flare2y":-44.99,"flare2x":-2720.7,"start":false,"flare1x":-2677.49,"x":-2698.89,"flare1y":-9.37,"flare1z":14.72,"z":13.83,"dist":28.0,"flare2z":15.07},{"y":1229.25,"flare2y":1230.99,"flare2x":-3131.1,"start":false,"flare1x":-3075.31,"x":-3102.78,"flare1y":1226.18,"flare1z":19.52,"z":18.48,"dist":28.0,"flare2z":19.57},{"y":2444.76,"flare2y":2448.68,"flare2x":-2713.91,"start":false,"flare1x":-2658.65,"x":-2685.8,"flare1y":2439.62,"flare1z":15.86,"z":14.88,"dist":28.0,"flare2z":16.03},{"y":3568.92,"flare2y":3579.45,"flare2x":-2522.94,"start":false,"flare1x":-2471.06,"x":-2496.6,"flare1y":3558.38,"flare1z":14.29,"z":13.2,"dist":28.0,"flare2z":14.25},{"y":4539.19,"flare2y":4548.59,"flare2x":-1988.21,"start":false,"flare1x":-1971.32,"x":-1979.42,"flare1y":4530.16,"flare1z":56.3,"z":55.21,"dist":12.5,"flare2z":56.26},{"y":5013.86,"flare2y":5030.87,"flare2x":-1509.59,"start":false,"flare1x":-1474.11,"x":-1491.46,"flare1y":4997.08,"flare1z":61.89,"z":60.98,"dist":24.5,"flare2z":62.21},{"y":6328.75,"flare2y":6345.82,"flare2x":-64.64,"start":false,"flare1x":-29.42,"x":-46.54,"flare1y":6311.75,"flare1z":30.55,"z":29.51,"dist":24.5,"flare2z":30.59},{"y":5511.42,"flare2y":5518.5,"flare2x":2532.97,"start":false,"flare1x":2485.9,"x":2509.12,"flare1y":5504.88,"flare1z":44.02,"z":42.92,"dist":24.5,"flare2z":43.95},{"y":3863.82,"flare2y":3863.95,"flare2x":2933.43,"start":false,"flare1x":2906.44,"x":2919.56,"flare1y":3864.46,"flare1z":51.75,"z":50.64,"dist":13.5,"flare2z":51.65},{"y":3116.39,"flare2y":3133.85,"flare2x":2645.83,"start":false,"flare1x":2615.15,"x":2630.34,"flare1y":3099.66,"flare1z":46.97,"z":47.09,"dist":23.0,"flare2z":49.37},{"y":3116.87,"flare2y":3102.49,"flare2x":2649.33,"start":false,"flare1x":2613.23,"x":2630.9,"flare1y":3131.0,"flare1z":48.19,"z":47.13,"dist":23.0,"flare2z":48.21},{"y":1891.39,"flare2y":1889.61,"flare2x":1767.32,"start":false,"flare1x":1734.54,"x":1750.54,"flare1y":1893.44,"flare1z":73.19,"z":72.13,"dist":16.5,"flare2z":73.18},{"y":599.72,"flare2y":577.04,"flare2x":1328.38,"start":false,"flare1x":1288.69,"x":1308.19,"flare1y":622.04,"flare1z":79.29,"z":78.24,"dist":30.0,"flare2z":79.32},{"y":-245.39,"flare2y":-252.95,"flare2x":614.11,"start":false,"flare1x":596.82,"x":604.96,"flare1y":-237.8,"flare1z":43.14,"z":42.39,"dist":11.5,"flare2z":43.79},{"y":-350.35,"flare2y":-339.4,"flare2x":563.51,"start":false,"flare1x":554.34,"x":558.93,"flare1y":-360.5,"flare1z":42.85,"z":41.8,"dist":11.5,"flare2z":42.87},{"y":-1077.72,"flare2y":-1075.17,"flare2x":806.84,"start":false,"flare1x":770.11,"x":788.14,"flare1y":-1079.71,"flare1z":27.88,"z":26.84,"dist":18.5,"flare2z":27.96},{"y":-1492.81,"flare2y":-1479.35,"flare2x":837.67,"start":false,"flare1x":783.7,"x":810.44,"flare1y":-1505.57,"flare1z":27.76,"z":26.32,"dist":30.0,"flare2z":27.04},{"y":-2620.2,"flare2y":-2620.41,"flare2x":752.48,"start":false,"flare1x":708.48,"x":730.11,"flare1y":-2619.67,"flare1z":16.89,"z":15.77,"dist":22.0,"flare2z":16.84},{"y":-3201.07,"flare2y":-3200.86,"flare2x":735.24,"start":false,"flare1x":691.24,"x":712.87,"flare1y":-3200.94,"flare1z":18.81,"z":17.73,"dist":22.0,"flare2z":18.81},{"y":-3317.16,"flare2y":-3300.78,"flare2x":1141.38,"start":false,"flare1x":1171.0,"x":1156.62,"flare1y":-3333.32,"flare1z":5.2,"z":4.15,"dist":22.0,"flare2z":5.27},{"y":-3216.46,"flare2y":-3186.13,"flare2x":1259.39,"start":false,"flare1x":1262.1,"x":1260.9,"flare1y":-3246.07,"flare1z":5.12,"z":4.02,"dist":30.0,"flare2z":5.09}]'),
	(21, 'Goled Special', 'For Ogled :)', '5047', '[{"flare1y":-670.96,"z":27.58,"dist":15.0,"start":true,"flare2z":28.42,"flare1z":28.46,"flare2x":360.59,"y":-676.46,"flare2y":-682.06,"x":347.06,"flare1x":332.71},{"flare1y":-826.84,"z":27.55,"dist":15.0,"start":false,"flare2z":28.4,"flare1z":28.41,"flare2x":308.66,"y":-831.4,"flare2y":-836.12,"x":294.8,"flare1x":280.13},{"flare1y":-872.94,"z":27.57,"dist":15.0,"start":false,"flare2z":28.44,"flare1z":28.43,"flare2x":370.16,"y":-857.58,"flare2y":-842.94,"x":369.89,"flare1x":370.03},{"flare1y":-836.75,"z":23.96,"dist":15.0,"start":false,"flare2z":24.05,"flare1z":25.6,"flare2x":478.9,"y":-821.4,"flare2y":-806.8,"x":479.11,"flare1x":479.57},{"flare1y":-1052.63,"z":26.78,"dist":15.0,"start":false,"flare2z":27.99,"flare1z":27.26,"flare2x":503.96,"y":-1064.34,"flare2y":-1075.71,"x":494.72,"flare1x":484.8},{"flare1y":-1052.1,"z":27.45,"dist":15.0,"start":false,"flare2z":28.3,"flare1z":28.3,"flare2x":449.8,"y":-1067.46,"flare2y":-1082.1,"x":450.12,"flare1x":450.1},{"flare1y":-1053.67,"z":27.54,"dist":15.0,"start":false,"flare2z":28.47,"flare1z":28.31,"flare2x":407.39,"y":-1068.82,"flare2y":-1083.31,"x":405.33,"flare1x":402.76},{"flare1y":-1115.21,"z":27.69,"dist":15.0,"start":false,"flare2z":28.76,"flare1z":28.33,"flare2x":412.24,"y":-1117.57,"flare2y":-1120.22,"x":397.83,"flare1x":382.66},{"flare1y":-1114.11,"z":27.62,"dist":15.0,"start":false,"flare2z":28.74,"flare1z":28.2,"flare2x":331.94,"y":-1129.45,"flare2y":-1144.02,"x":330.47,"flare1x":329.73},{"flare1y":-1253.32,"z":27.53,"dist":15.0,"start":false,"flare2z":28.94,"flare1z":27.82,"flare2x":227.48,"y":-1256.16,"flare2y":-1257.82,"x":212.91,"flare1x":197.84},{"flare1y":-1327.72,"z":27.73,"dist":15.0,"start":false,"flare2z":28.24,"flare1z":28.93,"flare2x":264.12,"y":-1312.32,"flare2y":-1297.77,"x":265.52,"flare1x":265.77},{"flare1y":-1374.51,"z":29.35,"dist":15.0,"start":false,"flare2z":29.99,"flare1z":30.47,"flare2x":298.0,"y":-1385.73,"flare2y":-1395.85,"x":287.43,"flare1x":276.92},{"flare1y":-1503.63,"z":27.52,"dist":15.0,"start":false,"flare2z":28.61,"flare1z":28.13,"flare2x":296.65,"y":-1492.37,"flare2y":-1480.98,"x":287.42,"flare1x":276.98},{"flare1y":-1666.72,"z":27.5,"dist":15.0,"start":false,"flare2z":28.79,"flare1z":27.91,"flare2x":423.52,"y":-1677.45,"flare2y":-1686.63,"x":412.09,"flare1x":401.1},{"flare1y":-1683.29,"z":27.52,"dist":15.0,"start":false,"flare2z":29.2,"flare1z":27.52,"flare2x":305.13,"y":-1695.39,"flare2y":-1707.31,"x":313.61,"flare1x":323.03},{"flare1y":-1726.55,"z":27.16,"dist":15.0,"start":false,"flare2z":28.3,"flare1z":27.73,"flare2x":211.44,"y":-1740.53,"flare2y":-1753.61,"x":204.84,"flare1x":198.5},{"flare1y":-1875.95,"z":20.62,"dist":15.0,"start":false,"flare2z":20.48,"flare1z":22.54,"flare2x":86.61,"y":-1888.39,"flare2y":-1900.06,"x":77.81,"flare1x":68.87},{"flare1y":-1740.32,"z":27.55,"dist":15.0,"start":false,"flare2z":28.42,"flare1z":28.4,"flare2x":-69.27,"y":-1725.86,"flare2y":-1712.45,"x":-63.38,"flare1x":-58.18},{"flare1y":-1606.48,"z":27.5,"dist":15.0,"start":false,"flare2z":28.88,"flare1z":27.82,"flare2x":-2.48,"y":-1618.25,"flare2y":-1630.23,"x":5.94,"flare1x":15.82},{"flare1y":-1438.44,"z":30.05,"dist":15.0,"start":false,"flare2z":30.9,"flare1z":30.95,"flare2x":-96.48,"y":-1445.16,"flare2y":-1451.81,"x":-83.44,"flare1x":-69.62},{"flare1y":-1378.02,"z":28.61,"dist":15.0,"start":false,"flare2z":29.98,"flare1z":28.91,"flare2x":-158.66,"y":-1392.08,"flare2y":-1405.22,"x":-165.14,"flare1x":-171.28},{"flare1y":-1407.27,"z":28.68,"dist":15.0,"start":false,"flare2z":29.79,"flare1z":29.36,"flare2x":-329.95,"y":-1422.65,"flare2y":-1437.26,"x":-330.97,"flare1x":-330.66},{"flare1y":-1299.43,"z":25.36,"dist":15.0,"start":false,"flare2z":26.53,"flare1z":25.95,"flare2x":-511.91,"y":-1292.67,"flare2y":-1287.21,"x":-498.32,"flare1x":-484.52},{"flare1y":-1019.56,"z":21.18,"dist":15.0,"start":false,"flare2z":22.1,"flare1z":21.98,"flare2x":-548.31,"y":-1019.22,"flare2y":-1019.3,"x":-533.68,"flare1x":-518.31},{"flare1y":-942.69,"z":20.92,"dist":15.0,"start":false,"flare2z":21.53,"flare1z":22.08,"flare2x":-586.82,"y":-958.05,"flare2y":-972.68,"x":-587.51,"flare1x":-587.41},{"flare1y":-875.69,"z":20.09,"dist":15.0,"start":false,"flare2z":21.06,"flare1z":20.8,"flare2x":-758.94,"y":-873.49,"flare2y":-871.89,"x":-744.39,"flare1x":-729.18},{"flare1y":-820.84,"z":18.51,"dist":15.0,"start":false,"flare2z":19.43,"flare1z":19.32,"flare2x":-810.98,"y":-836.12,"flare2y":-850.63,"x":-813.0,"flare1x":-814.51},{"flare1y":-728.68,"z":23.63,"dist":15.0,"start":false,"flare2z":24.54,"flare1z":24.37,"flare2x":-873.08,"y":-728.26,"flare2y":-728.7,"x":-858.44,"flare1x":-843.08},{"flare1y":-679.81,"z":27.07,"dist":15.0,"start":false,"flare2z":28.27,"flare1z":27.55,"flare2x":-793.3,"y":-664.47,"flare2y":-649.83,"x":-793.47,"flare1x":-794.15},{"flare1y":-616.97,"z":28.48,"dist":15.0,"start":false,"flare2z":29.77,"flare1z":28.92,"flare2x":-758.21,"y":-618.91,"flare2y":-621.47,"x":-743.81,"flare1x":-728.56},{"flare1y":-595.62,"z":23.69,"dist":15.0,"start":false,"flare2z":24.59,"flare1z":24.49,"flare2x":-472.64,"y":-581.15,"flare2y":-567.03,"x":-476.7,"flare1x":-481.74},{"flare1y":-679.45,"z":30.61,"dist":15.0,"start":false,"flare2z":31.6,"flare1z":31.31,"flare2x":-333.31,"y":-664.09,"flare2y":-649.45,"x":-332.88,"flare1x":-333.48},{"flare1y":-737.34,"z":33.01,"dist":15.0,"start":false,"flare2z":33.79,"flare1z":33.94,"flare2x":-118.63,"y":-723.01,"flare2y":-708.8,"x":-122.25,"flare1x":-127.86},{"flare1y":-846.85,"z":29.41,"dist":15.0,"start":false,"flare2z":30.22,"flare1z":30.28,"flare2x":201.5,"y":-833.23,"flare2y":-819.24,"x":197.01,"flare1x":189.76},{"flare1y":-810.98,"z":27.52,"dist":15.0,"start":false,"flare2z":28.55,"flare1z":28.21,"flare2x":300.28,"y":-806.22,"flare2y":-803.33,"x":314.64,"flare1x":329.28},{"flare1y":-683.06,"z":27.5,"dist":15.0,"start":false,"flare2z":28.62,"flare1z":28.1,"flare2x":345.69,"y":-676.53,"flare2y":-672.98,"x":359.96,"flare1x":373.94}]'),
	(22, 'Vinewood Track', 'Scenic view of vinewood', '8626', '[{"flare1x":329.89,"flare2x":322.97,"flare1z":105.29,"z":103.91,"flare2y":308.43,"flare1y":337.62,"y":322.44,"x":326.87,"start":true,"flare2z":105.04,"dist":15.0},{"flare1x":281.79,"flare2x":252.25,"flare1z":105.52,"z":104.3,"flare2y":361.37,"flare1y":356.09,"y":358.26,"x":266.46,"start":false,"flare2z":105.61,"dist":15.0},{"flare1x":200.28,"flare2x":208.44,"flare1z":118.76,"z":117.62,"flare2y":416.06,"flare1y":444.93,"y":430.17,"x":204.9,"start":false,"flare2z":118.9,"dist":15.0},{"flare1x":43.06,"flare2x":29.49,"flare1z":112.64,"z":111.08,"flare2y":341.43,"flare1y":368.17,"y":354.2,"x":36.43,"start":false,"flare2z":112.01,"dist":15.0},{"flare1x":-133.86,"flare2x":-109.48,"flare1z":112.81,"z":111.71,"flare2y":398.86,"flare1y":416.35,"y":407.64,"x":-121.05,"start":false,"flare2z":113.07,"dist":15.0},{"flare1x":-86.54,"flare2x":-75.85,"flare1z":105.87,"z":105.03,"flare2y":308.97,"flare1y":280.95,"y":295.57,"x":-81.47,"start":false,"flare2z":106.6,"dist":15.0},{"flare1x":8.46,"flare2x":13.25,"flare1z":109.41,"z":108.09,"flare2y":275.29,"flare1y":245.68,"y":261.03,"x":10.43,"start":false,"flare2z":109.26,"dist":15.0},{"flare1x":-4.61,"flare2x":23.69,"flare1z":103.29,"z":102.1,"flare2y":187.79,"flare1y":197.77,"y":193.04,"x":10.13,"start":false,"flare2z":103.22,"dist":15.0},{"flare1x":-53.53,"flare2x":-25.37,"flare1z":72.2,"z":70.99,"flare2y":52.19,"flare1y":62.55,"y":57.61,"x":-38.86,"start":false,"flare2z":72.24,"dist":15.0},{"flare1x":-97.58,"flare2x":-111.72,"flare1z":71.46,"z":70.05,"flare2y":52.88,"flare1y":79.33,"y":65.47,"x":-104.47,"start":false,"flare2z":71.14,"dist":15.0},{"flare1x":-99.02,"flare2x":-128.52,"flare1z":79.44,"z":77.92,"flare2y":143.37,"flare1y":137.93,"y":140.32,"x":-114.31,"start":false,"flare2z":79.05,"dist":15.0},{"flare1x":-147.8,"flare2x":-147.94,"flare1z":94.4,"z":93.48,"flare2y":239.78,"flare1y":269.77,"y":254.3,"x":-147.5,"start":false,"flare2z":94.95,"dist":15.0},{"flare1x":-487.2,"flare2x":-490.12,"flare1z":83.13,"z":81.89,"flare2y":236.0,"flare1y":265.85,"y":250.43,"x":-488.41,"start":false,"flare2z":83.1,"dist":15.0},{"flare1x":-692.86,"flare2x":-696.09,"flare1z":82.82,"z":81.56,"flare2y":273.88,"flare1y":303.7,"y":288.29,"x":-694.14,"start":false,"flare2z":82.81,"dist":15.0},{"flare1x":-841.05,"flare2x":-871.05,"flare1z":87.41,"z":86.02,"flare2y":378.11,"flare1y":378.59,"y":377.88,"x":-856.51,"start":false,"flare2z":87.12,"dist":15.0},{"flare1x":-902.5,"flare2x":-887.9,"flare1z":84.56,"z":83.72,"flare2y":385.2,"flare1y":411.4,"y":398.07,"x":-894.61,"start":false,"flare2z":85.26,"dist":15.0},{"flare1x":-924.7,"flare2x":-896.14,"flare1z":71.62,"z":70.74,"flare2y":302.69,"flare1y":311.85,"y":307.54,"x":-909.84,"start":false,"flare2z":72.19,"dist":15.0},{"flare1x":-916.41,"flare2x":-945.4,"flare1z":71.09,"z":70.18,"flare2y":335.36,"flare1y":343.05,"y":338.68,"x":-931.26,"start":false,"flare2z":71.74,"dist":15.0},{"flare1x":-1000.37,"flare2x":-1016.73,"flare1z":71.82,"z":70.56,"flare2y":366.12,"flare1y":391.27,"y":378.07,"x":-1008.44,"start":false,"flare2z":71.75,"dist":15.0},{"flare1x":-988.47,"flare2x":-994.59,"flare1z":73.6,"z":72.29,"flare2y":418.83,"flare1y":389.46,"y":404.52,"x":-992.03,"start":false,"flare2z":73.53,"dist":15.0},{"flare1x":-942.88,"flare2x":-971.45,"flare1z":79.58,"z":78.37,"flare2y":446.25,"flare1y":455.38,"y":450.3,"x":-957.49,"start":false,"flare2z":79.62,"dist":15.0},{"flare1x":-1058.74,"flare2x":-1039.63,"flare1z":76.29,"z":74.56,"flare2y":446.96,"flare1y":470.06,"y":458.37,"x":-1048.64,"start":false,"flare2z":75.25,"dist":15.0},{"flare1x":-1153.41,"flare2x":-1153.82,"flare1z":84.34,"z":83.03,"flare2y":453.39,"flare1y":483.39,"y":467.91,"x":-1153.28,"start":false,"flare2z":84.27,"dist":15.0},{"flare1x":-1372.1,"flare2x":-1377.47,"flare1z":104.81,"z":103.06,"flare2y":448.26,"flare1y":477.76,"y":462.51,"x":-1374.6,"start":false,"flare2z":103.85,"dist":15.0},{"flare1x":-1403.03,"flare2x":-1409.64,"flare1z":123.47,"z":122.74,"flare2y":569.71,"flare1y":540.46,"y":555.46,"x":-1406.8,"start":false,"flare2z":124.5,"dist":15.0},{"flare1x":-1338.51,"flare2x":-1366.78,"flare1z":132.83,"z":131.83,"flare2y":589.79,"flare1y":599.83,"y":594.29,"x":-1352.96,"start":false,"flare2z":133.35,"dist":15.0},{"flare1x":-1325.89,"flare2x":-1325.58,"flare1z":135.99,"z":134.66,"flare2y":642.22,"flare1y":612.23,"y":627.7,"x":-1326.12,"start":false,"flare2z":135.84,"dist":15.0},{"flare1x":-1190.73,"flare2x":-1215.39,"flare1z":146.73,"z":145.81,"flare2y":703.12,"flare1y":686.06,"y":694.62,"x":-1203.62,"start":false,"flare2z":147.4,"dist":15.0},{"flare1x":-1062.83,"flare2x":-1066.33,"flare1z":166.82,"z":164.8,"flare2y":803.37,"flare1y":773.61,"y":788.9,"x":-1065.05,"start":false,"flare2z":165.33,"dist":15.0},{"flare1x":-1051.24,"flare2x":-1023.5,"flare1z":165.69,"z":164.79,"flare2y":734.29,"flare1y":722.87,"y":729.1,"x":-1037.06,"start":false,"flare2z":166.32,"dist":15.0},{"flare1x":-663.04,"flare2x":-692.96,"flare1z":150.1,"z":149.34,"flare2y":663.2,"flare1y":665.25,"y":663.8,"x":-678.46,"start":false,"flare2z":151.11,"dist":15.0},{"flare1x":-689.81,"flare2x":-716.93,"flare1z":160.76,"z":159.11,"flare2y":719.9,"flare1y":732.71,"y":725.8,"x":-703.63,"start":false,"flare2z":160.09,"dist":15.0},{"flare1x":-727.31,"flare2x":-748.03,"flare1z":214.03,"z":212.3,"flare2y":804.46,"flare1y":826.14,"y":814.68,"x":-737.69,"start":false,"flare2z":213.14,"dist":15.0},{"flare1x":-713.93,"flare2x":-729.26,"flare1z":218.83,"z":217.82,"flare2y":857.99,"flare1y":832.21,"y":845.33,"x":-722.17,"start":false,"flare2z":219.43,"dist":15.0},{"flare1x":-697.17,"flare2x":-726.65,"flare1z":237.02,"z":236.49,"flare2y":967.81,"flare1y":973.18,"y":969.97,"x":-712.3,"start":false,"flare2z":238.43,"dist":15.0},{"flare1x":-701.29,"flare2x":-730.12,"flare1z":246.27,"z":244.92,"flare2y":1056.35,"flare1y":1048.04,"y":1052.0,"x":-716.25,"start":false,"flare2z":246.17,"dist":15.0},{"flare1x":-697.13,"flare2x":-719.22,"flare1z":264.64,"z":263.28,"flare2y":1188.55,"flare1y":1168.26,"y":1178.44,"x":-708.78,"start":false,"flare2z":264.45,"dist":15.0},{"flare1x":-475.67,"flare2x":-490.14,"flare1z":304.03,"z":302.9,"flare2y":1357.98,"flare1y":1331.71,"y":1345.04,"x":-483.57,"start":false,"flare2z":304.24,"dist":15.0},{"flare1x":-475.52,"flare2x":-445.66,"flare1z":306.63,"z":305.48,"flare2y":1331.68,"flare1y":1328.82,"y":1330.75,"x":-460.17,"start":false,"flare2z":306.93,"dist":15.0},{"flare1x":-375.09,"flare2x":-366.12,"flare1z":325.26,"z":324.32,"flare2y":1186.45,"flare1y":1157.82,"y":1172.7,"x":-370.81,"start":false,"flare2z":325.83,"dist":15.0},{"flare1x":-121.99,"flare2x":-125.04,"flare1z":287.42,"z":285.68,"flare2y":1527.31,"flare1y":1497.48,"y":1512.81,"x":-123.94,"start":false,"flare2z":286.36,"dist":15.0},{"flare1x":202.46,"flare2x":212.56,"flare1z":240.63,"z":239.25,"flare2y":1362.78,"flare1y":1334.54,"y":1349.22,"x":207.36,"start":false,"flare2z":240.23,"dist":15.0},{"flare1x":233.2,"flare2x":262.88,"flare1z":234.45,"z":233.19,"flare2y":1284.73,"flare1y":1280.38,"y":1282.9,"x":248.46,"start":false,"flare2z":234.36,"dist":15.0},{"flare1x":294.46,"flare2x":324.41,"flare1z":209.91,"z":209.06,"flare2y":1019.47,"flare1y":1020.93,"y":1020.68,"x":309.93,"start":false,"flare2z":210.65,"dist":15.0},{"flare1x":263.74,"flare2x":279.76,"flare1z":209.98,"z":208.99,"flare2y":981.91,"flare1y":1007.27,"y":994.4,"x":272.36,"start":false,"flare2z":210.45,"dist":15.0},{"flare1x":-45.62,"flare2x":-46.03,"flare1z":220.57,"z":219.43,"flare2y":1038.7,"flare1y":1068.7,"y":1053.22,"x":-45.51,"start":false,"flare2z":220.79,"dist":15.0},{"flare1x":-201.61,"flare2x":-208.42,"flare1z":234.12,"z":232.56,"flare2y":1033.38,"flare1y":1062.59,"y":1047.46,"x":-204.77,"start":false,"flare2z":233.54,"dist":15.0},{"flare1x":-333.19,"flare2x":-304.71,"flare1z":233.35,"z":231.92,"flare2y":978.47,"flare1y":987.9,"y":983.48,"x":-318.36,"start":false,"flare2z":232.93,"dist":15.0},{"flare1x":-371.6,"flare2x":-344.14,"flare1z":229.46,"z":228.13,"flare2y":911.44,"flare1y":923.5,"y":917.6,"x":-357.3,"start":false,"flare2z":229.19,"dist":15.0},{"flare1x":-277.96,"flare2x":-253.52,"flare1z":207.61,"z":206.42,"flare2y":747.01,"flare1y":729.61,"y":738.85,"x":-265.57,"start":false,"flare2z":207.68,"dist":15.0},{"flare1x":-131.06,"flare2x":-131.8,"flare1z":205.63,"z":204.31,"flare2y":589.6,"flare1y":619.59,"y":604.11,"x":-131.04,"start":false,"flare2z":205.4,"dist":15.0},{"flare1x":-486.63,"flare2x":-484.04,"flare1z":143.69,"z":142.02,"flare2y":648.7,"flare1y":678.58,"y":663.22,"x":-484.92,"start":false,"flare2z":142.68,"dist":15.0},{"flare1x":-521.56,"flare2x":-496.71,"flare1z":133.58,"z":132.53,"flare2y":641.37,"flare1y":624.57,"y":633.57,"x":-509.0,"start":false,"flare2z":133.74,"dist":15.0},{"flare1x":-476.43,"flare2x":-465.69,"flare1z":119.35,"z":118.61,"flare2y":564.61,"flare1y":536.61,"y":551.17,"x":-471.13,"start":false,"flare2z":120.31,"dist":15.0},{"flare1x":-138.94,"flare2x":-131.94,"flare1z":113.12,"z":111.85,"flare2y":453.61,"flare1y":424.44,"y":439.55,"x":-135.66,"start":false,"flare2z":113.09,"dist":15.0},{"flare1x":-52.06,"flare2x":-39.19,"flare1z":113.27,"z":111.76,"flare2y":408.64,"flare1y":381.54,"y":395.6,"x":-45.59,"start":false,"flare2z":112.73,"dist":15.0},{"flare1x":34.57,"flare2x":61.61,"flare1z":110.34,"z":109.24,"flare2y":292.63,"flare1y":305.64,"y":299.16,"x":48.63,"start":false,"flare2z":110.58,"dist":15.0},{"flare1x":98.15,"flare2x":107.32,"flare1z":107.9,"z":106.78,"flare2y":243.72,"flare1y":215.16,"y":229.96,"x":102.63,"start":false,"flare2z":108.11,"dist":15.0},{"flare1x":393.25,"flare2x":365.23,"flare1z":102.96,"z":101.69,"flare2y":187.33,"flare1y":176.62,"y":181.79,"x":378.67,"start":false,"flare2z":102.89,"dist":15.0},{"flare1x":397.18,"flare2x":389.9,"flare1z":102.68,"z":101.65,"flare2y":292.63,"flare1y":321.74,"y":306.62,"x":393.84,"start":false,"flare2z":103.06,"dist":15.0}]'),
	(23, 'Backstreet Boys', '', '12308', '[{"flare1x":319.02,"flare2x":290.45,"flare1z":201.62,"z":200.92,"flare2y":906.54,"flare1y":897.39,"y":902.81,"x":304.56,"start":true,"flare2z":201.33,"dist":15.0},{"flare1x":321.72,"flare2x":292.24,"flare1z":214.25,"z":212.96,"flare2y":1072.14,"flare1y":1077.57,"y":1075.71,"x":306.37,"start":false,"flare2z":212.83,"dist":15.0},{"flare1x":238.96,"flare2x":212.07,"flare1z":238.77,"z":238.38,"flare2y":1388.89,"flare1y":1402.17,"y":1396.31,"x":224.67,"start":false,"flare2z":239.29,"dist":15.0},{"flare1x":106.89,"flare2x":93.39,"flare1z":226.6,"z":226.07,"flare2y":1673.06,"flare1y":1699.85,"y":1686.54,"x":99.03,"start":false,"flare2z":226.94,"dist":15.0},{"flare1x":-59.28,"flare2x":-64.85,"flare1z":199.84,"z":199.17,"flare2y":1836.24,"flare1y":1865.72,"y":1850.77,"x":-63.2,"start":false,"flare2z":199.97,"dist":15.0},{"flare1x":-149.51,"flare2x":-177.75,"flare1z":195.62,"z":194.52,"flare2y":1942.72,"flare1y":1932.61,"y":1938.77,"x":-163.67,"start":false,"flare2z":194.98,"dist":15.0},{"flare1x":-4.34,"flare2x":-21.04,"flare1z":169.09,"z":168.62,"flare2y":2039.25,"flare1y":2014.34,"y":2027.8,"x":-11.94,"start":false,"flare2z":169.85,"dist":15.0},{"flare1x":160.79,"flare2x":160.69,"flare1z":127.4,"z":126.49,"flare2y":2119.9,"flare1y":2089.9,"y":2105.32,"x":161.95,"start":false,"flare2z":127.39,"dist":15.0},{"flare1x":318.69,"flare2x":319.96,"flare1z":102.37,"z":101.9,"flare2y":2100.73,"flare1y":2070.76,"y":2086.11,"x":320.57,"start":false,"flare2z":103.0,"dist":15.0},{"flare1x":780.97,"flare2x":772.02,"flare1z":52.15,"z":51.3,"flare2y":2227.06,"flare1y":2198.43,"y":2213.46,"x":777.38,"start":false,"flare2z":51.97,"dist":15.0},{"flare1x":923.19,"flare2x":940.26,"flare1z":47.75,"z":47.1,"flare2y":2210.38,"flare1y":2185.71,"y":2197.77,"x":932.84,"start":false,"flare2z":47.78,"dist":15.0},{"flare1x":1009.54,"flare2x":1033.24,"flare1z":48.64,"z":48.26,"flare2y":2111.36,"flare1y":2092.97,"y":2101.53,"x":1022.4,"start":false,"flare2z":49.13,"dist":15.0},{"flare1x":1085.25,"flare2x":1112.22,"flare1z":57.16,"z":56.51,"flare2y":1971.52,"flare1y":1958.39,"y":1963.97,"x":1099.68,"start":false,"flare2z":56.99,"dist":15.0},{"flare1x":1222.14,"flare2x":1247.37,"flare1z":80.06,"z":79.33,"flare2y":1735.84,"flare1y":1719.61,"y":1726.97,"x":1235.73,"start":false,"flare2z":79.78,"dist":15.0},{"flare1x":1291.07,"flare2x":1320.93,"flare1z":105.01,"z":104.3,"flare2y":1040.63,"flare1y":1037.71,"y":1037.99,"x":1306.54,"start":false,"flare2z":104.91,"dist":15.0},{"flare1x":1147.55,"flare2x":1172.13,"flare1z":97.85,"z":97.02,"flare2y":583.0,"flare1y":600.19,"y":590.79,"x":1159.79,"start":false,"flare2z":97.55,"dist":15.0},{"flare1x":1125.61,"flare2x":1099.63,"flare1z":108.34,"z":107.9,"flare2y":622.64,"flare1y":607.64,"y":616.12,"x":1112.7,"start":false,"flare2z":108.33,"dist":15.0},{"flare1x":1129.99,"flare2x":1120.03,"flare1z":147.61,"z":147.08,"flare2y":740.51,"flare1y":768.8,"y":754.48,"x":1124.27,"start":false,"flare2z":147.66,"dist":15.0},{"flare1x":1112.66,"flare2x":1086.13,"flare1z":152.19,"z":151.37,"flare2y":819.84,"flare1y":805.83,"y":813.97,"x":1099.52,"start":false,"flare2z":151.93,"dist":15.0},{"flare1x":1167.61,"flare2x":1138.66,"flare1z":170.3,"z":169.68,"flare2y":1097.41,"flare1y":1105.28,"y":1102.17,"x":1152.48,"start":false,"flare2z":170.2,"dist":15.0},{"flare1x":1137.68,"flare2x":1117.01,"flare1z":163.1,"z":162.85,"flare2y":1417.57,"flare1y":1439.31,"y":1428.84,"x":1126.32,"start":false,"flare2z":163.62,"dist":15.0},{"flare1x":1054.52,"flare2x":1030.18,"flare1z":161.58,"z":161.24,"flare2y":1697.02,"flare1y":1714.54,"y":1706.39,"x":1041.4,"start":false,"flare2z":162.2,"dist":15.0},{"flare1x":835.89,"flare2x":840.6,"flare1z":170.96,"z":170.39,"flare2y":1694.71,"flare1y":1724.34,"y":1708.96,"x":837.34,"start":false,"flare2z":171.0,"dist":15.0},{"flare1x":410.88,"flare2x":429.25,"flare1z":234.13,"z":233.81,"flare2y":1755.37,"flare1y":1779.08,"y":1766.19,"x":419.4,"start":false,"flare2z":234.54,"dist":15.0},{"flare1x":181.38,"flare2x":190.67,"flare1z":229.37,"z":228.74,"flare2y":1654.54,"flare1y":1683.07,"y":1668.12,"x":185.27,"start":false,"flare2z":229.58,"dist":15.0},{"flare1x":129.96,"flare2x":159.96,"flare1z":229.18,"z":228.62,"flare2y":1576.15,"flare1y":1576.21,"y":1575.15,"x":145.37,"start":false,"flare2z":229.28,"dist":15.0},{"flare1x":208.61,"flare2x":235.25,"flare1z":239.26,"z":238.38,"flare2y":1405.28,"flare1y":1391.49,"y":1397.57,"x":222.81,"start":false,"flare2z":238.86,"dist":15.0},{"flare1x":277.47,"flare2x":305.64,"flare1z":195.7,"z":195.42,"flare2y":867.24,"flare1y":877.5,"y":871.23,"x":291.57,"start":false,"flare2z":196.78,"dist":15.0},{"flare1x":332.25,"flare2x":315.53,"flare1z":192.52,"z":192.69,"flare2y":870.57,"flare1y":845.71,"y":858.97,"x":324.43,"start":false,"flare2z":194.05,"dist":15.0},{"flare1x":500.84,"flare2x":515.99,"flare1z":197.07,"z":196.39,"flare2y":871.54,"flare1y":845.65,"y":858.38,"x":509.58,"start":false,"flare2z":197.01,"dist":15.0},{"flare1x":856.76,"flare2x":846.69,"flare1z":240.99,"z":239.82,"flare2y":995.54,"flare1y":967.3,"y":982.19,"x":852.61,"start":false,"flare2z":240.01,"dist":15.0},{"flare1x":918.93,"flare2x":946.0,"flare1z":174.63,"z":174.68,"flare2y":682.41,"flare1y":669.61,"y":675.11,"x":933.37,"start":false,"flare2z":176.43,"dist":15.0},{"flare1x":1130.58,"flare2x":1148.72,"flare1z":145.39,"z":143.96,"flare2y":757.13,"flare1y":733.27,"y":744.84,"x":1140.79,"start":false,"flare2z":144.26,"dist":15.0},{"flare1x":1093.65,"flare2x":1120.83,"flare1z":105.65,"z":104.77,"flare2y":599.68,"flare1y":612.36,"y":604.73,"x":1107.11,"start":false,"flare2z":105.8,"dist":15.0},{"flare1x":1176.07,"flare2x":1152.02,"flare1z":97.63,"z":97.1,"flare2y":603.8,"flare1y":585.87,"y":595.94,"x":1164.36,"start":false,"flare2z":97.86,"dist":15.0},{"flare1x":1308.62,"flare2x":1278.63,"flare1z":107.72,"z":107.1,"flare2y":1268.18,"flare1y":1268.93,"y":1269.81,"x":1293.18,"start":false,"flare2z":107.81,"dist":15.0},{"flare1x":1132.82,"flare2x":1104.67,"flare1z":63.17,"z":62.17,"flare2y":1900.51,"flare1y":1910.89,"y":1906.87,"x":1117.87,"start":false,"flare2z":62.82,"dist":15.0},{"flare1x":888.54,"flare2x":879.94,"flare1z":47.03,"z":47.03,"flare2y":2214.19,"flare1y":2242.91,"y":2228.48,"x":883.03,"start":false,"flare2z":48.34,"dist":15.0},{"flare1x":742.55,"flare2x":752.07,"flare1z":54.55,"z":54.15,"flare2y":2189.6,"flare1y":2218.05,"y":2203.08,"x":746.38,"start":false,"flare2z":54.87,"dist":15.0},{"flare1x":444.37,"flare2x":463.9,"flare1z":85.9,"z":85.77,"flare2y":2135.52,"flare1y":2158.28,"y":2145.88,"x":453.57,"start":false,"flare2z":86.72,"dist":15.0},{"flare1x":76.04,"flare2x":89.37,"flare1z":145.0,"z":144.86,"flare2y":2077.09,"flare1y":2103.95,"y":2089.69,"x":81.96,"start":false,"flare2z":145.54,"dist":15.0},{"flare1x":-144.68,"flare2x":-128.34,"flare1z":189.07,"z":188.93,"flare2y":1958.63,"flare1y":1983.78,"y":1970.25,"x":-137.22,"start":false,"flare2z":189.76,"dist":15.0},{"flare1x":-15.08,"flare2x":14.68,"flare1z":217.1,"z":216.89,"flare2y":1760.29,"flare1y":1756.57,"y":1757.46,"x":0.34,"start":false,"flare2z":217.68,"dist":15.0},{"flare1x":133.54,"flare2x":162.77,"flare1z":237.69,"z":236.77,"flare2y":1513.5,"flare1y":1506.8,"y":1509.28,"x":148.81,"start":false,"flare2z":236.97,"dist":15.0},{"flare1x":251.16,"flare2x":279.74,"flare1z":222.53,"z":222.05,"flare2y":1164.34,"flare1y":1155.23,"y":1158.68,"x":266.24,"start":false,"flare2z":223.14,"dist":15.0},{"flare1x":296.22,"flare2x":325.73,"flare1z":205.19,"z":204.86,"flare2y":931.54,"flare1y":936.86,"y":933.37,"x":311.24,"start":false,"flare2z":205.99,"dist":15.0}]'),
	(24, 'Nascar', 'For the Nascar Event', '496', '[{"flare2x":2727.58,"flare1x":2730.24,"flare2z":124.67,"y":-3724.86,"z":134.68,"start":true,"x":2728.6,"flare1y":-3697.1,"dist":30.0,"flare1z":146.08,"flare2y":-3753.09},{"flare2x":2722.52,"flare1x":2720.59,"flare2z":124.74,"y":-3874.97,"z":134.6,"start":false,"x":2722.4,"flare1y":-3902.79,"dist":30.0,"flare1z":145.84,"flare2y":-3846.65},{"flare2x":2863.98,"flare1x":2865.6,"flare2z":126.21,"y":-3720.69,"z":136.23,"start":false,"x":2864.01,"flare1y":-3692.92,"dist":30.0,"flare1z":147.62,"flare2y":-3748.95}]'),
	(25, 'Nascar Event', 'Nascar Event', '695', '[{"dist":30.0,"flare2y":-3755.76,"start":true,"flare1z":145.17,"z":133.69,"flare2x":2749.24,"x":2749.7,"y":-3727.55,"flare1y":-3699.8,"flare2z":123.59,"flare1x":2750.79},{"dist":30.0,"flare2y":-3827.54,"start":false,"flare1z":145.04,"z":133.79,"flare2x":2673.07,"x":2661.43,"y":-3853.37,"flare1y":-3878.47,"flare2z":124.0,"flare1x":2649.34},{"dist":30.0,"flare2y":-3796.49,"start":false,"flare1z":147.86,"z":135.87,"flare2x":2939.9,"x":2967.9,"y":-3795.81,"flare1y":-3795.77,"flare2z":125.25,"flare1x":2995.47}]'),
	(26, 'Flash\'s Special', 'Event', '16613', '[{"flare1y":-2800.2,"dist":15.0,"flare2x":-408.01,"flare2y":-2797.87,"flare1x":-378.1,"flare2z":5.26,"flare1z":5.27,"z":4.18,"y":-2798.92,"x":-392.67,"start":true},{"flare1y":-2479.8,"dist":15.0,"flare2x":318.77,"flare2y":-2475.79,"flare1x":348.51,"flare2z":4.98,"flare1z":4.88,"z":3.86,"y":-2477.44,"x":334.06,"start":false},{"flare1y":-2068.23,"dist":15.0,"flare2x":589.81,"flare2y":-2038.45,"flare1x":586.15,"flare2z":28.6,"flare1z":28.65,"z":27.54,"y":-2053.76,"x":588.35,"start":false},{"flare1y":-2110.96,"dist":15.0,"flare2x":773.39,"flare2y":-2113.04,"flare1x":743.46,"flare2z":28.54,"flare1z":28.72,"z":27.55,"y":-2112.45,"x":758.02,"start":false},{"flare1y":-2465.79,"dist":15.0,"flare2x":797.67,"flare2y":-2435.84,"flare1x":796.24,"flare2z":21.48,"flare1z":20.64,"z":20.01,"y":-2451.21,"x":797.37,"start":false},{"flare1y":-2442.06,"dist":15.0,"flare2x":1016.89,"flare2y":-2440.39,"flare1x":1046.83,"flare2z":27.25,"flare1z":28.02,"z":26.56,"y":-2440.9,"x":1032.25,"start":false},{"flare1y":-2094.19,"dist":15.0,"flare2x":1119.52,"flare2y":-2064.19,"flare1x":1118.95,"flare2z":39.05,"flare1z":38.76,"z":37.87,"y":-2079.56,"x":1119.62,"start":false},{"flare1y":-1623.5,"dist":15.0,"flare2x":1315.89,"flare2y":-1647.89,"flare1x":1298.43,"flare2z":51.38,"flare1z":51.27,"z":50.22,"y":-1635.64,"x":1306.57,"start":false},{"flare1y":-1647.95,"dist":15.0,"flare2x":442.83,"flare2y":-1667.38,"flare1x":419.97,"flare2z":28.25,"flare1z":28.92,"z":27.51,"y":-1657.87,"x":430.75,"start":false},{"flare1y":-1811.44,"dist":15.0,"flare2x":241.19,"flare2y":-1835.98,"flare1x":258.42,"flare2z":26.53,"flare1z":25.71,"z":25.04,"y":-1823.14,"x":249.63,"start":false},{"flare1y":-1587.83,"dist":15.0,"flare2x":-1.3,"flare2y":-1567.71,"flare1x":20.95,"flare2z":28.9,"flare1z":28.38,"z":27.55,"y":-1577.66,"x":10.44,"start":false},{"flare1y":-1316.94,"dist":15.0,"flare2x":78.95,"flare2y":-1331.94,"flare1x":104.92,"flare2z":29.05,"flare1z":28.14,"z":27.5,"y":-1323.73,"x":91.96,"start":false},{"flare1y":-1120.63,"dist":15.0,"flare2x":11.16,"flare2y":-1150.53,"flare1x":8.85,"flare2z":28.33,"flare1z":27.67,"z":26.89,"y":-1135.23,"x":9.51,"start":false},{"flare1y":-1272.35,"dist":15.0,"flare2x":-94.15,"flare2y":-1271.86,"flare1x":-124.13,"flare2z":29.16,"flare1z":28.12,"z":27.54,"y":-1272.75,"x":-109.5,"start":false},{"flare1y":-1372.86,"dist":15.0,"flare2x":-146.38,"flare2y":-1398.75,"flare1x":-161.49,"flare2z":29.82,"flare1z":28.64,"z":28.16,"y":-1385.81,"x":-154.67,"start":false},{"flare1y":-1384.68,"dist":15.0,"flare2x":-286.14,"flare2y":-1384.68,"flare1x":-256.14,"flare2z":30.66,"flare1z":30.61,"z":29.55,"y":-1384.31,"x":-270.78,"start":false},{"flare1y":-1160.93,"dist":15.0,"flare2x":-224.78,"flare2y":-1130.94,"flare1x":-224.02,"flare2z":22.53,"flare1z":22.21,"z":21.28,"y":-1146.3,"x":-223.78,"start":false},{"flare1y":-1077.52,"dist":15.0,"flare2x":-85.48,"flare2y":-1067.58,"flare1x":-57.18,"flare2z":26.59,"flare1z":26.41,"z":25.44,"y":-1072.06,"x":-70.75,"start":false},{"flare1y":-985.29,"dist":15.0,"flare2x":31.76,"flare2y":-957.06,"flare1x":21.62,"flare2z":28.71,"flare1z":28.69,"z":27.62,"y":-971.69,"x":27.04,"start":false},{"flare1y":-995.28,"dist":15.0,"flare2x":227.36,"flare2y":-983.18,"flare1x":254.81,"flare2z":28.69,"flare1z":28.53,"z":27.52,"y":-988.8,"x":241.68,"start":false},{"flare1y":-822.29,"dist":15.0,"flare2x":233.57,"flare2y":-850.37,"flare1x":244.14,"flare2z":29.43,"flare1z":29.22,"z":28.25,"y":-835.79,"x":238.49,"start":false},{"flare1y":-602.43,"dist":15.0,"flare2x":-244.88,"flare2y":-592.65,"flare1x":-216.52,"flare2z":33.66,"flare1z":33.53,"z":32.52,"y":-597.3,"x":-230.22,"start":false},{"flare1y":-144.07,"dist":15.0,"flare2x":-26.09,"flare2y":-115.92,"flare1x":-36.47,"flare2z":56.51,"flare1z":56.35,"z":55.34,"y":-130.49,"x":-31.04,"start":false},{"flare1y":-216.41,"dist":15.0,"flare2x":369.56,"flare2y":-206.99,"flare1x":398.04,"flare2z":56.83,"flare1z":56.25,"z":55.53,"y":-211.22,"x":384.36,"start":false},{"flare1y":123.57,"dist":15.0,"flare2x":449.88,"flare2y":94.51,"flare1x":457.31,"flare2z":98.42,"flare1z":98.23,"z":97.28,"y":109.58,"x":453.0,"start":false},{"flare1y":278.81,"dist":15.0,"flare2x":-57.12,"flare2y":249.02,"flare1x":-60.67,"flare2z":103.3,"flare1z":102.75,"z":101.85,"y":264.2,"x":-59.62,"start":false},{"flare1y":202.77,"dist":15.0,"flare2x":-212.93,"flare2y":203.58,"flare1x":-242.88,"flare2z":83.56,"flare1z":81.97,"z":81.53,"y":202.63,"x":-228.26,"start":false},{"flare1y":-8.36,"dist":15.0,"flare2x":-317.2,"flare2y":-36.49,"flare1x":-306.8,"flare2z":47.52,"flare1z":47.91,"z":46.62,"y":-21.87,"x":-312.45,"start":false},{"flare1y":-435.17,"dist":15.0,"flare2x":-1352.69,"flare2y":-415.83,"flare1x":-1375.63,"flare2z":35.53,"flare1z":35.44,"z":34.37,"y":-426.2,"x":-1364.07,"start":false},{"flare1y":-775.25,"dist":15.0,"flare2x":-1108.6,"flare2y":-798.16,"flare1x":-1127.97,"flare2z":17.56,"flare1z":17.31,"z":16.32,"y":-786.71,"x":-1118.87,"start":false},{"flare1y":-990.55,"dist":15.0,"flare2x":-1259.68,"flare2y":-983.11,"flare1x":-1288.73,"flare2z":9.6,"flare1z":9.17,"z":8.28,"y":-987.53,"x":-1274.41,"start":false},{"flare1y":-1377.71,"dist":15.0,"flare2x":-1132.94,"flare2y":-1365.27,"flare1x":-1160.21,"flare2z":4.96,"flare1z":3.68,"z":3.22,"y":-1372.27,"x":-1146.63,"start":false},{"flare1y":-1688.29,"dist":15.0,"flare2x":-1064.76,"flare2y":-1709.42,"flare1x":-1086.03,"flare2z":4.34,"flare1z":3.31,"z":2.73,"y":-1698.73,"x":-1075.79,"start":false},{"flare1y":-1649.17,"dist":15.0,"flare2x":-1135.8,"flare2y":-1665.94,"flare1x":-1110.93,"flare2z":3.29,"flare1z":3.89,"z":2.51,"y":-1657.02,"x":-1123.28,"start":false},{"flare1y":-1542.0,"dist":15.0,"flare2x":-1198.97,"flare2y":-1517.49,"flare1x":-1181.68,"flare2z":3.84,"flare1z":3.6,"z":2.63,"y":-1529.82,"x":-1189.8,"start":false},{"flare1y":-1379.52,"dist":15.0,"flare2x":-1207.04,"flare2y":-1351.67,"flare1x":-1195.89,"flare2z":3.85,"flare1z":3.73,"z":2.72,"y":-1365.79,"x":-1200.94,"start":false},{"flare1y":-858.41,"dist":15.0,"flare2x":-561.28,"flare2y":-828.5,"flare1x":-563.49,"flare2z":26.97,"flare1z":26.04,"z":25.46,"y":-843.87,"x":-561.77,"start":false},{"flare1y":-986.93,"dist":15.0,"flare2x":233.98,"flare2y":-977.74,"flare1x":262.52,"flare2z":29.06,"flare1z":28.23,"z":27.56,"y":-981.82,"x":248.82,"start":false},{"flare1y":-456.48,"dist":15.0,"flare2x":495.79,"flare2y":-438.35,"flare1x":519.69,"flare2z":29.18,"flare1z":29.65,"z":28.39,"y":-446.79,"x":508.68,"start":false}]'),
	(27, 'Max Millars Track', '', '1171', '[{"flare1x":1176.87,"flare1y":2413.83,"y":2414.32,"x":1166.17,"flare2x":1155.37,"flare2z":55.2,"flare2y":2414.33,"dist":11.0,"flare1z":59.85,"start":true,"z":56.24},{"flare1x":1090.45,"flare1y":2469.63,"y":2461.61,"x":1097.98,"flare2x":1106.09,"flare2z":50.02,"flare2y":2454.2,"dist":11.0,"flare1z":48.84,"start":false,"z":48.13},{"flare1x":968.2,"flare1y":2478.71,"y":2468.91,"x":963.66,"flare2x":959.53,"flare2z":47.9,"flare2y":2458.85,"dist":11.0,"flare1z":51.65,"start":false,"z":48.48},{"flare1x":881.52,"flare1y":2417.78,"y":2417.37,"x":892.53,"flare2x":903.51,"flare2z":49.62,"flare2y":2418.12,"dist":11.0,"flare1z":49.34,"start":false,"z":48.2},{"flare1x":1080.38,"flare1y":2165.77,"y":2168.19,"x":1091.11,"flare2x":1101.68,"flare2z":53.3,"flare2y":2171.26,"dist":11.0,"flare1z":53.65,"start":false,"z":52.2},{"flare1x":972.19,"flare1y":2286.03,"y":2276.6,"x":966.56,"flare2x":961.59,"flare2z":46.67,"flare2y":2266.78,"dist":11.0,"flare1z":47.73,"start":false,"z":45.9},{"flare1x":1130.43,"flare1y":2419.93,"y":2418.82,"x":1141.39,"flare2x":1152.4,"flare2z":50.32,"flare2y":2418.71,"dist":11.0,"flare1z":50.46,"start":false,"z":49.04},{"flare1x":1176.83,"flare1y":2340.36,"y":2340.83,"x":1165.84,"flare2x":1154.83,"flare2z":57.41,"flare2y":2340.73,"dist":11.0,"flare1z":57.23,"start":false,"z":56.02}]'),
	(28, 'High Stakes', 'Where big ballers come to play. -Ogled Jones', '9871', '[{"flare1z":75.06,"dist":15.0,"z":73.68,"flare1y":-113.92,"flare2x":673.69,"flare2y":-88.73,"flare2z":74.67,"start":true,"flare1x":657.4,"y":-100.5,"x":665.23},{"flare1z":67.68,"dist":15.0,"z":66.34,"flare1y":-393.32,"flare2x":1074.11,"flare2y":-415.76,"flare2z":67.36,"start":false,"flare1x":1054.2,"y":-404.5,"x":1064.98},{"flare1z":57.32,"dist":15.0,"z":56.63,"flare1y":-677.73,"flare2x":994.14,"flare2y":-668.32,"flare2z":58.26,"start":false,"flare1x":965.67,"y":-672.2,"x":980.18},{"flare1z":56.44,"dist":15.0,"z":55.54,"flare1y":-795.71,"flare2x":1203.51,"flare2y":-802.54,"flare2z":56.92,"start":false,"flare1x":1174.3,"y":-798.56,"x":1189.58},{"flare1z":52.95,"dist":15.0,"z":50.38,"flare1y":-1558.31,"flare2x":1323.83,"flare2y":-1529.0,"flare2z":50.43,"start":false,"flare1x":1329.69,"y":-1543.28,"x":1326.01},{"flare1z":79.4,"dist":15.0,"z":78.37,"flare1y":-951.17,"flare2x":1998.22,"flare2y":-932.85,"flare2z":79.65,"start":false,"flare1x":1974.47,"y":-941.13,"x":1986.33},{"flare1z":108.31,"dist":15.0,"z":107.01,"flare1y":-2142.9,"flare2x":1675.59,"flare2y":-2159.26,"flare2z":108.1,"start":false,"flare1x":1650.44,"y":-2150.94,"x":1663.73},{"flare1z":37.77,"dist":15.0,"z":36.35,"flare1y":-2563.57,"flare2x":1195.83,"flare2y":-2537.2,"flare2z":37.38,"start":false,"flare1x":1210.14,"y":-2550.14,"x":1202.37},{"flare1z":38.53,"dist":8.0,"z":37.69,"flare1y":-1928.11,"flare2x":1212.13,"flare2y":-1934.08,"flare2z":39.04,"start":false,"flare1x":1226.97,"y":-1931.95,"x":1219.32},{"flare1z":37.82,"dist":10.5,"z":36.51,"flare1y":-1834.54,"flare2x":1165.21,"flare2y":-1853.76,"flare2z":37.57,"start":false,"flare1x":1156.75,"y":-1844.34,"x":1161.85},{"flare1z":31.86,"dist":10.5,"z":30.43,"flare1y":-1859.97,"flare2x":940.51,"flare2y":-1857.85,"flare2z":31.37,"start":false,"flare1x":961.4,"y":-1859.58,"x":950.36},{"flare1z":31.58,"dist":10.5,"z":30.43,"flare1y":-1752.3,"flare2x":936.75,"flare2y":-1773.16,"flare2z":31.64,"start":false,"flare1x":939.17,"y":-1763.33,"x":938.6},{"flare1z":30.19,"dist":10.5,"z":28.8,"flare1y":-1717.57,"flare2x":822.53,"flare2y":-1714.33,"flare2z":29.8,"start":false,"flare1x":843.28,"y":-1716.57,"x":832.28},{"flare1z":26.64,"dist":12.5,"z":25.45,"flare1y":-1335.08,"flare2x":789.51,"flare2y":-1334.62,"flare2z":26.62,"start":false,"flare1x":814.51,"y":-1335.27,"x":801.48},{"flare1z":28.75,"dist":10.0,"z":27.42,"flare1y":-998.26,"flare2x":734.35,"flare2y":-1018.0,"flare2z":28.61,"start":false,"flare1x":731.18,"y":-1008.55,"x":733.47},{"flare1z":29.73,"dist":10.0,"z":28.62,"flare1y":-1081.2,"flare2x":407.67,"flare2y":-1080.43,"flare2z":29.86,"start":false,"flare1x":387.69,"y":-1080.09,"x":398.18},{"flare1z":29.53,"dist":10.0,"z":28.61,"flare1y":-1120.31,"flare2x":371.38,"flare2y":-1140.28,"flare2z":30.03,"start":false,"flare1x":370.37,"y":-1130.79,"x":371.62},{"flare1z":31.07,"dist":14.5,"z":28.59,"flare1y":-1166.14,"flare2x":227.19,"flare2y":-1162.83,"flare2z":28.57,"start":false,"flare1x":198.49,"y":-1163.72,"x":213.27},{"flare1z":29.7,"dist":11.5,"z":28.6,"flare1y":-1424.43,"flare2x":190.21,"flare2y":-1405.53,"flare2z":29.84,"start":false,"flare1x":177.1,"y":-1414.14,"x":183.37},{"flare1z":29.43,"dist":8.5,"z":28.46,"flare1y":-1606.67,"flare2x":504.66,"flare2y":-1595.68,"flare2z":29.83,"start":false,"flare1x":517.62,"y":-1601.37,"x":510.29},{"flare1z":29.64,"dist":8.5,"z":28.44,"flare1y":-1522.15,"flare2x":533.6,"flare2y":-1534.9,"flare2z":29.61,"start":false,"flare1x":544.85,"y":-1529.39,"x":539.41},{"flare1z":27.86,"dist":8.5,"z":26.83,"flare1y":-945.27,"flare2x":474.14,"flare2y":-962.27,"flare2z":28.2,"start":false,"flare1x":474.41,"y":-954.32,"x":474.95},{"flare1z":29.57,"dist":15.0,"z":28.27,"flare1y":-926.38,"flare2x":254.6,"flare2y":-915.79,"flare2z":29.32,"start":false,"flare1x":282.67,"y":-921.56,"x":267.89},{"flare1z":29.91,"dist":15.0,"z":28.78,"flare1y":-833.81,"flare2x":247.65,"flare2y":-862.32,"flare2z":30.05,"start":false,"flare1x":257.01,"y":-848.78,"x":252.83},{"flare1z":32.42,"dist":15.0,"z":31.26,"flare1y":-783.48,"flare2x":176.72,"flare2y":-773.04,"flare2z":32.51,"start":false,"flare1x":204.85,"y":-778.72,"x":190.05},{"flare1z":44.35,"dist":7.0,"z":43.19,"flare1y":-443.18,"flare2x":327.72,"flare2y":-435.81,"flare2z":44.42,"start":false,"flare1x":339.62,"y":-439.84,"x":332.84},{"flare1z":48.99,"dist":10.5,"z":47.83,"flare1y":-253.73,"flare2x":508.99,"flare2y":-244.61,"flare2z":49.11,"start":false,"flare1x":527.91,"y":-249.58,"x":517.67},{"flare1z":60.17,"dist":10.5,"z":58.22,"flare1y":-140.51,"flare2x":469.53,"flare2y":-160.6,"flare2z":58.94,"start":false,"flare1x":475.51,"y":-151.24,"x":473.03},{"flare1z":69.07,"dist":13.5,"z":68.47,"flare1y":-95.85,"flare2x":414.01,"flare2y":-80.06,"flare2z":70.38,"start":false,"flare1x":435.88,"y":-88.19,"x":424.12},{"flare1z":95.0,"dist":7.5,"z":94.23,"flare1y":38.4,"flare2x":527.46,"flare2y":52.71,"flare2z":95.83,"start":false,"flare1x":531.88,"y":45.85,"x":528.84},{"flare1z":83.97,"dist":10.5,"z":82.86,"flare1y":-12.63,"flare2x":680.62,"flare2y":-25.0,"flare2z":83.98,"start":false,"flare1x":663.66,"y":-18.55,"x":672.97}]');
/*!40000 ALTER TABLE `racing-maps` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.rented_vehicles
CREATE TABLE IF NOT EXISTS `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.rented_vehicles: ~0 rows (approximately)
/*!40000 ALTER TABLE `rented_vehicles` DISABLE KEYS */;
/*!40000 ALTER TABLE `rented_vehicles` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.society_moneywash
CREATE TABLE IF NOT EXISTS `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.society_moneywash: ~0 rows (approximately)
/*!40000 ALTER TABLE `society_moneywash` DISABLE KEYS */;
/*!40000 ALTER TABLE `society_moneywash` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.trunk_inventory
CREATE TABLE IF NOT EXISTS `trunk_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(8) NOT NULL,
  `data` text NOT NULL,
  `owned` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.trunk_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `trunk_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `trunk_inventory` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.tweets
CREATE TABLE IF NOT EXISTS `tweets` (
  `handle` longtext NOT NULL,
  `message` varchar(500) NOT NULL,
  `time` longtext NOT NULL,
  KEY `IDX_tweets_handle` (`handle`(768)),
  KEY `IDX_tweets_message` (`message`),
  KEY `IDX_tweets_time` (`time`(768))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.tweets: ~0 rows (approximately)
/*!40000 ALTER TABLE `tweets` DISABLE KEYS */;
/*!40000 ALTER TABLE `tweets` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) COLLATE utf8mb4_bin NOT NULL,
  `license` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `money` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_bin DEFAULT '',
  `skin` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `job` varchar(255) COLLATE utf8mb4_bin DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `crafting_level` int(11) NOT NULL,
  `position` varchar(256) COLLATE utf8mb4_bin DEFAULT '{"x":195.55,"y":-933.36,"z":29.90,"heading":100.0}',
  `bank` int(11) DEFAULT NULL,
  `permission_level` int(11) DEFAULT NULL,
  `group` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `firstname` varchar(50) COLLATE utf8mb4_bin NOT NULL DEFAULT '',
  `lastname` varchar(50) COLLATE utf8mb4_bin DEFAULT '',
  `dateofbirth` varchar(25) COLLATE utf8mb4_bin DEFAULT '',
  `sex` varchar(10) COLLATE utf8mb4_bin DEFAULT '',
  `height` varchar(5) COLLATE utf8mb4_bin DEFAULT '',
  `status` longtext COLLATE utf8mb4_bin DEFAULT NULL,
  `phone_number` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL,
  `jail` int(11) NOT NULL DEFAULT 0,
  `lastdigits` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  `payslip` int(11) NOT NULL DEFAULT 0,
  `ammoTable` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  `metaData` longtext COLLATE utf8mb4_bin DEFAULT '{}',
  PRIMARY KEY (`id`),
  KEY `IDX_users_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- Dumping data for table s1873_ffrp.users: ~0 rows (approximately)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_accounts
CREATE TABLE IF NOT EXISTS `user_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) NOT NULL,
  `name` varchar(50) NOT NULL,
  `money` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_accounts: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_accounts` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_accounts` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_bans
CREATE TABLE IF NOT EXISTS `user_bans` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) CHARACTER SET utf8 DEFAULT NULL,
  `reason` longtext CHARACTER SET utf8 DEFAULT NULL,
  `admin` tinytext CHARACTER SET utf8 DEFAULT NULL,
  `ban_issued` text NOT NULL,
  `banned_until` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.user_bans: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_bans` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_bans` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_convictions
CREATE TABLE IF NOT EXISTS `user_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `jailtime` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_convictions: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_convictions` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_convictions` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_identifiers
CREATE TABLE IF NOT EXISTS `user_identifiers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `xbl` varchar(255) DEFAULT NULL,
  `live` varchar(255) DEFAULT NULL,
  `discord` varchar(255) DEFAULT NULL,
  `fivem` varchar(255) DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.user_identifiers: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_identifiers` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_identifiers` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_inventory
CREATE TABLE IF NOT EXISTS `user_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(22) NOT NULL,
  `item` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_inventory` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_inventory2
CREATE TABLE IF NOT EXISTS `user_inventory2` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `item_id` varchar(255) CHARACTER SET utf8 DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `information` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `slot` int(11) NOT NULL,
  `dropped` tinyint(4) NOT NULL DEFAULT 0,
  `quality` int(11) DEFAULT 100,
  `creationDate` bigint(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `IDX_user_inventory2_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_inventory2: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_inventory2` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_inventory2` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_keybinds
CREATE TABLE IF NOT EXISTS `user_keybinds` (
  `identifier` varchar(100) NOT NULL,
  `keybinds` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.user_keybinds: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_keybinds` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_keybinds` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_lastcharacter
CREATE TABLE IF NOT EXISTS `user_lastcharacter` (
  `steamid` varchar(255) NOT NULL,
  `charid` int(11) NOT NULL,
  PRIMARY KEY (`steamid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_lastcharacter: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_lastcharacter` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_lastcharacter` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `owner` (`owner`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_licenses: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_licenses` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_licenses` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.user_mdt
CREATE TABLE IF NOT EXISTS `user_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL,
  `bail` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.user_mdt: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_mdt` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicleaddon_categories
CREATE TABLE IF NOT EXISTS `vehicleaddon_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicleaddon_categories: ~3 rows (approximately)
/*!40000 ALTER TABLE `vehicleaddon_categories` DISABLE KEYS */;
INSERT INTO `vehicleaddon_categories` (`name`, `label`) VALUES
	('addon', 'Addon'),
	('super', 'super'),
	('addon', 'Addon');
/*!40000 ALTER TABLE `vehicleaddon_categories` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `inshop` int(11) NOT NULL DEFAULT 1,
  `commission` int(11) NOT NULL DEFAULT 15,
  `baseprice` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicles: ~245 rows (approximately)
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` (`id`, `name`, `model`, `price`, `category`, `inshop`, `commission`, `baseprice`) VALUES
	(1, 'Adder', 'adder', 900000, 'super', 0, 0, 0),
	(2, 'Akuma', 'AKUMA', 70000, 'motorcycles', 1, 0, 0),
	(3, 'Alpha', 'alpha', 60000, 'sports', 1, 0, 0),
	(4, 'Ardent', 'ardent', 1150000, 'sportsclassics', 1, 0, 0),
	(5, 'Asea', 'asea', 31000, 'sedans', 1, 0, 0),
	(6, 'Autarch', 'autarch', 1955000, 'super', 0, 0, 0),
	(7, 'Avarus', 'avarus', 55000, 'motorcycles', 1, 0, 0),
	(8, 'Bagger', 'bagger', 50000, 'motorcycles', 1, 0, 0),
	(9, 'Baller', 'baller2', 89000, 'suvs', 0, 0, 0),
	(10, 'Baller Sport', 'baller3', 60000, 'suvs', 0, 0, 0),
	(11, 'Banshee', 'banshee', 70000, 'sports', 0, 0, 0),
	(12, 'Banshee 900R', 'banshee2', 255000, 'importcars', 0, 0, 0),
	(13, 'Bati 801', 'bati', 12000, 'importbikes', 0, 0, 0),
	(14, 'Bati 801RR', 'bati2', 19000, 'importbikes', 0, 0, 0),
	(15, 'Bestia GTS', 'bestiagts', 55000, 'sports', 1, 0, 0),
	(16, 'BF400', 'bf400', 72000, 'motorcycles', 1, 0, 0),
	(17, 'Bf Injection', 'bfinjection', 16000, 'offroad', 0, 0, 0),
	(18, 'Bifta', 'bifta', 60000, 'offroad', 1, 0, 0),
	(19, 'Bison', 'bison', 51000, 'vans', 1, 0, 0),
	(20, 'Blade', 'blade', 35000, 'muscle', 1, 0, 0),
	(21, 'Blazer', 'blazer', 6500, 'offroad', 0, 0, 0),
	(22, 'Blazer Sport', 'blazer4', 8500, 'offroad', 0, 0, 0),
	(23, 'blazer5', 'blazer5', 1755600, 'offroad', 0, 0, 0),
	(24, 'Blista', 'blista', 10000, 'compacts', 1, 0, 0),
	(25, 'BMX (velo)', 'bmx', 500, 'motorcycles', 1, 0, 0),
	(26, 'Bobcat XL', 'bobcatxl', 40000, 'vans', 1, 0, 0),
	(27, 'Brawler', 'brawler', 45000, 'offroad', 0, 0, 0),
	(28, 'Brioso R/A', 'brioso', 25000, 'compacts', 1, 0, 0),
	(29, 'Btype', 'btype', 62000, 'sportsclassics', 1, 0, 0),
	(30, 'Btype Hotroad', 'btype2', 155000, 'sportsclassics', 1, 0, 0),
	(31, 'Btype Luxe', 'btype3', 85000, 'sportsclassics', 1, 0, 0),
	(32, 'Buccaneer', 'buccaneer', 36000, 'muscle', 1, 0, 0),
	(33, 'Buccaneer Rider', 'buccaneer2', 24000, 'muscle', 0, 0, 0),
	(34, 'Buffalo', 'buffalo', 12000, 'sports', 0, 0, 0),
	(35, 'Buffalo S', 'buffalo2', 20000, 'sports', 1, 0, 0),
	(36, 'Bullet', 'bullet', 90000, 'super', 0, 0, 0),
	(37, 'Burrito', 'burrito3', 45000, 'vans', 0, 0, 0),
	(38, 'Camper', 'camper', 41000, 'vans', 1, 0, 0),
	(39, 'Carbonizzare', 'carbonizzare', 75000, 'sports', 1, 0, 0),
	(40, 'Carbon RS', 'carbonrs', 55000, 'motorcycles', 1, 0, 0),
	(41, 'Casco', 'casco', 30000, 'sportsclassics', 1, 0, 0),
	(42, 'Cavalcade', 'cavalcade2', 39000, 'suvs', 1, 0, 0),
	(43, 'Cheetah', 'cheetah', 375000, 'super', 0, 0, 0),
	(44, 'Chimera', 'chimera', 65000, 'motorcycles', 1, 0, 0),
	(45, 'Chino', 'chino', 29000, 'muscle', 1, 0, 0),
	(46, 'Chino Luxe', 'chino2', 19000, 'muscle', 0, 0, 0),
	(47, 'Cliffhanger', 'cliffhanger', 63000, 'motorcycles', 1, 0, 0),
	(48, 'Cognoscenti Cabrio', 'cogcabrio', 90000, 'coupes', 1, 0, 0),
	(49, 'Cognoscenti', 'cognoscenti', 39000, 'sedans', 1, 0, 0),
	(50, 'Comet', 'comet2', 65000, 'sports', 1, 0, 0),
	(51, 'Comet 5', 'comet5', 1145000, 'sports', 1, 0, 0),
	(52, 'Contender', 'contender', 70000, 'suvs', 0, 0, 0),
	(53, 'Coquette', 'coquette', 65000, 'sports', 1, 0, 0),
	(54, 'Coquette Classic', 'coquette2', 40000, 'sportsclassics', 1, 0, 0),
	(55, 'Coquette BlackFin', 'coquette3', 55000, 'muscle', 0, 0, 0),
	(56, 'Cruiser (velo)', 'cruiser', 510, 'motorcycles', 1, 0, 0),
	(57, 'Cyclone', 'cyclone', 1890000, 'super', 0, 0, 0),
	(58, 'Daemon', 'daemon', 62000, 'motorcycles', 1, 0, 0),
	(59, 'Daemon High', 'daemon2', 70000, 'motorcycles', 1, 0, 0),
	(60, 'Defiler', 'defiler', 85000, 'motorcycles', 1, 0, 0),
	(61, 'Deluxo', 'deluxo', 4721500, 'sportsclassics', 1, 0, 0),
	(62, 'Dilettante', 'dilettante', 21500, 'compacts', 1, 0, 0),
	(63, 'Dominator', 'dominator', 50000, 'muscle', 1, 0, 0),
	(64, 'Double T', 'double', 75000, 'motorcycles', 1, 0, 0),
	(65, 'Dubsta', 'dubsta', 55000, 'suvs', 1, 0, 0),
	(66, 'Dubsta Luxuary', 'dubsta2', 60000, 'suvs', 0, 0, 0),
	(67, 'Bubsta 6x6', 'dubsta3', 120000, 'offroad', 0, 0, 0),
	(68, 'Dukes', 'dukes', 40000, 'muscle', 1, 0, 0),
	(69, 'Dune Buggy', 'dune', 8000, 'offroad', 0, 0, 0),
	(70, 'Elegy', 'elegy2', 38500, 'sports', 1, 0, 0),
	(71, 'Elliie', 'ellie', 150000, 'muscle', 1, 0, 0),
	(72, 'Emperor', 'emperor', 33000, 'sedans', 1, 0, 0),
	(73, 'Enduro', 'enduro', 55000, 'motorcycles', 1, 0, 0),
	(74, 'Entity XF', 'entityxf', 425000, 'importcars', 0, 0, 0),
	(75, 'Esskey', 'esskey', 65000, 'motorcycles', 1, 0, 0),
	(76, 'Exemplar', 'exemplar', 140000, 'coupes', 1, 0, 0),
	(77, 'F620', 'f620', 115000, 'coupes', 1, 0, 0),
	(78, 'Faction', 'faction', 38000, 'muscle', 1, 0, 0),
	(79, 'Faction Rider', 'faction2', 30000, 'muscle', 0, 0, 0),
	(80, 'Faction XL', 'faction3', 40000, 'muscle', 0, 0, 0),
	(81, 'Faggio', 'faggio', 15000, 'motorcycles', 1, 0, 0),
	(82, 'Vespa', 'faggio2', 15000, 'motorcycles', 1, 0, 0),
	(83, 'Felon', 'felon', 120000, 'coupes', 1, 0, 0),
	(84, 'Felon GT', 'felon2', 120000, 'coupes', 1, 0, 0),
	(85, 'Feltzer', 'feltzer2', 55000, 'sports', 1, 0, 0),
	(86, 'Stirling GT', 'feltzer3', 65000, 'sportsclassics', 1, 0, 0),
	(87, 'Fixter (velo)', 'fixter', 225, 'motorcycles', 1, 0, 0),
	(88, 'Flatbed', 'flatbed', 10000, 'utility', 0, 0, 0),
	(89, 'FMJ', 'fmj', 185000, 'super', 0, 0, 0),
	(90, 'Fhantom', 'fq2', 17000, 'suvs', 0, 0, 0),
	(91, 'Fugitive', 'fugitive', 33000, 'sedans', 1, 0, 0),
	(92, 'Furore GT', 'furoregt', 45000, 'sports', 1, 0, 0),
	(93, 'Fusilade', 'fusilade', 40000, 'sports', 0, 0, 0),
	(94, 'Gargoyle', 'gargoyle', 65000, 'motorcycles', 1, 0, 0),
	(95, 'Gauntlet', 'gauntlet', 45000, 'muscle', 1, 0, 0),
	(96, 'Gang Burrito', 'gburrito', 45000, 'vans', 0, 0, 0),
	(97, 'Burrito', 'gburrito2', 29000, 'vans', 0, 0, 0),
	(98, 'Glendale', 'glendale', 32000, 'sedans', 1, 0, 0),
	(99, 'Grabger', 'granger', 50000, 'suvs', 0, 0, 0),
	(100, 'Gresley', 'gresley', 40000, 'suvs', 1, 0, 0),
	(101, 'GT 500', 'gt500', 785000, 'sportsclassics', 1, 0, 0),
	(102, 'Guardian', 'guardian', 45000, 'offroad', 0, 0, 0),
	(103, 'Hakuchou', 'hakuchou', 31000, 'motorcycles', 0, 0, 0),
	(104, 'Hakuchou Sport', 'hakuchou2', 55000, 'motorcycles', 0, 0, 0),
	(105, 'Hermes', 'hermes', 535000, 'muscle', 0, 0, 0),
	(106, 'Hexer', 'hexer', 45000, 'motorcycles', 1, 0, 0),
	(107, 'Hotknife', 'hotknife', 125000, 'muscle', 0, 0, 0),
	(108, 'Huntley S', 'huntley', 55000, 'suvs', 1, 0, 0),
	(109, 'Hustler', 'hustler', 625000, 'muscle', 0, 0, 0),
	(110, 'Infernus', 'infernus', 180000, 'super', 0, 0, 0),
	(111, 'Innovation', 'innovation', 75000, 'motorcycles', 1, 0, 0),
	(112, 'Intruder', 'intruder', 35000, 'sedans', 1, 0, 0),
	(113, 'Issi', 'issi2', 25500, 'compacts', 1, 0, 0),
	(114, 'Jackal', 'jackal', 125000, 'coupes', 1, 0, 0),
	(115, 'Jester', 'jester', 200000, 'sports', 1, 0, 0),
	(116, 'Jester(Racecar)', 'jester2', 135000, 'sports', 0, 0, 0),
	(117, 'Journey', 'journey', 39000, 'vans', 1, 0, 0),
	(118, 'Kamacho', 'kamacho', 345000, 'offroad', 0, 0, 0),
	(119, 'Khamelion', 'khamelion', 38000, 'sports', 0, 0, 0),
	(120, 'Kuruma', 'kuruma', 30000, 'sports', 1, 0, 0),
	(121, 'Landstalker', 'landstalker', 40000, 'suvs', 1, 0, 0),
	(122, 'RE-7B', 'le7b', 325000, 'importcars', 0, 0, 0),
	(123, 'Lynx', 'lynx', 40000, 'sports', 1, 0, 0),
	(124, 'Mamba', 'mamba', 70000, 'sports', 1, 0, 0),
	(125, 'Manana', 'manana', 12800, 'sportsclassics', 1, 0, 0),
	(126, 'Manchez', 'manchez', 67000, 'motorcycles', 1, 0, 0),
	(127, 'Massacro', 'massacro', 65000, 'sports', 1, 0, 0),
	(128, 'Massacro(Racecar)', 'massacro2', 130000, 'sports', 0, 0, 0),
	(129, 'Mesa', 'mesa', 16000, 'suvs', 0, 0, 0),
	(130, 'Mesa Trail', 'mesa3', 40000, 'suvs', 0, 0, 0),
	(131, 'Minivan', 'minivan', 40000, 'vans', 1, 0, 0),
	(132, 'Monroe', 'monroe', 55000, 'sportsclassics', 1, 0, 0),
	(133, 'The Liberator', 'monster', 210000, 'offroad', 0, 0, 0),
	(134, 'Moonbeam', 'moonbeam', 45000, 'vans', 1, 0, 0),
	(135, 'Moonbeam Rider', 'moonbeam2', 50000, 'vans', 0, 0, 0),
	(136, 'Nemesis', 'nemesis', 50000, 'motorcycles', 1, 0, 0),
	(137, 'Neon', 'neon', 1500000, 'sports', 0, 0, 0),
	(138, 'Nightblade', 'nightblade', 35000, 'importbikes', 0, 0, 0),
	(139, 'Nightshade', 'nightshade', 65000, 'muscle', 0, 0, 0),
	(140, '9F', 'ninef', 65000, 'sports', 1, 0, 0),
	(141, '9F Cabrio', 'ninef2', 80000, 'sports', 1, 0, 0),
	(142, 'Omnis', 'omnis', 35000, 'sports', 0, 0, 0),
	(143, 'Oppressor', 'oppressor', 3524500, 'super', 0, 0, 0),
	(144, 'Oracle XS', 'oracle2', 130000, 'coupes', 1, 0, 0),
	(145, 'Osiris', 'osiris', 160000, 'super', 0, 0, 0),
	(146, 'Panto', 'panto', 18000, 'compacts', 1, 0, 0),
	(147, 'Paradise', 'paradise', 49000, 'vans', 1, 0, 0),
	(148, 'Pariah', 'pariah', 1420000, 'sports', 1, 0, 0),
	(149, 'Patriot', 'patriot', 55000, 'suvs', 0, 0, 0),
	(150, 'PCJ-600', 'pcj', 50000, 'motorcycles', 1, 0, 0),
	(151, 'Penumbra', 'penumbra', 28000, 'sports', 0, 0, 0),
	(152, 'Pfister', 'pfister811', 85000, 'super', 0, 0, 0),
	(153, 'Phoenix', 'phoenix', 35000, 'muscle', 1, 0, 0),
	(154, 'Picador', 'picador', 36000, 'muscle', 1, 0, 0),
	(155, 'Pigalle', 'pigalle', 20000, 'sportsclassics', 1, 0, 0),
	(156, 'Prairie', 'prairie', 22000, 'compacts', 1, 0, 0),
	(157, 'Premier', 'premier', 36000, 'sedans', 1, 0, 0),
	(158, 'Primo Custom', 'primo2', 40000, 'sedans', 0, 0, 0),
	(159, 'X80 Proto', 'prototipo', 2500000, 'super', 0, 0, 0),
	(160, 'Radius', 'radi', 46000, 'suvs', 1, 0, 0),
	(161, 'raiden', 'raiden', 1375000, 'sports', 0, 0, 0),
	(162, 'Rapid GT', 'rapidgt', 35000, 'sports', 1, 0, 0),
	(163, 'Rapid GT Convertible', 'rapidgt2', 45000, 'sports', 1, 0, 0),
	(164, 'Rapid GT3', 'rapidgt3', 885000, 'sportsclassics', 1, 0, 0),
	(165, 'Reaper', 'reaper', 150000, 'importcars', 0, 0, 0),
	(166, 'Rebel', 'rebel2', 75000, 'offroad', 1, 0, 0),
	(167, 'Regina', 'regina', 32000, 'sedans', 1, 0, 0),
	(168, 'Retinue', 'retinue', 615000, 'sportsclassics', 1, 0, 0),
	(169, 'Revolter', 'revolter', 1610000, 'sports', 1, 0, 0),
	(170, 'Rhapsody', 'rhapsody', 22000, 'compacts', 1, 0, 0),
	(171, 'riata', 'riata', 380000, 'offroad', 0, 0, 0),
	(172, 'Rocoto', 'rocoto', 45000, 'suvs', 0, 0, 0),
	(173, 'Ruffian', 'ruffian', 54000, 'motorcycles', 1, 0, 0),
	(174, 'Ruiner 2', 'ruiner2', 5745600, 'muscle', 0, 0, 0),
	(175, 'Rumpo', 'rumpo', 15000, 'vans', 0, 0, 0),
	(176, 'Rumpo Trail', 'rumpo3', 19500, 'vans', 0, 0, 0),
	(177, 'Sabre Turbo', 'sabregt', 37000, 'muscle', 1, 0, 0),
	(178, 'Sabre GT', 'sabregt2', 25000, 'muscle', 0, 0, 0),
	(179, 'Sanchez', 'sanchez', 65000, 'motorcycles', 1, 0, 0),
	(180, 'Sanchez Sport', 'sanchez2', 65000, 'motorcycles', 0, 0, 0),
	(181, 'Sanctus', 'sanctus', 25000, 'importbikes', 0, 0, 0),
	(182, 'Sandking', 'sandking', 55000, 'offroad', 0, 0, 0),
	(183, 'Savestra', 'savestra', 990000, 'sportsclassics', 1, 0, 0),
	(184, 'SC 1', 'sc1', 1603000, 'super', 0, 0, 0),
	(185, 'Schafter', 'schafter2', 25000, 'sedans', 0, 0, 0),
	(186, 'Schafter V12', 'schafter3', 50000, 'sports', 0, 0, 0),
	(187, 'Scorcher (velo)', 'scorcher', 280, 'motorcycles', 1, 0, 0),
	(188, 'Seminole', 'seminole', 40000, 'suvs', 1, 0, 0),
	(189, 'Sentinel', 'sentinel', 130000, 'coupes', 1, 0, 0),
	(190, 'Sentinel XS', 'sentinel2', 140000, 'coupes', 1, 0, 0),
	(191, 'Sentinel3', 'sentinel3', 650000, 'sports', 1, 0, 0),
	(192, 'Seven 70', 'seven70', 39500, 'sports', 1, 0, 0),
	(193, 'ETR1', 'sheava', 220000, 'importcars', 0, 0, 0),
	(194, 'Shotaro Concept', 'shotaro', 320000, 'importbikes', 0, 0, 0),
	(195, 'Slam Van', 'slamvan3', 11500, 'muscle', 0, 0, 0),
	(196, 'Sovereign', 'sovereign', 59000, 'motorcycles', 1, 0, 0),
	(197, 'Stinger', 'stinger', 80000, 'sportsclassics', 1, 0, 0),
	(198, 'Stinger GT', 'stingergt', 75000, 'sportsclassics', 1, 0, 0),
	(199, 'Streiter', 'streiter', 0, 'sports', 1, 0, 0),
	(200, 'Stretch', 'stretch', 90000, 'sedans', 0, 0, 0),
	(201, 'Stromberg', 'stromberg', 3185350, 'sports', 1, 0, 0),
	(202, 'Sultan', 'sultan', 15000, 'sports', 1, 0, 0),
	(203, 'Sultan RS', 'sultanrs', 65000, 'importcars', 0, 0, 0),
	(204, 'Super Diamond', 'superd', 100000, 'sedans', 1, 0, 0),
	(205, 'Surano', 'surano', 50000, 'sports', 1, 0, 0),
	(206, 'Surfer', 'surfer', 42000, 'vans', 1, 0, 0),
	(207, 'T20', 't20', 300000, 'super', 0, 0, 0),
	(208, 'Tailgater', 'tailgater', 36000, 'sedans', 1, 0, 0),
	(209, 'Tampa', 'tampa', 38000, 'muscle', 1, 0, 0),
	(210, 'Drift Tampa', 'tampa2', 80000, 'sports', 0, 0, 0),
	(211, 'Thrust', 'thrust', 85000, 'motorcycles', 0, 0, 0),
	(212, 'Towtruck', 'towtruck', 5000, 'utility', 0, 0, 0),
	(213, 'Tri bike (velo)', 'tribike3', 520, 'motorcycles', 1, 0, 0),
	(214, 'Trophy Truck', 'trophytruck', 60000, 'offroad', 0, 0, 0),
	(215, 'Trophy Truck Limited', 'trophytruck2', 80000, 'offroad', 0, 0, 0),
	(216, 'Tropos', 'tropos', 40000, 'sports', 0, 0, 0),
	(217, 'Turismo R', 'turismor', 350000, 'super', 0, 0, 0),
	(218, 'Tyrus', 'tyrus', 600000, 'super', 0, 0, 0),
	(219, 'Vacca', 'vacca', 120000, 'super', 0, 0, 0),
	(220, 'Vader', 'vader', 75000, 'motorcycles', 1, 0, 0),
	(221, 'Verlierer', 'verlierer2', 70000, 'sports', 1, 0, 0),
	(222, 'Vigero', 'vigero', 70000, 'muscle', 0, 0, 0),
	(223, 'Virgo', 'virgo', 42000, 'muscle', 1, 0, 0),
	(224, 'Viseris', 'viseris', 875000, 'sportsclassics', 1, 0, 0),
	(225, 'Visione', 'visione', 2250000, 'super', 0, 0, 0),
	(226, 'Voltic', 'voltic', 90000, 'super', 0, 0, 0),
	(227, 'Voltic 2', 'voltic2', 3830400, 'super', 0, 0, 0),
	(228, 'Voodoo', 'voodoo', 7200, 'muscle', 0, 0, 0),
	(229, 'Vortex', 'vortex', 80000, 'motorcycles', 1, 0, 0),
	(230, 'Warrener', 'warrener', 34000, 'sedans', 1, 0, 0),
	(231, 'Washington', 'washington', 35000, 'sedans', 1, 0, 0),
	(232, 'Windsor', 'windsor', 150000, 'coupes', 1, 0, 0),
	(233, 'Windsor Drop', 'windsor2', 165000, 'coupes', 1, 0, 0),
	(234, 'Woflsbane', 'wolfsbane', 9000, 'importbikes', 0, 0, 0),
	(235, 'XLS', 'xls', 32000, 'suvs', 0, 0, 0),
	(236, 'Yosemite', 'yosemite', 485000, 'muscle', 0, 0, 0),
	(237, 'Youga', 'youga', 43000, 'vans', 1, 0, 0),
	(238, 'Youga Luxuary', 'youga2', 45000, 'vans', 0, 0, 0),
	(239, 'Z190', 'z190', 900000, 'sportsclassics', 1, 0, 0),
	(240, 'Zentorno', 'zentorno', 1500000, 'super', 0, 0, 0),
	(241, 'Zion', 'zion', 130000, 'coupes', 1, 0, 0),
	(242, 'Zombie', 'zombiea', 65000, 'motorcycles', 1, 0, 0),
	(243, 'Zombie Luxuary', 'zombieb', 12000, 'importbikes', 0, 0, 0),
	(244, 'Z-Type', 'ztype', 220000, 'sportsclassics', 1, 0, 0),
	(245, 'Elegy2', 'elegy', 300000, 'sports', 1, 0, 0);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehiclesaddon
CREATE TABLE IF NOT EXISTS `vehiclesaddon` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehiclesaddon: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehiclesaddon` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehiclesaddon` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_display
CREATE TABLE IF NOT EXISTS `vehicles_display` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 15,
  `baseprice` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicles_display: ~7 rows (approximately)
/*!40000 ALTER TABLE `vehicles_display` DISABLE KEYS */;
INSERT INTO `vehicles_display` (`ID`, `model`, `commission`, `baseprice`) VALUES
	(1, 'bati', 15, 75000),
	(2, 'AKUMA', 15, 80000),
	(3, 'diablous', 15, 75500),
	(4, 'fcr2', 15, 75000),
	(5, 'vortex', 15, 90000),
	(6, 'hakuchou', 15, 80000),
	(7, 'vindicator', 15, 75000);
/*!40000 ALTER TABLE `vehicles_display` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_display_bikeshop
CREATE TABLE IF NOT EXISTS `vehicles_display_bikeshop` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 15,
  `baseprice` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1 AVG_ROW_LENGTH=2340;

-- Dumping data for table s1873_ffrp.vehicles_display_bikeshop: ~7 rows (approximately)
/*!40000 ALTER TABLE `vehicles_display_bikeshop` DISABLE KEYS */;
INSERT INTO `vehicles_display_bikeshop` (`ID`, `model`, `commission`, `baseprice`) VALUES
	(1, 'pcj', 15, 75000),
	(2, 'AKUMA', 15, 80000),
	(3, 'hexer', 15, 65000),
	(4, 'nemesis', 15, 70000),
	(5, 'bati', 25, 75000),
	(6, 'HDIron883', 25, 170000),
	(7, 'sanctus', 15, 80000);
/*!40000 ALTER TABLE `vehicles_display_bikeshop` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_display_imports
CREATE TABLE IF NOT EXISTS `vehicles_display_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 15,
  `baseprice` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicles_display_imports: ~5 rows (approximately)
/*!40000 ALTER TABLE `vehicles_display_imports` DISABLE KEYS */;
INSERT INTO `vehicles_display_imports` (`id`, `model`, `commission`, `baseprice`) VALUES
	(1, 'esv', 15, 850000),
	(2, 'bluecunt', 15, 375000),
	(3, 'v242', 15, 350000),
	(4, 'z2879', 15, 425000),
	(5, 'mig', 15, 2000000);
/*!40000 ALTER TABLE `vehicles_display_imports` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_display_tuner
CREATE TABLE IF NOT EXISTS `vehicles_display_tuner` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `commission` int(11) NOT NULL DEFAULT 15,
  `baseprice` int(11) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicles_display_tuner: ~7 rows (approximately)
/*!40000 ALTER TABLE `vehicles_display_tuner` DISABLE KEYS */;
INSERT INTO `vehicles_display_tuner` (`ID`, `model`, `commission`, `baseprice`) VALUES
	(1, 'schwarzer2', 15, 435000),
	(2, 's15rb', 15, 340000),
	(3, 'ap2', 15, 400000),
	(4, 'revolution6str2', 15, 550000),
	(5, 'filthynsx', 15, 362000),
	(6, 'comet6str', 15, 500000),
	(7, 'dc5', 15, 455000);
/*!40000 ALTER TABLE `vehicles_display_tuner` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_sold_bikeshop
CREATE TABLE IF NOT EXISTS `vehicles_sold_bikeshop` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `financed` int(11) NOT NULL,
  `commission` int(11) NOT NULL,
  `buy_price` varchar(50) NOT NULL,
  `soldby` varchar(50) DEFAULT NULL,
  `buyer` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=1365;

-- Dumping data for table s1873_ffrp.vehicles_sold_bikeshop: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicles_sold_bikeshop` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_sold_bikeshop` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_sold_imports
CREATE TABLE IF NOT EXISTS `vehicles_sold_imports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `financed` int(11) NOT NULL,
  `commission` int(11) NOT NULL,
  `buy_price` varchar(50) NOT NULL,
  `soldby` varchar(50) DEFAULT NULL,
  `buyer` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.vehicles_sold_imports: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicles_sold_imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_sold_imports` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_sold_pdm
CREATE TABLE IF NOT EXISTS `vehicles_sold_pdm` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `financed` int(11) NOT NULL,
  `commission` int(11) NOT NULL,
  `buy_price` varchar(50) NOT NULL,
  `soldby` varchar(50) DEFAULT NULL,
  `buyer` varchar(50) DEFAULT NULL,
  `date` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=1365;

-- Dumping data for table s1873_ffrp.vehicles_sold_pdm: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicles_sold_pdm` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_sold_pdm` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicles_sold_tuner
CREATE TABLE IF NOT EXISTS `vehicles_sold_tuner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `financed` int(11) NOT NULL,
  `commission` int(11) NOT NULL,
  `buy_price` varchar(50) NOT NULL,
  `soldby` varchar(50) DEFAULT NULL,
  `buyer` varchar(50) DEFAULT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.vehicles_sold_tuner: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicles_sold_tuner` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicles_sold_tuner` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicle_categories
CREATE TABLE IF NOT EXISTS `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicle_categories: ~11 rows (approximately)
/*!40000 ALTER TABLE `vehicle_categories` DISABLE KEYS */;
INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
	('compacts', 'Compacts'),
	('coupes', 'Coupes'),
	('importbikes', 'Import Bikes'),
	('importcars', 'Import Cars'),
	('motorcycles', 'Motos'),
	('muscle', 'Muscle'),
	('offroad', 'Off Road'),
	('sedans', 'Sedans'),
	('sports', 'Sports'),
	('suvs', 'SUVs'),
	('vans', 'Vans');
/*!40000 ALTER TABLE `vehicle_categories` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicle_mdt
CREATE TABLE IF NOT EXISTS `vehicle_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `stolen` bit(1) DEFAULT b'0',
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.vehicle_mdt: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_mdt` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_mdt` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicle_parts
CREATE TABLE IF NOT EXISTS `vehicle_parts` (
  `id` int(11) NOT NULL,
  `plate` varchar(100) NOT NULL,
  `parts` longtext NOT NULL,
  `mileage` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.vehicle_parts: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_parts` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_parts` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.vehicle_sold
CREATE TABLE IF NOT EXISTS `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table s1873_ffrp.vehicle_sold: ~0 rows (approximately)
/*!40000 ALTER TABLE `vehicle_sold` DISABLE KEYS */;
/*!40000 ALTER TABLE `vehicle_sold` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.warrants_list
CREATE TABLE IF NOT EXISTS `warrants_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `json_data` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Dumping data for table s1873_ffrp.warrants_list: ~0 rows (approximately)
/*!40000 ALTER TABLE `warrants_list` DISABLE KEYS */;
/*!40000 ALTER TABLE `warrants_list` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.weed
CREATE TABLE IF NOT EXISTS `weed` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `Spot` int(10) NOT NULL,
  `Timer` int(10) NOT NULL,
  `Status` int(10) NOT NULL,
  `Ready` int(10) NOT NULL,
  `Water` int(10) NOT NULL,
  `Fertilizer` int(10) NOT NULL,
  `Quality` int(10) NOT NULL,
  `QualityCounter` int(10) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table s1873_ffrp.weed: ~0 rows (approximately)
/*!40000 ALTER TABLE `weed` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp.weed_plants
CREATE TABLE IF NOT EXISTS `weed_plants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(50) NOT NULL,
  `coords` varchar(255) NOT NULL,
  `strain` varchar(50) NOT NULL,
  `growth` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_weed_plants_id` (`id`),
  KEY `IDX_weed_plants` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=606;

-- Dumping data for table s1873_ffrp.weed_plants: ~0 rows (approximately)
/*!40000 ALTER TABLE `weed_plants` DISABLE KEYS */;
/*!40000 ALTER TABLE `weed_plants` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp._business_logs
CREATE TABLE IF NOT EXISTS `_business_logs` (
  `identifier` varchar(50) NOT NULL DEFAULT '',
  `name` varchar(100) DEFAULT NULL,
  `business` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `log` longtext NOT NULL,
  KEY `identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=3276;

-- Dumping data for table s1873_ffrp._business_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `_business_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `_business_logs` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp._exploiter_logs
CREATE TABLE IF NOT EXISTS `_exploiter_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  `identifier` varchar(255) NOT NULL DEFAULT '',
  `log` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=32768;

-- Dumping data for table s1873_ffrp._exploiter_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `_exploiter_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `_exploiter_logs` ENABLE KEYS */;

-- Dumping structure for table s1873_ffrp._housing_logs
CREATE TABLE IF NOT EXISTS `_housing_logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(255) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `house_name` longtext DEFAULT NULL,
  `log` longtext DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 AVG_ROW_LENGTH=32768;

-- Dumping data for table s1873_ffrp._housing_logs: ~0 rows (approximately)
/*!40000 ALTER TABLE `_housing_logs` DISABLE KEYS */;
/*!40000 ALTER TABLE `_housing_logs` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
