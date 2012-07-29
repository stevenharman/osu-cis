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
<!--#INCLUDE FILE="inc_func_member.asp" -->
<!--#INCLUDE FILE="inc_func_posting.asp"-->
<!--#include file="inc_profile.asp"-->
<%
Dim strURLError
Response.Write	"      <table width=""100%"" border=""0"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & getCurrentIcon(strIconFolderOpen,"","") & "&nbsp;<a href=""default.asp"">All Forums</a><br />" & vbNewLine & _
		"          " & getCurrentIcon(strIconBar,"","") & getCurrentIcon(strIconFolderOpenTopic,"","") & "&nbsp;Registration Rules and Policies Agreement<br />" & vbNewLine & _
		"          " & getCurrentIcon(strIconBlank,"","") & getCurrentIcon(strIconBar,"","") & getCurrentIcon(strIconFolderOpenTopic,"","") & "&nbsp;Registration Form for " & strForumTitle & "</font></td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine

if strProhibitNewMembers <> "1" then
	if Request.QueryString("mode") <> "DoIt" and Request.QueryString("actkey") = "" then
		if InStr(strReferer, "policy.asp") = 0 then
			Response.Redirect("policy.asp")
		end if
		if strAuthType = "nt" and ChkAccountReg = "1" then
			Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Registration for this account is not necessary.</b></font></p>" & vbNewLine & _
					"      <table align=""center"">" & vbNewLine & _
					"        <tr>" & vbNewLine & _
					"          <td><ul><li>This NT User account has already been registered.</li></ul></td>" & vbNewLine & _
					"        </tr>" & vbNewLine & _
					"      </table>" & vbNewLine
			WriteFooter
			Response.End
		end if

		if strUseExtendedProfile then
			strColspan = " colspan=""2"""
		else
			strColspan = ""
		end if

		call ShowForm
	'################################ E-mail Validation Mod #################################
	elseif Request.QueryString("actkey") <> "" and lcase(strEmail) = "1" and strEmailVal = "1" then
		key = chkString(Request.QueryString("actkey"),"SQLString")

		'###Forum_SQL
		'strSql = "SELECT M_NAME, M_USERNAME, M_PASSWORD, M_KEY, M_LEVEL, M_EMAIL, M_DATE, M_COUNTRY, M_AIM, M_ICQ, M_MSN, M_YAHOO" & _
		'	 ", M_POSTS, M_HOMEPAGE, M_LASTHEREDATE, M_STATUS, M_RECEIVE_EMAIL, M_LAST_IP, M_IP, M_SIG, M_VIEW_SIG, M_SIG_DEFAULT" & _
		'	 ", M_FIRSTNAME, M_LASTNAME, M_CITY, M_STATE, M_PHOTO_URL, M_LINK1, M_LINK2, M_AGE, M_DOB, M_MARSTATUS, M_SEX, M_OCCUPATION" & _
		'	 ", M_BIO, M_HOBBIES, M_LNEWS, M_QUOTE, M_SHA256" & _
		'	 " FROM " & strMemberTablePrefix & "MEMBERS_PENDING" & _
		'	 " WHERE M_KEY = '" & key & "'"
		set rsKey = Server.CreateObject("ADODB.RecordSet")

		dim m_bio, m_hobbies, m_lnews, m_quote

		'get the hobbies
		strSql = "SELECT M_HOBBIES FROM forum_members_pending WHERE M_KEY = '" & key & "'"
		rsKey.Open strSql, my_Conn
		rsKey.MoveFirst
		'm_hobbies = rsKey("M_HOBBIES")		
		rsKey.Close
				
		'get the bio
		strSql = "SELECT M_BIO FROM forum_members_pending WHERE M_KEY = '" & key & "'"
		rsKey.Open strSql, my_Conn
		rsKey.MoveFirst
		'm_bio = rsKey("M_BIO")
		rsKey.Close
		

		
		'get the quote
		strSql = "SELECT M_QUOTE FROM forum_members_pending WHERE M_KEY = '" & key & "'"
		rsKey.Open strSql, my_Conn
		rsKey.MoveFirst
		'm_quote = rsKey("m_quote")
		rsKey.Close
				
		'get the news
		strSql = "SELECT M_LNEWS FROM forum_members_pending WHERE M_KEY = '" & key & "'"
		rsKey.Open strSql, my_Conn
		rsKey.MoveFirst
		'm_lnews = rsKey("m_lnews")				
		rsKey.Close
		
		set rsKey = Nothing
		
		strSql = "SELECT * FROM forum_members_pending WHERE M_KEY = '" & key & "'"
		set rsKey = my_Conn.Execute (strSql)
		
		

		if rsKey.EOF or rsKey.BOF then '## activation key not found add in ""
			'Error message to user
			Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """ color=""" & strHiLiteFontColor & """><b>Activation Key Not Found!</b></font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHiLiteFontColor & """>Your activation key was not found in our database.<br />Please try registering again by clicking the Register link at the top right hand corner.<br />If this problem persists, please contact the <a href=""mailto:" & strSender & """>Administrator</a> of the forums.</font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""default.asp"">Back To Forum</font></a></p>" & vbNewLine
		elseif strComp(key,rsKey("M_KEY")) <> 0 then
			'Error message to user
			Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """ color=""" & strHiLiteFontColor & """><b>Activation Key Did Not Match!</b></font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHiLiteFontColor & """>Your activation key did not match the one that we have in our database.<br />Please try registering again by clicking the Register link at the top right hand corner.<br />If this problem persists, please contact the <a href=""mailto:" & strSender & """>Administrator</a> of the forums.</font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""default.asp"">Back To Forum</font></a></p>" & vbNewLine
		else
			'## Forum_SQL
			
			
			
			strSql = "INSERT INTO " & strMemberTablePrefix & "MEMBERS "
			strSql = strSql & "(M_NAME"
			strSql = strSql & ", M_USERNAME"
			strSql = strSql & ", M_PASSWORD"
			strSql = strSql & ", M_LEVEL"
			strSql = strSql & ", M_EMAIL"
			strSql = strSql & ", M_DATE"
			strSql = strSql & ", M_COUNTRY"
			strSql = strSql & ", M_AIM"
			strSql = strSql & ", M_ICQ"
			strSql = strSql & ", M_MSN"
			strSql = strSql & ", M_YAHOO"
			strSql = strSql & ", M_POSTS"
			strSql = strSql & ", M_HOMEPAGE"
			strSql = strSql & ", M_LASTHEREDATE"
			strSql = strSql & ", M_STATUS"
			strSql = strSql & ", M_RECEIVE_EMAIL"
			strSql = strSql & ", M_LAST_IP"
			strSql = strSql & ", M_IP"
			strSql = strSql & ", M_SIG" 'MOVED M SIG LINE
			strSql = strSql & ", M_VIEW_SIG"
			strSql = strSql & ", M_SIG_DEFAULT"
			strSql = strSql & ", M_FIRSTNAME"
			strSql = strSql & ", M_LASTNAME"
			strSql = strSql & ", M_CITY"
			strSql = strSql & ", M_STATE"
			strSql = strSql & ", M_PHOTO_URL"
			strSql = strSql & ", M_LINK1"
			strSql = strSql & ", M_LINK2"
			strSql = strsql & ", M_AGE"
			strSql = strsql & ", M_DOB"
			strSql = strSql & ", M_MARSTATUS"
			strSql = strsql & ", M_SEX"
			strSql = strSql & ", M_OCCUPATION"
			strSql = strSql & ", M_HOBBIES"
			strsql = strsql & ", M_LNEWS"
			strSql = strSql & ", M_QUOTE"
			strSql = strSql & ", M_BIO"
			strSql = strSql & ", M_SHA256"
			strSql = strSql & ", M_ADDR1"			
			strSql = strSql & ", M_ADDR2"
			strSql = strSql & ", M_ZIP"
			
			strSql = strSql & ") "
			strSql = strSql & " VALUES ("
			strSql = strSql & "'" & chkString(rsKey("M_NAME"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_USERNAME"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_PASSWORD"),"SQLString") & "'"
			strSql = strSql & ", " & "1"
			strSql = strSql & ", '" & chkString(rsKey("M_EMAIL"),"SQLString") & "'"
			strSql = strSql & ", '" & DateToStr(strForumTimeAdjust) & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_COUNTRY"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_AIM"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_ICQ"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_MSN"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_YAHOO"),"SQLString") & "'"
			strSql = strSql & ", 0"
			strSql = strSql & ", '" & chkString(rsKey("M_HOMEPAGE"),"SQLString") & "'"
			strSql = strSql & ", '" & DateToStr(strForumTimeAdjust) & "'"
			strSql = strSql & ", 1"
			strSql = strSql & ", " & cLng(rsKey("M_RECEIVE_EMAIL")) & " "
			strSql = strSql & ", '" & chkString(rsKey("M_LAST_IP"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_IP"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_SIG"),"message") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_VIEW_SIG"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_SIG_DEFAULT"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_FIRSTNAME"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_LASTNAME"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_CITY"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_STATE"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_PHOTO_URL"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_LINK1"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_LINK2"),"SQLString") & "'"
			strSql = strsql & ", '" & chkString(rsKey("M_AGE"),"SQLString") & "'"
			strSql = strsql & ", '" & chkString(rsKey("M_DOB"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_MARSTATUS"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_SEX"),"SQLString") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_OCCUPATION"),"SQLString") & "'"
			strSql = strSql & ", '" & cstr(rsKey("M_HOBBIES")) & "'"
			strSql = strSql & ", '" & cstr(rsKey("M_LNEWS")) & "'"
			strSql = strSql & ", '" & cstr(rsKey("M_QUOTE")) & "'"
			strSql = strSql & ", '" & cstr(rsKey("M_BIO")) & "'"
			strSql = strSql & ", 1"
			strSql = strSql & ", '" & chkString(rsKey("M_ADDR1"),"message") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_ADDR2"),"message") & "'"
			strSql = strSql & ", '" & chkString(rsKey("M_ZIP"),"message") & "'"
			strSql = strSql & ")"

			'Response.Write strSql
			my_Conn.Execute (strSql),,adCmdText + adExecuteNoRecords

			Call DoCount

			'## Forum_SQL - Delete the Member
			strSql = "DELETE FROM " & strMemberTablePrefix & "MEMBERS_PENDING "
			strSql = strSql & " WHERE M_KEY = '" & key & "'"

			my_Conn.Execute (strSql),,adCmdText + adExecuteNoRecords

			Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """><b>Your Registration Has Been Completed!</b></font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>You may now begin posting"
			if strAuthType="db" then Response.Write(" using your new UserName and Password")
			Response.Write	".</font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""default.asp"">Back To Forum</font></a></p>" & vbNewLine
		end if

		rsKey.close
		set rsKey = nothing
	'#####################################################################################
	else
		strEncodedPassword = sha256("" & trim(Request.Form("Password")))

		Err_Msg = ""

		if strAutoLogon <> 1 then
			if trim(Request.Form("Name")) = "" then
				Err_Msg = Err_Msg & "<li>You must choose a UserName</li>"
			end if
			if Len(trim(Request.Form("Name"))) < 3 then
				Err_Msg = Err_Msg & "<li>Your UserName must be at least <strong>3</strong> characters long</li>"
			end if
		end if

		'## Forum_SQL
		strSql = "SELECT M_NAME FROM " & strMemberTablePrefix & "MEMBERS "
		strSql = strSql & " WHERE M_NAME = '" & ChkString(Trim(Request.Form("Name")), "SQLString") &"'"

		set rs = my_Conn.Execute (strSql)

		if rs.BOF and rs.EOF then
			'## Do Nothing
		else
			Err_Msg = Err_Msg & "<li>UserName already in Use, Please Choose Another</li>"
		end if

		rs.close
		set rs = nothing

		if strEmail = "1" and strEmailVal = "1" then
			'## Forum_SQL
			strSql = "SELECT M_NAME FROM " & strMemberTablePrefix & "MEMBERS_PENDING "
			strSql = strSql & " WHERE M_NAME = '" & ChkString(Trim(Request.Form("Name")), "SQLString") &"'"

			set rs = my_Conn.Execute (strSql)

			if rs.BOF and rs.EOF then
				'## Do Nothing
			else
				Err_Msg = Err_Msg & "<li>UserName already in Use, Please Choose Another</li>"
			end if
			rs.close
			set rs = nothing
		end if

		if strUserNameFilter = "1" then
			chkNameFilter(trim(Request.Form("Name")))
		end if

		if strBadWordFilter = "1" then
			chkNameBadWords(trim(Request.Form("Name")))
		end if
		if not IsValidString(trim(Request.Form("Name"))) then
			Err_Msg = Err_Msg & "<li>You may not use any of these chars in your username  !#$%^&*()=+{}[]|\;:/?>,<' </li>"
		end if
		'## NT authentication no additional password needed
		if strAuthType = "db" then
			if not IsValidString(trim(Request.Form("Password"))) then
				Err_Msg = Err_Msg & "<li>You may not use any of these chars in your password  !#$%^&*()=+{}[]|\;:/?>,<' </li>"
			end if

			if trim(Request.Form("Password")) = "" then
				Err_Msg = Err_Msg &  "<li>You must choose a Password</li>"
			end if

			if Len(Request.Form("Password")) > 25 then
				Err_Msg = Err_Msg & "<li>Your Password can not be greater than 25 characters</li>"
			end if

			if Request.Form("Password") <> Request.Form("Password2") then
				Err_Msg = Err_Msg & "<li>Your Passwords didn't match.</li>"
			end if
		end if

		If strAutoLogon <> 1 then
			if Request.Form("Email") = "" then
				Err_Msg = Err_Msg & "<li>You Must give an e-mail address</li>"
			end if

			if Request.Form("Email") <> Request.Form("Email3") then
				Err_Msg = Err_Msg & "<li>Your E-mail Addresses didn't match.</li>"
			end if

			if EmailField(Request.Form("Email")) = 0 then 
				Err_Msg = Err_Msg & "<li>You Must enter a valid e-mail address</li>"
			end if
		end if

		if strMSN = "1" and trim(Request.Form("MSN")) <> "" then
			if EmailField(Request.Form("MSN")) = 0 then 
				Err_Msg = Err_Msg & "<li>You Must enter a valid MSN Messenger Username</li>"
			end if
		end if
	
		if strAuthType = "nt" and ChkAccountReg = "true" then
			Err_Msg = Err_Msg & "<li>NT User Account already registered.</li>"
		end if

		if strUniqueEmail = "1" then
			'## Forum_SQL
			strSql = "SELECT M_EMAIL FROM " & strMemberTablePrefix & "MEMBERS "
			strSql = strSql & " WHERE M_EMAIL = '" & Trim(chkString(Request.Form("Email"),"SQLString")) &"'"

			set rs = my_Conn.Execute(TopSQL(strSql,1))

			if rs.BOF and rs.EOF then 
				'## Do Nothing
			else
				Err_Msg = Err_Msg & "<li>E-mail Address already in use, Please Choose Another</li>"
			end if
			set rs = nothing

			if strEmail = "1" and strEmailVal = "1" then
				'## Forum_SQL
				strSql = "SELECT M_EMAIL FROM " & strMemberTablePrefix & "MEMBERS_PENDING "
				strSql = strSql & " WHERE M_EMAIL = '" & Trim(chkString(Request.Form("Email"),"SQLString")) &"'"

				set rs = my_Conn.Execute(TopSQL(strSql,1))

				if rs.BOF and rs.EOF then 
					'## Do Nothing
				else
					Err_Msg = Err_Msg & "<li>E-mail Address already in use, Please Choose Another</li>"
				end if
				set rs = nothing

				'## Forum_SQL
				strSql = "SELECT M_NEWEMAIL FROM " & strMemberTablePrefix & "MEMBERS "
				strSql = strSql & " WHERE M_NEWEMAIL = '" & Trim(ChkString(Request.Form("Email"),"SQLString")) &"'"

				set rs = my_Conn.Execute(TopSQL(strSql,1))

				if rs.BOF and rs.EOF then 
					'## Do Nothing
				else
					Err_Msg = Err_Msg & "<li>E-mail Address already in use, Please Choose Another</li>"
				end if
				set rs = nothing
			end if
		end if
		if not IsValidURL(trim(Request.Form("Homepage"))) then
			Err_Msg = Err_Msg & "<li>Homepage URL: Invalid URL" & strURLError & "</li>"
		end if
		if not IsValidURL(trim(Request.Form("LINK1"))) then
			Err_Msg = Err_Msg & "<li>Cool Links URL: Invalid URL" & strURLError & "</li>"
		end if
		if not IsValidURL(trim(Request.Form("LINK2"))) then
			Err_Msg = Err_Msg & "<li>Cool Links URL: Invalid URL" & strURLError & "</li>"
		end if
		if not IsValidURL(trim(Request.Form("Photo_URL"))) then
			Err_Msg = Err_Msg & "<li>Photo URL: Invalid URL" & strURLError & "</li>"
		end if
		if trim(Request.Form("Addr1")) = "" then
			Err_Msg = Err_Msg & "<li>Address line 1 invalid." & strURLError & "</li>"
		end if
		if not len(trim(Request.Form("Zip"))) = 5 OR not isnumeric(trim(Request.Form("zip"))) then
			Err_Msg = Err_Msg & "<li>Invalid zip code." & strURLerror & "</li>"		
		end if
		
		if Err_Msg = "" then
			if Trim(Request.Form("Homepage")) <> "" and lcase(trim(Request.Form("Homepage"))) <> "http://" and Trim(lcase(Request.Form("Homepage"))) <> "https://" and lcase(Request.Form("Homepage")) <> "file:///" then
				regHomepage = ChkString(Request.Form("Homepage"),"SQLString")
			else
				regHomepage = " "
			end if
			if Trim(Request.Form("LINK1")) <> "" and lcase(trim(Request.Form("LINK1"))) <> "http://" and Trim(lcase(Request.Form("LINK1"))) <> "https://" then
				regLink1 = ChkString(Request.Form("LINK1"),"SQLString")
			else
				regLink1 = " "
			end if
			if Trim(Request.Form("LINK2")) <> "" and lcase(trim(Request.Form("LINK2"))) <> "http://" and Trim(lcase(Request.Form("LINK2"))) <> "https://" then
				regLink2 = ChkString(Request.Form("LINK2"),"SQLString")
			else
				regLink2 = " "
			end if
			if Trim(Request.Form("PHOTO_URL")) <> "" and lcase(trim(Request.Form("PHOTO_URL"))) <> "http://" and Trim(lcase(Request.Form("PHOTO_URL"))) <> "https://" then
				regPhoto_URL = ChkString(Request.Form("Photo_URL"),"SQLString")
			else
				regPhoto_URL = " "
			end if

			'###### E-mail Validation Mod ######
			actkey = GetKey("none")
			'##################################

			'## Forum_SQL
			strSql = "INSERT INTO " & strMemberTablePrefix
			if strEmail = "1" and strEmailVal = "1" then
				strSql = strSql & "MEMBERS_PENDING "
			else
				strSql = strSql & "MEMBERS "
			end if
			strSql = strSql & "(M_NAME"
			if strAuthType = "nt" then
				strSql = strSql & ", M_USERNAME"
			end if
			strSql = strSql & ", M_PASSWORD"
			'######### E-mail Validation Mod ##########
			if strEmail = "1" and strEmailVal = "1" then
				strSql = strSql & ", M_KEY"
				strSql = strSql & ", M_LEVEL"
				strSql = strSql & ", M_APPROVE"
			end if
			'#########################################
			strSql = strSql & ", M_EMAIL"
			strSql = strSql & ", M_DATE"
			strSql = strSql & ", M_COUNTRY"
			strSql = strSql & ", M_AIM"
			strSql = strSql & ", M_ICQ"
			strSql = strSql & ", M_MSN"
			strSql = strSql & ", M_YAHOO"
			strSql = strSql & ", M_POSTS"
			strSql = strSql & ", M_HOMEPAGE"
			strSql = strSql & ", M_LASTHEREDATE"
			strSql = strSql & ", M_STATUS"
			strSql = strSql & ", M_RECEIVE_EMAIL"
			strSql = strSql & ", M_LAST_IP"
			strSql = strSql & ", M_IP"
			strSql = strSql & ", M_SIG"
			strSql = strSql & ", M_VIEW_SIG"
			strSql = strSql & ", M_SIG_DEFAULT"
			strSql = strSql & ", M_FIRSTNAME"
			strSql = strSql & ", M_LASTNAME"
			strsql = strsql & ", M_CITY"
			strsql = strsql & ", M_STATE"
			strsql = strsql & ", M_PHOTO_URL"
			strsql = strsql & ", M_LINK1"
			strSql = strSql & ", M_LINK2"
			strSql = strsql & ", M_AGE"
			strSql = strsql & ", M_DOB"
			strSql = strSql & ", M_MARSTATUS"
			strSql = strsql & ", M_SEX"
			strSql = strSql & ", M_OCCUPATION"
			strSql = strSql & ", M_BIO"
			strSql = strSql & ", M_HOBBIES"
			strsql = strsql & ", M_LNEWS"
			strSql = strSql & ", M_QUOTE"
			strSql = strSql & ", M_SHA256"
			strSql = strSql & ", M_ADDR1"
			strSql = strSql & ", M_ADDR2"
			strSql = strSql & ", M_ZIP"									
			strSql = strSql & ") "
			strSql = strSql & " VALUES ("
			if strAutoLogon = "1" then
				strSql = strSql & "'" & chkString(Session(strCookieURL & "strNTUserFullName"),"SQLString") & "'"
			else
				strSql = strSql & "'" & chkString(trim(Request.Form("Name")),"SQLString") & "'"
			end if
			if strAuthType = "nt" then
				strSql = strSql & ", " & "'" & chkString(strDBNTUserName,"SQLString") & "'"
			end if
			strSql = strSql & ", " & "'" & chkString(strEncodedPassword,"password") & "'"
			'################## E-mail Validation Mod ########################
			if strEmail = "1" and strEmailVal = "1" then
				strSql = strSql & ", " & "'" & chkString(actkey,"") & "'"
				strSql = strSql & ", " & "-1"
				if strRestrictReg = "1" then
					strSql = strSql & ", " & "0"
				else
					strSql = strSql & ", " & "1"
				end if
			end if
			'################################################################
			strSql = strSql & ", " & "'" & chkString(Request.Form("Email"),"SQLString") & "'"
			strSql = strSql & ", " & "'" & DateToStr(strForumTimeAdjust) & "'"
			strSql = strSql & ", " & "'" & chkString(Request.Form("Country"),"SQLString") & "'"
			strSql = strSql & ", " & "'" & chkString(Request.Form("AIM"),"SQLString") & "'"
			strSql = strSql & ", " & "'" & chkString(Request.Form("ICQ"),"SQLString") & "'"
			strSql = strSql & ", " & "'" & chkString(Request.Form("MSN"),"SQLString") & "'"
			strSql = strSql & ", " & "'" & chkString(Request.Form("YAHOO"),"SQLString") & "'"
			strSql = strSql & ", " & "0"
			strSql = strSql & ", " & "'" & chkString(Trim(regHomepage),"SQLString") & "'"
			strSql = strSql & ", " & "'" & DateToStr(strForumTimeAdjust) & "'"
			'################## E-mail Validation Mod ########################
			if strEmail = "1" and strEmailVal = "1" then
				strSql = strSql & ", " & "0"
			else
				strSql = strSql & ", " & "1"
			end if
			'strSql = strSql & ", " & "1"
			'################################################################
			strSql = strSql & ", " & cLng(Request.Form("ReceiveEMail")) & " "
			strSql = strSql & ", '" & Request.ServerVariables("REMOTE_ADDR") & "'"
			strSql = strSql & ", '" & Request.ServerVariables("REMOTE_ADDR") & "'"
			if strSignatures = "1" then
				strSql = strSql & ", " & "'" & chkString(Request.Form("Sig"),"message") & "'"
			else
				strsql = strsql & ", ''"
			end if
			if strSignatures = "1" and strDSignatures = "1" then
				strSql = strSql & ", " & cLng(Request.Form("ViewSig"))
			else
				strsql = strsql & ", " & 1
			end if
			if strSignatures = "1" then
				strSql = strSql & ", " & cLng(Request.Form("fSigDefault"))
			else
				strsql = strsql & ", " & 1
			end if
			if strFullName = "1" then
				strSql = strSql & ", '" & ChkString(Request.Form("FirstName"),"SQLString") & "'"
				strSql = strSql & ", '" & ChkString(Request.Form("LastName"),"SQLString") & "'"
			else
				strSql = strSql & ", ''"
				strSql = strSql & ", ''"
			end if
			if strCity = "1" then
				strsql = strsql & ", '" & ChkString(Request.Form("City"),"SQLString") & "'"
			else
				strsql = strsql & ", ''"
			end if
			if strState = "1" then
				strsql = strsql & ", '" & ChkString(Request.Form("State"),"SQLString") & "'"
			else
				strsql = strsql & ", ''"
			end if
			if strPicture = "1" then
				strsql = strsql & ", '" & ChkString(Trim(regPhoto_URL),"SQLString") & "'"
			else
				strsql = strsql & ", ''"
			end if
			if strFavLinks = "1" then
				strsql = strsql & ", '" & ChkString(Trim(regLink1),"SQLString") & "'"
				strSql = strSql & ", '" & ChkString(Trim(regLink2),"SQLString") & "'"
			else
				strsql = strsql & ", ''"
				strSql = strSql & ", ''"
			end if
			if strAge = "1" then
				strSql = strsql & ", '" & ChkString(Request.Form("Age"),"SQLString") & "'"
			else
				strSql = strsql & ", ''"
			end if
			if strAgeDOB = "1" then
				strSql = strsql & ", '" & ChkString(Request.Form("AgeDOB"),"SQLString") & "'"
			else
				strSql = strsql & ", ''"
			end if
			if strMarStatus = "1" then
				strSql = strSql & ", '" & ChkString(Request.Form("MarStatus"),"SQLString") & "'"
			else
				strSql = strSql & ", ''"
			end if
			if strSex = "1" then
				strSql = strsql & ", '" & ChkString(Request.Form("Sex"),"SQLString") & "'"
			else
				strSql = strSql & ", ''"
			end if
			if strOccupation = "1" then
				strSql = strSql & ", '" & ChkString(Request.Form("Occupation"),"SQLString") & "'"
			else
				strSql = strSql & ", ''"
			end if

			if strBio = "1" then
				'strSql = strSql & ", '" & ChkString(Request.Form("Bio"),"message") & "'"
				strSql = strSql & ", '" & Request.Form("bio") & "'"
			else
				strSql = strSql & ", ''"
			end if
			if strHobbies = "1" then
				'strSql = strSql & ", '" & ChkString(Request.Form("Hobbies"),"message") & "'"
				strSql = strSql & ", '" & Request.Form("hobbies") & "'"
			else
				strSql = strSql & ", ''"
			end if
			if strLNews = "1" then
				'strsql = strsql & ", '" & ChkString(Request.Form("LNews"),"message") & "'"
				strSql = strSql & ", '" & Request.Form("lnews") & "'"				
			else
				strSql = strSql & ", ''"
			end if
			if strQuote = "1" then
				'strSql = strSql & ", '" & ChkString(Request.Form("Quote"),"message") & "'"
				strSql = strSql & ", '" & Request.Form("quote") & "'"				
			else
				strSql = strSql & ", ''"
			end if
			strSql = strSql & ", 1" 'SHA256
			if strAddr1 = "1" then
				strSql = strSql & ", '" & Request.Form("Addr1") & "'"
			else
				strSql = strSql & ", ''"
			end if
			if strAddr2 = "1" then
				strSql = strSql & ", '" & Request.Form("Addr2") & "'"
			else
				strSql = strSql & ", ''"
			end if			
			if strZip = "1" then
				strSql = strSql & ", '" & Request.Form("Zip") & "'"
			else
				strSql = strSql & ", ''"
			end if
			
			strSql = strSql & ")"

			my_Conn.Execute (strSql),,adCmdText + adExecuteNoRecords

			if strEmail = "1" and strEmailVal = "1" then
				'Do Nothing
			else
				Call DoCount
			end if

			regHomepage = ""

			if strEmail = "1" and strRestrictReg = "0" then
				'## E-mails Message to the Author of this Reply.
				strRecipientsName = Request.Form("Name")
				strRecipients = Request.Form("Email")
				strFrom = strSender
				strFromName = strForumTitle
				strsubject = strForumTitle & " Registration "
				strMessage = "Hello " & Request.Form("name") & vbNewline & vbNewline
				strMessage = strMessage & "You received this message from " & strForumTitle & " because you have registered for a new account which allows you to post new messages and reply to existing ones on the forums at " & strForumURL & vbNewline & vbNewline
				if strAuthType="db" then
				'################################### E-mail Validation Mod #################################
					if strEmailVal = "1" then
						strMessage = strMessage & "Please click on the link below to complete your registration." & vbNewline & vbNewLine
						strMessage = strMessage & "If the link is split or broken, you will need to copy and paste the entire link into your web browser." & vbNewline & vbNewLine
						strMessage = strMessage & strForumURL & "register.asp?actkey=" & actkey & vbNewline & vbNewline
					else
				'######################################################################################
						strMessage = strMessage & "Password: " & Request.Form("Password") & vbNewline & vbNewline
					end if '<---- E-mail Validation Mod - 1 line #############
				end if
				strMessage = strMessage & "You can change your information at our website by selecting the ""Profile"" link." & vbNewline & vbNewline
				strMessage = strMessage & "Happy Posting!"
%>
<!--#INCLUDE FILE="inc_mail.asp" -->
<%
			end if
		else
			Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """ color=""" & strHiLiteFontColor & """>There Was A Problem With Your Details</font></p>" & vbNewLine & _
					"      <table align=""center"" border=""0"">" & vbNewLine & _
					"        <tr>" & vbNewLine & _
					"          <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHiLiteFontColor & """><ul>" & Err_Msg & "</ul></font></td>" & vbNewLine & _
					"        </tr>" & vbNewLine & _
					"      </table>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""JavaScript:history.go(-1)"">Go Back To Enter Data</a></font></p>" & vbNewLine
			WriteFooter
			Response.End 
		end if
		' ##################### E-mail Validation Mod #########################
		if lcase(strEmail) = "0" then
			Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Your Registration Has Been Completed!</font></p>" & vbNewLine & _
					"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>You may now begin posting"
			if strAuthType = "db" then Response.Write(" using your new UserName and Password")
			Response.Write	".</font></p>" & vbNewLine
	 	else
			if strEmailVal = "1" then
				Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Your Registration Is Almost Complete!</font></p>" & vbNewLine
			'#######################################
				if strRestrictReg = "1" then
					Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>The Administrator has restricted registration on this forum. You will receive an e-mail as soon as the Administrator approves your request.</font></p>" & vbNewLine
				else
					Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>Please follow the instructions in the e-mail that has been sent to <b>" & ChkString(Request.Form("Email"),"email") & "</b> to complete your registration.</font></p>" & vbNewLine
				end if
			'#######################################
		 	else
				Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """>Your Registration Has Been Completed!</font></p>" & vbNewLine & _
						"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>You may now begin posting"
				if strAuthType = "db" then Response.Write(" using your new UserName and Password")
				Response.Write	".</font></p>" & vbNewLine
			end if
	 	end if
		' #######################################################################

		if strAuthType = "db" then

			select case chkUser(Request.Form("Name"), Request.Form("Password"),-1)
				case 1, 2, 3, 4
					Call DoCookies("false")
					strLoginStatus = 1
				case else
					strLoginStatus = 0
			end select
		end if

		if strAutoLogon = 1 then
  			Response.Redirect "default.asp"
		else
			Response.Write	"      <meta http-equiv=""Refresh"" content=""5; URL=" & chkString(Request.Form("refer"),"refer") & """>" & vbNewLine
		end if
		Response.Write	"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""" & chkString(Request.Form("refer"),"refer") & """>Back To Forum</font></a></p>" & vbNewLine
	end if 
else
	Response.Write	"    <br /><p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """ color=""" & strHiLiteFontColor & """>Sorry, we are not accepting any new Members at this time.</font></p>" & vbNewLine & _
			"    <meta http-equiv=""Refresh"" content=""5; URL=default.asp"">" & vbNewLine & _
			"    <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""default.asp"">Back To Forum</font></a></p><br />" & vbNewLine
