-- HelioViewer Database Structure --
-- last update: 10-06-2008        --

--
-- Create schema
--
CREATE DATABASE IF NOT EXISTS hv;
USE hv;

--
-- Create tables
--

-- --------------------------------------------------------

--
-- Table structure for table `observatory`
--

CREATE TABLE `observatory` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `abbreviation` varchar(4) NOT NULL default '',
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

INSERT INTO `observatory` VALUES(1, 'soho', 'SOHO', 'Solar and Heliospheric Observatory');
INSERT INTO `observatory` VALUES(2, 'trac', 'TRACE', 'The Transition Region and Coronal Explorer');


-- --------------------------------------------------------

--
-- Table structure for table `instrument`
--

CREATE TABLE `instrument` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `abbreviation` varchar(4) NOT NULL default '',
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `observatoryId` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

INSERT INTO `instrument` VALUES(1, 'MDI', 'MDI', 'Michelson Doppler Imager', 1);
INSERT INTO `instrument` VALUES(2, 'LAS', 'LAS', 'The Large Angle Spectrometric Coronagraph', 1);
INSERT INTO `instrument` VALUES(3, 'EIT', 'EIT', 'Extreme ultraviolet Imaging Telescope', 1);
INSERT INTO `instrument` VALUES(4, 'TRA', 'TRACE', 'TRACE', 2);

--
-- Table structure for table `detector`
--
CREATE TABLE `detector` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `abbreviation` varchar(4) NOT NULL default '',
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  `instrumentId` int(10) unsigned NOT NULL default '0',
  `imgSunRatio` float(6,3) default NULL,
  `lowestRegularZoomLevel` tinyint(4) default NULL,
  `minZoom` tinyint(4) default NULL,
  `opacityGroupId` int(10) unsigned NOT NULL default '1',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

INSERT INTO `detector` VALUES(1, 'MDI', '', 'MDI', 1, NULL, 10, 9, 1);
INSERT INTO `detector` VALUES(2, '0C3', 'C3', 'LASCO C3', 2, NULL, 15, 14, 3);
INSERT INTO `detector` VALUES(3, '0C2', 'C2', 'LASCO C2', 2, NULL, 13, 12, 2);
INSERT INTO `detector` VALUES(4, 'EIT', '', 'EIT', 3, NULL, 10, 10, 1);
INSERT INTO `detector` VALUES(5, 'TRA', '', 'TRACE', 4, NULL, 10, 9, 1);

-- --------------------------------------------------------

--
-- Table structure for table `measurement`
--

CREATE TABLE `measurement` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `measurementTypeId` int(10) unsigned NOT NULL default '0',
  `detectorId` int(10) unsigned NOT NULL default '0',
  `abbreviation` varchar(4) NOT NULL default '',
  `name` varchar(255) default NULL,
  `description` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

INSERT INTO `measurement` VALUES(1, 1, 1, 'mag', 'mag', 'Magnetogram');
INSERT INTO `measurement` VALUES(2, 1, 1, 'int', 'int', 'Intensitygram');
INSERT INTO `measurement` VALUES(3, 1, 2, '0WL', 'WL', 'White Light');
INSERT INTO `measurement` VALUES(4, 1, 3, '0WL', 'WL', 'White Light');
INSERT INTO `measurement` VALUES(5, 2, 4, '195', '195', '195 Angstrom extreme ultraviolet');
INSERT INTO `measurement` VALUES(6, 2, 4, '171', '171', '171 Angstrom extreme ultraviolet');
INSERT INTO `measurement` VALUES(7, 2, 4, '304', '304', '304 Angstrom extreme ultraviolet');
INSERT INTO `measurement` VALUES(8, 2, 4, '284', '284', '284 Angstrom extreme ultraviolet');
INSERT INTO `measurement` VALUES(9, 2, 5, '171', '171', '171 Angstrom extreme ultraviolet');

-- --------------------------------------------------------

--
-- Table structure for table `measurementType`
--

CREATE TABLE `measurementType` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `unit` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

INSERT INTO `measurementType` VALUES(1, 'other', NULL);
INSERT INTO `measurementType` VALUES(2, 'wavelength', 'nm');

-- --------------------------------------------------------

--
-- Table structure for table `opacityGroup`
--
CREATE TABLE `opacityGroup` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;


INSERT INTO `opacityGroup` VALUES(1, 'Full Disc Image');
INSERT INTO `opacityGroup` VALUES(2, 'Coronagraph Image, in the range of LASCO C2');
INSERT INTO `opacityGroup` VALUES(3, 'Coronagraph Image, in the range of LASCO C3');
INSERT INTO `opacityGroup` VALUES(4, 'Sub-field');

--
-- Table structure for table `image`
--
CREATE TABLE  `image` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `measurementId` int(10) unsigned NOT NULL default '0',
  `timestamp` datetime NOT NULL default '0000-00-00 00:00:00',
  `filetype` varchar(4) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=0;

--
-- Table structure for table `tile`
--
DROP TABLE IF EXISTS `tile`;
CREATE TABLE IF NOT EXISTS `tile` (
  `imageId` int(11) NOT NULL default '0',
  `x` int(11) NOT NULL default '0',
  `y` int(11) NOT NULL default '0',
  `zoom` int(11) NOT NULL default '0',
  `url` varchar(255) default NULL,
  `tile` mediumblob,
  PRIMARY KEY  (`imageId`,`x`,`y`,`zoom`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
