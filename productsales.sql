-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 06, 2022 at 03:15 PM
-- Server version: 8.0.26
-- PHP Version: 8.0.13

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
  `BillingDateTime` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `BillingTaxNum` int DEFAULT NULL,
  `Items` int DEFAULT NULL,
  `SellingAmount` int DEFAULT NULL,
  `PurchaseAmount` int DEFAULT NULL,
  `Discount` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `billing`
--

INSERT INTO `billing` (`BillingID`, `BillingDateTime`, `BillingTaxNum`, `Items`, `SellingAmount`, `PurchaseAmount`, `Discount`) VALUES
('B00001', '2022-01-31 15:24:43', 3728426, 0, 0, 0, 1),
('B00002', '2022-01-31 15:24:43', 493942827, 0, 0, 0, 1),
('B00003', '2022-01-31 15:24:43', 434433026, 0, 0, 0, 1),
('B00004', '2022-01-31 15:24:43', 392462837, 0, 0, 0, 1),
('B00005', '2022-01-31 15:24:43', 473510334, 0, 0, 0, 1),
('B00005', '2022-01-31 15:24:43', 292326348, 0, 0, 0, 1),
('B00006', '2022-01-31 15:29:04', 33226712, 0, 0, 0, 1),
('B00007', '2022-01-31 15:29:04', 474250253, 0, 0, 0, 1),
('B00008', '2022-01-31 15:31:43', 93382825, 0, 0, 0, 1),
('B00009', '2022-01-31 15:31:43', 118124834, 0, 0, 0, 1),
('B00010', '2022-01-31 15:39:50', 38202962, 0, 0, 0, 1),
('B00011', '2022-01-31 15:41:35', 848103211, 2, 29, 70, 1),
('B00012', '2022-01-31 16:13:42', 613184340, 2, 29, 70, 1),
('B00013', '2022-01-31 18:02:37', 34344287, 2, 29, 70, 1),
('B00014', '2022-01-31 18:02:37', 222629303, 0, 0, 0, 1),
('B00015', '2022-01-31 18:21:35', 1045282532, 0, 0, 0, 1),
('B00016', '2022-01-31 18:21:35', 44037344, 0, 0, 0, 1),
('B00017', '2022-01-31 21:11:12', 191084729, 1, 10, 5, 1),
('B00018', '2022-01-31 22:18:40', 128494024, 0, 0, 0, 1),
('B00019', '2022-01-31 22:18:40', 725222331, 2, 10, 32, 1),
('B00020', '2022-01-31 23:14:17', 312848311, 1, 50, 20, 1),
('B00021', '2022-01-31 23:25:01', 1118482627, 1, 0, 20, 1),
('B00022', '2022-02-01 15:08:32', 818224227, 1, 10, 5, 1),
('B00023', '2022-02-01 15:33:56', 26336534, 1, 10, 5, 1),
('B00024', '2022-02-01 15:51:10', 463395041, 1, 10, 5, 1),
('B00025', '2022-02-01 15:51:10', 734311425, 1, 50, 20, 1),
('B00026', '2022-02-01 15:51:10', 7344825, 2, 59, 25, 1),
('B00027', '2022-02-01 16:30:21', 63942224, 3, 19, 1252, 1),
('B00028', '2022-02-01 16:30:21', 432142331, 1, 10, 5, 1),
('B00029', '2022-02-01 16:30:21', 403438465, 1, 10, 12, 1),
('B00030', '2022-02-01 17:40:13', 1537301226, 1, 19, 1212, 1),
('B00031', '2022-02-01 17:40:13', 41739255, 1, 19, 55, 1),
('B00032', '2022-02-01 17:40:13', 333711836, 1, 19, 55, 1),
('B00033', '2022-02-01 17:47:16', 1323281418, 1, 19, 10, 1),
('B00034', '2022-02-03 22:32:13', 433093644, 3, 38, 34, 1),
('B00035', '2022-02-05 16:20:44', 331021189, 1, 19, 24, 1),
('B00036', '2022-02-05 16:37:20', 9844026, 1, 99, 50, 1),
('B00037', '2022-02-05 16:37:20', 549342823, 1, 99, 50, 1),
('B00038', '2022-02-05 16:37:20', 13242410, 1, 99, 50, 1),
('B00039', '2022-02-05 16:37:20', 393230644, 1, 49, 50, 1),
('B00040', '2022-02-06 18:39:51', 202725491, 2, 98, 100, 1),
('B00041', '2022-02-06 18:39:51', 321351138, 2, 98, 100, 1),
('B00042', '2022-02-06 19:40:30', 30416834, 1, 10, 200, 1);

