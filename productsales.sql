-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 24, 2022 at 05:40 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `productsales`
--

-- --------------------------------------------------------

--
-- Table structure for table `billing`
--

CREATE TABLE `billing` (
  `BillingID` varchar(255) DEFAULT NULL,
  `BillingDateTime` varchar(255) DEFAULT NULL,
  `BillingTaxNum` int DEFAULT NULL,
  `Items` int DEFAULT NULL,
  `BillingAmount` int DEFAULT NULL,
  `SellingAmount` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`BillingID`, `BillingDateTime`, `BillingTaxNum`, `Items`, `BillingAmount`,`SellingAmount`) VALUES
('00003', '2022-01-24 20:59:43.174864', 12195079, 3, 256,324);

-- --------------------------------------------------------



--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` varchar(255) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productCost` int(11) NOT NULL,
  `productInStock` int(11) NOT NULL,
  `sellingPrice` int(11) NOT NULL,
  `discount` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `productName`, `productCost`, `productInStock`, `sellingPrice`, `discount`) VALUES
('P100', 'Milk', 20, 100, 0, 0),
('P101', 'Apple', 5, 8, 10, 5),
('P102', 'Mango', 12, 15, 10, 5);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

