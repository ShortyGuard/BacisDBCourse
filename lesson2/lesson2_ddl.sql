use geodata;

-- сперва удалим лишние столбцы
-- удалим лишние столюцы на таблице стран
ALTER TABLE `geodata`.`_countries` 
DROP COLUMN `title_cz`,
DROP COLUMN `title_lv`,
DROP COLUMN `title_lt`,
DROP COLUMN `title_ja`,
DROP COLUMN `title_pl`,
DROP COLUMN `title_it`,
DROP COLUMN `title_fr`,
DROP COLUMN `title_de`,
DROP COLUMN `title_pt`,
DROP COLUMN `title_es`,
DROP COLUMN `title_en`,
DROP COLUMN `title_be`,
DROP COLUMN `title_ua`;

-- удалим лишние столюцы на таблице регионов
ALTER TABLE `geodata`.`_regions` 
DROP COLUMN `title_cz`,
DROP COLUMN `title_lv`,
DROP COLUMN `title_lt`,
DROP COLUMN `title_ja`,
DROP COLUMN `title_pl`,
DROP COLUMN `title_it`,
DROP COLUMN `title_fr`,
DROP COLUMN `title_de`,
DROP COLUMN `title_pt`,
DROP COLUMN `title_es`,
DROP COLUMN `title_en`,
DROP COLUMN `title_be`,
DROP COLUMN `title_ua`;

-- удалим лишние столюцы на таблице стран
ALTER TABLE `geodata`.`_cities` 
DROP COLUMN `region_cz`,
DROP COLUMN `area_cz`,
DROP COLUMN `title_cz`,
DROP COLUMN `region_lv`,
DROP COLUMN `area_lv`,
DROP COLUMN `title_lv`,
DROP COLUMN `region_lt`,
DROP COLUMN `area_lt`,
DROP COLUMN `title_lt`,
DROP COLUMN `region_ja`,
DROP COLUMN `area_ja`,
DROP COLUMN `title_ja`,
DROP COLUMN `region_pl`,
DROP COLUMN `area_pl`,
DROP COLUMN `title_pl`,
DROP COLUMN `region_it`,
DROP COLUMN `area_it`,
DROP COLUMN `title_it`,
DROP COLUMN `region_fr`,
DROP COLUMN `area_fr`,
DROP COLUMN `title_fr`,
DROP COLUMN `region_de`,
DROP COLUMN `area_de`,
DROP COLUMN `title_de`,
DROP COLUMN `region_pt`,
DROP COLUMN `area_pt`,
DROP COLUMN `title_pt`,
DROP COLUMN `region_es`,
DROP COLUMN `area_es`,
DROP COLUMN `title_es`,
DROP COLUMN `region_en`,
DROP COLUMN `area_en`,
DROP COLUMN `title_en`,
DROP COLUMN `region_be`,
DROP COLUMN `area_be`,
DROP COLUMN `title_be`,
DROP COLUMN `region_ua`,
DROP COLUMN `area_ua`,
DROP COLUMN `title_ua`,
DROP COLUMN `region_ru`,
DROP COLUMN `area_ru`;

-- теперь переименуем столбцы (на уроке усвоено, что в продакш лучше такого не делать, но это же практика, поэтому практикуемся)
-- и сразу поправим типы данных и констрайнты, а так же определим первичные ключи
ALTER TABLE `geodata`.`_countries` 
CHANGE COLUMN `country_id` `id` INT NOT NULL AUTO_INCREMENT , -- переименовали и добавили not null и AI
CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL , -- переименовали расширили тип до 150 и добавили not null
ADD PRIMARY KEY (`id`); -- добавили PK

ALTER TABLE `geodata`.`_regions` 
CHANGE COLUMN `region_id` `id` INT NOT NULL AUTO_INCREMENT , -- переименовали и добавили not null и AI
CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL , -- переименовали и добавили not null
ADD PRIMARY KEY (`id`); -- добавили PK

-- на region_id не ставим NOT NULL т.к. таблица имеет записи с region_id is null, а в условиях задачи ничего о том что делать с этими записями
ALTER TABLE `geodata`.`_cities` 
CHANGE COLUMN `city_id` `id` INT NOT NULL AUTO_INCREMENT , -- переименовали и добавили not null и AI
CHANGE COLUMN `title_ru` `title` VARCHAR(150) NOT NULL , -- переименовали и добавили not null
ADD PRIMARY KEY (`id`); -- добавили PK

-- теперь добавим foreign keys для связи "городов с регионами и странами" и "регионов со странами"
-- связь "регионов со странами"
ALTER TABLE `geodata`.`_regions` 
ADD INDEX `region_country_FK_idx` (`country_id` ASC) VISIBLE; -- добавим индекс для FK
ALTER TABLE `geodata`.`_regions`  -- добавим сам ключ
ADD CONSTRAINT `region_country_FK`
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

  
-- связь "городов с регионами и странами"
ALTER TABLE `geodata`.`_cities` 
ADD INDEX `city_region_FK_idx` (`region_id` ASC) VISIBLE, -- добавим индекс для FK с регионом
ADD INDEX `city_country_FK_idx` (`country_id` ASC) VISIBLE; -- добавим индекс для FK со страной
ALTER TABLE `geodata`.`_cities` -- добавмим FK до регионов
ADD CONSTRAINT `city_region_FK`
  FOREIGN KEY (`region_id`)
  REFERENCES `geodata`.`_regions` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `city_country_FK` -- добавим ключ до стран
  FOREIGN KEY (`country_id`)
  REFERENCES `geodata`.`_countries` (`id`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

--  теперь добавим индексы для названий
ALTER TABLE `geodata`.`_countries` 
ADD INDEX `cointry_title_idx` (`title` ASC) INVISIBLE;

ALTER TABLE `geodata`.`_regions` 
ADD INDEX `region_title_idx` (`title` ASC) INVISIBLE;

ALTER TABLE `geodata`.`_cities` 
ADD INDEX `city_title_idx` (`title` ASC) INVISIBLE;
