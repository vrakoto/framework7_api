-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: May 12, 2023 at 08:17 PM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 8.1.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sts_todolist`
--

-- --------------------------------------------------------

--
-- Table structure for table `liste`
--

CREATE TABLE `liste` (
  `id_liste` int(11) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `liste`
--

INSERT INTO `liste` (`id_liste`, `nom`, `description`) VALUES
(1, 'Menage', 'Liste des m&eacute;nages &agrave; faire dans la maison'),
(2, 'Cours', 'Liste des cours d&#039;apprentissage'),
(3, 'Vehicule', 'Liste des entretiens &agrave; faire pour les v&eacute;hicules ');

-- --------------------------------------------------------

--
-- Table structure for table `tache`
--

CREATE TABLE `tache` (
  `id_tache` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `niveau` smallint(6) NOT NULL,
  `ref_liste` int(11) NOT NULL,
  `ref_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tache`
--

INSERT INTO `tache` (`id_tache`, `nom`, `description`, `niveau`, `ref_liste`, `ref_type`) VALUES
(1, 'Aspirateur', 'Partout dans la maison', 3, 1, 5),
(2, 'Serpillere', '', 2, 1, 5),
(3, 'Lave-vaisselle', '', 4, 1, 5),
(4, 'Programmation Framework 7', 'Lundi mardi et vendredi', 5, 2, 5),
(5, 'JS', '', 5, 2, 5),
(6, 'Math', 'Algo, Djisktra, Lin&eacute;aires ...', 5, 2, 5),
(7, 'Faire le vidange', 'Moto', 4, 3, 5),
(8, 'Nettoyer parebrise', 'voiture', 4, 3, 5),
(9, 'Gonfler les pneus', 'Pour les deux v&eacute;hicules', 5, 3, 5);

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `id_type` int(11) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `couleur` varchar(7) NOT NULL,
  `ref_type_parent` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`id_type`, `nom`, `couleur`, `ref_type_parent`) VALUES
(1, 'Moto', 'vert', NULL),
(2, 'Voiture', 'rouge', NULL),
(3, 'Cours', 'bleu', NULL),
(4, 'Ménage', 'violet', NULL),
(5, 'Autre', 'Gris', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `liste`
--
ALTER TABLE `liste`
  ADD PRIMARY KEY (`id_liste`);

--
-- Indexes for table `tache`
--
ALTER TABLE `tache`
  ADD PRIMARY KEY (`id_tache`),
  ADD KEY `fk_tache_liste` (`ref_liste`),
  ADD KEY `fk_tache_type` (`ref_type`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`id_type`),
  ADD KEY `fk_type_parent_enfant` (`ref_type_parent`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `liste`
--
ALTER TABLE `liste`
  MODIFY `id_liste` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tache`
--
ALTER TABLE `tache`
  MODIFY `id_tache` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `id_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `tache`
--
ALTER TABLE `tache`
  ADD CONSTRAINT `fk_tache_liste` FOREIGN KEY (`ref_liste`) REFERENCES `liste` (`id_liste`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_tache_type` FOREIGN KEY (`ref_type`) REFERENCES `type` (`id_type`);

--
-- Constraints for table `type`
--
ALTER TABLE `type`
  ADD CONSTRAINT `fk_type_parent_enfant` FOREIGN KEY (`ref_type_parent`) REFERENCES `type` (`id_type`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