end if
WriteFooter
Response.End

sub DoCount
	'## Forum_SQL - Updates the Totals table by adding 1 to U_COUNT
	strSql = "UPDATE " & strTablePrefix & "TOTALS "
	strSql = strSql & " SET " & strTablePrefix & "TOTALS.U_COUNT = " & strTablePrefix & "TOTALS.U_COUNT + 1"
	my_Conn.Execute (strSql),,adCmdText + adExecuteNoRecords
end sub

sub ShowForm()
	Response.Write	"      <form action=""register.asp?mode=DoIt"" method=""Post"" id=""Form1"" name=""Form1"">" & vbNewLine & _
			"      <input name=""Refer"" type=""hidden"" value=""" & chkString(Request.Form("Refer"),"refer") & """>" & vbNewLine & _
			"      <table width=""400"" border=""0"" align=""center"">" & vbNewLine & _
			"        <tr>" & vbNewLine & _
			"          <td>" & vbNewLine
Call DisplayProfileForm
	Response.Write	"          </td>" & vbNewLine & _
			"        </tr>" & vbNewLine & _
			"      </table>" & vbNewLine & _
			"      </form>" & vbNewLine
end sub

Function IsValidURL(sValidate)
	Dim sInvalidChars
	Dim bTemp
	Dim i

	if trim(sValidate) = "" then IsValidURL = true : exit function
	sInvalidChars = """;+()*'<>"
	for i = 1 To Len(sInvalidChars)
		if InStr(sValidate, Mid(sInvalidChars, i, 1)) > 0 then bTemp = True
		if bTemp then strURLError = "<br />&bull;&nbsp;cannot contain any of the following characters:  "" ; + ( ) * ' < > "
		if bTemp then Exit For
	next
	if not bTemp then
		for i = 1 to Len(sValidate)
			if Asc(Mid(sValidate, i, 1)) = 160 then bTemp = True
			if bTemp then strURLError = "<br />&bull;&nbsp;cannot contain any spaces "
			if bTemp then Exit For
		next
	end if

	' extra checks
	' check to make sure URL begins with http:// or https://
	if not bTemp then
		bTemp = (lcase(left(sValidate, 7)) <> "http://") and (lcase(left(sValidate, 8)) <> "https://")
		if bTemp then strURLError = "<br />&bull;&nbsp;must begin with either http:// or https:// "
	end if
	' check to make sure URL is 255 characters or less
	if not bTemp then
		bTemp = len(sValidate) > 255
		if bTemp then strURLError = "<br />&bull;&nbsp;cannot be more than 255 characters "
	end if
	' no two consecutive dots
	if not bTemp then
		bTemp = InStr(sValidate, "..") > 0
		if bTemp then strURLError = "<br />&bull;&nbsp;cannot contain consecutive periods "
	end if
	'no spaces
	if not bTemp then
		bTemp = InStr(sValidate, " ") > 0
		if bTemp then strURLError = "<br />&bull;&nbsp;cannot contain any spaces "
	end if
	if not bTemp then
		bTemp = (len(sValidate) <> len(Trim(sValidate)))
		if bTemp then strURLError = "<br />&bull;&nbsp;cannot contain any spaces "
	end if 'Addition for leading and trailing spaces

	' if any of the above are true, invalid string
	IsValidURL = Not bTemp
