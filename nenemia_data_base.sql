-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 09-12-2025 a las 15:39:08
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `nenemia_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `destinos`
--

CREATE TABLE `destinos` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `ubicacion` varchar(255) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `destinos`
--

INSERT INTO `destinos` (`id`, `nombre`, `slug`, `descripcion`, `ubicacion`, `activo`, `fecha_creacion`) VALUES
(1, 'Nanacamilpa', 'nanacamilpa', 'Tierra de luz - Santuario de las Luciérnagas', 'Tlaxcala', 1, '2025-12-05 02:06:55'),
(2, 'Tecoaque', 'tecoaque', 'Zona Arqueológica histórica', 'Tlaxcala', 1, '2025-12-05 02:06:55'),
(3, 'Val\'Quirico', 'valquirico', 'Destino turístico de estilo europeo', 'Tlaxcala', 1, '2025-12-05 02:06:55'),
(4, 'Xochitécatl', 'xochitecatl', 'Zona Arqueológica con vistas panorámicas', 'Tlaxcala', 1, '2025-12-05 02:06:55'),
(5, 'Tlaxco', 'tlaxco', 'Pueblo Mágico de bosques', 'Tlaxcala', 1, '2025-12-05 02:06:55'),
(6, 'Barca de la Fe', 'barca-de-la-fe', 'Iglesia en forma de barco', 'Tlaxcala', 1, '2025-12-05 02:06:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mensajes_soporte`
--

