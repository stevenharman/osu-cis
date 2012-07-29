# phpMyAdmin SQL Dump
# version 2.5.5-pl1
# http://www.phpmyadmin.net
#
# Host: 192.168.2.201
# Generation Time: Mar 10, 2004 at 03:34 PM
# Server version: 4.0.17
# PHP Version: 4.2.3
# 
# Database : `cis772`
# 

# --------------------------------------------------------

#
# Table structure for table `communications`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Feb 03, 2004 at 11:27 PM
#

DROP TABLE IF EXISTS `communications`;
CREATE TABLE `communications` (
  `comm_id` bigint(20) NOT NULL auto_increment,
  `comm_date` datetime NOT NULL default '0000-00-00 00:00:00',
  `user_id` bigint(20) NOT NULL default '0',
  `message` longtext NOT NULL,
  PRIMARY KEY  (`comm_id`),
  KEY `user_id` (`user_id`),
  FULLTEXT KEY `message` (`message`)
) TYPE=MyISAM COMMENT='Communications Table' AUTO_INCREMENT=1 ;

#
# Dumping data for table `communications`
#


# --------------------------------------------------------

#
# Table structure for table `forum_a_reply`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_a_reply`;
CREATE TABLE `forum_a_reply` (
  `CAT_ID` int(11) NOT NULL default '0',
  `FORUM_ID` int(11) NOT NULL default '0',
  `TOPIC_ID` int(11) NOT NULL default '0',
  `REPLY_ID` int(11) NOT NULL default '0',
  `R_STATUS` smallint(6) default NULL,
  `R_MAIL` smallint(6) default NULL,
  `R_AUTHOR` int(11) default NULL,
  `R_MESSAGE` text,
  `R_DATE` varchar(14) default NULL,
  `R_IP` varchar(15) default NULL,
  `R_LAST_EDIT` varchar(14) default NULL,
  `R_LAST_EDITBY` int(11) default NULL,
  `R_SIG` smallint(6) default NULL,
  PRIMARY KEY  (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`,`REPLY_ID`),
  KEY `FORUM_A_REPLY_CATFORTOPREPL` (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`,`REPLY_ID`),
  KEY `FORUM_A_REPLY_REP_ID` (`REPLY_ID`),
  KEY `FORUM_A_REPLY_CAT_ID` (`CAT_ID`),
  KEY `FORUM_A_REPLY_FORUM_ID` (`FORUM_ID`),
  KEY `FORUM_A_REPLY_TOPIC_ID` (`TOPIC_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `forum_a_reply`
#


# --------------------------------------------------------

#
# Table structure for table `forum_a_topics`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_a_topics`;
CREATE TABLE `forum_a_topics` (
  `CAT_ID` int(11) NOT NULL default '0',
  `FORUM_ID` int(11) NOT NULL default '0',
  `TOPIC_ID` int(11) NOT NULL default '0',
  `T_STATUS` smallint(6) default NULL,
  `T_MAIL` smallint(6) default NULL,
  `T_SUBJECT` varchar(100) default NULL,
  `T_MESSAGE` text,
  `T_AUTHOR` int(11) default NULL,
  `T_REPLIES` int(11) default NULL,
  `T_UREPLIES` int(11) default NULL,
  `T_VIEW_COUNT` int(11) default NULL,
  `T_LAST_POST` varchar(14) default NULL,
  `T_DATE` varchar(14) default NULL,
  `T_LAST_POSTER` int(11) default NULL,
  `T_IP` varchar(15) default NULL,
  `T_LAST_POST_AUTHOR` int(11) default NULL,
  `T_LAST_POST_REPLY_ID` int(11) default NULL,
  `T_ARCHIVE_FLAG` int(11) default NULL,
  `T_LAST_EDIT` varchar(14) default NULL,
  `T_LAST_EDITBY` int(11) default NULL,
  `T_STICKY` smallint(6) default NULL,
  `T_SIG` smallint(6) default NULL,
  PRIMARY KEY  (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`),
  KEY `FORUM_A_TOPIC_CATFORTOP` (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`),
  KEY `FORUM_A_TOPIC_CAT_ID` (`CAT_ID`),
  KEY `FORUM_A_TOPIC_FORUM_ID` (`FORUM_ID`),
  KEY `FORUM_A_TOPIC_TOPIC_ID` (`TOPIC_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `forum_a_topics`
#


# --------------------------------------------------------

#
# Table structure for table `forum_allowed_members`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_allowed_members`;
CREATE TABLE `forum_allowed_members` (
  `MEMBER_ID` int(11) NOT NULL default '0',
  `FORUM_ID` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`MEMBER_ID`,`FORUM_ID`)
) TYPE=MyISAM;

#
# Dumping data for table `forum_allowed_members`
#


# --------------------------------------------------------

#
# Table structure for table `forum_badwords`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_badwords`;
CREATE TABLE `forum_badwords` (
  `B_ID` int(11) NOT NULL auto_increment,
  `B_BADWORD` varchar(50) default NULL,
  `B_REPLACE` varchar(50) default NULL,
  PRIMARY KEY  (`B_ID`)
) TYPE=MyISAM AUTO_INCREMENT=6 ;

#
# Dumping data for table `forum_badwords`
#

INSERT INTO `forum_badwords` (`B_ID`, `B_BADWORD`, `B_REPLACE`) VALUES (1, 'fuck', '****'),
(2, 'wank', '****'),
(3, 'shit', '****'),
(4, 'pussy', '*****'),
(5, 'cunt', '****');

# --------------------------------------------------------

#
# Table structure for table `forum_category`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_category`;
CREATE TABLE `forum_category` (
  `CAT_ID` int(11) NOT NULL auto_increment,
  `CAT_STATUS` smallint(6) NOT NULL default '1',
  `CAT_NAME` varchar(100) default '',
  `CAT_MODERATION` int(11) default '0',
  `CAT_SUBSCRIPTION` int(11) default '0',
  `CAT_ORDER` int(11) default '1',
  PRIMARY KEY  (`CAT_ID`),
  KEY `FORUM_CATEGORY_CAT_ID` (`CAT_ID`),
  KEY `FORUM_CATEGORY_CAT_STATUS` (`CAT_STATUS`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

#
# Dumping data for table `forum_category`
#

INSERT INTO `forum_category` (`CAT_ID`, `CAT_STATUS`, `CAT_NAME`, `CAT_MODERATION`, `CAT_SUBSCRIPTION`, `CAT_ORDER`) VALUES (2, 1, 'User Feed-back', 0, 0, 1);

# --------------------------------------------------------

#
# Table structure for table `forum_config_new`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Mar 03, 2004 at 01:29 PM
#

DROP TABLE IF EXISTS `forum_config_new`;
CREATE TABLE `forum_config_new` (
  `ID` int(11) NOT NULL auto_increment,
  `C_VARIABLE` varchar(255) default NULL,
  `C_VALUE` varchar(255) default NULL,
  PRIMARY KEY  (`ID`)
) TYPE=MyISAM AUTO_INCREMENT=156 ;

#
# Dumping data for table `forum_config_new`
#

INSERT INTO `forum_config_new` (`ID`, `C_VARIABLE`, `C_VALUE`) VALUES (1, 'STRVERSION', 'Snitz Forums 2000 Version 3.4.04'),
(2, 'STRFORUMTITLE', 'www.BCRocket.com Forums'),
(3, 'STRCOPYRIGHT', 'www.BCRocket.com'),
(4, 'STRTITLEIMAGE', '../../images/Title1.gif'),
(5, 'STRHOMEURL', '../index.asp'),
(6, 'STRFORUMURL', 'http://www.bcrocket.com/forum/'),
(7, 'STRAUTHTYPE', 'db'),
(8, 'STRSETCOOKIETOFORUM', '0'),
(9, 'STREMAIL', '1'),
(10, 'STRUNIQUEEMAIL', '1'),
(11, 'STRMAILMODE', 'cdosys'),
(12, 'STRMAILSERVER', 'smtp-server.columbus.rr.com'),
(13, 'STRSENDER', 'harman@cis.ohio-state.edu'),
(14, 'STRDATETYPE', 'mdy'),
(15, 'STRTIMETYPE', '12'),
(16, 'STRTIMEADJUSTLOCATION', '0'),
(17, 'STRTIMEADJUST', '0'),
(18, 'STRMOVETOPICMODE', '1'),
(19, 'STRPRIVATEFORUMS', '0'),
(20, 'STRSHOWMODERATORS', '1'),
(21, 'STRSHOWRANK', '3'),
(22, 'STRHIDEEMAIL', '0'),
(23, 'STRIPLOGGING', '1'),
(24, 'STRALLOWFORUMCODE', '1'),
(25, 'STRIMGINPOSTS', '1'),
(26, 'STRALLOWHTML', '0'),
(27, 'STRSECUREADMIN', '1'),
(28, 'STRNOCOOKIES', '0'),
(29, 'STREDITEDBYDATE', '1'),
(30, 'STRHOTTOPIC', '1'),
(31, 'INTHOTTOPICNUM', '20'),
(32, 'STRHOMEPAGE', '1'),
(33, 'STRAIM', '1'),
(34, 'STRICQ', '1'),
(35, 'STRMSN', '1'),
(36, 'STRYAHOO', '1'),
(37, 'STRICONS', '1'),
(38, 'STRGFXBUTTONS', '0'),
(39, 'STRBADWORDFILTER', '1'),
(40, 'STRBADWORDS', 'fuck|wank|shit|pussy|cunt'),
(41, 'STRUSERNAMEFILTER', '0'),
(42, 'STRDEFAULTFONTFACE', 'Arial, Helvetica, sans-serif'),
(43, 'STRDEFAULTFONTSIZE', '2'),
(44, 'STRHEADERFONTSIZE', '4'),
(45, 'STRFOOTERFONTSIZE', '1'),
(46, 'STRPAGEBGCOLOR', '#FFFFFF'),
(47, 'STRDEFAULTFONTCOLOR', '#333333'),
(48, 'STRLINKCOLOR', '#990000'),
(49, 'STRLINKTEXTDECORATION', 'none'),
(50, 'STRVISITEDLINKCOLOR', '#990000'),
(51, 'STRVISITEDTEXTDECORATION', 'none'),
(52, 'STRACTIVELINKCOLOR', 'red'),
(53, 'STRHOVERFONTCOLOR', '#990000'),
(54, 'STRHOVERTEXTDECORATION', 'underline'),
(55, 'STRHEADCELLCOLOR', '#828282'),
(56, 'STRHEADFONTCOLOR', 'mintcream'),
(57, 'STRCATEGORYCELLCOLOR', '#990000'),
(58, 'STRCATEGORYFONTCOLOR', 'mintcream'),
(59, 'STRFORUMFIRSTCELLCOLOR', 'whitesmoke'),
(60, 'STRFORUMCELLCOLOR', 'whitesmoke'),
(61, 'STRALTFORUMCELLCOLOR', 'whitesmoke'),
(62, 'STRFORUMFONTCOLOR', '#333333'),
(63, 'STRFORUMLINKCOLOR', '#990000'),
(64, 'STRFORUMLINKTEXTDECORATION', 'none'),
(65, 'STRFORUMVISITEDLINKCOLOR', '#990000'),
(66, 'STRFORUMVISITEDTEXTDECORATION', 'none'),
(67, 'STRFORUMACTIVELINKCOLOR', '#990000'),
(68, 'STRFORUMACTIVETEXTDECORATION', 'none'),
(69, 'STRFORUMHOVERFONTCOLOR', '#990000'),
(70, 'STRFORUMHOVERTEXTDECORATION', 'underline'),
(71, 'STRTABLEBORDERCOLOR', '#333333'),
(72, 'STRPOPUPTABLECOLOR', 'whitesmoke'),
(73, 'STRPOPUPBORDERCOLOR', 'black'),
(74, 'STRNEWFONTCOLOR', 'blue'),
(75, 'STRHILITEFONTCOLOR', 'red'),
(76, 'STRSEARCHHILITECOLOR', 'yellow'),
(77, 'STRTOPICWIDTHLEFT', '100'),
(78, 'STRTOPICWIDTHRIGHT', '100%'),
(79, 'STRTOPICNOWRAPLEFT', '1'),
(80, 'STRTOPICNOWRAPRIGHT', '0'),
(81, 'STRRANKADMIN', 'Administrator'),
(82, 'STRRANKMOD', 'Moderator'),
(83, 'STRRANKLEVEL0', 'Starting Member'),
(84, 'STRRANKLEVEL1', 'New Member'),
(85, 'STRRANKLEVEL2', 'Junior Member'),
(86, 'STRRANKLEVEL3', 'Average Member'),
(87, 'STRRANKLEVEL4', 'Senior Member'),
(88, 'STRRANKLEVEL5', 'Advanced Member'),
(89, 'STRRANKCOLORADMIN', 'gold'),
(90, 'STRRANKCOLORMOD', 'silver'),
(91, 'STRRANKCOLOR0', 'bronze'),
(92, 'STRRANKCOLOR1', 'green'),
(93, 'STRRANKCOLOR2', 'blue'),
(94, 'STRRANKCOLOR3', 'red'),
(95, 'STRRANKCOLOR4', 'orange'),
(96, 'STRRANKCOLOR5', 'bronze'),
(97, 'INTRANKLEVEL0', '0'),
(98, 'INTRANKLEVEL1', '10'),
(99, 'INTRANKLEVEL2', '100'),
(100, 'INTRANKLEVEL3', '500'),
(101, 'INTRANKLEVEL4', '1000'),
(102, 'INTRANKLEVEL5', '2000'),
(103, 'STRSIGNATURES', '1'),
(104, 'STRDSIGNATURES', '1'),
(105, 'STRSHOWSTATISTICS', '1'),
(106, 'STRSHOWIMAGEPOWEREDBY', '0'),
(107, 'STRLOGONFORMAIL', '1'),
(108, 'STRSHOWPAGING', '1'),
(109, 'STRSHOWTOPICNAV', '1'),
(110, 'STRPAGESIZE', '15'),
(111, 'STRPAGENUMBERSIZE', '10'),
(112, 'STRFULLNAME', '1'),
(113, 'STRPICTURE', '1'),
(114, 'STRSEX', '1'),
(115, 'STRCITY', '1'),
(116, 'STRSTATE', '1'),
(117, 'STRAGE', '1'),
(118, 'STRAGEDOB', '0'),
(119, 'STRCOUNTRY', '1'),
(120, 'STROCCUPATION', '1'),
(121, 'STRFAVLINKS', '1'),
(122, 'STRBIO', '0'),
(123, 'STRHOBBIES', '0'),
(124, 'STRLNEWS', '0'),
(125, 'STRQUOTE', '0'),
(126, 'STRMARSTATUS', '1'),
(127, 'STRRECENTTOPICS', '1'),
(128, 'STRNTGROUPS', '0'),
(129, 'STRAUTOLOGON', '0'),
(130, 'STRMOVENOTIFY', '1'),
(131, 'STRSUBSCRIPTION', '0'),
(132, 'STRMODERATION', '0'),
(133, 'STRARCHIVESTATE', '1'),
(134, 'STRFLOODCHECK', '1'),
(135, 'STRFLOODCHECKTIME', '-60'),
(136, 'STREMAILVAL', '1'),
(137, 'STRPAGEBGIMAGEURL', ''),
(138, 'STRIMAGEURL', 'images/'),
(139, 'STRJUMPLASTPOST', '0'),
(140, 'STRSTICKYTOPIC', '1'),
(141, 'STRSHOWSENDTOFRIEND', '1'),
(142, 'STRSHOWPRINTERFRIENDLY', '1'),
(143, 'STRPROHIBITNEWMEMBERS', '0'),
(144, 'STRREQUIREREG', '0'),
(145, 'STRRESTRICTREG', '0'),
(146, 'STRGROUPCATEGORIES', '0'),
(147, 'STRSHOWTIMER', '1'),
(148, 'STRTIMERPHRASE', 'This page was generated in [TIMER] seconds.'),
(149, 'STRSHOWFORMATBUTTONS', '1'),
(150, 'STRSHOWSMILIESTABLE', '1'),
(151, 'STRSHOWQUICKREPLY', '1'),
(152, 'strActiveTextDecoration', 'none'),
(153, 'STRADDR1', '1'),
(154, 'STRADDR2', '1'),
(155, 'STRZIP', '1');

# --------------------------------------------------------

#
# Table structure for table `forum_forum`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Mar 09, 2004 at 06:16 PM
#

DROP TABLE IF EXISTS `forum_forum`;
CREATE TABLE `forum_forum` (
  `CAT_ID` int(11) NOT NULZš}fault '1',
  `FORUM_ID` smallint(6) NOT NULL auto_increment,
  `F_STATUS` smallint(6) default '1',
  `F_MAIL` smallint(6) default '1',
  `F_SUBJECT` varchar(100) default '',
  `F_URL` varchar(255) default '',
  `F_DESCRIPTION` text,
  `F_TOPICS` int(11) default '0',
  `F_COUNT` int(11) default '0',
  `F_LAST_POST` varchar(14) default '',
  `F_PASSWORD_NEW` varchar(255) default '',
  `F_PRIVATEFORUMS` int(11) default '0',
  `F_TYPE` smallint(6) default '0',
  `F_IP` varchar(15) default '000.000.000.000',
  `F_LAST_POST_AUTHOR` int(11) default '1',
  `F_LAST_POST_TOPIC_ID` int(11) default '0',
  `F_LAST_POST_REPLY_ID` int(11) default '0',
  `F_MODERATION` int(11) default '0',
  `F_SUBSCRIPTION` int(11) default '0',
  `F_ORDER` int(11) default '1',
  `F_DEFAULTDAYS` int(11) default '30',
  `F_COUNT_M_POSTS` smallint(6) default '1',
  `F_L_ARCHIVE` varchar(14) default '',
  `F_ARCHIVE_SCHED` int(11) default '30',
  `F_L_DELETE` varchar(14) default '',
  `F_DELETE_SCHED` int(11) default '365',
  `F_A_TOPICS` int(11) default '0',
  `F_A_COUNT` int(11) default '0',
  PRIMARY KEY  (`CAT_ID`,`FORUM_ID`),
  KEY `FORUM_FORUM_FORUM_ID` (`FORUM_ID`),
  KEY `FORUM_FORUM_CAT_ID` (`CAT_ID`)
) TYPE=MyISAM AUTO_INCREMENT=4 ;

#
# Dumping data for table `forum_forum`
#

INSERT INTO `forum_forum` (`CAT_ID`, `FORUM_ID`, `F_STATUS`, `F_MAIL`, `F_SUBJECT`, `F_URL`, `F_DESCRIPTION`, `F_TOPICS`, `F_COUNT`, `F_LAST_POST`, `F_PASSWORD_NEW`, `F_PRIVATEFORUMS`, `F_TYPE`, `F_IP`, `F_LAST_POST_AUTHOR`, `F_LAST_POST_TOPIC_ID`, `F_LAST_POST_REPLY_ID`, `F_MODERATION`, `F_SUBSCRIPTION`, `F_ORDER`, `F_DEFAULTDAYS`, `F_COUNT_M_POSTS`, `F_L_ARCHIVE`, `F_ARCHIVE_SCHED`, `F_L_DELETE`, `F_DELETE_SCHED`, `F_A_TOPICS`, `F_A_COUNT`) VALUES (2, 2, 1, 1, 'Questions & Comments', '', 'Have some questions or comments about BCRocket.com, the forums, or anything else about the site... post them here!', 1, 1, '20040210080415', '', 0, 0, '000.000.000.000', 3, 2, 0, 0, 0, 1, 0, 1, '', 30, '', 365, 0, 0),
(2, 3, 1, 1, 'Suggestions, Bugs, and Fixes', '', 'Have some suggestions for making the site better?  Or have you found some bugs in the site?  Have some suggestions for fixes?  Let us know!', 3, 10, '20040215125902', '', 0, 0, '000.000.000.000', 3, 5, 7, 0, 0, 1, 0, 1, '', 30, '', 365, 0, 0);

# --------------------------------------------------------

#
# Table structure for table `forum_group_names`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_group_names`;
CREATE TABLE `forum_group_names` (
  `GROUP_ID` int(11) NOT NULL auto_increment,
  `GROUP_NAME` varchar(50) default NULL,
  `GROUP_DESCRIPTION` varchar(255) default NULL,
  `GROUP_ICON` varchar(255) default NULL,
  `GROUP_IMAGE` varchar(255) default NULL,
  PRIMARY KEY  (`GROUP_ID`)
) TYPE=MyISAM AUTO_INCREMENT=3 ;

#
# Dumping data for table `forum_group_names`
#

INSERT INTO `forum_group_names` (`GROUP_ID`, `GROUP_NAME`, `GROUP_DESCRIPTION`, `GROUP_ICON`, `GROUP_IMAGE`) VALUES (1, 'All Categories you have access to', 'All Categories you have access to', NULL, NULL),
(2, 'Default Categories', 'Default Categories', NULL, NULL);

# --------------------------------------------------------

#
# Table structure for table `forum_groups`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_groups`;
CREATE TABLE `forum_groups` (
  `GROUP_KEY` int(11) NOT NULL auto_increment,
  `GROUP_ID` int(11) default NULL,
  `GROUP_CATID` int(11) default NULL,
  PRIMARY KEY  (`GROUP_KEY`)
) TYPE=MyISAM AUTO_INCREMENT=2 ;

#
# Dumping data for table `forum_groups`
#


# --------------------------------------------------------

#
# Table structure for table `forum_members`
#
# Creation: Feb 11, 2004 at 05:24 PM
# Last update: Mar 09, 2004 at 06:16 PM
#

DROP TABLE IF EXISTS `forum_members`;
CREATE TABLE `forum_members` (
  `MEMBER_ID` int(11) NOT NULL auto_increment,
  `M_STATUS` smallint(6) default '0',
  `M_NAME` varchar(75) default '',
  `M_USERNAME` varchar(150) default '',
  `M_PASSWORD` varchar(65) default '',
  `M_EMAIL` varchar(50) default '',
  `M_COUNTRY` varchar(50) default '',
  `M_HOMEPAGE` varchar(255) default '',
  `M_SIG` text,
  `M_VIEW_SIG` smallint(6) default '1',
  `M_SIG_DEFAULT` smallint(6) default '1',
  `M_DEFAULT_VIEW` int(11) default '1',
  `M_LEVEL` smallint(6) default '1',
  `M_AIM` varchar(150) default '',
  `M_ICQ` varchar(150) default '',
  `M_MSN` varchar(150) default '',
  `M_YAHOO` varchar(150) default '',
  `M_POSTS` int(11) default '0',
  `M_DATE` varchar(14) default '',
  `M_LASTHEREDATE` varchar(14) default '',
  `M_LASTPOSTDATE` varchar(14) default '',
  `M_TITLE` varchar(50) default '',
  `M_SUBSCRIPTION` smallint(6) default '0',
  `M_HIDE_EMAIL` smallint(6) default '0',
  `M_RECEIVE_EMAIL` smallint(6) default '1',
  `M_LAST_IP` varchar(15) default '000.000.000.000',
  `M_IP` varchar(15) default '000.000.000.000',
  `M_FIRSTNAME` varchar(100) default '',
  `M_LASTNAME` varchar(100) default '',
  `M_OCCUPATION` varchar(255) default '',
  `M_SEX` varchar(50) default '',
  `M_AGE` varchar(10) default '',
  `M_DOB` varchar(8) default '',
  `M_HOBBIES` text,
  `M_LNEWS` text,
  `M_QUOTE` text,
  `M_BIO` text,
  `M_MARSTATUS` varchar(100) default '',
  `M_LINK1` varchar(255) default '',
  `M_LINK2` varchar(255) default '',
  `M_CITY` varchar(100) default '',
  `M_STATE` varchar(100) default '',
  `M_PHOTO_URL` varchar(255) default '',
  `M_KEY` varchar(32) default '',
  `M_NEWEMAIL` varchar(50) default '',
  `M_PWKEY` varchar(32) default '',
  `M_SHA256` smallint(6) default '1',
  `M_ADDR1` varchar(50) NOT NULL default '',
  `M_ADDR2` varchar(50) default NULL,
  `M_ZIP` varchar(5) NOT NULL default '',
  `M_INV_ADMIN` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`MEMBER_ID`),
  KEY `FORUM_MEMBERS_MEMBER_ID` (`MEMBER_ID`)
) TYPE=MyISAM AUTO_INCREMENT=15 ;

#
# Dumping data for table `forum_members`
#

INSERT INTO `forum_members` (`MEMBER_ID`, `M_STATUS`, `M_NAME`, `M_USERNAME`, `M_PASSWORD`, `M_EMAIL`, `M_COUNTRY`, `M_HOMEPAGE`, `M_SIG`, `M_VIEW_SIG`, `M_SIG_DEFAULT`, `M_DEFAULT_VIEW`, `M_LEVEL`, `M_AIM`, `M_ICQ`, `M_MSN`, `M_YAHOO`, `M_POSTS`, `M_DATE`, `M_LASTHEREDATE`, `M_LASTPOSTDATE`, `M_TITLE`, `M_SUBSCRIPTION`, `M_HIDE_EMAIL`, `M_RECEIVE_EMAIL`, `M_LAST_IP`, `M_IP`, `M_FIRSTNAME`, `M_LASTNAME`, `M_OCCUPATION`, `M_SEX`, `M_AGE`, `M_DOB`, `M_HOBBIES`, `M_LNEWS`, `M_QUOTE`, `M_BIO`, `M_MARSTATUS`, `M_LINK1`, `M_LINK2`, `M_CITY`, `M_STATE`, `M_PHOTO_URL`, `M_KEY`, `M_NEWEMAIL`, `M_PWKEY`, `M_SHA256`, `M_ADDR1`, `M_ADDR2`, `M_ZIP`, `M_INV_ADMIN`) VALUES (1, 1, 'BCRocketAdmin', 'BCRocketAdmin', '589df3f9be97ebe46ac9fcbfeff6d5cdb6e91dae2929ca63e9c36924cdb0b223', 'yourmail@server.com', '', 'http://www.bcrocket.com', ' ', 1, 1, 1, 3, '', '', '', '', 1, '20040204172914', '20040303133105', '20040204172914', 'Forum Admin', 0, 0, 0, '164.107.114.60', '000.000.000.000', '', '', '', '', '', '', NULL, NULL, NULL, NULL, '', '', '', '', '', '', '', 'yourmail@server.com', '', 1, '', NULL, '', 1),
(3, 1, 'ussherm', '', 'dda058dac7e5f1c9b1379e3ecff7710141be6afaee442fcdbf1079d2ea47b419', 'harman.30@osu.edu', 'USA', 'http://www.buckeyeboys.com', '&gt;- 90% of being smart is knowing what you\'re dumb at -&lt;', 1, 1, 1, 3, 'ussherm', '', '', '', 7, '20040208162132', '20040309175824', '20040217111247', '', 0, 0, 1, '130.11.184.57', '192.168.2.1', 'Steve', 'Harman', 'Student', 'Male', '22', '', ' ', ' ', '"Is this thing even working?"', ' ', '', 'http://slashdot.org', '', 'Anytown', 'Ohio', 'http://www.buckeyeboys.com/piclib/jambo2003/fullimages/jambo03_091_f.jpg', '', 'harman.30@osu.edu', '', 1, '123 Some St.', '', '44444', 1),
(6, 1, 'justin', '', '102cf10b5286bad9fcfe5e275ace3ddd7dcc23931fb0ca93dc223daf9877cabd', 'jackson.814@osu.edu', 'USA', 'http://testhomepage.com', 'A test sig.', 0, 1, 1, 3, 'TestAIMName', 'testICQname', '', 'testYAHOOname', 0, '20040210035349', '20040222203002', '', '', 0, 0, 1, '24.208.173.202', '24.208.173.202', 'Justin', 'Jackson', 'Student', 'Male', '21', '', 'Some Test Hobbies', 'Some Test News', 'A cool quote', 'My test bio', 'Single', 'http://testlink1.com', 'http://testlink2.com', 'Dublin', 'OH', 'http://mypicture.com', '', 'jackson.814@osu.edu', '', 1, 'gobbledegook lane', '', '43017', 1),
(7, 1, 'Reolstan', '', 'e68444de99c5ffbfda466d2a374c28acef347eeca3a6150a001ae8b94d4d5ebb', 'eleka@columbus.rr.com', 'USA', '', '"Border relations between Canada and Mexico have never been better. " - George W. Bush Sept 24th, 2001.\r\n\r\nMakes you wonder.', 1, 1, 1, 3, 'Reolstan', '', '', '', 4, '20040212100826', '20040303223438', '20040215113205', '', 0, 0, 1, '24.93.96.98', '24.93.96.98', 'Alexander', 'Elek', 'Student', 'Male', '27', '', '', '', '', '', 'Single', '', '', 'Westerville', 'Ohio', '', '', 'eleka@columbus.rr.com', '', 1, '366 Gentlewind Dr', '', '43081', 1),
(8, 1, 'wolfycd', '', '9168e847861429230da331e23aa7983862033165c1ce3fe5f6d29a76c04c8a07', 'wolf.201@osu.edu', '', '', ' ', 1, 1, 1, 3, '', '', '', '', 4, '20040212105747', '20040308154755', '20040214115008', 'The Search Guru', 0, 0, 1, '24.160.171.235', '24.160.171.235', 'Matthew', 'Wolf', '', '', '', '', '', '', '', '', '', '', '', 'Columbus', 'OH', '', '', 'wolf.201@osu.edu', '', 1, '4664 Ralston Street', '', '43214', 1),
(9, 1, 'bcdevine', '', 'e00f9ef51a95f6e854862eed28dc0f1a68f154d9f75ddd841ab00de6ede9209b', 'bcdevine@sbcglobal.net', 'USA', '', ' ', 1, 1, 1, 2, '', '', '', '', 0, '20040212120304', '20040308224257', '', '', 0, 0, 1, '12.75.80.125', '24.93.96.98', 'Mark', 'DeVine', '', 'Male', '', '', '', '', '', '', '', '', '', 'Columbus', 'Ohio', '', '', 'bcdevine@sbcglobal.net', '', 1, 'PO Box 14357', '', '43214', 1),
(14, 1, 'riverrat111', '', '4dd938466304bacc70a11f357eb618502525fcb9dc85a9f3275b4d4cf205e98c', 'sheselde@columbus.rr.com', '', '', ' ', 1, 1, 1, 1, '', '', '', '', 0, '20040308173517', '20040308173517', '', '', 0, 0, 1, '24.210.17.41', '24.210.17.41', 'steven', 'heselden', '', 'Male', '49', '', '', '', '', '', '', '', '', 'columbus', 'ohio', '', '', '', '', 1, '3743 newell dr', '', '43228', 0),
(11, 1, 'GoBucks005', '', '49452e7d75461ed1e7af8f7950b2cea723360dddb19edd1c9f6390e8ed750c2d', 'pyeager@columbus.rr.com', 'USA', 'http://yeager.no-ip.info', ' ', 1, 1, 1, 1, 'GoBucks005', '', '', '', 0, '20040213122418', '20040310153401', '', '', 0, 0, 1, '164.107.190.80', '164.107.114.127', 'Paul', 'Yeager', 'Rocket Scientist', 'Male', '22', '', '', '', '', '', 'Single', '', '', 'Columbus', 'OH', 'http://yeager.no-ip.info/msu/slides/MVC-038S.JPG', '', '', '', 1, '58 West Ninth Avenue', 'Apartment K', '43201', 0),
(13, 1, 'hakan', '', '1e262cd7d110812f5726055a6e672b92cde43648b76adff51a12441fbdf7e667', 'hakan@cis.ohio-state.edu', 'USA', '', ' ', 1, 1, 1, 1, '', '', '', '', 0, '20040303001734', '20040303001734', '', '', 0, 0, 1, '24.210.50.140', '24.210.50.140', 'Hakan', 'Ferhatosmanoglu', '', '', '', '', '', '', '', '', '', '', '', 'Columbus', 'OH', '', '', '', '', 1, '2015 Neil Ave.', '', '43210', 0);

# --------------------------------------------------------

#
# Table structure for table `forum_members_pending`
#
# Creation: Feb 10, 2004 at 08:54 AM
# Last update: Mar 08, 2004 at 05:46 PM
#

DROP TABLE IF EXISTS `forum_members_pending`;
CREATE TABLE `forum_members_pending` (
  `MEMBER_ID` int(11) NOT NULL auto_increment,
  `M_STATUS` smallint(6) default '0',
  `M_NAME` varchar(75) default '',
  `M_USERNAME` varchar(150) default '',
  `M_PASSWORD` varchar(65) default '',
  `M_EMAIL` varchar(50) default '',
  `M_COUNTRY` varchar(50) default '',
  `M_HOMEPAGE` varchar(255) default '',
  `M_SIG` text,
  `M_VIEW_SIG` smallint(6) default '1',
  `M_SIG_DEFAULT` smallint(6) default '1',
  `M_DEFAULT_VIEW` int(11) default '1',
  `M_LEVEL` smallint(6) default '1',
  `M_AIM` varchar(150) default '',
  `M_ICQ` varchar(150) default '',
  `M_MSN` varchar(150) default '',
  `M_YAHOO` varchar(150) default '',
  `M_POSTS` int(11) default '0',
  `M_DATE` varchar(14) default '',
  `M_LASTHEREDATE` varchar(14) default '',
  `M_LASTPOSTDATE` varchar(14) default '',
  `M_TITLE` varchar(50) default '',
  `M_SUBSCRIPTION` smallint(6) default '0',
  `M_HIDE_EMAIL` smallint(6) default '0',
  `M_RECEIVE_EMAIL` smallint(6) default '1',
  `M_LAST_IP` varchar(15) default '000.000.000.000',
  `M_IP` varchar(15) default '000.000.000.000',
  `M_FIRSTNAME` varchar(100) default '',
  `M_LASTNAME` varchar(100) default '',
  `M_OCCUPATION` varchar(255) default '',
  `M_SEX` varchar(50) default '',
  `M_AGE` varchar(10) default '',
  `M_DOB` varchar(8) default '',
  `M_HOBBIES` varchar(255) default NULL,
  `M_LNEWS` varchar(255) default NULL,
  `M_QUOTE` varchar(255) default NULL,
  `M_BIO` varchar(255) default NULL,
  `M_MARSTATUS` varchar(100) default '',
  `M_LINK1` varchar(255) default '',
  `M_LINK2` varchar(255) default '',
  `M_CITY` varchar(100) default '',
  `M_STATE` varchar(100) default '',
  `M_PHOTO_URL` varchar(255) default '',
  `M_KEY` varchar(32) default NULL,
  `M_NEWEMAIL` varchar(50) default '',
  `M_PWKEY` varchar(32) default '',
  `M_APPROVE` smallint(6) default '0',
  `M_SHA256` smallint(6) default '1',
  `M_ADDR1` varchar(50) NOT NULL default '',
  `M_ADDR2` varchar(50) default NULL,
  `M_ZIP` varchar(5) NOT NULL default '',
  PRIMARY KEY  (`MEMBER_ID`)
) TYPE=MyISAM AUTO_INCREMENT=20 ;

#
# Dumping data for table `forum_members_pending`
#


# --------------------------------------------------------

#
# Table structure for table `forum_moderator`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 13, 2004 at 04:21 PM
#

DROP TABLE IF EXISTS `forum_moderator`;
CREATE TABLE `forum_moderator` (
  `MOD_ID` int(11) NOT NULL auto_increment,
  `FORUM_ID` int(11) default '1',
  `MEMBER_ID` int(11) default '1',
  `MOD_TYPE` smallint(6) default '0',
  PRIMARY KEY  (`MOD_ID`)
) TYPE=MyISAM AUTO_INCREMENT=24 ;

#
# Dumping data for table `forum_moderator`
#

INSERT INTO `forum_moderator` (`MOD_ID`, `FORUM_ID`, `MEMBER_ID`, `MOD_TYPE`) VALUES (23, 3, 8, 0),
(22, 3, 3, 0),
(21, 3, 7, 0),
(20, 3, 6, 0),
(19, 3, 9, 0),
(18, 2, 8, 0),
(17, 2, 3, 0),
(16, 2, 7, 0),
(15, 2, 6, 0),
(14, 2, 9, 0);

# --------------------------------------------------------

#
# Table structure for table `forum_namefilter`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_namefilter`;
CREATE TABLE `forum_namefilter` (
  `N_ID` int(11) NOT NULL auto_increment,
  `N_NAME` varchar(75) default NULL,
  PRIMARY KEY  (`N_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `forum_namefilter`
#


# --------------------------------------------------------

#
# Table structure for table `forum_reply`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Mar 09, 2004 at 06:16 PM
#

DROP TABLE IF EXISTS `forum_reply`;
CREATE TABLE `forum_reply` (
  `CAT_ID` int(11) NOT NULL default '1',
  `FORUM_ID` int(11) NOT NULL default '1',
  `TOPIC_ID` int(11) NOT NULL default '1',
  `REPLY_ID` int(11) NOT NULL auto_increment,
  `R_MAIL` smallint(6) default '0',
  `R_AUTHOR` int(11) default '1',
  `R_MESSAGE` text,
  `R_DATE` varchar(14) default '',
  `R_IP` varchar(15) default '000.000.000.000',
  `R_STATUS` smallint(6) default '0',
  `R_LAST_EDIT` varchar(14) default NULL,
  `R_LAST_EDITBY` int(11) default NULL,
  `R_SIG` smallint(6) default '0',
  PRIMARY KEY  (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`,`REPLY_ID`),
  KEY `FORUM_REPLY_CATFORTOPREPL` (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`,`REPLY_ID`),
  KEY `FORUM_REPLY_REP_ID` (`REPLY_ID`),
  KEY `FORUM_REPLY_CAT_ID` (`CAT_ID`),
  KEY `FORUM_REPLY_FORUM_ID` (`FORUM_ID`),
  KEY `FORUM_REPLY_TOPIC_ID` (`TOPIC_ID`)
) TYPE=MyISAM AUTO_INCREMENT=11 ;

#
# Dumping data for table `forum_reply`
#

INSERT INTO `forum_reply` (`CAT_ID`, `FORUM_ID`, `TOPIC_ID`, `REPLY_ID`, `R_MAIL`, `R_AUTHOR`, `R_MESSAGE`, `R_DATE`, `R_IP`, `R_STATUS`, `R_LAST_EDIT`, `R_LAST_EDITBY`, `R_SIG`) VALUES (2, 3, 3, 1, 0, 7, 'Also, I think that before the final release, we need to make sure that the search only returns items "for sale". The public should never see items not for sale.\r\n\r\nA\r\n\r\n', '20040212102250', '24.93.96.98', 1, NULL, NULL, 1),
(2, 3, 5, 2, 0, 8, 'A couple of suggested fixes:\r\n\r\n(1) The price field in the database should have a fixed two decimal places\r\n(2) When registering, \'Sirname\' should be changed to \'Last Name\'\r\n(3) When registering, there are more required fields than indicated', '20040212140526', '24.160.171.235', 1, NULL, NULL, 1),
(2, 3, 5, 3, 0, 8, '(4) In admin section, make description textbox larger for easier viewing of full description while entry is made.', '20040213064058', '164.107.114.49', 1, NULL, NULL, 1),
(2, 3, 5, 4, 0, 8, '(5) Margaritas need to be provided at our next team meeting.', '20040213064438', '164.107.114.47', 1, NULL, NULL, 1),
(2, 3, 5, 5, 0, 3, '<blockquote id="quote"><font size="1" face="Arial, Helvetica, sans-serif" id="quote">quote:<hr height="1" noshade id="quote"><i>Originally posted by wolfycd</i>\r\n<br />(5) Margaritas need to be provided at our next team meeting.\r\n<hr height="1" noshade id="quote"></font id="quote"></blockquote id="quote">\r\n\r\nI agree... but matt, next time just edit your post and add the new items (4) & (5).  Or are you just trying to "pad your stats" and make your # of posts go up?[:)]   However, a To-Do/Wish list for the site (including forums) is very much needed.  Someone start one!  (I call, "not-it"!)', '20040213091126', '164.107.114.12', 1, NULL, NULL, 1),
(2, 3, 5, 6, 0, 7, '6) search and view inventory pages should allow item ordering by Category, Name, Qty, and Price.', '20040215113205', '24.93.96.98', 1, NULL, NULL, 1),
(2, 3, 5, 7, 0, 3, '<blockquote id="quote"><font size="1" face="Arial, Helvetica, sans-serif" id="quote">quote:<hr height="1" noshade id="quote"><i>Originally posted by Reolstan</i>\r\n<br />6) search and view inventory pages should allow item ordering by Category, Name, Qty, and Price.\r\n<hr height="1" noshade id="quote"></font id="quote"></blockquote id="quote">\r\n\r\nThis belongs under the topic "Necessary Fixes", which will be our new location for all fixes/improvements to be made before we go live.', '20040215125902', '24.160.180.74', 1, NULL, NULL, 1);

# --------------------------------------------------------

#
# Table structure for table `forum_subscriptions`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Feb 09, 2004 at 04:54 PM
#

DROP TABLE IF EXISTS `forum_subscriptions`;
CREATE TABLE `forum_subscriptions` (
  `SUBSCRIPTION_ID` int(11) NOT NULL auto_increment,
  `MEMBER_ID` int(11) NOT NULL default '0',
  `CAT_ID` int(11) NOT NULL default '0',
  `TOPIC_ID` int(11) NOT NULL default '0',
  `FORUM_ID` int(11) NOT NULL default '0',
  KEY `FORUM_SUBSCRIPTIONS_SUB_ID` (`SUBSCRIPTION_ID`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `forum_subscriptions`
#


# --------------------------------------------------------

#
# Table structure for table `forum_topics`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Mar 09, 2004 at 06:16 PM
#

DROP TABLE IF EXISTS `forum_topics`;
CREATE TABLE `forum_topics` (
  `CAT_ID` int(11) NOT NULL default '1',
  `FORUM_ID` int(11) NOT NULL default '1',
  `TOPIC_ID` int(11) NOT NULL auto_increment,
  `T_STATUS` smallint(6) default '1',
  `T_MAIL` smallint(6) default '0',
  `T_SUBJECT` varchar(100) default '',
  `T_MESSAGE` text,
  `T_AUTHOR` int(11) default '1',
  `T_REPLIES` int(11) default '0',
  `T_UREPLIES` int(11) default '0',
  `T_VIEW_COUNT` int(11) default '0',
  `T_LAST_POST` varchar(14) default '',
  `T_DATE` varchar(14) default '',
  `T_LAST_POSTER` int(11) default '1',
  `T_IP` varchar(15) default '000.000.000.000',
  `T_LAST_POST_AUTHOR` int(11) default '1',
  `T_LAST_POST_REPLY_ID` int(11) default '0',
  `T_ARCHIVE_FLAG` int(11) default '1',
  `T_LAST_EDIT` varchar(14) default NULL,
  `T_LAST_EDITBY` int(11) default NULL,
  `T_STICKY` smallint(6) default '0',
  `T_SIG` smallint(6) default '0',
  PRIMARY KEY  (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`),
  KEY `FORUM_TOPIC_CATFORTOP` (`CAT_ID`,`FORUM_ID`,`TOPIC_ID`),
  KEY `FORUM_TOPIC_CAT_ID` (`CAT_ID`),
  KEY `FORUM_TOPIC_FORUM_ID` (`FORUM_ID`),
  KEY `FORUM_TOPIC_TOPIC_ID` (`TOPIC_ID`)
) TYPE=MyISAM AUTO_INCREMENT=7 ;

#
# Dumping data for table `forum_topics`
#

INSERT INTO `forum_topics` (`CAT_ID`, `FORUM_ID`, `TOPIC_ID`, `T_STATUS`, `T_MAIL`, `T_SUBJECT`, `T_MESSAGE`, `T_AUTHOR`, `T_REPLIES`, `T_UREPLIES`, `T_VIEW_COUNT`, `T_LAST_POST`, `T_DATE`, `T_LAST_POSTER`, `T_IP`, `T_LAST_POST_AUTHOR`, `T_LAST_POST_REPLY_ID`, `T_ARCHIVE_FLAG`, `T_LAST_EDIT`, `T_LAST_EDITBY`, `T_STICKY`, `T_SIG`) VALUES (2, 2, 2, 1, 0, 'The forums are working...', 'Well, the forums are up and running, and now Justin and I are trying to customize/fix/prepare them for use.  We\'ve made the necessary changes to the database, Justin is working on getting the forums to accept, display, update, etc... our custom user info (address, zip, etc...) and I\'m trying to integrate our site security with the forums built-in security and login functions.  For updates, be sure and check [url]http://www.buckeyeboys.com/forum/viewforum.php?f=9[/url].', 3, 0, 0, 21, '20040210080415', '20040210080415', 1, '130.11.184.57', 3, 0, 1, NULL, NULL, 0, 1),
(2, 3, 3, 1, 0, 'Search Suggestions...', 'A few suggestions:\r\n1) after a user runs a search, keep their search terms in the search bar on the search_results page so they can modify their searches without having to remember exactly what they searched on\r\n\r\n2) after a user clicks on a particular item, how about putting a link back to the search results... kind of like ebay?\r\n\r\n3) is there a wildcard? if so what is it?  how about a short explanation of how the search works (can booleans be used in the search... AND, NOT, OR, LIKE....)?', 3, 1, 0, 23, '20040212102250', '20040212054654', 1, '130.11.184.57', 7, 1, 1, NULL, NULL, 0, 1),
(2, 3, 4, 1, 0, 'Client Meeting Notes 2/12/04', 'Ok Everyone- \r\nI talked to mark today about the website, and got him started on playing around with the admin site/entering new items and everything else. Here\'s some ideas he had that we could kick around:\r\n\r\n1) FTP for image transfer might be too complex. I set his FTP client to connect to the appropriate folders on both his PC and our server, but he thought an upload utility would be helpful. I know we talked a bit about this and were having problems with the uplaod utility, but this might be something to address later.\r\n\r\n2) Mark sells a lot of items at shows and public events ( as well as ebay) and wanted to know if there was an easy way to disable the "for sale" bit for a number of items at a given time. Ex: He goes to a show and takes item x,y,z with him - rather than editing all three items individually, could we do something to let him just "uncheck" those items and disable the for sale status from a list of inventory items?\r\n\r\n3) Mark also was hoping to use the system to track where he sold some of his inventory. Since most of it is qty=1 & when he sells it, there is no more stock, he was curious to see if we could add something that keeps track of where an item was sold ( ebay, fair, antique show) and how much it was sold for (final sale price).\r\n\r\n4) He liked the "safety measures" we used - delete verification & restore function. Good job Justin.\r\n\r\nAgain, these are all just some thoughts he had while looking at the site. I asked him to play around & enter some real data into the DB, and let me know if there was anything else he ran into that was confusing or could be better, so hopefully we can get more feedback soon.\r\n\r\nA\r\n', 7, 0, 0, 15, '20040212101944', '20040212101944', 1, '24.93.96.98', 7, 0, 1, NULL, NULL, 0, 1),
(2, 3, 5, 0, 0, 'Misc Suggestions', 'Contact info for the contact page should be:\r\n\r\nDeVine Enterprises\r\nPO Box 14357\r\nColumbus, Ohio 43214\r\n614-846-1617\r\n\r\nemail: bcdevine@sbcglobal.net', 7, 6, 0, 43, '20040215125902', '20040212102529', 1, '24.93.96.98', 3, 7, 1, '20040212102551', 7, 0, 1);

# --------------------------------------------------------

#
# Table structure for table `forum_totals`
#
# Creation: Feb 09, 2004 at 04:54 PM
# Last update: Mar 09, 2004 at 06:16 PM
#

DROP TABLE IF EXISTS `forum_totals`;
CREATE TABLE `forum_totals` (
  `COUNT_ID` smallint(6) NOT NULL auto_increment,
  `P_COUNT` int(11) default '0',
  `T_COUNT` int(11) default '0',
  `P_A_COUNT` int(11) default '0',
  `T_A_COUNT` int(11) default '0',
  `U_COUNT` int(11) default '0',
  PRIMARY KEY  (`COUNT_ID`),
  KEY `FORUM_TOTALS_COUNT_ID` (`COUNT_ID`)
) TYPE=MyISAM AUTO_INCREMENT=2 ;

#
# Dumping data for table `forum_totals`
#

INSERT INTO `forum_totals` (`COUNT_ID`, `P_COUNT`, `T_COUNT`, `P_A_COUNT`, `T_A_COUNT`, `U_COUNT`) VALUES (1, 11, 4, 0, 0, 12);

# --------------------------------------------------------

#
# Table structure for table `item_class`
#
# Creation: Feb 12, 2004 at 02:52 PM
# Last update: Mar 07, 2004 at 02:15 PM
#

DROP TABLE IF EXISTS `item_class`;
CREATE TABLE `item_class` (
  `class_id` bigint(20) NOT NULL auto_increment,
  `class_name` varchar(40) NOT NULL default '',
  PRIMARY KEY  (`class_id`),
  UNIQUE KEY `class_name` (`class_name`)
) TYPE=MyISAM COMMENT='Item Classes' AUTO_INCREMENT=30 ;

#
# Dumping data for table `item_class`
#

INSERT INTO `item_class` (`class_id`, `class_name`) VALUES (1, 'Firefighting: Tools'),
(2, 'Firefighting: Trumpets'),
(3, 'Firefighting: Alarms'),
(4, 'Tools'),
(5, 'Firefighting: Lanterns'),
(6, 'Firefighting: Buckets'),
(7, 'Lanterns: Misc.'),
(8, 'Firefighting: Fire Marks'),
(9, 'Firefighting: Bells & Sirens'),
(10, 'Firefighting: Misc.'),
(12, 'Lighting: Misc.'),
(13, 'Collectables: Advertisement'),
(14, 'Collectables: Misc.'),
(15, 'Lanterns: Dietz'),
(16, 'Firefighting: Extinguishers'),
(17, 'Lanterns: CT Ham'),
(18, 'Firefighting: Books'),
(19, 'Firefighting: Seagrave'),
(20, 'Firefighting: Insurance'),
(21, 'Firefighting: Grenades'),
(22, 'Firefighting: Literature'),
(23, 'Firefighting: Helmets'),
(24, 'Firefighting: Nozzles'),
(25, 'Firefighting: Gamewell'),
(26, 'Firefighting: Advertising'),
(27, 'Automobile: Literature'),
(28, 'Columbus: Ohio State'),
(29, 'Columbus: Advertisement');

# --------------------------------------------------------

#
# Table structure for table `item_pictures`
#
# Creation: Feb 16, 2004 at 11:30 AM
# Last update: Mar 07, 2004 at 03:46 PM
# Last check: Feb 16, 2004 at 11:30 AM
#

DROP TABLE IF EXISTS `item_pictures`;
CREATE TABLE `item_pictures` (
  `file_name` varchar(50) NOT NULL default '',
  `item_id` bigint(20) NOT NULL default '0',
  `primary_picture` smallint(6) NOT NULL default '0',
  PRIMARY KEY  (`file_name`,`item_id`),
  KEY `file_name` (`file_name`),
  KEY `item_id` (`item_id`)
) TYPE=MyISAM COMMENT='Item Picture Links';

#
# RELATIONS FOR TABLE `item_pictures`:
#   `item_id`
#       `items` -> `item_id`
#

#
# Dumping data for table `item_pictures`
#

INSERT INTO `item_pictures` (`file_name`, `item_id`, `primary_picture`) VALUES ('P1010613.JPG', 14, 1),
('P1010633.JPG', 15, 1),
('P1010161.JPG', 16, 1),
('P1010634.JPG', 17, 1),
('P1010168.JPG', 19, 1),
('P1010635.JPG', 21, 1),
('P1010164.JPG', 23, 1),
('P1010165.JPG', 33, 1),
('P1010632.JPG', 18, 1),
('P1010629.JPG', 35, 1),
('P1010628.JPG', 44, 1),
('P1010626.JPG', 51, 1),
('P1010625.JPG', 56, 1),
('P1010615.JPG', 72, 1),
('P1010162.JPG', 16, 0),
('P1010163.JPG', 16, 0),
('P1010630.JPG', 35, 0),
('P1010167.JPG', 19, 0),
('P1010166.JPG', 19, 0),
('P1010617.JPG', 72, 0),
('P1010616.JPG', 72, 0),
('P1010618.JPG', 72, 0),
('P2240554.JPG', 91, 1),
('P1010624.JPG', 92, 1),
('P1010619.JPG', 93, 1),
('P1010620.JPG', 93, 0),
('P1010621.JPG', 93, 0),
('P1010622.JPG', 94, 1),
('P1010623.JPG', 94, 0),
('P2220206.JPG', 95, 1),
('P2220204.JPG', 96, 1),
('P2220205.JPG', 97, 1),
('P2220554.JPG', 98, 1),
('P2220211.JPG', 99, 1),
('P2220200.JPG', 100, 1),
('P2220203.JPG', 101, 1),
('P2220202.JPG', 102, 1),
('P2220169.JPG', 26, 1),
('P2220641.JPG', 13, 1),
('P2230649.JPG', 90, 1),
('P2220642.JPG', 10, 1),
('P2220632.JPG', 70, 1),
('P2220633.JPG', 70, 0),
('P2220584.JPG', 47, 1),
('P2220585.JPG', 47, 0),
('P2220628.JPG', 69, 1),
('P2220629.JPG', 69, 0),
('P2220630.JPG', 69, 0),
('P2220631.JPG', 69, 0),
('P2220221.JPG', 78, 1),
('P2230653.JPG', 49, 1),
('P2230652.JPG', 49, 0),
('P2220185.JPG', 25, 1),
('P2220187.JPG', 25, 0),
('P2220634.JPG', 63, 1),
('P2220635.JPG', 63, 0),
('P2230651.JPG', 12, 1),
('P2230650.JPG', 12, 0),
('P2220627.JPG', 71, 1),
('P2220626.JPG', 67, 1),
('P2220606.JPG', 43, 1),
('P2220605.JPG', 43, 0),
('P2230655.JPG', 11, 1),
('P2220586.JPG', 46, 1),
('P2220233.JPG', 84, 1),
('P2220553.JPG', 84, 0),
('P2220181.JPG', 30, 1),
('P2220179.JPG', 31, 1),
('P2220570.JPG', 87, 1),
('P2220624.JPG', 66, 1),
('P2230654.JPG', 1, 1),
('P2220609.JPG', 58, 1),
('P2220625.JPG', 65, 1),
('P2220588.JPG', 38, 1),
('P2220592.JPG', 37, 1),
('P2220593.JPG', 37, 0),
('P2220594.JPG', 37, 0),
('P2220595.JPG', 36, 1),
('P2220596.JPG', 36, 0),
('P2220600.JPG', 36, 0),
('P2220578.JPG', 53, 1),
('P2220579.JPG', 53, 0),
('P2220580.JPG', 53, 0),
('P2220220.JPG', 89, 1),
('P2220567.JPG', 83, 1),
('P2220215.JPG', 73, 1),
('P2220214.JPG', 74, 1),
('P2220556.JPG', 77, 1),
('P2220231.JPG', 82, 1),
('P2220582.JPG', 48, 1),
('P2220173.JPG', 27, 1),
('P2220583.JPG', 45, 1),
('P2220601.JPG', 41, 1),
('P2220602.JPG', 41, 0),
('P2220587.JPG', 50, 1),
('P2220612.JPG', 60, 1),
('P2220613.JPG', 59, 1),
('P2220614.JPG', 61, 1),
('P2220615.JPG', 61, 0),
('P2220610.JPG', 62, 1),
('P2220611.JPG', 62, 0),
('P2220603.JPG', 40, 1),
('P2220604.JPG', 40, 0),
('P2220573.JPG', 54, 1),
('P2220574.JPG', 54, 0),
('P2220575.JPG', 54, 0),
('P2220576.JPG', 54, 0),
('P2220577.JPG', 54, 0),
('P2220228.JPG', 81, 1),
('P2220229.JPG', 81, 0),
('P2220217.JPG', 75, 1),
('P2220227.JPG', 80, 1),
('P2220572.JPG', 52, 1),
('P2220222.JPG', 79, 1),
('P2220224.JPG', 79, 0),
('P2220569.JPG', 86, 1),
('P2220568.JPG', 85, 1),
('P2220213.JPG', 76, 1),
('P2220571.JPG', 88, 1),
('P2220616.JPG', 64, 1),
('P2220581.JPG', 55, 1),
('P2220170.JPG', 29, 1),
('P2220589.JPG', 39, 1),
('P2220590.JPG', 39, 0),
('P2220591.JPG', 39, 0),
('P2220607.JPG', 42, 1),
('P2220608.JPG', 42, 0),
('P2220617.JPG', 68, 1),
('P2220618.JPG', 68, 0),
('P2220619.JPG', 68, 0),
('P2220193.JPG', 34, 1),
('P2220188.JPG', 24, 1),
('P2220189.JPG', 24, 0),
('P2220190.JPG', 24, 0),
('P2220191.JPG', 24, 0),
('P2220192.JPG', 24, 0),
('P2220182.JPG', 22, 1),
('P2220183.JPG', 22, 0),
('P2220184.JPG', 22, 0),
('P2220174.JPG', 32, 1),
('P2220175.JPG', 32, 0),
('P2220176.JPG', 32, 0),
('P2220177.JPG', 32, 0),
('P2220178.JPG', 32, 0),
('P2220195.JPG', 20, 1),
('P2220194.JPG', 20, 0),
('P2220172.JPG', 28, 1),
('P2220620.JPG', 57, 1),
('P2220621.JPG', 57, 0),
('P2220622.JPG', 57, 0),
('P2220199.JPG', 104, 1),
('P2220198.JPG', 105, 1),
('P2220201.JPG', 106, 1),
('P2220197.JPG', 107, 1),
('P2240575.JPG', 108, 1),
('P2240555.JPG', 109, 1),
('P2240557.JPG', 109, 0),
('P2240560.JPG', 110, 1),
('P2240561.JPG', 111, 1),
('P2240562.JPG', 112, 1),
('P2240563.JPG', 113, 1),
('P2240565.JPG', 113, 0),
('P2240564.JPG', 113, 0),
('P2240570.JPG', 115, 1),
('P2240571.JPG', 116, 1),
('P2240572.JPG', 117, 1),
('P2240573.JPG', 118, 1),
('P2240574.JPG', 119, 1),
('P2240553.JPG', 120, 1),
('P2220232.JPG', 121, 1),
('P2220559.JPG', 123, 1),
('P2220558.JPG', 123, 0),
('P2220562.JPG', 124, 1),
('P2220564.JPG', 125, 1),
('P2220563.JPG', 126, 1),
('P2220565.JPG', 127, 1),
('P2220566.JPG', 128, 1),
('P2220636.JPG', 129, 1),
('P2220638.JPG', 129, 0),
('P2220640.JPG', 130, 1),
('P2220218.JPG', 132, 1),
('P2220208.JPG', 133, 1);

# --------------------------------------------------------

#
# Table structure for table `items`
#
# Creation: Mar 07, 2004 at 06:33 PM
# Last update: Mar 07, 2004 at 06:33 PM
# Last check: Mar 07, 2004 at 06:33 PM
#

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `item_id` bigint(20) NOT NULL auto_increment,
  `item_name` varchar(60) NOT NULL default '',
  `class_id` bigint(20) NOT NULL default '0',
  `item_price` decimal(10,2) default NULL,
  `for_sale` char(3) NOT NULL default 'NO',
  `active` tinyint(4) NOT NULL default '0',
  `description` longtext NOT NULL,
  `quantity` int(10) unsigned NOT NULL default '1',
  `qty_pending` int(11) NOT NULL default '0',
  `purge_date` varchar(25) default NULL,
  PRIMARY KEY  (`item_id`),
  FULLTEXT KEY `description` (`description`)
) TYPE=MyISAM COMMENT='Item Information' AUTO_INCREMENT=134 ;

#
# RELATIONS FOR TABLE `items`:
#   `class_id`
#       `item_class` -> `class_id`
#

#
# Dumping data for table `items`
#

INSERT INTO `items` (`item_id`, `item_name`, `class_id`, `item_price`, `for_sale`, `active`, `description`, `quantity`, `qty_pending`, `purge_date`) VALUES (1, 'Bed Key', 1, '225.00', '1', 1, '1800`s firemens bed wrench use to take apart the bed so it could be removed from a burning house usually the occupants most valuable possesion.', 1, 0, NULL),
(2, 'Cairns Trumpet', 2, '750.00', '1', 1, '1800`s cairns octagon 3 band nickel plated brass working trumpet. The trumpet is marked cairns this is the tall one. These were used by chiefs to shout orders to the firemen. This trumpet has damage to the bell area looks to have been shoved down then straighten back out. A very heavy well built working trumpet.', 1, 0, NULL),
(3, 'Gamewell Vitaalarm', 3, '65.00', '1', 1, 'NOS(new old stock) gamewell fire alarm in original box with instructions. These were heat dectors: just screw them in a light socket and they had an audible as well as a visual alarm a great early item in mint condition.', 1, 0, NULL),
(4, 'Iron Wrench 3 Sided', 4, '19.95', '1', 1, 'Old iron wrench a bit rusty and "T" shaped.', 1, 0, NULL),
(5, 'Seagrave dietz king', 5, '675.00', '1', 1, 'great nickel plated brass dietz  fire king seagrave lantern 95% of the plating is still there. the lantern has the usual dents where the apparatus hook held it. It also has a dent in the tube where the bottom of the cage hits.a very nice named dietz king.', 1, 0, NULL),
(6, 'Early  Brass or Copper Fireman Trumpet', 2, '450.00', '1', 1, 'Early hand made copper or brass firemans trumpet. The trumpet is in "as found" condition; very dirty with black soot and grunge. May clean and polish up if that is what you like.', 1, 0, NULL),
(7, 'Early Leather Bucket', 6, '575.00', '1', 1, 'leather bucket marked H. henderson no 4 1833? it is about 15" tall 8" in diameter at the top.about 70% of the writing is still readable. The bucket is brown with yellow lettering. there are no holes, handle is there and attached.a great early bucket with great patina. These were kept by home owners to be use by the volunteers.', 1, 0, NULL),
(8, 'Hendrickson Marine Lantern', 7, '195.00', '1', 1, 'Large 20"x9" red A.Ward Hendrickson marine galvanized tin lantern. Has large  red fresnel globe (8"x 6 1/2")in good condition. The lantern has many coats of paint (red currently but has been orange) It has asturdy hanging handle on the top and four tie down rings on the bottom of the cage. It has a brass screw in fount with a P&A wickraiser. Weighs 20 lbs.', 1, 0, NULL),
(9, 'French Tin Fire Mark', 8, '45.00', '1', 1, 'French mutuelles A.I.M. Du Mans tin fire mark has four mounting holes in the corners. These were put on houses to indentify which houses were insured by the insurance owned fire companies.', 1, 0, NULL),
(10, '3 1/2" Muffin Bell', 9, '325.00', '1', 1, '3 1/2" brass muffin bell original turned wood handle works great very nice piece. These were used to alert the Volunteers that there was a fire.', 1, 0, NULL),
(11, 'Gutta Purcha fire theme photo case', 10, '250.00', '1', 1, '1800`s firemens photo case Has firefighter holding child on staircase plus firemans scramble in center. Both sides of case are the same. There is a generic tintipe of 2 children inside. Case displays well only flay is a small chip where the case snaps together.', 1, 0, NULL),
(12, 'Firefighter Rattle', 10, '125.00', '1', 1, 'Early double reed firemans wood rattle. Rattle has metal weighted end looks to be made of maple. 6" long good condition great early piece.', 1, 0, NULL),
(13, 'Street light with alarm box', 3, '95.00', '1', 1, '12" tall train set fire alarm street light with fire box and red lenses. turn the alarm box handle and the bell rings.powered by a D cell street sign reads Main & state St.made by theGong bell mfg. co. East Hampton Conn. These are a favorite of alarm box collectors.', 1, 0, NULL),
(14, 'Art Deco Fire Globe', 12, '75.00', '1', 1, 'European Art Deco frame shaped globe 8" tall by 5" in diameter.  This would look great on a wall light casting its glow over your fire fighting collection.', 1, 0, NULL),
(15, 'Early Open Flame Light', 12, '45.00', '1', 1, 'Brass wall mounted, open flame gas light.  It has been restored and mounted toan attractive oak plaque.  Great early lamp.', 1, 0, NULL),
(16, 'Hustler Magazine Advertisement', 13, '17.00', '1', 1, '1970`s Hustler Magazine was located in Columbus, Ohio.  This is a pair of plastic coasters and a drink glass from the night club which was located in the X-rated magazine headquarters.', 1, 0, NULL),
(17, 'Tin Fire Mark Ohio Farmers', 8, '35.00', '1', 1, 'Tin fire mark from Ohio Farmers Insurance Company has four mounting holes in each corner. 6 1/2" x 3 1/2".', 1, 0, NULL),
(18, 'Golden Rule Hazel Cream Bottle', 14, '9.99', '1', 1, 'Early bottle from The Citizens Wholesale Supply Co.  Columbus, Ohio.  Bottle has internal crack in neck.  6 1/2" x 2 3/4"', 1, 0, NULL),
(19, 'Dietz Lantern Phamplet', 15, '35.00', '1', 1, 'Four-fold pamphlet for Dietz lanterns in excellent shape.  Folded, it is 5” x 8” open it is 18 1/2” x 8” two sided.  Shows 30 of their products.', 1, 0, NULL),
(20, 'Dietz Marine Deck Lantern', 15, '275.00', '1', 1, 'Nickel-plated tin Dietz Marine Deck Lantern.  Has tie downs on the bell, and has original globe, excellent condition, plating in 100% excellent.  All there, all working.', 1, 0, NULL),
(21, 'Red Comet CTC Extingusiher', 1, '65.00', '1', 1, 'Red Comet Automatic Carbon TET Extinguisher.  These Hung from the ceiling and a fusible link would melt causing a spring-loaded pin to puncture the glass globe and spray the CTC, therefore smothering the fire.', 1, 0, NULL),
(22, 'Ham Nu-Style Lanern', 17, '75.00', '1', 1, 'Ham’s Nu-Style Lantern with red globe that was manufactured between 1912-1914.  After Dietz purchased CT Ham Co. this became the Dietz “D-Lite.” This lantern is listed is listed as rare by Anthony Hobson.  Lantern has dent in fount, otherwise lantern is in good condition.', 1, 0, NULL),
(23, 'CTC Fire Extinguisher', 16, '45.00', '1', 1, 'Automatic Carbon TET Extinguisher.  These Hung from the ceiling and a fusible link would melt causing a spring-loaded pin to puncture the glass globe and spray the CTC, therefore smothering the fire.', 1, 0, NULL),
(24, 'CT Ham #2 Cold Blast Milk Wagon', 17, '125.00', '1', 1, '#2 Cold Blast Milk Wagon.  This is one of largest and few Cold Blast lanterns that Ham made. What makes this lantern unique is that it has a tray under the font to catch any spilled fuel.  These were used on milk wagons and on milk houses. Has a marked Ham’s Cold Blast Globe that stands 15” tall, painted black, excellent condition.', 1, 0, NULL),
(25, 'Fire Theme Ice Bucket', 10, '20.00', '1', 1, 'Fire Theme Ice Bucket colors are almond and black.  It has pictures of fire marks, horse drawn steamer, and fire chief with trumpet.  Excellent condition.', 1, 0, NULL),
(26, 'Brass & Glass Sprayer', 14, '35.00', '1', 1, 'Ball jar brass sprayer made by the H. B. Hudson Co. Chicago, IL. Glass jar has a blue tint about quart size, excellent condition.', 1, 0, NULL),
(27, 'Enjine! - Enjine! 1939', 18, '35.00', '1', 1, 'Enjine! - Enjine! 1939 – A story of fire protection.  Published by Harold Vincent Smith for the Home Insurance Company, New York, NY.  This book has lots of pictures of early firefighting collectables.  A great resource for your fire collection, many pictures are in color.  This book does have a water stain at the binding, but does not obstruct the quality of the pictures.', 1, 0, NULL),
(28, 'Sears Catalogue Page for Dietz Lanterns', 15, '15.00', '1', 1, 'Early Sears, Roebuck Catalogue number 112 advertising Dietz Lanterns.  There are 20 lanterns on this page.  Page in excellent condition.', 1, 0, NULL),
(29, '1940`s Seagrave Aerial Ladder Photo', 19, '15.00', '1', 1, '1940`s Seagrave Aerial Ladder Photo: 20” x 5 1/2” factory drawing in color of a 1940’s Seagrave tillered ladder, does have water stains, mounted on a wood backing.', 1, 0, NULL),
(30, 'Texaco Fire Chief Bakelite Scotty Dog', 10, '45.00', '1', 1, 'Texaco Fire Chief Bakelite Scotty Dog was a 50th anniversary give away by the Texaco in 1952.  It is the official Bakelite Texaco Scottie Dog service station manager pin.  This is still mounted to the original cardboard holder.', 1, 0, NULL),
(31, 'Texaco Fire Chief Glass Pump Sign', 10, '45.00', '1', 1, 'Texaco Fire Chief Glass Pump Sign: 10” x 3 ½” slightly curved Fire Chief sign.  This would be a great wall hanging or desk sign for the office, excellent condition.', 1, 0, NULL),
(32, 'Dietz Flash Light Police Lantern', 15, '100.00', '1', 1, 'Dietz Flash Light Police Lantern – has a 2 3/4” lens, 8” tall, made prior to 1894, font is intact, everything is working, lantern is in excellent condition.  Has carrying handles and belt clip on the rear, marked Dietz flashlight police lantern.', 1, 0, NULL),
(33, 'CTC Fire Extinguisher', 16, '25.00', '1', 1, 'CTC Fire Extinguisher: Wall mounted carbon TET extinguisher.  These were wall-mounted holders to enable the occupant to throw it at the fire.', 1, 0, NULL),
(34, 'Tin Box Lantern', 7, '10.00', '1', 1, 'Tin Box Lantern: Tin is painted red, lantern is 8” tall 4” square with carrying handle works fine, like new condition.', 1, 0, NULL),
(35, 'Firemen`s Insurance Co. Sign', 20, '175.00', '1', 1, 'Firemen`s Insurance Co. Sign: An early metal fire insurance sign from Firemen`s Insurance Co. of Newark, NJ.  Has a great graphic of fire fighter on ladder with hose in hand fighting a building fire. 20” x 14”', 1, 0, NULL),
(36, 'Brass Working Trumpet 17"', 2, '335.00', '1', 1, 'Brass Working Trumpet: Early brass working trumpet, made by the P. Frederick Co. in Philadelphia, PA.  This trumpet is 17” tall with a 7” bell, single sash loop with red sash.  It has customary nicks and dents, a great fireman’s working trumpet.', 1, 0, NULL),
(37, 'Brass Working Trumpet 15 1/2"', 2, '425.00', '1', 1, 'Brass Working Trumpet 15 1/2": Early fire chief’s working trumpet, two band with sash holders, has been heavily used with lots of dents, but has great patina.  A great early fire fighters collectable.', 1, 0, NULL),
(38, 'Brass Speaking Trumpet 15"', 2, '125.00', '1', 1, 'Brass Speaking Trumpet 15" with a 6” bell end.  All brass rolled joints with carrying handle. May be fire department or early sports megaphone. Excellent condition.', 1, 0, NULL),
(39, 'Grether Battery Lantern', 19, '295.00', '1', 1, 'Grether Battery Lantern: marked Seagrave with original leather strap and mounting bracket. Silver in color, these were used in the 20`s and 30`s. Excellent condition.', 2, 0, NULL),
(40, 'Hardens Glass Hand Fire Grenade', 21, '175.00', '1', 1, 'Hardens Glass Hand Fire Grenade. Grenade is blue with original stopper and contents.  Is in excellent shape. Patented August 8, 1871, marked number 1. This would be a great addition to your fire collection, and a great conversation piece.', 2, 0, NULL),
(41, 'CTC Extinguisher Marked C&O Railroad', 16, '75.00', '1', 1, 'CTC Extinguisher Marked C & O Railroad brass General Quick Aid, CTC pump fire extinguisher 17” tall with the handle. It is empty, few minor dents, this is a rare marked extinguisher.', 1, 0, NULL),
(42, 'Dark Room Lantern', 7, '55.00', '1', 1, 'Early Dark Room Lantern, made by Rochester Optical Co. Rochester, NY, No. 3 Universal.  The size is 10” x 5”. It is all there and working, except for the red glass in the front. A large early tin dark room lantern.', 1, 0, NULL),
(43, 'Forest Fire Motion Light by Econolite', 10, '125.00', '1', 1, 'Forest Fire Motion Light by Econolite is in working condition, has some minor dents to the outside plastic shell that do not distract from its operation or viewing.  It has pictures of deer startled by a raging forest fire.', 1, 0, NULL),
(44, 'Westminster Fire Ins. Sign', 20, '75.00', '1', 1, 'Westminster Fire Office of London England Head office for Canada – Montreal.  Metal sign with their logo in the middle. Established 1717.  Nice sign framed 19 1/2" x 11 1/4", has original paper backing.', 1, 0, NULL),
(45, 'ALT CTC Fire Extinguisher', 16, '39.00', '1', 1, 'ALT CTC Fire Extinguisher, this is a plastic cased CTC grenade designed to hang from the ceiling.  It has an automatic fusible link designed to melt in the heat of the fire and a spring loaded pin breaks the glass grenade releasing the CTC as a spray and smothers the fire. Good condition, nice addition to your fire collection. ', 1, 0, NULL),
(46, 'Kids Siren Whistle', 10, '2.00', '1', 1, 'Kids Early Siren Whistle, not recommended for children under 8 years of age.  These are worn like a ring and blow through them to emit a siren like sound. New!', 40, 0, NULL),
(47, 'Leather Fire Bucket', 6, '55.00', '1', 1, 'Leather Fire Bucket that is 10” x 9” very early fire bucket in very poor shape.  No handle, hole in the bottom, top ring is loose, was painted but cannot be make out. ', 1, 0, NULL),
(48, 'American Rubber Firefighting Supplies', 18, '75.00', '1', 1, 'Reproduction American Rubber Mfg. Co. Fire Hose and Supplies Book.  It has 120 pages, 7” x 5”.  A great resource for early (pre 1900) firefighting supplies.  This was copied from the original catalogue on glossy paper, spiral bound, in excellent condition.', 1, 0, NULL),
(49, 'Dietz Fire King', 5, '175.00', '1', 1, 'Dietz Fire King Lantern with copper bottom, nickel plated tin top, has a few rust holes in the lower tubes and burner skirt, but has been polished and displays well.  It also has marked Diets fits all globe; everything is there and working.', 1, 0, NULL),
(50, 'Fire Ball Christmas Tree Ext.', 16, '25.00', '1', 1, 'Fire Ball Christmas tree Extinguisher were mounted on Christmas trees and filled with water.  They had an automatic spring-loaded fusible link, which released by the heat of the fire smashing the glass globe releasing the water.  Made by Fire Ball Inc. Philadelphia, PA.', 1, 0, NULL),
(51, 'Metal Burger Beer Sign', 13, '75.00', '1', 1, 'Burger Beer Metal Sign with portrait of a sexy lady inscription “Tempting”  from a Burger Beer in Cincinnati, Ohio.  The size is 24 1/2” x 16 1/2”, condition is fair.', 1, 0, NULL),
(52, 'Midland Mutual Fire Insurance Co. Sign', 20, '65.00', '1', 1, 'Midland Mutual Fire Insurance Co. Sign is 21 1/2” x 14 1/2” wood framed brass sign.  That reads “The Midland Mutual Incorporated 1880 Fire Insurance Company Newton, Kans.” ', 1, 0, NULL),
(53, 'Tole Firefighting Trumpet 20 1/2"', 2, '425.00', '1', 1, 'Tole Firefighting Trumpet 20 1/2".  This is a very early firefighting trumpet, appears to have been repainted, but still has traces of old red paint on the inside.  It has a few minor dents, but overall a great trumpet.', 1, 0, NULL),
(54, 'Cairns Leather High Eagle Fire Helmet', 23, '435.00', '1', 1, 'Cairns Leather High Eagle Fire Helmet with metal No. 9 high eagle front.  It has “Chief Wiener” written on the back brim.  It is in overall good condition, but is missing the liner.  It has a sort of reddish-brown color.', 1, 0, NULL),
(55, '30" Underwriter`s Nozzle', 24, '85.00', '1', 1, '30" Underwriter`s Nozzle.  This is a rope wound copper straight stream firefighters nozzle.  It was used mostly by fire brigades and factories and was made by Wooster Brass Co.', 2, 0, NULL),
(56, 'Reverse Painted Glass Hartford Fire Ins.', 20, '75.00', '1', 1, 'Hartford Stag Fire Insurance Co. Reverse Painted glass Sign from Hartford Connecticut.  The size is 17” x 12”, excellent condition.', 1, 0, NULL),
(57, 'White Star Tin Dead Flame Lantern', 12, '175.00', '1', 1, 'White Star Tin Dead Flame Lantern - 1800`s lantern with drop out font, globe is clear and unmarked.  The lantern is marked “White Star.”  I do not know if that is the White Star that owned the Titanic Cruse Ship.  Lantern is in overall OK condition.', 1, 0, NULL),
(58, 'Short Viking Axe', 1, '125.00', '1', 1, 'Short Viking Axe – 20” long with a 10” head, which is made of aluminum.  It has a curved wood handle.  I would assume this is a parade piece.', 1, 0, NULL),
(59, 'Liberty Tin Tube Fire Ext.', 16, '38.00', '1', 1, 'Liberty Tin Tube Fire Extinguisher – The size is 22” x 2”, extinguisher is full of dry powder.  These were hung on a hook to be jerked off the hook thus pulling the lid off and the powder was then flung at the fire there by smothering it. It has the usual dents, but is readable.', 1, 0, NULL),
(60, 'Instantaneous Tin Tube', 16, '22.00', '1', 1, 'Instantaneous Tin Tube Fire Extinguisher – The size is 22” x 2”, extinguisher is full of dry powder.  These were hung on a hook to be jerked off the hook thus pulling the lid off and the powder was then flung at the fire there by smothering it. It has the usual dents, and is barely readable.', 1, 0, NULL),
(61, 'Liberty Tin Tube Fire Ext. NOS', 16, '65.00', '1', 1, 'Liberty Tin Tube Fire Extinguisher NOS – The size is 22” x 2”, extinguisher is full of dry powder.  These were hung on a hook to be jerked off the hook thus pulling the lid off and the powder was then flung at the fire there by smothering it. It has a few minor scratches, otherwise in like new condition in its original holder.', 1, 0, NULL),
(62, 'Gamewell Battery Jar', 25, '75.00', '1', 1, 'Gamewell Battery Jar – The size is 6 1/2” x 5 1/2”.  I believe this is the middle sized jar, not the common small jar.  This is in excellent condition and is marked Gamewell on both sides.', 1, 0, NULL),
(63, 'Fire Truck Liquor Decanter', 10, '40.00', '1', 1, 'Fire Truck Liquor Decanter – “Spirit of 76” and “Mooseheart F.D” written on the side and the hood. Unfortunately it is empty, but in excellent condition.', 1, 0, NULL),
(64, 'Thermometer Merchants Fire Ins. Co.', 20, '60.00', '1', 1, 'Thermometer Merchants Fire Insurance Company – The size is 9” diameter, it is a working thermometer tym·Adoes have a few chips in the glass, and is water stained.  This is from Denver Colorado.', 1, 0, NULL),
(65, 'Sutphen Pump Gauge', 1, '25.00', '1', 1, 'Sutphen Pump Gauge – The size is 4 1/4” in diameter.  Reads from –30 to 600 psi, chrome plated for panel mounting.', 1, 0, NULL),
(66, 'Volunteer Firefighter Car Tag', 10, '20.00', '1', 1, 'Volunteer Firefighter Car Tag marked “Volunteer FD Member”, it is 3 3/4” square.', 1, 0, NULL),
(67, 'Firefighters Shaving Mug', 10, '55.00', '1', 1, 'Firefighters Shaving Mug has a picture what appears to be a horse drawn wagon with four firefighters wearing their high eagle helmets.  The cup has gold trim, is in excellent condition, and is unmarked.', 1, 0, NULL),
(68, 'Large Flashlight Lantern 7 1/2" Tall', 7, '85.00', '1', 1, 'Large Flashlight Lantern – The size is 7 1/2" x 4” with a 3 1/4” lens.  Overall in good condition, everything is there and working.  Has early whale oil burner, and has carrying handles and belt clip.  This is a larger and heavier police style flashlight lantern.', 1, 0, NULL),
(69, 'Leather Fire Bucket 11"', 6, '425.00', '1', 1, 'Leather Fire Bucket – The size is 11" tall and 8 1/2” in diameter.  The bucket is marked “J. Averell.”  The handle is attached.  This bucket is in Excellent condition, one of the nicer buckets I have owned.', 1, 0, NULL),
(70, 'Ladder Rubber Coated Canvas Bucket', 6, '200.00', '1', 1, 'Ladder Rubber Coated Canvas Bucket – The size is 12” tall by 10” in diameter.  These were normally carried on the side of the ladder trucks and used by the firefighters.  This bucket is in good condition; some of the rubber has worn off, especially on the handle.  The handle is attached and would be a nice addition to your fire collection.', 1, 0, NULL),
(71, 'Firefighters Mustache Cup', 10, '55.00', '1', 1, 'Firefighters Mustache Cup – This has a fire panoply helmet, trumpet, Viking axe.  Cup is marked “Royal Crown 2804.”', 1, 0, NULL),
(72, 'Early Tin Box Lantern', 7, '75.00', '1', 1, 'Early Tin Box Lantern: A tin Box Lantern with drop out fount.  Has carrying handles on back, and a metal reflector.  The back opens to light.  It does have surface rust and pitting, but is still useable.  The size is 12” tall by 5 1/4” square.  Lantern is unmarked.', 1, 0, NULL),
(73, 'Dacron Fire Hose Deck of Cards', 26, '25.00', '1', 1, 'Dacron Fire Hose Deck of Cards – This is a sealed deck from a Dacron Polyester fiber fire hose company.  Depicts a chief with fire hose wrapped around him.', 1, 0, NULL),
(74, 'Eureka Fire Hose Paper Clip', 26, '60.00', '1', 1, 'Eureka Fire Hose Paper Clip – This is a metal paper clip depicting an eagle on top of a roll of fire hoses from the United States Rubber Co. ', 1, 0, NULL),
(75, 'German American Fire Ins. Paper Clip', 20, '25.00', '1', 1, 'German American Fire Insurance Paper Clip – This is a aluminum paper clip from the German American Fire Insurance Company of New York.', 1, 0, NULL),
(76, 'Paper Clip from London Assurance Corp.', 20, '35.00', '1', 1, 'Metal Paper Clip from London Assurance Corporation – This is a New York company established in 1720. ', 1, 0, NULL),
(77, 'Notebook Eureka Fire Hose', 26, '23.00', '1', 1, 'Notebook Eureka Fire Hose – This is a pocket-sized 1950ish notebook from the Eureka Fire Hose Company, New York.', 1, 0, NULL),
(78, 'Tin Fire Mark Continental Insurance', 8, '125.00', '1', 1, 'Tin Fire Mark Continental Insurance – The size is  7” x 3 1/4”.  It is inscribed Continental New York, in good condition.', 1, 0, NULL),
(79, 'National Fire Ins. Co. Letter Opener', 20, '48.00', '1', 1, 'National Fire Ins. Co. Letter Opener – The size is 9 1/2”, and is nickel plated brass marked “National Fire Insurance Co. of Hartford.” ', 1, 0, NULL),
(80, 'Lumbar Insurance Agency Letter Opener', 20, '30.00', '1', 1, 'Lumbar Insurance Agency Letter Opener – The size is 8 1/2”, copper, marked with “Lumber Insurance Agency Indianapolis, Ind. Fire – Automobile – Tornado.”', 1, 0, NULL),
(81, 'Firemans Ins. Co. Paperweight', 20, '35.00', '1', 1, 'Fireman`s Ins. Co. Paperweight – The size is 3” in diameter, brass paperweight, marked with “Founded 1855 Firemen`s Insurance Company of Newark New Jersey.”', 1, 0, NULL),
(82, 'Rhode Island Coupling Co. FD Supplies', 26, '35.00', '1', 1, 'Rhode Island Coupling Co. FD Supplies – The size is 6” x 3 1/2”, 15 pages of fire department supplies from Providence, RI.  Mostly hoses,  nozzles, and couplings.', 1, 0, NULL),
(83, 'Cracker Jack Fire Hose Rubber Axe', 26, '95.00', '1', 1, 'Cracker jack Fire Hose Rubber Axe – The size is 12” x 5”.  This is a advertisement piece from the American Rubber Manufacturing Company.', 1, 0, NULL),
(84, 'Sentinel First Aid Kit', 10, '10.00', '1', 1, 'Sentinel First Aid Kit – The size is 6” x 3 1/4” tin first aid kit. ', 1, 0, NULL),
(85, 'Niagara Porcelain Fire Insurance Sign', 20, '135.00', '1', 1, 'Niagara Porcelain Fire Insurance Sign – The size is 18” x 12”, white over blue, and inscribed “Established 1850 Niagara Fire Insurance company New York.”  This sign is in average condition with some serious chips around the edges.', 1, 0, NULL),
(86, 'Newark Fire Ins. Sign', 20, '75.00', '1', 1, 'Newark Fire Insurance Sign – Aluminum sign, size is 18” x 12”, inscribed ‘Newark Fire Insurance Co.  Newark, N.J. Western Department, Chicago”, plus logo.', 1, 0, NULL),
(87, 'Texaco Fire Chief Sign', 10, '35.00', '1', 1, 'Reproduction Texaco Fire Chief Sign – Porcelain over metal sign, size is 16” x 10 1/2”.  Very good condition dated 1986, small chip on lower right edge.', 1, 0, NULL),
(88, 'Shawnee Fire Ins. Sign', 20, '125.00', '1', 1, 'Shawnee Fire Insurance Sign – The size is 20” x 12” tin sign inscribed “Agency The Shawnee Fire Insurance Co. of Topeka Kansas.” ', 1, 0, NULL),
(89, 'Clipboard National Fire Group', 26, '30.00', '1', 1, 'Clipboard National Fire Group – The size is 7 1/4” x 4 1/2” brass clipboard, inscribed “The National Fire Group Western Department 50th Anniversary 1888-1938.”', 1, 0, NULL),
(90, 'Wood Gas Alarm', 3, '30.00', '1', 1, 'Wood Gas Alarm – The size is 11” x 8”.  This is a firefigher`s style clacker, it has a single read which is made of oak.  These were used in the mines to warn the miners that there was a gas accumulation. ', 1, 0, NULL),
(91, 'Sheet music Burning of Rome', 22, '15.00', '1', 1, '12" x 9" Burning of Rome Sheet musicby E.T. Paul 8 pages good condition nice fire graphic', 1, 0, NULL),
(92, 'Fire Sprinkler Head  Box', 10, '60.00', '1', 1, 'Fire Sprinkler Head  Box: Wall mounted fire sprinkler head box with six heads and wrench.  These were wall mounted in factories to replace fused heads.', 1, 0, NULL),
(93, 'No. 40 Dazey Churn', 14, '95.00', '1', 1, 'No. 40 Dazey Churn: 1 gallon size glass square Dazey churn with wood paddles.  Great condition! Works!  Nice item for that country kitchen.', 1, 0, NULL),
(94, 'Cairns Leather Fire Bucket', 6, '100.00', '1', 1, 'Cairns Leather Ice Bucket: These were made in the 1930`s as reproduction fire buckets by the helmet maker Cairns.  This is very useful as an ice bucket.  It has a picture of an early hand pumper.  This bucket has a brass phaque inscribed “R.R.C.C. Fall member-Member 1960” Nice Gift!', 1, 0, NULL),
(95, 'Oak Crucifix', 14, '25.00', '1', 1, 'Oak Crucifix with compartment for holy water bottle and candle.  The size is 16 1/2" x 10 1/2".', 1, 0, NULL),
(96, 'Walnut Crucifix', 14, '20.00', '1', 1, 'Walnut Crucifix with storage for candle and holy water bottle. The size is 12 1/2" x 7 1/2".', 1, 0, NULL),
(97, 'Crucifix Inlaid', 14, '20.00', '1', 1, 'Crucifix Inlaid: with storage for candle and holy water bottle. The size is 12 1/2" x 7 1/2".', 1, 0, NULL),
(98, 'Brass B&R Police and Fire Whistle', 10, '35.00', '1', 1, 'Nickel-plated brass B&R city police and fire whistle is 3 1/4" long. Works great!', 1, 0, NULL),
(99, 'Glass Fire Paperweight', 10, '35.00', '1', 1, 'Glass Fire Paperweight of the Senate House after the fire on February 2, 1897 in Harrisburg, PA.  This shows a crowd of people staring out the burned at senate house.  The size is 4” x 22 3/8”.', 1, 0, NULL),
(100, 'Leather Fire Insurance  Folder', 20, '25.00', '1', 1, 'Leather Fire Insurance Folder: Leather pouch that folds into thirds from Quincy Mutual Fire Insurance Company, Quincy Mass. The folded size is 8 1/2” x 4 1/4”.  The size laid out flat is 12” x 8 1/2”.  Good Shape!', 1, 0, NULL),
(101, 'Car & Driver Magazine Aug 1969', 27, '9.00', '1', 1, 'Car & Driver Magazine from August 1969 has articles on Dune buggies, motor sports and The Black Man, `69 Camaro, and Sunbeam Alpine GT.', 1, 0, NULL),
(102, 'Car & Driver Magazine July 1969', 27, '9.00', '1', 1, 'Car & Driver Magazine from July 1969 has articles on Car & Drier road tests, FIAT 124, Volvo 164 & SAAB 99.  Article on 1969 Blue Max Camaro.', 1, 0, NULL),
(103, '', 0, NULL, 'NO', 0, '', 1, 0, NULL),
(104, '1950 OSU vs. California Rose Bowl Pictorial', 28, '35.00', '1', 1, 'Here is the1950 Pasadena Tournament of Roses Pictorial.  This was published after the game that was won by OSU 17-14.  This has team pictures with head coach, Wesley Fesler, for OSU and Pappy Waldorf for California.  Also, it has many pictures of Rose Bowl Parade.  This contains 34 pages and is 11 3/4” x 8 3/4”.\r\n', 1, 0, NULL),
(105, 'Ohio State Yearbook Makio 1888', 28, '35.00', '1', 1, 'Ohio State Yearbook Makio 1888 has over 160 pages.', 1, 0, NULL),
(106, 'Leather Ohio State Graduation Program 1917', 28, '35.00', '1', 1, 'Leather Ohio State Graduation Program for the first week of June in 1917.  The size is 6 1/4” x 4 1/2”, has approximately 25 pages.  It lists all the programs for the week and all the grads by college.  In great condition!\r\n', 1, 0, NULL),
(107, 'Columbus Buggy Co. AD', 29, '15.00', '1', 1, 'This is a 15 page brochure for the Columbus Buggy Company, the largest in the world!  The size is 6” x 3”.  Great Condition!\r\n', 1, 0, NULL),
(108, 'American La France Fire Fighting Equipment Catalogue', 22, '55.00', '1', 1, 'American La France Fire Fighting Equipment Catalogue: The size is 9” x 6” with over 200 pages of firefighting equipment.  This was a processional re-copied and bound.  I would say about 1930`s, a great resource!\r\n', 1, 0, NULL),
(109, 'Brass Speaking Trumpet', 2, '75.00', '1', 1, 'Brass Speaking Trumpet: 18” brass trumpet with 4 1/2” bell.  It is missing the mouth piece, and is marked “My Captain GIG.”  Has some dents mostly on the bell end.', 1, 0, NULL),
(110, 'Firemen`s Ladder Bucket', 6, '225.00', '1', 1, 'Firemen’s Ladder Bucket: The size is 12 1/2” x 9 1/2”, rubber coated canvas ladder bucket with handle attached.  Bucket in great shape!  These were carried on the side of the ladder wagon. A very nice early bucket!', 1, 0, NULL),
(111, 'Fireman`s Ladder Bucket Marked L-1', 6, '275.00', '1', 1, 'Fireman`s Ladder Bucket Marked L-1: A 12 1/2” x 9” rubber coated canvas ladder bucket marked L-1.   These were carried on the side of the ladder wagon.  A very nice bucket to add to your collection.', 1, 0, NULL),
(112, 'Fireman`s Ladder Bucket Marked “E-Thompson”:', 6, '175.00', '1', 1, 'Fireman`s Ladder Bucket Marked “E-Thompson”: A 13” x 7” leather bucket green with gold lettering.  In good shape other than missing it’s handles and a nail hole in the bottom.  Would make a nice mantle piece.', 1, 0, NULL),
(113, 'Brass Police Flashlight Lantern', 7, '225.00', '1', 1, 'Brass Police Flashlight Lantern:  This is a 6 1/2” x 4 1/2” brass unmarked police or miners flashlight.  It has 3” fish eye lens carrying handles and belt clip.  It is in great condition and is a rare find in brass!', 1, 0, NULL),
(114, '1843 Leather Fire Bucket', 6, '525.00', '1', 1, '1843 Leather Fire Bucket: The size is 13” x 8” leather bucket that is green with gold lettering inscribed with “E. Gifford 1843 #1” These were required in every household.  During a fire they would be used by the bucket brigades and then thrown in a pile.  That is why they had their name on them.  A great early bucket with what looks like original paint.  It is missing the handle. ', 1, 0, NULL),
(115, 'The Hartford Fire Insurance Co. Sign', 20, '135.00', '1', 1, 'The Hartford Fire Insurance Co. Sign: The size is 18” x 12” aluminum sign with Hartford Stag Logo.  Aÿ§›*y nice sign!', 1, 0, NULL),
(116, 'Penn Mutual Fire Insurance Co. Sign', 20, '50.00', '1', 1, 'Penn Mutual Fire Insurance Co. Sign: The size is 13 1/2” x 10 1/2” composite sign inscribed Penn Mutual Fire Insurance Co. West Chester PA.  Great Condition!', 1, 0, NULL),
(117, 'National Liberty Fire Insurance Sign', 20, '65.00', '1', 1, 'National Liberty Fire Insurance Sign: It is a 13 1/2” round sign inscribed “National Liberty One of the Great Fire Insurance Companies of America This agency can insure your property anywhere in the United States.”  The colors are black and yellow and is in great shape!!', 1, 0, NULL),
(118, 'Hanover Fire Insurance Sign', 20, '95.00', '1', 1, 'Hanover Fire Insurance Sign: A 13” x 11” composite sign inscribed “The Hanover Fire Insurance Company of New York Established 1852.”  In Great Condition!', 1, 0, NULL),
(119, 'Horrors of Tornado Flood and Fire Book', 18, '20.00', '1', 1, 'Horrors of Tornado Flood and Fire Book: The size is 9” x 6 1/2”, has 300 pages.  1913 book in good condition!', 1, 0, NULL),
(120, 'Captain Fort Wayne IN Police or Fireman Photo', 10, '30.00', '1', 1, 'Captain Fort Wayne IN Police or Fireman Photo: This is either a policeman or fireman from Fort Wayne, IN and probably his wife.  The frame is 12” x 9 1/2” early looks to be original. ', 1, 0, NULL),
(121, 'Small Dish with Fire Penelope', 10, '15.00', '1', 1, 'Small Dish with Fire Penelope: Round 4” dish with fire theme helmet, axe, and trumpet. ', 1, 0, NULL),
(122, '12” Tin Horn', 27, '25.00', '1', 1, 'Early 12”  tin horn with wood tip.\r\n', 1, 0, NULL),
(123, 'Fireman`s Rattle', 27, '95.00', '1', 1, 'Fireman`s Rattle: An 8” x 6” single reed fireman`s rattle, works great! Very loud!  These were used to summon the volunteers to fight a fire.', 1, 0, NULL),
(124, 'Camden Fire Ins. Brass Ashtray', 20, '50.00', '1', 1, 'Camden Fire Ins. Brass Ashtray: A 5” brass ashtray inscribed “Camden Fire Insurance Assn. A.D. 1841.”', 1, 0, NULL),
(125, 'Hartford Fire Insurance Ruler', 20, '55.00', '1', 1, 'Hartford Fire Insurance Ruler: A 9 1/2” ruler from the Hartford Insurance Co.  Losses Paid 57,000,000 Orange Good Condition!', 1, 0, NULL),
(126, 'Hartford Fire Insurance Ruler 9 1/2”', 20, '50.00', '1', 1, 'Hartford Fire Insurance Ruler 9 1/2”: Ruler Adv. Hartford Insurance Co.  Losses Paid $110,000,000 Orange Fair Condition.', 1, 0, NULL),
(127, 'Hartford Fire Insurance Green Ruler', 20, '40.00', '1', 1, 'Hartford Fire Insurance Green Ruler: A 9 1/2” ruler adv. for Hartford Insurance Co.  Losses Paid $33,000,000 Green Fair Condition.', 1, 0, NULL),
(128, 'Hartford Fire Insurance Dark Green Ruler', 20, '40.00', '1', 1, 'Hartford Fire Insurance Dark Green Ruler: A 9 1/2” ruler adv. for Hartford Insurance Co.  Losses Paid $110,000,000 Green Fair Condition.', 1, 0, NULL),
(129, 'National Fire Insurance Co. Ledger Marker', 20, '135.00', '1', 1, 'National Fire Insurance Co. Ledger Marker: 12 1/2” tin ledger marker inscribed “National Fire Insurance Co. Hartford CONN.  Has a nice graphic of a lady holding US flag next to an eagle.  Very rare, fair condition.  ', 1, 0, NULL),
(130, 'Firemen`s Ball Invitation 1897 Dayton', 22, '45.00', '1', 1, 'Firemen`s Ball Invitation 1897 Dayton, OH: The size is 4 3/4” x 3 1/2”, 20 pages, and has a picture of chief with high eagle helmet and trumpet.  Dated 4-4-97.  Has many ads and also location of the city alarm boxes.  Very good condition! ', 1, 0, NULL),
(131, 'Large Wood Olympia Beer Sign', 14, '9.99', '1', 1, 'Large Wood Olympia Beer Sign: 24” x 36” Olympia beer sign on wood slated background.  Says it’s the water trademark in both upper corners.  The lower left corner 1909 greeting Olympia Brewing Co. The lower right corner Olympia Wash Great picture of Victorian blue-eyed lady.  This would be a great sign for a bar, restaurant or your recreation room.', 1, 0, NULL),
(132, 'Ham Light Watch FOB', 17, '60.00', '1', 1, 'Ham Light Watch FOB: Advertising watch FOB for the CT Ham Lantern Co. Marked Sterling Silver.', 1, 0, NULL),
(133, 'Seagrave Apparatus Sign', 19, '25.00', '1', 1, 'Seagrave Apparatus Sign: Metal Seagrave sign with a mounting hole in each corner.  The size is 8” x 2 1/2”. Excellent Condition!', 1, 0, NULL);

# --------------------------------------------------------

#
# Table structure for table `orders_completed`
#
# Creation: Mar 02, 2004 at 10:15 PM
# Last update: Mar 02, 2004 at 10:15 PM
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
# Dumping data for table `orders_completed`
#


# --------------------------------------------------------

#
# Table structure for table `orders_completed_itemlist`
#
# Creation: Mar 02, 2004 at 10:15 PM
# Last update: Mar 02, 2004 at 10:15 PM
#

DROP TABLE IF EXISTS `orders_completed_itemlist`;
CREATE TABLE `orders_completed_itemlist` (
  `order_number` int(11) NOT NULL default '0',
  `item_id` int(11) NOT NULL default '0',
  `item_name` varchar(60) NOT NULL default '',
  `quantity` int(11) NOT NUL`b”fault '0',
  `price` double NOT NULL default '0'
) TYPE=MyISAM;

#
# Dumping data for table `orders_completed_itemlist`
#


# --------------------------------------------------------

#
# Table structure for table `orders_itemlist`
#
# Creation: Mar 02, 2004 at 10:15 PM
# Last update: Mar 02, 2004 at 10:15 PM
#

DROP TABLE IF EXISTS `orders_itemlist`;
CREATE TABLE `orders_itemlist` (
  `order_number` int(11) NOT NULL default '0',
  `item_number` int(11) NOT NULL default '0',
  `item_quantity` int(11) NOT NULL default '0',
  PRIMARY KEY  (`order_number`,`item_number`)
) TYPE=MyISAM;

#
# Dumping data for table `orders_itemlist`
#


# --------------------------------------------------------

#
# Table structure for table `orders_pending`
#
# Creation: Mar 08, 2004 at 08:05 AM
# Last update: Mar 08, 2004 at 08:05 AM
# Last check: Mar 08, 2004 at 08:05 AM
#

DROP TABLE IF EXISTS `orders_pending`;
CREATE TABLE `orders_pending` (
  `order_number` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL default '0',
  `date_placed` varchar(100) NOT NULL default '',
  `paymentmethod` varchar(30) NOT NULL default 'PayPal',
  PRIMARY KEY  (`order_number`),
  KEY `user_id` (`user_id`)
) TYPE=MyISAM AUTO_INCREMENT=1 ;

#
# Dumping data for table `orders_pending`
#


# --------------------------------------------------------

#
# Table structure for table `pma_column_info`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Feb 09, 2004 at 07:21 PM
#

DROP TABLE IF EXISTS `pma_column_info`;
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
) TYPE=MyISAM COMMENT='Comments for Columns' AUTO_INCREMENT=2 ;

#
# Dumping data for table `pma_column_info`
#


# --------------------------------------------------------

#
# Table structure for table `pma_history`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Feb 03, 2004 at 11:27 PM
#

DROP TABLE IF EXISTS `pma_history`;
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

#
# Dumping data for table `pma_history`
#


# --------------------------------------------------------

#
# Table structure for table `pma_pdf_pages`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Feb 03, 2004 at 11:46 PM
#

DROP TABLE IF EXISTS `pma_pdf_pages`;
CREATE TABLE `pma_pdf_pages` (
  `db_name` varchar(64) NOT NULL default '',
  `page_nr` int(10) unsigned NOT NULL auto_increment,
  `page_descr` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`page_nr`),
  KEY `db_name` (`db_name`)
) TYPE=MyISAM COMMENT='PDF Relationpages for PMA' AUTO_INCREMENT=5 ;

#
# Dumping data for table `pma_pdf_pages`
#

INSERT INTO `pma_pdf_pages` (`db_name`, `page_nr`, `page_descr`) VALUES ('cis772', 1, 'no Description'),
('cis772', 2, 'no Description'),
('cis772', 3, 'no Description'),
('cis772', 4, 'no Description');

# --------------------------------------------------------

#
# Table structure for table `pma_relation`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Mar 02, 2004 at 10:29 PM
#

DROP TABLE IF EXISTS `pma_relation`;
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

#
# Dumping data for table `pma_relation`
#

INSERT INTO `pma_relation` (`master_db`, `master_table`, `master_field`, `foreign_db`, `foreign_table`, `foreign_field`) VALUES ('cis772', 'items', 'class_id', 'cis772', 'item_class', 'class_id'),
('cis772', 'item_pictures', 'item_id', 'cis772', 'items', 'item_id');

# --------------------------------------------------------

#
# Table structure for table `pma_table_coords`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Mar 02, 2004 at 10:29 PM
#

DROP TABLE IF EXISTS `pma_table_coords`;
CREATE TABLE `pma_table_coords` (
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `pdf_page_number` int(11) NOT NULL default '0',
  `x` float unsigned NOT NULL default '0',
  `y` float unsigned NOT NULL default '0',
  PRIMARY KEY  (`db_name`,`table_name`,`pdf_page_number`)
) TYPE=MyISAM COMMENT='Table coordinates for phpMyAdmin PDF output';

#
# Dumping data for table `pma_table_coords`
#

INSERT INTO `pma_table_coords` (`db_name`, `table_name`, `pdf_page_number`, `x`, `y`) VALUES ('cis772', 'item_pictures', 1, '350', '300'),
('cis772', 'communications', 1, '421.429', '340'),
('cis772', 'items', 1, '260.22', '246.695'),
('cis772', 'item_class', 1, '260.22', '300'),
('cis772', 'items', 2, '350', '300'),
('cis772', 'item_pictures', 2, '350', '367'),
('cis772', 'communications', 2, '260.22', '246.695'),
('cis772', 'item_class', 2, '421.429', '246.695'),
('cis772', 'items', 3, '350', '300'),
('cis772', 'item_pictures', 3, '350', '367'),
('cis772', 'communications', 3, '260.22', '246.695'),
('cis772', 'item_class', 3, '421.429', '246.695'),
('cis772', 'communications', 4, '350', '367'),
('cis772', 'items', 4, '260.22', '367'),
('cis772', 'item_pictures', 4, '260.22', '246.695'),
('cis772', 'item_class', 4, '421.429', '462.715');

# --------------------------------------------------------

#
# Table structure for table `pma_table_info`
#
# Creation: Feb 03, 2004 at 11:27 PM
# Last update: Feb 03, 2004 at 11:46 PM
#

DROP TABLE IF EXISTS `pma_table_info`;
CREATE TABLE `pma_table_info` (
  `db_name` varchar(64) NOT NULL default '',
  `table_name` varchar(64) NOT NULL default '',
  `display_field` varchar(64) NOT NULL default '',
  PRIMARY KEY  (`db_name`,`table_name`)
) TYPE=MyISAM COMMENT='Table information for phpMyAdmin';

#
# Dumping data for table `pma_table_info`
#

INSERT INTO `pma_table_info` (`db_name`, `table_name`, `display_field`) VALUES ('cis772', 'items', 'class_id');

# --------------------------------------------------------

#
# Table structure for table `shopping_carts`
#
# Creation: Mar 02, 2004 at 10:15 PM
# Last update: Mar 08, 2004 at 04:16 PM
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
# Dumping data for table `shopping_carts`
#

INSERT INTO `shopping_carts` (`user_id`, `item_number`, `item_qty`) VALUES (11, 96, 1);