-- --------------------------------------------------------

--
-- Table structure for table `billingsecond`
--

CREATE TABLE `billingsecond` (
  `BillingID` varchar(255) DEFAULT NULL,
  `BillingDateTime` varchar(255) DEFAULT NULL,
  `BillingTaxNum` int DEFAULT NULL,
  `Items` int DEFAULT NULL,
  `SellingAmount` int DEFAULT NULL,
  `PurchaseAmount` int DEFAULT NULL,
  `Discount` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `billingsecond`
--

INSERT INTO `billingsecond` (`BillingID`, `BillingDateTime`, `BillingTaxNum`, `Items`, `SellingAmount`, `PurchaseAmount`, `Discount`) VALUES
('00002', '2022-01-25 13:34:14.738665', 421342843, 3, 256, 256, 1),
('00004', '2022-01-25 13:34:14.738665', 421262846, 3, 256, 256, 1);

-- --------------------------------------------------------

--
-- Table structure for table `billing_cart`
--

CREATE TABLE `billing_cart` (
  `id` int NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `quantity` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int NOT NULL,
  `product_id` varchar(255) NOT NULL,
  `notification_message` varchar(255) DEFAULT NULL,
  `notification_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `notifications`
--

INSERT INTO `notifications` (`id`, `product_id`, `notification_message`, `notification_date`) VALUES
(16, 'P102', 'Stock is less than 10', '2022-02-05'),
(17, 'P102', 'Stock is less than 10', '2022-02-05'),
(18, 'P102', 'Stock is less than 10', '2022-02-05'),
(19, 'P102', 'Stock is less than 10', '2022-02-06');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `productId` varchar(255) NOT NULL,
  `productName` varchar(255) NOT NULL,
  `productCost` int NOT NULL,
  `productInStock` int NOT NULL,
  `sellingPrice` int NOT NULL,
  `discount` int DEFAULT NULL,
  `expiry_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isPerishAble` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`productId`, `productName`, `productCost`, `productInStock`, `sellingPrice`, `discount`, `expiry_date`, `isPerishAble`) VALUES
('P100', 'Milk', 20, 50, 28, 0, '2022-02-03 00:00:00', 1),
('P101', 'Oranges', 50, 58, 100, 1, '2022-02-19 00:00:00', 1),
('P102', 'Apples', 50, 0, 100, 1, '2022-02-14 00:00:00', 1),
('P103', 'Grapes', 50, 53, 50, 2, '2022-02-04 00:00:00', 1),
('P104', 'Dragon Fruit', 200, 499, 10, 1, '2022-02-19 00:00:00', 1);

--
-- Triggers `products`
--
DELIMITER $$
CREATE TRIGGER `after_products_greater_than_10` AFTER UPDATE ON `products` FOR EACH ROW IF NEW.productInStock >= 10 THEN 
DELETE FROM notifications WHERE product_id = NEW.productId; 
END IF
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_products_less_than_10` AFTER UPDATE ON `products` FOR EACH ROW IF NEW.productInStock < 10 THEN 
INSERT INTO notifications VALUES(null, NEW.productId, 'Stock is less than 10', NOW());
END IF
$$
DELIMITER ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `billing_cart`
--
ALTER TABLE `billing_cart`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `billing_cart`
--
ALTER TABLE `billing_cart`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
