SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `spain_geo`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `region`
--

CREATE TABLE `region` (
  `region_id` int(2) NOT NULL,
  `name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `region`
--

INSERT INTO `region` (`region_id`, `name`) VALUES
(1, 'Galicia'),
(2, 'Asturias'),
(3, 'Cantabria'),
(4, 'País Vasco'),
(5, 'Navarra'),
(6, 'La Rioja'),
(7, 'Aragón'),
(8, 'Cataluña'),
(9, 'Castilla León'),
(10, 'Castilla la Mancha'),
(11, 'Comunidad de Madrid'),
(12, 'Comunidad Valenciana'),
(13, 'Murcia'),
(14, 'Extremadura'),
(15, 'Andalucía'),
(16, 'Baleares'),
(17, 'Canarias');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mountain`
--

CREATE TABLE `mountain` (
  `mountain_id` int(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `height` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mountain`
--

INSERT INTO `mountain` (`mountain_id`, `name`, `height`) VALUES
(1, 'Pirineos', 3404),
(2, 'Sistema Penibético', 3479),
(3, 'Cordilleras béticas', 3482),
(4, 'Cordilleras cantábricas', 2519),
(5, 'Meseta Central', 600),
(6, 'Sierra Morena', 1322),
(7, 'Sistema Central', 2592),
(8, 'Sistema Ibérico', 2314);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `province`
--

CREATE TABLE `province` (
  `province_id` int(5) NOT NULL,
  `name` varchar(30) NOT NULL,
  `capital` varchar(30) NOT NULL,
  `population` int(9) NOT NULL,
  `surface` int(9) NOT NULL,
  `coast` tinyint(1) NOT NULL,
  `region_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `province`
--

INSERT INTO `province` (`province_id`, `name`, `capital`, `population`, `surface`, `coast`, `region_id`) VALUES
(1, 'Huelva', 'Huelva', 519932, 10128, 1, 15),
(2, 'Sevilla', 'Sevilla', 1940000, 14036, 0, 15),
(3, 'Córdoba', 'Córdoba', 785240, 13771, 0, 15),
(4, 'Jaén', 'Jaén', 638099, 13484, 0, 15),
(5, 'Cádiz', 'Cádiz', 1239000, 7436, 1, 15),
(6, 'Granada', 'Granada', 912075, 12531, 1, 15),
(7, 'Almería', 'Almería', 709340, 8774, 1, 15),
(8, 'Soria', 'Soria', 89752, 10306, 0, 9),
(9, 'Málaga', 'Málaga', 1641000, 7308, 1, 15),
(10, 'Badajoz', 'Badajoz', 676376, 21766, 0, 14),
(11, 'Cáceres', 'Cáceres', 396487, 19868, 0, 14),
(13, 'Alicante', 'Alicante', 331577, 20127, 1, 12),
(16, 'Valencia', 'Valencia', 2547986, 10763, 1, 12),
(17, 'Castellón', 'Castellón de la Plana', 576898, 6611, 1, 12),
(18, 'Tarragona', 'Tarragona', 792256, 6303, 1, 8),
(19, 'Barcelona', 'Barcelona', 5663284, 7726, 1, 8),
(20, 'Gerona', 'Gerona', 755716, 5910, 1, 8),
(21, 'Lerida', 'Lerida', 428418, 12172, 0, 8),
(22, 'Santa Cruz de Tenerife', 'Santa Cruz de Tenerife', 1018510, 3381, 1, 17),
(23, 'Las Palmas', ' Las Palmas de Gran Canaria', 1109175, 4066, 1, 17),
(24, 'Teruel', 'Teruel', 133344, 14804, 0, 7),
(25, 'Zaragoza', 'Zaragoza', 968149, 17274, 0, 7),
(26, 'Huesca', 'Huesca', 219301, 15626, 0, 7),
(27, 'Albacete', 'Albacete', 390032, 14926, 0, 10),
(28, 'Cuenca', 'Cuenca', 198718, 17141, 0, 10),
(29, 'Ciudad Real', 'Ciudad Real', 499100, 19813, 0, 10),
(30, 'Toledo', 'Toledo', 687391, 15369, 0, 10),
(31, 'Guadalajara', 'Guadalajara', 254308, 12167, 0, 10),
(33, 'Murcia', 'Murcia', 1478509, 11313, 1, 13),
(34, 'Madrid', 'Madrid', 6661949, 8021, 0, 11),
(35, 'La Rioja', 'Logroño', 315675, 5045, 0, 6),
(36, 'Navarra', 'Pamplona', 647554, 10391, 0, 5),
(37, 'Cantabria', 'Santander', 580229, 5321, 1, 3),
(38, 'Asturias', 'Oviedo', 1028244, 10603, 1, 2),
(39, 'Baleares', 'Palma de Mallorca', 1150839, 4992, 1, 16),
(40, 'Vizcaya', 'Bilbao', 1149628, 2217, 1, 4),
(41, 'Álava', 'Vitoria', 328868, 3037, 0, 4),
(42, 'Guipuzcua', 'San Sebastian', 719282, 1997, 1, 4),
(43, 'Orense', 'Orense', 309372, 7273, 0, 1),
(44, 'Pontevedra', 'Pontevedra', 940927, 4495, 1, 1),
(45, 'Lugo', 'Lugo', 331507, 9856, 1, 1),
(46, 'La Coruña', 'La Coruña', 1121484, 7950, 1, 1),
(47, 'Avila', 'Avila', 158265, 8050, 0, 9),
(48, 'Segovia', 'Segovia', 154041, 6920, 0, 9),
(49, 'Salamanca', 'Salamanca', 333603, 12349, 0, 9),
(50, 'Valladolid', 'Valladolid', 520801, 8111, 0, 9),
(51, 'Zamora', 'Zamora', 174544, 10561, 0, 9),
(52, 'Leon', 'Leon', 466030, 15581, 0, 9),
(53, 'Palencia', 'Palencia', 161821, 8052, 0, 9),
(54, 'Burgos', 'Burgos', 356119, 14022, 0, 9);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pro_mou`
--

CREATE TABLE `pro_mou` (
  `province_id` int(2) NOT NULL,
  `mountain_id` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pro_mou`
--

INSERT INTO `pro_mou` (`province_id`, `mountain_id`) VALUES
(3, 6),
(4, 3),
(5, 2),
(6, 2),
(6, 3),
(7, 2),
(8, 5),
(8, 7),
(8, 8),
(9, 2),
(9, 3),
(10, 6),
(17, 8),
(20, 1),
(21, 1),
(24, 8),
(25, 8),
(26, 1),
(27, 3),
(27, 6),
(28, 5),
(29, 6),
(30, 5),
(31, 5),
(33, 3),
(34, 5),
(35, 8),
(36, 1),
(37, 4),
(41, 4),
(42, 1),
(47, 5),
(47, 7),
(48, 7),
(49, 5),
(50, 5),
(51, 5),
(52, 4),
(53, 4),
(54, 5),
(54, 8);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pro_riv`
--

CREATE TABLE `pro_riv` (
  `province_id` int(2) NOT NULL,
  `river_id` int(2) NOT NULL,
  `river_order` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `pro_riv`
--

INSERT INTO `pro_riv` (`province_id`, `river_id`, `river_order`) VALUES
(1, 1, 4),
(1, 12, 4),
(2, 1, 3),
(3, 1, 2),
(4, 1, 1),
(5, 1, 4),
(8, 5, 1),
(10, 12, 3),
(11, 7, 6),
(18, 2, 8),
(24, 7, 1),
(25, 2, 7),
(27, 12, 1),
(28, 7, 3),
(29, 12, 2),
(30, 7, 5),
(31, 7, 2),
(34, 7, 4),
(35, 2, 4),
(36, 2, 6),
(37, 2, 1),
(41, 2, 5),
(43, 10, 2),
(44, 10, 3),
(45, 10, 1),
(49, 5, 5),
(50, 5, 3),
(51, 5, 4),
(53, 2, 2),
(54, 2, 3),
(54, 5, 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `river`
--

CREATE TABLE `river` (
  `river_id` int(2) NOT NULL,
  `name` varchar(30) NOT NULL,
  `length` int(4) NOT NULL,
  `sea` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `river`
--

INSERT INTO `river` (`river_id`, `name`, `length`, `sea`) VALUES
(1, 'Guadalquivir', 657, 'Atlántico'),
(2, 'Ebro', 930, 'Mar Mediterráneo'),
(5, 'Duero', 897, 'Atlático'),
(7, 'Tajo', 1007, 'Atlático'),
(10, 'Miño', 350, 'Atlántico'),
(12, 'Guadiana ', 742, 'Atlántico');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `region`
--
ALTER TABLE `region`
  ADD PRIMARY KEY (`region_id`);

--
-- Indices de la tabla `mountain`
--
ALTER TABLE `mountain`
  ADD PRIMARY KEY (`mountain_id`);

--
-- Indices de la tabla `province`
--
ALTER TABLE `province`
  ADD PRIMARY KEY (`province_id`),
  ADD KEY `region_id` (`region_id`);

--
-- Indices de la tabla `pro_mou`
--
ALTER TABLE `pro_mou`
  ADD PRIMARY KEY (`province_id`,`mountain_id`),
  ADD KEY `province_id` (`province_id`),
  ADD KEY `mountain_id` (`mountain_id`);

--
-- Indices de la tabla `pro_riv`
--
ALTER TABLE `pro_riv`
  ADD PRIMARY KEY (`province_id`,`river_id`),
  ADD KEY `province_id` (`province_id`),
  ADD KEY `river_id` (`river_id`);

--
-- Indices de la tabla `river`
--
ALTER TABLE `river`
  ADD PRIMARY KEY (`river_id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `region`
--
ALTER TABLE `region`
  MODIFY `region_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de la tabla `mountain`
--
ALTER TABLE `mountain`
  MODIFY `mountain_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `province`
--
ALTER TABLE `province`
  MODIFY `province_id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT de la tabla `river`
--
ALTER TABLE `river`
  MODIFY `river_id` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `province`
--
ALTER TABLE `province`
  ADD CONSTRAINT `province_ibfk_1` FOREIGN KEY (`region_id`) REFERENCES `region` (`region_id`);

--
-- Filtros para la tabla `pro_mou`
--
ALTER TABLE `pro_mou`
  ADD CONSTRAINT `pro_mou_ibfk_2` FOREIGN KEY (`mountain_id`) REFERENCES `mountain` (`mountain_id`),
  ADD CONSTRAINT `pro_mou_ibfk_3` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`);

--
-- Filtros para la tabla `pro_riv`
--
ALTER TABLE `pro_riv`
  ADD CONSTRAINT `pro_riv_ibfk_1` FOREIGN KEY (`province_id`) REFERENCES `province` (`province_id`),
  ADD CONSTRAINT `pro_riv_ibfk_2` FOREIGN KEY (`river_id`) REFERENCES `river` (`river_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
