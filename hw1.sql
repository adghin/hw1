-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2023 at 04:37 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hw1`
--
CREATE DATABASE IF NOT EXISTS `hw1` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `hw1`;

-- --------------------------------------------------------

--
-- Table structure for table `libreria`
--

CREATE TABLE `libreria` (
  `lib_id` int(11) NOT NULL,
  `usr_id` int(11) NOT NULL,
  `nome` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `libreria`
--

INSERT INTO `libreria` (`lib_id`, `usr_id`, `nome`) VALUES
(2, 35, 'Letti'),
(15, 5, 'Non letti'),
(21, 35, 'Prefe'),
(23, 37, 'Da leggere'),
(24, 37, 'Letti'),
(25, 37, 'Interessanti'),
(29, 5, 'Interessanti'),
(41, 38, 'Da leggere'),
(42, 38, 'Letti'),
(43, 38, 'Non letti'),
(44, 38, 'Interessanti'),
(45, 38, 'Interessantissimi'),
(46, 38, 'Personali'),
(47, 38, 'Personali2'),
(48, 38, 'Personali3'),
(49, 38, 'Personali4'),
(51, 39, 'Libreria1'),
(52, 39, 'Libreria2'),
(58, 40, 'Da leggere'),
(59, 41, 'Da leggere'),
(60, 41, 'Letti'),
(61, 42, 'Da leggere'),
(62, 42, 'Letti'),
(64, 43, 'Preferitissimi'),
(66, 44, 'Da leggere'),
(67, 44, 'I miei libri'),
(68, 44, 'Libri bellissimi'),
(69, 44, 'Stupendi'),
(70, 44, 'Stupendi2'),
(75, 45, 'Da leggere'),
(76, 5, 'Manga'),
(77, 46, 'Preferiti'),
(78, 46, 'Da leggere'),
(81, 5, 'Profondi'),
(84, 47, 'Manga2'),
(85, 47, 'Importanti'),
(91, 47, 'Manga1'),
(94, 47, 'Original Books'),
(95, 49, 'Romanzi storici'),
(96, 49, 'Manga');

-- --------------------------------------------------------

--
-- Table structure for table `libri_libreria`
--

CREATE TABLE `libri_libreria` (
  `id_libro` varchar(255) NOT NULL,
  `id_libreria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `libri_libreria`
--

INSERT INTO `libri_libreria` (`id_libro`, `id_libreria`) VALUES
('0u-ZEAAAQBAJ', 2),
('9CJWTbd-RYoC', 78),
('BcGuOa-QHAcC', 81),
('BexnNAEACAAJ', 23),
('BexnNAEACAAJ', 58),
('BexnNAEACAAJ', 59),
('BexnNAEACAAJ', 62),
('BexnNAEACAAJ', 64),
('ByZYnwEACAAJ', 67),
('D4yQEAAAQBAJ', 91),
('ddET09cVpF0C', 49),
('ep-cDwAAQBAJ', 94),
('eRgXMjAl5MMC', 77),
('i8svEAAAQBAJ', 47),
('LefAsgEACAAJ', 44),
('LefAsgEACAAJ', 52),
('LefAsgEACAAJ', 60),
('LUbdQ0JgdFEC', 15),
('ndnKDAAAQBAJ', 41),
('ndnKDAAAQBAJ', 64),
('QKYsEAAAQBAJ', 21),
('rt1UEAAAQBAJ', 24),
('u4OxzgEACAAJ', 76),
('u4OxzgEACAAJ', 84),
('u4OxzgEACAAJ', 96),
('USarzwEACAAJ', 60),
('USarzwEACAAJ', 64),
('UTGnopblxt8C', 43),
('UTGnopblxt8C', 51),
('UTGnopblxt8C', 58),
('UTGnopblxt8C', 59),
('UTGnopblxt8C', 61),
('UTGnopblxt8C', 66),
('utT5qmal_gIC', 64),
('utT5qmal_gIC', 95),
('vEKjzgEACAAJ', 42),
('wpOwBwAAQBAJ', 21),
('YjpJvgAACAAJ', 21);

