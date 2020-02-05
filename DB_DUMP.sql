-- phpMyAdmin SQL Dump
-- version 4.6.6
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Лют 05 2020 р., 20:33
-- Версія сервера: 10.3.18-MariaDB-50+deb10u1.cba
-- Версія PHP: 7.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `dimamyhal`
--

-- --------------------------------------------------------

--
-- Структура таблиці `family`
--

CREATE TABLE `family` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `family`
--

INSERT INTO `family` (`id`, `name`, `logo`) VALUES
(1, 'Royal Family', 'royal.png');

-- --------------------------------------------------------

--
-- Структура таблиці `member`
--

CREATE TABLE `member` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1,
  `active` tinyint(1) NOT NULL,
  `rec_season` int(1) DEFAULT 1,
  `rec_year` year(4) DEFAULT NULL,
  `mentor_id` int(255) DEFAULT NULL,
  `family_id` int(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `member`
--

INSERT INTO `member` (`id`, `name`, `image`, `status`, `active`, `rec_season`, `rec_year`, `mentor_id`, `family_id`) VALUES
(1, 'Маша Брянцева', 'Masha_Briantseva.jpg', 3, 1, 1, 2016, NULL, 1),
(2, 'Аня Олексієнко', 'Hanna_Oleksiienko.jpg', 2, 1, 1, 2017, 1, 1),
(3, 'Альона Калитенко', 'Alyona_Kalytenko.jpg', 2, 1, 1, 2017, 1, 1),
(4, 'Діма Мигаль', 'Dima_Myhal.jpg', 2, 1, 1, 2018, 2, 1),
(5, 'Віка Семендяк', NULL, 1, 1, 1, 2018, 2, 1),
(6, 'Руслан Кучеренко', 'Ruslan_Kucherenko.jpg', 1, 1, 1, 2018, 1, 1),
(7, 'Ніна', NULL, 1, 0, 0, 2019, 2, 1),
(8, 'Кирил', NULL, 1, 1, 1, 2019, 2, 1),
(9, 'Нікіта Чуйков', NULL, 1, 1, 1, 2019, 2, 1),
(10, 'Рома Кіндерис', NULL, 1, 1, 1, 2019, 4, 1),
(11, 'Женя Перегуда', NULL, 1, 1, 1, 2019, 4, 1),
(12, 'Юра Штик', NULL, 1, 1, 1, 2019, 4, 1),
(13, 'Настя Давидова', 'Nastya_Davydova.jpg', 1, 1, 1, 2018, 1, 1);

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `family`
--
ALTER TABLE `family`
  ADD PRIMARY KEY (`id`);

--
-- Індекси таблиці `member`
--
ALTER TABLE `member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `mentor` (`mentor_id`),
  ADD KEY `family` (`family_id`);

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `family`
--
ALTER TABLE `family`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT для таблиці `member`
--
ALTER TABLE `member`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
