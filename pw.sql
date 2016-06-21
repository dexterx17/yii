-- phpMyAdmin SQL Dump
-- version 4.0.4
-- http://www.phpmyadmin.net
--
-- Servidor: localhost
-- Tiempo de generación: 03-09-2014 a las 04:23:43
-- Versión del servidor: 5.6.12-log
-- Versión de PHP: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de datos: `pw`
--
CREATE DATABASE IF NOT EXISTS `pw` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `pw`;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authassignment`
--

CREATE TABLE IF NOT EXISTS `authassignment` (
  `itemname` varchar(64) NOT NULL,
  `userid` varchar(64) NOT NULL,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`itemname`,`userid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authassignment`
--

INSERT INTO `authassignment` (`itemname`, `userid`, `bizrule`, `data`) VALUES
('admin', 'admin', NULL, 'N;'),
('author', 'profesor1', NULL, 'N;'),
('author', 'profesor2', NULL, 'N;'),
('editor', 'profesorJefe', NULL, 'N;');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitem`
--

CREATE TABLE IF NOT EXISTS `authitem` (
  `name` varchar(64) NOT NULL,
  `type` int(11) NOT NULL,
  `description` text,
  `bizrule` text,
  `data` text,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authitem`
--

INSERT INTO `authitem` (`name`, `type`, `description`, `bizrule`, `data`) VALUES
('admin', 2, '', NULL, 'N;'),
('author', 2, '', NULL, 'N;'),
('createPost', 0, 'create a post', NULL, 'N;'),
('deletePost', 0, 'delete a post', NULL, 'N;'),
('editor', 2, '', NULL, 'N;'),
('reader', 2, '', NULL, 'N;'),
('readPost', 0, 'read a post', NULL, 'N;'),
('updateOwnPost', 1, 'update a post by author himself', 'return Yii::app()->user->id==$params["post"]->authorname;', 'N;'),
('updatePost', 0, 'update a post', NULL, 'N;');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `authitemchild`
--

CREATE TABLE IF NOT EXISTS `authitemchild` (
  `parent` varchar(64) NOT NULL,
  `child` varchar(64) NOT NULL,
  PRIMARY KEY (`parent`,`child`),
  KEY `child` (`child`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `authitemchild`
--

INSERT INTO `authitemchild` (`parent`, `child`) VALUES
('admin', 'author'),
('author', 'createPost'),
('admin', 'deletePost'),
('admin', 'editor'),
('author', 'reader'),
('editor', 'reader'),
('reader', 'readPost'),
('author', 'updateOwnPost'),
('editor', 'updatePost'),
('updateOwnPost', 'updatePost');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_comment`
--

CREATE TABLE IF NOT EXISTS `pw_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `content` text NOT NULL,
  `status` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `author` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `url` varchar(200) NOT NULL,
  `post_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `postIdIndex` (`post_id`),
  KEY `authorIndex` (`author`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Volcado de datos para la tabla `pw_comment`
--

INSERT INTO `pw_comment` (`id`, `content`, `status`, `create_time`, `author`, `email`, `url`, `post_id`) VALUES
(1, '321', 1, 0, 'admin', 'felix@ceis.cujae.edu.cu', 'http://ntceis.cujae.edu.cu', 9),
(2, '123', 1, 0, 'admin', 'felix@ceis.cujae.edu.cu', 'http://ntceis.cujae.edu.cu', 9),
(3, '456', 2, 0, 'admin', 'felix@ceis.cujae.edu.cu', 'http://ntceis.cujae.edu.cu', 9),
(4, '890', 2, 1407849575, 'admin', 'felix@ceis.cujae.edu.cu', 'http://ntceis.cujae.edu.cu', 9),
(5, '123', 2, 1407867219, 'admin', 'felix@ceis.cujae.edu.cu', 'http://ntceis.cujae.edu.cu', 4),
(6, 'dfsdf', 1, 1407891924, 'admin', 'demo@ceis.cujae.edu.cu', 'http://www.google.com', 11);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_post`
--

CREATE TABLE IF NOT EXISTS `pw_post` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(200) NOT NULL,
  `content` varchar(255) NOT NULL,
  `tags` varchar(200) DEFAULT NULL,
  `status` int(11) NOT NULL,
  `create_time` int(11) NOT NULL,
  `update_time` int(11) NOT NULL,
  `authorname` varchar(50) NOT NULL,
  `likes` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `authornameFK` (`authorname`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

--
-- Volcado de datos para la tabla `pw_post`
--

INSERT INTO `pw_post` (`id`, `title`, `content`, `tags`, `status`, `create_time`, `update_time`, `authorname`, `likes`) VALUES
(4, 'Actividad práctica semana 8', 'Es importante garantizar el conocimiento de BD como punto de partida para esta actividad.', 'yii', 2, 0, 0, 'admin', 1),
(6, 'Inicio de curso', 'Comenzamos el 1ro de Septiembre', 'web, programación', 2, 0, 0, 'admin', 1),
(9, 'Facebook', 'Facebook es el tercer país más grande del mundo si tenemos en cuenta su población, por lo que es capaz de mover más información que cualquier gobierno', 'facebook', 2, 1407814218, 1407814218, 'admin', 1),
(11, 'El acceso a datos se implementa en tres niveles diferentes', 'Podemos ver la estructura del código php mezclada con el código html en las vistas pero es importante la separación que se logra con el patrón de diseño MVC', 'datos, php, programacion', 2, 1407879989, 1407887230, 'admin', 2),
(13, 'El acceso a información', 'x25', 'a, b, c', 3, 1407892946, 1407893028, 'admin', 3),
(14, 'entrance1', 'sdfa', 'a, b, c', 2, 1407975661, 1407976028, 'admin', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_post_resource`
--

CREATE TABLE IF NOT EXISTS `pw_post_resource` (
  `idPost` int(11) NOT NULL,
  `idResource` int(11) NOT NULL,
  PRIMARY KEY (`idPost`,`idResource`),
  KEY `postId` (`idPost`),
  KEY `resourceId` (`idResource`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_resource`
--

CREATE TABLE IF NOT EXISTS `pw_resource` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `description` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  `downloads` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `resourceTypeIdx` (`type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Volcado de datos para la tabla `pw_resource`
--

INSERT INTO `pw_resource` (`id`, `name`, `description`, `location`, `type`, `downloads`) VALUES
(1, 'r1', 'libro', 'c:\\wamp\\www', 1, 0),
(2, 'x', 'x', 'x', 1, 0);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_resourcetype`
--

CREATE TABLE IF NOT EXISTS `pw_resourcetype` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

--
-- Volcado de datos para la tabla `pw_resourcetype`
--

INSERT INTO `pw_resourcetype` (`id`, `type`) VALUES
(1, 'Video'),
(2, 'Bibliografía'),
(3, 'Software');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_tag`
--

CREATE TABLE IF NOT EXISTS `pw_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `frequency` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Volcado de datos para la tabla `pw_tag`
--

INSERT INTO `pw_tag` (`id`, `name`, `frequency`) VALUES
(1, 'facebook', 1),
(2, 'datos', 1),
(3, 'php', 1),
(4, 'programacion', 1),
(5, 'a', 2),
(6, 'b', 2),
(7, 'c', 2);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pw_user`
--

CREATE TABLE IF NOT EXISTS `pw_user` (
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `profile` varchar(255) NOT NULL,
  `type` int(11) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `usernameIdx` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Volcado de datos para la tabla `pw_user`
--

INSERT INTO `pw_user` (`username`, `password`, `email`, `profile`, `type`) VALUES
('admin', '25779f8829ab7a7650e85a4cc871e6ac', 'felix@ceis.cujae.edu.cu', '', 1),
('profesor1', '25779f8829ab7a7650e85a4cc871e6ac', 'felix@ceis.cujae.edu.cu', '', 1),
('profesor2', '25779f8829ab7a7650e85a4cc871e6ac', 'felix@ceis.cujae.edu.cu', '', 1),
('profesorJefe', '25779f8829ab7a7650e85a4cc871e6ac', 'felix@ceis.cujae.edu.cu', '', 0);

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `authassignment`
--
ALTER TABLE `authassignment`
  ADD CONSTRAINT `authassignment_ibfk_1` FOREIGN KEY (`itemname`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `authitemchild`
--
ALTER TABLE `authitemchild`
  ADD CONSTRAINT `authitemchild_ibfk_1` FOREIGN KEY (`parent`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `authitemchild_ibfk_2` FOREIGN KEY (`child`) REFERENCES `authitem` (`name`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pw_comment`
--
ALTER TABLE `pw_comment`
  ADD CONSTRAINT `pw_comment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `pw_post` (`id`),
  ADD CONSTRAINT `pw_comment_ibfk_2` FOREIGN KEY (`author`) REFERENCES `pw_user` (`username`);

--
-- Filtros para la tabla `pw_post`
--
ALTER TABLE `pw_post`
  ADD CONSTRAINT `authornameFK` FOREIGN KEY (`authorname`) REFERENCES `pw_user` (`username`);

--
-- Filtros para la tabla `pw_post_resource`
--
ALTER TABLE `pw_post_resource`
  ADD CONSTRAINT `pw_post_resource_ibfk_1` FOREIGN KEY (`idPost`) REFERENCES `pw_post` (`id`),
  ADD CONSTRAINT `pw_post_resource_ibfk_2` FOREIGN KEY (`idResource`) REFERENCES `pw_resource` (`id`);

--
-- Filtros para la tabla `pw_resource`
--
ALTER TABLE `pw_resource`
  ADD CONSTRAINT `pw_resource_ibfk_1` FOREIGN KEY (`type`) REFERENCES `pw_resourcetype` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
