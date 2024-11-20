-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 20, 2024 at 05:27 PM
-- Server version: 8.0.31
-- PHP Version: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pizza`
--

-- --------------------------------------------------------

--
-- Table structure for table `client`
--

CREATE TABLE `client` (
  `id` int NOT NULL,
  `nom` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `prenom` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `numero_telephone` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `adresse` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `client`
--

INSERT INTO `client` (`id`, `nom`, `prenom`, `numero_telephone`, `adresse`) VALUES
(1, 'Beaulieu', 'Etienne', '(873) 375-7766', '454 boulevard Jutras Est, Victoriaville'),
(2, 'Rivard', 'Etienne', 'tamere', 'tamere'),
(4, 'hamel', 'catherine', 'njosdvnojsad', 'ewfonjwdeofwe'),
(5, 'trump', 'donald', '1111111111', 'white house biatch!'),
(6, 'Trump', 'Donald', '43r42245245', 'ewferfgergferf');

-- --------------------------------------------------------

--
-- Table structure for table `commande`
--

CREATE TABLE `commande` (
  `id` int NOT NULL,
  `id_client` int DEFAULT NULL,
  `id_pizza` int DEFAULT NULL,
  `date_commande` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `commande`
--

INSERT INTO `commande` (`id`, `id_client`, `id_pizza`, `date_commande`) VALUES
(1, 1, 1, '2024-11-11 09:56:17'),
(2, 1, 2, '2024-11-11 10:04:05'),
(3, 1, 3, '2024-11-11 10:04:25'),
(4, 1, 4, '2024-11-11 10:18:33'),
(5, 1, 5, '2024-11-11 10:21:08'),
(6, 1, 6, '2024-11-11 10:22:27'),
(7, 1, 7, '2024-11-11 10:27:10'),
(8, 4, 8, '2024-11-11 10:29:34'),
(9, 5, 9, '2024-11-11 12:13:22'),
(10, 5, 10, '2024-11-18 13:47:23');

--
-- Triggers `commande`
--
DELIMITER $$
CREATE TRIGGER `after_commande_insert` AFTER INSERT ON `commande` FOR EACH ROW BEGIN
    -- Insérer la commande dans la table Commande_en_attente
    INSERT INTO Commande_en_attente (id_client, id_pizza)
    VALUES (NEW.id_client, NEW.id_pizza);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `commande_en_attente`
--

CREATE TABLE `commande_en_attente` (
  `id` int NOT NULL,
  `id_client` int DEFAULT NULL,
  `id_pizza` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `croute`
--

CREATE TABLE `croute` (
  `id` int NOT NULL,
  `titre` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `croute`
--

INSERT INTO `croute` (`id`, `titre`) VALUES
(1, 'Classique'),
(2, 'Mince'),
(3, 'Épaisse');

-- --------------------------------------------------------

--
-- Table structure for table `garniture`
--

CREATE TABLE `garniture` (
  `id` int NOT NULL,
  `titre` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `garniture`
--

INSERT INTO `garniture` (`id`, `titre`) VALUES
(1, 'Pepperoni'),
(2, 'Champignons'),
(3, 'Oignons'),
(4, 'Poivrons'),
(5, 'Olives'),
(6, 'Anchois'),
(7, 'Bacon'),
(8, 'Poulet'),
(9, 'Maïs'),
(10, 'Fromage'),
(11, 'Piments forts');

-- --------------------------------------------------------

--
-- Table structure for table `pizza`
--

CREATE TABLE `pizza` (
  `id` int NOT NULL,
  `croute` int DEFAULT NULL,
  `sauce` int DEFAULT NULL,
  `garniture1` int DEFAULT NULL,
  `garniture2` int DEFAULT NULL,
  `garniture3` int DEFAULT NULL,
  `garniture4` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pizza`
--

INSERT INTO `pizza` (`id`, `croute`, `sauce`, `garniture1`, `garniture2`, `garniture3`, `garniture4`) VALUES
(1, 1, 1, 1, 1, 1, 1),
(2, 1, 2, 1, 2, 5, 11),
(3, 1, 3, 2, 1, 1, 9),
(4, 2, 2, 2, 7, 6, 5),
(5, 1, 1, 1, 8, 7, 3),
(6, 3, 1, 1, 7, 8, 2),
(7, 1, 1, 1, 1, 1, 1),
(8, 1, 2, 6, 9, 5, 11),
(9, 3, 3, 2, 8, 7, 11),
(10, 2, 1, 3, 11, 8, 7);

-- --------------------------------------------------------

--
-- Table structure for table `sauce`
--

CREATE TABLE `sauce` (
  `id` int NOT NULL,
  `titre` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sauce`
--

INSERT INTO `sauce` (`id`, `titre`) VALUES
(1, 'Tomate'),
(2, 'Spaghetti'),
(3, 'Alfredo');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `commande`
--
ALTER TABLE `commande`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_client` (`id_client`),
  ADD KEY `id_pizza` (`id_pizza`);

--
-- Indexes for table `commande_en_attente`
--
ALTER TABLE `commande_en_attente`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_client` (`id_client`),
  ADD KEY `id_pizza` (`id_pizza`);

--
-- Indexes for table `croute`
--
ALTER TABLE `croute`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `garniture`
--
ALTER TABLE `garniture`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pizza`
--
ALTER TABLE `pizza`
  ADD PRIMARY KEY (`id`),
  ADD KEY `croute` (`croute`),
  ADD KEY `sauce` (`sauce`),
  ADD KEY `garniture1` (`garniture1`),
  ADD KEY `garniture2` (`garniture2`),
  ADD KEY `garniture3` (`garniture3`),
  ADD KEY `garniture4` (`garniture4`);

--
-- Indexes for table `sauce`
--
ALTER TABLE `sauce`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `client`
--
ALTER TABLE `client`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `commande`
--
ALTER TABLE `commande`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `commande_en_attente`
--
ALTER TABLE `commande_en_attente`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `croute`
--
ALTER TABLE `croute`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `garniture`
--
ALTER TABLE `garniture`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `pizza`
--
ALTER TABLE `pizza`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `sauce`
--
ALTER TABLE `sauce`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `commande`
--
ALTER TABLE `commande`
  ADD CONSTRAINT `commande_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commande_ibfk_2` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `commande_en_attente`
--
ALTER TABLE `commande_en_attente`
  ADD CONSTRAINT `commande_en_attente_ibfk_1` FOREIGN KEY (`id_client`) REFERENCES `client` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `commande_en_attente_ibfk_2` FOREIGN KEY (`id_pizza`) REFERENCES `pizza` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `pizza`
--
ALTER TABLE `pizza`
  ADD CONSTRAINT `pizza_ibfk_1` FOREIGN KEY (`croute`) REFERENCES `croute` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pizza_ibfk_2` FOREIGN KEY (`sauce`) REFERENCES `sauce` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pizza_ibfk_3` FOREIGN KEY (`garniture1`) REFERENCES `garniture` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pizza_ibfk_4` FOREIGN KEY (`garniture2`) REFERENCES `garniture` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pizza_ibfk_5` FOREIGN KEY (`garniture3`) REFERENCES `garniture` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `pizza_ibfk_6` FOREIGN KEY (`garniture4`) REFERENCES `garniture` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
