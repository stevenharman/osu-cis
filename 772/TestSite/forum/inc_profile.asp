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
Sub DisplayProfileForm
	on error resume next
	strMode = Request.QueryString("mode")

	Response.Write	"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"" valign=""top"" align=""center"">" & vbNewLine & _
			"        <tr>" & vbNewLine & _
			"          <td bgColor=""" & strPageBGColor & """ align=""center""" & strColSpan & "><p><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>All Fields marked with <font size=""" & strHeaderFontSize & """ color=""" & strHiLiteFontColor & """>*</font> are required</b>"
	if lcase(strEmail) = "1" and strEmailVal = "1" then
		if strMode = "Register" then
			Response.Write("<br /><small>To complete your registration, you need to have a valid e-mail address.</small>")
		else
			if strMode <> "goModify" then
				Response.Write("<br /><small>If you change your e-mail address, a confirmation e-mail will be sent to your new address.<br />Please make sure it is a valid address.</small>")
			else
				Response.Write("<br /><small>If you change the e-mail address, a confirmation e-mail will be sent to the new address.<br />Please make sure it is a valid address.</small>")
			end if
		end if
	end if
	Response.Write	"</font></p></td>" & vbNewLine & _
			"        </tr>" & vbNewLine & _
			"        <tr>" & vbNewLine & _
			"          <td bgcolor=""" & strPageBGColor & """ align=""left"" valign=""top"">" & vbNewLine & _
			"            <table border=""0"" width=""80%"" cellspacing=""1"" cellpadding=""0"" align=""center"">" & vbNewLine & _
			"              <tr>" & vbNewLine

	if strUseExtendedProfile then
		Response.Write	"                <td width=""50%"" bgColor=""" & strPopUpTableColor & """ valign=""top"">" & vbNewLine & _
				"                  <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""1"">" & vbNewLine & _
				"                    <tr>" & vbNewLine & _
				"                      <td align=""center"" bgcolor=""" & strCategoryCellColor & """ colspan=""2""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>&nbsp;Contact Info&nbsp;</font></b></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine & _
				"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" width=""10%"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> E-mail Address:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Email"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then  Response.Write(rs("M_EMAIL"))
		Response.Write	""">" & vbNewLine & _
				"                      <input type=""hidden"" name=""Email2"" value="""
		if strMode <> "Register" then Response.Write(rs("M_EMAIL"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
		if strMode = "Register" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" width=""10%"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> E-mail Address Again:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Email3"" size=""25"" maxLength=""50"" value=""""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		Response.Write	"                    <tr valign=""middle"">" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" width=""10%"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>Allow Forum Members<br />to Send you E-Mail?:&nbsp;</font></b></td>" & vbNewLine
		if strMode = "Register" then
			Response.Write	"                      <td bgColor=""" & strPopUpTableColor & """ valign=""middle""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
					"                      <select name=""ReceiveEMail"">" & vbNewLine & _
					"                      	<option value=""1"" selected>Yes</option>" & vbNewLine & _
					"                      	<option value=""0"">No</option>" & vbNewLine & _
					"                      </select></font></td>" & vbNewLine
		else
			Response.Write	"                      <td bgColor=""" & strPopUpTableColor & """ valign=""middle""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewLine & _
					"                      <select name=""ReceiveEMail"">" & vbNewLine & _
					"                      	<option value=""1"""
			if rs("M_RECEIVE_EMAIL") <> "0" then Response.Write(" selected")
			Response.Write	">Yes</option>" & vbNewLine & _
					"                      	<option value=""0"""
			if rs("M_RECEIVE_EMAIL") = "0" then Response.Write(" selected")
			Response.Write	">No</option>" & vbNewLine & _
					"                      </select></font></td>" & vbNewLine
		end if
		Response.Write	"                    </tr>" & vbNewLine
		if strMode = "goModify" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Initial IP:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""http://www.samspade.org/t/ipwhois?a=" & ChkString(rs("M_IP"), "display") & """ target=""_blank"">" & ChkString(rs("M_IP"), "display") & "</a></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine & _
					"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Last IP:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""http://www.samspade.org/t/ipwhois?a=" & ChkString(rs("M_LAST_IP"), "display") & """ target=""_blank"">" & ChkString(rs("M_LAST_IP"), "display") & "</a></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strAIM = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>AIM:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""AIM"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_AIM"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strICQ = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>ICQ:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""ICQ"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_ICQ"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strMSN = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>MSN:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""MSN"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_MSN"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strYAHOO = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>YAHOO IM:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""YAHOO"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_YAHOO"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if (strHomepage + strFavLinks) > 0 and (strUseExtendedProfile) then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td align=""center"" bgcolor=""" & strCategoryCellColor & """ colspan=""2"">" & vbNewLine & _
					"                      <b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>Links&nbsp;</font></b></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
			if strHomepage = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Homepage:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Homepage"" size=""25"" maxLength=""255"" value="""
				if strMode <> "Register" then
					if ChkString(rs("M_HOMEPAGE"), "display") <> " " and lcase(rs("M_HOMEPAGE")) <> "http://" then Response.Write(rs("M_HOMEPAGE")) else Response.Write("http://")
				else
					Response.Write("http://")
				end if
				Response.Write	"""></font></td>" & vbNewLine & _
							"                    </tr>" & vbNewLine
			end if
			if strFavLinks = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Cool Links:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Link1"" size=""25"" maxLength=""255"" value="""
				if strMode <> "Register" then
					if rs("M_LINK1") <> " " and lcase(rs("M_LINK1")) <> "http://" then Response.Write(ChkString(rs("M_LINK1"), "display")) else Response.Write("http://")
				else
					Response.Write("http://")
				end if
				Response.Write	"""></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine & _
						"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Link2"" size=""25"" maxLength=""255"" value="""
				if strMode <> "Register" then
					if rs("M_LINK2") <> " " and lcase(rs("M_LINK2")) <> "http://" then Response.Write(ChkString(rs("M_LINK2"), "display")) else Response.Write("http://")
				else
					Response.Write("http://")
				end if
				Response.Write	"""></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
		end if
		if strPicture = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td align=""center"" bgcolor=""" & strCategoryCellColor & """ colspan=""2"">" & vbNewLine & _
					"                      <b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>Picture&nbsp;</font></b></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine & _
					"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Picture URL:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Photo_URL"" size=""25"" maxLength=""255"" value="""
			if strMode <> "Register" then
				if rs("M_PHOTO_URL") <> " " and lcase(rs("M_PHOTO_URL")) <> "http://" then Response.Write(ChkString(rs("M_PHOTO_URL"), "displayimage")) else Response.Write("http://")
			else
				Response.Write("http://")
			end if
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if ' strPicture
		if (strBio + strHobbies + strLNews + strQuote)	> 0 then 
			if strMode <> "Register" then
				strMyHobbies = rs("M_HOBBIES")
				strMyLNews = rs("M_LNEWS")
				strMyQuote = rs("M_QUOTE")
				strMyBio = rs("M_BIO")
			end if
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td align=""center"" bgcolor=""" & strCategoryCellColor & """ colspan=""2""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>More About Me</font></b></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
			if strHobbies = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top"" align=""right"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Hobbies:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><textarea name=""Hobbies"" cols=""30"" rows=""4"">" & Trim(cleancode(strMyHobbies)) & "</textarea></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
			if strLNews = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top"" align=""right"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Latest News:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><textarea name=""LNews"" cols=""30"" rows=""4"">" & Trim(cleancode(strMyLNews)) & "</textarea></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
			if strQuote = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgcolor=""" & strPopUpTableColor & """ valign=""top"" align=""right"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Favorite Quote:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input type=""text"" size=""25"" maxlength=""255"" name=""quote"" value=""" & Trim(cleancode(strMyQuote)) & """></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
			if strBio = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top"" align=""right"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Bio:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><textarea name=""Bio"" cols=""30"" rows=""4"">" & Trim(cleancode(strMyBio)) & "</textarea></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
		end if
		Response.Write	"                  </table>" & vbNewLine & _
				"                </td>" & vbNewLine
	end if 'extended profile

	Response.Write	"                <td bgColor=""" & strPopUpTableColor & """ valign=""top"">" & vbNewLine & _
			"                  <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""1"">" & vbNewLine & _
			"                    <tr>" & vbNewLine & _
			"                      <td valign=""top"" align=""center"" colspan=""2"" bgcolor=""" & strCategoryCellColor & """><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>Basics</font></b></td>" & vbNewLine & _
			"                    </tr>" & vbNewLine & _
			"                    <tr>" & vbNewLine & _
			"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> User Name:&nbsp;</font></b></td>" & vbNewLine & _
			"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
	if (strMode = "goEdit") or (strMode = "goModify" and cLng(Request.Form("MEMBER_ID")) = cLng(intAdminMemberID)) then
		Response.Write	"                      <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & ChkString(rs("M_NAME"), "display") & "</font>" & vbNewLine & _
				"                      <input type=""hidden"" name=""Name"" value=""" & rs("M_NAME") & """>" & vbNewLine
	else
		Response.Write	"                      <input name=""Name"" size=""25"" maxLength=""25"" value="""
		if strMode <> "Register" then Response.Write(ChkString(rs("M_NAME"), "display"))
		Response.Write	""">" & vbNewLine
	end if
	Response.Write	"                      </font></td>" & vbNewLine & _
			"                    </tr>" & vbNewLine
	if strMode = "goModify" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Title:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Title"" size=""25"" maxLength=""50"" value=""" & CleanCode(rs("M_TITLE")) & """></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strAuthType = "nt" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Your Account:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
		if Request.Form("Method_Type") = "Modify" then
			Response.Write	"                      <input name=""Account"" value=""" & ChkString(rs("M_USERNAME"), "display") & """>" & vbNewLine
		else
			Response.Write	"                      " & Session(strCookieURL & "userid") & "<input type=""hidden"" name=""Account"" value=""" & Session(strCookieURL & "userid") & """>" & vbNewLine
		end if
		Response.Write	"                      </font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	else
		if strMode = "Register" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Password:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Password"" type=""Password"" size=""25"" maxLength=""25"" value=""""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine & _
					"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Password Again:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Password2"" type=""Password"" size=""25"" maxLength=""25"" value=""""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
	        else
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>&nbsp;New Password:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Password"" type=""Password"" size=""25"" maxLength=""25"" value="""">" & vbNewLine & _
					"                      <input name=""Password-d"" type=""hidden"" value=""" & rs("M_PASSWORD") & """></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
			if strMode = "goEdit" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>&nbsp;New Password Again:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Password2"" type=""Password"" size=""25"" maxLength=""25"" value=""""></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
		end if
	end if
	if strFullName = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Firstname:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""FirstName"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(rs("M_FIRSTNAME"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine & _
				"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Lastname:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""LastName"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(rs("M_LASTNAME"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if


	if strAddr1 = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Address Line 1:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Addr1"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(rs("M_ADDR1"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine	
	end if	
	if strAddr2 = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Address Line 2:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Addr2"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(rs("M_ADDR2"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine	
	end if	



	if strCity = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> City:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""City"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(rs("M_CITY"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strState = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> State:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""State"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(rs("M_STATE"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strZip = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Zip Code:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Zip"" size=""25"" maxLength=""5"" value="""
		if strMode <> "Register" then Response.Write(rs("M_ZIP"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine	
	end if	
	if strCountry = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> Country:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
				"                      <select name=""Country"" size=""1"">" & vbNewLine
		if strMode <> "Register" then
			Response.Write("                           <option selected value=""" & rs("M_COUNTRY") & """>" & ChkString(rs("M_COUNTRY"), "display") & "</option>" & vbNewLine)
		else
			Response.Write	"                           <option value=""""></option>" & vbNewLine
		end if
		Response.Write	"                           <option value="""">None</option>" & vbNewLine
%>
		<!--#INCLUDE FILE="inc_countrylist.asp"-->
<%
		Response.Write	"                      </select></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strAge = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Age:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Age"" size=""5"" maxLength=""3"" value="""
		if strMode <> "Register" then Response.Write(ChkString(rs("M_AGE"), "display"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strAgeDOB = "1" then
		Response.Write	"                    <script language=""JavaScript"" type=""text/javascript"" src=""inc_datepicker.js""></script>" & vbNewLine
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Birth Date:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input type=""hidden"" name=""AgeDOB"" id=""AgeDOB"" value="""
		if strMode <> "Register" then Response.Write(trim(ChkString(rs("M_DOB"), "display")))
		Response.Write	"""><a href=""javascript:_ShowPopupCalendar( 'Form1', 'AgeDOB', false )"">" & getCurrentIcon(strIconCalendar,"Choose Date","align=""absmiddle""") & "</a></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strSex = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Gender:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
				"                      <select name=""Sex"" size=""1"">" & vbNewLine & _
				"                           <option value="""""
		if strMode <> "Register" then
			if rs("M_SEX") = "" then Response.Write(" selected")
		else
			Response.Write(" selected")
		end if
		Response.Write	">Not specified&nbsp;</option>" & vbNewLine & _
				"                           <option value=""Male"""
		if strMode <> "Register" then
			if rs("M_SEX") = "Male" then Response.Write(" selected")
		end if
		Response.Write	">Male&nbsp;</option>" & vbNewLine & _
				"                           <option value=""Female"""
		if strMode <> "Register" then
			if rs("M_SEX") = "Female" then Response.Write(" selected")
		end if
		Response.Write	">Female&nbsp;</option>" & vbNewLine & _
				"                      </select></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strMarStatus = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Marital Status:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""MarStatus"" size=""25"" maxLength=""25"" value="""
		if strMode <> "Register" then Response.Write(ChkString(rs("M_MARSTATUS"), "display"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strOccupation = "1" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Occupation:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Occupation"" size=""25"" maxLength=""255"" value="""
		if strMode <> "Register" then Response.Write(ChkString(rs("M_OCCUPATION"), "display"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strMode = "goModify" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """># of Posts:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Posts"" size=""5"" maxLength=""10"" value=""" & ChkString(rs("M_POSTS"), "display") & """></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if strSignatures = "1" then
		if strMode <> "Register" then
			strTxtSig = rs("M_SIG")
		end if
		Response.Write	"                    <script language=""JavaScript"" type=""text/javascript"" src=""inc_code.js""></script>" & vbNewLine & _
				"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""top"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Signature:&nbsp;</font></b><br />" & vbNewLine & _
				"                      <span style=""font-size: 4px;""><br /></span>" & vbNewLine & _
				"                        <table border=""0"">" & vbNewLine & _
				"                          <tr>" & vbNewLine & _
				"                            <td align=""left"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewLine
		if strAllowHTML = "1" then
			Response.Write	"                            * HTML is ON<br />" & vbNewLine
		else
			Response.Write	"                            * HTML is OFF<br />" & vbNewLine
		end if
		if strAllowForumCode = "1" then
			Response.Write	"                            * <a href=""JavaScript:openWindow6('pop_forum_code.asp')"" tabindex=""-1"">Forum Code</a> is ON<br />" & vbNewLine
		else
			Response.Write	"                            * Forum Code is OFF<br />" & vbNewLine
		end if
		Response.Write	"                            </font></td>" & vbNewLine & _
				"                          </tr>" & vbNewLine & _
				"                        </table>" & vbNewLine & _
				"                      <span style=""font-size: 4px;""><br /></span>" & vbNewLine & _
				"                      <input name=""Preview"" type=""button"" value=""Preview"" onclick=""OpenSigPreview()"">&nbsp;</td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><textarea name=""Sig"" cols=""25"" rows=""4"">" & Trim(cleancode(strTxtSig)) & "</textarea></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
		if strMode <> "goModify" then
			if strDSignatures = "1" then
				Response.Write	"                    <tr>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>View Signatures<br />in Posts?:&nbsp;</font></b></td>" & vbNewLine & _
						"                      <td bgColor=""" & strPopUpTableColor & """ valign=""middle""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
						"                      <select name=""ViewSig"">" & vbNewLine
				if strMode = "Register" then
					Response.Write	"                      	<option value=""1"" selected>Yes</option>" & vbNewLine & _
							"                      	<option value=""0"">No</option>" & vbNewLine
				else
					Response.Write	"                      	<option value=""1""" & chkSelect(rs("M_VIEW_SIG"),1) & ">Yes</option>" & vbNewLine & _
							"                      	<option value=""0""" & chkSelect(rs("M_VIEW_SIG"),0) & ">No</option>" & vbNewLine
				end if
				Response.Write	"                      </select></font></td>" & vbNewLine & _
						"                    </tr>" & vbNewLine
			end if
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>Signature checkbox<br />checked by default?:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ valign=""middle""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
					"                      <select name=""fSigDefault"">" & vbNewLine
			if strMode = "Register" then
				Response.Write	"                      	<option value=""1"" selected>Yes</option>" & vbNewLine & _
						"                      	<option value=""0"">No</option>" & vbNewLine
			else
				Response.Write	"                      	<option value=""1""" & chkSelect(rs("M_SIG_DEFAULT"),1) & ">Yes</option>" & vbNewLine & _
						"                      	<option value=""0""" & chkSelect(rs("M_SIG_DEFAULT"),0) & ">No</option>" & vbNewLine
			end if
			Response.Write	"                      </select></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
	end if
	if Request.Form("Method_Type") = "Modify" then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Member Level:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ valign=""top"">" & vbNewLine
		if rs("MEMBER_ID") = intAdminMemberID then
			Response.Write	"                      <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Administrator</font>" & vbNewLine & _
					"                      <input type=""hidden"" value=""3"" name=""Level"">" & vbNewLine
		else
			Response.Write	"                      <select value=""1"" name=""Level"">" & vbNewLine & _
					"                           <option value=""1"""
			if rs("M_LEVEL") = 1 then Response.Write(" selected")
			Response.Write	">Normal User</option>" & vbNewLine & _
					"                           <option value=""2"""
			if rs("M_LEVEL") = 2 then Response.Write(" selected")
			Response.Write	">Moderator</option>" & vbNewLine & _
					"                           <option value=""3"""
			if rs("M_LEVEL") = 3 then Response.Write(" selected")
			Response.Write	">Administrator</option>" & vbNewLine & _
					"                      </select>" & vbNewLine
		end if
		Response.Write	"                      </td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
	end if
	if not(strUseExtendedProfile) then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td align=""center"" bgcolor=""" & strCategoryCellColor & """ colspan=""2""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>&nbsp;Contact Info&nbsp;</font></b></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine & _
				"                    <tr>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" width=""10%"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> E-mail Address:&nbsp;</font></b></td>" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Email"" size=""25"" maxLength=""50"" value="""
		if strMode <> "Register" then Response.Write(ChkString(rs("M_EMAIL"), "display"))
		Response.Write	""">" & vbNewLine & _
				"                      <input type=""hidden"" name=""Email2"" value="""
		if strMode <> "Register" then Response.Write(rs("M_EMAIL"))
		Response.Write	"""></font></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
		if strMode = "Register" then
			Response.Write	"                    </tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" width=""10%"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><font color=""" & strHiLiteFontColor & """>*</font> E-mail Address Again:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Email3"" size=""25"" maxLength=""50"" value=""""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		Response.Write	"                    <tr valign=""middle"">" & vbNewLine & _
				"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" width=""10%"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>Allow Forum Members<br />to Send you E-Mail?:&nbsp;</font></b></td>" & vbNewLine
		if strMode = "Register" then
			Response.Write	"                      <td bgColor=""" & strPopUpTableColor & """ valign=""middle""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
					"                      <select name=""ReceiveEMail"">" & vbNewLine & _
					"                      	<option value=""1"" selected>Yes</option>" & vbNewLine & _
					"                      	<option value=""0"">No</option>" & vbNewLine & _
					"                      </select></font></td>" & vbNewLine
		else
			Response.Write	"                      <td bgColor=""" & strPopUpTableColor & """ valign=""middle""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewLine & _
					"                      <select name=""ReceiveEMail"">" & vbNewLine & _
					"                      	<option value=""1"""
			if rs("M_RECEIVE_EMAIL") <> "0" then Response.Write(" selected")
			Response.Write	">Yes</option>" & vbNewLine & _
					"                      	<option value=""0"""
			if rs("M_RECEIVE_EMAIL") = "0" then Response.Write(" selected")
			Response.Write	">No</option>" & vbNewLine & _
					"                      </select></font></td>" & vbNewLine
		end if
		Response.Write	"                    </tr>" & vbNewLine
		if strAIM = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>AIM:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""AIM"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_AIM"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strICQ = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>ICQ:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""ICQ"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_ICQ"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strMSN = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>MSN:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""MSN"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_MSN"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strYAHOO = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>YAHOO IM:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""YAHOO"" size=""25"" maxLength=""50"" value="""
			if strMode <> "Register" then Response.Write(ChkString(rs("M_YAHOO"), "display"))
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
	end if
	if (strHomepage + strFavLinks) > 0 and not(strUseExtendedProfile) then
		Response.Write	"                    <tr>" & vbNewLine & _
				"                      <td align=""center"" bgcolor=""" & strCategoryCellColor & """ colspan=""2""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """>Links&nbsp;</font></b></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine
		if strHomepage = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Homepage:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Homepage"" size=""25"" maxLength=""255"" value="""
			if strMode <> "Register" then
				if rs("M_HOMEPAGE") <> " " and lcase(rs("M_HOMEPAGE")) <> "http://" then Response.Write(ChkString(rs("M_HOMEPAGE"), "display")) else Response.Write("http://")
			else
				Response.Write("http://")
			end if
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
		if strFavLinks = "1" then
			Response.Write	"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Cool Links:&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Link1"" size=""25"" maxLength=""255"" value="""
			if strMode <> "Register" then
				if rs("M_LINK1") <> " " and lcase(rs("M_LINK1")) <> "http://" then Response.Write(ChkString(rs("M_LINK1"), "display")) else Response.Write("http://")
			else
				Response.Write("http://")
			end if
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine & _
					"                    <tr>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """ align=""right"" valign=""middle"" nowrap width=""10%""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>&nbsp;</font></b></td>" & vbNewLine & _
					"                      <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""Link2"" size=""25"" maxLength=""255"" value="""
			if strMode <> "Register" then
				if rs("M_LINK2") <> " " and lcase(rs("M_LINK2")) <> "http://" then Response.Write(ChkString(rs("M_LINK2"), "display")) else Response.Write("http://")
			else
				Response.Write("http://")
			end if
			Response.Write	"""></font></td>" & vbNewLine & _
					"                    </tr>" & vbNewLine
		end if
	end if
	Response.Write	"                  </table>" & vbNewLine & _
			"                </td>" & vbNewLine & _
			"              </tr>" & vbNewLine & _
			"            </table>" & vbNewLine & _
			"          </td>" & vbNewLine & _
			"        </tr>" & vbNewLine & _
			"      </table>" & vbNewLine

	if strUseExtendedProfile then
		Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""default.asp"">Back To Forum</a></font></p>" & vbNewLine & _
				"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"">" & vbNewLine & _
				"        <tr>" & vbNewLine & _
				"          <td align=""center"" nowrap " & strColSpan & ">" & vbNewLine & _
				"          <input type=""hidden"" value=""" & cLng(Request.Form("MEMBER_ID")) & """ name=""MEMBER_ID"">" & vbNewLine & _
				"          <input type=""submit"" value=""Submit"" name=""Submit1"">" & vbNewLine & _
				"          </td>" & vbNewLine & _
				"        </tr>" & vbNewLine & _
				"      </table>" & vbNewLine
	else
		Response.Write	"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"">" & vbNewLine & _
				"        <tr>" & vbNewLine & _
				"          <td align=""center"" nowrap " & strColSpan & ">" & vbNewLine & _
				"          <input type=""hidden"" value=""" & cLng(Request.Form("MEMBER_ID")) & """ name=""MEMBER_ID"">" & vbNewLine & _
				"          <input type=""submit"" value=""Submit"" name=""Submit1"">" & vbNewLine & _
				"          </td>" & vbNewLine & _
				"        </tr>" & vbNewLine & _
				"      </table>" & vbNewLine
	end if
	on error goto 0
end Sub
%>
