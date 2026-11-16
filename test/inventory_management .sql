-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 25, 2026 at 11:32 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth`
--

CREATE TABLE `auth` (
  `ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `MENU_ID` int(11) NOT NULL,
  `PERMISSION` int(1) NOT NULL DEFAULT 1,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `auth`
--

INSERT INTO `auth` (`ID`, `ROLE_ID`, `MENU_ID`, `PERMISSION`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 1, 1, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(2, 1, 2, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(3, 1, 3, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(4, 1, 4, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(5, 1, 5, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(6, 1, 6, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(7, 1, 7, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(8, 1, 8, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(9, 1, 9, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(10, 1, 10, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(11, 1, 11, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(12, 1, 12, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(13, 1, 13, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(14, 1, 14, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(15, 1, 15, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(16, 1, 16, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(17, 1, 17, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(18, 1, 18, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(19, 1, 19, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(20, 1, 20, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(21, 1, 21, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(22, 1, 22, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(23, 1, 23, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(24, 1, 24, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(25, 1, 25, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(26, 1, 26, 1, 1, '2026-06-26 08:49:08', '2026-06-26 08:49:08'),
(27, 1, 27, 1, 1, '2026-06-26 09:01:22', '2026-06-26 09:01:22'),
(28, 1, 28, 1, 1, '2026-06-26 11:00:31', '2026-06-26 11:00:31'),
(29, 1, 29, 1, 1, '2026-06-26 11:00:31', '2026-06-26 11:00:31'),
(30, 1, 30, 1, 1, '2026-06-26 11:00:31', '2026-06-26 11:00:31'),
(31, 1, 31, 1, 1, '2026-06-26 11:00:31', '2026-06-26 11:00:31'),
(32, 1, 32, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(33, 1, 33, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(34, 1, 34, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(35, 1, 35, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(36, 1, 36, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(37, 1, 37, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(38, 1, 38, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(39, 1, 39, 1, 1, '2026-07-23 10:45:04', '2026-07-23 10:45:04'),
(40, 1, 40, 1, 1, '2026-07-24 10:27:48', '2026-07-24 10:27:48'),
(41, 1, 41, 1, 1, '2026-07-24 10:27:58', '2026-07-24 10:27:58'),
(42, 1, 42, 1, 1, '2026-07-24 10:28:04', '2026-07-24 10:28:04'),
(43, 1, 43, 1, 1, '2026-07-24 10:39:32', '2026-07-24 10:39:32'),
(44, 2, 1, 1, 1, '2026-07-24 10:42:33', '2026-07-24 10:42:33'),
(45, 2, 2, 1, 1, '2026-07-24 18:32:07', '2026-07-24 18:32:07'),
(46, 2, 3, 0, 1, '2026-07-24 18:32:14', '2026-07-24 18:32:14'),
(47, 2, 4, 1, 1, '2026-07-24 18:33:30', '2026-07-24 18:33:30'),
(48, 2, 11, 1, 1, '2026-07-24 18:34:10', '2026-07-24 18:34:10'),
(49, 2, 12, 1, 1, '2026-07-24 18:34:17', '2026-07-24 18:34:17'),
(50, 2, 13, 1, 1, '2026-07-24 18:34:25', '2026-07-24 18:34:25'),
(51, 2, 14, 1, 1, '2026-07-24 18:34:32', '2026-07-24 18:34:32'),
(52, 2, 15, 1, 1, '2026-07-24 18:34:42', '2026-07-24 18:34:42'),
(53, 2, 16, 1, 1, '2026-07-24 18:35:36', '2026-07-24 18:35:36'),
(54, 2, 17, 1, 1, '2026-07-24 18:35:48', '2026-07-24 18:35:48'),
(55, 2, 18, 1, 1, '2026-07-24 18:36:15', '2026-07-24 18:36:15'),
(56, 2, 19, 0, 1, '2026-07-24 18:36:32', '2026-07-24 18:36:32'),
(57, 2, 20, 1, 1, '2026-07-24 18:36:38', '2026-07-24 18:36:38'),
(58, 2, 21, 1, 1, '2026-07-24 18:36:46', '2026-07-24 18:36:46'),
(59, 2, 22, 1, 1, '2026-07-24 18:36:54', '2026-07-24 18:36:54'),
(60, 2, 23, 1, 1, '2026-07-24 18:37:07', '2026-07-24 18:37:07'),
(61, 2, 29, 1, 1, '2026-07-24 18:37:48', '2026-07-24 18:37:48'),
(62, 2, 28, 1, 1, '2026-07-24 18:38:12', '2026-07-24 18:38:12'),
(63, 2, 31, 1, 1, '2026-07-24 18:38:20', '2026-07-24 18:38:20');

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE `category` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `CODE` varchar(50) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`ID`, `NAME`, `CODE`, `DESCRIPTION`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 'iphone 16', 'apple', ' promax', 1, '2026-06-24 09:54:07', '2026-06-24 09:56:43'),
(2, 'sansumng123', 'samsung', ' promax', 0, '2026-06-24 11:44:12', '2026-06-26 10:25:25'),
(3, 'iphone 13', 'apple1', 'min', 1, '2026-06-24 15:27:58', '2026-06-24 15:27:58'),
(4, 'iphone 134', '1', ' promax', 1, '2026-06-24 15:29:17', '2026-06-24 15:29:17'),
(5, 'tu lanh', '123', '1', 1, '2026-06-26 08:52:03', '2026-06-26 08:52:03'),
(6, 'tu lanh', '1234', 'tu lanh', 1, '2026-06-26 13:35:36', '2026-06-26 13:35:36');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `ID` int(11) NOT NULL,
  `ACTION_NAME` varchar(100) NOT NULL,
  `TYPE` int(1) NOT NULL,
  `PRODUCT_ID` int(11) NOT NULL,
  `QTY` int(11) NOT NULL,
  `PRICE` decimal(15,2) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`ID`, `ACTION_NAME`, `TYPE`, `PRODUCT_ID`, `QTY`, `PRICE`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 'Add', 1, 4, 10, 5000000.00, 1, '2026-06-26 09:09:52', '2026-06-26 09:09:52'),
(2, 'Add', 1, 4, 12, 3000000.00, 1, '2026-06-26 09:13:24', '2026-06-26 09:13:24'),
(3, 'Edit', 1, 1, 8, 3000000.00, 1, '2026-06-26 09:29:31', '2026-06-26 09:29:31'),
(4, 'Edit', 1, 1, 5, 5000000.00, 1, '2026-06-26 10:09:22', '2026-06-26 10:09:22'),
(5, 'Add', 1, 1, 4, 17000000.00, 1, '2026-06-26 10:49:26', '2026-06-26 10:49:26'),
(6, 'Add', 2, 4, 2, 2000000.00, 1, '2026-06-26 11:13:14', '2026-06-26 11:13:14'),
(7, 'Edit', 1, 1, 3, 5000000.00, 1, '2026-06-26 11:14:46', '2026-06-26 11:14:46'),
(8, 'Add', 2, 4, 2, 5000000.00, 1, '2026-06-26 11:15:57', '2026-06-26 11:15:57'),
(9, 'Add', 1, 1, 10, 4000000.00, 1, '2026-06-26 13:37:00', '2026-06-26 13:37:00'),
(10, 'Add', 2, 4, 1, 5000000.00, 1, '2026-07-24 09:57:12', '2026-07-24 09:57:12'),
(11, 'Edit', 1, 1, 2, 5000000.00, 1, '2026-07-24 10:46:14', '2026-07-24 10:46:14'),
(12, 'Edit', 2, 1, 1, 2000000.00, 1, '2026-07-24 10:47:36', '2026-07-24 10:47:36');

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `ID` int(11) NOT NULL,
  `CODE` varchar(50) NOT NULL,
  `TYPE` int(1) NOT NULL,
  `PRODUCT_ID` int(11) NOT NULL,
  `QTY` int(11) NOT NULL,
  `PRICE` decimal(15,2) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`ID`, `CODE`, `TYPE`, `PRODUCT_ID`, `QTY`, `PRICE`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 'TL01', 1, 1, 2, 5000000.00, 1, '2026-06-26 09:09:52', '2026-07-24 10:46:14'),
(2, 'TL02', 1, 1, 8, 3000000.00, 1, '2026-06-26 09:13:24', '2026-06-26 09:29:31'),
(3, 'IP01', 1, 1, 4, 17000000.00, 1, '2026-06-26 10:49:26', '2026-06-26 10:49:26'),
(4, '1', 2, 1, 1, 2000000.00, 1, '2026-06-26 11:13:14', '2026-07-24 10:47:36'),
(5, '2', 2, 4, 2, 5000000.00, 1, '2026-06-26 11:15:57', '2026-06-26 11:15:57'),
(6, 'IP03', 1, 1, 10, 4000000.00, 1, '2026-06-26 13:37:00', '2026-06-26 13:37:00'),
(7, '1000', 2, 4, 1, 5000000.00, 1, '2026-07-24 09:57:12', '2026-07-24 09:57:12');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `ID` int(11) NOT NULL,
  `PARENT_ID` int(11) NOT NULL,
  `URL` varchar(100) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `ORDER_INDEX` int(1) NOT NULL DEFAULT 0,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`ID`, `PARENT_ID`, `URL`, `NAME`, `ORDER_INDEX`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 0, '/product', 'Sản phẩm', 1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(2, 0, '/stock', 'Kho', 2, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(3, 0, '/management', 'Quản lý', 3, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(4, 1, '/product-info/list', 'Danh sách sản phẩm', 2, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(5, 1, '/category/list', 'Danh sách category', 1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(6, 1, '/category/edit', 'Sửa', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(7, 1, '/category/view', 'Xem', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(8, 1, '/category/add', 'Thêm mới', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(9, 1, '/category/save', 'Lưu', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(10, 1, '/category/delete', 'Xoá', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(11, 1, '/product-info/edit', 'Sửa', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(12, 1, '/product-info/view', 'Xem', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(13, 1, '/product-info/add', 'Thêm mới', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(14, 1, '/product-info/save', 'Lưu', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(15, 1, '/product-info/delete', 'Xoá', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(16, 2, '/goods-receipt/list', 'Danh sách nhập kho', 1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(17, 2, '/goods-receipt/view', 'Xem', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(18, 2, '/goods-receipt/add', 'Thêm mới', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(19, 2, '/goods-receipt/save', 'Lưu', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(20, 2, '/goods-receipt/export', 'Xuất báo cáo', -1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(21, 2, '/goods-issue/list', 'Danh sách xuất kho', 2, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(22, 2, '/product-in-stock/list', 'Sản phẩm trong kho', 3, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(23, 2, '/history/list', 'Lịch sử kho', 4, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(24, 3, '/user/list', 'Danh sách user', 1, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(25, 3, '/menu/list', 'Danh sách menu', 2, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(26, 3, '/role/list', 'Danh sách quyền', 3, 1, '2026-06-26 08:48:49', '2026-06-26 08:48:49'),
(27, 2, '/goods-receipt/edit', 'Sửa', -1, 1, '2026-06-26 08:59:55', '2026-06-26 08:59:55'),
(28, 2, '/goods-issue/view', 'Xem', -1, 1, '2026-06-26 10:58:30', '2026-06-26 10:58:30'),
(29, 2, '/goods-issue/add', 'Thêm mới', -1, 1, '2026-06-26 10:58:30', '2026-06-26 10:58:30'),
(30, 2, '/goods-issue/save', 'Lưu', -1, 1, '2026-06-26 10:58:30', '2026-06-26 10:58:30'),
(31, 2, '/goods-issue/export', 'Xuất báo cáo', -1, 1, '2026-06-26 10:58:30', '2026-06-26 10:58:30'),
(32, 3, '/user/save', 'Save', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(33, 3, '/user/edit', 'Edit', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(34, 3, '/user/view', 'View', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(35, 3, '/user/add', 'Add', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(36, 3, '/role/save', 'Save', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(37, 3, '/role/edit', 'Edit', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(38, 3, '/role/view', 'View', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(39, 3, '/role/add', 'Add', -1, 1, '2026-07-23 10:43:47', '2026-07-23 10:43:47'),
(40, 3, '/menu/update-permission', 'Update', -1, 1, '2026-07-24 10:26:33', '2026-07-24 10:26:33'),
(41, 3, '/menu/change-status', 'Update', -1, 1, '2026-07-24 10:26:33', '2026-07-24 10:26:33'),
(42, 3, '/menu/permission', 'Permission', -1, 1, '2026-07-24 10:26:33', '2026-07-24 10:26:33'),
(43, 2, '/goods-issue/edit', 'Sửa', -1, 1, '2026-07-24 10:38:01', '2026-07-24 10:38:01');

-- --------------------------------------------------------

--
-- Table structure for table `product_info`
--

CREATE TABLE `product_info` (
  `ID` int(11) NOT NULL,
  `CATE_ID` int(11) NOT NULL,
  `CODE` varchar(50) NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `DESCRIPTION` text DEFAULT NULL,
  `IMG_URL` varchar(100) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `product_info`
--

INSERT INTO `product_info` (`ID`, `CATE_ID`, `CODE`, `NAME`, `DESCRIPTION`, `IMG_URL`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 1, '1', 'iphone', '123', '/upload/1782413617293_Microsoft.jpg', 1, '2026-06-24 20:16:28', '2026-06-25 18:53:37'),
(2, 1, 'MH123', 'iphone 13', '123', '/upload/1782409889478_pic_khoahoc.jpg', 0, '2026-06-25 17:51:29', '2026-06-26 10:25:37'),
(3, 1, '1123', '4', '6767', '/upload/1782412718909_pic_mdc1.jpg', 1, '2026-06-25 18:38:38', '2026-06-25 18:38:38'),
(4, 5, '1000', 'toshiba', '1', '/upload/1782463945232_', 1, '2026-06-26 08:52:25', '2026-06-26 08:52:25');

-- --------------------------------------------------------

--
-- Table structure for table `product_in_stock`
--

CREATE TABLE `product_in_stock` (
  `ID` int(11) NOT NULL,
  `PRODUCT_ID` int(11) NOT NULL,
  `QTY` int(11) NOT NULL,
  `PRICE` decimal(15,2) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `product_in_stock`
--

INSERT INTO `product_in_stock` (`ID`, `PRODUCT_ID`, `QTY`, `PRICE`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 4, 17, 3000000.00, 1, '2026-06-26 09:09:52', '2026-07-24 09:57:12'),
(2, 1, 10, 4000000.00, 1, '2026-06-26 10:49:26', '2026-07-24 10:47:36');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `ID` int(11) NOT NULL,
  `ROLE_NAME` varchar(50) NOT NULL,
  `DESCRIPTION` varchar(200) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`ID`, `ROLE_NAME`, `DESCRIPTION`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 'admin', 'Admin of system', 1, '2026-06-19 12:47:04', '2026-06-19 12:47:04'),
(2, 'staff', 'Staff of system', 1, '2026-06-19 12:47:04', '2026-06-19 12:47:04');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `USER_NAME` varchar(50) NOT NULL,
  `PASSWORD` varchar(100) NOT NULL,
  `EMAIL` varchar(100) DEFAULT NULL,
  `NAME` varchar(100) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `USER_NAME`, `PASSWORD`, `EMAIL`, `NAME`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 'minh', 'T7IaJPtdeF15b+ONqJ1JeuhCkeSN11Se', 'minhmuoi234@gmail.com', 'Minh', 1, '2026-06-19 12:03:44', '2026-06-19 12:03:44'),
(2, 'nv1', 'v8DJHvbvXBBxG3YHLAxljfE3O9yk2aVV', '', 'nhan vien 1', 1, '2026-07-23 11:48:27', '2026-07-23 11:48:27');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE `user_role` (
  `ID` int(11) NOT NULL,
  `USER_ID` int(11) NOT NULL,
  `ROLE_ID` int(11) NOT NULL,
  `ACTIVE_FLAG` int(1) NOT NULL DEFAULT 1,
  `CREATE_DATE` timestamp NOT NULL DEFAULT current_timestamp(),
  `UPDATE_DATE` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `user_role`
--

INSERT INTO `user_role` (`ID`, `USER_ID`, `ROLE_ID`, `ACTIVE_FLAG`, `CREATE_DATE`, `UPDATE_DATE`) VALUES
(1, 1, 1, 1, '2026-06-19 12:50:27', '2026-06-19 12:50:27'),
(2, 2, 2, 1, '2026-07-23 11:48:27', '2026-07-23 11:48:27');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `roleid_foreignKey` (`ROLE_ID`),
  ADD KEY `menuid_foreignKey` (`MENU_ID`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `productID_foreignKey_history` (`PRODUCT_ID`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `productID_foreignKey_invoice` (`PRODUCT_ID`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `product_info`
--
ALTER TABLE `product_info`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `cateid_foreignKey` (`CATE_ID`);

--
-- Indexes for table `product_in_stock`
--
ALTER TABLE `product_in_stock`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `productID_foreignKey` (`PRODUCT_ID`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `user_role`
--
ALTER TABLE `user_role`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `userid_foreign_key` (`USER_ID`),
  ADD KEY `roleid_foreign_key` (`ROLE_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth`
--
ALTER TABLE `auth`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `category`
--
ALTER TABLE `category`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `product_info`
--
ALTER TABLE `product_info`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `product_in_stock`
--
ALTER TABLE `product_in_stock`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `user_role`
--
ALTER TABLE `user_role`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth`
--
ALTER TABLE `auth`
  ADD CONSTRAINT `menuid_foreignKey` FOREIGN KEY (`MENU_ID`) REFERENCES `menu` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `roleid_foreignKey` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `productID_foreignKey_history` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product_info` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `productID_foreignKey_invoice` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product_info` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `product_info`
--
ALTER TABLE `product_info`
  ADD CONSTRAINT `cateid_foreignKey` FOREIGN KEY (`CATE_ID`) REFERENCES `category` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `product_in_stock`
--
ALTER TABLE `product_in_stock`
  ADD CONSTRAINT `productID_foreignKey` FOREIGN KEY (`PRODUCT_ID`) REFERENCES `product_info` (`ID`) ON UPDATE CASCADE;

--
-- Constraints for table `user_role`
--
ALTER TABLE `user_role`
  ADD CONSTRAINT `roleid_foreign_key` FOREIGN KEY (`ROLE_ID`) REFERENCES `role` (`ID`) ON UPDATE CASCADE,
  ADD CONSTRAINT `userid_foreign_key` FOREIGN KEY (`USER_ID`) REFERENCES `users` (`ID`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
