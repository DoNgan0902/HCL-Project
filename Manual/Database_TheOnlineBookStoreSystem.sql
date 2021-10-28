-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema project_hcl
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema project_hcl
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `project_hcl` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `project_hcl` ;

-- -----------------------------------------------------
-- Table `project_hcl`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`admin` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(90) NOT NULL,
  `password` VARCHAR(90) NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username` (`username` ASC) ,
  UNIQUE INDEX `username_2` (`username` ASC) )

-- -----------------------------------------------------
-- Table `project_hcl`.`boardnew`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`boardnew` (
  `boardnew_id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(90) NOT NULL,
  `content` LONGTEXT NULL DEFAULT NULL,
  `image_link` VARCHAR(255) NOT NULL,
  `author` VARCHAR(60) NOT NULL DEFAULT 'Anonymouse',
  `created` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`boardnew_id`))




-- -----------------------------------------------------
-- Table `project_hcl`.`catalog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`catalog` (
  `catalog_id` INT NOT NULL,
  `name` VARCHAR(90) NOT NULL,
  `parent_id` INT NULL DEFAULT '10',
  PRIMARY KEY (`catalog_id`))



-- -----------------------------------------------------
-- Table `project_hcl`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`product` (
  `product_id` INT NOT NULL,
  `catalog_id` INT NOT NULL,
  `name` VARCHAR(90) NOT NULL DEFAULT 'Empty',
  `price` DOUBLE NOT NULL,
  `status` VARCHAR(20) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `discount` INT NULL DEFAULT NULL,
  `image_link` VARCHAR(255) NOT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT '0',
  `author` VARCHAR(255) NULL DEFAULT 'Anonymous',
  PRIMARY KEY (`product_id`),
  INDEX `catalog_catalog_id_fk` (`catalog_id` ASC) ,
  CONSTRAINT `catalog_catalog_id_fk`
    FOREIGN KEY (`catalog_id`)
    REFERENCES `project_hcl`.`catalog` (`catalog_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)



-- -----------------------------------------------------
-- Table `project_hcl`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`user` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(90) NOT NULL DEFAULT 'Book',
  `email` VARCHAR(90) NOT NULL,
  `phone` VARCHAR(20) NOT NULL,
  `dob` VARCHAR(10) NOT NULL,
  `address` VARCHAR(90) NOT NULL,
  `created` TIMESTAMP NOT NULL,
  `password` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE INDEX `email` (`email` ASC) )



-- -----------------------------------------------------
-- Table `project_hcl`.`cart`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`cart` (
  `cart_id` INT NOT NULL AUTO_INCREMENT,
  `quantity` INT NULL DEFAULT NULL,
  `user_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `status` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`cart_id`),
  INDEX `fk_cart_user_idx` (`user_id` ASC) ,
  INDEX `fk_cart_product1_idx` (`product_id` ASC) ,
  CONSTRAINT `fk_cart_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `project_hcl`.`product` (`product_id`)
    ON DELETE CASCADE,
  CONSTRAINT `fk_cart_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `project_hcl`.`user` (`user_id`)
    ON DELETE CASCADE)



-- -----------------------------------------------------
-- Table `project_hcl`.`transactions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`transactions` (
  `transaction_id` INT NOT NULL AUTO_INCREMENT,
  `user_id` INT NOT NULL,
  `message` VARCHAR(90) NULL DEFAULT 'nothing!',
  `payment` DOUBLE NOT NULL,
  `status` VARCHAR(90) NOT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  INDEX `user_user_id_fk` (`user_id` ASC) ,
  CONSTRAINT `user_user_id_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `project_hcl`.`user` (`user_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)



-- -----------------------------------------------------
-- Table `project_hcl`.`ordered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`ordered` (
  `ordered_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `transaction_id` INT NOT NULL,
  `amount` INT NULL DEFAULT NULL,
  PRIMARY KEY (`ordered_id`),
  INDEX `product_product_id_fk` (`product_id` ASC) ,
  INDEX `transactions_transaction_id_fk` (`transaction_id` ASC) ,
  CONSTRAINT `product_product_id_fk`
    FOREIGN KEY (`product_id`)
    REFERENCES `project_hcl`.`product` (`product_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `transactions_transaction_id_fk`
    FOREIGN KEY (`transaction_id`)
    REFERENCES `project_hcl`.`transactions` (`transaction_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)



-- -----------------------------------------------------
-- Table `project_hcl`.`review`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `project_hcl`.`review` (
  `review_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `name` VARCHAR(90) NOT NULL,
  `email` VARCHAR(90) NOT NULL,
  `content` TINYTEXT NULL DEFAULT NULL,
  `created` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`review_id`),
  INDEX `product_product_id` (`product_id` ASC) ,
  CONSTRAINT `product_product_id`
    FOREIGN KEY (`product_id`)
    REFERENCES `project_hcl`.`product` (`product_id`))


