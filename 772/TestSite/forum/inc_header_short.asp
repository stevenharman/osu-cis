<%
'#################################################################################
'## Snitz Forums 2000 v3.4.04
'#################################################################################
'## Copyright (C) 2000-04 Michael Anderson, Pierre Gorissen,
'##                       Huw Reddick and Richard Kinser
'##
'## This program is free software; you can redistribute it and/or
'## modify it under the terms of the GNU General Public License
'## as published by the Free Software Foundation; either version 2
'## of the License, or (at your option) any later version.
'##
'## All copyright notices regarding Snitz Forums 2000
'## must remain intact in the scripts and in the outputted HTML
'## The "powered by" text/logo with a link back to
'## http://forum.snitz.com in the footer of the pages MUST
'## remain visible when the pages are viewed on the internet or intranet.
'##
'## This program is distributed in the hope that it will be useful,
'## but WITHOUT ANY WARRANTY; without even the implied warranty of
'## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'## GNU General Public License for more details.
'##
'## You should have received a copy of the GNU General Public License
'## along with this program; if not, write to the Free Software
'## Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
'##
'## Support can be obtained from our support forums at:
'## http://forum.snitz.com
'##
'## Correspondence and Marketing Questions can be sent to:
'## manderson@snitz.com
'##
'#################################################################################
%>
<!--#INCLUDE FILE="inc_func_common.asp" -->
<%
strArchiveTablePrefix = strTablePrefix & "A_"
scriptname = split(request.servervariables("SCRIPT_NAME"),"/")
strReferer = chkString(request.servervariables("HTTP_REFERER"),"refer")

set my_Conn= Server.CreateObject("ADODB.Connection")
my_Conn.Open strConnString

strDBNTUserName = Request.Cookies(strUniqueID & "User")("Name")
strDBNTFUserName = trim(chkString(Request.Form("Name"),"SQLString"))
if strDBNTFUserName = "" then strDBNTFUserName = trim(chkString(Request.Form("User"),"SQLString"))
if strAuthType = "nt" then
	strDBNTUserName = Session(strCookieURL & "userID")
	strDBNTFUserName = Session(strCookieURL & "userID")
end if

chkCookie = 1
mLev = cLng(chkUser(strDBNTUserName, Request.Cookies(strUniqueID & "User")("Pword"),-1))
chkCookie = 0

Response.Write	"<html>" & vbNewline & _
		vbNewline & _
		"<head>" & vbNewline & _
		"<title>" & strForumTitle & "</title>" & vbNewline


'## START - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT
Response.Write	"<meta name=""copyright"" content=""This Forum code is Copyright (C) 2000-04 Michael Anderson, Pierre Gorissen, Huw Reddick and Richard Kinser, Non-Forum Related code is Copyright (C) " & strCopyright & """>" & vbNewline 
'## END   - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT


Response.Write	"<style><!--" & vbNewline & _
		"a:link    {color:" & strLinkColor & ";text-decoration:" & strLinkTextDecoration & "}" & vbNewline & _
		"a:visited {color:" & strVisitedLinkColor & ";text-decoration:" & strVisitedTextDecoration & "}" & vbNewline & _
		"a:hover   {color:" & strHoverFontColor & ";text-decoration:" & strHoverTextDecoration & "}" & vbNewline & _
		"a:active  {color:" & strActiveLinkColor & ";text-decoration:" & strActiveTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:link    {color:" & strForumLinkColor & ";text-decoration:" & strForumLinkTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:visited {color:" & strForumVisitedLinkColor & ";text-decoration:" & strForumVisitedTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:hover   {color:" & strForumHoverFontColor & ";text-decoration:" & strForumHoverTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:active  {color:" & strForumActiveLinkColor & ";text-decoration:" & strForumActiveTextDecoration & "}" & vbNewLine & _
		"input.radio {background:" & strPopUpTableColor & ";color:#000000}" & vbNewLine & _
		"--></style>" & vbNewline & _
		"</head>" & vbNewline & _
		vbNewline & _
		"<body bgColor=""" & strPageBGColor & """ text=""" & strDefaultFontColor & """ link=""" & strLinkColor & """ aLink=""" & strActiveLinkColor & """ vLink=""" & strVisitedLinkColor & """ onLoad=""window.focus();"">" & vbNewline & _
		vbNewline & _
		"<table width=""100%"" height=""100%"" align=""center"">" & vbNewline & _
		"  <tr>" & vbNewline & _
		"    <td align=""center"" valign=""middle"">" & vbNewline & _
		"    <div align=""center"">" & vbNewline & _
		"    <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewline
%>
