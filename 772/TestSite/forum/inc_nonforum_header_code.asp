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

'## START - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT
Response.Write	"<meta name=""copyright"" content=""This Forum code is Copyright (C) 2000-04 Michael Anderson, Pierre Gorissen, Huw Reddick and Richard Kinser, Non-Forum Related code is Copyright (C) " & strCopyright & """>" & vbNewline 
'## END   - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT

if Application(strCookieURL & "down") then 
	if not Instr(strScriptName,"admin_") > 0 then
		Response.redirect("down.asp")
	end if
end if

if strShowTimer = "1" then
	'### start of timer code
	Dim StopWatch(19) 

	sub StartTimer(x)
		StopWatch(x) = timer
	end sub

	function StopTimer(x)
		EndTime = Timer

		'Watch for the midnight wraparound...
		if EndTime < StopWatch(x) then
			EndTime = EndTime + (86400)
		end if

		StopTimer = EndTime - StopWatch(x)
	end function

	StartTimer 1

	'### end of timer code
end if

set my_Conn = Server.CreateObject("ADODB.Connection")
my_Conn.Open strConnString

if (strAuthType = "nt") then
	call NTauthenticate()
	if (ChkAccountReg() = "1") then
		call NTUser()
	end if
end if

strArchiveTablePrefix = strTablePrefix & "A_"
strScriptName = request.servervariables("script_name")
strReferer = chkString(request.servervariables("HTTP_REFERER"),"refer")

if strPageBGImageURL = "" then
	strTmpPageBGImageURL = ""
elseif Instr(strPageBGImageURL,"/") > 0 or Instr(strPageBGImageURL,"\") > 0 then
	strTmpPageBGImageURL = " background=""" & strPageBGImageURL & """"
else
	strTmpPageBGImageURL = " background=""" & strImageUrl & strPageBGImageURL & """"
end if

if strGroupCategories = "1" then
	if Request.QueryString("Group") = "" then
		if Request.Cookies(strCookieURL & "GROUP") = "" Then
			Group = 2
		else 
			Group = Request.Cookies(strCookieURL & "GROUP")
		end if
	else
		Group = cLng(Request.QueryString("Group"))
	end if
	'set default
	Session(strCookieURL & "GROUP_ICON") = "icon_group_categories.gif"
	Session(strCookieURL & "GROUP_IMAGE") = strTitleImage
	'Forum_SQL - Group exists ?
	strSql = "SELECT GROUP_ID, GROUP_NAME, GROUP_ICON, GROUP_IMAGE " 
	strSql = strSql & " FROM " & strTablePrefix & "GROUP_NAMES "
	strSql = strSql & " WHERE GROUP_ID = " & Group
	set rs2 = my_Conn.Execute (strSql)
	if rs2.EOF or rs2.BOF then
		Group = 2
		strSql = "SELECT GROUP_ID, GROUP_NAME, GROUP_ICON, GROUP_IMAGE " 
		strSql = strSql & " FROM " & strTablePrefix & "GROUP_NAMES "
		strSql = strSql & " WHERE GROUP_ID = " & Group
		set rs2 = my_Conn.Execute (strSql)
	end if	
	Session(strCookieURL & "GROUP_NAME") = rs2("GROUP_NAME")
	if instr(rs2("GROUP_ICON"), ".") then
		Session(strCookieURL & "GROUP_ICON") = rs2("GROUP_ICON")
	end if
	if instr(rs2("GROUP_IMAGE"), ".") then
		Session(strCookieURL & "GROUP_IMAGE") = rs2("GROUP_IMAGE")
	end if
	rs2.Close  
	set rs2 = nothing  
	Response.Cookies(strCookieURL & "GROUP") = Group
	Response.Cookies(strCookieURL & "GROUP").Expires =  dateAdd("d", intCookieDuration, strForumTimeAdjust)
	if Session(strCookieURL & "GROUP_IMAGE") <> "" then
		strTitleImage = Session(strCookieURL & "GROUP_IMAGE") 
	end if 
end if

strDBNTUserName = Request.Cookies(strUniqueID & "User")("Name")
strDBNTFUserName = trim(chkString(Request.Form("Name"),"SQLString"))
if strDBNTFUserName = "" then strDBNTFUserName = trim(chkString(Request.Form("User"),"SQLString"))
if strAuthType = "nt" then
	strDBNTUserName = Session(strCookieURL & "userID")
	strDBNTFUserName = Session(strCookieURL & "userID")
end if

if strRequireReg = "1" and strDBNTUserName = "" then
	if not Instr(strScriptName,"policy.asp") > 0 and _
	not Instr(strScriptName,"register.asp") > 0 and _
	not Instr(strScriptName,"password.asp") > 0 and _
	not Instr(strScriptName,"faq.asp") > 0 and _
	not Instr(strScriptName,"login.asp") > 0 then
		scriptname = split(request.servervariables("SCRIPT_NAME"),"/")
		if Request.QueryString <> "" then
			Response.Redirect("login.asp?target=" & lcase(scriptname(ubound(scriptname))) & "?" & Request.QueryString)
		else
			Response.Redirect("login.asp?target=" & lcase(scriptname(ubound(scriptname))))
		end if
	end if
end if

select case Request.Form("Method_Type")
	case "login"
		strEncodedPassword = sha256("" & Request.Form("Password"))
		select case chkUser(strDBNTFUserName, strEncodedPassword,-1)
			case 1, 2, 3, 4
				Call DoCookies(Request.Form("SavePassword"))
				strLoginStatus = 1
	'Need to get navbar Shopping Cart session variables
%>
<!--#include virtual="/includes/navbar_getCartValues.asp" -->
<%
			case else
				strLoginStatus = 0
			end select
			
		Response.Write	"      </table>" & vbNewLine & _
				"    </td>" & vbNewLine & _
				"  </tr>" & vbNewLine & _
				"</table>" & vbNewLine
		if strLoginStatus = 0 then
			Response.Write	"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Your username and/or password were incorrect.</font></p>" & vbNewLine & _
					"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Please either try again or register for an account.</font></p>" & vbNewLine
		else
			Response.Write	"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>You logged on successfully!</font></p>" & vbNewLine & _
					"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Thank you for your participation.</font></p>" & vbNewLine
		end if
		Response.Write	"<meta http-equiv=""Refresh"" content=""2; URL=" & strReferer & """>" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""" & strReferer & """>Back!</font></a></p>" & vbNewLine & _
				"<table align=""center"" border=""0"" cellPadding=""0"" cellSpacing=""0"" width=""95%"">" & vbNewLine & _
				"  <tr>" & vbNewLine & _
				"    <td>" & vbNewLine
		WriteFooter
		Response.End
	case "logout"
		Call ClearCookies()
		Response.Write	"      </table>" & vbNewLine & _
				"    </td>" & vbNewLine & _
				"  </tr>" & vbNewLine & _
				"</table>" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>You logged out successfully!</font></p>" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Thank you for your participation.</font></p>" & vbNewLine & _
				"<meta http-equiv=""Refresh"" content=""2; URL=/index.asp"">" & vbNewLine & _
				"<p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""/index.asp"">Back Home!</font></a></p>" & vbNewLine & _
				"<table align=""center"" border=""0"" cellPadding=""0"" cellSpacing=""0"" width=""95%"">" & vbNewLine & _
				"  <tr>" & vbNewLine & _
				"    <td>" & vbNewLine
		WriteFooter
		Response.End
end select

if trim(strDBNTUserName) <> "" and trim(Request.Cookies(strUniqueID & "User")("Pword")) <> "" then
	If Session.Contents("Cart_Init") <> 1 Then
		getCartValues = true
	End If
	chkCookie = 1
	mLev = cLng(chkUser(strDBNTUserName, Request.Cookies(strUniqueID & "User")("Pword"),-1))
	chkCookie = 0
	If getCartValues = true Then
%>
<!--#include virtual="/includes/navbar_getCartValues.asp" -->
<%
	End IF
else
	MemberID = -1
	mLev = 0
end if

if mLev = 4 and strEmailVal = "1" and strRestrictReg = "1" and strEmail = "1" then
	'## Forum_SQL - Get membercount from DB 
	strSql = "SELECT COUNT(MEMBER_ID) AS U_COUNT FROM " & strMemberTablePrefix & "MEMBERS_PENDING WHERE M_APPROVE = " & 0

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open strSql, my_Conn

	if not rs.EOF then
		User_Count = cLng(rs("U_COUNT"))
	else
		User_Count = 0
	end if

	rs.close
	set rs = nothing
end if


sub sForumNavigation()
	' DEM --> Added code to show the subscription line
	if strSubscription > 0 and strEmail = "1" then
		if mlev > 0 then
			strSql = "SELECT COUNT(*) AS MySubCount FROM " & strTablePrefix & "SUBSCRIPTIONS"
			strSql = strSql & " WHERE MEMBER_ID = " & MemberID
			set rsCount = my_Conn.Execute (strSql)
			if rsCount.BOF or rsCount.EOF then
				' No Subscriptions found, do nothing
				MySubCount = 0
				rsCount.Close
				set rsCount = nothing
			else
				MySubCount = rsCount("MySubCount")
				rsCount.Close
				set rsCount = nothing
			end if
			if mLev = 4 then
				strSql = "SELECT COUNT(*) AS SubCount FROM " & strTablePrefix & "SUBSCRIPTIONS"
				set rsCount = my_Conn.Execute (strSql)
				if rsCount.BOF or rsCount.EOF then
					' No Subscriptions found, do nothing
					SubCount = 0
					rsCount.Close
					set rsCount = nothing
				else
					SubCount = rsCount("SubCount")
					rsCount.Close
					set rsCount = nothing
				end if
			end if
		else
			SubCount = 0
			MySubCount = 0
		end if
	else
		SubCount = 0
		MySubCount = 0
	end if
	Response.Write	"          <a href=""" & strHomeURL & """" & dWStatus("Homepage") & " tabindex=""-1""><acronym title=""Homepage"">Home</acronym></a>" & vbNewline & _
			"          |" & vbNewline
	if strUseExtendedProfile then 
		Response.Write	"          <a href=""pop_profile.asp?mode=Edit""" & dWStatus("Edit your personal profile...") & " tabindex=""-1""><acronym title=""Edit your personal profile..."">Profile</acronym></a>" & vbNewline
	else
		Response.Write	"          <a href=""javascript:openWindow3('pop_profile.asp?mode=Edit')""" & dWStatus("Edit your personal profile...") & " tabindex=""-1""><acronym title=""Edit your personal profile..."">Profile</acronym></a>" & vbNewline
	end if 
	if strAutoLogon <> "1" then
		if strProhibitNewMembers <> "1" then
			Response.Write	"          |" & vbNewline & _
					"          <a href=""policy.asp""" & dWStatus("Register to post to our forum...") & " tabindex=""-1""><acronym title=""Register to post to our forum..."">Register</acronym></a>" & vbNewline
		end if
	end if
	Response.Write	"          |" & vbNewline & _
			"          <a href=""active.asp""" & dWStatus("See what topics have been active since your last visit...") & " tabindex=""-1""><acronym title=""See what topics have been active since your last visit..."">Active Topics</acronym></a>" & vbNewline 
	' DEM --> Start of code added to show subscriptions if they exist
	if (strSubscription > 0) then
		if mlev = 4 and SubCount > 0 then
			Response.Write	"          |" & vbNewline & _
					"          <a href=""subscription_list.asp?MODE=all""" & dWStatus("See all current subscriptions") & " tabindex=""-1""><acronym title=""See all current subscriptions"">All Subscriptions</acronym></a>" & vbNewline
		end if
		if MySubCount > 0 then
			Response.Write	"          |" & vbNewline & _
					"          <a href=""subscription_list.asp""" & dWStatus("See all of your subscriptions") & " tabindex=""-1""><acronym title=""See all of your subscriptions"">My Subscriptions</acronym></a>" & vbNewline
		end if
	end if
	' DEM --> End of Code added to show subscriptions if they exist
	Response.Write	"          |" & vbNewline & _
			"          <a href=""members.asp""" & dWStatus("Current members of these forums...") & " tabindex=""-1""><acronym title=""Current members of these forums..."">Members</acronym></a>" & vbNewline & _
			"          |" & vbNewline & _
			"          <a href=""search.asp"
	if Request.QueryString("FORUM_ID") <> "" then Response.Write("?FORUM_ID=" & cLng(Request.QueryString("FORUM_ID")))
	Response.Write	"""" & dWStatus("Perform a search by keyword, date, and/or name...") & " tabindex=""-1""><acronym title=""Perform a search by keyword, date, and/or name..."">Search</acronym></a>" & vbNewline & _
			"          |" & vbNewline & _
			"          <a href=""faq.asp""" & dWStatus("Answers to Frequently Asked Questions...") & " tabindex=""-1""><acronym title=""Answers to Frequently Asked Questions..."">FAQ</acronym></a>"
end sub

 %>
