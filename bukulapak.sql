SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` INT primary key AUTO_INCREMENT not null,
  `name` VARCHAR(255) not null,
  `email` VARCHAR(255) not null,
  `email_verified_at` datetime,
  `password` VARCHAR(255) not null,
  `remember_token` VARCHAR(255),
  `created_at` datetime,
  `updated_at` datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`) VALUES
(1,'Andi Wijaya','andi@bukulapak.id',NULL,'$2y$12$mknFJgmJM1Iw7KhESlMpg.KAi9bq2am1x.9pwhcQZ1R5oDcNUFvw.',NULL,'2026-10-12 07:58:14','2026-10-12 07:58:14'),
(2,'Sari Putri','sari@bukulapak.id',NULL,'$2y$12$tUx7avYkibRkh9sdrheKmepjh34PVF4do3M1BhqyNdqQm9hSwFU0C',NULL,'2026-10-12 07:58:15','2026-10-12 07:58:15'),
(3,'Budi','budi@bukulapak.id',NULL,'$2y$12$nO8V5n6kYByNOe5JS5O8/uzbN0uTB4QcFXpkHEqtEVYXvbuu3S6Ei',NULL,'2026-10-12 07:59:23','2026-10-12 07:59:23'),
(4,'Oka','okaroyhan@gmail.com',NULL,'$2y$12$wjv0arMEbE21xvc.hu6TK.GrCpAOH0hJ3fwYaj8C/qjr9Kj1IzESq',NULL,'2026-10-12 14:26:28','2026-10-12 14:26:28'),
(5,'Dewi Lestari','dewi@bukulapak.id',NULL,'$2y$12$VMNy143gs5xu0KUHR1AbrONDYqGx4OGzEHrUVfI6mes8kLVRh1MR.',NULL,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(6,'Rizky Pratama','rizky@bukulapak.id',NULL,'$2y$12$AXI59jXDyytt9p.wudrwleHUZinBATliiIh5pF7bMJkzW6mbnjJx.',NULL,'2026-10-12 15:14:44','2026-10-12 15:14:44');

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` VARCHAR(255) not null,
  `token` VARCHAR(255) not null,
  `created_at` datetime,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` VARCHAR(255) not null,
  `user_id` INT,
  `ip_address` VARCHAR(255),
  `user_agent` text,
  `payload` text not null,
  `last_activity` INT not null,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sessions` (`id`,`user_id`,`ip_address`,`user_agent`,`payload`,`last_activity`) VALUES
('KuGHHkI34lE1r8QVqvvtzKsWtU1H0uDpEY4tri7r',NULL,'127.0.0.1','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/155.0.0.0 Safari/537.36','eyJfdG9rZW4iOiJBRWFSQVlOTENaRWV2NWprTWJWaGNzeHB5SkxIbEV4VTc3bE1xYWhIIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cL2xvY2FsaG9zdDo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19',1791820465);

DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` VARCHAR(255) not null,
  `value` text not null,
  `expiration` INT not null,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `cache` (`key`,`value`,`expiration`) VALUES
('laravel-cache-books_search_81d6f64505aad647a23be7af63ed68f2','a:20:{i:0;a:12:{s:15:"open_library_id";s:18:"/works/OL15302003W";s:4:"isbn";N;s:5:"title";s:14:"Laskar Pelangi";s:7:"authors";a:1:{i:0;s:13:"Andrea Hirata";}s:9:"publisher";N;s:14:"published_date";s:10:"2005-01-01";s:11:"description";N;s:9:"cover_url";s:49:"https://covers.openlibrary.org/b/id/7079796-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:1;a:12:{s:15:"open_library_id";s:18:"/works/OL15302005W";s:4:"isbn";N;s:5:"title";s:18:"The rainbow troops";s:7:"authors";a:1:{i:0;s:13:"Andrea Hirata";}s:9:"publisher";N;s:14:"published_date";s:10:"2009-01-01";s:11:"description";N;s:9:"cover_url";s:50:"https://covers.openlibrary.org/b/id/13007588-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:2;a:12:{s:15:"open_library_id";s:18:"/works/OL13719321W";s:4:"isbn";N;s:5:"title";s:14:"Laskar pelangi";s:7:"authors";a:1:{i:0;s:15:"Asrori S. Karni";}s:9:"publisher";N;s:14:"published_date";s:10:"2008-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:3;a:12:{s:15:"open_library_id";s:18:"/works/OL18784081W";s:4:"isbn";N;s:5:"title";s:14:"Laskar pemimpi";s:7:"authors";a:1:{i:0;s:17:"Nurhady Sirimorok";}s:9:"publisher";N;s:14:"published_date";s:10:"2008-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:4;a:12:{s:15:"open_library_id";s:18:"/works/OL16715362W";s:4:"isbn";N;s:5:"title";s:24:"Laskar pelangi song book";s:7:"authors";a:1:{i:0;s:13:"Andrea Hirata";}s:9:"publisher";N;s:14:"published_date";s:10:"2012-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:5;a:12:{s:15:"open_library_id";s:18:"/works/OL19954956W";s:4:"isbn";N;s:5:"title";s:29:"Tian hong zhan dui xiao xue =";s:7:"authors";a:1:{i:0;s:13:"Andrea Hirata";}s:9:"publisher";N;s:14:"published_date";s:10:"2011-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:6;a:12:{s:15:"open_library_id";s:18:"/works/OL22379749W";s:4:"isbn";N;s:5:"title";s:33:"Laskar pejuang 9 wanita wirausaha";s:7:"authors";a:1:{i:0;s:12:"Henry Ismono";}s:9:"publisher";N;s:14:"published_date";s:10:"2010-01-01";s:11:"description";N;s:9:"cover_url";s:50:"https://covers.openlibrary.org/b/id/13844400-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:7;a:12:{s:15:"open_library_id";s:16:"/works/OL945693W";s:4:"isbn";N;s:5:"title";s:33:"Badai pembalasan Laskar Mujahidin";s:7:"authors";a:1:{i:0;s:13:"Rustam Kastor";}s:9:"publisher";N;s:14:"published_date";s:10:"2000-01-01";s:11:"description";N;s:9:"cover_url";s:49:"https://covers.openlibrary.org/b/id/4540598-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:8;a:12:{s:15:"open_library_id";s:17:"/works/OL5988233W";s:4:"isbn";N;s:5:"title";s:12:"Laskar Jihad";s:7:"authors";a:1:{i:0;s:16:"Mohammad Shoelhi";}s:9:"publisher";N;s:14:"published_date";s:10:"2002-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:9;a:12:{s:15:"open_library_id";s:18:"/works/OL13429456W";s:4:"isbn";N;s:5:"title";s:9:"Laskarē";s:7:"authors";a:1:{i:0;s:21:"Marinos Kousoumidēs";}s:9:"publisher";N;s:14:"published_date";s:10:"1982-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:10;a:12:{s:15:"open_library_id";s:18:"/works/OL27281446W";s:4:"isbn";N;s:5:"title";s:7:"Voyages";s:7:"authors";a:1:{i:0;s:11:"Adom Sample";}s:9:"publisher";N;s:14:"published_date";s:10:"2008-01-01";s:11:"description";N;s:9:"cover_url";s:50:"https://covers.openlibrary.org/b/id/12606145-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:11;a:12:{s:15:"open_library_id";s:18:"/works/OL23140009W";s:4:"isbn";N;s:5:"title";s:36:"Laskar ulama-santri & resolusi jihad";s:7:"authors";a:1:{i:0;s:20:"Zainul Milal Bizawie";}s:9:"publisher";N;s:14:"published_date";s:10:"2014-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:12;a:12:{s:15:"open_library_id";s:18:"/works/OL21210922W";s:4:"isbn";N;s:5:"title";s:27:"The Atlas of Reds and Blues";s:7:"authors";a:1:{i:0;s:14:"Devi S. Laskar";}s:9:"publisher";N;s:14:"published_date";s:10:"2019-01-01";s:11:"description";N;s:9:"cover_url";s:50:"https://covers.openlibrary.org/b/id/10618387-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:13;a:12:{s:15:"open_library_id";s:18:"/works/OL11729587W";s:4:"isbn";N;s:5:"title";s:14:"Laskar Sabrang";s:7:"authors";a:1:{i:0;s:22:"Purwadmadi Admadipurwa";}s:9:"publisher";N;s:14:"published_date";s:10:"2006-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:14;a:12:{s:15:"open_library_id";s:18:"/works/OL44029657W";s:4:"isbn";N;s:5:"title";s:8:"Laskarē";s:7:"authors";a:1:{i:0;s:20:"Marinos Kousoumidēs";}s:9:"publisher";N;s:14:"published_date";s:10:"1982-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:15;a:12:{s:15:"open_library_id";s:18:"/works/OL13774858W";s:4:"isbn";N;s:5:"title";s:29:"Di balik layar Laskar pelangi";s:7:"authors";a:1:{i:0;s:20:"Rita Triana Budiarti";}s:9:"publisher";N;s:14:"published_date";s:10:"2008-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:16;a:12:{s:15:"open_library_id";s:18:"/works/OL16983416W";s:4:"isbn";N;s:5:"title";s:26:"Modern receiver front-ends";s:7:"authors";a:1:{i:0;s:10:"Joy Laskar";}s:9:"publisher";N;s:14:"published_date";s:10:"2004-01-01";s:11:"description";N;s:9:"cover_url";s:49:"https://covers.openlibrary.org/b/id/1243745-L.jpg";s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:17;a:12:{s:15:"open_library_id";s:18:"/works/OL23639746W";s:4:"isbn";N;s:5:"title";s:16:"Laskar Hizbullah";s:7:"authors";a:0:{}s:9:"publisher";N;s:14:"published_date";s:10:"1995-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:18;a:12:{s:15:"open_library_id";s:18:"/works/OL25229275W";s:4:"isbn";N;s:5:"title";s:28:"Atlas of Reds and Blues EPub";s:7:"authors";a:1:{i:0;s:11:"Devi Laskar";}s:9:"publisher";N;s:14:"published_date";s:10:"2019-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}i:19;a:12:{s:15:"open_library_id";s:18:"/works/OL22381422W";s:4:"isbn";N;s:5:"title";s:32:"Laporan investigasi konflik Poso";s:7:"authors";a:1:{i:0;s:16:"Laskar Mujahidin";}s:9:"publisher";N;s:14:"published_date";s:10:"2001-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}}',1791819267),
('laravel-cache-books_search_5ce2807c8a5638442de0e6d877d6da30','a:1:{i:0;a:12:{s:15:"open_library_id";s:18:"/works/OL42709469W";s:4:"isbn";N;s:5:"title";s:14:"automic habbit";s:7:"authors";a:1:{i:0;s:11:"James Clear";}s:9:"publisher";N;s:14:"published_date";s:10:"2018-01-01";s:11:"description";N;s:9:"cover_url";N;s:10:"categories";a:0:{}s:10:"page_count";N;s:10:"avg_rating";N;s:13:"ratings_count";N;}}',1791824959),
('laravel-cache-5c785c036466adea360111aa28563bfd556b5fba:timer','i:1791822960;',1791822960),
('laravel-cache-5c785c036466adea360111aa28563bfd556b5fba','i:1;',1791822961);

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` VARCHAR(255) not null,
  `owner` VARCHAR(255) not null,
  `expiration` INT not null,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` INT primary key AUTO_INCREMENT not null,
  `queue` VARCHAR(255) not null,
  `payload` text not null,
  `attempts` INT not null,
  `reserved_at` INT,
  `available_at` INT not null,
  `created_at` INT not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` VARCHAR(255) not null,
  `name` VARCHAR(255) not null,
  `total_jobs` INT not null,
  `pending_jobs` INT not null,
  `failed_jobs` INT not null,
  `failed_job_ids` text not null,
  `options` text,
  `cancelled_at` INT,
  `created_at` INT not null,
  `finished_at` INT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` INT primary key AUTO_INCREMENT not null,
  `uuid` VARCHAR(255) not null,
  `connection` VARCHAR(255) not null,
  `queue` VARCHAR(255) not null,
  `payload` text not null,
  `exception` text not null,
  `failed_at` datetime not null default CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` INT primary key AUTO_INCREMENT not null,
  `tokenable_type` VARCHAR(255) not null,
  `tokenable_id` INT not null,
  `name` text not null,
  `token` VARCHAR(255) not null,
  `abilities` text,
  `last_used_at` datetime,
  `expires_at` datetime,
  `created_at` datetime,
  `updated_at` datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` (`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) VALUES
(1,'App\\Models\\User',3,'bukulapak','3ad08606061c64e1a1a43f83f3cdee56aedb8393a03385b874c0cd0ada964ffe','["*"]','2026-10-12 07:59:24',NULL,'2026-10-12 07:59:23','2026-10-12 07:59:24'),
(2,'App\\Models\\User',3,'bukulapak','2d2b97b9b5578dc3e8544674dc84960b2e72dff2a31e47bb57a6337cdc391531','["*"]','2026-10-12 07:59:38',NULL,'2026-10-12 07:59:36','2026-10-12 07:59:38'),
(3,'App\\Models\\User',3,'bukulapak','188a469dd9c1a42956a0d5d4b75440a1de1933ac5b09f7b9077ad2b0f8a7c389','["*"]','2026-10-12 07:59:55',NULL,'2026-10-12 07:59:52','2026-10-12 07:59:55'),
(5,'App\\Models\\User',1,'bukulapak','d2e82f4513741ca88d6cd15dab9c1f8ee6986184deadca5275d5c2ae1c2b9318','["*"]','2026-10-12 14:40:58',NULL,'2026-10-12 14:40:57','2026-10-12 14:40:58'),
(6,'App\\Models\\User',1,'bukulapak','8fcc3476964c09924f45774134f3498c33ec22f7404ee471a5ac16b41e716562','["*"]','2026-10-12 14:42:07',NULL,'2026-10-12 14:42:07','2026-10-12 14:42:07'),
(7,'App\\Models\\User',3,'bukulapak','db7bfcd4d72aa00a78ab7908d1393c596bb8a4b42b3e837827fbdf54325d4e86','["*"]','2026-10-12 15:35:39',NULL,'2026-10-12 15:35:39','2026-10-12 15:35:39'),
(8,'App\\Models\\User',3,'bukulapak','91b18b7dd5e86961b37158c0fc4433d2f7003ee52fad2ba93ef4f38af7fcf327','["*"]','2026-10-12 15:36:05',NULL,'2026-10-12 15:36:04','2026-10-12 15:36:05'),
(9,'App\\Models\\User',2,'bukulapak','07a830f132145bba253392b8d18105643aad891eecd88d534f8f5187de92c407','["*"]','2026-10-12 15:36:06',NULL,'2026-10-12 15:36:05','2026-10-12 15:36:06'),
(10,'App\\Models\\User',1,'bukulapak','f3c0444935beb8518a8f1044d31cf63b30ee3d7a3d256249f33b5c1bf6979118','["*"]','2026-10-12 15:36:25',NULL,'2026-10-12 15:36:24','2026-10-12 15:36:25'),
(11,'App\\Models\\User',1,'bukulapak','71d182cf6e74040c66082032800f36a2f31c9dfa36168e0beedc6745e9be7d83','["*"]',NULL,NULL,'2026-10-12 15:55:26','2026-10-12 15:55:26'),
(12,'App\\Models\\User',5,'bukulapak','510f5633028e290c97017e201681d4fd70adbca7fb1d7217b688a5e8912e7f50','["*"]','2026-10-12 15:55:38',NULL,'2026-10-12 15:55:37','2026-10-12 15:55:38'),
(13,'App\\Models\\User',1,'bukulapak','424118ffa52ae9f5a13f04087876ddb98613c452073d8fd9ea63d83e8bb474d2','["*"]','2026-10-12 16:06:49',NULL,'2026-10-12 16:06:48','2026-10-12 16:06:49'),
(14,'App\\Models\\User',5,'bukulapak','cb0425078f5ed9bc43f429972be7eaf829d8566184004355eb396f269993982a','["*"]','2026-10-12 16:13:00',NULL,'2026-10-12 16:12:59','2026-10-12 16:13:00'),
(15,'App\\Models\\User',5,'bukulapak','ba72da136524ac22d185c4ac4af387d56d2ee7032a1ff084c05cd19191248a68','["*"]','2026-10-12 16:13:19',NULL,'2026-10-12 16:13:18','2026-10-12 16:13:19'),
(16,'App\\Models\\User',5,'bukulapak','804b48dd8ecfa4055b3ec6aabc68cd4c98696b80d111d83876f845306bf0f2dc','["*"]','2026-10-12 16:22:19',NULL,'2026-10-12 16:22:18','2026-10-12 16:22:19'),
(17,'App\\Models\\User',5,'bukulapak','55280c221e3a2db224a201a161c2c9d953518e17437073e4bd3e872a5c818faf','["*"]','2026-10-12 16:23:57',NULL,'2026-10-12 16:23:56','2026-10-12 16:23:57'),
(19,'App\\Models\\User',4,'bukulapak','322f83c4e16e711a67b15b4fb257356e57b9a2f8c6366c730bb3833036a6f8a9','["*"]','2026-10-12 16:35:12',NULL,'2026-10-12 16:35:01','2026-10-12 16:35:12');

DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` INT primary key AUTO_INCREMENT not null,
  `open_library_id` VARCHAR(255),
  `isbn` VARCHAR(255),
  `title` VARCHAR(255) not null,
  `authors` text,
  `publisher` VARCHAR(255),
  `published_date` VARCHAR(255),
  `description` text,
  `cover_url` VARCHAR(255),
  `categories` text,
  `page_count` INT,
  `avg_rating` DECIMAL(10,2),
  `ratings_count` INT not null default '0',
  `created_at` datetime,
  `updated_at` datetime
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `books` (`id`,`open_library_id`,`isbn`,`title`,`authors`,`publisher`,`published_date`,`description`,`cover_url`,`categories`,`page_count`,`avg_rating`,`ratings_count`,`created_at`,`updated_at`) VALUES
(1,'/works/OL82563W',NULL,'Harry Potter and the Philosopher\'s Stone','["J. K. Rowling"]','Bloomsbury','1997-06-26','Petualangan pertama Harry Potter di Hogwarts.','https://covers.openlibrary.org/b/id/15155833-L.jpg','["Fantasy"]',223,4.67,3,'2026-10-12 07:58:15','2026-10-12 07:59:37'),
(2,'/works/OL262758W',NULL,'Laskar Pelangi','["Andrea Hirata"]','Bentang Pustaka','2005-01-01','Kisah inspiratif anak-anak Belitung.','https://covers.openlibrary.org/b/id/7079796-L.jpg','["Fiksi Indonesia"]',529,4.5,2,'2026-10-12 07:58:15','2026-10-12 15:18:57'),
(3,'/works/OL14906239W',NULL,'Atomic Habits','["James Clear"]','Avery','2018-10-16','Membangun kebiasaan baik lewat perubahan kecil.','https://covers.openlibrary.org/b/id/12539702-L.jpg','["Self-Help"]',320,4.5,2,'2026-10-12 07:58:15','2026-10-12 15:19:01'),
(4,'/works/OL15302003W',NULL,'Laskar Pelangi','["Andrea Hirata"]',NULL,'2005-01-01',NULL,'https://covers.openlibrary.org/b/id/7079796-L.jpg','[]',NULL,4,2,'2026-10-12 14:34:32','2026-10-12 15:14:44'),
(5,'/works/OL27482W',NULL,'The Hobbit','["J.R.R. Tolkien"]',NULL,'1937-01-01',NULL,'https://covers.openlibrary.org/b/id/14627509-L.jpg',NULL,NULL,3,1,'2026-10-12 15:11:40','2026-10-12 15:14:45'),
(6,'/works/OL27448W',NULL,'The Lord of the Rings','["J.R.R. Tolkien"]',NULL,'1954-01-01',NULL,'https://covers.openlibrary.org/b/id/14625765-L.jpg',NULL,NULL,5,1,'2026-10-12 15:11:43','2026-10-12 15:14:45'),
(7,'/works/OL3140822W',NULL,'To Kill a Mockingbird','["Harper Lee"]',NULL,'1960-01-01',NULL,'https://covers.openlibrary.org/b/id/14351077-L.jpg',NULL,NULL,5,1,'2026-10-12 15:11:45','2026-10-12 15:14:45'),
(8,'/works/OL1168083W',NULL,'Nineteen Eighty-Four','["George Orwell"]',NULL,'1949-01-01',NULL,'https://covers.openlibrary.org/b/id/9267242-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:11:47','2026-10-12 15:11:47'),
(9,'/works/OL1168007W',NULL,'Animal Farm','["George Orwell"]',NULL,'1945-01-01',NULL,'https://covers.openlibrary.org/b/id/11261770-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:11:49','2026-10-12 15:11:49'),
(10,'/works/OL66554W',NULL,'Pride and Prejudice','["Jane Austen"]',NULL,'1813-01-01',NULL,'https://covers.openlibrary.org/b/id/14348537-L.jpg',NULL,NULL,5,1,'2026-10-12 15:11:51','2026-10-12 15:14:45'),
(11,'/works/OL468431W',NULL,'The Great Gatsby','["F. Scott Fitzgerald"]',NULL,'1920-01-01',NULL,'https://covers.openlibrary.org/b/id/10590366-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:11:53','2026-10-12 15:11:53'),
(12,'/works/OL1095427W',NULL,'Jane Eyre','["Charlotte Bronte\\u0308"]',NULL,'1847-01-01',NULL,'https://covers.openlibrary.org/b/id/8235363-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:11:54','2026-10-12 15:11:54'),
(13,'/works/OL3335245W',NULL,'The Catcher in the Rye','["J. D. Salinger","Shao jia yun"]',NULL,'1945-01-01',NULL,'https://covers.openlibrary.org/b/id/9273490-L.jpg',NULL,NULL,4,1,'2026-10-12 15:11:57','2026-10-12 15:14:45'),
(14,'/works/OL455327W',NULL,'Lord of the Flies','["William Golding"]',NULL,'1954-01-01',NULL,'https://covers.openlibrary.org/b/id/8684447-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:01','2026-10-12 15:12:01'),
(15,'/works/OL71037W',NULL,'The Lion, the Witch and the Wardrobe','["C. S. Lewis"]',NULL,'1950-01-01',NULL,'https://covers.openlibrary.org/b/id/8441376-L.jpg',NULL,NULL,4,2,'2026-10-12 15:12:03','2026-10-12 15:14:45'),
(16,'/works/OL893414W',NULL,'Dune','["Frank Herbert"]',NULL,'1965-01-01',NULL,'https://covers.openlibrary.org/b/id/11481354-L.jpg',NULL,NULL,5,1,'2026-10-12 15:12:05','2026-10-12 15:14:45'),
(17,'/works/OL46125W',NULL,'Foundation','["Isaac Asimov"]',NULL,'1951-01-01',NULL,'https://covers.openlibrary.org/b/id/14612610-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:06','2026-10-12 15:12:06'),
(18,'/works/OL2163649W',NULL,'The Hitchhiker\'s Guide to the Galaxy','["Douglas Adams"]',NULL,'1979-01-01',NULL,'https://covers.openlibrary.org/b/id/12986869-L.jpg',NULL,NULL,4,2,'2026-10-12 15:12:08','2026-10-12 15:14:44'),
(19,'/works/OL64365W',NULL,'Brave New World','["Aldous Huxley"]',NULL,'1932-01-01',NULL,'https://covers.openlibrary.org/b/id/8231823-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:10','2026-10-12 15:12:10'),
(20,'/works/OL103123W',NULL,'Fahrenheit 451','["Ray Bradbury"]',NULL,'1953-01-01',NULL,'https://covers.openlibrary.org/b/id/12993656-L.jpg',NULL,NULL,4,1,'2026-10-12 15:12:11','2026-10-12 15:14:45'),
(21,'/works/OL796465W',NULL,'O Alquimista','["Paulo Coelho"]',NULL,'1988-01-01',NULL,'https://covers.openlibrary.org/b/id/7414780-L.jpg',NULL,NULL,4,2,'2026-10-12 15:12:12','2026-10-12 15:14:45'),
(22,'/works/OL10263W',NULL,'Le petit prince','["Antoine de Saint-Exup\\u00e9ry"]',NULL,'1943-01-01',NULL,'https://covers.openlibrary.org/b/id/10708272-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:14','2026-10-12 15:12:14'),
(23,'/works/OL5781992W',NULL,'The Kite Runner','["Khaled Hosseini"]',NULL,'2003-01-01',NULL,'https://covers.openlibrary.org/b/id/14846827-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:15','2026-10-12 15:12:15'),
(24,'/works/OL5782000W',NULL,'A Thousand Splendid Suns','["Khaled Hosseini"]',NULL,'2007-01-01',NULL,'https://covers.openlibrary.org/b/id/8579790-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:16','2026-10-12 15:12:16'),
(25,'/works/OL5819456W',NULL,'The Book Thief','["Markus Zusak"]',NULL,'1998-01-01',NULL,'https://covers.openlibrary.org/b/id/8153054-L.jpg',NULL,NULL,5,1,'2026-10-12 15:12:21','2026-10-12 15:14:44'),
(26,'/works/OL76837W',NULL,'The Da Vinci Code','["Dan Brown"]',NULL,'2003-01-01',NULL,'https://covers.openlibrary.org/b/id/9255229-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:23','2026-10-12 15:12:23'),
(27,'/works/OL5735363W',NULL,'The Hunger Games','["Suzanne Collins"]',NULL,'2008-01-01',NULL,'https://covers.openlibrary.org/b/id/12646537-L.jpg',NULL,NULL,5,1,'2026-10-12 15:12:26','2026-10-12 15:14:45'),
(28,'/works/OL5720023W',NULL,'Twilight','["Stephenie Meyer"]',NULL,'2005-01-01',NULL,'https://covers.openlibrary.org/b/id/12641977-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:29','2026-10-12 15:12:29'),
(29,'/works/OL16444438W',NULL,'The Fault in Our Stars','["John Green"]',NULL,'2010-01-01',NULL,'https://covers.openlibrary.org/b/id/7418786-L.jpg',NULL,NULL,4,1,'2026-10-12 15:12:33','2026-10-12 15:14:45'),
(30,'/works/OL15992072W',NULL,'Thinking, fast and slow','["Daniel Kahneman"]',NULL,'2011-01-01',NULL,'https://covers.openlibrary.org/b/id/13290711-L.jpg',NULL,NULL,4,1,'2026-10-12 15:12:35','2026-10-12 15:14:45'),
(31,'/works/OL17075811W',NULL,'Sapiens','["Yuval Noah Harari"]',NULL,'2011-01-01',NULL,'https://covers.openlibrary.org/b/id/8634250-L.jpg',NULL,NULL,5,1,'2026-10-12 15:12:38','2026-10-12 15:14:45'),
(32,'/works/OL2780331W',NULL,'The psychology of money','["Henry Clay Lindgren"]',NULL,'1991-01-01',NULL,'https://covers.openlibrary.org/b/id/6694177-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:40','2026-10-12 15:12:40'),
(33,'/works/OL2010879W',NULL,'Rich Dad, Poor Dad','["Robert T. Kiyosaki"]',NULL,'1990-01-01',NULL,'https://covers.openlibrary.org/b/id/8315603-L.jpg',NULL,NULL,4,1,'2026-10-12 15:12:42','2026-10-12 15:14:45'),
(34,'/works/OL2629977W',NULL,'The 7 Habits of Highly Effective People','["Stephen R. Covey"]',NULL,'1989-01-01',NULL,'https://covers.openlibrary.org/b/id/10079937-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:45','2026-10-12 15:12:45'),
(35,'/works/OL19714233W',NULL,'Ikigai','["H\\u00e9ctor Garc\\u00eda","Francesc Miralles"]',NULL,'2016-01-01',NULL,'https://covers.openlibrary.org/b/id/11300391-L.jpg',NULL,NULL,4,1,'2026-10-12 15:12:46','2026-10-12 15:14:44'),
(36,'/works/OL17590212W',NULL,'The Subtle Art of Not Giving a F*ck','["Mark Manson"]',NULL,'2016-01-01',NULL,'https://covers.openlibrary.org/b/id/8231990-L.jpg',NULL,NULL,5,1,'2026-10-12 15:12:48','2026-10-12 15:14:45'),
(37,'/works/OL18139176W',NULL,'Educated','["Tara Westover","Orah Dan\\u1e33ner"]',NULL,'2018-01-01',NULL,'https://covers.openlibrary.org/b/id/8314077-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:49','2026-10-12 15:12:49'),
(38,'/works/OL17930367W',NULL,'Becoming','["Michelle Obama"]',NULL,'2018-01-01',NULL,'https://covers.openlibrary.org/b/id/8824664-L.jpg',NULL,NULL,3.5,2,'2026-10-12 15:12:53','2026-10-12 15:14:45'),
(39,'/works/OL16085155W',NULL,'Steve Jobs','["Walter Isaacson"]',NULL,'2011-01-01',NULL,'https://covers.openlibrary.org/b/id/12374726-L.jpg',NULL,NULL,4,2,'2026-10-12 15:12:55','2026-10-12 15:14:45'),
(40,'/works/OL262421W',NULL,'The Adventures of Sherlock Holmes [12 stories]','["Arthur Conan Doyle"]',NULL,'1892-01-01',NULL,'https://covers.openlibrary.org/b/id/6717853-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:12:57','2026-10-12 15:12:57'),
(41,'/works/OL471565W',NULL,'And Then There Were None','["Agatha Christie"]',NULL,'1939-01-01',NULL,'https://covers.openlibrary.org/b/id/11172296-L.jpg',NULL,NULL,4,2,'2026-10-12 15:12:59','2026-10-12 15:14:45'),
(42,'/works/OL471576W',NULL,'Murder on the Orient Express','["Agatha Christie"]',NULL,'1933-01-01',NULL,'https://covers.openlibrary.org/b/id/11100465-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:13:01','2026-10-12 15:13:01'),
(43,'/works/OL19096402W',NULL,'The Silent Patient','["Alex Michaelides"]',NULL,'2018-01-01',NULL,'https://covers.openlibrary.org/b/id/9407338-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:13:02','2026-10-12 15:13:02'),
(44,'/works/OL16239762W',NULL,'Gone Girl','["Gillian Flynn"]',NULL,'2011-01-01',NULL,'https://covers.openlibrary.org/b/id/8368314-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:13:03','2026-10-12 15:13:03'),
(45,'/works/OL20965973W',NULL,'The Midnight Library','["Matt Haig"]',NULL,'2020-01-01',NULL,'https://covers.openlibrary.org/b/id/10313767-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:13:06','2026-10-12 15:13:06'),
(46,'/works/OL21745884W',NULL,'Project Hail Mary','["Andy Weir"]',NULL,'2021-01-01',NULL,'https://covers.openlibrary.org/b/id/11200092-L.jpg',NULL,NULL,4,1,'2026-10-12 15:13:07','2026-10-12 15:14:45'),
(47,'/works/OL18012166W',NULL,'Circe','["Madeline Miller"]',NULL,'2018-01-01',NULL,'https://covers.openlibrary.org/b/id/8739376-L.jpg',NULL,NULL,3,1,'2026-10-12 15:13:08','2026-10-12 15:14:45'),
(48,'/works/OL16509148W',NULL,'The Song of Achilles','["Madeline Miller"]',NULL,'2011-01-01',NULL,'https://covers.openlibrary.org/b/id/7098465-L.jpg',NULL,NULL,4,2,'2026-10-12 15:13:10','2026-10-12 15:14:45'),
(49,'/works/OL2625457W',NULL,'Norwegian Wood','["\\u6751\\u4e0a\\u6625\\u6a39"]',NULL,'1987-01-01',NULL,'https://covers.openlibrary.org/b/id/2237620-L.jpg',NULL,NULL,5,1,'2026-10-12 15:13:11','2026-10-12 15:14:45'),
(50,'/works/OL2625431W',NULL,'海辺のカフカ','["\\u6751\\u4e0a\\u6625\\u6a39"]',NULL,'2001-01-01',NULL,'https://covers.openlibrary.org/b/id/4982600-L.jpg',NULL,NULL,4,2,'2026-10-12 15:13:13','2026-10-12 15:14:45'),
(51,'/works/OL24028184W',NULL,'Sang pemimpi','["Andrea Hirata"]',NULL,'2006-01-01',NULL,'https://covers.openlibrary.org/b/id/15218349-L.jpg',NULL,NULL,3,1,'2026-10-12 15:13:15','2026-10-12 15:14:45'),
(52,'/works/OL15302002W',NULL,'Edensor','["Andrea Hirata"]',NULL,'2008-01-01',NULL,'https://covers.openlibrary.org/b/id/9986435-L.jpg',NULL,NULL,5,1,'2026-10-12 15:13:16','2026-10-12 15:14:45'),
(53,'/works/OL307247W',NULL,'Bumi Manusia','["Pramoedya Ananta Toer"]',NULL,'1972-01-01',NULL,'https://covers.openlibrary.org/b/id/6643692-L.jpg',NULL,NULL,3.5,2,'2026-10-12 15:13:18','2026-10-12 15:14:45'),
(54,'/works/OL307178W',NULL,'Anak Semua Bangsa','["Pramoedya Ananta Toer"]',NULL,'1973-01-01',NULL,'https://covers.openlibrary.org/b/id/6635926-L.jpg',NULL,NULL,NULL,0,'2026-10-12 15:13:22','2026-10-12 15:13:22'),
(55,'/works/OL42709469W',NULL,'automic habbit','["James Clear"]',NULL,'2018-01-01',NULL,NULL,'[]',NULL,NULL,0,'2026-10-12 16:09:21','2026-10-12 16:09:21');

DROP TABLE IF EXISTS `reviews`;
CREATE TABLE `reviews` (
  `id` INT primary key AUTO_INCREMENT not null,
  `user_id` INT not null,
  `book_id` INT not null,
  `rating` INT not null,
  `title` VARCHAR(255),
  `content` text not null,
  `likes_count` INT not null default '0',
  `created_at` datetime,
  `updated_at` datetime,
  KEY `user_id` (`user_id`),
  CONSTRAINT `reviews_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)on delete cascade,
  KEY `book_id` (`book_id`),
  CONSTRAINT `reviews_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `reviews` (`id`,`user_id`,`book_id`,`rating`,`title`,`content`,`likes_count`,`created_at`,`updated_at`) VALUES
(1,1,1,5,'Wajib baca!','Buku yang sangat berkesan, ceritanya mengalir dan sulit berhenti dibaca.',1,'2026-10-12 07:58:15','2026-10-12 07:59:38'),
(2,2,1,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 07:58:15','2026-10-12 07:58:15'),
(3,1,2,5,'Wajib baca!','Buku yang sangat berkesan, ceritanya mengalir dan sulit berhenti dibaca.',0,'2026-10-12 07:58:15','2026-10-12 07:58:15'),
(4,2,2,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 07:58:15','2026-10-12 07:58:15'),
(5,1,3,5,'Wajib baca!','Buku yang sangat berkesan, ceritanya mengalir dan sulit berhenti dibaca.',0,'2026-10-12 07:58:15','2026-10-12 07:58:15'),
(6,2,3,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 07:58:15','2026-10-12 07:58:15'),
(7,3,1,5,'Luar biasa','Salah satu buku terbaik yang pernah saya baca.',0,'2026-10-12 07:59:37','2026-10-12 07:59:37'),
(8,1,4,5,'Luar biasa','Salah satu buku terbaik yang pernah saya baca. Alurnya mengalir dan sulit berhenti.',0,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(9,2,4,3,'Lumayan','Bagus di paruh kedua, awalnya perlu kesabaran.',0,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(10,2,25,5,'Wajib baca!','Ceritanya berkesan dan membekas lama setelah selesai dibaca.',0,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(11,3,35,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(12,4,18,4,'Recommended','Gaya bahasanya enak diikuti, cocok untuk dibaca santai.',0,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(13,5,18,4,'Seru','Konfliknya bikin penasaran sampai halaman terakhir.',0,'2026-10-12 15:14:44','2026-10-12 15:14:44'),
(14,5,6,5,'Sangat menginspirasi','Banyak pelajaran hidup yang bisa dipetik dari buku ini.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(15,6,5,3,'Lumayan','Bagus di paruh kedua, awalnya perlu kesabaran.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(16,1,41,4,'Menarik','Sudut pandangnya segar, tidak seperti buku sejenis.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(17,2,41,4,'Bacaan wajib','Sudah saya rekomendasikan ke tiga teman dan semuanya suka.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(18,2,27,5,'Masterpiece','Setiap halaman terasa padat makna. Pantas jadi klasik.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(19,3,20,4,'Seru','Konfliknya bikin penasaran sampai halaman terakhir.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(20,4,38,3,'Cukup bagus','Ada bagian yang bertele-tele, tapi endingnya memuaskan.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(21,5,38,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(22,5,7,5,'Menyentuh','Beberapa bagian sampai membuat saya berhenti sejenak untuk merenung.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(23,6,33,4,'Bacaan wajib','Sudah saya rekomendasikan ke tiga teman dan semuanya suka.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(24,1,50,5,'Luar biasa','Salah satu buku terbaik yang pernah saya baca. Alurnya mengalir dan sulit berhenti.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(25,2,50,3,'Lumayan','Bagus di paruh kedua, awalnya perlu kesabaran.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(26,2,52,5,'Wajib baca!','Ceritanya berkesan dan membekas lama setelah selesai dibaca.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(27,3,30,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(28,4,39,4,'Recommended','Gaya bahasanya enak diikuti, cocok untuk dibaca santai.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(29,5,39,4,'Seru','Konfliknya bikin penasaran sampai halaman terakhir.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(30,5,10,5,'Sangat menginspirasi','Banyak pelajaran hidup yang bisa dipetik dari buku ini.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(31,6,47,3,'Lumayan','Bagus di paruh kedua, awalnya perlu kesabaran.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(32,1,21,4,'Menarik','Sudut pandangnya segar, tidak seperti buku sejenis.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(33,2,21,4,'Bacaan wajib','Sudah saya rekomendasikan ke tiga teman dan semuanya suka.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(34,2,31,5,'Masterpiece','Setiap halaman terasa padat makna. Pantas jadi klasik.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(35,3,13,4,'Seru','Konfliknya bikin penasaran sampai halaman terakhir.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(36,4,53,3,'Cukup bagus','Ada bagian yang bertele-tele, tapi endingnya memuaskan.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(37,5,53,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(38,5,16,5,'Menyentuh','Beberapa bagian sampai membuat saya berhenti sejenak untuk merenung.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(39,6,46,4,'Bacaan wajib','Sudah saya rekomendasikan ke tiga teman dan semuanya suka.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(40,1,15,5,'Luar biasa','Salah satu buku terbaik yang pernah saya baca. Alurnya mengalir dan sulit berhenti.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(41,2,15,3,'Lumayan','Bagus di paruh kedua, awalnya perlu kesabaran.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(42,2,49,5,'Wajib baca!','Ceritanya berkesan dan membekas lama setelah selesai dibaca.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(43,3,29,4,'Bagus','Menikmati setiap babnya, walau awalnya agak lambat.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(44,4,48,4,'Recommended','Gaya bahasanya enak diikuti, cocok untuk dibaca santai.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(45,5,48,4,'Seru','Konfliknya bikin penasaran sampai halaman terakhir.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(46,5,36,5,'Sangat menginspirasi','Banyak pelajaran hidup yang bisa dipetik dari buku ini.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45'),
(47,6,51,3,'Lumayan','Bagus di paruh kedua, awalnya perlu kesabaran.',0,'2026-10-12 15:14:45','2026-10-12 15:14:45');

DROP TABLE IF EXISTS `listings`;
CREATE TABLE `listings` (
  `id` INT primary key AUTO_INCREMENT not null,
  `user_id` INT not null,
  `book_id` INT not null,
  `condition` VARCHAR(255) not null default 'good',
  `price` INT not null,
  `location_city` VARCHAR(255) not null,
  `description` text,
  `images` text,
  `status` VARCHAR(255) not null default 'active',
  `created_at` datetime,
  `updated_at` datetime,
  `wa_number` VARCHAR(255),
  KEY `user_id` (`user_id`),
  CONSTRAINT `listings_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)on delete cascade,
  KEY `book_id` (`book_id`),
  CONSTRAINT `listings_book_id_foreign` FOREIGN KEY (`book_id`) REFERENCES `books` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `listings` (`id`,`user_id`,`book_id`,`condition`,`price`,`location_city`,`description`,`images`,`status`,`created_at`,`updated_at`,`wa_number`) VALUES
(1,1,1,'good',45000,'Jakarta','Kondisi mulus, tanpa coretan.',NULL,'active','2026-10-12 07:58:15','2026-10-12 16:07:14','6281234567890'),
(2,1,2,'good',45000,'Jakarta','Kondisi mulus, tanpa coretan.',NULL,'active','2026-10-12 07:58:15','2026-10-12 15:28:09','6281234567890'),
(3,1,3,'good',45000,'Jakarta','Kondisi mulus, tanpa coretan.',NULL,'active','2026-10-12 07:58:15','2026-10-12 15:28:09','6281234567890'),
(4,2,1,'like_new',60000,'Bandung','Seperti baru, hanya dibaca sekali.',NULL,'active','2026-10-12 07:58:15','2026-10-12 15:28:09','6281234567890'),
(6,1,5,'like_new',35000,'Jakarta','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(7,1,6,'good',45000,'Bandung','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(8,1,7,'good',50000,'Surabaya','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(9,1,8,'fair',55000,'Yogyakarta','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(10,1,9,'like_new',60000,'Semarang','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(11,1,10,'like_new',40000,'Jakarta','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(12,1,11,'good',65000,'Bandung','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(13,1,12,'good',30000,'Surabaya','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(14,1,13,'fair',70000,'Yogyakarta','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(15,1,14,'like_new',48000,'Semarang','Kondisi terawat, siap kirim.',NULL,'active','2026-10-12 15:13:22','2026-10-12 15:13:22','6281234567890'),
(16,3,1,'like_new',65000,'Bandung','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281211475775'),
(17,6,1,'fair',80000,'Yogyakarta','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281223084935'),
(18,6,2,'fair',30000,'Yogyakarta','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281238846120'),
(19,3,2,'good',60000,'Medan','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281258676967'),
(20,3,3,'good',35000,'Medan','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281259683721'),
(21,6,3,'good',40000,'Bandung','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281216478843'),
(22,6,4,'good',55000,'Bandung','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281285178377'),
(23,3,4,'new',50000,'Yogyakarta','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281273300090'),
(24,3,15,'new',45000,'Yogyakarta','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:11','2026-10-12 15:26:11','6281250790666'),
(25,6,15,'like_new',75000,'Medan','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281269971773'),
(26,6,18,'like_new',65000,'Medan','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281250795170'),
(27,3,18,'fair',80000,'Bandung','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281219328341'),
(28,3,21,'fair',30000,'Bandung','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281243576516'),
(29,6,21,'good',60000,'Yogyakarta','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281244639987'),
(30,6,38,'good',35000,'Yogyakarta','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281247566919'),
(31,3,38,'good',40000,'Medan','Stok terbatas, siapa cepat dia dapat.',NULL,'active','2026-10-12 15:26:12','2026-10-12 15:26:12','6281239911173');

DROP TABLE IF EXISTS `review_likes`;
CREATE TABLE `review_likes` (
  `id` INT primary key AUTO_INCREMENT not null,
  `user_id` INT not null,
  `review_id` INT not null,
  `created_at` datetime,
  `updated_at` datetime,
  KEY `user_id` (`user_id`),
  CONSTRAINT `review_likes_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)on delete cascade,
  KEY `review_id` (`review_id`),
  CONSTRAINT `review_likes_review_id_foreign` FOREIGN KEY (`review_id`) REFERENCES `reviews` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `review_likes` (`id`,`user_id`,`review_id`,`created_at`,`updated_at`) VALUES
(1,3,1,'2026-10-12 07:59:38','2026-10-12 07:59:38');

DROP TABLE IF EXISTS `bookmarks`;
CREATE TABLE `bookmarks` (
  `id` INT primary key AUTO_INCREMENT not null,
  `user_id` INT not null,
  `bookmarkable_type` VARCHAR(255) not null,
  `bookmarkable_id` INT not null,
  `created_at` datetime,
  `updated_at` datetime,
  KEY `user_id` (`user_id`),
  CONSTRAINT `bookmarks_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

DROP TABLE IF EXISTS `conversations`;
CREATE TABLE `conversations` (
  `id` INT primary key AUTO_INCREMENT not null,
  `listing_id` INT not null,
  `buyer_id` INT not null,
  `seller_id` INT not null,
  `last_message_at` datetime,
  `created_at` datetime,
  `updated_at` datetime,
  KEY `listing_id` (`listing_id`),
  CONSTRAINT `conversations_listing_id_foreign` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`)on delete cascade,
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `conversations_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`)on delete cascade,
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `conversations_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `conversations` (`id`,`listing_id`,`buyer_id`,`seller_id`,`last_message_at`,`created_at`,`updated_at`) VALUES
(1,1,3,1,'2026-10-12 07:59:54','2026-10-12 07:59:53','2026-10-12 07:59:54'),
(2,4,4,2,'2026-10-12 14:26:54','2026-10-12 14:26:54','2026-10-12 14:26:54'),
(3,18,4,6,'2026-10-12 16:03:03','2026-10-12 16:03:03','2026-10-12 16:03:03');

DROP TABLE IF EXISTS `messages`;
CREATE TABLE `messages` (
  `id` INT primary key AUTO_INCREMENT not null,
  `conversation_id` INT not null,
  `user_id` INT not null,
  `content` text not null,
  `read_at` datetime,
  `created_at` datetime,
  `updated_at` datetime,
  KEY `conversation_id` (`conversation_id`),
  CONSTRAINT `messages_conversation_id_foreign` FOREIGN KEY (`conversation_id`) REFERENCES `conversations` (`id`)on delete cascade,
  KEY `user_id` (`user_id`),
  CONSTRAINT `messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `messages` (`id`,`conversation_id`,`user_id`,`content`,`read_at`,`created_at`,`updated_at`) VALUES
(1,1,3,'Halo, apakah buku ini masih tersedia?',NULL,'2026-10-12 07:59:54','2026-10-12 07:59:54');

DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
  `id` INT primary key AUTO_INCREMENT not null,
  `code` VARCHAR(255) not null,
  `buyer_id` INT not null,
  `listing_id` INT not null,
  `seller_id` INT not null,
  `price` INT not null,
  `buyer_name` VARCHAR(255) not null,
  `buyer_note` text,
  `status` VARCHAR(255) not null default 'pending',
  `created_at` datetime,
  `updated_at` datetime,
  `payment_method` VARCHAR(255) not null default 'cod',
  `payment_proof` VARCHAR(255),
  KEY `buyer_id` (`buyer_id`),
  CONSTRAINT `orders_buyer_id_foreign` FOREIGN KEY (`buyer_id`) REFERENCES `users` (`id`)on delete cascade,
  KEY `listing_id` (`listing_id`),
  CONSTRAINT `orders_listing_id_foreign` FOREIGN KEY (`listing_id`) REFERENCES `listings` (`id`)on delete cascade,
  KEY `seller_id` (`seller_id`),
  CONSTRAINT `orders_seller_id_foreign` FOREIGN KEY (`seller_id`) REFERENCES `users` (`id`)on delete cascade
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `orders` (`id`,`code`,`buyer_id`,`listing_id`,`seller_id`,`price`,`buyer_name`,`buyer_note`,`status`,`created_at`,`updated_at`,`payment_method`,`payment_proof`) VALUES
(2,'BL-20261012-E9FA77',4,2,1,45000,'Oka',NULL,'pending','2026-10-12 15:55:23','2026-10-12 15:55:23','cod',NULL),
(6,'BL-20261012-1CFF46',5,3,1,45000,'Dewi Lestari','COD Sabtu','pending','2026-10-12 16:22:19','2026-10-12 16:22:19','cod',NULL),
(8,'BL-20261012-3A4B9F',4,1,1,45000,'Oka',NULL,'confirmed','2026-10-12 16:24:41','2026-10-12 16:34:47','cod',NULL);

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` INT primary key AUTO_INCREMENT not null,
  `migration` VARCHAR(255) not null,
  `batch` INT not null
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`,`migration`,`batch`) VALUES
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2026_10_12_000001_create_books_table',2),
(5,'2026_10_12_000002_create_reviews_table',2),
(6,'2026_10_12_000003_create_listings_table',2),
(7,'2026_10_12_000004_create_review_likes_table',2),
(8,'2026_10_12_000005_create_bookmarks_table',2),
(9,'2026_10_12_000006_create_conversations_table',2),
(10,'2026_10_12_000007_create_messages_table',2),
(11,'2026_10_12_075758_create_personal_access_tokens_table',2),
(12,'2026_10_12_000008_add_wa_number_to_listings',3),
(13,'2026_10_12_000009_create_orders_table',4),
(14,'2026_10_12_000010_add_payment_to_orders',5);

SET FOREIGN_KEY_CHECKS=1;
ALTER TABLE `users` ADD UNIQUE KEY `users_email_unique` (`email`);
ALTER TABLE `failed_jobs` ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);
ALTER TABLE `books` ADD UNIQUE KEY `books_open_library_id_unique` (`open_library_id`);
ALTER TABLE `reviews` ADD UNIQUE KEY `reviews_user_id_book_id_unique` (`user_id`,`book_id`);
ALTER TABLE `review_likes` ADD UNIQUE KEY `review_likes_user_id_review_id_unique` (`user_id`,`review_id`);
ALTER TABLE `bookmarks` ADD UNIQUE KEY `bookmarks_user_id_bookmarkable_type_bookmarkable_id_unique` (`user_id`,`bookmarkable_type`,`bookmarkable_id`);
ALTER TABLE `conversations` ADD UNIQUE KEY `conversations_listing_id_buyer_id_unique` (`listing_id`,`buyer_id`);
ALTER TABLE `personal_access_tokens` ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`);
ALTER TABLE `orders` ADD UNIQUE KEY `orders_code_unique` (`code`);