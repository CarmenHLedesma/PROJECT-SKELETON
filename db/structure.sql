-- MySQL dump 10.13  Distrib 5.6.27, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: DMSIG
-- ------------------------------------------------------
-- Server version	5.6.27-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `accesibilidades`
--

DROP TABLE IF EXISTS `accesibilidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accesibilidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `dashboard` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `administracion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empleados` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `imputaciones` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `accesibilidades_user_id_fk` (`user_id`),
  CONSTRAINT `accesibilidades_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `calendarios`
--

DROP TABLE IF EXISTS `calendarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `calendarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `caduca_el` datetime NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_calendarios_on_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `centros_responsabilidades`
--

DROP TABLE IF EXISTS `centros_responsabilidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centros_responsabilidades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `caduca_el` datetime NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `sociedad_id` int(11) NOT NULL,
  `responsable_id` int(11) NOT NULL,
  `tipo_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_centros_responsabilidades_on_codigo` (`codigo`),
  KEY `index_centros_responsabilidades_on_sociedad_id` (`sociedad_id`),
  KEY `centros_responsabilidades_responsable_id_fk` (`responsable_id`),
  CONSTRAINT `centros_responsabilidades_responsable_id_fk` FOREIGN KEY (`responsable_id`) REFERENCES `users` (`id`),
  CONSTRAINT `centros_responsabilidades_sociedad_id_fk` FOREIGN KEY (`sociedad_id`) REFERENCES `sociedades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `centros_responsabilidades_empleados`
--

DROP TABLE IF EXISTS `centros_responsabilidades_empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `centros_responsabilidades_empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empleado_id` int(11) NOT NULL,
  `centro_responsabilidad_id` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empleado_id_fk` (`empleado_id`),
  KEY `centro_resp_id_fk` (`centro_responsabilidad_id`),
  CONSTRAINT `centro_resp_id_fk` FOREIGN KEY (`centro_responsabilidad_id`) REFERENCES `centros_responsabilidades` (`id`),
  CONSTRAINT `empleado_id_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `clientes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cif` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `persona_contacto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono_contacto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email_contacto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_clientes_on_codigo` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `departamentos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `caduca_el` datetime NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `centro_responsabilidad_id` int(11) NOT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `descripcion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `responsable_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_departamentos_on_codigo` (`codigo`),
  KEY `index_departamentos_on_centro_responsabilidad_id` (`centro_responsabilidad_id`),
  KEY `departamentos_responsable_id_fk` (`responsable_id`),
  CONSTRAINT `departamentos_centro_responsabilidad_id_fk` FOREIGN KEY (`centro_responsabilidad_id`) REFERENCES `centros_responsabilidades` (`id`),
  CONSTRAINT `departamentos_responsable_id_fk` FOREIGN KEY (`responsable_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `destinos`
--

DROP TABLE IF EXISTS `destinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destinos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `responsable_id` int(11) NOT NULL,
  `caduca_el` date DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `tipo_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `color` varchar(255) COLLATE utf8_unicode_ci DEFAULT '#0000ff',
  `users_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `destinos_responsable_id_fk` (`responsable_id`),
  CONSTRAINT `destinos_responsable_id_fk` FOREIGN KEY (`responsable_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `destinos_imputaciones_actividades_dias`
--

