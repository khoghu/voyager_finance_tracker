-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 08, 2023 at 04:41 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `voyager_expense_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `order`, `name`, `slug`, `created_at`, `updated_at`) VALUES
(1, NULL, 1, 'Category 1', 'category-1', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(2, NULL, 1, 'Category 2', 'category-2', '2023-09-24 01:02:02', '2023-09-24 01:02:02');

-- --------------------------------------------------------

--
-- Table structure for table `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, NULL, 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, NULL, 4),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, NULL, 5),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 6),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, NULL, 8),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":0}', 10),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 11),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, NULL, 12),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 1, 1, 1, 1, 1, 1, NULL, 9),
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}', 2),
(24, 4, 'order', 'text', 'Order', 1, 1, 1, 1, 1, 1, '{\"default\":1}', 3),
(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 4),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\"}}', 5),
(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, NULL, 6),
(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 7),
(29, 5, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(30, 5, 'author_id', 'text', 'Author', 1, 0, 1, 1, 0, 1, NULL, 2),
(31, 5, 'category_id', 'text', 'Category', 1, 0, 1, 1, 1, 0, NULL, 3),
(32, 5, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 4),
(33, 5, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 5),
(34, 5, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 6),
(35, 5, 'image', 'image', 'Post Image', 0, 1, 1, 1, 1, 1, '{\"resize\":{\"width\":\"1000\",\"height\":\"null\"},\"quality\":\"70%\",\"upsize\":true,\"thumbnails\":[{\"name\":\"medium\",\"scale\":\"50%\"},{\"name\":\"small\",\"scale\":\"25%\"},{\"name\":\"cropped\",\"crop\":{\"width\":\"300\",\"height\":\"250\"}}]}', 7),
(36, 5, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\",\"forceUpdate\":true},\"validation\":{\"rule\":\"unique:posts,slug\"}}', 8),
(37, 5, 'meta_description', 'text_area', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 9),
(38, 5, 'meta_keywords', 'text_area', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 10),
(39, 5, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"DRAFT\",\"options\":{\"PUBLISHED\":\"published\",\"DRAFT\":\"draft\",\"PENDING\":\"pending\"}}', 11),
(40, 5, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, NULL, 12),
(41, 5, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 13),
(42, 5, 'seo_title', 'text', 'SEO Title', 0, 1, 1, 1, 1, 1, NULL, 14),
(43, 5, 'featured', 'checkbox', 'Featured', 1, 1, 1, 1, 1, 1, NULL, 15),
(44, 6, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(45, 6, 'author_id', 'text', 'Author', 1, 0, 0, 0, 0, 0, NULL, 2),
(46, 6, 'title', 'text', 'Title', 1, 1, 1, 1, 1, 1, NULL, 3),
(47, 6, 'excerpt', 'text_area', 'Excerpt', 1, 0, 1, 1, 1, 1, NULL, 4),
(48, 6, 'body', 'rich_text_box', 'Body', 1, 0, 1, 1, 1, 1, NULL, 5),
(49, 6, 'slug', 'text', 'Slug', 1, 0, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"title\"},\"validation\":{\"rule\":\"unique:pages,slug\"}}', 6),
(50, 6, 'meta_description', 'text', 'Meta Description', 1, 0, 1, 1, 1, 1, NULL, 7),
(51, 6, 'meta_keywords', 'text', 'Meta Keywords', 1, 0, 1, 1, 1, 1, NULL, 8),
(52, 6, 'status', 'select_dropdown', 'Status', 1, 1, 1, 1, 1, 1, '{\"default\":\"INACTIVE\",\"options\":{\"INACTIVE\":\"INACTIVE\",\"ACTIVE\":\"ACTIVE\"}}', 9),
(53, 6, 'created_at', 'timestamp', 'Created At', 1, 1, 1, 0, 0, 0, NULL, 10),
(54, 6, 'updated_at', 'timestamp', 'Updated At', 1, 0, 0, 0, 0, 0, NULL, 11),
(55, 6, 'image', 'image', 'Page Image', 0, 1, 1, 1, 1, 1, NULL, 12),
(56, 8, 'id', 'text', 'Id', 1, 1, 0, 0, 0, 0, '{}', 1),
(57, 8, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(58, 8, 'created_at', 'timestamp', 'Created At', 0, 1, 0, 0, 0, 0, '{}', 3),
(59, 8, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 4),
(60, 9, 'id', 'text', 'Id', 1, 1, 0, 0, 0, 0, '{}', 1),
(63, 9, 'title', 'text', 'Title', 0, 1, 1, 1, 1, 1, '{}', 6),
(64, 9, 'description', 'text', 'Description', 0, 1, 1, 1, 1, 1, '{}', 7),
(65, 9, 'amount', 'number', 'Amount', 0, 1, 1, 1, 1, 1, '{}', 8),
(66, 9, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, '{}', 11),
(67, 9, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 12),
(76, 9, 'user_id', 'text', 'User Id', 0, 0, 0, 0, 0, 0, '{}', 3),
(77, 9, 'group_id', 'text', 'Group Id', 0, 0, 0, 0, 0, 0, '{}', 5),
(80, 9, 'document', 'image', 'Document', 0, 1, 1, 1, 1, 1, '{}', 9),
(81, 9, 'credited_at', 'timestamp', 'Credited At', 0, 1, 1, 1, 1, 1, '{}', 10),
(82, 14, 'id', 'text', 'Id', 1, 1, 0, 0, 0, 0, '{}', 1),
(83, 14, 'user_id', 'text', 'User Id', 0, 0, 0, 0, 0, 0, '{}', 4),
(84, 14, 'group_id', 'text', 'Group Id', 0, 0, 0, 0, 0, 0, '{}', 5),
(85, 14, 'title', 'text', 'Title', 0, 1, 1, 1, 1, 1, '{}', 6),
(86, 14, 'description', 'text', 'Description', 0, 1, 1, 1, 1, 1, '{}', 7),
(87, 14, 'amount', 'number', 'Amount', 0, 1, 1, 1, 1, 1, '{}', 8),
(88, 14, 'credit_day_per_month', 'number', 'Credit Day Per Month', 0, 1, 1, 1, 1, 1, '{}', 9),
(89, 14, 'attachment', 'image', 'Attachment', 0, 1, 1, 1, 1, 1, '{}', 10),
(90, 14, 'credited_at', 'timestamp', 'Credited At', 0, 1, 1, 1, 1, 1, '{}', 11),
(91, 14, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, '{}', 12),
(92, 14, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 13),
(93, 14, 'static_income_belongsto_finance_group_relationship', 'relationship', 'Group', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\FinanceGroup\",\"table\":\"finance_groups\",\"type\":\"belongsTo\",\"column\":\"group_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 3),
(94, 14, 'static_income_belongsto_user_relationship', 'relationship', 'User', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Models\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 2),
(96, 17, 'id', 'text', 'Id', 1, 1, 0, 0, 0, 0, '{}', 1),
(97, 17, 'user_id', 'text', 'User Id', 0, 1, 1, 1, 1, 1, '{}', 2),
(98, 17, 'group_id', 'text', 'Group Id', 0, 1, 1, 1, 1, 1, '{}', 3),
(99, 17, 'title', 'text', 'Title', 0, 1, 1, 1, 1, 1, '{}', 4),
(100, 17, 'description', 'text', 'Description', 0, 1, 1, 1, 1, 1, '{}', 5),
(101, 17, 'amount', 'text', 'Amount', 0, 1, 1, 1, 1, 1, '{}', 6),
(102, 17, 'status', 'text', 'Status', 0, 1, 1, 1, 1, 1, '{}', 7),
(103, 17, 'attachment', 'text', 'Attachment', 0, 1, 1, 1, 1, 1, '{}', 8),
(104, 17, 'credited_at', 'timestamp', 'Credited At', 0, 1, 1, 1, 1, 1, '{}', 9),
(105, 17, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, '{}', 10),
(106, 17, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 11),
(107, 19, 'id', 'text', 'Id', 1, 1, 0, 0, 0, 0, '{}', 1),
(108, 19, 'user_id', 'text', 'User Id', 0, 1, 1, 1, 1, 1, '{}', 2),
(109, 19, 'group_id', 'text', 'Group Id', 0, 1, 1, 1, 1, 1, '{}', 3),
(110, 19, 'title', 'text', 'Title', 0, 1, 1, 1, 1, 1, '{}', 4),
(111, 19, 'description', 'text', 'Description', 0, 1, 1, 1, 1, 1, '{}', 5),
(112, 19, 'amount', 'text', 'Amount', 0, 1, 1, 1, 1, 1, '{}', 6),
(113, 19, 'credit_day_per_month', 'text', 'Credit Day Per Month', 0, 1, 1, 1, 1, 1, '{}', 7),
(114, 19, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, '{}', 8),
(115, 19, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9);

-- --------------------------------------------------------

--
-- Table structure for table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `display_name_singular` varchar(255) NOT NULL,
  `display_name_plural` varchar(255) NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `model_name` varchar(255) DEFAULT NULL,
  `policy_name` varchar(255) DEFAULT NULL,
  `controller` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', '', 1, 0, NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, 'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController', '', 1, 0, NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'TCG\\Voyager\\Models\\Category', NULL, '', '', 1, 0, NULL, '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(5, 'posts', 'posts', 'Post', 'Posts', 'voyager-news', 'TCG\\Voyager\\Models\\Post', 'TCG\\Voyager\\Policies\\PostPolicy', '', '', 1, 0, NULL, '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(6, 'pages', 'pages', 'Page', 'Pages', 'voyager-file-text', 'TCG\\Voyager\\Models\\Page', NULL, '', '', 1, 0, NULL, '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(8, 'finance_groups', 'finance-groups', 'Finance Group', 'Finance Groups', 'voyager-logbook', 'App\\Models\\FinanceGroup', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-09-24 02:25:28', '2023-09-24 02:25:28'),
(9, 'incomes', 'incomes', 'Income', 'Incomes', 'voyager-book-download', 'App\\Models\\Income', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-09-24 05:33:36', '2023-09-26 02:01:55'),
(10, 'testing', 'testing', 'Testing', 'Testings', 'voyager-video', 'App\\Models\\Testing', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-09-24 06:21:08', '2023-09-24 06:21:08'),
(14, 'static_incomes', 'static-incomes', 'Static Income', 'Static Incomes', 'voyager-markdown', 'App\\Models\\StaticIncome', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2023-09-25 15:54:41', '2023-09-25 15:57:02'),
(17, 'expenses', 'expenses', 'Expense', 'Expenses', 'voyager-double-up', 'App\\Models\\Expense', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-09-27 16:55:08', '2023-09-27 16:55:08'),
(19, 'static_expenses', 'static-expenses', 'Static Expense', 'Static Expenses', 'voyager-upload', 'App\\Models\\StaticExpense', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2023-09-28 10:50:01', '2023-09-28 10:50:01');

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `status` varchar(50) DEFAULT NULL,
  `attachment` varchar(500) DEFAULT NULL,
  `credited_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `user_id`, `group_id`, `title`, `description`, `amount`, `status`, `attachment`, `credited_at`, `created_at`, `updated_at`) VALUES
(7, 1, 4, 'Friend Wedding', 'Pulau Pinang', '875.00', 'Complete', 'expense/WuNUydSSdMGva9f1Ame911td92zOkH8NCqQCwPNv.webp', '2023-09-09 01:38:00', '2023-09-12 17:38:49', '2023-09-30 17:39:00'),
(8, 1, 5, 'Car Loan', NULL, '545.00', 'Complete', NULL, NULL, '2023-10-18 17:51:17', '2023-09-30 17:51:17'),
(9, 1, 6, 'Movie Ticket', 'GSC', '34.00', 'Complete', NULL, '2023-10-18 17:51:00', '2023-09-30 17:51:55', '2023-09-30 17:51:55'),
(10, 1, 5, 'House Loan', NULL, '1200.00', 'Complete', NULL, NULL, '2023-10-02 08:52:34', '2023-10-02 08:52:34'),
(11, 1, 7, 'Restaurant', NULL, '60.00', 'Pending', 'expense/xnhLnZ6Ote0kGr0ktEY8S7YexTlt2q15yDPLBcXP.webp', NULL, '2023-10-02 10:38:08', '2023-10-06 16:26:26');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finance_groups`
--

CREATE TABLE `finance_groups` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `finance_groups`
--

INSERT INTO `finance_groups` (`id`, `name`, `created_at`, `updated_at`) VALUES
(2, 'Salary', '2023-09-25 14:37:00', '2023-09-25 14:37:00'),
(4, 'Travel', '2023-09-26 12:41:25', '2023-09-26 12:41:25'),
(5, 'Bank Loan', '2023-09-30 13:59:44', '2023-09-30 14:00:01'),
(6, 'Entertainment', '2023-09-30 14:00:20', '2023-09-30 14:00:20'),
(7, 'Food & Bevarges', '2023-09-30 14:00:32', '2023-09-30 14:00:32'),
(8, 'Shopping', '2023-09-30 14:00:43', '2023-09-30 14:08:36'),
(9, 'Rent', '2023-09-30 14:02:04', '2023-09-30 14:02:04'),
(10, 'Sports', '2023-09-30 14:02:20', '2023-09-30 14:02:20'),
(11, 'Commision', '2023-09-30 14:02:29', '2023-09-30 14:02:29'),
(12, 'Medical', '2023-09-30 14:03:20', '2023-09-30 14:03:35'),
(13, 'Insurance', '2023-09-30 14:03:28', '2023-09-30 14:03:28'),
(14, 'House Hold', '2023-09-30 14:03:48', '2023-09-30 14:03:48'),
(15, 'Business', '2023-09-30 14:04:58', '2023-09-30 14:04:58'),
(16, 'Family', '2023-09-30 14:05:05', '2023-09-30 14:05:05'),
(17, 'Studies', '2023-09-30 14:05:32', '2023-09-30 14:05:32'),
(18, 'E-Wallet', '2023-09-30 14:08:57', '2023-09-30 14:08:57'),
(19, 'Touch & Go', '2023-09-30 14:09:18', '2023-09-30 14:09:18'),
(20, 'Vehicle', '2023-09-30 14:09:36', '2023-09-30 14:10:08'),
(21, 'Bank Saving', '2023-09-30 17:25:46', '2023-09-30 17:25:46'),
(22, 'Investment', '2023-09-30 17:25:55', '2023-09-30 17:25:55');

-- --------------------------------------------------------

--
-- Table structure for table `incomes`
--

CREATE TABLE `incomes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `amount` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `debited_at` timestamp NULL DEFAULT NULL,
  `attachment` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `incomes`
--

INSERT INTO `incomes` (`id`, `user_id`, `group_id`, `title`, `description`, `amount`, `created_at`, `updated_at`, `debited_at`, `attachment`) VALUES
(20, 1, 2, 'September Salary', NULL, '5600.00', '2023-09-30 17:34:20', '2023-10-06 17:12:06', '2023-10-29 17:12:00', 'income/Ug86lX3wHQd2cT20HlguJetAgPUAw0xH5mWgTWDo.png'),
(21, 1, 15, 'September Salary', NULL, '1200.00', '2023-09-30 17:35:27', '2023-10-06 17:11:54', '2023-10-16 17:11:00', 'income/SJ8Oulr02TOy794uEECTcd9a7ZM24dncbLXYM2i7.png');

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2023-09-24 01:01:39', '2023-09-24 01:01:39');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `target` varchar(255) NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) DEFAULT NULL,
  `color` varchar(255) DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) DEFAULT NULL,
  `parameters` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2023-09-24 01:01:39', '2023-09-24 01:01:39', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, 5, 4, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, 5, 5, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, 5, 6, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 2, '2023-09-24 01:01:39', '2023-09-24 02:08:18', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 7, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 8, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 9, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 10, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 3, '2023-09-24 01:01:39', '2023-09-24 02:08:18', 'voyager.settings.index', NULL),
(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, 5, 1, '2023-09-24 01:02:02', '2023-09-24 02:08:18', 'voyager.categories.index', NULL),
(12, 1, 'Posts', '', '_self', 'voyager-news', NULL, 5, 3, '2023-09-24 01:02:02', '2023-09-24 02:08:18', 'voyager.posts.index', NULL),
(13, 1, 'Pages', '', '_self', 'voyager-file-text', NULL, 5, 2, '2023-09-24 01:02:02', '2023-09-24 02:08:18', 'voyager.pages.index', NULL),
(14, 1, 'Finance Groups', '', '_self', 'voyager-logbook', NULL, NULL, 4, '2023-09-24 02:25:28', '2023-09-24 02:25:28', 'voyager.finance-groups.index', NULL),
(15, 1, 'Incomes', '', '_self', 'voyager-book-download', NULL, NULL, 5, '2023-09-24 05:33:36', '2023-09-24 05:33:36', 'voyager.incomes.index', NULL),
(18, 1, 'Static Incomes', '', '_self', 'voyager-markdown', NULL, NULL, 6, '2023-09-25 15:54:42', '2023-09-25 15:54:42', 'voyager.static-incomes.index', NULL),
(19, 1, 'Expenses', '', '_self', 'voyager-double-up', NULL, NULL, 7, '2023-09-27 16:55:08', '2023-09-27 16:55:08', 'voyager.expenses.index', NULL),
(20, 1, 'Static Expenses', '', '_self', 'voyager-upload', NULL, NULL, 8, '2023-09-28 10:50:01', '2023-09-28 10:50:01', 'voyager.static-expenses.index', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_reset_tokens_table', 1),
(3, '2016_01_01_000000_add_voyager_user_fields', 1),
(4, '2016_01_01_000000_create_data_types_table', 1),
(5, '2016_05_19_173453_create_menu_table', 1),
(6, '2016_10_21_190000_create_roles_table', 1),
(7, '2016_10_21_190000_create_settings_table', 1),
(8, '2016_11_30_135954_create_permission_table', 1),
(9, '2016_11_30_141208_create_permission_role_table', 1),
(10, '2016_12_26_201236_data_types__add__server_side', 1),
(11, '2017_01_13_000000_add_route_to_menu_items_table', 1),
(12, '2017_01_14_005015_create_translations_table', 1),
(13, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
(14, '2017_03_06_000000_add_controller_to_data_types_table', 1),
(15, '2017_04_21_000000_add_order_to_data_rows_table', 1),
(16, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
(17, '2017_08_05_000000_add_group_to_settings_table', 1),
(18, '2017_11_26_013050_add_user_role_relationship', 1),
(19, '2017_11_26_015000_create_user_roles_table', 1),
(20, '2018_03_11_000000_add_user_settings', 1),
(21, '2018_03_14_000000_add_details_to_data_types_table', 1),
(22, '2018_03_16_000000_make_settings_value_nullable', 1),
(23, '2019_08_19_000000_create_failed_jobs_table', 1),
(24, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(25, '2016_01_01_000000_create_pages_table', 2),
(26, '2016_01_01_000000_create_posts_table', 2),
(27, '2016_02_15_204651_create_categories_table', 2),
(28, '2017_04_11_000000_alter_post_nullable_fields_table', 2);

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'INACTIVE',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `author_id`, `title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `created_at`, `updated_at`) VALUES
(1, 0, 'Hello World', 'Hang the jib grog grog blossom grapple dance the hempen jig gangway pressgang bilge rat to go on account lugger. Nelsons folly gabion line draught scallywag fire ship gaff fluke fathom case shot. Sea Legs bilge rat sloop matey gabion long clothes run a shot across the bow Gold Road cog league.', '<p>Hello World. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', 'pages/page1.jpg', 'hello-world', 'Yar Meta Description', 'Keyword1, Keyword2', 'ACTIVE', '2023-09-24 01:02:02', '2023-09-24 01:02:02');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `table_name` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(2, 'browse_bread', NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(3, 'browse_database', NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(4, 'browse_media', NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(5, 'browse_compass', NULL, '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(6, 'browse_menus', 'menus', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(7, 'read_menus', 'menus', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(8, 'edit_menus', 'menus', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(9, 'add_menus', 'menus', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(10, 'delete_menus', 'menus', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(11, 'browse_roles', 'roles', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(12, 'read_roles', 'roles', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(13, 'edit_roles', 'roles', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(14, 'add_roles', 'roles', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(15, 'delete_roles', 'roles', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(16, 'browse_users', 'users', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(17, 'read_users', 'users', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(18, 'edit_users', 'users', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(19, 'add_users', 'users', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(20, 'delete_users', 'users', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(21, 'browse_settings', 'settings', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(22, 'read_settings', 'settings', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(23, 'edit_settings', 'settings', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(24, 'add_settings', 'settings', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(25, 'delete_settings', 'settings', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(26, 'browse_categories', 'categories', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(27, 'read_categories', 'categories', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(28, 'edit_categories', 'categories', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(29, 'add_categories', 'categories', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(30, 'delete_categories', 'categories', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(31, 'browse_posts', 'posts', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(32, 'read_posts', 'posts', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(33, 'edit_posts', 'posts', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(34, 'add_posts', 'posts', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(35, 'delete_posts', 'posts', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(36, 'browse_pages', 'pages', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(37, 'read_pages', 'pages', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(38, 'edit_pages', 'pages', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(39, 'add_pages', 'pages', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(40, 'delete_pages', 'pages', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(41, 'browse_finance_groups', 'finance_groups', '2023-09-24 02:25:28', '2023-09-24 02:25:28'),
(42, 'read_finance_groups', 'finance_groups', '2023-09-24 02:25:28', '2023-09-24 02:25:28'),
(43, 'edit_finance_groups', 'finance_groups', '2023-09-24 02:25:28', '2023-09-24 02:25:28'),
(44, 'add_finance_groups', 'finance_groups', '2023-09-24 02:25:28', '2023-09-24 02:25:28'),
(45, 'delete_finance_groups', 'finance_groups', '2023-09-24 02:25:28', '2023-09-24 02:25:28'),
(46, 'browse_incomes', 'incomes', '2023-09-24 05:33:36', '2023-09-24 05:33:36'),
(47, 'read_incomes', 'incomes', '2023-09-24 05:33:36', '2023-09-24 05:33:36'),
(48, 'edit_incomes', 'incomes', '2023-09-24 05:33:36', '2023-09-24 05:33:36'),
(49, 'add_incomes', 'incomes', '2023-09-24 05:33:36', '2023-09-24 05:33:36'),
(50, 'delete_incomes', 'incomes', '2023-09-24 05:33:36', '2023-09-24 05:33:36'),
(51, 'browse_testing', 'testing', '2023-09-24 06:21:08', '2023-09-24 06:21:08'),
(52, 'read_testing', 'testing', '2023-09-24 06:21:08', '2023-09-24 06:21:08'),
(53, 'edit_testing', 'testing', '2023-09-24 06:21:08', '2023-09-24 06:21:08'),
(54, 'add_testing', 'testing', '2023-09-24 06:21:08', '2023-09-24 06:21:08'),
(55, 'delete_testing', 'testing', '2023-09-24 06:21:08', '2023-09-24 06:21:08'),
(61, 'browse_static_incomes', 'static_incomes', '2023-09-25 15:54:42', '2023-09-25 15:54:42'),
(62, 'read_static_incomes', 'static_incomes', '2023-09-25 15:54:42', '2023-09-25 15:54:42'),
(63, 'edit_static_incomes', 'static_incomes', '2023-09-25 15:54:42', '2023-09-25 15:54:42'),
(64, 'add_static_incomes', 'static_incomes', '2023-09-25 15:54:42', '2023-09-25 15:54:42'),
(65, 'delete_static_incomes', 'static_incomes', '2023-09-25 15:54:42', '2023-09-25 15:54:42'),
(66, 'browse_expenses', 'expenses', '2023-09-27 16:55:08', '2023-09-27 16:55:08'),
(67, 'read_expenses', 'expenses', '2023-09-27 16:55:08', '2023-09-27 16:55:08'),
(68, 'edit_expenses', 'expenses', '2023-09-27 16:55:08', '2023-09-27 16:55:08'),
(69, 'add_expenses', 'expenses', '2023-09-27 16:55:08', '2023-09-27 16:55:08'),
(70, 'delete_expenses', 'expenses', '2023-09-27 16:55:08', '2023-09-27 16:55:08'),
(71, 'browse_static_expenses', 'static_expenses', '2023-09-28 10:50:01', '2023-09-28 10:50:01'),
(72, 'read_static_expenses', 'static_expenses', '2023-09-28 10:50:01', '2023-09-28 10:50:01'),
(73, 'edit_static_expenses', 'static_expenses', '2023-09-28 10:50:01', '2023-09-28 10:50:01'),
(74, 'add_static_expenses', 'static_expenses', '2023-09-28 10:50:01', '2023-09-28 10:50:01'),
(75, 'delete_static_expenses', 'static_expenses', '2023-09-28 10:50:01', '2023-09-28 10:50:01');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(31, 1),
(32, 1),
(33, 1),
(34, 1),
(35, 1),
(36, 1),
(37, 1),
(38, 1),
(39, 1),
(40, 1),
(41, 1),
(41, 2),
(42, 1),
(42, 2),
(43, 1),
(43, 2),
(44, 1),
(44, 2),
(45, 1),
(45, 2),
(46, 1),
(46, 2),
(47, 1),
(47, 2),
(48, 1),
(48, 2),
(49, 1),
(49, 2),
(50, 1),
(50, 2),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(61, 1),
(61, 2),
(62, 1),
(62, 2),
(63, 1),
(63, 2),
(64, 1),
(64, 2),
(65, 1),
(65, 2),
(66, 1),
(66, 2),
(67, 1),
(67, 2),
(68, 1),
(68, 2),
(69, 1),
(69, 2),
(70, 1),
(70, 2),
(71, 1),
(71, 2),
(72, 1),
(72, 2),
(73, 1),
(73, 2),
(74, 1),
(74, 2),
(75, 1),
(75, 2);

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) UNSIGNED NOT NULL,
  `author_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `seo_title` varchar(255) DEFAULT NULL,
  `excerpt` text DEFAULT NULL,
  `body` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `slug` varchar(255) NOT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('PUBLISHED','DRAFT','PENDING') NOT NULL DEFAULT 'DRAFT',
  `featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `author_id`, `category_id`, `title`, `seo_title`, `excerpt`, `body`, `image`, `slug`, `meta_description`, `meta_keywords`, `status`, `featured`, `created_at`, `updated_at`) VALUES
(1, 0, NULL, 'Lorem Ipsum Post', NULL, 'This is the excerpt for the Lorem Ipsum Post', '<p>This is the body of the lorem ipsum post</p>', 'posts/post1.jpg', 'lorem-ipsum-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(2, 0, NULL, 'My Sample Post', NULL, 'This is the excerpt for the sample Post', '<p>This is the body for the sample post, which includes the body.</p>\n                <h2>We can use all kinds of format!</h2>\n                <p>And include a bunch of other stuff.</p>', 'posts/post2.jpg', 'my-sample-post', 'Meta Description for sample post', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(3, 0, NULL, 'Latest Post', NULL, 'This is the excerpt for the latest post', '<p>This is the body for the latest post</p>', 'posts/post3.jpg', 'latest-post', 'This is the meta description', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(4, 0, NULL, 'Yarr Post', NULL, 'Reef sails nipperkin bring a spring upon her cable coffer jury mast spike marooned Pieces of Eight poop deck pillage. Clipper driver coxswain galleon hempen halter come about pressgang gangplank boatswain swing the lead. Nipperkin yard skysail swab lanyard Blimey bilge water ho quarter Buccaneer.', '<p>Swab deadlights Buccaneer fire ship square-rigged dance the hempen jig weigh anchor cackle fruit grog furl. Crack Jennys tea cup chase guns pressgang hearties spirits hogshead Gold Road six pounders fathom measured fer yer chains. Main sheet provost come about trysail barkadeer crimp scuttle mizzenmast brig plunder.</p>\n<p>Mizzen league keelhaul galleon tender cog chase Barbary Coast doubloon crack Jennys tea cup. Blow the man down lugsail fire ship pinnace cackle fruit line warp Admiral of the Black strike colors doubloon. Tackle Jack Ketch come about crimp rum draft scuppers run a shot across the bow haul wind maroon.</p>\n<p>Interloper heave down list driver pressgang holystone scuppers tackle scallywag bilged on her anchor. Jack Tar interloper draught grapple mizzenmast hulk knave cable transom hogshead. Gaff pillage to go on account grog aft chase guns piracy yardarm knave clap of thunder.</p>', 'posts/post4.jpg', 'yarr-post', 'this be a meta descript', 'keyword1, keyword2, keyword3', 'PUBLISHED', 0, '2023-09-24 01:02:02', '2023-09-24 01:02:02');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2023-09-24 01:01:39', '2023-09-24 01:01:39'),
(2, 'user', 'Normal User', '2023-09-24 01:01:39', '2023-09-24 01:01:39');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `details` text DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Expense Tracker', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Budget & Expense Tracking System', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', 'settings\\September2023\\gXRwMRX1al67GGCYQnsD.png', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', NULL, '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', 'settings\\September2023\\g5zsCxLNkN2KXg89xprz.webp', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Expense Tracker', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Budget & Expense Tracking System', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', 'settings\\September2023\\P6NUDdz04BrTl9ee2ZmQ.png', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', NULL, '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `static_expenses`
--

CREATE TABLE `static_expenses` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `credit_day_per_month` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `static_expenses`
--

INSERT INTO `static_expenses` (`id`, `user_id`, `group_id`, `title`, `description`, `amount`, `credit_day_per_month`, `created_at`, `updated_at`) VALUES
(3, 1, 5, 'Car Loan', NULL, '512.00', 4, '2023-09-30 17:36:20', '2023-09-30 17:36:20'),
(4, 1, 5, 'House Loan', NULL, '1500.00', 3, '2023-09-30 17:36:42', '2023-09-30 17:36:42'),
(5, 1, 13, 'Hong Leong Insurance', 'Medical Insurance', '160.00', 8, '2023-09-30 17:37:34', '2023-09-30 17:37:34');

-- --------------------------------------------------------

--
-- Table structure for table `static_incomes`
--

CREATE TABLE `static_incomes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `title` varchar(500) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `amount` varchar(50) DEFAULT NULL,
  `debit_day_per_month` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `static_incomes`
--

INSERT INTO `static_incomes` (`id`, `user_id`, `group_id`, `title`, `description`, `amount`, `debit_day_per_month`, `created_at`, `updated_at`) VALUES
(7, 1, 2, 'Monthly Salary', 'Auto Create Salary', '5420.00', 1, '2023-09-30 15:22:56', '2023-09-30 15:22:56'),
(8, 1, 11, 'Insurance Commision', 'Insurance Commision', '670.00', 10, '2023-09-30 15:24:01', '2023-09-30 17:24:33'),
(10, 1, 15, 'House Rent', 'Subang Jaya House', '1200.00', 5, '2023-09-30 17:27:57', '2023-09-30 17:27:57');

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) NOT NULL,
  `column_name` varchar(255) NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) NOT NULL,
  `value` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2023-09-24 01:02:02', '2023-09-24 01:02:02'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2023-09-24 01:02:02', '2023-09-24 01:02:02');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `settings` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`) VALUES
(1, 1, 'User', 'khoghu@gmail.com', 'users/default.png', NULL, '$2y$10$XY0Hg5DswcNFKTPm8p9areHoQJ.pMvG3.No/nR.TOY7Z2Inyf4R3C', 'N6C0wwj92JgLEpGTVHqUONN1Lv9EbEwJ1l6aj8qrip6igUzJBWBBLFEoFJW8', '{\"locale\":\"en\"}', '2023-09-24 01:02:02', '2023-10-07 03:57:30'),
(2, 2, 'vikram', 'vikramgopal14@gmail.com', 'users/default.png', NULL, '$2y$10$k.m1E1hla6DQKp7vIQQ9wekpv02FxlJP9YKWftBkA53g..qzWiCLy', NULL, '{\"locale\":\"en\"}', '2023-10-08 07:48:30', '2023-10-08 07:48:30');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`);

--
-- Indexes for table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_types_name_unique` (`name`),
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `finance_groups`
--
ALTER TABLE `finance_groups`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `incomes`
--
ALTER TABLE `incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_name_unique` (`name`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_key_index` (`key`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `posts_slug_unique` (`slug`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `static_expenses`
--
ALTER TABLE `static_expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `static_incomes`
--
ALTER TABLE `static_incomes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_user_id_index` (`user_id`),
  ADD KEY `user_roles_role_id_index` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finance_groups`
--
ALTER TABLE `finance_groups`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `incomes`
--
ALTER TABLE `incomes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `static_expenses`
--
ALTER TABLE `static_expenses`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `static_incomes`
--
ALTER TABLE `static_incomes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
