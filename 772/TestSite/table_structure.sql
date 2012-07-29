Database cis772 running on localhost 
# phpMyAdmin SQL Dump
# version 2.5.5-pl1
# http://www.phpmyadmin.net
#
# Host: localhost
# Generation Time: Jan 16, 2004 at 02:12 PM
# Server version: 4.0.17
# PHP Version: 4.3.4
# 
# Database : `cis772`
# 

# --------------------------------------------------------

#
# Table structure for table `communications`
#

CREATE TABLE `communications` (
  `comm_id` bigint(20) NOT NULL auto_increment,
  `comm_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_id` bigint(20) NOT NULL default '0',
  `message` longtext NOT NULL,
  PRIMARY KEY  (`comm_id`),
  KEY `user_id` (`user_id`),
  FULLTEXT KEY `message` (`message`)
) TYPE=MyISAM COMMENT='Communications Table' AUTO_INCREMENT=1 ;

# --------------------------------------------------------

#
# Table structure for table `item_class`
#

CREATE TABLE `item_class` (
  `class_id` bigint(20) NOT NULL auto_increment,
  `class_name` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`class_id`),
  UNIQUE KEY `class_name` (`class_name`)
) TYPE=MyISAM COMMENT='Item Classes' AUTO_INCREMENT=2 ;

# --------------------------------------------------------

#
# Table structure for table `item_pictures`
#

CREATE TABLE `item_pictures` (
  `file_name` varchar(50) NOT NULL default '',
  `item_id` bigint(20) NOT NULL default '0',
  PRIMARY KEY  (`file_name`)
) TYPE=MyISAM COMMENT='Item Picture Links';

# --------------------------------------------------------

#
# Table structure for table `items`
#

CREATE TABLE `items` (
  `item_id` bigint(20) NOT NULL auto_increment,
  `class_id_1` bigint(20) NOT NULL default '0',
  `item_price` decimal(10,0) default NULL,
  `for_sale` char(3) NOT NULL default 'NO',
  `active` char(3) NOT NULL default 'NO',
  `description` longtext NOT NULL,
  PRIMARY KEY  (`item_id`),
  FULLTEXT KEY `description` (`description`)
) TYPE=MyISAM COMMENT='Item Information' AUTO_INCREMENT=2 ;

# --------------------------------------------------------

#
# Table structure for table `orders`
#

CREATE TABLE `orders` (
  `order_id` bigint(20) NOT NULL auto_increment,
  `user_id` bigint(20) NOT NULL default '0',
  `order_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `shipped_date` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`order_id`)
) TYPE=MyISAM COMMENT='Order Information' AUTO_INCREMENT=2 ;

# --------------------------------------------------------

#
# Table structure for table `pma_column_info`
#

CREATE TABLE `pma_column_info` (
  `id` int(5) unsigned NOT NULL auto_increment,
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `column_name` varchar(64) NOT NULL default '',
  `comment` varchar(255) NOT NULL default '',
  `mimetype` varchar(255) NOT NULL default '',
  `transformation` varchar(255) NOT NULL default '',
  `transformation_options` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `db_name` (`db_name`,`table_name`,`column_name`)
) TYPE=MyISAM COMMENT='Comments for Columns' AUTO_INCREMENT=1 ;

# --------------------------------------------------------

#
# Table structure for table `pma_history`
#

CREATE TABLE `pma_history` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `username` varchar(64) NOT NULL default '',
  `db` varchar(64) NOT NULL default '',
  `table` varchar(64) NOT NULL default '',
  `timevalue` timestamp(14) NOT NULL,
  `sqlquery` text NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `username` (`username`,`db`,`table`,`timevalue`)
) TYPE=MyISAM COMMENT='SQL history' AUTO_INCREMENT=1 ;

# --------------------------------------------------------

#
# Table structure for table `pma_pdf_pages`
#

CREATE TABLE `pma_pdf_pages` (
  `db_name` varchar(64) NOT NULL default '',
  `page_nr` int(10) unsigned NOT NULL auto_increment,
  `page_descr` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`page_nr`),
  KEY `db_name` (`db_name`)
) TYPE=MyISAM COMMENT='PDF Relationpages for PMA' AUTO_INCREMENT=4 ;

# --------------------------------------------------------

#
# Table structure for table `pma_relation`
#

CREATE TABLE `pma_relation` (
  `master_db` varchar(64) NOT NULL default '',
  `master_table` varchar(64) NOT NULL default '',
  `master_field` varchar(64) NOT NULL default '',
  `foreign_db` varchar(64) NOT NULL default '',
  `foreign_table` varchar(64) NOT NULL default '',
  `foreign_field` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`master_db`,`master_table`,`master_field`),
  KEY `foreign_field` (`foreign_db`,`foreign_table`)
) TYPE=MyISAM COMMENT='Relation table';

# --------------------------------------------------------

#
# Table structure for table `pma_table_coords`
#

CREATE TABLE `pma_table_coords` (
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `pdf_page_number` int(11) NOT NULL default '0',
  `x` float unsigned NOT NULL default '0',
  `y` float unsigned NOT NULL default '0',
  PRIMARY KEY  (`db_name`,`table_name`,`pdf_page_number`)
) TYPE=MyISAM COMMENT='Table coordinates for phpMyAdmin PDF output';

# --------------------------------------------------------

#
# Table structure for table `pma_table_info`
#

CREATE TABLE `pma_table_info` (
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `display_field` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`db_name`,`table_name`)
) TYPE=MyISAM COMMENT='Table information for phpMyAdmin';

# --------------------------------------------------------

#
# Table structure for table `purchases`
#

CREATE TABLE `purchases` (
  `order_id` bigint(20) NOT NULL default '0',
  `item_id` bigint(20) NOT NULL default '0'
) TYPE=MyISAM COMMENT='Purchase Info';

# --------------------------------------------------------

#
# Table structure for table `users`
#

CREATE TABLE `users` (
  `user_id` bigint(20) NOT NULL auto_increment,
  `first_name` varchar(25) NOT NULL default '',
  `last_name` varchar(30) NOT NULL default '',
  `address_1` varchar(100) NOT NULL default '',
  `address_2` varchar(100) default NULL,
  `city` varchar(25) NOT NULL default '',
  `state` char(2) NOT NULL default '',
  `zip` int(5) NOT NULL default '0',
  `username` varchar(40) NOT NULL default '',
  `password` varchar(20) NOT NULL default '',
  `email` varchar(50) NOT NULL default '',
  `admin` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`user_id`),
  UNIQUE KEY `username` (`username`)
) TYPE=MyISAM COMMENT='User Information' AUTO_INCREMENT=3 ;
    