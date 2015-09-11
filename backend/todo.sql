/*
 Navicat Premium Data Transfer

 Source Server         : tunel.arquitectura-ios.appspot.com
 Source Server Type    : MySQL
 Source Server Version : 50626
 Source Host           : :/cloudsql/arquitectura-ios:db
 Source Database       : todo

 Target Server Type    : MySQL
 Target Server Version : 50626
 File Encoding         : utf-8

 Date: 09/03/2015 14:46:07 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `categorias`
-- ----------------------------
DROP TABLE IF EXISTS `categorias`;
CREATE TABLE `categorias` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `nombre_cat` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `categorias`
-- ----------------------------
BEGIN;
INSERT INTO `categorias` VALUES ('1', 'Limpieza'), ('2', 'Estudio'), ('3', 'Salud');
COMMIT;

-- ----------------------------
--  Table structure for `tareas`
-- ----------------------------
DROP TABLE IF EXISTS `tareas`;
CREATE TABLE `tareas` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `tarea` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tareas`
-- ----------------------------
BEGIN;
INSERT INTO `tareas` VALUES ('1', 'Lavar auto'), ('2', 'Lavar platos'), ('3', 'Estudiar inglés'), ('4', 'Andar en bici 30 minutos');
COMMIT;

-- ----------------------------
--  Table structure for `tareas_categorias`
-- ----------------------------
DROP TABLE IF EXISTS `tareas_categorias`;
CREATE TABLE `tareas_categorias` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `fk_tarea` bigint(20) NOT NULL,
  `fk_categoria` bigint(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `tareas_categorias`
-- ----------------------------
BEGIN;
INSERT INTO `tareas_categorias` VALUES ('1', '1', '1'), ('2', '2', '1'), ('3', '3', '2'), ('4', '4', '3');
COMMIT;

-- ----------------------------
--  Table structure for `usuarios`
-- ----------------------------
DROP TABLE IF EXISTS `usuarios`;
CREATE TABLE `usuarios` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(255) NOT NULL,
  `clave` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
--  Records of `usuarios`
-- ----------------------------
BEGIN;
INSERT INTO `usuarios` VALUES ('38', '1', '1'), ('39', '3', '3'), ('40', '2', '2'), ('41', 'w', 'w'), ('42', '5', '5');
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
