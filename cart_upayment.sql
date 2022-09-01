-- Adminer 4.8.1 MySQL 8.0.21 dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` int unsigned DEFAULT NULL,
  `product_id` int unsigned NOT NULL,
  `qty` int unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `carts_user_id_foreign` (`user_id`),
  KEY `carts_product_id_foreign` (`product_id`),
  CONSTRAINT `carts_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `carts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `carts` (`id`, `session_id`, `user_id`, `product_id`, `qty`, `created_at`, `updated_at`) VALUES
(14,	'EI9zbhGdogOV5xSqjfA5OyWH0it15U1BcmHJypHV',	NULL,	3,	1,	'2022-09-01 04:10:54',	'2022-09-01 04:11:28'),
(15,	NULL,	1,	3,	1,	'2022-09-01 04:12:22',	'2022-09-01 04:18:00');

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `category`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1,	'books',	'2022-09-01 00:38:07',	'2022-09-01 00:38:07',	NULL);

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1,	'2014_10_12_000000_create_users_table',	1),
(2,	'2014_10_12_100000_create_password_resets_table',	1),
(3,	'2019_08_19_000000_create_failed_jobs_table',	1),
(4,	'2019_12_14_000001_create_personal_access_tokens_table',	1),
(5,	'2022_09_01_050212_add_admin_column_into_users_table',	1),
(6,	'2022_09_01_050251_create_categories_table',	1),
(7,	'2022_09_01_050300_create_products_table',	1),
(8,	'2022_09_01_050314_create_carts_table',	1);

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `created_at`, `updated_at`) VALUES
(6,	'App\\Models\\User',	1,	'auth_token',	'3c02493087658b684143f6bbc82a18be5ba439949662f1c45cd4232be595aaf0',	'[\"*\"]',	NULL,	'2022-09-01 04:04:11',	'2022-09-01 04:04:11'),
(7,	'App\\Models\\User',	1,	'auth_token',	'9323ac960753ab583d882db34a762bd4302805e01bbb2016357d74a098731313',	'[\"*\"]',	NULL,	'2022-09-01 04:12:12',	'2022-09-01 04:12:12'),
(8,	'App\\Models\\User',	3,	'auth_token',	'f67c02134b1fee14d06b6638c92bbc2f3bd325fa94d951b77b1458e6e8c9428f',	'[\"*\"]',	NULL,	'2022-09-01 04:35:33',	'2022-09-01 04:35:33'),
(9,	'App\\Models\\User',	1,	'auth_token',	'752d11b8b4ea73b23b5d47fcf2741c9ceb68de3894e945ae1b11908a328bf301',	'[\"*\"]',	NULL,	'2022-09-01 04:36:20',	'2022-09-01 04:36:20');

DROP TABLE IF EXISTS `products`;
CREATE TABLE `products` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `category_id` int unsigned NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double(8,2) NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `products_category_id_foreign` (`category_id`),
  CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `products` (`id`, `category_id`, `name`, `price`, `description`, `avatar`, `created_at`, `updated_at`, `deleted_at`) VALUES
(2,	1,	'engish',	125.00,	'something',	'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50',	'2022-09-01 00:54:41',	'2022-09-01 00:54:41',	NULL),
(3,	1,	'engish',	125.00,	'something',	'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50',	'2022-09-01 01:04:53',	'2022-09-01 01:04:53',	NULL),
(4,	1,	'engish',	125.00,	'something',	'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50',	'2022-09-01 04:40:33',	'2022-09-01 04:40:33',	NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `admin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `admin`, `remember_token`, `created_at`, `updated_at`) VALUES
(1,	'harishwar',	'harishwar@gmail.com',	NULL,	'$2y$10$7WhhsiRDo5LHDvVyX.3XMeeGDnNUlyZlLt9W.Da/lErWjWf22ljFG',	'1',	NULL,	'2022-09-01 00:17:49',	'2022-09-01 00:17:49'),
(2,	'harishwar',	'eharishwar@gmail.com',	NULL,	'$2y$10$aVYyrIjP6fFdyvM/qbAN4uoy/.OShy2FiBc0mFU9TDZtY9Gwt0k8G',	'1',	NULL,	'2022-09-01 00:32:30',	'2022-09-01 00:32:30'),
(3,	'harishwar',	'e1harishwar@gmail.com',	NULL,	'$2y$10$HNsp1LLtMyk1syNPHyNe0OFgDlulv/gAMME4zh1iAargidM61cVdC',	NULL,	NULL,	'2022-09-01 04:35:33',	'2022-09-01 04:35:33');

-- 2022-09-01 10:23:07
