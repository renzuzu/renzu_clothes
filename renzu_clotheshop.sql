ALTER TABLE `users` ADD COLUMN `skin` LONGTEXT NULL DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `renzu_clothes` (
  `identifier` varchar(64) NOT NULL DEFAULT '',
  `wardrobe` longtext NULL,
  `inventory` longtext NULL,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;