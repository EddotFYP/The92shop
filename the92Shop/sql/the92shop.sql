-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 08, 2018 at 02:27 PM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `the92shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `Name` varchar(50) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Phone_number` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `Postal_Code` varchar(30) NOT NULL,
  PRIMARY KEY (`Phone_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Name`, `Gender`, `Phone_number`, `Address`, `Postal_Code`) VALUES
('Tom', 'M', '89093271', 'Bishan St Blk 7 #14-232', '123222'),
('Alexandra', 'F', '89093272', 'Tampines St Blk 12 #14-00', '123425'),
('Clara', 'F', '85476531', 'Bishan St Blk 2 #13-323', '123123'),
('Amelia Tan', 'F', '85876531', '28 Jalan Datoh #26-07', '329536'),
('Monste Lee', 'M', '97478731', 'Balestier Rd Blk 89 #13-323', '234871'),
('Esmerinda Chong', 'F', '87776532', 'Ang Mo Kio St Blk 15 #17-30', '546123'),
('Simpson Ang', 'M', '85400431', '13 Jalan Bahagia #01-02', '333123'),
('Brendon Lee', 'M', '98706531', 'Tampines St Blk 45 #10-123', '324581'),
('Ciara Seet', 'F', '93386198', 'Bishan St Blk 2 #13-323', '320913'),
('Michael Kans', 'M', '93386189', '700 Toa Payoh Lor 1 #11-02', '329773'),
('Michelle Lim', 'F', '93456189', '60 Toa Payoh Blk 3 #12-90', '329774'),
('Alex Goh', 'M', '87386189', 'Clementi Avenue 5 Blk 103 #103-70', '329773'),
('Havana Ohnana', 'F', '91807177', '67 Lorong Chuan #26-02', '329743');

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `SKU_Id` int(30) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Updated_Date` varchar(50) NOT NULL,
  `Cost_Price` decimal(12,2) NOT NULL,
  `Selling_Price` decimal(12,2) NOT NULL,
   PRIMARY KEY(`SKU_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`SKU_Id`, `Name`, `Quantity`, `Updated_Date`, `Cost_Price`, `Selling_Price`) VALUES
(1, 'The Shell (Blue)', 1, '2017-12-28', '29.90', '31.90'),
(2, 'Plain green socks', 412, '2017-07-11', '5.00', '7.60'),
(3, 'Plain black socks', 308, '2017-07-11', '5.00', '7.60'),
(4, 'Plain white socks', 205, '2017-07-12', '5.50', '7.90'),
(5, 'Plain grey socks', 200, '2017-07-11', '7.50', '9.50'),
(6, 'Little Animal Ankle B', 8, '2017-07-11', '7.50', '9.50'),
(7, 'Candie Socks', 14, '2017-07-13', '5.00', '7.60'),
(8, 'Pig Socks', 4, '2017-01-03', '2.40', '4.90'),
(9, 'White T-shirt with red polka dots', 31, '2017-07-15', '10.50', '14.50'),
(10, 'Plain purple thick socks', 200, '2017-07-11', '7.50', '9.50'),
(11, 'Two-toned red thick socks', 310, '2017-07-12', '7.50', '9.50'),
(12, 'White grey striped T-shirt', 31, '2017-07-16', '11.50', '14.00');

-- --------------------------------------------------------
--
-- Table structure for table `customer_purchase`
--

