-- --------------------------------------------------------
-- Hôte :                        127.0.0.1
-- Version du serveur:           10.1.38-MariaDB - mariadb.org binary distribution
-- SE du serveur:                Win64
-- HeidiSQL Version:             10.1.0.5464
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Listage de la structure de la base pour bd_restapi
CREATE DATABASE IF NOT EXISTS `bd_restapi` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `bd_restapi`;

-- Listage de la structure de la table bd_restapi. article
CREATE TABLE IF NOT EXISTS `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author_id` int(11) DEFAULT NULL,
  `title` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `content` longtext COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `IDX_23A0E66F675F31B` (`author_id`),
  CONSTRAINT `FK_23A0E66F675F31B` FOREIGN KEY (`author_id`) REFERENCES `author` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Listage des données de la table bd_restapi.article : ~16 rows (environ)
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` (`id`, `author_id`, `title`, `content`) VALUES
	(1, 1, 'titre 1', 'text text text'),
	(2, 2, 'titre 2', 'text text text'),
	(4, 3, 'Le titre de mon article ', 'Le contenu de mon article.'),
	(5, 4, 'Le titre de mon article ', 'Le contenu de mon article.'),
	(6, 3, 'My title test 6', 'Text text text aaa'),
	(7, 6, 'Le titre de mon article ', 'Le contenu de mon article.'),
	(8, 3, 'My title test 1', 'text text text'),
	(10, 2, 'My title test 3', 'text text text text'),
	(11, 2, 'My title test  11', ''),
	(12, 1, 'My title test 4', 'text text text text'),
	(14, 1, 'My title test 4', 'text text text text'),
	(15, 1, 'My title test 4', 'text text text text'),
	(16, 1, 'My title test 4', 'text text text text'),
	(17, 1, 'My title test 4', 'text text text text'),
	(18, 1, 'My title test 4', 'text text text text'),
	(19, 1, 'My title test 4', 'text text text text');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;

-- Listage de la structure de la table bd_restapi. author
CREATE TABLE IF NOT EXISTS `author` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fullname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `biography` longtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Listage des données de la table bd_restapi.author : ~6 rows (environ)
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` (`id`, `fullname`, `biography`) VALUES
	(1, 'Karim rochdi', 'text text text'),
	(2, 'Yassin Baadi', 'text text text'),
	(3, 'Sarah Khalil', 'Ma biographie.'),
	(4, 'Sarah Khalil', 'Ma biographie.'),
	(5, 'Sarah Khalil', 'Ma biographie.'),
	(6, 'Sarah Khalil', 'Ma biographie.');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;

-- Listage de la structure de la table bd_restapi. category
CREATE TABLE IF NOT EXISTS `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Listage des données de la table bd_restapi.category : ~2 rows (environ)
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` (`id`, `name`) VALUES
	(1, 'Categ 1'),
	(2, 'Categ 2');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;

-- Listage de la structure de la table bd_restapi. produit
CREATE TABLE IF NOT EXISTS `produit` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `prix` double NOT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Listage des données de la table bd_restapi.produit : ~0 rows (environ)
/*!40000 ALTER TABLE `produit` DISABLE KEYS */;
/*!40000 ALTER TABLE `produit` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