DROP TABLE IF EXISTS `destinos_imputaciones_actividades_dias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `destinos_imputaciones_actividades_dias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imputacion_actividad_id` int(11) NOT NULL,
  `destino_id` int(11) NOT NULL,
  `dia` date DEFAULT NULL,
  `minutos` int(11) DEFAULT '0',
  `estado` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `destinos_imputaciones_actividades_dias_destino_id_fk` (`destino_id`),
  KEY `dia_imputacion_actividad_fk` (`imputacion_actividad_id`),
  CONSTRAINT `destinos_imputaciones_actividades_dias_destino_id_fk` FOREIGN KEY (`destino_id`) REFERENCES `destinos` (`id`),
  CONSTRAINT `dia_imputacion_actividad_fk` FOREIGN KEY (`imputacion_actividad_id`) REFERENCES `imputaciones_actividades` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `emails`
--

DROP TABLE IF EXISTS `emails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `emails` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `from` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `to` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `attachment` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados`
--

DROP TABLE IF EXISTS `empleados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `apellidos` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo_empleado` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nif` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `nacimiento_el` datetime NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telefono1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telefono2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `tipo_contrato_id` int(11) DEFAULT NULL,
  `salario_bruto_anual` float NOT NULL,
  `alta_el` datetime NOT NULL,
  `baja_el` date DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `perfil_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_empleados_on_codigo_empleado` (`codigo_empleado`),
  KEY `index_empleados_on_user_id` (`user_id`),
  CONSTRAINT `empleados_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados_destinos`
--

DROP TABLE IF EXISTS `empleados_destinos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados_destinos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empleado_id` int(11) NOT NULL,
  `destino_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_empleados_destinos_on_empleado_id_and_destino_id` (`empleado_id`,`destino_id`),
  KEY `empleados_destinos_destino_id_fk` (`destino_id`),
  CONSTRAINT `empleados_destinos_destino_id_fk` FOREIGN KEY (`destino_id`) REFERENCES `destinos` (`id`),
  CONSTRAINT `empleados_destinos_empleado_id_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados_proyectos`
--

DROP TABLE IF EXISTS `empleados_proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados_proyectos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `empleado_id` int(11) NOT NULL,
  `proyecto_id` int(11) NOT NULL,
  `horario_id` int(11) NOT NULL,
  `tarifa` float NOT NULL,
  `tipo_tarifa_id` int(11) NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `empleados_proyectos_empleado_id_fk` (`empleado_id`),
  KEY `empleados_proyectos_proyecto_id_fk` (`proyecto_id`),
  KEY `empleados_proyectos_horario_id_fk` (`horario_id`),
  CONSTRAINT `empleados_proyectos_empleado_id_fk` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`),
  CONSTRAINT `empleados_proyectos_horario_id_fk` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`),
  CONSTRAINT `empleados_proyectos_proyecto_id_fk` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `empleados_temporales`
--

DROP TABLE IF EXISTS `empleados_temporales`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `empleados_temporales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo_empresa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empresa` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_centro_cotizacion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_empleado` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dni` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_alta` date DEFAULT NULL,
  `fecha_baja` date DEFAULT NULL,
  `excluir_proceso` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `datos_incompletos` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sigla_nacion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `centro_contizacion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apellido1` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `apellido2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `profesional` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_antiwedad` date DEFAULT NULL,
  `por_jornada` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_contrato` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sub_codigo_contrato` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_canal` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_departamento` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_seccion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_delegacion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_proyecto` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `codigo_centro_trabajo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `fecha_inicio_calculo_antiwedad` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `festivos`
--

DROP TABLE IF EXISTS `festivos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `festivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fecha` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `calendario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_festivos_on_calendario_id` (`calendario_id`),
  CONSTRAINT `festivos_calendario_id_fk` FOREIGN KEY (`calendario_id`) REFERENCES `calendarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `horarios`
--