End Function

Function IsValidString(sValidate)
	Dim sInvalidChars
	Dim bTemp
	Dim i 
	' Disallowed characters
	sInvalidChars = "!#$%^&*()=+{}[]|\;:/?>,<'"
	for i = 1 To Len(sInvalidChars)
		if InStr(sValidate, Mid(sInvalidChars, i, 1)) > 0 then bTemp = True
		if bTemp then Exit For
	next
	for i = 1 to Len(sValidate)
		if Asc(Mid(sValidate, i, 1)) = 160 then bTemp = True
		if bTemp then Exit For
	next

	' extra checks
	' no two consecutive dots or spaces
	if not bTemp then
		bTemp = InStr(sValidate, "..") > 0
	end if
	if not bTemp then
		bTemp = InStr(sValidate, "  ") > 0
	end if
	if not bTemp then
		bTemp = (len(sValidate) <> len(Trim(sValidate)))
	end if 'Addition for leading and trailing spaces

	' if any of the above are true, invalid string
	IsValidString = Not bTemp
End Function

function chkNameFilter(pString)
	if trim(Application(strCookieURL & "STRFILTERUSERNAMES")) = "" then
		txtUserNames = ""
		'## Forum_SQL - Get UserNames from DB
		strSqln = "SELECT N_NAME " 
		strSqln = strSqln & " FROM " & strFilterTablePrefix & "NAMEFILTER "

		set rsUName = Server.CreateObject("ADODB.Recordset")
		rsUName.open strSqln, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

		if rsUName.EOF then
			recUserNameCount = ""
		else
			allUserNameData = rsUName.GetRows(adGetRowsRest)
			recUserNameCount = UBound(allUserNameData,2)
		end if

		rsUName.close
		set rsUName = nothing

		if recUserNameCount <> "" then
			nNAME = 0

			for iUserName = 0 to recUserNameCount
				UserNameName = allUserNameData(nNAME,iUserName)
				if txtUserNames = "" then
					txtUserNames = UserNameName
				else
					txtUserNames = txtUserNames & "," & UserNameName
				end if
			next
		end if
		Application.Lock
		Application(strCookieURL & "STRFILTERUSERNAMES") = txtUserNames
		Application.UnLock
	end if
	txtUserNames = Application(strCookieURL & "STRFILTERUSERNAMES")
	fString = trim(pString)
	unames = split(txtUserNames, ",")
	for i = 0 to ubound(unames)
		if instr(1,lcase(fString), lcase(unames(i)),1) <> 0 then
			Err_Msg = Err_Msg & "<li>Username may not contain the word <b>" & unames(i) & "</b></li>"
			exit function
		end if
	next
