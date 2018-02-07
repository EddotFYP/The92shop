-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Feb 07, 2018 at 02:22 PM
-- Server version: 5.7.11
-- PHP Version: 5.6.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `the92shop`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `Cust_Id` int(10) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Gender` varchar(10) NOT NULL,
  `Birthdate` date NOT NULL,
  `Phone_number` varchar(10) NOT NULL,
  `Address` varchar(100) NOT NULL,
  `Postal_Code` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Cust_Id`, `Name`, `Gender`, `Birthdate`, `Phone_number`, `Address`, `Postal_Code`) VALUES
(1, 'Tom', 'M', '2000-07-11', '89093272', 'Bishan St Blk 7 #14-232', '123222'),
(2, 'Alexandra', 'F', '2001-07-11', '82093272', 'Tampines St Blk 12 #14-00', '123425'),
(3, 'Clara', 'F', '1995-01-01', '85476531', 'Bishan St Blk 2 #13-323', '123123'),
(4, 'Amelia Tan', 'F', '1997-04-03', '85876531', '28 Jalan Datoh #26-07', '329536'),
(5, 'Monste Lee', 'M', '1998-12-13', '97478731', 'Balestier Rd Blk 89 #13-323', '234871'),
(6, 'Esmerinda Chong', 'F', '2001-05-02', '87776531', 'Ang Mo Kio St Blk 15 #17-30', '546123'),
(7, 'Simpson Ang', 'M', '1992-06-11', '85400431', '13 Jalan Bahagia #01-02', '333123'),
(8, 'Brendon Lee', 'M', '1994-11-10', '98706531', 'Tampines St Blk 45 #10-123', '324581'),
(9, 'Ciara Seet', 'F', '1995-01-04', '93386198', 'Bishan St Blk 2 #13-323', '320913'),
(10, 'Michael Kans', 'M', '1993-08-23', '93386189', '700 Toa Payoh Lor 1 #11-02', '329773'),
(11, 'Michelle Lim', 'F', '1995-08-23', '93456189', '60 Toa Payoh Blk 3 #12-90', '329774'),
(12, 'Alex Goh', 'M', '1998-11-23', '87386189', 'Clementi Avenue 5 Blk 103 #103-70', '329773'),
(13, 'Havana Ohnana', 'F', '1987-11-20', '87546189', '67 Lorong Chuan #26-02', '329743');

-- --------------------------------------------------------

--
-- Table structure for table `customer_purchase`
--

CREATE TABLE `customer_purchase` (
  `Phone_number` varchar(10) NOT NULL,
  `SKU_Id` varchar(30) NOT NULL,
  `Date_Of_Purchase` date NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer_purchase`
--

INSERT INTO `customer_purchase` (`Phone_number`, `SKU_Id`, `Date_Of_Purchase`, `Quantity`) VALUES
('82093272', 'SK0001', '2016-01-18', 10),
('82093272', 'SK0003', '2016-03-18', 20),
('87776532', 'SK0003', '2017-06-03', 11),
('87776532', 'SK0004', '2017-07-03', 7),
('87776532', 'SK0004', '2017-08-03', 15),
('89093272', 'SK0005', '2016-02-18', 11),
('91807177', 'SK0001', '2017-07-11', 12),
('93386189', 'SK0001', '2017-04-18', 16),
('93386189', 'SK0002', '2017-04-18', 15),
('93386189', 'SK0003', '2017-02-18', 9),
('93386189', 'SK0005', '2016-05-01', 15),
('93386198', 'TSK0001', '2016-06-18', 20),
('98997679', 'SK0004', '2016-04-15', 13),
('98997679', 'TSK0001', '2017-01-11', 12),
('98997679', 'TSK0002', '2017-02-13', 8),
('99879064', 'SK0004', '2016-02-10', 6);

-- --------------------------------------------------------

--
-- Table structure for table `expensetracker`
--

CREATE TABLE `expensetracker` (
  `date` date DEFAULT NULL,
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
('2017-07-01', 'Driving', 'Driving to the EAST', 45);

-- --------------------------------------------------------

--
-- Table structure for table `expensetypes`
--

CREATE TABLE `expensetypes` (
  `ExpenseType` varchar(100) NOT NULL
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
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `SKU_Id` int(10) NOT NULL,
  `Name` varchar(50) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Updated_Date` varchar(50) NOT NULL,
  `Cost_Price` decimal(12,2) NOT NULL,
  `Selling_Price` decimal(12,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`SKU_Id`, `Name`, `Quantity`, `Updated_Date`, `Cost_Price`, `Selling_Price`) VALUES
('1', 'The Shell (Blue)', 1, '2017-12-28', '29.90', '31.90'),
('2', 'Plain green socks', 412, '2017-07-11', '5.00', '7.60'),
('2', 'Plain black socks', 308, '2017-07-11', '5.00', '7.60'),
('3', 'Plain white socks', 205, '2017-07-12', '5.50', '7.90'),
('4', 'Plain grey socks', 200, '2017-07-11', '7.50', '9.50'),
('5', 'Little Animal Ankle B', 8, '2017-07-11', '7.50', '9.50'),
('6', 'Candie Socks', 14, '2017-07-13', '5.00', '7.60'),
('7', 'Pig Socks', 4, '2017-01-03', '2.40', '4.90'),
('8', 'White T-shirt with red polka dots', 31, '2017-07-15', '10.50', '14.50'),
('9', 'Plain purple thick socks', 200, '2017-07-11', '7.50', '9.50'),
('10', 'Two-toned red thick socks', 310, '2017-07-12', '7.50', '9.50'),
('11', 'White grey striped T-shirt', 31, '2017-07-16', '11.50', '14.00');

-- --------------------------------------------------------

--
-- Table structure for table `inventory_purchase`
--

CREATE TABLE `inventory_purchase` (
  `SKU_Id` varchar(30) NOT NULL,
  `Date_Of_Purchase` date NOT NULL,
  `Quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `inventory_purchase`
--

INSERT INTO `inventory_purchase` (`SKU_Id`, `Date_Of_Purchase`, `Quantity`) VALUES
('SK0001', '2017-07-18', 10),
('SK0002', '2017-07-18', 15),
('SK0003', '2017-07-18', 10),
('SK0005', '2017-07-18', 5),
('TSK0001', '2017-07-18', 2);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `Name` varchar(30) NOT NULL,
  `Password` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`Name`, `Password`) VALUES
('qingyang', 'the92shop'),
('qingyang', 'the92shop'),
('staff1', 'staff1'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Bryan', 'bryan'),
('Alwin', 'alwin'),
('Alwin', 'alwin'),
('Tom', 'tom'),
('Tom', 'tom'),
('john', 'john123'),
('c', 'c'),
('qingyang', 'the92shop'),
('staff1', 'staff1'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Clarey', 'clarey'),
('Bryan', 'bryan'),
('Alwin', 'alwin'),
('Alwin', 'alwin'),
('Tom', 'tom'),
('Tom', 'tom'),
('john', 'john123'),
('c', 'c');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`Cust_Id`);

--
-- Indexes for table `customer_purchase`
--
ALTER TABLE `customer_purchase`
  ADD PRIMARY KEY (`Phone_number`,`SKU_Id`,`Date_Of_Purchase`);

--
-- Indexes for table `expensetypes`
--
ALTER TABLE `expensetypes`
  ADD PRIMARY KEY (`ExpenseType`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`SKU_Id`),
  MODIFY `SKU_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- Indexes for table `inventory_purchase`
--
ALTER TABLE `inventory_purchase`
  ADD PRIMARY KEY (`SKU_Id`,`Date_Of_Purchase`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `Cust_Id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