DROP TABLE IF EXISTS `horarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `horarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `lunes` datetime NOT NULL,
  `martes` datetime NOT NULL,
  `miercoles` datetime NOT NULL,
  `jueves` datetime NOT NULL,
  `viernes` datetime NOT NULL,
  `sabado` datetime NOT NULL,
  `domingo` datetime NOT NULL,
  `caduca_el` datetime NOT NULL,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `calendario_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_horarios_on_codigo` (`codigo`),
  KEY `index_horarios_on_calendario_id` (`calendario_id`),
  CONSTRAINT `horarios_calendario_id_fk` FOREIGN KEY (`calendario_id`) REFERENCES `calendarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `imputaciones_actividades`
--

DROP TABLE IF EXISTS `imputaciones_actividades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `imputaciones_actividades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mes` date DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `empleado_proyecto_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `imputaciones_actividades_empleado_proyecto_id_fk` (`empleado_proyecto_id`),
  KEY `imputaciones_actividades_user_id_fk` (`user_id`),
  CONSTRAINT `imputaciones_actividades_empleado_proyecto_id_fk` FOREIGN KEY (`empleado_proyecto_id`) REFERENCES `empleados_proyectos` (`id`),
  CONSTRAINT `imputaciones_actividades_user_id_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `insert_empleados`
--

