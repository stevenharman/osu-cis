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
<!--#include file="inc_header_code.asp"-->
<%
Response.Write	"<html>" & vbNewline & vbNewline & _
		"<head>" & vbNewline & _
		"<title>" & GetNewTitle(strScriptName) & "</title>" & vbNewline

'## START - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT
Response.Write	"<meta name=""copyright"" content=""This Forum code is Copyright (C) 2000-04 Michael Anderson, Pierre Gorissen, Huw Reddick and Richard Kinser, Non-Forum Related code is Copyright (C) " & strCopyright & """>" & vbNewline 
'## END   - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT

Response.Write	"<script language=""JavaScript"" type=""text/javascript"">" & vbNewLine & _
		"<!-- hide from JavaScript-challenged browsers" & vbNewLine & _
		"function openWindow(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=400,height=400')" & vbNewLine & _
		"}" & vbNewLine & _
		"function openWindow2(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=400,height=450')" & vbNewLine & _
		"}" & vbNewLine & _
		"function openWindow3(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=400,height=450,scrollbars=yes')" & vbNewLine & _
		"}" & vbNewLine & _
		"function openWindow4(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=400,height=525')" & vbNewLine & _
		"}" & vbNewLine & _
		"function openWindow5(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=450,height=525,scrollbars=yes,toolbars=yes,menubar=yes,resizable=yes')" & vbNewLine & _
		"}" & vbNewLine & _
		"function openWindow6(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=500,height=450,scrollbars=yes')" & vbNewLine & _
		"}" & vbNewLine & _
		"function openWindowHelp(url) {" & vbNewLine & _
		"	popupWin = window.open(url,'new_page','width=470,height=200,scrollbars=yes')" & vbNewLine & _
		"}" & vbNewLine & _
		"// done hiding -->" & vbNewLine & _
		"</script>" & vbNewLine & _
		"<style type=""text/css"">" & vbNewLine & _
		"<!--" & vbNewLine & _
		"a:link    {color:" & strLinkColor & ";text-decoration:" & strLinkTextDecoration & "}" & vbNewLine & _
		"a:visited {color:" & strVisitedLinkColor & ";text-decoration:" & strVisitedTextDecoration & "}" & vbNewLine & _
		"a:hover   {color:" & strHoverFontColor & ";text-decoration:" & strHoverTextDecoration & "}" & vbNewLine & _
		"a:active  {color:" & strActiveLinkColor & ";text-decoration:" & strActiveTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:link    {color:" & strForumLinkColor & ";text-decoration:" & strForumLinkTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:visited {color:" & strForumVisitedLinkColor & ";text-decoration:" & strForumVisitedTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:hover   {color:" & strForumHoverFontColor & ";text-decoration:" & strForumHoverTextDecoration & "}" & vbNewLine & _
		".spnMessageText a:active  {color:" & strForumActiveLinkColor & ";text-decoration:" & strForumActiveTextDecoration & "}" & vbNewLine & _
		".spnSearchHighlight {background-color:" & strSearchHiLiteColor & "}" & vbNewLine & _
		"input.radio {background:" & strPopUpTableColor & ";color:#000000}" & vbNewLine & _
		"-->" & vbNewLine & _
		"</style>" & vbNewLine & _
		"<link href=""/BCRocketStyleSheet.css"" rel=""stylesheet"" type=""text/css"">" & vbNewLine & _
		"</head>" & vbNewLine & _
		vbNewLine & _
		"<body" & strTmpPageBGImageURL & " bgColor=""" & strPageBGColor & """ text=""" & strDefaultFontColor & """ link=""" & strLinkColor & """ aLink=""" & strActiveLinkColor & """ vLink=""" & strVisitedLinkColor & """>" & vbNewLine & _
		"<a name=""top""></a>" & vbNewLine & _
		vbNewLine
%>
<!--#include virtual="/includes/header_forum_open.inc.html" -->
<!--#include virtual="/includes/header_std_close.inc.html" -->

<%		
Response.write	"<table valign=""top"" align=""center"" width=""100%"" border=""0"" cellPadding=""2"" cellSpacing=""0"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td align=""left""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>" & strForumTitle & "</b></font></td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td align=""left""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewLine
call sForumNavigation()
Response.Write	"</font></td>" & vbNewLine & _
		"        </tr>" & vbNewLine

select case Request.Form("Method_Type")

	case "login"
		Response.Write	"      </table>" & vbNewLine
		if strLoginStatus = 0 then
			Response.Write	"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Your username and/or password were incorrect.</font></p>" & vbNewLine & _
					"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Please either try again or register for an account.</font></p>" & vbNewLine
		else
			Response.Write	"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>You logged on successfully!</font></p>" & vbNewLine & _
					"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Thank you for your participation.</font></p>" & vbNewLine
		end if
		Response.Write	"<meta http-equiv=""Refresh"" content=""2; URL=" & strReferer & """>" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""" & strReferer & """>Back To Forum</font></a></p>" & vbNewLine & _
				"<table align=""center"" border=""0"" cellPadding=""0"" cellSpacing=""0"" width=""100%"">" & vbNewLine & _
				"  <tr>" & vbNewLine & _
				"    <td>" & vbNewLine
		WriteFooter
		Response.End
	case "logout" 
		Response.Write	"      </table>" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>You logged out successfully!</font></p>" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Thank you for your participation.</font></p>" & vbNewLine & _
				"<meta http-equiv=""Refresh"" content=""2; URL=default.asp"">" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""default.asp"">Back To Forum</font></a></p>" & vbNewLine & _
				"<table align=""center"" border=""0"" cellPadding=""0"" cellSpacing=""0"" width=""100%"">" & vbNewLine & _
				"  <tr>" & vbNewLine & _
				"    <td>" & vbNewLine
		WriteFooter
		Response.End
end select
%>
<% '<!--#include file="inc_loginForm.asp"--> %>
<%
Response.Write	"      </table>"

'########### End of Header, main forum tables starts below.
Response.write	"<table align=""center"" border=""0"" cellPadding=""0"" cellSpacing=""0"" width=""100%"">" & vbNewLine
'########### GROUP Categories ########### %>
<!--#INCLUDE FILE="inc_groupjump_to.asp" -->
<% '######## GROUP Categories ##############
Response.Write	"  <tr>" & vbNewLine & _
		"    <td>" & vbNewLine


if strGroupCategories = "1" then
	if Session(strCookieURL & "GROUP_NAME") = "" then
		GROUPNAME = " Default Groups "
	else
		GROUPNAME = Session(strCookieURL & "GROUP_NAME")
	end if
	'Forum_SQL - Get Groups
	strSql = "SELECT GROUP_ID, GROUP_CATID " 
	strSql = strSql & " FROM " & strTablePrefix & "GROUPS "
	strSql = strSql & " WHERE GROUP_ID = " & Group
	set rsgroups = Server.CreateObject("ADODB.Recordset")
	rsgroups.Open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText
	if rsgroups.EOF then
		recGroupCatCount = ""
	else
		allGroupCatData = rsgroups.GetRows(adGetRowsRest)
		recGroupCatCount = UBound(allGroupCatData, 2)
	end if
	rsgroups.Close
	set rsgroups = nothing
end if
%>
