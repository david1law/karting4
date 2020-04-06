-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 06, 2020 at 03:03 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `karting4`
--
CREATE DATABASE IF NOT EXISTS `karting4` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `karting4`;

-- --------------------------------------------------------

--
-- Table structure for table `activiteiten`
--

CREATE TABLE `activiteiten` (
  `id` int(11) NOT NULL,
  `soort_id` int(11) DEFAULT NULL,
  `datum` date NOT NULL,
  `tijd` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `activiteiten`
--

INSERT INTO `activiteiten` (`id`, `soort_id`, `datum`, `tijd`) VALUES
(9, 1, '2020-04-01', '09:00:00'),
(10, 2, '2020-04-01', '11:00:00'),
(11, 3, '2020-04-06', '15:00:00'),
(12, 4, '2020-05-02', '10:00:00'),
(48, 3867, '2020-05-27', '16:30:00');

-- --------------------------------------------------------

--
-- Table structure for table `app_users`
--

CREATE TABLE `app_users` (
  `id` int(11) NOT NULL,
  `username` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json_array)' CHECK (json_valid(`roles`)),
  `voorletters` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tussenvoegsel` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `achternaam` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `adres` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `postcode` varchar(7) COLLATE utf8mb4_unicode_ci NOT NULL,
  `woonplaats` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `telefoon` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `app_users`
--

INSERT INTO `app_users` (`id`, `username`, `password`, `email`, `roles`, `voorletters`, `tussenvoegsel`, `achternaam`, `adres`, `postcode`, `woonplaats`, `telefoon`) VALUES
(1, 'max', '$argon2id$v=19$m=65536,t=4,p=1$WW9ieC9nRE44Z2t2YmVtSA$6td8TQ80lZCDEbaclB+03+dvuSC52l/PzLn2yBbZv4g', 'max@wxs.nl', '[\"ROLE_ADMIN\"]', 'M.', NULL, 'Verstappen', 'Eijk 7', '1234HJ', 'Maaseik', '0682342343'),
(5, 'guus', '$argon2id$v=19$m=65536,t=4,p=1$WW9ieC9nRE44Z2t2YmVtSA$6td8TQ80lZCDEbaclB+03+dvuSC52l/PzLn2yBbZv4g', 'guus@duckstad.nl', '[\"ROLE_USER\"]', 'G.', NULL, 'Geluk', 'Guuslaan 1', '1234AS', 'Duckstad', '0612345678'),
(6, 'donald', '$argon2id$v=19$m=65536,t=4,p=1$WW9ieC9nRE44Z2t2YmVtSA$6td8TQ80lZCDEbaclB+03+dvuSC52l/PzLn2yBbZv4g', 'donald@duckstad.nl', '[\"ROLE_USER\"]', 'D.', NULL, 'Duck', 'Donald Ducklaan 2', '1234AS', 'Duckstad', '0687654321'),
(7, 'katrien', '$argon2id$v=19$m=65536,t=4,p=1$WW9ieC9nRE44Z2t2YmVtSA$6td8TQ80lZCDEbaclB+03+dvuSC52l/PzLn2yBbZv4g', 'katrien@duckstad.nl', '[\"ROLE_USER\"]', 'K.', NULL, 'Duck', 'Donald Ducklaan 3', '1234AS', 'Duckstad', '0687654567');

-- --------------------------------------------------------

--
-- Table structure for table `deelnames`
--

CREATE TABLE `deelnames` (
  `user_id` int(11) NOT NULL,
  `activiteit_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `deelnames`
--

INSERT INTO `deelnames` (`user_id`, `activiteit_id`) VALUES
(5, 9),
(5, 10),
(6, 12),
(7, 10),
(7, 12);

-- --------------------------------------------------------

--
-- Table structure for table `migration_versions`
--

CREATE TABLE `migration_versions` (
  `version` varchar(14) COLLATE utf8mb4_unicode_ci NOT NULL,
  `executed_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migration_versions`
--

INSERT INTO `migration_versions` (`version`, `executed_at`) VALUES
('20200319123827', '2020-03-19 12:41:51');

-- --------------------------------------------------------

--
-- Table structure for table `soortactiviteiten`
--

CREATE TABLE `soortactiviteiten` (
  `id` int(11) NOT NULL,
  `naam` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_leeftijd` int(11) NOT NULL,
  `tijdsduur` int(11) NOT NULL,
  `prijs` decimal(6,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `soortactiviteiten`
--

INSERT INTO `soortactiviteiten` (`id`, `naam`, `min_leeftijd`, `tijdsduur`, `prijs`) VALUES
(1, 'Vrije training', 12, 15, '15.00'),
(2, 'Grand Prix', 12, 60, '50.00'),
(3, 'Endurance race', 16, 90, '65.00'),
(4, 'Kinder race', 8, 10, '18.00'),
(3867, 'Tijd race', 8, 15, '20.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activiteiten`
--
ALTER TABLE `activiteiten`
  ADD PRIMARY KEY (`id`),
  ADD KEY `IDX_1C50895F3DEE50DF` (`soort_id`);

--
-- Indexes for table `app_users`
--
ALTER TABLE `app_users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `UNIQ_C2502824F85E0677` (`username`);

--
-- Indexes for table `deelnames`
--
ALTER TABLE `deelnames`
  ADD PRIMARY KEY (`user_id`,`activiteit_id`),
  ADD KEY `IDX_ED2478E7A76ED395` (`user_id`),
  ADD KEY `IDX_ED2478E75A8A0A1` (`activiteit_id`);

--
-- Indexes for table `migration_versions`
--
ALTER TABLE `migration_versions`
  ADD PRIMARY KEY (`version`);

--
-- Indexes for table `soortactiviteiten`
--
ALTER TABLE `soortactiviteiten`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activiteiten`
--
ALTER TABLE `activiteiten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `app_users`
--
ALTER TABLE `app_users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `soortactiviteiten`
--
ALTER TABLE `soortactiviteiten`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3868;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activiteiten`
--
ALTER TABLE `activiteiten`
  ADD CONSTRAINT `FK_1C50895F3DEE50DF` FOREIGN KEY (`soort_id`) REFERENCES `soortactiviteiten` (`id`);

--
-- Constraints for table `deelnames`
--
ALTER TABLE `deelnames`
  ADD CONSTRAINT `FK_ED2478E75A8A0A1` FOREIGN KEY (`activiteit_id`) REFERENCES `activiteiten` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `FK_ED2478E7A76ED395` FOREIGN KEY (`user_id`) REFERENCES `app_users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