DROP TABLE IF EXISTS `insert_empleados`;
/*!50001 DROP VIEW IF EXISTS `insert_empleados`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `insert_empleados` AS SELECT 
 1 AS `codigo_empleado`,
 1 AS `dni`,
 1 AS `fecha_alta`,
 1 AS `fecha_baja`,
 1 AS `nombre`,
 1 AS `apellidos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `obras_curso`
--

DROP TABLE IF EXISTS `obras_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `obras_curso` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `periodo` date DEFAULT NULL,
  `proyecto_id` int(11) NOT NULL,
  `costes_periodo` float DEFAULT NULL,
  `costes_acumulado` float DEFAULT NULL,
  `facturado_periodo` float DEFAULT NULL,
  `facturado_acumulado` float DEFAULT NULL,
  `realizado_periodo` float DEFAULT NULL,
  `realizado_acumulado` float DEFAULT NULL,
  `margen_periodo` float DEFAULT NULL,
  `margen_acumulado` float DEFAULT NULL,
  `horas_imputadas` float DEFAULT NULL,
  `horas_imputadas_acumuladas` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `estado` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proyecto_id_fk` (`proyecto_id`),
  CONSTRAINT `proyecto_id_fk` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4624 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paises`
--

DROP TABLE IF EXISTS `paises`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paises` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `provincias`
--

DROP TABLE IF EXISTS `provincias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provincias` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `pais_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `provincias_pais_id_fk` (`pais_id`),
  CONSTRAINT `provincias_pais_id_fk` FOREIGN KEY (`pais_id`) REFERENCES `paises` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyectos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `importe_v0` float NOT NULL,
  `importe_v1` float NOT NULL,
  `coste_v0` float NOT NULL,
  `coste_v1` float NOT NULL,
  `margen_v0` float NOT NULL,
  `margen_v1` float NOT NULL,
  `inicio_el` datetime NOT NULL,
  `fin_el` datetime NOT NULL,
  `tipo_proyecto_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `estado` int(11) NOT NULL,
  `cliente_id` int(11) NOT NULL,
  `departamento_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_proyectos_on_codigo` (`codigo`),
  KEY `index_proyectos_on_cliente_id` (`cliente_id`),
  KEY `index_proyectos_on_departamento_id` (`departamento_id`),
  CONSTRAINT `proyectos_cliente_id_fk` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  CONSTRAINT `proyectos_departamento_id_fk` FOREIGN KEY (`departamento_id`) REFERENCES `departamentos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `proyectos_historicos`
--

DROP TABLE IF EXISTS `proyectos_historicos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `proyectos_historicos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `proyecto_id` int(11) NOT NULL,
  `importe_v1` float DEFAULT NULL,
  `coste_v1` float DEFAULT NULL,
  `margen_v1` float DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `proyectos_historicos_proyecto_id_fk` (`proyecto_id`),
  CONSTRAINT `proyectos_historicos_proyecto_id_fk` FOREIGN KEY (`proyecto_id`) REFERENCES `proyectos` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4529 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dashboard` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `administracion` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empleados` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `imputaciones` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schema_migrations`
--

DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sociedades`
--

DROP TABLE IF EXISTS `sociedades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sociedades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `estado` int(11) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `localidad` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `codigo_postal` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `provincia` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `telefono1` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fax` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cif` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `pie_factura` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `telefono2` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `update_empleados`
--

DROP TABLE IF EXISTS `update_empleados`;
/*!50001 DROP VIEW IF EXISTS `update_empleados`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `update_empleados` AS SELECT 
 1 AS `codigo_empleado`,
 1 AS `dni`,
 1 AS `fecha_alta`,
 1 AS `fecha_baja`,
 1 AS `nombre`,
 1 AS `apellidos`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `last_sign_in_ip` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `rol_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_username` (`username`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  KEY `index_users_on_rol_id` (`rol_id`),
  CONSTRAINT `users_rol_id_fk` FOREIGN KEY (`rol_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Final view structure for view `insert_empleados`
--

/*!50001 DROP VIEW IF EXISTS `insert_empleados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `insert_empleados` AS select `t1`.`codigo_empleado` AS `codigo_empleado`,`t1`.`dni` AS `dni`,`t1`.`fecha_alta` AS `fecha_alta`,`t1`.`fecha_baja` AS `fecha_baja`,`t1`.`nombre` AS `nombre`,concat(`t1`.`apellido1`,' ',`t1`.`apellido2`) AS `apellidos` from (`empleados_temporales` `t1` left join `empleados` `t2` on((`t1`.`codigo_empleado` = `t2`.`codigo_empleado`))) where isnull(`t2`.`codigo_empleado`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `update_empleados`
--

/*!50001 DROP VIEW IF EXISTS `update_empleados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `update_empleados` AS select `t1`.`codigo_empleado` AS `codigo_empleado`,`t1`.`dni` AS `dni`,`t1`.`fecha_alta` AS `fecha_alta`,`t1`.`fecha_baja` AS `fecha_baja`,`t1`.`nombre` AS `nombre`,concat(`t1`.`apellido1`,' ',`t1`.`apellido2`) AS `apellidos` from (`empleados_temporales` `t1` left join `empleados` `t2` on((`t1`.`codigo_empleado` = `t2`.`codigo_empleado`))) where isnull(`t2`.`codigo_empleado`) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-01-04 16:32:19
INSERT INTO schema_migrations (version) VALUES ('20150818094706');

INSERT INTO schema_migrations (version) VALUES ('20150826160755');

INSERT INTO schema_migrations (version) VALUES ('20150828075704');

INSERT INTO schema_migrations (version) VALUES ('20150828120233');

INSERT INTO schema_migrations (version) VALUES ('20150831101007');

INSERT INTO schema_migrations (version) VALUES ('20151111123419');

INSERT INTO schema_migrations (version) VALUES ('20151112083152');

INSERT INTO schema_migrations (version) VALUES ('20151113101328');

INSERT INTO schema_migrations (version) VALUES ('20151116085851');

INSERT INTO schema_migrations (version) VALUES ('20151116092420');

INSERT INTO schema_migrations (version) VALUES ('20151116145527');

INSERT INTO schema_migrations (version) VALUES ('20151116160819');

INSERT INTO schema_migrations (version) VALUES ('20151118095845');

INSERT INTO schema_migrations (version) VALUES ('20151118140946');

INSERT INTO schema_migrations (version) VALUES ('20151118144137');

INSERT INTO schema_migrations (version) VALUES ('20151118164206');

INSERT INTO schema_migrations (version) VALUES ('20151118180044');

INSERT INTO schema_migrations (version) VALUES ('20151118180456');

INSERT INTO schema_migrations (version) VALUES ('20151119082857');

INSERT INTO schema_migrations (version) VALUES ('20151119110610');

INSERT INTO schema_migrations (version) VALUES ('20151120104144');

INSERT INTO schema_migrations (version) VALUES ('20151120111830');

INSERT INTO schema_migrations (version) VALUES ('20151120112559');

INSERT INTO schema_migrations (version) VALUES ('20151123100040');

INSERT INTO schema_migrations (version) VALUES ('20151123100920');

INSERT INTO schema_migrations (version) VALUES ('20151123114733');

INSERT INTO schema_migrations (version) VALUES ('20151124085327');

INSERT INTO schema_migrations (version) VALUES ('20151125165115');

INSERT INTO schema_migrations (version) VALUES ('20151125174029');

INSERT INTO schema_migrations (version) VALUES ('20151126092210');

INSERT INTO schema_migrations (version) VALUES ('20151126093133');

INSERT INTO schema_migrations (version) VALUES ('20151126103540');

INSERT INTO schema_migrations (version) VALUES ('20151126103556');

INSERT INTO schema_migrations (version) VALUES ('20151126173505');

INSERT INTO schema_migrations (version) VALUES ('20151126174502');

INSERT INTO schema_migrations (version) VALUES ('20151201111937');

INSERT INTO schema_migrations (version) VALUES ('20151201112218');

INSERT INTO schema_migrations (version) VALUES ('20151201112422');

INSERT INTO schema_migrations (version) VALUES ('20151201112512');

INSERT INTO schema_migrations (version) VALUES ('20151201115850');

INSERT INTO schema_migrations (version) VALUES ('20151201121727');

INSERT INTO schema_migrations (version) VALUES ('20151201122956');

INSERT INTO schema_migrations (version) VALUES ('20151201135422');

INSERT INTO schema_migrations (version) VALUES ('20151201140115');

INSERT INTO schema_migrations (version) VALUES ('20151201140358');

INSERT INTO schema_migrations (version) VALUES ('20151201140704');

INSERT INTO schema_migrations (version) VALUES ('20151201141229');

INSERT INTO schema_migrations (version) VALUES ('20151201141636');

INSERT INTO schema_migrations (version) VALUES ('20151201142024');

INSERT INTO schema_migrations (version) VALUES ('20151201143625');

INSERT INTO schema_migrations (version) VALUES ('20151201160348');

INSERT INTO schema_migrations (version) VALUES ('20151201161615');

INSERT INTO schema_migrations (version) VALUES ('20151202115102');

INSERT INTO schema_migrations (version) VALUES ('20151203085348');

INSERT INTO schema_migrations (version) VALUES ('20151203153530');

INSERT INTO schema_migrations (version) VALUES ('20151203153749');

INSERT INTO schema_migrations (version) VALUES ('20151203173045');

INSERT INTO schema_migrations (version) VALUES ('20151204085958');

INSERT INTO schema_migrations (version) VALUES ('20151209142759');

INSERT INTO schema_migrations (version) VALUES ('20151214114450');

INSERT INTO schema_migrations (version) VALUES ('20151214124914');

INSERT INTO schema_migrations (version) VALUES ('20151215112151');

INSERT INTO schema_migrations (version) VALUES ('20151215122858');

INSERT INTO schema_migrations (version) VALUES ('20151216161236');

INSERT INTO schema_migrations (version) VALUES ('20151217150833');

INSERT INTO schema_migrations (version) VALUES ('20151217152248');

INSERT INTO schema_migrations (version) VALUES ('20151217153152');

INSERT INTO schema_migrations (version) VALUES ('20151217155447');

INSERT INTO schema_migrations (version) VALUES ('20151218084120');

INSERT INTO schema_migrations (version) VALUES ('20151221151746');

INSERT INTO schema_migrations (version) VALUES ('20151222105118');

INSERT INTO schema_migrations (version) VALUES ('20151222150907');

INSERT INTO schema_migrations (version) VALUES ('20151224070327');

INSERT INTO schema_migrations (version) VALUES ('20151230105117');

INSERT INTO schema_migrations (version) VALUES ('20151230105701');

INSERT INTO schema_migrations (version) VALUES ('20160104090810');

INSERT INTO schema_migrations (version) VALUES ('20160104105417');

