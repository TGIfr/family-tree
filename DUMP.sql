-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Сер 18 2020 р., 19:28
-- Версія сервера: 10.3.13-MariaDB-log
-- Версія PHP: 7.1.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `familytree`
--

-- --------------------------------------------------------

--
-- Структура таблиці `coreteam_member`
--

CREATE TABLE `coreteam_member` (
  `id` int(10) NOT NULL,
  `member_id` int(10) NOT NULL,
  `project_id` int(10) NOT NULL,
  `position_id` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Структура таблиці `family`
--

CREATE TABLE `family` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `family`
--

INSERT INTO `family` (`id`, `name`, `logo`) VALUES
(1, 'Royal Family', 'royal.png'),
(2, 'Цезарі', 'ceasars.png'),
(3, 'Spartians', NULL),
(4, 'Деды', NULL),
(5, 'Велеколепные бубочки', NULL),
(6, 'Орден Царя и Волчары', 'ordenCarya.jpg'),
(7, 'Золотые кросотули', NULL),
(8, 'Орден Фенікса', 'ordenFeniksa.png'),
(9, 'Superheros', NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `member`
--

CREATE TABLE `member` (
  `id` int(255) NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 NOT NULL,
  `telegram` varchar(100) DEFAULT NULL,
  `instagram` varchar(100) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `rec_season` int(1) DEFAULT NULL,
  `rec_year` year(4) DEFAULT NULL,
  `faculty` varchar(10) DEFAULT NULL,
  `year_of_studying` int(1) DEFAULT NULL,
  `mentor_id` int(255) DEFAULT NULL,
  `family_id` int(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `member`
--

INSERT INTO `member` (`id`, `name`, `telegram`, `instagram`, `birthday`, `image`, `status`, `active`, `rec_season`, `rec_year`, `faculty`, `year_of_studying`, `mentor_id`, `family_id`) VALUES
(1, 'Аня Ланевська', NULL, NULL, NULL, 'member1.png', 3, 0, 1, 2007, NULL, NULL, NULL, NULL),
(2, 'Настя Міщук', NULL, NULL, NULL, 'member2.jpg', 3, 0, 1, 2008, NULL, NULL, 1, NULL),
(3, 'Аня Архіпова', NULL, NULL, NULL, 'member3.jpg', 3, 0, 1, 2009, NULL, NULL, 1, NULL),
(4, 'Антон Поліщук', NULL, NULL, NULL, 'member4.png', 3, 0, 0, 2009, NULL, NULL, 1, NULL),
(5, 'Світлана Єзгор', NULL, NULL, NULL, 'member5.png', 3, 0, 0, 2009, NULL, NULL, 1, NULL),
(6, 'Таня Нєчаєва', NULL, NULL, NULL, NULL, 3, 0, 0, 2010, NULL, NULL, 2, NULL),
(7, 'Юля Юрченко', NULL, NULL, NULL, NULL, 3, 0, 0, 2009, NULL, NULL, 2, NULL),
(8, 'Єгор Кульбачка', NULL, NULL, NULL, NULL, 3, 0, 1, 2009, NULL, NULL, 2, NULL),
(9, 'Олексій Потапенко', NULL, NULL, NULL, 'member9.jpg', 3, 0, 0, 2009, NULL, NULL, 2, NULL),
(10, 'Ксюша Сорока', NULL, NULL, NULL, 'member10.jpg', 3, 0, 1, 2010, NULL, NULL, 3, NULL),
(11, 'Андрій Терентьєв', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 3, NULL),
(12, 'Катя Федорець', NULL, NULL, NULL, NULL, 3, 0, 1, 2012, NULL, NULL, 4, NULL),
(13, 'Віка Калініченко', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 4, NULL),
(14, 'Діма Страшко', NULL, NULL, NULL, NULL, 3, 0, 1, 2010, NULL, NULL, 5, NULL),
(15, 'Марта Гожа', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 5, NULL),
(16, 'Марк Паславський', NULL, NULL, NULL, 'member16.jpg', 3, 0, 1, 2012, NULL, NULL, 5, NULL),
(17, 'Юля Крижановська', NULL, NULL, NULL, 'member17.jpg', 3, 0, 1, 2010, NULL, NULL, 5, NULL),
(18, 'Олег Опіференко', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 5, NULL),
(19, 'Ярік Штефан', NULL, NULL, NULL, 'member19.jpg', 3, 0, 1, 2010, NULL, NULL, 6, NULL),
(20, 'Юра Лукаш', NULL, NULL, NULL, NULL, 3, 0, 1, 2009, NULL, NULL, 7, NULL),
(21, 'Маруся Кульбачка', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 8, NULL),
(22, 'Оля Бриндзя', NULL, NULL, NULL, NULL, 3, 0, 1, 2010, NULL, NULL, 8, NULL),
(23, 'Євген Філатов', NULL, NULL, NULL, 'member23.jpg', 3, 0, 0, 2011, NULL, NULL, 8, NULL),
(24, 'Юля Краліна', NULL, NULL, NULL, 'Kralina_Yulia.jpg', 3, 0, 1, 2009, NULL, NULL, 9, NULL),
(25, 'Міша Лорткіпанідзе', NULL, NULL, NULL, NULL, 3, 0, 0, 2010, NULL, NULL, 9, NULL),
(26, 'Таня Кармадонова', NULL, NULL, NULL, NULL, 3, 0, 1, 2010, NULL, NULL, 9, NULL),
(27, 'Влад Власюк', NULL, NULL, NULL, NULL, 3, 0, 1, 2013, NULL, NULL, 12, NULL),
(28, 'Саша Кузьменко', NULL, NULL, NULL, NULL, 3, 0, 1, 2014, NULL, NULL, 12, NULL),
(29, 'Ігор Єрмак', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 16, NULL),
(30, 'Віка Строкань', NULL, NULL, NULL, 'member30.jpg', 3, 0, 1, 2010, NULL, NULL, 16, NULL),
(31, 'Юра Лосінець', NULL, NULL, NULL, 'member31.jpg', 3, 0, 0, 2012, NULL, NULL, 17, NULL),
(32, 'Наташа Матєєва', NULL, NULL, NULL, NULL, 3, 0, 1, 2010, NULL, NULL, 20, NULL),
(33, 'Настя Артюх', NULL, NULL, NULL, NULL, 1, 0, 1, 2010, NULL, NULL, 20, NULL),
(34, 'Оля Тросянчук', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 23, NULL),
(35, 'Петро Дацюк', NULL, NULL, NULL, 'member35.jpg', 3, 0, 1, 2012, NULL, NULL, 23, NULL),
(36, 'Саша Корсун', NULL, NULL, NULL, NULL, 3, 0, 1, 2010, NULL, NULL, 24, NULL),
(37, 'Андрій Лебединець', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 24, NULL),
(38, 'Аліна Зенич', NULL, NULL, NULL, NULL, 1, 0, 1, 2011, NULL, NULL, 24, NULL),
(39, 'Юля Ширіна', NULL, NULL, NULL, NULL, 1, 0, 1, 2016, NULL, NULL, 27, NULL),
(40, 'Армен Аракелян', NULL, NULL, NULL, 'armen.jpg', 1, 0, 0, 2016, NULL, NULL, 27, NULL),
(41, 'Даша Андрєєва', NULL, NULL, NULL, 'member41.jpg', 3, 0, 0, 2015, NULL, NULL, 35, NULL),
(42, 'Лада Курабцева', NULL, NULL, NULL, 'kurabceva_lada.jpg', 3, 0, 1, 2013, NULL, NULL, 35, NULL),
(43, 'Оля Бєдова', NULL, NULL, NULL, NULL, 3, 0, 1, 2012, NULL, NULL, 36, NULL),
(44, 'Влад Ширінов', NULL, NULL, NULL, NULL, 1, 0, 0, 2016, NULL, NULL, 41, NULL),
(45, 'Аліса Котляренко', NULL, NULL, NULL, 'alisa_kotlyarenko.jpg', 3, 0, 1, 2015, NULL, NULL, 41, NULL),
(46, 'Міша Мороз', NULL, NULL, NULL, 'member46.jpg', 2, 0, 0, 2017, NULL, NULL, 41, NULL),
(47, 'Настя Шелудько', NULL, NULL, NULL, 'nastia_sheludko.jpg', 3, 0, 0, 2017, NULL, NULL, 41, NULL),
(48, 'Саша Єфіменко', NULL, NULL, NULL, 'alexandra_yefimenko.jpg', 3, 0, 1, 2014, NULL, NULL, 42, NULL),
(49, 'Ігор Суздалєв', NULL, NULL, NULL, 'ihor_suzdalev.jpg', 3, 0, 1, 2015, NULL, NULL, 42, NULL),
(50, 'Саша Погребенний', NULL, NULL, NULL, 'pogrebennyi.jpg', 3, 1, 1, 2016, NULL, NULL, 42, 4),
(51, 'Маша Брянцева', NULL, NULL, NULL, 'Masha_Briantseva.jpg', 3, 1, 1, 2016, NULL, NULL, 42, 1),
(52, 'Ліля Посівач', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 45, NULL),
(53, 'Юлія Касяненко', NULL, NULL, NULL, NULL, 1, 0, 0, 2017, NULL, NULL, 45, NULL),
(54, 'Іра Безкровна', NULL, NULL, NULL, 'member54.jpg', 1, 0, 1, 2017, NULL, NULL, 46, NULL),
(55, 'Саша Нєживов', NULL, NULL, NULL, NULL, 1, 0, 1, 2017, NULL, NULL, 46, NULL),
(56, 'Єва Колдовська', NULL, NULL, NULL, 'member56.jpg', 1, 0, 1, 2018, NULL, NULL, 47, NULL),
(57, 'Даша Попова', NULL, NULL, NULL, 'dasha_popova.jpg', 1, 1, 1, 2018, NULL, NULL, 47, NULL),
(58, 'Альона Поліщук', NULL, NULL, NULL, 'member58.jpg', 1, 0, 0, 2016, NULL, NULL, 48, NULL),
(59, 'Павло Красовський', NULL, NULL, NULL, NULL, 1, 0, 1, 2016, NULL, NULL, 48, NULL),
(60, 'Женя Боровик', NULL, NULL, NULL, NULL, 1, 0, 1, 2016, NULL, NULL, 48, NULL),
(61, 'Ваня Почта', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 48, NULL),
(62, 'Ваня Панченко', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 48, NULL),
(63, 'Таня Гупало', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 48, NULL),
(64, 'Наташа Моргун', NULL, NULL, NULL, 'member64.jpg', 3, 0, 0, 2015, NULL, NULL, 48, NULL),
(65, 'Ксенія Лещенко', NULL, NULL, NULL, 'ksenia_leshchenko.jpg', 1, 0, 1, 2017, NULL, NULL, 48, NULL),
(66, 'Кирило Чеботарьов', NULL, NULL, NULL, 'member66.jpg', 1, 0, 0, 2018, NULL, NULL, 49, NULL),
(67, 'Олег Паливода', NULL, NULL, NULL, 'member67.jpg', 1, 0, 0, 2017, NULL, NULL, 49, NULL),
(68, 'Міша Лук\'янець', NULL, NULL, '1999-03-23', 'Misha_Lukjanets.jpg', 2, 1, 0, 2018, 'ФПМ', 4, 50, 4),
(69, 'Катя Левошко', NULL, NULL, '1998-09-15', 'katya_lev.jpg', 2, 1, 1, 2018, 'ФПМ', 0, 50, 4),
(70, 'Аня Олексієнко', NULL, NULL, '1998-09-03', 'Hanna_Oleksiienko.jpg', 2, 1, 1, 2017, 'ІПСА', 0, 51, 1),
(71, 'Альона Калитенко', NULL, NULL, '1997-07-27', 'Alyona_Kalytenko.jpg', 2, 1, 0, 2018, 'ФІОТ', 0, 51, 1),
(72, 'Настя Давидова', NULL, NULL, NULL, 'Nastya_Davydova.jpg', 1, 1, 1, 2018, NULL, NULL, 51, 1),
(73, 'Руслан Кучеренко', NULL, NULL, NULL, 'Ruslan_Kucherenko.jpg', 1, 1, 1, 2018, NULL, NULL, 51, 1),
(74, 'Діма Мигаль', 'dimamyhal', 'dimamyhal', '1998-08-07', 'dima_myhal.jpg', 2, 1, 1, 2018, 'ФІОТ', 5, 70, 1),
(75, 'Віка Семендяк', NULL, NULL, NULL, 'vika_semendiak.jpg', 1, 1, 1, 2018, NULL, NULL, 70, 1),
(76, 'Ніна Міцюк', NULL, NULL, NULL, 'nina_mitsyk.jpg', 1, 0, 0, 2019, NULL, NULL, 70, 1),
(77, 'Нікіта Чуйков', NULL, NULL, NULL, 'nikita_chuykov.jpg', 1, 1, 1, 2019, NULL, NULL, 70, 1),
(78, 'Кіріл Бабич', NULL, NULL, NULL, 'member78.jpg', 1, 1, 1, 2019, NULL, NULL, 70, 1),
(79, 'Юра Штик', NULL, NULL, NULL, 'yura_shtyk.jpg', 1, 1, 1, 2019, NULL, NULL, 74, 1),
(80, 'Рома Кіндерись', NULL, NULL, NULL, 'roma_kinderys.jpg', 1, 1, 1, 2019, NULL, NULL, 74, 1),
(81, 'Женя Перегуда', NULL, NULL, NULL, 'zhenya_perehuda.jpg', 1, 1, 1, 2019, NULL, NULL, 74, 1),
(82, 'Зоя Іншакова', NULL, NULL, NULL, 'member82.jpg', 3, 0, 1, 2007, NULL, NULL, NULL, NULL),
(83, 'Іра Збруцька (Загірська)', NULL, NULL, NULL, 'member83.jpg', 3, 0, 1, 2007, NULL, NULL, NULL, NULL),
(84, 'Аня Шепеленко', NULL, NULL, NULL, 'member84.jpg', 3, 0, 1, 2007, NULL, NULL, NULL, NULL),
(85, 'Наташа Ванєєва', NULL, NULL, NULL, 'member85.jpg', 3, 0, 0, 2011, NULL, NULL, 82, NULL),
(86, 'Мар\'яна Кухтин', NULL, NULL, NULL, NULL, 3, 0, 1, 2008, NULL, NULL, 82, NULL),
(87, 'Інна Крюкова', NULL, NULL, NULL, NULL, 3, 0, 1, 2010, NULL, NULL, 82, NULL),
(88, 'Влад Шумілов', NULL, NULL, NULL, 'member88.jpg', 3, 0, 0, 2011, NULL, NULL, 83, NULL),
(89, 'Оля Галайко', NULL, NULL, NULL, 'member89.jpg', 3, 0, 1, 2007, NULL, NULL, 83, NULL),
(90, 'Олег Самулік', NULL, NULL, NULL, NULL, 3, 0, 1, 2009, NULL, NULL, 83, NULL),
(91, 'Марина Гребінна', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 84, NULL),
(92, 'Аня Локтева', NULL, NULL, NULL, 'member92.jpg', 3, 0, 0, 2009, NULL, NULL, 84, NULL),
(93, 'Ната Галайко', NULL, NULL, NULL, NULL, 3, 0, 0, 2008, NULL, NULL, 84, NULL),
(94, 'Дмитро Побережний', NULL, NULL, NULL, NULL, 1, 0, 1, 2009, NULL, NULL, 84, NULL),
(95, 'Катя Шрамченко', NULL, NULL, NULL, NULL, 3, 0, 0, 2011, NULL, NULL, 84, NULL),
(96, 'Олександр Жуль', NULL, NULL, NULL, NULL, 3, 0, 0, 2010, NULL, NULL, 84, NULL),
(97, 'Саша Пугачов', NULL, NULL, NULL, NULL, 3, 0, 0, 2013, NULL, NULL, 85, NULL),
(98, 'Таня Архіпова', NULL, NULL, NULL, 'member98.jpg', 3, 0, 1, 2012, NULL, NULL, 85, NULL),
(99, 'Таня Станішевська', NULL, NULL, NULL, NULL, 2, 0, 0, 2012, NULL, NULL, 85, NULL),
(100, 'Олена Ігнатович', NULL, NULL, NULL, NULL, 3, 0, 0, 2009, NULL, NULL, 89, NULL),
(101, 'Іра Коркішко', NULL, NULL, NULL, NULL, 3, 0, 1, 2009, NULL, NULL, 89, NULL),
(102, 'Олександр Метелиця', NULL, NULL, NULL, 'member102.jpg', 3, 0, 1, 2008, NULL, NULL, 89, NULL),
(103, 'Влад Терентьєв', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 92, NULL),
(104, 'Жасмін', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 92, NULL),
(105, 'Юля Губинець', NULL, NULL, NULL, NULL, 1, 0, 0, 2011, NULL, NULL, 92, NULL),
(106, 'Сергій Нікіфоров', NULL, NULL, NULL, NULL, 1, 0, 0, 2009, NULL, NULL, 93, NULL),
(107, 'Даша Чорнобаєва', NULL, NULL, NULL, NULL, 3, 0, 0, 2009, NULL, NULL, 93, NULL),
(108, 'Андрій Антоненко', NULL, NULL, NULL, NULL, 3, 0, 0, 2012, NULL, NULL, 95, NULL),
(109, 'Дарина Хомик', NULL, NULL, NULL, NULL, 3, 0, 0, 2012, NULL, NULL, 95, NULL),
(110, 'Ірина Лагно', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 96, NULL),
(111, 'Юлія Кіро', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 96, NULL),
(112, 'Юлія Проскурня', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 96, NULL),
(113, 'Настя Барбашина', NULL, NULL, NULL, 'member113.jpg', 3, 0, 0, 2012, NULL, NULL, 96, NULL),
(114, 'Леонід Вербов', NULL, NULL, NULL, 'leonid_verbov.jpg', 3, 0, 1, 2014, NULL, NULL, 97, 3),
(115, 'Юра Шурапов', NULL, NULL, NULL, NULL, 3, 0, 1, 2014, NULL, NULL, 97, NULL),
(116, 'Міша Путілов', NULL, NULL, NULL, 'member116.jpg', 3, 0, 1, 2015, NULL, NULL, 97, 3),
(117, 'Оля Івасюк', NULL, NULL, NULL, 'ivasiuk_olha.jpg', 3, 0, 0, 2014, NULL, NULL, 98, NULL),
(118, 'Даша Панічева', NULL, NULL, NULL, NULL, 3, 0, 1, 2013, NULL, NULL, 98, NULL),
(119, 'Юля Шкаровська', NULL, NULL, NULL, NULL, 3, 0, 1, 2013, NULL, NULL, 98, NULL),
(120, 'Юля Краснянська', NULL, NULL, NULL, NULL, 3, 0, 1, 2012, NULL, NULL, 99, NULL),
(121, 'Віталій Благодір', NULL, NULL, NULL, 'member121.jpg', 3, 0, 1, 2009, NULL, NULL, 100, NULL),
(122, 'Лєна Савчук', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 100, NULL),
(123, 'Олександр Гонтар', NULL, NULL, NULL, NULL, 3, 0, 0, 2010, NULL, NULL, 100, NULL),
(124, 'Альона Шамедько', NULL, NULL, NULL, NULL, 3, 0, 1, 2009, NULL, NULL, 102, NULL),
(125, 'Леся Гнідець', NULL, NULL, NULL, 'Lesya_Hnidets.jpg', 3, 0, 0, 2010, NULL, NULL, 102, NULL),
(126, 'Саша Томілін', NULL, NULL, NULL, 'sasha_tomilin.jpg', 3, 0, 1, 2009, NULL, NULL, 107, NULL),
(127, 'Антон Адамів', NULL, NULL, NULL, NULL, 3, 0, 0, 2014, NULL, NULL, 108, NULL),
(128, 'Оксана Семчук', NULL, NULL, NULL, 'member128.jpg', 1, 0, 1, 2015, NULL, NULL, 113, NULL),
(129, 'Саша Векліч', NULL, NULL, NULL, NULL, 3, 0, 1, 2014, NULL, NULL, 113, NULL),
(130, 'Свєта Аврахова', NULL, NULL, NULL, NULL, 3, 0, 0, 2015, NULL, NULL, 113, NULL),
(131, 'Віка Туряб', NULL, NULL, NULL, 'turyab_vika.jpg', 3, 0, NULL, NULL, NULL, NULL, 113, NULL),
(132, 'Ксюша Єлєва', NULL, NULL, NULL, NULL, 1, 0, 0, 2013, NULL, NULL, 113, NULL),
(133, 'Стас Лютенко', NULL, NULL, NULL, 'stas_liutenko.jpg', 3, 0, 0, 2015, NULL, NULL, 114, 3),
(134, 'Макс Ільїн', NULL, NULL, '1999-08-11', 'member134.jpg', 2, 1, 0, 2017, 'ФПМ', 4, 114, 3),
(135, 'Ксюша Гаршина', NULL, NULL, '1997-08-21', 'ksenia_garshina.jpg', 3, 1, 1, 2015, 'ФІОТ', 4, 115, 9),
(136, 'Костя Кучерявий', NULL, NULL, '1998-10-16', 'kostya_kucheriavyi.jpg', 2, 1, 0, 2017, 'ФТІ', 4, 116, 3),
(137, 'Юля Кобрин', NULL, NULL, NULL, 'julia_kobryn.jpg', 3, 0, 0, 2016, NULL, NULL, 117, NULL),
(138, 'Саша Голубєва', NULL, NULL, NULL, NULL, 3, 0, 1, 2015, NULL, NULL, 117, NULL),
(139, 'Саша Криушин', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 117, NULL),
(140, 'Макс Прокопенко', NULL, NULL, NULL, 'Prakop.jpg', 3, 0, 1, 2015, NULL, NULL, 118, 7),
(141, 'Боря Бакланов', NULL, NULL, NULL, 'boris_baklanov.jpg', 3, 0, 0, 2015, NULL, NULL, 119, 6),
(142, 'Адель Шахін', NULL, NULL, NULL, 'adel_shakhin.jpg', 3, 0, 0, 2015, NULL, NULL, 120, NULL),
(143, 'Іра Калінчік', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 121, NULL),
(144, 'Іван Дунський', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 124, NULL),
(145, 'Влада Мацкевич', NULL, NULL, NULL, NULL, 3, 0, 0, 2011, NULL, NULL, 124, NULL),
(146, 'Володимир Кролівець', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 124, NULL),
(147, 'Тімур Пророченко', NULL, NULL, NULL, NULL, 1, 0, 0, 2011, NULL, NULL, 125, NULL),
(148, 'Макс Лаєвський', NULL, NULL, NULL, NULL, 1, 0, 0, 2011, NULL, NULL, 125, NULL),
(149, 'Саша Бурима', NULL, NULL, NULL, 'member149.jpg', 3, 0, 1, 2011, NULL, NULL, 125, NULL),
(150, 'Евеліна Селебінка', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 126, NULL),
(151, 'Стас Бондаренко', NULL, NULL, NULL, 'stas_bondarenko.jpg', 1, 0, 0, 2016, NULL, NULL, 130, NULL),
(152, 'Юля Ступак', NULL, NULL, NULL, 'julia_stupak.jpg', 3, 0, 0, 2017, NULL, NULL, 131, NULL),
(153, 'Інга Візниця', NULL, NULL, NULL, 'member153.jpg', 3, 0, 1, 2014, NULL, NULL, 131, NULL),
(154, 'Андрій Руденко', NULL, NULL, NULL, NULL, 1, 0, 1, 2015, NULL, NULL, 131, NULL),
(155, 'Віта Прищепа', NULL, NULL, '1997-09-18', 'vita_pryshchepa.jpg', 2, 1, 1, 2016, 'ФСП', 0, 132, 2),
(156, 'Сергій Ніношвілі', NULL, NULL, '1996-03-22', 'sehiy_nino.jpg', 2, 1, 1, 2017, 'ФЕЛ', NULL, 133, 3),
(157, 'Влад Бондаренко', NULL, NULL, NULL, 'vlad_bondarenko.jpg', 1, 0, NULL, NULL, NULL, NULL, 133, 3),
(158, 'Юля Кременецька', NULL, NULL, NULL, 'yulka_krem.jpg', 1, 0, 1, 2019, NULL, NULL, 134, 3),
(159, 'Аня Чорногор', NULL, NULL, NULL, 'anya_chornohor.jpg', 1, 1, 1, 2018, NULL, NULL, 135, 8),
(160, 'Оля Сиротюк', NULL, NULL, NULL, NULL, 1, 0, 1, 2018, NULL, NULL, 135, 9),
(161, 'Таня Величко', NULL, NULL, NULL, 'tania_velychko.jpg', 1, 1, 0, 2019, NULL, NULL, 136, 3),
(162, 'Артем Литовченко', NULL, NULL, NULL, 'artem_lytva.jpg', 1, 1, 0, 2019, NULL, NULL, 136, 3),
(163, 'Діма Андрієвський', NULL, NULL, NULL, 'member163.jpg', 1, 1, 1, 2018, NULL, NULL, 136, 3),
(164, 'Каріна Жуковська', NULL, NULL, '2001-07-25', 'karina_zhukovska.jpg', 2, 1, 1, 2018, 'ФБТ', 2, 136, 3),
(165, 'Таня Власенко', NULL, NULL, NULL, 'tanya_vlasenko.jpg', 1, 1, 1, 2019, NULL, NULL, 136, 3),
(166, 'Максим Височін', NULL, NULL, NULL, 'max_vysochin.jpg', 1, 0, 1, 2019, NULL, NULL, 136, 3),
(167, 'Юля Бодавець', NULL, NULL, '1998-11-10', 'julia_bodavets.jpg', 2, 1, 0, 2017, 'ФІОТ', 4, 140, 7),
(168, 'Яна Стрижак', NULL, NULL, NULL, 'yana_strizhak.jpg', 1, 1, 0, 2017, NULL, NULL, 140, 7),
(169, 'Настя Лагно', NULL, NULL, '2000-05-07', 'nastia_lagno.jpg', 2, 1, 1, 2018, 'ФПМ', 3, 140, 7),
(170, 'Катя Нікітіна', NULL, NULL, NULL, 'member170.jpg', 0, 0, 0, 2018, NULL, NULL, 140, 7),
(171, 'Катя Ващенко', NULL, NULL, '1997-09-08', 'katya_vashchenko.jpg', 2, 1, 1, 2017, 'ФЕА', NULL, 140, 7),
(173, 'Вітя Яцкін', NULL, NULL, NULL, 'vitya_yatskin.jpg', 3, 0, 0, 2016, NULL, NULL, 141, 6),
(174, 'Лєна Шахін', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 142, NULL),
(175, 'Олександр Альохін', NULL, NULL, NULL, 'member175.jpg', 3, 0, 0, 2011, NULL, NULL, 145, NULL),
(176, 'Катя Мячина', NULL, NULL, NULL, 'member176.jpg', 3, 0, 1, 2013, NULL, NULL, 149, NULL),
(177, 'Лєра Шукатка', NULL, NULL, NULL, 'lera_shukatka.jpg', 3, 0, 0, 2013, NULL, NULL, 149, NULL),
(178, 'Аня Соловйова', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 152, NULL),
(179, 'Ліза Гончар', NULL, NULL, NULL, NULL, 1, 0, 1, 2018, NULL, NULL, 152, NULL),
(180, 'Таня Нагорняк', NULL, NULL, '1996-03-02', 'tania_nahorniak.jpg', 2, 1, 1, 2015, 'ФБТ', 0, 153, NULL),
(181, 'Юля Ковальчук', NULL, NULL, NULL, 'julia_lovalchuk.jpg', 1, 1, 0, 2018, NULL, NULL, 155, 2),
(182, 'Влада Жмуркевич', NULL, NULL, NULL, 'member182.jpg', 1, 0, 0, 2018, NULL, NULL, 155, 2),
(183, 'Єгор Мирошниченко', NULL, NULL, '1997-11-10', 'yehor_myroshmychenko.jpg', 2, 1, 0, 2019, 'ФЕЛ', 0, 155, 2),
(184, 'Оля Смирнова', NULL, NULL, '2000-10-15', 'olya_smirnova.jpg', 2, 1, 1, 2018, 'ФММ', 3, 155, 2),
(185, 'Марина Піталова', NULL, NULL, NULL, 'marina_pitalova.jpg', 1, 1, 0, 2019, NULL, NULL, 155, 2),
(186, 'Катя Стефанович', NULL, NULL, '1998-11-23', 'katya_stef.jpg', 3, 1, 1, 2017, 'ФСП', 4, 155, 2),
(187, 'Міша Швець', NULL, NULL, '1997-09-15', 'misha_shvets.jpg', 2, 1, 1, 2017, 'ФЕЛ', 0, 155, 2),
(188, 'Яся Бондарчук', NULL, NULL, NULL, 'yasya_bondarchuk.jpg', 1, 1, 1, 2019, NULL, NULL, 155, 2),
(189, 'Іван Гритчук', NULL, NULL, NULL, 'ivan_hrytchuk.jpg', 1, 1, 0, 2019, NULL, NULL, 156, 3),
(190, 'Саша Числов', NULL, NULL, NULL, 'sasha_chyslov.jpg', 1, 1, 1, 2018, NULL, NULL, 156, 3),
(191, 'Микола Мельник', NULL, NULL, NULL, 'member191.jpg', 1, 0, 1, 2018, NULL, NULL, 156, 3),
(192, 'Інга Манжуленко', NULL, NULL, NULL, 'member192.jpg', 1, 1, 0, 2019, NULL, NULL, 156, 3),
(193, 'Тетяна Онищук', NULL, NULL, NULL, NULL, 1, 0, 1, 2019, NULL, NULL, 164, 3),
(194, 'Омар Массауді', NULL, NULL, NULL, 'omar_massaudi.jpg', 1, 1, 1, 2019, NULL, NULL, 164, 3),
(195, 'Андрій Власов', NULL, NULL, NULL, 'andrey_vlasov.jpg', 1, 1, 1, 2019, NULL, NULL, 164, 3),
(196, 'Сергій Мілантьєв', NULL, NULL, NULL, 'serhiy_milantiev.jpg', 1, 1, 1, 2019, NULL, NULL, 167, 7),
(197, 'Дмитро Бурденко', NULL, NULL, NULL, 'Dmytro_Burdenko.jpg', 1, 1, 1, 2019, NULL, NULL, 167, 7),
(198, 'Маша Ковальчук', NULL, NULL, NULL, 'masha_kovalchuk.jpg', 1, 1, 0, 2019, NULL, NULL, 171, 7),
(199, 'Марина Коваленко', NULL, NULL, NULL, 'member199.jpg', 3, 0, 1, 2016, NULL, NULL, 173, NULL),
(200, 'Антон Бауман', NULL, NULL, NULL, NULL, 1, 0, 1, 2016, NULL, NULL, 173, NULL),
(201, 'Аліса Піцик', NULL, NULL, NULL, 'member201.jpg', 3, 0, 1, 2016, NULL, NULL, 173, NULL),
(202, 'Арсен Куник', NULL, NULL, '1998-10-03', 'arsen_kunyk.jpg', 2, 1, 1, 2017, 'ТЕФ', 5, 173, 6),
(203, 'Рома Бородатов', NULL, NULL, NULL, 'roma_borodatov.jpg', 3, 0, 0, 2017, NULL, NULL, 173, 6),
(204, 'Нікіта Комолов', NULL, NULL, NULL, 'komolov_mykyta.jpg', 3, 0, 1, 2015, NULL, NULL, 176, NULL),
(205, 'Поліна Ворошилова', NULL, NULL, NULL, NULL, 3, 0, 1, 2015, NULL, NULL, 177, NULL),
(206, 'Дарина Гавриш', NULL, NULL, NULL, NULL, 1, 0, 0, 2015, NULL, NULL, 177, NULL),
(207, 'Саша Рижик', NULL, NULL, NULL, NULL, 1, 0, 0, 2017, NULL, NULL, 177, NULL),
(208, 'Юля', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 177, NULL),
(209, 'Оля Сирота', NULL, NULL, NULL, 'olya_syrota.jpg', 1, 1, 0, 2018, NULL, NULL, 180, NULL),
(210, 'Лєра Кугук', NULL, NULL, NULL, NULL, 1, 0, NULL, NULL, NULL, NULL, 180, NULL),
(211, 'Віка Макарова', NULL, NULL, NULL, 'vika_makarova.jpg', 1, 1, 0, 2018, NULL, NULL, 180, NULL),
(212, 'Вероніка Єремєєва', NULL, NULL, '1999-07-09', 'nika_yeremeyeva.jpg', 2, 1, 1, 2018, 'ІПСА', 4, 186, 2),
(213, 'Денис Гритчук', NULL, NULL, '1997-04-25', 'denys_hrytchuk.jpg', 2, 1, 1, 2018, 'ТЕФ', 6, 186, 2),
(214, 'Андрій Голіней', NULL, NULL, NULL, NULL, 1, 0, 1, 2018, NULL, NULL, 187, 2),
(215, 'Єгор Нестеренко', NULL, NULL, '1999-12-10', 'yehor_nesterenko.jpg', 2, 1, 1, 2018, 'ФІОТ', 3, 187, 2),
(216, 'Марина Музя', NULL, NULL, NULL, 'marina_muzya.jpg', 1, 1, 0, 2019, NULL, NULL, 187, 2),
(217, 'Денис Юрченко', NULL, NULL, NULL, NULL, 1, 1, 1, 2019, NULL, NULL, 187, 2),
(218, 'Олексій Котвицький', NULL, NULL, NULL, NULL, 1, 0, 1, 2018, NULL, NULL, 199, NULL),
(219, 'Ілля Юшенко', NULL, NULL, NULL, 'illiya_yushenko.jpg', 1, 1, 0, 2019, NULL, NULL, 202, 6),
(220, 'Іра Абрамович', NULL, NULL, '1999-07-22', 'ira_abramovych.jpg', 2, 1, 1, 2017, 'ФСП', 4, 203, 6),
(221, 'Саша Подолян', NULL, NULL, '2000-09-13', 'podolyan.jpg', 2, 1, 0, 2018, 'ФММ', 3, 203, 8),
(222, 'Артем Ніколаєв', NULL, NULL, NULL, 'artem_nikolaiev.jpg', 1, 1, 0, 2018, NULL, NULL, 203, 6),
(223, 'Даша Ханюченко', NULL, NULL, NULL, NULL, 1, 0, 0, 2019, NULL, NULL, 203, 6),
(224, 'Даня Буханько', NULL, NULL, '1997-11-13', 'dania_bukhanko.jpg', 2, 1, 0, 2017, 'ФЕЛ', 0, 203, 6),
(225, 'Юра Блінов', NULL, NULL, NULL, 'yura_blinov.jpg', 3, 1, 1, 2016, NULL, NULL, 204, 5),
(226, 'Діма Уруков', NULL, NULL, NULL, 'dima_urukov.jpg', 3, 1, 0, 2017, NULL, NULL, 204, NULL),
(227, 'Єлизавета Кияткіна', NULL, NULL, NULL, 'member227.jpg', 0, 0, 1, 2019, NULL, NULL, 212, NULL),
(228, 'Назар Яскал', NULL, NULL, NULL, 'member228.jpg', 1, 1, 1, 2019, NULL, NULL, 212, NULL),
(229, 'Женя Іващенко', NULL, NULL, NULL, 'zhenya_ivashchenko.jpg', 1, 1, 1, 2019, NULL, NULL, 213, NULL),
(230, 'Софія Шумель', NULL, NULL, NULL, 'sonya_shumel.jpg', 1, 1, 1, 2019, NULL, NULL, 213, NULL),
(231, 'Микита Морозов', NULL, NULL, NULL, 'mykyta_morozov.jpg', 0, 1, 1, 2019, NULL, NULL, 213, NULL),
(232, 'Ліза Кущенко', NULL, NULL, NULL, 'kushchenko_liza.jpg', 1, 0, 1, 2019, NULL, NULL, 215, 2),
(233, 'Катя Грініх', NULL, NULL, NULL, 'kate_grinih.jpg', 1, 1, 1, 2019, NULL, NULL, 221, 8),
(234, 'Аладдін Сулейманов', NULL, NULL, NULL, 'Aladdin_Suleimanov.jpg', 1, 1, 1, 2019, NULL, NULL, 221, 8),
(235, 'Демід Попенко', NULL, NULL, NULL, 'demyd_popenko.jpg', 1, 1, 1, 2018, NULL, NULL, 224, 6),
(236, 'Настя П\'яткова', NULL, NULL, NULL, 'Nastia_Piatkova.jpg', 1, 1, 1, 2018, NULL, NULL, 224, 6),
(237, 'Ліза Копернак', NULL, NULL, NULL, NULL, 1, 0, NULL, 2019, NULL, NULL, 224, 6),
(238, 'Настя Бутенко', NULL, NULL, '1998-02-25', 'nastia_butenko.jpg', 2, 1, 1, 2017, 'ФЕА', NULL, 225, 5),
(239, 'Настя Кондаурова', NULL, NULL, NULL, NULL, 1, 0, 1, 2017, NULL, NULL, 225, 5),
(240, 'Андрій Юдов', NULL, NULL, NULL, 'yudov_andriy.jpg', 1, 0, 0, 2018, NULL, NULL, 225, 5),
(241, 'Ліка Князева', NULL, NULL, NULL, 'knyazeva_lika.jpg', 1, 0, 0, 2018, NULL, NULL, 225, 5),
(242, 'Вадік Отрішко', NULL, NULL, '2001-02-12', 'vadik_otrishko.jpg', 2, 1, 1, 2018, 'ФЕА', 2, 225, 5),
(243, 'Артур Козловський', NULL, NULL, NULL, 'archi_kozlovski.jpg', 1, 1, 1, 2018, NULL, NULL, 225, 5),
(244, 'Марія Гребінченко', NULL, NULL, NULL, 'member244.jpg', 1, 1, 1, 2018, NULL, NULL, 226, NULL),
(245, 'Міша Барвінко', NULL, NULL, NULL, 'member245.jpg', 1, 1, 0, 2019, NULL, NULL, 238, 5),
(246, 'Даша Ковальчук', NULL, NULL, NULL, 'dasha_kovalchuk.jpg', 1, 1, 0, 2019, NULL, NULL, 238, 5),
(247, 'Марк Герасименко', NULL, NULL, NULL, 'mark_herasymenko.jpg', 1, 1, 1, 2019, NULL, NULL, 242, 5),
(248, 'Ліза Нечай', NULL, NULL, NULL, 'liza_nechay.jpg', 1, 0, 1, 2019, NULL, NULL, 242, 5),
(250, 'Катя Шубіна', NULL, NULL, NULL, 'katya_shubina.jpg', 3, 0, 0, 2012, NULL, NULL, 17, NULL),
(251, 'Діма Федоров', NULL, NULL, NULL, 'member251.png', 3, 0, 0, 2012, NULL, NULL, 85, NULL),
(252, 'Поліна Якименко', NULL, NULL, NULL, 'Polina_Yakymenko.jpg', 3, 0, 0, 2012, NULL, NULL, 85, NULL),
(253, 'Марина Шалько', NULL, NULL, NULL, NULL, 3, 0, 1, 2012, NULL, NULL, 36, NULL),
(254, 'Каріна Азарян', NULL, NULL, NULL, 'karina_azarian.jpg', 3, 0, 1, 2012, NULL, NULL, 10, NULL),
(255, 'Ліза Ручко', NULL, NULL, NULL, NULL, 3, 0, 1, 2008, NULL, NULL, 83, NULL),
(256, 'Саша Чумак', NULL, NULL, NULL, NULL, 3, 0, 1, 2008, NULL, NULL, 83, NULL),
(257, 'Івашкіна Олена', NULL, NULL, NULL, NULL, 3, 0, 0, 2002, NULL, NULL, 100, NULL),
(259, 'Маша Шкулепова', NULL, NULL, NULL, 'masha_shkulepova.jpg', 1, 1, 1, 2019, NULL, NULL, 69, 4),
(266, 'Діана Скляр', NULL, NULL, NULL, 'member266.jpg', 0, 1, 0, 2020, NULL, NULL, 134, 3),
(267, 'Марина Бірюкова', NULL, NULL, NULL, 'member267.jpg', 0, 1, 0, 2020, NULL, NULL, 134, 3),
(269, 'Катя Дівущак', NULL, NULL, NULL, 'member269.jpg', 0, 1, 0, 2020, NULL, NULL, 169, 7),
(272, 'Валерія Кучеренко', NULL, NULL, NULL, 'member272.jpg', 1, 0, 1, 2018, NULL, NULL, 140, 7),
(273, 'Вікторія Лавренюк', NULL, NULL, NULL, 'member273.jpg', 0, 1, 0, 2020, NULL, NULL, 71, 1),
(274, 'Настя Вінічук', NULL, NULL, NULL, 'member274.jpg', 0, 1, 0, 2020, NULL, NULL, 74, 1),
(275, 'Андрій Руденко', NULL, NULL, NULL, NULL, 0, 1, 0, 2020, NULL, NULL, 242, 5),
(276, 'Женя Поваров', NULL, NULL, NULL, NULL, 0, 1, 0, 2020, NULL, NULL, 242, 5),
(277, 'Нікіта Бутенко', NULL, NULL, NULL, 'member277.jpg', 0, 1, 0, 2020, NULL, NULL, 212, 2),
(278, 'Саша Кобзар', NULL, NULL, NULL, NULL, 0, 1, 0, 2020, NULL, NULL, 167, 7),
(279, 'Паша Пивовар', NULL, NULL, NULL, 'member279.jpg', 0, 1, 0, 2020, NULL, NULL, 167, 7),
(280, 'Льоша Коток', NULL, NULL, NULL, 'member280.jpg', 0, 1, 0, 2020, NULL, NULL, 220, 6),
(281, 'Марина Кубенко', NULL, NULL, NULL, 'member281.jpg', 0, 1, 0, 2020, NULL, NULL, 221, 8),
(282, 'Микита Головакін', NULL, NULL, NULL, 'member282.jpg', 0, 1, 0, 2020, NULL, NULL, 213, 2),
(283, 'Діма Сьомченко', NULL, NULL, NULL, NULL, 0, 1, 0, 2020, NULL, NULL, 215, 2),
(284, 'Руслан Мельник', NULL, NULL, NULL, 'member284.jpg', 0, 1, 0, 2020, NULL, NULL, 213, 2),
(285, 'Марина Юрченко', NULL, NULL, NULL, 'member285.jpg', 0, 1, 0, 2020, NULL, NULL, 164, 3),
(299, 'Новий мембер', NULL, NULL, NULL, NULL, 2, 1, 0, 2020, NULL, NULL, 297, 1),
(300, 'Новий мембер5', NULL, NULL, NULL, NULL, 0, 1, 0, 2020, NULL, NULL, 299, 1);

-- --------------------------------------------------------

--
-- Структура таблиці `project`
--

CREATE TABLE `project` (
  `id` int(10) NOT NULL,
  `type_id` int(10) NOT NULL,
  `year` year(4) NOT NULL,
  `coreteam_name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `project`
--

INSERT INTO `project` (`id`, `type_id`, `year`, `coreteam_name`) VALUES
(1, 1, 2020, NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `project_position`
--

CREATE TABLE `project_position` (
  `id` int(10) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abbreviation` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп даних таблиці `project_position`
--

INSERT INTO `project_position` (`id`, `name`, `abbreviation`) VALUES
(1, 'Main Organiser', 'MO'),
(2, 'Corporate Relationships Responsible', 'CR Resp'),
(3, 'Logistics Responsible', 'Logist'),
(4, 'Designer', NULL),
(5, 'Public Relations Responsible', 'PR Resp');

-- --------------------------------------------------------

--
-- Структура таблиці `project_type`
--

CREATE TABLE `project_type` (
  `id` int(10) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abbreviation` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп даних таблиці `project_type`
--

INSERT INTO `project_type` (`id`, `name`, `abbreviation`) VALUES
(1, 'European BEST Engineering Competition', 'EBEC');

--
-- Індекси збережених таблиць
--

--
-- Індекси таблиці `coreteam_member`
--
ALTER TABLE `coreteam_member`
  ADD PRIMARY KEY (`id`),
  ADD KEY `member_id` (`member_id`),
  ADD KEY `project_id` (`project_id`),
  ADD KEY `position_id` (`position_id`);

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
  ADD KEY `children_mentor_foreign` (`mentor_id`),
  ADD KEY `member_family_foreign` (`family_id`);

--
-- Індекси таблиці `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `type_id` (`type_id`) USING BTREE;

--
-- AUTO_INCREMENT для збережених таблиць
--

--
-- AUTO_INCREMENT для таблиці `member`
--
ALTER TABLE `member`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=302;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