CREATE TABLE IF NOT EXISTS `customer_purchase` (
  `Phone_number` varchar(10) NOT NULL,
  `SKU_Id` int(30) NOT NULL,
  `Date_Of_Purchase` date NOT NULL,
  `Quantity` int(11) NOT NULL,
  PRIMARY KEY (`Phone_number`,`SKU_Id`,`Date_Of_Purchase`),
  FOREIGN KEY (`Phone_number`) REFERENCES `customer`(`Phone_number`),
  FOREIGN KEY (`SKU_Id`) REFERENCES `inventory`(`SKU_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_purchase`
--

INSERT INTO `customer_purchase` (`Phone_number`, `SKU_Id`, `Date_Of_Purchase`, `Quantity`) VALUES
('89093271', '1', '2016-01-18', 10),
('89093272', '1', '2016-03-18', 20),
('85476531', '2', '2017-06-03', 11),
('85476531', '3', '2017-08-03', 15),
('85876531', '4', '2017-07-03', 7),
('85876531', '2', '2016-02-18', 11),
('85876531', '5', '2017-07-11', 12),
('97478731', '1', '2017-04-18', 16),
('97478731', '2', '2017-04-18', 15),
('97478731', '7', '2017-02-18', 9),
('87776532', '4', '2016-05-01', 15),
('85400431', '5', '2016-06-18', 20),
('85400431', '10', '2017-01-11', 12),
('85400431', '8', '2016-04-15', 13),
('91807177', '2', '2017-02-13', 8),
('91807177', '9', '2016-07-10', 6);

-- --------------------------------------------------------

--
-- Table structure for table `expensetracker`
--

CREATE TABLE IF NOT EXISTS `expensetracker` (
  `date` varchar(45) DEFAULT NULL,
  `expenseTypes` varchar(45) NOT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `cost` double(45,0) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `expensetracker`
--

INSERT INTO `expensetracker` (`date`, `expenseTypes`, `remark`, `cost`) VALUES
('2018-01-30', 'Delivery', 'Delivery is based on location ', 11),
('2018-01-31', 'Postage', 'What', 14),
('2018-02-02', 'Parking', 'SxSWERTYUIOIUYTRD', 87),
('2017-07-12', 'Driving', 'West side : $50\r\nClementi , Jurong and Chinese Garden \r\nReach by 10pm', 50),
('2017-07-12', 'Parking', 'Fine for illegal parking', 20),
('2017-07-01', 'Driving', 'Driving to the EAST', 45),
('2016-01-01', 'Delivery', 'Based on location', 12),
('2016-02-01', 'Delivery', 'Based on location', 12);

-- --------------------------------------------------------

--
-- Table structure for table `expensetypes`
--

CREATE TABLE IF NOT EXISTS `expensetypes` (
  `ExpenseType` varchar(100) NOT NULL,
  PRIMARY KEY (`ExpenseType`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `expensetypes`
--

INSERT INTO `expensetypes` (`ExpenseType`) VALUES
('Bank Charges'),
('Insurance'),
('Parking'),
('Phone fees'),
('Postage'),
('Rent'),
('Repairs and Maintenance '),
('Self-Employment Taxes'),
('Staff Remunerations'),
('Stock'),
('Supplies'),
('Taxes'),
('Travel'),
('Utilities'),
('Wages');

-- --------------------------------------------------------



--
-- Table structure for table `inventory_purchase`
--

CREATE TABLE IF NOT EXISTS `inventory_purchase` (
  `SKU_Id` int(30) NOT NULL,
  `Date_Of_Purchase` date NOT NULL,
  `Quantity` int(11) NOT NULL,
 FOREIGN KEY (`SKU_Id`) REFERENCES `inventory`(`SKU_Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory_purchase`
--

INSERT INTO `inventory_purchase` (`SKU_Id`, `Date_Of_Purchase`, `Quantity`) VALUES
('1', '2017-07-18', 10),
('1', '2017-07-18', 5),
('2', '2017-07-18', 2),
('2', '2017-07-18', 10),
('2', '2017-07-18', 15),
('3', '2017-06-18', 10),
('4', '2017-08-18', 2),
('5', '2017-01-18', 1),
('5', '2017-02-18', 1),
('5', '2017-03-18', 1),
('5', '2017-04-18', 1),
('6', '2017-05-18', 1),
('7', '2016-01-01', 2),
('7', '2016-03-01', 1),
('7', '2016-02-01', 1),
('8', '2016-04-01', 1),
('9', '2016-05-01', 1),
('9', '2016-06-01', 1),
('10', '2016-07-01', 1),
('10', '2016-08-01', 1),
('10', '2016-09-01', 1),
('11', '2016-10-01', 1),
('12', '2016-11-01', 1),
('12', '2016-12-01', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `Name` varchar(30) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY(`Name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Name`, `Password`) VALUES
('qingyang', 'the92shop');



/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
