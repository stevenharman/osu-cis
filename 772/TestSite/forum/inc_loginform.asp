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
if (mlev = 0) then
	if not(Instr(Request.ServerVariables("Path_Info"), "register.asp") > 0) and _
	not(Instr(Request.ServerVariables("Path_Info"), "policy.asp") > 0) and _
	not(Instr(Request.ServerVariables("Path_Info"), "pop_profile.asp") > 0) and _
	not(Instr(Request.ServerVariables("Path_Info"), "login.asp") > 0) and _
	not(Instr(Request.ServerVariables("Path_Info"), "password.asp") > 0) and _
	not(Instr(Request.ServerVariables("Path_Info"), "post.asp") > 0) then
		Response.Write	"        <form action=""" & Request.ServerVariables("URL") & """ method=""post"" id=""form1"" name=""form1"">" & vbNewLine & _
				"        <input type=""hidden"" name=""Method_Type"" value=""login"">" & vbNewLine & _
				"            <table class=""Body-Small-txt"">" & vbNewLine & _
				"              <tr>" & vbNewLine
		if (strAuthType = "db") then
			Response.Write	"                <td><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """><b>Username:</b></font><br />" & vbNewLine & _
					"                <input type=""text"" name=""Name"" size=""10"" maxLength=""25"" value=""""><br />" & vbNewLine & _
					"                <font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """><b>Password:</b></font><br />" & vbNewLine & _
					"                <input type=""password"" name=""Password"" size=""10"" maxLength=""25"" value=""""><br />" & vbNewLine
			if strGfxButtons = "1" then
				Response.Write	"                <input src=""" & strImageUrl & "button_login.gif"" type=""image"" border=""0"" value=""Login"" id=""submit1"" name=""Login"">" & vbNewLine
			else
				Response.Write	"                <input type=""submit"" value=""Login"" id=""submit1"" name=""submit1"">" & vbNewLine
			end if 
			Response.Write	"                </td>" & vbNewLine & _
					"              </tr>" & vbNewLine & _
					"              <tr>" & vbNewLine & _
					"                <td colspan=""3"" align=""left""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewLine & _
					"                <input type=""checkbox"" name=""SavePassWord"" value=""true"" tabindex=""-1""><b> Save Password</b></font></td>" & vbNewLine
		else
			if (strAuthType = "nt") then 
				Response.Write	"                <td><font face=""" & strDefaultFontFace & """ size=""1""  color=""" & strHiLiteFontColor & """>Please <a href=""policy.asp"" tabindex=""-1"">register</a> to post in these Forums</font></td>" & vbNewLine
			end if
		end if 
		Response.Write	"              </tr>" & vbNewLine
		if (lcase(strEmail) = "1") then
			Response.Write	"              <tr>" & vbNewLine & _
					"                <td colspan=""3"" align=""left""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewLine & _
					"                <a href=""/forum/password.asp""" & dWStatus("Choose a new password if you have forgotten your current one...") & " tabindex=""-1"">Forgot your "
			if strAuthType = "nt" then Response.Write("Admin ")
			Response.Write	"Password?</a><br /><a href=""/forum/policy.asp""" & dWStatus("Need to Register for www.BCRocket.com?  Go Here!") & " tabindex=""-1"">Need to Register?</a>" & vbNewLine
			if (lcase(strNoCookies) = "1") then
				Response.Write	"                |" & vbNewLine & _
						"                <a href=""/forum/admin_home.asp""" & dWStatus("Access the Forum Admin Functions...") & " tabindex=""-1"">Admin Options</a>" & vbNewLine
			end if
			Response.Write	"                <br /><br /></font></td>" & vbNewLine & _
					"              </tr>" & vbNewLine
		end if
		Response.Write	"            </table>" & vbNewLine & _
				"        </form>" & vbNewLine
	end if
else
	Response.Write	"        <form action=""" & Request.ServerVariables("URL") & """ method=""post"" id=""form2"" name=""form2"">" & vbNewLine & _
			"        <input type=""hidden"" name=""Method_Type"" value=""logout"">" & vbNewLine & _
			"            <table class=""Body-Small-txt"">" & vbNewLine & _
			"              <tr>" & vbNewLine & _
			"                <td align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>You are logged on as<br />"
	if strAuthType="nt" then
		Response.Write	"<b>" & Session(strCookieURL & "username") & "&nbsp;(" & Session(strCookieURL & "userid") & ")</b></font></td>" & vbNewLine & _
				"                <td>&nbsp;"
	else 
		if strAuthType = "db" then 
			if strUseExtendedProfile then
				Response.Write	"<b><a href=""pop_profile.asp?mode=display&id=" & MemberID & """" & dWStatus("View " & ChkString(strDBNTUserName,"display") & "'s Profile") & ">" & ChkString(strDBNTUserName, "display") & "</a></b></font><br />"
			else
				Response.Write	"<b><a href=""JavaScript:openWindow3('pop_profile.asp?mode=display&id=" & MemberID & "')""" & dWStatus("View " & ChkString(strDBNTUserName,"display") & "'s Profile") & ">" & ChkString(strDBNTUserName, "display") & "</a></b></font><br />"
			end if
		'	Response.Write	"<b>" & ChkString(strDBNTUserName, "display") & "</b></font><br /><br />" & vbNewLine
			if strGfxButtons = "1" then
				Response.Write	"<input src=""/forum/" & strImageUrl & "button_logout.gif"" type=""image"" border=""0"" value=""Logout"" id=""submit1"" name=""Logout"" tabindex=""-1"">"
			else
				Response.Write	"<input type=""submit"" value=""Logout"" id=""submit1"" name=""submit1"" tabindex=""-1"">"
			end if 
		end if 
	end if 
	Response.Write	"</td>" & vbNewLine & _
			"              </tr>" & vbNewLine
	if (mlev = 4) or (lcase(strNoCookies) = "1") then
		Response.Write	"        <tr>" & vbNewLine & _
				"          <td align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """><a href=""/forum/admin_home.asp""" & dWStatus("Access the Forum Admin Functions...") & " tabindex=""-1"">Admin Options</a>"
		if mLev = 4 and (strEmailVal = "1" and strRestrictReg = "1" and strEmail = "1" and User_Count > 0) then Response.Write("&nbsp;|&nbsp;<a href=""/forum/admin_accounts_pending.asp""" & dWStatus("(" & User_Count & ") Member(s) awaiting approval") & " tabindex=""-1"">(" & User_Count & ") Member(s) awaiting approval</a>")
		Response.Write	"<br /><br /></font></td>" & vbNewLine & _
				"        </tr>" & vbNewLine
	end if
	Response.Write	"            </table>" & vbNewLine & _  
	"     			</form>" & vbNewLine
end if
 %>
