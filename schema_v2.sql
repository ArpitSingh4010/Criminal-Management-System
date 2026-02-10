-- Criminal Management System - Enhanced Schema
-- This schema includes User Roles (Admin/User) and all necessary management tables.

CREATE DATABASE IF NOT EXISTS management;
USE management;

-- 1. Users Table (Includes both regular users and admins/officers)
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `email` VARCHAR(100) NOT NULL,
    `age` INT DEFAULT NULL,
    `phone` VARCHAR(15) DEFAULT NULL,
    `role` ENUM('admin', 'user') DEFAULT 'user',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Seed Users (Admin and regular users)
INSERT INTO `users` (`username`, `password`, `email`, `age`, `phone`, `role`) VALUES 
('admin', 'admin123', 'admin@police.gov.in', 45, '9999999999', 'admin'),
('officer1', 'pass123', 'officer1@police.gov.in', 30, '8888888888', 'user'),
('ayush', 'ayush123', 'ayush@example.com', 22, '7777777777', 'user');

-- 2. Officers Table (Police Personnel details)
DROP TABLE IF EXISTS `officers`;
CREATE TABLE `officers` (
    `officer_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `age` INT DEFAULT NULL,
    `designation` VARCHAR(100) DEFAULT NULL,
    `badge_number` VARCHAR(50) UNIQUE DEFAULT NULL,
    `department` VARCHAR(100) DEFAULT NULL,
    `state` VARCHAR(50) DEFAULT NULL,
    `years_of_service` INT DEFAULT NULL,
    PRIMARY KEY (`officer_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Criminals Table
DROP TABLE IF EXISTS `criminal`;
CREATE TABLE `criminal` (
    `Case_id` VARCHAR(45) NOT NULL,
    `Criminal_no` VARCHAR(45) DEFAULT NULL,
    `Criminal_name` VARCHAR(45) NOT NULL,
    `Nick_name` VARCHAR(45) DEFAULT NULL,
    `arrest_date` VARCHAR(45) DEFAULT NULL,
    `dateOfcrime` VARCHAR(45) DEFAULT NULL,
    `address` VARCHAR(100) DEFAULT NULL,
    `age` INT DEFAULT NULL,
    `occupation` VARCHAR(45) DEFAULT NULL,
    `BirthMark` VARCHAR(100) DEFAULT NULL,
    `crimeType` VARCHAR(45) DEFAULT NULL,
    `fatherName` VARCHAR(45) DEFAULT NULL,
    `gender` ENUM('male', 'female', 'other') DEFAULT 'male',
    `wanted` ENUM('yes', 'no') DEFAULT 'no',
    PRIMARY KEY (`Case_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Laws Table
DROP TABLE IF EXISTS `laws`;
CREATE TABLE `laws` (
    `law_id` INT NOT NULL AUTO_INCREMENT,
    `section` VARCHAR(50) NOT NULL,
    `title` VARCHAR(255) NOT NULL,
    `description` TEXT,
    `act_name` VARCHAR(100) DEFAULT 'Indian Penal Code',
    `offense_type` VARCHAR(50) DEFAULT NULL,
    `punishment` VARCHAR(255) DEFAULT NULL,
    `bailable` VARCHAR(10) DEFAULT NULL,
    `cognizable` VARCHAR(10) DEFAULT NULL,
    PRIMARY KEY (`law_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Reports Table
DROP TABLE IF EXISTS `reports`;
CREATE TABLE `reports` (
    `report_id` INT NOT NULL AUTO_INCREMENT,
    `report_type` VARCHAR(100) DEFAULT NULL,
    `report_title` VARCHAR(255) DEFAULT NULL,
    `description` TEXT,
    `generated_date` DATE DEFAULT (CURRENT_DATE),
    `generated_by` VARCHAR(100) DEFAULT NULL,
    `total_records` INT DEFAULT NULL,
    `status` VARCHAR(50) DEFAULT 'Pending',
    PRIMARY KEY (`report_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Case Types (Lookup table)
DROP TABLE IF EXISTS `case_types`;
CREATE TABLE `case_types` (
    `type_id` INT NOT NULL AUTO_INCREMENT,
    `case_type` VARCHAR(50) NOT NULL,
    `description` TEXT,
    `ipc_section` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Adding some initial data for testing Admin functions
INSERT INTO `officers` (`name`, `age`, `designation`, `badge_number`, `department`, `state`, `years_of_service`) 
VALUES ('Rajesh Kumar Sharma', 52, 'DGP', 'DGP001', 'State Police', 'Maharashtra', 30);

INSERT INTO `criminal` (`Case_id`, `Criminal_no`, `Criminal_name`, `age`, `crimeType`, `wanted`) 
VALUES ('CASE001', 'CR001', 'Vikram Singh', 28, 'Robbery', 'yes');

INSERT INTO `laws` (`section`, `title`, `description`, `punishment`) 
VALUES ('Section 302', 'Murder', 'Intentional killing of another person', 'Death or Life Imprisonment');

INSERT INTO `reports` (`report_type`, `report_title`, `description`, `generated_by`) 
VALUES ('Monthly Stats', 'Jan 2026 Crime Report', 'Summary of all cases in January', 'admin');