-- --------------------------------------------------------

--
-- Table structure for table `libro`
--

CREATE TABLE `libro` (
  `id_libro` varchar(255) NOT NULL,
  `titolo` varchar(255) DEFAULT NULL,
  `autori` varchar(255) DEFAULT NULL,
  `cover` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `libro`
--

INSERT INTO `libro` (`id_libro`, `titolo`, `autori`, `cover`) VALUES
('0u-ZEAAAQBAJ', 'La verità sul caso Harry Quebert', 'Joël Dicker', 'http://books.google.com/books/content?id=0u-ZEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('1rJ5DAAAQBAJ', 'Discovering Computer Science', 'Jessen Havill', 'http://books.google.com/books/content?id=1rJ5DAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('2nm4zgEACAAJ', 'One piece. Celebration edition. Ediz. speciale', 'Eiichiro Oda', 'http://books.google.com/books/content?id=2nm4zgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('2VSXzQEACAAJ', 'L\'attacco dei giganti. Colossal edition', 'Hajime Isayama', 'http://books.google.com/books/content?id=2VSXzQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('2Yb5SvT2VqgC', 'Il conte di Montecristo', 'Alexandre Dumas', 'http://books.google.com/books/content?id=2Yb5SvT2VqgC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('4rjzjwEACAAJ', 'Game of Thrones. Erotismo, guerra e spazi urbani nel Trono di Spade', 'S. Martin,V. Re', 'http://books.google.com/books/content?id=4rjzjwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('8XzGXQDBdRsC', 'Il conte di Montecristo', 'Alexandre Dumas', 'http://books.google.com/books/content?id=8XzGXQDBdRsC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('9CJWTbd-RYoC', 'Harry Potter e la Pietra Filosofale', 'J.K. Rowling', 'http://books.google.com/books/content?id=9CJWTbd-RYoC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('9NSRzwEACAAJ', 'Piccole donne', 'Louisa May Alcott', 'http://books.google.com/books/content?id=9NSRzwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('AKX6swEACAAJ', 'La vera storia di Geronimo Stilton', 'Geronimo Stilton', 'http://books.google.com/books/content?id=AKX6swEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('BcGuOa-QHAcC', 'La linea d\'ombra', 'Joseph Conrad', 'http://books.google.com/books/content?id=BcGuOa-QHAcC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('BexnNAEACAAJ', 'Il conte di Montecristo', 'Alexandre Dumas', 'http://books.google.com/books/content?id=BexnNAEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('ByZYnwEACAAJ', 'Gatto nero, gatta bianca', 'Silvia Borando', 'http://books.google.com/books/content?id=ByZYnwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('cEb6PAAACAAJ', 'Le grandi società di costruzioni nel mondo. Benchmarking finanziario e gestionale. Il settore in Italia', 'KPMG - SDA Area Finanza', 'http://books.google.com/books/content?id=cEb6PAAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('d2GeDAAAQBAJ', 'La lettera scarlatta', 'Nathaniel Hawthorne', 'http://books.google.com/books/content?id=d2GeDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('D4yQEAAAQBAJ', 'Attack on Titan 18', 'Hajime Isayama', 'http://books.google.com/books/content?id=D4yQEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('ddET09cVpF0C', 'Mastering the Art of War', 'Liang Zhuge,Ji Liu', 'http://books.google.com/books/content?id=ddET09cVpF0C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('DtHKDwAAQBAJ', 'Fate largo al mini detective', 'Geronimo Stilton', 'http://books.google.com/books/content?id=DtHKDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('e0U3EAAAQBAJ', 'Piccole donne', 'Louise May Alcott', 'http://books.google.com/books/content?id=e0U3EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('ep-cDwAAQBAJ', 'Le avventure di Tom Sawyer', 'Mark Twain', 'http://books.google.com/books/content?id=ep-cDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('eRgXMjAl5MMC', 'Harry Potter e i Doni della Morte', 'J.K. Rowling', 'http://books.google.com/books/content?id=eRgXMjAl5MMC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('eTWSzQEACAAJ', 'Il giro del mondo in 80 giorni. Ediz. integrale', 'Jules Verne', 'http://books.google.com/books/content?id=eTWSzQEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('gEyyzgEACAAJ', 'Tokyo Express', 'Seichö Matsumoto', 'http://books.google.com/books/content?id=gEyyzgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('i8svEAAAQBAJ', 'Cat\'s Cradle', 'Bianca D\'Arc', 'http://books.google.com/books/content?id=i8svEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('KaKwDAAAQBAJ', 'Le avventure di Winnie the Pooh', 'Disney', 'http://books.google.com/books/content?id=KaKwDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('LefAsgEACAAJ', 'Attack on Titan', 'Hajime Isayama', 'http://books.google.com/books/content?id=LefAsgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('LUbdQ0JgdFEC', 'Orgoglio e pregiudizio', 'Jane Austen', 'http://books.google.com/books/content?id=LUbdQ0JgdFEC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('ndnKDAAAQBAJ', 'Lo strano caso dei giochi olimpici', 'Geronimo Stilton', 'http://books.google.com/books/content?id=ndnKDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('QKYsEAAAQBAJ', 'Fiabe giapponesi', 'AA. VV.', 'http://books.google.com/books/content?id=QKYsEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('rt1UEAAAQBAJ', 'The Fff and a Changing World', 'Kay Ray', 'http://books.google.com/books/content?id=rt1UEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('s8NYAAAAYAAJ', 'Some Statistics of Wages, Earnings and Hours of Work', 'undefined', 'http://books.google.com/books/content?id=s8NYAAAAYAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('SflWEAAAQBAJ', 'Lunjika SDA Mission in Northern Malawi 1932 - 1995', 'Macleard Banda', 'http://books.google.com/books/content?id=SflWEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('SPNLAgAAQBAJ', 'Il conte di Montecristo (Mondadori)', 'Alexandre (padre) Dumas', 'http://books.google.com/books/content?id=SPNLAgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('sy2KDwAAQBAJ', 'Il Trono di Spade. Il graphic novel - 1. Un gioco di troni #1', 'George R.R. Martin', 'http://books.google.com/books/content?id=sy2KDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('tlODCwAAQBAJ', 'Gli occhi neri di Susan', 'Julia Heaberlin', 'http://books.google.com/books/content?id=tlODCwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('u4OxzgEACAAJ', 'One Piece, Vol. 100', 'Eiichiro Oda', 'http://books.google.com/books/content?id=u4OxzgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('USarzwEACAAJ', 'La guerra dei mondi', 'Herbert George Wells', 'http://books.google.com/books/content?id=USarzwEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('UTGnopblxt8C', 'The Art of War', 'Sun Tzu', 'http://books.google.com/books/content?id=UTGnopblxt8C&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('utT5qmal_gIC', 'I tre moschettieri', 'Alexandre Dumas', 'http://books.google.com/books/content?id=utT5qmal_gIC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('V5a2ugAACAAJ', 'Piccole donne', 'Louisa May Alcott', 'http://books.google.com/books/content?id=V5a2ugAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('vEKjzgEACAAJ', 'L\'arte della guerra', 'Tzu Sun', 'http://books.google.com/books/content?id=vEKjzgEACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('VoskAQAAMAAJ', 'Candido, ovvero, L\'ottimismo', 'Voltaire', 'http://books.google.com/books/content?id=VoskAQAAMAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('wGMWDQAAQBAJ', 'Strategia, azioni, misure', 'Antonella Cugini,Andrea Dossi,Luca Ghezzi,Giovanni Battista Derchi', 'http://books.google.com/books/content?id=wGMWDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('wpOwBwAAQBAJ', 'I segreti delle piramidi', 'Geronimo Stilton', 'http://books.google.com/books/content?id=wpOwBwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('xBOsDwAAQBAJ', 'Attack on Titan - Before the Fall 1', 'Hajime Isayama,Ryo Suzukaze', 'http://books.google.com/books/content?id=xBOsDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api'),
('xLWQEAAAQBAJ', 'Attack on Titan Omnibus 1 (Vol. 1-3)', 'Hajime Isayama', 'http://books.google.com/books/content?id=xLWQEAAAQBAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('YjpJvgAACAAJ', 'Frane e alluvioni', 'Giuseppe Marziano', 'http://books.google.com/books/content?id=YjpJvgAACAAJ&printsec=frontcover&img=1&zoom=1&source=gbs_api'),
('yqJCmRUrifQC', 'Keyboarding for the Christian School', 'Leanne Beitel', 'http://books.google.com/books/content?id=yqJCmRUrifQC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api');

-- --------------------------------------------------------

--
-- Table structure for table `rating_libri`
--

CREATE TABLE `rating_libri` (
  `id_libro` varchar(255) NOT NULL,
  `id_user` int(11) NOT NULL,
  `rate` int(11) NOT NULL
) ;

--
-- Dumping data for table `rating_libri`
--

INSERT INTO `rating_libri` (`id_libro`, `id_user`, `rate`) VALUES
('BexnNAEACAAJ', 40, 4),
('BexnNAEACAAJ', 42, 3),
('BexnNAEACAAJ', 43, 4),
('eRgXMjAl5MMC', 46, 1),
('LefAsgEACAAJ', 5, 4),
('LUbdQ0JgdFEC', 5, 4),
('ndnKDAAAQBAJ', 43, 4),
('u4OxzgEACAAJ', 5, 5),
('u4OxzgEACAAJ', 47, 4),
('USarzwEACAAJ', 41, 4),
('UTGnopblxt8C', 5, 5),
('UTGnopblxt8C', 40, 3),
('UTGnopblxt8C', 43, 3),
('V5a2ugAACAAJ', 43, 5),
('VoskAQAAMAAJ', 5, 4);

-- --------------------------------------------------------

--
-- Stand-in structure for view `t1`
-- (See below for the actual view)
--
CREATE TABLE `t1` (
`id_libro` varchar(255)
,`titolo` varchar(255)
,`autori` varchar(255)
,`cover` varchar(255)
,`id_libreria` int(11)
,`nome` varchar(255)
,`usr_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `temp_data`
-- (See below for the actual view)
--
CREATE TABLE `temp_data` (
`id_libro` varchar(255)
,`titolo` varchar(255)
,`autori` varchar(255)
,`cover` varchar(255)
);

-- --------------------------------------------------------

--
-- Table structure for table `utenti`
--

CREATE TABLE `utenti` (
  `id_utenti` int(11) NOT NULL,
  `username` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `utenti`
--

INSERT INTO `utenti` (`id_utenti`, `username`, `email`, `password`) VALUES
(5, 'adghin00', 'adrian.ghinea00@gmail.com', '$2y$10$OGL1d1FRCIKTXFfkHZmP5u5ZGwHzT7IRDlQqb/CZbA4hNQNCjH8lm'),
(12, 'adghin000', 'adrian.ghinea@outlook.it', '$2y$10$kPMNavC6qyJD6L810/4rJeAQpRVd4ItKo2LtJ.DOd.cw4kz0MizVi'),
(13, 'emarz00', 'emrz@gmail.com', '$2y$10$aqrmT05yIzQ1eF4ax2X.I.dL5rn4d86vTcSHgWePy7EtDvvDbnxxO'),
(14, 'pippo00', 'pippo@gmail.com', '$2y$10$aD6.QJVW11hWgQykt6mXIu3SBIQA7c/ixIgxL4gLUaRYYzfa1fAke'),
(15, 'pappo0', 'pappo@gmail.com', '$2y$10$3z9GVO6P1ClyRZMSf/bkJOgEvXNkfULMD5ENn.tF8wFaEVJa7cpRC'),
(16, 'adghin0000', 'adrian.ghineaa00@gmail.com', '$2y$10$.QH.FdbwriTMH8PDnDoVhepvOTnSdF2fp94OwdavegAUjkA48uJYe'),
(17, 'asda', 'adriann.ghinea00@gmail.com', '$2y$10$jYx8RXrYpfBdVkV5516FEeSSUUdcWzwzxCKp457hbBz5ZkR/r58BC'),
(18, 'asd00', 'asd@gmail.com', '$2y$10$/BZrj/Td82vKpSpJRAcgH.SD7AE5hWXcwRk9Ml3.5hiPhGH.Cq/CG'),
(33, 'adghin00000', 'adrian.ghinea0000@gmail.com', '$2y$10$BPmsYCDEayWYrqSXnGzrNebLUYNgXzaW3CcGnjMnIZOfnIGTTz6Ja'),
(34, 'adghin001', 'adrian.ghinea001@gmail.com', '$2y$10$5iXvTzyXSHmvPP9gfJY6Tejplm/wbAYvigvM6zHb8CdnxJKhPQiZi'),
(35, 'emiliana125', 'lovelove@gmail.com', '$2y$10$GWxXJ5dASSGrgNw9P3RKl.302v0YrCUaw5hXcDDfLr/mI3.V3SFYm'),
(36, 'prova123', 'prova123@gmail.com', '$2y$10$njvSgGjH51V2HcTLC39QteZqT9iIPl2D2GZSYZeplpiIxKkLO2XOq'),
(37, 'prova1234', 'prova1234@gmail.com', '$2y$10$Jeh.OWZc4RNyNFlb5uSlFOnJeJbFHqABa0b4miKlNldKrjzgJ2O9K'),
(38, 'testemiliana', 'testemiliana@gmail.com', '$2y$10$Eo7EuqqLBvNH7udN3o5z6uKJPnUtDpwgQqwlGw5bsMIlo7OcMdgeS'),
(39, 'Prova55', 'prova55@gmail.com', '$2y$10$cxHofAOhugE5BWnKofxO3enkRwQngbJwPAwkw1WR7cafpUIRL.m8u'),
(40, 'mr.ciao', 'ciaociao@gmail.com', '$2y$10$oNqqDvXtekoi4YYoYuyu3OIRNlqKOrHhfn5sMRS6iNkS97a1vtfaK'),
(41, 'mr.ciao2', 'mrciaone@gmail.com', '$2y$10$uZxjVu6AebuyRLPIl8kqquExmHRtDe8NaIbzrETFrJgGkEFfqFpTa'),
(42, 'mr.ciao3', 'mrciao3@gmail.com', '$2y$10$opBCt8Td/.dVcitUA7qQo.urhISxOZdhX9m8x8h5kPALEJYFMYPrC'),
(43, 'mr.ciao4', 'mrciao4@gmail.com', '$2y$10$uaSefTPaunngWET4M32zrusL1G4rurjjskxiJNnrkJGkj3Hq8zBG.'),
(44, 'mr.ciao5', 'mrciao5@gmail.com', '$2y$10$naTGOmq0MYeerSllraqvY.eSMYYsT67cqJRn9bCGM/0RGA1T9/SqK'),
(45, 'mr.ciao6', 'mrciao6@gmail.com', '$2y$10$vV0Ku7BIVxY0/pA026dvoOiqyuHvg/p80z4fDK4e1ZO2N13vGTBN2'),
(46, 'emiliana01', 'emiliana01@gmail.com', '$2y$10$xhvWUnFa/Oq.UbmCCxyZMOmYzFZsNZ3Uxz08In5Rm513iNeAPU9NC'),
(47, 'finaltest', 'finaltest@gmail.com', '$2y$10$BCKlWM5UC0foI5FMVf6kPu2uDwYDsuYz0DAhrjH15SLK3M.mrvfYK'),
(48, 'finaltest2', 'finaltest2@gmail.com', '$2y$10$y/Ht/O/q/thiO/GZyzujOelKI1EybV6f7a5Esy6937tv5cX3SBzD2'),
(49, 'finaltest3', 'finaltest3@gmail.com', '$2y$10$goRksmcHTwQOSHVLACqCWuhH8Py6lMyluIfXTZ0NmFsa9.ZexPIc2');

-- --------------------------------------------------------

--
-- Structure for view `t1`
--
DROP TABLE IF EXISTS `t1`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `t1`  AS SELECT `l1`.`id_libro` AS `id_libro`, `l1`.`titolo` AS `titolo`, `l1`.`autori` AS `autori`, `l1`.`cover` AS `cover`, `l5`.`id_libreria` AS `id_libreria`, `l6`.`nome` AS `nome`, `l6`.`usr_id` AS `usr_id` FROM ((`libro` `l1` join `libri_libreria` `l5` on(`l1`.`id_libro` = `l5`.`id_libro`)) join `libreria` `l6` on(`l6`.`lib_id` = `l5`.`id_libreria`)) WHERE `l1`.`id_libro` in (select `l2`.`id_libro` from `libri_libreria` `l2` where `l2`.`id_libreria` in (select `l3`.`lib_id` from `libreria` `l3` where `l3`.`usr_id` = 40)) AND `l6`.`usr_id` = 40 ;

-- --------------------------------------------------------

--
-- Structure for view `temp_data`
--
DROP TABLE IF EXISTS `temp_data`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `temp_data`  AS SELECT `l1`.`id_libro` AS `id_libro`, `l1`.`titolo` AS `titolo`, `l1`.`autori` AS `autori`, `l1`.`cover` AS `cover` FROM (`libro` `l1` left join `rating_libri` `l4` on(`l1`.`id_libro` = `l4`.`id_libro`)) WHERE `l1`.`id_libro` in (select `l2`.`id_libro` from `libri_libreria` `l2` where `l2`.`id_libreria` in (select `l3`.`lib_id` from `libreria` `l3` where `l3`.`usr_id` = 5)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `libreria`
--
ALTER TABLE `libreria`
  ADD PRIMARY KEY (`lib_id`),
  ADD KEY `usr_id` (`usr_id`);

--
-- Indexes for table `libri_libreria`
--
ALTER TABLE `libri_libreria`
  ADD PRIMARY KEY (`id_libro`,`id_libreria`),
  ADD KEY `libri_libreria_ibfk_2` (`id_libreria`);

--
-- Indexes for table `libro`
--
ALTER TABLE `libro`
  ADD PRIMARY KEY (`id_libro`);

--
-- Indexes for table `rating_libri`
--
ALTER TABLE `rating_libri`
  ADD PRIMARY KEY (`id_libro`,`id_user`),
  ADD KEY `id_user` (`id_user`);

--
-- Indexes for table `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`id_utenti`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `libreria`
--
ALTER TABLE `libreria`
  MODIFY `lib_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `utenti`
--
ALTER TABLE `utenti`
  MODIFY `id_utenti` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `libreria`
--
ALTER TABLE `libreria`
  ADD CONSTRAINT `libreria_ibfk_1` FOREIGN KEY (`usr_id`) REFERENCES `utenti` (`id_utenti`);

--
-- Constraints for table `libri_libreria`
--
ALTER TABLE `libri_libreria`
  ADD CONSTRAINT `libri_libreria_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`),
  ADD CONSTRAINT `libri_libreria_ibfk_2` FOREIGN KEY (`id_libreria`) REFERENCES `libreria` (`lib_id`) ON DELETE CASCADE;

--
-- Constraints for table `rating_libri`
--
ALTER TABLE `rating_libri`
  ADD CONSTRAINT `rating_libri_ibfk_1` FOREIGN KEY (`id_libro`) REFERENCES `libro` (`id_libro`),
  ADD CONSTRAINT `rating_libri_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `utenti` (`id_utenti`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
