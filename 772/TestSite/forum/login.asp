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
<!--#INCLUDE FILE="config.asp"-->
<!--#INCLUDE FILE="inc_sha256.asp"-->
<!--#INCLUDE FILE="inc_header.asp" -->
<%
if MemberID > 0 then Response.Redirect("/index.asp")
Response.Write	"      <table border=""0"" width=""100%"" align=""center"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td width=""33%"" align=""left"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
		"          " & getCurrentIcon(strIconFolderOpen,"All Forums","") & "&nbsp;<a href=""default.asp"">All&nbsp;Forums</a><br />" & vbNewLine & _
		"          " & getCurrentIcon(strIconBar,"","") & getCurrentIcon(strIconFolderOpenTopic,"Forum Login","") & "&nbsp;Member&nbsp;Login<br /></font></td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine

fName = strDBNTFUserName
fPassword = ChkString(Request.Form("Password"), "SQLString")

RequestMethod = Request.ServerVariables("Request_Method")
strTarget = trim(chkString(request("target"),"SQLString"))

if RequestMethod = "POST" Then
	strEncodedPassword = sha256("" & fPassword)
	select case chkUser(fName, strEncodedPassword,-1)
		case 1, 2, 3, 4
			Call DoCookies(Request.Form("SavePassword"))
			strLoginStatus = 1
		case else
			strLoginStatus = 0
	end select

	if strLoginStatus = 1 then
		Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Login was successful!</font></p>" & vbNewLine
		Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href="""
		if strTarget = "" then
			Response.Write	"default.asp"
		else
			Response.Write	strTarget
		end if
		Response.Write	""">Click here to Continue</a></font></p>" & vbNewLine

		Response.Write	"      <meta http-equiv=""Refresh"" content=""2; URL="
		if strTarget = "" then
			Response.Write	"default.asp"
		else
			Response.Write	strTarget
		end if
		Response.Write	""">" & vbNewline & _
				"      <br />" & vbNewLine

		WriteFooter
		Response.End
	end if
end if
Response.Write	"      <table width=""100%"" border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"        <form action=""login.asp"" method=""post"" id=""Form1"" name=""Form1"">" & vbNewLine & _
		"        <input type=""hidden"" value=""" & strTarget & """ name=""target"">" & vbNewLine & _
		"          <td bgcolor=""" & strTableBorderColor & """>" & vbNewLine & _
		"            <table width=""100%"" border=""0"" cellspacing=""1"" cellpadding=""4"" align=""center"">" & vbNewLine & _
		"              <tr>" & vbNewLine & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Member Login</font></b></td>" & vbNewLine & _
		"              </tr>" & vbNewLine & _
		"              <tr>" & vbNewLine & _
		"                <td align=""left"" bgcolor=""" & strCategoryCellColor & """><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>Member Login</font></b></td>" & vbNewLine & _
		"              </tr>" & vbNewLine & _
		"              <tr>" & vbNewLine & _
		"                <td bgcolor=""" & strForumCellColor & """>" & vbNewLine & _
		"                  <table border=""0"" cellpadding=""6"" cellspacing=""0"" width=""90%"" align=""center"">" & vbNewLine & _
		"                    <tr valign=""top"">" & vbNewLine & _
		"                      <td width=""49%""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & vbNewLine
if RequestMethod = "POST" and strLoginStatus = 0 then Response.Write("                      <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHiLiteFontColor & """>Your username and/or password was incorrect.</font><br />" & vbNewLine) else Response.Write("<br />" & vbNewLine)
Response.Write	"                      <b>Login:</b></font>" & vbNewLine & _
		"                        <table border=""0"" cellpadding=""2"" cellspacing=""0"">" & vbNewLine & _
		"                          <tr>" & vbNewLine & _
		"                            <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & vbNewLine & _
		"                            Username:<br />" & vbNewLine & _
		"                            <input type=""text"" name=""Name"" size=""20"" maxLength=""25"" tabindex=""1"" value="""" style=""width:150px;""></td>" & vbNewLine & _
		"                            <td rowspan=""2"" valign=""bottom""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & vbNewLine
if strGfxButtons = "1" then
	Response.Write	"                            <input src=""" & strImageUrl & "button_login.gif"" type=""image"" border=""0"" value=""Login"" id=""submit1"" name=""submit1"" tabindex=""3""></font></td>" & vbNewLine
else
	Response.Write	"                            <input class=""button"" type=""submit"" value=""Login"" id=""submit1"" name=""submit1"" tabindex=""3""></font></td>" & vbNewLine
end if 
Response.Write	"                          </tr>" & vbNewLine & _
		"                          <tr>" & vbNewLine & _
		"                            <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & vbNewLine & _
		"                            Password:<br />" & vbNewLine & _
		"                            <input type=""password"" name=""Password"" size=""20"" tabindex=""2"" maxLength=""25"" value="""" style=""width:150px;""></td>" & vbNewLine & _
		"                          </tr>" & vbNewLine & _
		"                          <tr>" & vbNewLine & _
		"                            <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & vbNewLine & _
		"                            <input type=""checkbox"" name=""SavePassWord"" tabindex=""4"" value=""true""> Save Password</font></td>" & vbNewLine & _
		"                          </tr>" & vbNewLine & _
		"                        </table>" & vbNewLine & _
		"                      </td>" & vbNewLine & _
		"                      <script language=""JavaScript"" type=""text/javascript"">document.Form1.Name.focus();</script>" & vbNewLine & _
		"                      <td width=""2%""nowrap></td>" & vbNewLine & _
		"                      <td width=""49%""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """><br /><b>Login Questions:</b><br />" & vbNewLine & _
		"                      <span style=""font-size: 6px;""><br /></span>" & vbNewLine & _
		"                      <acronym title=""Do I have to register?""><span class=""spnMessageText""><a href=""faq.asp#register""" & dWStatus("Do I have to register?") & ">Do I have to register?</a></span></acronym><br />" & vbNewLine
if strEmail = "1" then Response.Write("                      <acronym title=""Choose a new password if you have forgotten your current one.""><span class=""spnMessageText""><a href=""password.asp""" & dWStatus("Choose a new password if you have forgotten your current one.") & ">Forgot your Password?</a></span></acronym><br /><br />" & vbNewLine) else Response.Write("                      <br />" & vbNewLine)
Response.Write	"                      Not a member?<br />"
if strProhibitNewMembers = "1" then
	Response.Write	"<font size=""" & strFooterFontSize & """ color=""" & strHiLiteFontColor & """>The Administrator has turned off Registration for this forum.<br />Only registered members are able to log in</font></font></td>" & vbNewLine
else
	Response.Write	"<acronym title=""Click here to register.""><span class=""spnMessageText""><a href=""policy.asp""" & dWStatus("Click here to register.") & ">Register Here!</a></span></acronymn></font></td>" & vbNewLine
end if
Response.Write	"                    </tr>" & vbNewLine & _
		"                  </table>" & vbNewLine & _
		"                </td>" & vbNewLine & _
		"              </tr>" & vbNewLine & _
		"            </table>" & vbNewLine & _
		"          </td>" & vbNewLine & _
		"        </form>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine & _
		"      <br />" & vbNewLine
WriteFooter
%>