end function

function chkNameBadWords(pString)
	if trim(Application(strCookieURL & "STRBADWORDWORDS")) = "" or trim(Application(strCookieURL & "STRBADWORDREPLACE")) = "" then
		txtBadWordWords = ""
		txtBadWordReplace = ""
		'## Forum_SQL - Get Badwords from DB
		strSqlb = "SELECT B_BADWORD, B_REPLACE " 
		strSqlb = strSqlb & " FROM " & strFilterTablePrefix & "BADWORDS "

		set rsBadWord = Server.CreateObject("ADODB.Recordset")
		rsBadWord.open strSqlb, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

		if rsBadWord.EOF then
			recBadWordCount = ""
		else
			allBadWordData = rsBadWord.GetRows(adGetRowsRest)
			recBadWordCount = UBound(allBadWordData,2)
		end if

		rsBadWord.close
		set rsBadWord = nothing

		if recBadWordCount <> "" then
			bBADWORD = 0
			bREPLACE = 1

			for iBadword = 0 to recBadWordCount
				BadWordWord = allBadWordData(bBADWORD,iBadWord)
				BadWordReplace = allBadWordData(bREPLACE,iBadWord)
				if txtBadWordWords = "" then
					txtBadWordWords = BadWordWord
					txtBadWordReplace = BadWordReplace
				else
					txtBadWordWords = txtBadWordWords & "," & BadWordWord
					txtBadWordReplace = txtBadWordReplace & "," & BadWordReplace
				end if
			next
		end if
		Application.Lock
		Application(strCookieURL & "STRBADWORDWORDS") = txtBadWordWords
		Application(strCookieURL & "STRBADWORDREPLACE") = txtBadWordReplace
		Application.UnLock
	end if
	txtBadWordWords = Application(strCookieURL & "STRBADWORDWORDS")
	fString = trim(pString)
	bwords = split(txtBadWordWords, ",")
	for i = 0 to ubound(bwords)
		if instr(1,lcase(fString), lcase(bwords(i)),1) <> 0 then
			Err_Msg = Err_Msg & "<li>Username may not contain the word <b>" & bwords(i) & "</b></li>"
			exit function
		end if
	next
end function
%>