CREATE TABLE `mensajes_soporte` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `asunto` varchar(100) NOT NULL,
  `mensaje` text NOT NULL,
  `fecha_envio` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('nuevo','en_proceso','resuelto') DEFAULT 'nuevo'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` int(11) NOT NULL,
  `reserva_id` int(11) NOT NULL,
  `monto` decimal(10,2) NOT NULL,
  `tipo_pago` enum('anticipo','saldo','total') NOT NULL,
  `metodo_pago` varchar(50) NOT NULL,
  `estado` enum('pendiente','procesando','completado','rechazado','reembolsado') DEFAULT 'pendiente',
  `referencia` varchar(255) DEFAULT NULL,
  `fecha_pago` timestamp NULL DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `paquetes`
--

CREATE TABLE `paquetes` (
  `id` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `duracion_dias` int(11) NOT NULL,
  `personas_incluidas` int(11) DEFAULT 1,
  `activo` tinyint(1) DEFAULT 1,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `paquetes`
--

INSERT INTO `paquetes` (`id`, `nombre`, `slug`, `descripcion`, `precio`, `duracion_dias`, `personas_incluidas`, `activo`, `fecha_creacion`) VALUES
(1, 'Explorador', 'explorador', 'Perfecto para comenzar tu aventura', 3500.00, 3, 1, 1, '2025-12-05 02:06:55'),
(2, 'Aventurero', 'aventurero', 'El más popular - Experiencia completa', 6800.00, 5, 1, 1, '2025-12-05 02:06:55'),
(3, 'Experiencia Total', 'experiencia-total', 'La experiencia más completa', 12500.00, 7, 1, 1, '2025-12-05 02:06:55'),
(4, 'Familiar', 'familiar', 'Diversión para toda la familia', 18000.00, 5, 4, 1, '2025-12-05 02:06:55'),
(5, 'Inmersión Cultural', 'inmersion-cultural', 'Vive la tradición mexicana', 8900.00, 6, 1, 1, '2025-12-05 02:06:55'),
(6, 'Escapada Express', 'escapada-express', 'Fin de semana perfecto', 2200.00, 2, 1, 1, '2025-12-05 02:06:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `reservas`
--

CREATE TABLE `reservas` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `nombre_completo` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `ciudad_origen` varchar(255) NOT NULL,
  `paquete` varchar(100) NOT NULL,
  `destino` varchar(100) NOT NULL,
  `fecha_inicio` date NOT NULL,
  `num_personas` int(11) NOT NULL,
  `tipo_habitacion` varchar(50) NOT NULL,
  `preferencia_alimentacion` varchar(50) DEFAULT NULL,
  `actividades_interes` varchar(100) DEFAULT NULL,
  `necesita_transporte` varchar(20) DEFAULT NULL,
  `solicitudes_especiales` text DEFAULT NULL,
  `metodo_pago` varchar(50) NOT NULL,
  `estado_reserva` enum('pendiente','confirmada','cancelada','completada') DEFAULT 'pendiente',
  `fecha_reserva` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_modificacion` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte_respuestas`
--

CREATE TABLE `soporte_respuestas` (
  `id` int(11) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `es_staff` tinyint(1) DEFAULT 0,
  `mensaje` text NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `soporte_tickets`
--

CREATE TABLE `soporte_tickets` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `asunto` varchar(255) NOT NULL,
  `mensaje` text NOT NULL,
  `estado` enum('abierto','en_proceso','resuelto','cerrado') DEFAULT 'abierto',
  `prioridad` enum('baja','media','alta','urgente') DEFAULT 'media',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `fecha_actualizacion` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `fecha_resolucion` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `telefono` varchar(20) NOT NULL,
  `contrasena` varchar(255) NOT NULL,
  `fecha_registro` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `email`, `telefono`, `contrasena`, `fecha_registro`) VALUES
(4, 'prueba2@nenemia.com', '7771234568', '$2y$10$UD4ytbwWmvX1o3V.OXo7Y.jJzm0P2kizMAtrMPMo9sEyz1KaBajwe', '2025-11-25 00:58:28'),
(7, 'prueba@nenemia.com', '7771234567', '$2y$10$E3PZQNH8yeY2Env//rioe.AFiV79N0A2mq91so4qNizfsEXhW5R8i', '2025-11-25 17:48:05'),
(8, 'pruebaa@nenemia.com', '7771234567', '$2y$10$yJ2l5Fv03EJPLormtM5b/.qHCDCIaUJWBPG.S840Mq2Pn0yLUnH0.', '2025-11-25 17:49:00'),
(9, 'test@nenemia.com', '7771234569 ', '$2y$10$n.ida506Wm.JDfU6vNKBwORg8.f88jMWTHN.PBsSkRIUjPNX0QHLG', '2025-11-26 15:09:18'),
(10, 'reberuqu98@gmail.com', '2217930283', '$2y$10$D4G0O065XXc.p6faII/QTeZQbSdHTpePuXnmzxupbiOLPILdcA.w.', '2025-11-30 18:59:28'),
(12, 'vaca123@gmail.com', '646642254', '$2y$10$UzQujRhCWkcrcY73iU5FgemrK0HILMR6G1FKvwijABsQe6IZwFIy.', '2025-12-06 20:01:46');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `destinos`
--
ALTER TABLE `destinos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_activo` (`activo`);

--
-- Indices de la tabla `mensajes_soporte`
--
ALTER TABLE `mensajes_soporte`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_fecha` (`fecha_envio`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_reserva` (`reserva_id`),
  ADD KEY `idx_estado` (`estado`);

--
-- Indices de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `idx_slug` (`slug`),
  ADD KEY `idx_activo` (`activo`);

--
-- Indices de la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_fecha_inicio` (`fecha_inicio`),
  ADD KEY `idx_estado` (`estado_reserva`);

--
-- Indices de la tabla `soporte_respuestas`
--
ALTER TABLE `soporte_respuestas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `idx_ticket` (`ticket_id`),
  ADD KEY `idx_fecha` (`fecha_creacion`);

--
-- Indices de la tabla `soporte_tickets`
--
ALTER TABLE `soporte_tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_usuario` (`usuario_id`),
  ADD KEY `idx_email` (`email`),
  ADD KEY `idx_estado` (`estado`),
  ADD KEY `idx_prioridad` (`prioridad`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `destinos`
--
ALTER TABLE `destinos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de la tabla `mensajes_soporte`
--
ALTER TABLE `mensajes_soporte`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `paquetes`
--
ALTER TABLE `paquetes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `reservas`
--
ALTER TABLE `reservas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `soporte_respuestas`
--
ALTER TABLE `soporte_respuestas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `soporte_tickets`
--
ALTER TABLE `soporte_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`reserva_id`) REFERENCES `reservas` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `reservas`
--
ALTER TABLE `reservas`
  ADD CONSTRAINT `reservas_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE;

--
-- Filtros para la tabla `soporte_respuestas`
--
ALTER TABLE `soporte_respuestas`
  ADD CONSTRAINT `soporte_respuestas_ibfk_1` FOREIGN KEY (`ticket_id`) REFERENCES `soporte_tickets` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `soporte_respuestas_ibfk_2` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;

--
-- Filtros para la tabla `soporte_tickets`
--
ALTER TABLE `soporte_tickets`
  ADD CONSTRAINT `soporte_tickets_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
