-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema lesson1
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema lesson1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `lesson1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `lesson1` ;

-- -----------------------------------------------------
-- Table `lesson1`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lesson1`.`country` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'идентификатор страны',
  `name` TEXT NOT NULL COMMENT 'наименование страны',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'страна';


-- -----------------------------------------------------
-- Table `lesson1`.`area`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lesson1`.`area` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'идентификатор области',
  `country_id` INT NOT NULL COMMENT 'ссылка на  индентификатор страны',
  `name` TEXT NOT NULL COMMENT 'наименование области',
  PRIMARY KEY (`id`),
  INDEX `area_country_fk_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `area_country_fk`
    FOREIGN KEY (`country_id`)
    REFERENCES `lesson1`.`country` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'область';


-- -----------------------------------------------------
-- Table `lesson1`.`city_type`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lesson1`.`city_type` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'идентификатор типа города',
  `name` TEXT NOT NULL COMMENT 'наименование типа города',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'тип города';


-- -----------------------------------------------------
-- Table `lesson1`.`district`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lesson1`.`district` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'идентификатор области',
  `area_id` INT NOT NULL COMMENT 'ссылка на идентификатор области',
  `name` TEXT NOT NULL COMMENT 'наименование района',
  PRIMARY KEY (`id`),
  INDEX `district_area_fk_idx` (`area_id` ASC) VISIBLE,
  CONSTRAINT `district_area_fk`
    FOREIGN KEY (`area_id`)
    REFERENCES `lesson1`.`area` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'район';


-- -----------------------------------------------------
-- Table `lesson1`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `lesson1`.`city` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'идентификатор города',
  `area_id` INT NOT NULL COMMENT 'ссылка на идентификатор области',
  `district_id` INT NULL DEFAULT NULL COMMENT 'ссылка на идентификатор района (может не быть)',
  `city_type_id` INT NOT NULL COMMENT 'ссылка на идентификатор типа города',
  `name` TEXT NOT NULL COMMENT 'наименование города',
  PRIMARY KEY (`id`),
  INDEX `city_area_fk_idx` (`area_id` ASC) VISIBLE,
  INDEX `city_district_fk_idx` (`district_id` ASC) VISIBLE,
  INDEX `city_city_type_fk_idx` (`city_type_id` ASC) VISIBLE,
  CONSTRAINT `city_area_fk`
    FOREIGN KEY (`area_id`)
    REFERENCES `lesson1`.`area` (`id`),
  CONSTRAINT `city_city_type_fk`
    FOREIGN KEY (`city_type_id`)
    REFERENCES `lesson1`.`city_type` (`id`),
  CONSTRAINT `city_district_fk`
    FOREIGN KEY (`district_id`)
    REFERENCES `lesson1`.`district` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci
COMMENT = 'город';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
