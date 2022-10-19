/*
SQLyog Ultimate v10.00 Beta1
MySQL - 5.5.5-10.4.25-MariaDB : Database - pwc
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`pwc` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci */;

USE `pwc`;

/*Table structure for table `calendario` */

DROP TABLE IF EXISTS `calendario`;

CREATE TABLE `calendario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `asignadas` int(11) DEFAULT NULL,
  `id_sede` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKcalendario` (`id`),
  KEY `XIF1calendario` (`id_sede`),
  CONSTRAINT `calendario_ibfk_1` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=197 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `ccaa` */

DROP TABLE IF EXISTS `ccaa`;

CREATE TABLE `ccaa` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKccaa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `citas` */

DROP TABLE IF EXISTS `citas`;

CREATE TABLE `citas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hora` varchar(5) COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `id_calendario` int(11) DEFAULT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKcitas` (`id`),
  KEY `XIF1citas` (`id_pedido`),
  KEY `XIF2citas` (`id_calendario`),
  CONSTRAINT `citas_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `citas_ibfk_2` FOREIGN KEY (`id_calendario`) REFERENCES `calendario` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `correo` */

DROP TABLE IF EXISTS `correo`;

CREATE TABLE `correo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `destinatario` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `copia` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `asunto` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `cuerpo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `observaciones` text COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKcorreo` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `correo_estado` */

DROP TABLE IF EXISTS `correo_estado`;

CREATE TABLE `correo_estado` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_estado` int(11) DEFAULT NULL,
  `id_correo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKcorreo_estado` (`id`),
  KEY `XIF1correo_estado` (`id_estado`),
  KEY `XIF2correo_estado` (`id_correo`),
  CONSTRAINT `correo_estado_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id`) ON DELETE CASCADE,
  CONSTRAINT `correo_estado_ibfk_2` FOREIGN KEY (`id_correo`) REFERENCES `correo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `envios` */

DROP TABLE IF EXISTS `envios`;

CREATE TABLE `envios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `apellidos` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `dni` varchar(10) COLLATE utf8_spanish_ci NOT NULL,
  `direccion` varchar(500) COLLATE utf8_spanish_ci NOT NULL,
  `provincia` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `poblacion` varbinary(100) DEFAULT NULL,
  `cod_postal` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `comentario` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `seguimiento` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo_zeleris` varchar(50) COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKenvios` (`id`),
  UNIQUE KEY `XAK1envios` (`codigo_zeleris`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `estados` */

DROP TABLE IF EXISTS `estados`;

CREATE TABLE `estados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `codigo` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `descripcion` varchar(300) COLLATE utf8_spanish_ci NOT NULL,
  `icono` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKestados` (`id`),
  UNIQUE KEY `XAK1estados` (`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `festivos` */

DROP TABLE IF EXISTS `festivos`;

CREATE TABLE `festivos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `id_ccaa` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKfestivos` (`id`),
  KEY `XIF1festivos` (`id_ccaa`),
  CONSTRAINT `festivos_ibfk_1` FOREIGN KEY (`id_ccaa`) REFERENCES `ccaa` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `historico_envios` */

DROP TABLE IF EXISTS `historico_envios`;

CREATE TABLE `historico_envios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_envio` int(11) DEFAULT NULL,
  `numero_doc` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `estado` varchar(20) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `numero_exp` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `seguimiento` varchar(50) CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  `obs_incidencia` text CHARACTER SET utf8 COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKhistorico_envios` (`id`),
  KEY `XIF1historico_envios` (`id_envio`),
  CONSTRAINT `historico_envios_ibfk_1` FOREIGN KEY (`id_envio`) REFERENCES `envios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `historico_pedidos` */

DROP TABLE IF EXISTS `historico_pedidos`;

CREATE TABLE `historico_pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` datetime DEFAULT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_estado` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKhistorico_pedidos` (`id`),
  KEY `XIF1historico_pedidos` (`id_pedido`),
  KEY `XIF2historico_pedidos` (`id_estado`),
  KEY `XIF3historico_pedidos` (`id_usuario`),
  CONSTRAINT `historico_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historico_pedidos_ibfk_2` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id`) ON DELETE CASCADE,
  CONSTRAINT `historico_pedidos_ibfk_3` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=267 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `parametros` */

DROP TABLE IF EXISTS `parametros`;

CREATE TABLE `parametros` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  `valor` longtext COLLATE utf8_spanish_ci DEFAULT NULL,
  `tipo` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `clave` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKparametros` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `pedidos` */

DROP TABLE IF EXISTS `pedidos`;

CREATE TABLE `pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `adquirir_antiguo` int(11) DEFAULT NULL,
  `entregado_antiguo` int(11) DEFAULT 0,
  `envio_domicilio` int(11) DEFAULT NULL,
  `fecha_crea` datetime DEFAULT NULL,
  `fecha_modi` datetime DEFAULT NULL,
  `motivo_domicilio` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `comentario` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `motivo_rechazo` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_estado` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `id_sede_entrega` int(11) DEFAULT NULL,
  `id_envio` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKpedidos` (`id`),
  KEY `XIF1pedidos` (`id_estado`),
  KEY `XIF2pedidos` (`id_usuario`),
  KEY `XIF3pedidos` (`id_sede_entrega`),
  KEY `XIF4pedidos` (`id_envio`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`id_estado`) REFERENCES `estados` (`id`),
  CONSTRAINT `pedidos_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pedidos_ibfk_3` FOREIGN KEY (`id_sede_entrega`) REFERENCES `sedes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pedidos_ibfk_4` FOREIGN KEY (`id_envio`) REFERENCES `envios` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=192 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `perfiles` */

DROP TABLE IF EXISTS `perfiles`;

CREATE TABLE `perfiles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `peso` int(11) DEFAULT NULL,
  `home_banner` text COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKperfiles` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `referencia` */

DROP TABLE IF EXISTS `referencia`;

CREATE TABLE `referencia` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tabla` varchar(40) COLLATE utf8_spanish_ci DEFAULT NULL,
  `codigo` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `valor` text COLLATE utf8_spanish_ci DEFAULT NULL,
  `descripcion` varchar(500) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKreferencia` (`id`),
  UNIQUE KEY `XAK1referencia` (`tabla`,`codigo`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `sedes` */

DROP TABLE IF EXISTS `sedes`;

CREATE TABLE `sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(200) COLLATE utf8_spanish_ci NOT NULL,
  `entregas` int(11) DEFAULT NULL,
  `fecha_desde` date DEFAULT NULL,
  `fecha_hasta` date DEFAULT NULL,
  `hora_desde` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hora_hasta` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `slot` int(11) DEFAULT NULL,
  `citas_slot` int(11) DEFAULT NULL,
  `personas_slot` int(11) DEFAULT NULL,
  `id_ccaa` int(11) DEFAULT NULL,
  `hora_desde2` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `hora_hasta2` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `slot2` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKsedes` (`id`),
  KEY `XIF1sedes` (`id_ccaa`),
  CONSTRAINT `sedes_ibfk_1` FOREIGN KEY (`id_ccaa`) REFERENCES `ccaa` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `terminal_pedidos` */

DROP TABLE IF EXISTS `terminal_pedidos`;

CREATE TABLE `terminal_pedidos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cantidad` int(11) DEFAULT NULL,
  `id_pedido` int(11) DEFAULT NULL,
  `id_terminal_extra` int(11) DEFAULT NULL,
  `id_terminal_nuevo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKterminal_pedidos` (`id`),
  KEY `XIF2terminal_pedidos` (`id_pedido`),
  KEY `XIF3terminal_pedidos` (`id_terminal_extra`),
  KEY `XIF4terminal_pedidos` (`id_terminal_nuevo`),
  CONSTRAINT `terminal_pedidos_ibfk_1` FOREIGN KEY (`id_pedido`) REFERENCES `pedidos` (`id`) ON DELETE CASCADE,
  CONSTRAINT `terminal_pedidos_ibfk_2` FOREIGN KEY (`id_terminal_extra`) REFERENCES `terminales` (`id`) ON DELETE CASCADE,
  CONSTRAINT `terminal_pedidos_ibfk_3` FOREIGN KEY (`id_terminal_nuevo`) REFERENCES `terminal_usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=195 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `terminal_usuarios` */

DROP TABLE IF EXISTS `terminal_usuarios`;

CREATE TABLE `terminal_usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imei` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `num_serie` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `id_terminal` int(11) DEFAULT NULL,
  `id_usuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKterminal_usuarios` (`id`),
  KEY `XIF1terminal_usuarios` (`id_terminal`),
  KEY `XIF2terminal_usuarios` (`id_usuario`),
  CONSTRAINT `terminal_usuarios_ibfk_1` FOREIGN KEY (`id_terminal`) REFERENCES `terminales` (`id`),
  CONSTRAINT `terminal_usuarios_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8193 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `terminales` */

DROP TABLE IF EXISTS `terminales`;

CREATE TABLE `terminales` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `marca` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `modelo` varchar(20) COLLATE utf8_spanish_ci NOT NULL,
  `precio` decimal(6,2) DEFAULT NULL,
  `nuevo` int(11) DEFAULT NULL,
  `codigo` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `mas_terminales` int(1) DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKterminales` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `password` varchar(100) COLLATE utf8_spanish_ci NOT NULL,
  `email_verified_at` datetime DEFAULT NULL,
  `remember_token` varchar(200) COLLATE utf8_spanish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `locked_at` datetime DEFAULT NULL,
  `username` varchar(50) COLLATE utf8_spanish_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `extension` varchar(10) COLLATE utf8_spanish_ci DEFAULT NULL,
  `perfil_pwc` varchar(20) COLLATE utf8_spanish_ci DEFAULT NULL,
  `caduca` datetime DEFAULT NULL,
  `id_perfil` int(11) DEFAULT NULL,
  `id_sede` int(11) DEFAULT NULL,
  `sys_id` varchar(100) COLLATE utf8_spanish_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `XPKusuarios` (`id`),
  KEY `XIF1usuarios` (`id_perfil`),
  KEY `XIF2usuarios` (`id_sede`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_perfil`) REFERENCES `perfiles` (`id`),
  CONSTRAINT `usuarios_ibfk_2` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4195 DEFAULT CHARSET=utf8 COLLATE=utf8_spanish_ci;

/*Table structure for table `vw_empleado` */

DROP TABLE IF EXISTS `vw_empleado`;

/*!50001 DROP VIEW IF EXISTS `vw_empleado` */;
/*!50001 DROP TABLE IF EXISTS `vw_empleado` */;

/*!50001 CREATE TABLE  `vw_empleado`(
 `name` varchar(100) ,
 `email` varchar(50) ,
 `id` int(11) ,
 `adquirir_antiguo` int(11) ,
 `adquiere_antiguo` varchar(2) ,
 `fecha_crea` datetime ,
 `envio_domicilio` int(11) ,
 `estado_pedido` varchar(300) ,
 `fecha_cita` date ,
 `hora` varchar(5) ,
 `estado_envio` varchar(20) ,
 `fecha_envio` datetime ,
 `id_sede_entrega` int(11) ,
 `nombre_sede` varchar(200) ,
 `telefono` varchar(20) ,
 `id_pedido` int(11) ,
 `estado_codigo` varchar(20) ,
 `tipo_entrega` text 
)*/;

/*View structure for view vw_empleado */

/*!50001 DROP TABLE IF EXISTS `vw_empleado` */;
/*!50001 DROP VIEW IF EXISTS `vw_empleado` */;

/*!50001 CREATE ALGORITHM=UNDEFINED DEFINER=`user`@`%` SQL SECURITY DEFINER VIEW `vw_empleado` AS select `u`.`name` AS `name`,`u`.`email` AS `email`,`u`.`id` AS `id`,`pe`.`adquirir_antiguo` AS `adquirir_antiguo`,if(`pe`.`adquirir_antiguo` is not null,if(`pe`.`adquirir_antiguo` = 1,'SI','NO'),NULL) AS `adquiere_antiguo`,`pe`.`fecha_crea` AS `fecha_crea`,`pe`.`envio_domicilio` AS `envio_domicilio`,`es`.`descripcion` AS `estado_pedido`,`ci`.`fecha` AS `fecha_cita`,`ci`.`hora` AS `hora`,`en`.`estado` AS `estado_envio`,`hi`.`fecha` AS `fecha_envio`,`pe`.`id_sede_entrega` AS `id_sede_entrega`,`se`.`descripcion` AS `nombre_sede`,`u`.`telefono` AS `telefono`,`pe`.`id` AS `id_pedido`,`es`.`codigo` AS `estado_codigo`,`re`.`valor` AS `tipo_entrega` from ((((((((`usuarios` `u` left join (select `pe1`.`id_usuario` AS `id_usuario`,max(`pe1`.`id`) AS `id` from `pedidos` `pe1` group by `pe1`.`id_usuario`) `aux` on(`aux`.`id_usuario` = `u`.`id`)) left join `pedidos` `pe` on(`pe`.`id` = `aux`.`id`)) left join `sedes` `se` on(`se`.`id` = `pe`.`id_sede_entrega`)) left join `estados` `es` on(`es`.`id` = `pe`.`id_estado`)) left join `citas` `ci` on(`ci`.`id_pedido` = `pe`.`id`)) left join `envios` `en` on(`en`.`id` = `pe`.`id_envio`)) left join `historico_envios` `hi` on(`hi`.`id_envio` = `en`.`id` and `hi`.`estado` = `en`.`estado`)) left join `referencia` `re` on(`re`.`tabla` = 'TIPO_ENTREGA' and `re`.`codigo` = `pe`.`envio_domicilio`)) where (`es`.`codigo` <> 'BOR' or `es`.`codigo` is null) and `u`.`email` like '%@pwc.com' */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
