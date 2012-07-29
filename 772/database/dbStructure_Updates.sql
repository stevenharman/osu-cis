# phpMyAdmin SQL Dump
# version 2.5.5-pl1
# http://www.phpmyadmin.net
#
# Host: localhost
# Generation Time: Mar 02, 2004 at 10:04 PM
# Server version: 4.0.17
# PHP Version: 4.3.4
# 
# Database : `cis772`
# 

# --------------------------------------------------------

#
# Table structure for table `orders_completed`
#
# Creation: Feb 29, 2004 at 06:31 PM
# Last update: Mar 01, 2004 at 11:12 PM
#

DROP TABLE IF EXISTS `orders_completed`;
CREATE TABLE `orders_completed` (
  `user_id` int(11) NOT NULL default '0',
  `order_number` int(11) NOT NULL default '0',
  `date_placed` varchar(100) NOT NULL default '',
  `date_shipped` varchar(100) NOT NULL default '',
  `shipping_method` varchar(50) NOT NULL default '',
  `tracking_number` varchar(100) NOT NULL default '',
  `place_of_sale` varchar(100) NOT NULL default '',
  `user_name` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`user_id`,`order_number`)
) TYPE=MyISAM;

#
# RELATIONS FOR TABLE `orders_completed`:
#   `user_id`
#       `forum_members` -> `MEMBER_ID`
#

# --------------------------------------------------------

#
# Table structure for table `orders_completed_itemlist`
#
# Creation: Feb 29, 2004 at 06:20 PM
# Last update: Mar 01, 2004 at 11:09 PM
#

DROP TABLE IF EXISTS `orders_completed_itemlist`;
CREATE TABLE `orders_completed_itemlist` (
  `order_number` int(11) NOT NULL default '0',
  `item_id` int(11) NOT NULL default '0',
  `item_name` varchar(60) NOT NULL default '',
  `quantity` int(11) NOT NULL default '0',
  `price` double NOT NULL default '0'
) TYPE=MyISAM;

#
# RELATIONS FOR TABLE `orders_completed_itemlist`:
#   `order_number`
#       `orders_completed` -> `order_number`
#

# --------------------------------------------------------

#
# Table structure for table `orders_itemlist`
#
# Creation: Feb 25, 2004 at 03:41 PM
# Last update: Mar 02, 2004 at 11:59 AM
#

DROP TABLE IF EXISTS `orders_itemlist`;
CREATE TABLE `orders_itemlist` (
  `order_number` int(11) NOT NULL default '0',
  `item_number` int(11) NOT NULL default '0',
  `item_quantity` int(11) NOT NULL default '0',
  PRIMARY KEY  (`order_number`,`item_number`)
) TYPE=MyISAM;

#
# RELATIONS FOR TABLE `orders_itemlist`:
#   `item_number`
#       `items` -> `item_id`
#

# --------------------------------------------------------

#
# Table structure for table `orders_pending`
#
# Creation: Feb 25, 2004 at 03:38 PM
# Last update: Mar 02, 2004 at 12:12 PM
#

DROP TABLE IF EXISTS `orders_pending`;
CREATE TABLE `orders_pending` (
  `order_number` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `date_placed` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`order_number`),
  KEY `user_id` (`user_id`)
) TYPE=MyISAM;

#
# RELATIONS FOR TABLE `orders_pending`:
#   `user_id`
#       `forum_members` -> `MEMBER_ID`
#

# --------------------------------------------------------

#
# Table structure for table `shopping_carts`
#
# Creation: Feb 25, 2004 at 03:36 PM
# Last update: Mar 02, 2004 at 09:42 PM
# Last check: Feb 25, 2004 at 03:36 PM
#

DROP TABLE IF EXISTS `shopping_carts`;
CREATE TABLE `shopping_carts` (
  `user_id` int(11) NOT NULL default '0',
  `item_number` int(11) NOT NULL default '0',
  `item_qty` int(11) NOT NULL default '0',
  PRIMARY KEY  (`user_id`,`item_number`),
  KEY `user_id` (`user_id`)
) TYPE=MyISAM;

#
# RELATIONS FOR TABLE `shopping_carts`:
#   `item_number`
#       `items` -> `item_id`
#   `user_id`
#       `forum_members` -> `MEMBER_ID`
#
