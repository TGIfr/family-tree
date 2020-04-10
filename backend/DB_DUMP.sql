-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3306
-- Час створення: Бер 21 2020 р., 15:17
-- Версія сервера: 5.6.41
-- Версія PHP: 7.0.32

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База даних: `bestkyivfamilytree`
--

-- --------------------------------------------------------

--
-- Структура таблиці `family`
--

CREATE TABLE `family` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `family`
--

INSERT INTO `family` (`id`, `name`, `logo`) VALUES
(1, 'Royal Family', 'royal.png'),
(2, 'Цезарі', NULL);

-- --------------------------------------------------------

--
-- Структура таблиці `member`
--

CREATE TABLE `member` (
  `id` int(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT '0',
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `rec_season` int(1) DEFAULT NULL,
  `rec_year` year(4) DEFAULT NULL,
  `mentor_id` int(255) DEFAULT NULL,
  `family_id` int(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `children_mentor_foreign` (`mentor_id`),
  KEY `member_family_foreign` (`family_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Дамп даних таблиці `member`
--

INSERT INTO `member` (`id`, `name`, `image`, `status`, `active`, `rec_season`, `rec_year`, `mentor_id`, `family_id`) VALUES
(2, 'Настя Міщук', NULL, 3, 0, 1, 2008, 1, NULL),
(1, 'Аня Ланєвська', NULL, 3, 0, 1, 2007, NULL, NULL),
(3, 'Аня Архіпова', NULL, 3, 0, 1, 2009, 1, NULL),
(4, 'Антон Поліщук', NULL, 3, 0, 0, 2009, 1, NULL),
(5, 'Світлана Єзгор', NULL, 3, 0, 0, 2009, 1, NULL),
(6, 'Таня Нєчаєва', NULL, 3, 0, 0, 2010, 2, NULL),
(7, 'Юля Юрченко', NULL, 3, 0, 0, 2009, 2, NULL),
(8, 'Єгор Кульбачка', NULL, 3, 0, 1, 2009, 2, NULL),
(9, 'Олексій Потапенко', NULL, 3, 0, 0, 2009, 2, NULL),
(10, 'Ксюша Сорока', NULL, 3, 0, 1, 2010, 3, NULL),
(11, 'Андрій Терентьєв', NULL, 1, 0, NULL, NULL, 3, NULL),
(12, 'Катя Федорець', NULL, 3, 0, 1, 2012, 4, NULL),
(13, 'Віка Калініченко', NULL, 1, 0, NULL, NULL, 4, NULL),
(14, 'Діма Страшко', NULL, 3, 0, 1, 2010, 5, NULL),
(15, 'Марта Гожа', NULL, 1, 0, NULL, NULL, 5, NULL),
(16, 'Марк Паславський', NULL, 3, 0, 1, 2012, 5, NULL),
(17, 'Юля Крижановська', NULL, 3, 0, 1, 2010, 5, NULL),
(18, 'Олег Опіференко', NULL, 1, 0, NULL, NULL, 5, NULL),
(19, 'Ярік Штефан', NULL, 3, 0, 1, 2010, 6, NULL),
(20, 'Юра Лукаш', NULL, 3, 0, 1, 2009, 7, NULL),
(21, 'Маруся Кульбачка', NULL, 1, 0, NULL, NULL, 8, NULL),
(22, 'Оля Бриндзя', NULL, 3, 0, 1, 2010, 8, NULL),
(23, 'Євген Філатов', NULL, 3, 0, 0, 2011, 8, NULL),
(24, 'Юля Краліна', 'Kralina_Yulia.jpg', 3, 0, 1, 2009, 9, NULL),
(25, 'Міша Лорткіпанідзе', NULL, 3, 0, 0, 2010, 9, NULL),
(26, 'Таня Кармадонова', NULL, 3, 0, 1, 2010, 9, NULL),
(27, 'Влад Власюк', NULL, 3, 0, 1, 2013, 12, NULL),
(28, 'Саша Кузьменко', NULL, 3, 0, 1, 2014, 12, NULL),
(29, 'Ігор Єрмак', NULL, 1, 0, NULL, NULL, 16, NULL),
(30, 'Віка Строкань', NULL, 3, 0, 1, 2010, 16, NULL),
(31, 'Юра Лосінець', NULL, 3, 0, 0, 2012, 17, NULL),
(32, 'Наташа Матєєва', NULL, 3, 0, 1, 2010, 20, NULL),
(33, 'Настя Артюх', NULL, 1, 0, 1, 2010, 20, NULL),
(34, 'Оля Тросянчук', NULL, 1, 0, NULL, NULL, 23, NULL),
(35, 'Петро Дацюк', NULL, 3, 0, 1, 2012, 23, NULL),
(36, 'Саша Корсун', NULL, 3, 0, 1, 2010, 24, NULL),
(37, 'Андрій Лебединець', NULL, 1, 0, NULL, NULL, 24, NULL),
(38, 'Аліна Зенич', NULL, 1, 0, 1, 2011, 24, NULL),
(39, 'Юля Ширіна', NULL, 1, 0, 1, 2016, 27, NULL),
(40, 'Армен Аракелян', 'armen.jpg', 1, 0, 0, 2016, 27, NULL),
(41, 'Даша Андрєєва', NULL, 3, 0, 0, 2015, 35, NULL),
(42, 'Лада Курабцева', 'kurabceva_lada.jpg', 3, 0, 1, 2013, 35, NULL),
(43, 'Оля Бєдова', NULL, 3, 0, 1, 2012, 36, NULL),
(44, 'Влад Ширінов', NULL, 1, 0, 0, 2016, 41, NULL),
(45, 'Аліса Котляренко', 'alisa_kotlyarenko.jpg', 3, 0, 1, 2015, 41, NULL),
(46, 'Міша Мороз', NULL, 2, 0, 0, 2017, 41, NULL),
(47, 'Настя Шелудько', 'nastia_sheludko.jpg', 3, 0, 0, 2017, 41, NULL),
(48, 'Саша Єфіменко', 'alexandra_yefimenko.png', 3, 0, 1, 2014, 42, NULL),
(49, 'Ігор Суздалєв', 'ihor_suzdalev.jpeg', 3, 0, 1, 2015, 42, NULL),
(50, 'Саша Погребенний', 'pogrebennyi.jpeg', 3, 0, 1, 2016, 42, NULL),
(51, 'Маша Брянцева', 'Masha_Briantseva.jpg', 3, 0, 1, 2016, 42, 1),
(52, 'Ліля Посівач', NULL, 1, 0, NULL, NULL, 45, NULL),
(53, 'Юлія Касяненко', NULL, 1, 0, 0, 2017, 45, NULL),
(54, 'Іра Безкровна', NULL, 1, 0, 1, 2017, 46, NULL),
(55, 'Саша Нєживов', NULL, 1, 0, 1, 2017, 46, NULL),
(56, 'Єва Колдовська', NULL, 1, 1, 1, 2018, 47, NULL),
(57, 'Даша Попова', 'dasha_popova.jpg', 1, 1, 1, 2018, 47, NULL),
(58, 'Альона Поліщук', NULL, 1, 0, 0, 2016, 48, NULL),
(59, 'Павло Красовський', NULL, 1, 0, 1, 2016, 48, NULL),
(60, 'Женя Боровик', NULL, 1, 0, 1, 2016, 48, NULL),
(61, 'Ваня Почта', NULL, 1, 0, NULL, NULL, 48, NULL),
(62, 'Ваня Панченко', NULL, 1, 0, NULL, NULL, 48, NULL),
(63, 'Таня Гупало', NULL, 1, 0, NULL, NULL, 48, NULL),
(64, 'Наташа Моргун', NULL, 3, 0, 0, 2015, 48, NULL),
(65, 'Ксенія Лещенко', 'ksenia_leshchenko.jpg', 1, 0, 1, 2017, 48, NULL),
(66, 'Кирило Чеботарьов', NULL, 1, 0, NULL, NULL, 49, NULL),
(67, 'Олег Паливода', NULL, 1, 0, 0, 2017, 49, NULL),
(68, 'Міша Лук\'янець', 'Misha_Lukjanets.jpg', 2, 1, 0, 2018, 50, NULL),
(69, 'Катя Левошко', 'katya_lev.jpg', 2, 1, 1, 2018, 50, NULL),
(70, 'Аня Олексієнко', 'Hanna_Oleksiienko.jpg', 2, 1, 1, 2017, 51, 1),
(71, 'Альона Калитенко', 'Alyona_Kalytenko.jpg', 2, 1, 0, 2018, 51, 1),
(72, 'Настя Давидова', 'Nastya_Davydova.jpg', 1, 1, 1, 2018, 51, 1),
(73, 'Руслан Кучеренко', 'Ruslan_Kucherenko.jpg', 1, 1, 1, 2018, 51, 1),
(74, 'Діма Мигаль', 'dima_myhal.jpg', 2, 1, 1, 2018, 70, 1),
(75, 'Віка Семендяк', 'vika_semendiak.jpg', 1, 1, 1, 2018, 70, 1),
(76, 'Ніна Міцюк', 'nina_mitsyk.jpg', 1, 0, 0, 2019, 70, 1),
(77, 'Нікіта Чуйков', 'nikita_chuykov.jpg', 1, 1, 1, 2019, 70, 1),
(78, 'Кіріл Бабич', NULL, 1, 1, 1, 2019, 70, 1),
(79, 'Юра Штик', 'yura_shtyk.jpeg', 1, 1, 1, 2019, 74, 1),
(80, 'Рома Кіндерись', 'roma_kinderys.jpg', 1, 1, 1, 2019, 74, 1),
(81, 'Женя Перегуда', 'zhenya_perehuda.jpg', 1, 1, 1, 2019, 74, 1),
(82, 'Зоя Іншакова', NULL, 3, 0, 1, 2007, NULL, NULL),
(83, 'Іра Збруцька (Загірська)', NULL, 3, 0, 1, 2007, NULL, NULL),
(84, 'Аня Шепеленко', NULL, 3, 0, 1, 2007, NULL, NULL),
(85, 'Наташа Ванєєва', NULL, 3, 0, 0, 2011, 82, NULL),
(86, 'Мар\'яна Кухтин', NULL, 3, 0, 1, 2008, 82, NULL),
(87, 'Інна Крюкова', NULL, 3, 0, 1, 2010, 82, NULL),
(88, 'Влад Шумілов', NULL, 3, 0, 0, 2011, 83, NULL),
(89, 'Оля Галайко', NULL, 3, 0, 1, 2007, 83, NULL),
(90, 'Олег Самулік', NULL, 3, 0, 1, 2009, 83, NULL),
(91, 'Марина Гребінна', NULL, 1, 0, NULL, NULL, 84, NULL),
(92, 'Аня Локтева', NULL, 3, 0, 0, 2009, 84, NULL),
(93, 'Ната Галайко', NULL, 3, 0, 0, 2008, 84, NULL),
(94, 'Дмитро Побережний', NULL, 1, 0, 1, 2009, 84, NULL),
(95, 'Катя Шрамченко', NULL, 3, 0, 0, 2011, 84, NULL),
(96, 'Олександр Жуль', NULL, 3, 0, 0, 2010, 84, NULL),
(97, 'Саша Пугачов', NULL, 3, 0, 0, 2013, 85, NULL),
(98, 'Таня Архіпова', NULL, 3, 0, 1, 2012, 85, NULL),
(99, 'Таня Станішевська', NULL, 2, 0, 0, 2012, 85, NULL),
(100, 'Олена Ігнатович', NULL, 3, 0, 0, 2009, 89, NULL),
(101, 'Іра Коркішко', NULL, 3, 0, 1, 2009, 89, NULL),
(102, 'Олександр Метелиця', NULL, 3, 0, 1, 2008, 89, NULL),
(103, 'Влад Терентьєв', NULL, 1, 0, NULL, NULL, 92, NULL),
(104, 'Жасмін', NULL, 1, 0, NULL, NULL, 92, NULL),
(105, 'Юля Губинець', NULL, 1, 0, 0, 2011, 92, NULL),
(106, 'Сергій Нікіфоров', NULL, 1, 0, 0, 2009, 93, NULL),
(107, 'Даша Чорнобаєва', NULL, 3, 0, 0, 2009, 93, NULL),
(108, 'Андрій Антоненко', NULL, 3, 0, 0, 2012, 95, NULL),
(109, 'Дарина Хомик', NULL, 3, 0, 0, 2012, 95, NULL),
(110, 'Ірина Лагно', NULL, 1, 0, NULL, NULL, 96, NULL),
(111, 'Юлія Кіро', NULL, 1, 0, NULL, NULL, 96, NULL),
(112, 'Юлія Проскурня', NULL, 1, 0, NULL, NULL, 96, NULL),
(113, 'Настя Барбашина', NULL, 3, 0, 0, 2012, 96, NULL),
(114, 'Леонід Вербов', 'leonid_verbov.jpg', 3, 0, 1, 2014, 97, NULL),
(115, 'Юра Шурапов', NULL, 3, 0, 1, 2014, 97, NULL),
(116, 'Міша Путілов', NULL, 3, 0, 1, 2015, 97, NULL),
(117, 'Оля Івасюк', 'ivasiuk_olha.jpg', 3, 0, 0, 2014, 98, NULL),
(118, 'Даша Панічева', NULL, 3, 0, 1, 2013, 98, NULL),
(119, 'Юля Шкаровська', NULL, 3, 0, 1, 2013, 98, NULL),
(120, 'Юля Краснянська', NULL, 3, 0, 1, 2012, 99, NULL),
(121, 'Віталій Благодір', NULL, 3, 0, 1, 2009, 100, NULL),
(122, 'Лєна Савчук', NULL, 1, 0, NULL, NULL, 100, NULL),
(123, 'Олександр Гонтар', NULL, 3, 0, 0, 2010, 100, NULL),
(124, 'Альона Шамедько', NULL, 3, 0, 1, 2009, 102, NULL),
(125, 'Леся Гнідець', 'Lesya_Hnidets.jpeg', 3, 0, 0, 2010, 102, NULL),
(126, 'Саша Томілін', 'sasha_tomilin.jpg', 3, 0, 1, 2009, 107, NULL),
(127, 'Антон Адамів', NULL, 3, 0, 0, 2014, 108, NULL),
(128, 'Оксана Семчук', NULL, 1, 0, 1, 2015, 113, NULL),
(129, 'Саша Векліч', NULL, 3, 0, 1, 2014, 113, NULL),
(130, 'Свєта Аврахова', NULL, 3, 0, 0, 2015, 113, NULL),
(131, 'Віка Туряб', 'turyab_vika.jpg', 3, 0, NULL, NULL, 113, NULL),
(132, 'Ксюша Єлєва', NULL, 1, 0, 0, 2013, 113, NULL),
(133, 'Стас Лютенко', 'stas_liutenko.jpg', 3, 0, 0, 2015, 114, NULL),
(134, 'Макс Ільїн', NULL, 2, 1, 0, 2017, 114, NULL),
(135, 'Ксюша Гаршина', 'ksenia_garshina.jpg', 2, 1, 1, 2015, 115, NULL),
(136, 'Костя Кучерявий', 'kostya_kucheriavyi.jpg', 2, 1, 0, 2017, 116, NULL),
(137, 'Юля Кобрин', 'julia_kobryn.jpg', 3, 0, 0, 2016, 117, NULL),
(138, 'Саша Голубєва', NULL, 3, 0, 1, 2015, 117, NULL),
(139, 'Саша Криушин', NULL, 1, 0, NULL, NULL, 117, NULL),
(140, 'Макс Прокопенко', 'Prakop.jpg', 3, 0, 1, 2015, 118, NULL),
(141, 'Боря Бакланов', 'boris_baklanov.jpeg', 3, 0, 0, 2015, 119, NULL),
(142, 'Адель Шахін', 'adel_shakhin.jpg', 3, 0, 0, 2015, 120, NULL),
(143, 'Іра Калінчік', NULL, 1, 0, NULL, NULL, 121, NULL),
(144, 'Іван Дунський', NULL, 1, 0, NULL, NULL, 124, NULL),
(145, 'Влада Мацкевич', NULL, 3, 0, 0, 2011, 124, NULL),
(146, 'Володимир Кролівець', NULL, 1, 0, NULL, NULL, 124, NULL),
(147, 'Тімур Пророченко', NULL, 1, 0, 0, 2011, 125, NULL),
(148, 'Макс Лаєвський', NULL, 1, 0, 0, 2011, 125, NULL),
(149, 'Саша Бурима', NULL, 3, 0, 1, 2011, 125, NULL),
(150, 'Евеліна Селебінка', NULL, 1, 0, NULL, NULL, 126, NULL),
(151, 'Стас Бондаренко', 'stas_bondarenko.jpg', 1, 0, 0, 2016, 130, NULL),
(152, 'Юля Ступак', 'julia_stupak.jpg', 3, 0, 0, 2017, 131, NULL),
(153, 'Інга Візниця', NULL, 3, 0, 1, 2014, 131, NULL),
(154, 'Андрій Руденко', NULL, 1, 0, 1, 2015, 131, NULL),
(155, 'Віта Прищепа', 'vita_pryshchepa.jpg', 2, 1, 1, 2016, 132, 2),
(156, 'Сергій Ніношвілі', 'sehiy_nino.jpg', 2, 1, 1, 2017, 133, NULL),
(157, 'Влад Бондаренко', 'vlad_bondarenko.jpg', 1, 0, NULL, NULL, 133, NULL),
(158, 'Юля Кременецька', 'yulka_krem.jpeg', 1, 1, 1, 2019, 134, NULL),
(159, 'Аня Чорногор', 'anya_chornohor.jpg', 1, 1, 1, 2018, 135, NULL),
(160, 'Оля Сиротюк', NULL, 1, 0, 1, 2018, 135, NULL),
(161, 'Таня Величко', 'tania_velychko.jpg', 1, 1, 0, 2019, 136, NULL),
(162, 'Артем Литовченко', 'artem_lytva.jpg', 1, 1, 0, 2019, 136, NULL),
(163, 'Діма Андрієвський', NULL, 1, 1, 1, 2018, 136, NULL),
(164, 'Каріна Жуковська', 'karina_zhukovska.jpg', 2, 1, 1, 2018, 136, NULL),
(165, 'Таня Власенко', 'tanya_vlasenko.jpeg', 1, 0, 1, 2019, 136, NULL),
(166, 'Максим Височін', 'max_vysochin.jpg', 1, 1, 1, 2019, 136, NULL),
(167, 'Юля Бодавець', 'julia_bodavets.jpg', 2, 1, 0, 2017, 140, NULL),
(168, 'Яна Стрижак', 'yana_strizhak.jpg', 1, 1, 0, 2017, 140, NULL),
(169, 'Настя Лагно', 'nastia_lagno.png', 2, 1, 1, 2018, 140, NULL),
(170, 'Катя Нікітіна', NULL, 0, 0, NULL, NULL, 140, NULL),
(171, 'Катя Ващенко', 'katya_vashchenko.jpg', 2, 1, NULL, NULL, 140, NULL),
(172, 'Валерія Кучеренко', NULL, 1, 0, NULL, NULL, 140, NULL),
(173, 'Вітя Яцкін', 'vitya_yatskin.jpg', 3, 0, 0, 2016, 141, NULL),
(174, 'Лєна Шахін', NULL, 1, 0, NULL, NULL, 142, NULL),
(175, 'Олександр Альохін', NULL, 3, 0, 0, 2011, 145, NULL),
(176, 'Катя Мячина', NULL, 3, 0, 1, 2013, 149, NULL),
(177, 'Лєра Шукатка', 'lera_shukatka.jpg', 3, 0, 0, 2013, 149, NULL),
(178, 'Аня Соловйова', NULL, 1, 0, NULL, NULL, 152, NULL),
(179, 'Ліза Гончар', NULL, 1, 0, 1, 2018, 152, NULL),
(180, 'Таня Нагорняк', 'tania_nahorniak.jpg', 2, 1, 1, 2015, 153, NULL),
(181, 'Юля Ковальчук', 'julia_lovalchuk.jpg', 1, 1, 0, 2018, 155, 2),
(182, 'Влада Жмуркевич', NULL, 1, 1, 0, 2018, 155, 2),
(183, 'Єгор Мирошниченко', 'yehor_myroshmychenko.jpg', 2, 1, 0, 2019, 155, 2),
(184, 'Оля Смирнова', 'olya_smirnova.jpeg', 2, 1, 1, 2018, 155, 2),
(185, 'Марина Піталова', 'marina_pitalova.jpg', 1, 1, 0, 2019, 155, 2),
(186, 'Катя Стефанович', 'katya_stef.jpg', 2, 1, 1, 2017, 155, 2),
(187, 'Міша Швець', 'misha_shvets.jpg', 2, 1, 1, 2017, 155, 2),
(188, 'Яся Бондарчук', 'yasya_bondarchuk.jpg', 1, 1, 1, 2019, 155, 2),
(189, 'Іван Гритчук', 'ivan_hrytchuk.jpg', 1, 1, 0, 2019, 156, NULL),
(190, 'Саша Числов', 'sasha_chyslov.jpg', 1, 1, 1, 2018, 156, NULL),
(191, 'Микола Мельник', NULL, 1, 0, 1, 2018, 156, NULL),
(192, 'Інга Манжуленко', NULL, 1, 1, 0, 2019, 156, NULL),
(193, 'Тетяна Онищук', NULL, 1, 0, 1, 2019, 164, NULL),
(194, 'Омар Массауді', 'omar_massaudi.jpg', 1, 1, 1, 2019, 164, NULL),
(195, 'Андрій Власов', 'andrey_vlasov.jpg', 1, 1, 1, 2019, 164, NULL),
(196, 'Сергій Мілантьєв', 'serhiy_milantiev.jpeg', 1, 1, 1, 2019, 167, NULL),
(197, 'Дмитро Бурденко', 'Dmytro_Burdenko.jpeg', 1, 1, 1, 2019, 167, NULL),
(198, 'Маша Ковальчук', 'masha_kovalchuk.jpeg', 1, 0, 0, 2019, 171, NULL),
(199, 'Марина Коваленко', NULL, 3, 0, 1, 2016, 173, NULL),
(200, 'Антон Бауман', NULL, 1, 0, 1, 2016, 173, NULL),
(201, 'Аліса Піцик', NULL, 3, 0, 1, 2016, 173, NULL),
(202, 'Арсен Куник', 'arsen_kunyk.jpg', 2, 1, 1, 2017, 173, NULL),
(203, 'Рома Бородатов', 'roma_borodatov.jpg', 3, 0, 0, 2017, 173, NULL),
(204, 'Нікіта Комолов', 'komolov_mykyta.jpg', 3, 0, 1, 2015, 176, NULL),
(205, 'Поліна Ворошилова', NULL, 3, 0, 1, 2015, 177, NULL),
(206, 'Дарина Гавриш', NULL, 1, 0, 0, 2015, 177, NULL),
(207, 'Саша Рижик', NULL, 1, 0, 0, 2017, 177, NULL),
(208, 'Юля', NULL, 1, 0, NULL, NULL, 177, NULL),
(209, 'Оля Сирота', 'olya_syrota.jpg', 1, 1, 0, 2018, 180, NULL),
(210, 'Лєра Кугук', NULL, 1, 0, NULL, NULL, 180, NULL),
(211, 'Віка Макарова', 'vika_makarova.jpeg', 1, 1, 0, 2018, 180, NULL),
(212, 'Вероніка Єремєєва', 'nika_yeremeyeva.png', 2, 1, 1, 2018, 186, 2),
(213, 'Денис Гритчук', 'denys_hrytchuk.jpg', 2, 1, 1, 2018, 186, 2),
(214, 'Андрій Голіней', NULL, 1, 0, 1, 2018, 187, 2),
(215, 'Єгор Нестеренко', 'yehor_nesterenko.jpeg', 2, 1, 1, 2018, 187, 2),
(216, 'Марина Музя', 'marina_muzya.jpg', 1, 1, 0, 2019, 187, 2),
(217, 'Денис Юрченко', NULL, 1, 1, 1, 2019, 187, 2),
(218, 'Олексій Котвицький', NULL, 1, 0, 1, 2018, 199, NULL),
(219, 'Ілля Юшенко', 'illiya_yushenko.jpg', 1, 1, 0, 2019, 202, NULL),
(220, 'Іра Абрамович', 'ira_abramovych.png', 2, 1, 1, 2017, 203, NULL),
(221, 'Саша Подолян', 'podolyan.jpg', 2, 1, 0, 2018, 203, NULL),
(222, 'Артем Ніколаєв', 'artem_nikolaiev.jpg', 1, 1, 0, 2018, 203, NULL),
(223, 'Даша Ханюченко', NULL, 1, 0, 0, 2019, 203, NULL),
(224, 'Даня Буханько', 'dania_bukhanko.jpg', 2, 1, 0, 2017, 203, NULL),
(225, 'Юра Блінов', 'yura_blinov.jpg', 3, 0, 1, 2016, 204, NULL),
(226, 'Діма Уруков', 'dima_urukov.jpg', 3, 1, 0, 2017, 204, NULL),
(227, 'Єлизавета Кияткіна', NULL, 0, 0, 1, 2019, 212, NULL),
(228, 'Назар Яскал', NULL, 1, 1, 1, 2019, 212, NULL),
(229, 'Женя Іващенко', 'zhenya_ivashchenko.jpg', 1, 1, 1, 2019, 213, NULL),
(230, 'Софія Шумель', 'sonya_shumel.jpg', 1, 1, 1, 2019, 213, NULL),
(231, 'Микита Морозов', 'mykyta_morozov.jpg', 0, 1, 1, 2019, 213, NULL),
(232, 'Ліза Кущенко', 'kushchenko_liza.jpg', 1, 0, 1, 2019, 215, 2),
(233, 'Катя Грініх', 'kate_grinih.jpeg', 1, 1, 1, 2019, 221, NULL),
(234, 'Аладдін Сулейманов', 'Aladdin_Suleimanov.jpg', 1, 1, 1, 2019, 221, NULL),
(235, 'Демід Попенко', 'demyd_popenko.jpg', 1, 1, 1, 2018, 224, NULL),
(236, 'Настя П\'яткова', 'Nastia_Piatkova.jpg', 1, 1, 1, 2018, 224, NULL),
(237, 'Ліза Копернак', NULL, 1, 0, NULL, NULL, 224, NULL),
(238, 'Настя Бутенко', 'nastia_butenko.jpg', 2, 1, 1, 2017, 225, NULL),
(239, 'Настя Кондаурова', NULL, 1, 0, 1, 2017, 225, NULL),
(240, 'Андрій Юдов', 'yudov_andriy.jpg', 1, 0, 0, 2018, 225, NULL),
(241, 'Ліка Князева', 'knyazeva_lika.jpg', 3, 0, 0, 2018, 225, NULL),
(242, 'Вадік Отрішко', 'vadik_otrishko.jpg', 2, 1, 1, 2018, 225, NULL),
(243, 'Артур Козловський', 'archi_kozlovski.jpeg', 1, 1, 1, 2018, 225, NULL),
(244, 'Марія Гребінченко', NULL, 1, 1, 1, 2018, 226, NULL),
(245, 'Міша Барвінко', NULL, 1, 0, 0, 2019, 238, NULL),
(246, 'Даша Ковальчук', 'dasha_kovalchuk.jpg', 1, 1, 0, 2019, 238, NULL),
(247, 'Марк Герасименко', 'mark_herasymenko.jpg', 1, 1, 1, 2019, 242, NULL),
(248, 'Ліза Нечай', 'liza_nechay.jpeg', 1, 1, 1, 2019, 242, NULL),
(254, 'Каріна Азарян', 'karina_azarian.jpg', 3, 0, 1, 2012, 10, NULL),
(250, 'Катя Шубіна', 'katya_shubina.jpg', 3, 0, 0, 2012, 17, NULL),
(251, 'Діма Федоров', NULL, 3, 0, 0, 2012, 85, NULL),
(252, 'Поліна Якименко', 'Polina_Yakymenko.jpg', 3, 0, 0, 2012, 85, NULL),
(253, 'Марина Шалько', NULL, 3, 0, 1, 2012, 36, NULL),
(255, 'Ліза Ручко', NULL, 3, 0, 1, 2008, 83, NULL),
(256, 'Саша Чумак', NULL, 3, 0, 1, 2008, 83, NULL),
(257, 'Івашкіна Олена', NULL, 3, 0, 0, 2002, 100, NULL),
(259, 'Маша Шкулепова', 'masha_shkulepova.jpg', 1, 1, 1, 2019, 69, NULL);


-- AUTO_INCREMENT для таблиці `family`
--
ALTER TABLE `family`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблиці `member`
--
ALTER TABLE `member`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=260;
COMMIT;

ALTER TABLE `member`
  ADD CONSTRAINT `children_mentor_foreign` FOREIGN KEY (`mentor_id`) REFERENCES `member` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `member_family_foreign` FOREIGN KEY (`family_id`) REFERENCES `family` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
