-- получившиеся скрипты создания таблиц
-- города
CREATE TABLE `_countries` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cointry_title_idx` (`title`) /*!80000 INVISIBLE */
) ENGINE=InnoDB AUTO_INCREMENT=236 DEFAULT CHARSET=utf8;

-- регионы
CREATE TABLE `_regions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_id` int NOT NULL,
  `title` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `region_country_FK_idx` (`country_id`),
  KEY `region_title_idx` (`title`) /*!80000 INVISIBLE */,
  CONSTRAINT `region_country_FK` FOREIGN KEY (`country_id`) REFERENCES `_countries` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5468685 DEFAULT CHARSET=utf8;

-- города
CREATE TABLE `_cities` (
  `id` int NOT NULL AUTO_INCREMENT,
  `country_id` int NOT NULL,
  `important` tinyint(1) NOT NULL,
  `region_id` int DEFAULT NULL,
  `title` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `city_region_FK_idx` (`region_id`),
  KEY `city_country_FK_idx` (`country_id`),
  KEY `city_title_idx` (`title`) /*!80000 INVISIBLE */,
  CONSTRAINT `city_country_FK` FOREIGN KEY (`country_id`) REFERENCES `_countries` (`id`),
  CONSTRAINT `city_region_FK` FOREIGN KEY (`region_id`) REFERENCES `_regions` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5469360 DEFAULT CHARSET=utf8;
