-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 30, 2026 at 03:31 PM
-- Server version: 8.0.30
-- PHP Version: 8.3.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tes_maganghub`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `items`
--

CREATE TABLE `items` (
  `id` bigint UNSIGNED NOT NULL,
  `kode_barang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nama_barang` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `satuan` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `harga_satuan` decimal(15,2) NOT NULL,
  `stock_awal` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `items`
--

INSERT INTO `items` (`id`, `kode_barang`, `nama_barang`, `satuan`, `harga_satuan`, `stock_awal`, `created_at`, `updated_at`) VALUES
(13, 'BG0001', 'Laptop Asus', 'Pcs', 1000000.00, 70, '2026-07-30 07:38:11', '2026-07-30 07:58:05'),
(14, 'BG0002', 'Mouse Logitech', 'Unit', 500000.00, 10, '2026-07-30 07:39:40', '2026-07-30 07:39:40'),
(15, 'BG0003', 'Keyboard Gamen', 'Pcs', 200000.00, 15, '2026-07-30 07:40:01', '2026-07-30 07:59:32'),
(16, 'BG0004', 'Camera Cannon', 'Unit', 2000000.00, 25, '2026-07-30 07:42:01', '2026-07-30 07:44:30'),
(17, 'BG0005', 'Proyektor Epson', 'Unit', 3000000.00, 100, '2026-07-30 07:42:49', '2026-07-30 08:06:07');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_07_29_141214_create_personal_access_tokens_table', 2),
(5, '2026_07_29_141947_create_items_table', 3),
(6, '2026_07_29_142051_create_transaksis_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 2, 'inventory-token', '2b29479761752f2863881c371fb7493022c6cb5b264d35665eae958a4b1171d7', '[\"*\"]', NULL, NULL, '2026-07-29 08:09:07', '2026-07-29 08:09:07'),
(3, 'App\\Models\\User', 2, 'inventory-token', '1303e05eaa722bafafcb84b6caab802af5e01d3c7f0fe1b8a9916e36ebed9231', '[\"*\"]', '2026-07-29 09:19:57', NULL, '2026-07-29 08:26:13', '2026-07-29 09:19:57'),
(4, 'App\\Models\\User', 2, 'inventory-token', 'a855222c7a2759acbc6ff4168c142610beecbda0d7a420285251355468885cdd', '[\"*\"]', NULL, NULL, '2026-07-29 17:46:33', '2026-07-29 17:46:33'),
(5, 'App\\Models\\User', 2, 'inventory-token', 'db6e91653516487a74066bec6e26dc176c1e19b3acdd6da5d22c3c4ce7f9eef9', '[\"*\"]', NULL, NULL, '2026-07-29 17:47:17', '2026-07-29 17:47:17'),
(6, 'App\\Models\\User', 2, 'inventory-token', 'bd801e55f48a78238d5274cf3ef1d5b034e08920831f6eb26b587c6a2b235e68', '[\"*\"]', NULL, NULL, '2026-07-29 18:49:29', '2026-07-29 18:49:29'),
(7, 'App\\Models\\User', 2, 'inventory-token', '59ace0c80ef73918b04d1825639a878fd589df776329331a88e6eeb4642ab786', '[\"*\"]', NULL, NULL, '2026-07-29 19:39:50', '2026-07-29 19:39:50'),
(11, 'App\\Models\\User', 2, 'inventory-token', '2da1648bc085c62e617daa06e895801af05ce297421736272dca7edc955bc9bd', '[\"*\"]', NULL, NULL, '2026-07-30 02:36:00', '2026-07-30 02:36:00'),
(12, 'App\\Models\\User', 2, 'inventory-token', 'bf32598dc9398d63f2e41482be3ff93c5d97de73fd99b0ff7690f12d14e8cf99', '[\"*\"]', '2026-07-30 02:37:52', NULL, '2026-07-30 02:37:19', '2026-07-30 02:37:52'),
(13, 'App\\Models\\User', 2, 'inventory-token', 'c20c6c955b3b05bf518875703dcc20edd863c374c33a0ec53ee9de3638042b65', '[\"*\"]', NULL, NULL, '2026-07-30 02:37:32', '2026-07-30 02:37:32'),
(15, 'App\\Models\\User', 2, 'inventory-token', '4f3db1593b85107c67688986e0e601ec9fd6298f343d9c9a4837348d02f7e997', '[\"*\"]', '2026-07-30 08:25:28', NULL, '2026-07-30 07:03:13', '2026-07-30 08:25:28');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('RxbpvLFwAbqgnnUGWzm0V5q9szMva5vWiOz80V1d', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/150.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJxYXBlVDNOeE1ZMHVFdXpGbXptRUN4VmRJaGp6bXFFNG5YZmVnTnFXIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOm51bGx9LCJfZmxhc2giOnsib2xkIjpbXSwibmV3IjpbXX19', 1785319739);

-- --------------------------------------------------------

--
-- Table structure for table `transaksis`
--

CREATE TABLE `transaksis` (
  `id` bigint UNSIGNED NOT NULL,
  `kode_transaksi` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` bigint UNSIGNED NOT NULL,
  `tanggal_transaksi` timestamp NOT NULL,
  `jenis_transaksi` enum('masuk','keluar') COLLATE utf8mb4_unicode_ci NOT NULL,
  `jumlah` int NOT NULL,
  `keterangan` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaksis`
--

INSERT INTO `transaksis` (`id`, `kode_transaksi`, `item_id`, `tanggal_transaksi`, `jenis_transaksi`, `jumlah`, `keterangan`, `created_at`, `updated_at`) VALUES
(16, 'TRX-20260730144314', 13, '2026-07-28 17:00:00', 'masuk', 20, 'beli barang', '2026-07-30 07:43:14', '2026-07-30 07:43:14'),
(17, 'TRX-20260730144405', 17, '2026-07-28 17:00:00', 'masuk', 10, 'beli baru', '2026-07-30 07:44:05', '2026-07-30 07:44:05'),
(18, 'TRX-20260730144430', 16, '2026-07-29 17:00:00', 'masuk', 5, 'tambah unit', '2026-07-30 07:44:30', '2026-07-30 07:44:30'),
(19, 'TRX-20260730144511', 15, '2026-07-29 17:00:00', 'masuk', 10, 'tambah unit', '2026-07-30 07:45:11', '2026-07-30 07:45:11'),
(20, 'TRX-20260730144533', 13, '2026-07-29 17:00:00', 'masuk', 100, 'inventaris', '2026-07-30 07:45:33', '2026-07-30 07:45:33'),
(21, 'TRX-20260730144657', 13, '2026-07-29 17:00:00', 'keluar', 50, 'dijual', '2026-07-30 07:46:57', '2026-07-30 07:46:57'),
(22, 'TRX-20260730144738', 17, '2026-06-30 17:00:00', 'keluar', 10, 'dijual', '2026-07-30 07:47:38', '2026-07-30 07:47:38'),
(23, 'TRX-20260730145739', 13, '2026-07-29 17:00:00', 'keluar', 2, 'tes', '2026-07-30 07:57:39', '2026-07-30 07:57:39'),
(24, 'TRX-20260730145805', 13, '2026-07-29 17:00:00', 'keluar', 3, 'tes', '2026-07-30 07:58:05', '2026-07-30 07:58:05'),
(25, 'TRX-20260730145932', 15, '2026-07-29 17:00:00', 'keluar', 5, 'tes', '2026-07-30 07:59:32', '2026-07-30 07:59:32'),
(26, 'TRX-20260730150517', 17, '2026-07-29 17:00:00', 'masuk', 100, 'inventaris', '2026-07-30 08:05:17', '2026-07-30 08:05:17'),
(27, 'TRX-20260730150607', 17, '2026-07-29 17:00:00', 'keluar', 10, 'tes', '2026-07-30 08:06:07', '2026-07-30 08:06:07');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@example.com', '2026-07-29 07:30:49', '$2y$12$k/YFXXOyQ/HIcSoGxjw2j.VDYh84ZhakwDuuNxDGM35BOIWLELH2O', 'geZzwUPBKG', '2026-07-29 07:30:50', '2026-07-29 07:30:50'),
(2, 'Admin', 'admin@gmail.com', NULL, '$2y$12$/KpXzBcRcHVCIfZv44S9wuau5z6Fdv9W0knjvBFKaYcwO1HIjhls.', NULL, '2026-07-29 07:32:19', '2026-07-29 07:32:19');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_expiration_index` (`expiration`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`),
  ADD KEY `cache_locks_expiration_index` (`expiration`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`),
  ADD KEY `failed_jobs_connection_queue_failed_at_index` (`connection`,`queue`,`failed_at`);

--
-- Indexes for table `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `items_kode_barang_unique` (`kode_barang`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  ADD KEY `personal_access_tokens_expires_at_index` (`expires_at`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `transaksis`
--
ALTER TABLE `transaksis`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `transaksis_kode_transaksi_unique` (`kode_transaksi`),
  ADD KEY `transaksis_item_id_foreign` (`item_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `items`
--
ALTER TABLE `items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `transaksis`
--
ALTER TABLE `transaksis`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaksis`
--
ALTER TABLE `transaksis`
  ADD CONSTRAINT `transaksis_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `items` (`id`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
