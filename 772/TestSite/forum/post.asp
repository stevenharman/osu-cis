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
<%
'#################################################################################
'## Variable declaration 
'#################################################################################
dim strSelectSize
dim intCols, intRows
'#################################################################################
'## Initialise variables 
'#################################################################################
if Request.QueryString("method") <> "" then
	strRqMethod = chkString(Request.QueryString("method"), "SQLString")
elseif Request.Form("Method_Type") = "logout" then
	'Do Nothing
else
	Response.Redirect("default.asp")
end if
if Request.QueryString("TOPIC_ID") <> "" then
	if IsNumeric(Request.QueryString("TOPIC_ID")) = True then
		strRqTopicID = cLng(Request.QueryString("TOPIC_ID"))
	else
		Response.Redirect("default.asp")
	end if
end if
if Request.QueryString("FORUM_ID") <> "" then
	if IsNumeric(Request.QueryString("FORUM_ID")) = True then
		strRqForumID = cLng(Request.QueryString("FORUM_ID"))
	else
		Response.Redirect("default.asp")
	end if
end if
if Request.QueryString("CAT_ID") <> "" then
	if IsNumeric(Request.QueryString("CAT_ID")) = True then
		strRqCatID = cLng(Request.QueryString("CAT_ID"))
	else
		Response.Redirect("default.asp")
	end if
end if
if Request.QueryString("REPLY_ID") <> "" then
	if IsNumeric(Request.QueryString("REPLY_ID")) = True then
		strRqReplyID = cLng(Request.QueryString("REPLY_ID"))
	else
		Response.Redirect("default.asp")
	end if
end if
strCkPassWord = Request.Cookies(strUniqueID & "User")("Pword")

if strSelectSize = "" or IsNull(strSelectSize) then 
	strSelectSize = Request.Cookies(strUniqueID & "strSelectSize")
end if
if not(IsNull(strSelectSize)) and strSelectSize <> "" then 
	if strSetCookieToForum = 1 then
    		Response.Cookies(strUniqueID & "strSelectSize").Path = strCookieURL
	else
		Response.Cookies(strUniqueID & "strSelectSize").Path = "/"
	end if
	Response.Cookies(strUniqueID & "strSelectSize") = strSelectSize
	Response.Cookies(strUniqueID & "strSelectSize").expires = dateAdd("yyyy", 1, strForumTimeAdjust)
end if
%>
<!--#INCLUDE FILE="inc_sha256.asp"-->
<!--#INCLUDE FILE="inc_header.asp" -->
<!--#INCLUDE FILE="inc_subscription.asp"-->
<!--#INCLUDE FILE="inc_func_secure.asp" -->
<!--#INCLUDE FILE="inc_func_member.asp" -->
<!--#INCLUDE FILE="inc_func_posting.asp"-->
<%
'#################################################################################
'## Page-code start
'#################################################################################

if request("ARCHIVE") = "true" then
	strActivePrefix = strTablePrefix & "A_"
	ArchiveView = "true"
else
	strActivePrefix = strTablePrefix
	ArchiveView = ""
end if

if strRqMethod = "Edit" or _
strRqMethod = "EditTopic" or _
strRqMethod = "Reply" or _
strRqMethod = "ReplyQuote" or _
strRqMethod = "TopicQuote" then
	'## check if topic exists in TOPICS table
	set rsTCheck = my_Conn.Execute ("SELECT TOPIC_ID FROM " & strActivePrefix & "TOPICS WHERE TOPIC_ID = " & strRqTopicID)
	if rsTCheck.EOF or rsTCheck.BOF then
	        rsTCheck.Close
        	set rsTCheck = nothing
        	Go_Result "Sorry, that Topic no longer exists in the Database"
	end if
	set rsTCheck = nothing
end if

if ArchiveView <> "" then
	if MethodType = "Reply" or _
	MethodType = "ReplyQuote" or _
	MethodType = "TopicQuote" then
		Go_Result "This is not allowed in the Archives."
	end if
end if

if strRqMethod = "Edit" or _
strRqMethod = "EditTopic" or _
strRqMethod = "Reply" or _
strRqMethod = "ReplyQuote" or _
strRqMethod = "Topic" or _
strRqMethod = "TopicQuote" then
 
	if strRqMethod <> "Topic" then
		'## Forum_SQL - Find out if the Category, Forum or Topic is Locked or Un-Locked and if it Exists
		strSql = "SELECT C.CAT_ID, C.CAT_NAME, C.CAT_STATUS, C.CAT_SUBSCRIPTION, " &_
		"F.FORUM_ID, F.F_STATUS, F.F_TYPE, F.F_SUBJECT, F.F_SUBSCRIPTION, "&_
		"T.T_STATUS, T.T_SUBJECT " &_
		" FROM " & strTablePrefix & "CATEGORY C, " &_
		strTablePrefix & "FORUM F, " &_
		strActivePrefix & "TOPICS T" &_
		" WHERE C.CAT_ID = T.CAT_ID " &_
		" AND F.FORUM_ID = T.FORUM_ID " &_
		" AND T.TOPIC_ID = " & strRqTopicID & ""
	else
		'## Forum_SQL - Find out if the Category or Forum is Locked or Un-Locked and if it Exists
		strSql = "SELECT C.CAT_ID, C.CAT_NAME, C.CAT_STATUS, C.CAT_SUBSCRIPTION, " &_
		"F.FORUM_ID, F.F_STATUS, F.F_TYPE, F.F_SUBJECT, F.F_SUBSCRIPTION "&_
		" FROM " & strTablePrefix & "CATEGORY C, " &_
		strTablePrefix & "FORUM F" &_
		" WHERE C.CAT_ID = F.CAT_ID " &_
		" AND F.FORUM_ID = " & strRqForumID & ""
        end if
 
	set rsStatus = my_Conn.Execute(strSql)
	if rsStatus.EOF or rsStatus.BOF then
	        rsStatus.close
		set rsStatus = nothing
		Go_Result "Please don't attempt to edit the URL<br />to gain access to locked Forums/Categories."
	else
		'## Subscribe checkbox start ##
		PostCat_subscription = rsStatus("CAT_SUBSCRIPTION")
		PostForum_subscription = rsStatus("F_SUBSCRIPTION")
		'## Subscribe checkbox end ##
		blnCStatus = rsStatus("CAT_STATUS")
		blnFStatus = rsStatus("F_STATUS")
		strRqForumID = rsStatus("FORUM_ID")
		strRqCatID = rsStatus("CAT_ID")
		Cat_Name = rsStatus("CAT_NAME")
		Forum_Type = rsStatus("F_TYPE")
		Forum_Subject = rsStatus("F_SUBJECT")
		if strRqMethod <> "Topic" then
			blnTStatus = rsStatus("T_STATUS")
			Topic_Title = rsStatus("T_SUBJECT")
		else
			blnTStatus = 1
		end if
		rsStatus.close
		set rsStatus = nothing
	end if
 
	if mLev = 4 then
		AdminAllowed = 1
		ForumChkSkipAllowed = 1
	elseif mLev = 3 then
		if chkForumModerator(strRqForumID, ChkString(strDBNTUserName, "decode")) = "1" then
			AdminAllowed = 1
			ForumChkSkipAllowed = 1
		else
			if lcase(strNoCookies) = "1" then
				AdminAllowed = 1
				ForumChkSkipAllowed = 0
			else
				AdminAllowed = 0
				ForumChkSkipAllowed = 0
			end if
		end if
	elseif lcase(strNoCookies) = "1" then
		AdminAllowed = 1
		ForumChkSkipAllowed = 0
	else
		AdminAllowed = 0
		ForumChkSkipAllowed = 0
	end if 
 
	select case strRqMethod
		case "Topic"
			if (Forum_Type = 1) then
				Go_Result "You have attempted to post a New Topic to a Forum designated as a Web Link"
			end if
			if (blnCStatus = 0) and (AdminAllowed = 0) then
				Go_Result "You have attempted to post a New Topic to a Locked Category"
			end if
			if (blnFStatus = 0) and (AdminAllowed = 0) then
				Go_Result "You have attempted to post a New Topic to a Locked Forum"
			end if
		case "EditTopic"
			if ((blnCStatus = 0) or (blnFStatus = 0) or (blnTStatus = 0)) and (AdminAllowed = 0) then
				Go_Result "You have attempted to edit a Locked Topic"
			end if
		case "Reply", "ReplyQuote", "TopicQuote"
			if ((blnCStatus = 0) or (blnFStatus = 0) or (blnTStatus = 0)) and (AdminAllowed = 0) then
				Go_Result "You have attempted to Reply to a Locked Topic"
			end if
		case "Edit"
			if ((blnCStatus = 0) or (blnFStatus = 0) or (blnTStatus = 0)) and (AdminAllowed = 0) then
				Go_Result "You have attempted to Edit a Reply to a Locked Topic"
			end if
	end select
	if strPrivateForums = "1" and ForumChkSkipAllowed = 0 then
		if not(chkForumAccess(strRqForumID,MemberID,false)) then
    			Go_Result "You do not have access to this forum"
  		end if
	end if
end if

select case strSelectSize
	case "1"
		intCols = 45
		intRows = 11
	case "2"
		intCols = 70
		intRows = 12
	case "3"
		intCols = 90
		intRows = 12
	case "4"
		intCols = 130
		intRows = 15
	case else
		intCols = 70
		intRows = 12
end select

Response.Write	"    <script language=""JavaScript"" type=""text/javascript"" src=""inc_code.js""></script>" & vbNewLine & _
		"    <script language=""JavaScript"" type=""text/javascript"" src=""selectbox.js""></script>" & vbNewLine

if strRqMethod = "EditForum" then
	if (mLev = 4) or (chkForumModerator(strRqForumId, strDBNTUserName) = "1") then
		'## Do Nothing
	else
		Go_Result "Only moderators and administrators can edit forums"
	end if
end if

Msg = ""

select case strRqMethod 
	case "Reply", "ReplyQuote", "TopicQuote"
		if (strNoCookies = 1) or (strDBNTUserName = "") then
			Msg = Msg & "<b>Note:</b> You must be registered in order to post a reply.<br />"
			if strProhibitNewMembers <> "1" then
				Msg = Msg & "To register, <a href=""policy.asp"">click here</a>. Registration is FREE!<br />"
			end if
		end if
	case "Topic"
		if (strNoCookies = 1) or (strDBNTUserName = "") then
			Msg = Msg & "<b>Note:</b> You must be registered in order to post a Topic.<br />"
			if strProhibitNewMembers <> "1" then
				Msg = Msg & "To register, <a href=""policy.asp"">click here</a>. Registration is FREE!<br />"
			end if
		end if
	case "Category"
		Msg = Msg & "<b>Note:</b> You must be an Administrator to create a new Category.<br />"
	case "Forum"
		Msg = Msg & "<b>Note:</b> You must be an Administrator to create a new Forum.<br />"
	case "URL"
		Msg = Msg & "<b>Note:</b> You must be an Administrator to create a new Web Link.<br />"
	case "Edit", "EditTopic"
		Msg = Msg & "<b>Note:</b> Only the poster of this message, and the Moderator can edit the message."
	case "EditForum"
		Msg = Msg & "<b>Note:</b> Only the Moderator or an Administrator can edit a Forum."
	case "EditURL"
		Msg = Msg & "<b>Note:</b> Only the Moderator or an Administrator can edit a Web Link."
	case "EditCategory"
		Msg = Msg & "<b>Note:</b> Only an Administrator can edit a Category."
	case else
		Response.Redirect "default.asp"
end select

if strRqMethod = "Edit" or _
strRqMethod = "ReplyQuote" then
	'## Forum_SQL
	strSql = "SELECT M.M_NAME, R.R_AUTHOR, R.R_SIG, R.R_MESSAGE "
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS M, " & strActivePrefix & "REPLY R "
	strSql = strSql & " WHERE M.MEMBER_ID = R.R_AUTHOR AND R.REPLY_ID = " & strRqReplyID

	set rs = my_Conn.Execute (strSql)
	
	strAuthor = rs("R_AUTHOR")

	if strRqMethod = "Edit" then
		TxtMsg = rs("R_MESSAGE")
	else
		if strRqMethod = "ReplyQuote" then
			TxtMsg = "[quote][i]Originally posted by " & chkString(rs("M_NAME"),"display") & "[/i]" & vbNewline
			TxtMsg = TxtMsg & "[br]" & rs("R_MESSAGE") & vbNewline
			TxtMsg = TxtMsg & "[/quote]"
		end if
	end if
end if

if strRqMethod = "EditTopic" or strRqMethod = "TopicQuote" then
	'## Forum_SQL
	strSql = "SELECT M.M_NAME, T.CAT_ID, T.FORUM_ID, T.TOPIC_ID, T.T_SUBJECT, T.T_AUTHOR, T.T_STICKY, T.T_SIG, T.T_MESSAGE "
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS M, " & strActivePrefix & "TOPICS T "
	strSql = strSql & " WHERE M.MEMBER_ID = T.T_AUTHOR AND T.TOPIC_ID = " & strRqTopicID

	set rs = my_Conn.Execute (strSql)

	TxtSub = rs("T_SUBJECT")
	strAuthor = rs("T_AUTHOR")
	if strStickyTopic = "1" then
		strTopicSticky = rs("T_STICKY")
	end if

	if strRqMethod = "EditTopic" then
		TxtMsg = rs("T_MESSAGE")
	else
		if strRqMethod = "TopicQuote" then
			TxtMsg = "[quote][i]Originally posted by " & chkString(rs("M_NAME"),"display") & "[/i]" & vbNewline
			TxtMsg = TxtMsg & "[br]" & rs("T_MESSAGE") & vbNewline
			TxtMsg = TxtMsg & "[/quote]"
		end if
	end if
end if

if strRqMethod = "EditForum" or _
strRqMethod = "EditURL" then
	'## Forum_SQL
	' DEM --> Added F_SUBSCRIPTION, F_MODERATION to the end of this select
	strSql = "SELECT F_SUBJECT, F_URL, F_PRIVATEFORUMS, F_PASSWORD_NEW, " & _
		 "F_DEFAULTDAYS, F_COUNT_M_POSTS, F_SUBSCRIPTION, F_MODERATION, F_DESCRIPTION " & _
		 " FROM " & strTablePrefix & "FORUM " & _
		 " WHERE FORUM_ID = " & strRqForumId

	set rs = my_Conn.Execute (strSql)
	
	if strRqMethod = "EditURL" then
		TxtUrl = rs("F_URL")
	end if

	if strRqMethod = "EditForum" then
		fDefaultDays = rs("F_DEFAULTDAYS")
		fForumCntMPosts = rs("F_COUNT_M_POSTS")
	end if

	if strRqMethod = "EditForum" or _ 
	strRqMethod = "EditURL" then
		TxtSub = rs("F_SUBJECT")
		' DEM --> Added fields to get them into local variables which is a faster run
		ForumSubscription = rs("F_SUBSCRIPTION")
		ForumModeration   = rs("F_MODERATION")
		TxtMsg = rs("F_DESCRIPTION")
	end if
end if

' DEM --> Added editforum and forum to get the cat_subscription and cat_moderation for later use.
if strRqMethod = "EditCategory" or strRqMethod = "EditForum" or strRqMethod = "EditURL" or strRqMethod = "Forum" then
	'## Forum_SQL
	' DEM --> Added CAT_SUBSCRIPTION for subscription services
	' DEM --> Added  CAT_MODERATION for moderation processing
	strSql = "SELECT CAT_NAME, CAT_SUBSCRIPTION, CAT_MODERATION "
	strSql = strSql & " FROM " & strTablePrefix & "CATEGORY "
	strSql = strSql & " WHERE CAT_ID = " & strRqCatID

	' DEM --> Added if statement to use a different connection and to move the database fields to local variables
	if strRqMethod = "EditForum" or strRqMethod = "EditURL" or strRqMethod = "Forum" then
		set rs1 = my_Conn.Execute (strSql)
		CatSubscription = rs1("CAT_SUBSCRIPTION")
		CatModeration   = rs1("CAT_MODERATION")
		strCatName = rs1("CAT_NAME")
		set rs1 = nothing
	else
		set rs = my_Conn.Execute (strSql)
		CatSubscription = rs("CAT_SUBSCRIPTION")
		CatModeration   = rs("CAT_MODERATION")
	end if

	if strRqMethod = "EditCategory" then
		TxtSub = rs("CAT_NAME")
	end if
end if

select case strRqMethod 
	case "Category"
		btn = "Post New Category"
	case "Edit", "EditCategory", "EditForum", "EditTopic", "EditURL"
		btn = "Post Changes"
	case "Forum"
		btn = "Post New Forum"
	case "Reply", "ReplyQuote", "TopicQuote"
		btn = "Post New Reply"
	case "Topic"
		btn = "Post New Topic"
	case "URL"
		btn = "Post New URL"
	case else
		btn = "Post"
end select

Response.Write	"      <table border=""0"" width=""100%"" align=""center"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td width=""33%"" align=""left""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
		"          " & getCurrentIcon(strIconFolderOpen,"","align=""absmiddle""") & "&nbsp;<a href=""default.asp"" tabindex=""-1"">All Forums</a><br />" & vbNewLine
if strRqMethod = "EditCategory" then
	Response.Write	"          " & getCurrentIcon(strIconBar,"","align=""absmiddle""") & getCurrentIcon(strIconFolderOpen,"","align=""absmiddle""") & "&nbsp;" & ChkString(TxtSub,"display") & "<br />" & vbNewLine
elseif strRqMethod = "EditForum" or strRqMethod = "EditURL" then
	Response.Write	"          " & getCurrentIcon(strIconBar,"","align=""absmiddle""") & getCurrentIcon(strIconFolderOpen,"","align=""absmiddle""") & "&nbsp;<a href=""default.asp?CAT_ID=" & strRqCatID & """ tabindex=""-1"">" & ChkString(strCatName,"display") & "</a><br />" & vbNewLine
	Response.Write	"          " & getCurrentIcon(strIconBlank,"","align=""absmiddle""") & getCurrentIcon(strIconBar,"","align=""absmiddle""") & getCurrentIcon(strIconFolderOpen,"","align=""absmiddle""") & "&nbsp;" & ChkString(TxtSub,"display") & "<br />" & vbNewLine
else
	if strRqMethod = "Edit" or strRqMethod = "EditTopic" or _
	strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
	strRqMethod = "Topic" or strRqMethod = "TopicQuote" then 
		Response.Write	"          " & getCurrentIcon(strIconBar,"","align=""absmiddle""")
		if blnCStatus <> 0 then
			Response.Write	getCurrentIcon(strIconFolderOpen,"","align=""absmiddle""")
		else
			Response.Write	getCurrentIcon(strIconFolderClosed,"","align=""absmiddle""")
		end if
		Response.Write	"&nbsp;<a href=""default.asp?CAT_ID=" & strRqCatId & """ tabindex=""-1"">" & ChkString(Cat_Name,"display") & "</a><br />" & vbNewLine
		Response.Write	"          " & getCurrentIcon(strIconBlank,"","align=""absmiddle""") & getCurrentIcon(strIconBar,"","align=""absmiddle""")
		if blnFStatus <> 0 and blnCStatus <> 0 then
			Response.Write	getCurrentIcon(strIconFolderOpen,"","align=""absmiddle""")
		else
			if strRqMethod <> "Topic" then
				Response.Write	getCurrentIcon(strIconFolderClosed,"","align=""absmiddle""")
			else
				Response.Write	getCurrentIcon(strIconFolderClosedTopic,"","align=""absmiddle""")
			end if
		end if
		Response.Write	"&nbsp;<a href=""forum.asp?FORUM_ID=" & strRqForumId & """ tabindex=""-1"">" & ChkString(Forum_Subject,"display") & "</a><br />" & vbNewLine
	end if 
 end if 

if strRqMethod = "Edit" or strRqMethod = "EditTopic" or _
strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
strRqMethod = "TopicQuote" then 
	Response.Write	"          " & getCurrentIcon(strIconBlank,"","align=""absmiddle""") & getCurrentIcon(strIconBlank,"","align=""absmiddle""") & getCurrentIcon(strIconBar,"","align=""absmiddle""")
	if blnTStatus <> 0 and blnFStatus <> 0 and blnCStatus <> 0 then
		Response.Write	getCurrentIcon(strIconFolderOpenTopic,"","align=""absmiddle""")
	else
		Response.Write	getCurrentIcon(strIconFolderClosedTopic,"","align=""absmiddle""")
	end if
	Response.Write	"&nbsp;<a href=""topic.asp?TOPIC_ID=" & strRqTopicID & """ tabindex=""-1"">" & ChkString(Topic_Title,"title") & "</a>" & vbNewLine
end if 
Response.Write	"          </font></td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine & _
		"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & Msg & "</font></p>" & vbNewLine & _
		"      <table border=""0"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td bgcolor=""" & strPopUpBorderColor & """>" & vbNewLine & _
		"            <table border=""0"" cellspacing=""1"" cellpadding=""1"">" & vbNewLine & _
		"              <form name=""PostTopic"" method=""post"" action=""post_info.asp"""
select case strRqMethod
	case "Topic", "EditTopic", "Reply", "ReplyQuote", "TopicQuote", "Edit"
		Response.Write(" onSubmit=""return validate();""")
	case else
		Response.Write	""
end select
'strRefer = Request.ServerVariables("HTTP_REFERER")
if strReferer = "" then strReferer = chkString(Request.Form("Refer"),"refer")
if strReferer = "" then strReferer = "default.asp"
Response.Write	">" & vbNewLine & _
		"              <input name=""ARCHIVE"" type=""hidden"" value=""" & ArchiveView & """>" & vbNewLine & _
		"              <input name=""Method_Type"" type=""hidden"" value=""" & strRqMethod & """>" & vbNewLine & _
		"              <input name=""Type"" type=""hidden"" value=""" & Request.QueryString("type") & """>" & vbNewLine & _
		"              <input name=""REPLY_ID"" type=""hidden"" value=""" & strRqReplyID & """>" & vbNewLine & _
		"              <input name=""TOPIC_ID"" type=""hidden"" value=""" & strRqTopicID & """>" & vbNewLine & _
		"              <input name=""FORUM_ID"" type=""hidden"" value=""" & strRqForumId & """> " & vbNewLine & _
		"              <input name=""CAT_ID"" type=""hidden"" value=""" & strRqCatID & """>" & vbNewLine
if strRqMethod = "Edit" or strRqMethod = "EditTopic" then Response.Write("              <input name=""Author"" type=""hidden"" value=""" & strAuthor & """>" & vbNewLine)
Response.Write	"              <input name=""Refer"" type=""hidden"" value=""" & strReferer & """>" & vbNewLine & _
		"              <input name=""cookies"" type=""hidden"" value=""yes"">" & vbNewLine

if strRqMethod = "Edit" or strRqMethod = "EditTopic" or strRqMethod = "Forum" or strRqMethod = "EditForum" or _
	strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
	strRqMethod = "Topic" or strRqMethod = "TopicQuote" then 
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Screensize:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
			"                <select name=""SelectSize"" size=""1"" tabindex=""-1"" onchange=""resizeTextarea('" & strUniqueID & "')"">" & vbNewLine & _
			"                	<option value=""1"""
	if strSelectSize = "1" then Response.Write(" selected")
	Response.Write	">640  x 480</option>" & vbNewLine & _
			"                	<option value=""2"""
	if strSelectSize = "2" or strSelectSize = "" then Response.Write(" selected")
	Response.Write	">800  x 600</option>" & vbNewLine & _
			"                	<option value=""3"""
	if strSelectSize = "3" then Response.Write(" selected")
	Response.Write	">1024 x 768</option>" & vbNewLine & _
			"                	<option value=""4"""
	if strSelectSize = "4" then Response.Write(" selected")
	Response.Write	">1280 x 1024</option>" & vbNewLine & _
			"                </select>" & vbNewLine & _
			"                </font></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if 

if mlev = 4 or _
mlev = 3 or _
mlev = 2 or _
mlev = 1 then 
	Response.Write	"              <input name=""UserName"" type=""hidden"" value=""" & strDBNTUserName & """>" & vbNewLine & _
			"              <input name=""Password"" type=""hidden"" value=""" & strCkPassWord & """>" & vbNewLine
else
	if (lcase(strNoCookies) = "1") or _
	(strDBNTUserName = "" or _
	strCkPassWord = "") then 
		Response.Write	"              <tr>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>UserName:</b></font></td>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """><input name=""UserName"" maxLength=""25"" size=""25"" type=""text"" value=""" & Request.Form("UserName") & """></td>" & vbNewLine & _
				"              </tr>" & vbNewLine & _
				"              <tr>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Password:</b></font></td>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """ valign=""top""><input name=""Password"" maxLength=""25"" size=""25"" type=""password"" value=""" & Request.Form("password") & """></td>" & vbNewLine & _
				"              </tr>" & vbNewLine
	end if 
end if

if strAllowForumCode = "1" and strShowFormatButtons = "1" then
	if strRqMethod = "Edit" or strRqMethod = "EditTopic" or _
		strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
		strRqMethod = "Topic" or strRqMethod = "TopicQuote" then 
%>
<!--#INCLUDE FILE="inc_post_buttons.asp" -->
<% 
	end if
end if
if strRqMethod = "Forum" or _
strRqMethod = "URL" or _
strRqMethod = "EditURL" or _
strRqMethod = "EditForum" then 
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Category:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """>" & vbNewLine & _
			"                <select name=""Category"" size=""1"">" & vbNewLine
	'## Forum_SQL
	strSql = "SELECT CAT_ID, CAT_NAME "
	strSql = strSql & " FROM " & strTablePrefix & "CATEGORY "
	if mlev = 3 then 
		strSql = strSql & " WHERE CAT_ID = " & strRqCatID
	end if 
	strSql = strSql & " ORDER BY CAT_ORDER, CAT_NAME ASC;"

	set rsCat = Server.CreateObject("ADODB.Recordset")
	rsCat.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

	if rsCat.EOF then
		recCatCount = ""
	else
		allCatData = rsCat.GetRows(adGetRowsRest)
		recCatCount = UBound(allCatData,2)
	end if

	rsCat.close
	set rsCat = nothing

	if recCatCount <> "" then
		cCAT_ID = 0
		cCAT_NAME = 1

		for iCat = 0 to recCatCount
			CatID = allCatData(cCAT_ID,iCat)
			CatName = allCatData(cCAT_NAME,iCat)

			Response.Write "                	<option value=""" & CatID & """"
			if cLng(strRqCatID) = CatID then
				Response.Write " selected"
			end if
			Response.Write ">" & ChkString(CatName,"display") & "</option>" & vbNewline
		next
	end if
	Response.Write	"                </select>" & vbNewLine & _
			"                <a href=""Javascript:openWindow3('pop_help.asp?mode=options#category')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if

if (strRqMethod = "EditTopic") then
	Dim MoveTopicAllowed
	if (mLev = 4) or (mLev = 3 and strMoveTopicMode = "0") or ((mLev = 3) and (strMoveTopicMode = "1") and (strAuthor = MemberID)) then
		MoveTopicAllowed = "1"
	else
		MoveTopicAllowed = "0"
	end if

	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Forum:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """>" & vbNewLine
	if mlev = 3 or mlev = 4 then 
		Response.Write	"                <select name=""Forum"" size=""1"">" & vbNewLine
	end if 
	'## Forum_SQL
	strSql = "SELECT C.CAT_NAME, F.CAT_ID, F.FORUM_ID, F.F_SUBJECT, F_PRIVATEFORUMS, F_PASSWORD_NEW " &_
	" FROM " & strTablePrefix & "CATEGORY C, " & strTablePrefix & "FORUM F" &_
	" WHERE F.F_TYPE = 0 " & _
	" AND C.CAT_ID = F.CAT_ID "
	if mLev = 4 then
		'## Do Nothing
	else
		if MoveTopicAllowed = "1" then
		else
			strSql = strSql & " AND F.FORUM_ID = " & rs("FORUM_ID")
		end if
	end if
	strSql = strSql & " ORDER BY C.CAT_ORDER, C.CAT_NAME, F.F_ORDER, F.F_SUBJECT ASC;"

	set rsForum = Server.CreateObject("ADODB.Recordset")
	rsForum.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

	if rsForum.EOF then
		recForumCount = ""
	else
		allForumData = rsForum.GetRows(adGetRowsRest)
		recForumCount = UBound(allForumData,2)
	end if

	rsForum.close
	set rsForum = nothing

	if mlev = 3 or mlev = 4 then
		if recForumCount <> "" then
			cCAT_NAME = 0
			fCAT_ID = 1
			fFORUM_ID = 2
			fF_SUBJECT = 3
			fF_PRIVATEFORUMS = 4
			fF_PASSWORD_NEW = 5

			for iForum = 0 to recForumCount
				ForumCat_Name = allForumData(cCAT_NAME, iForum)
				ForumCatID = allForumData(fCAT_ID, iForum)
				ForumID = allForumData(fFORUM_ID, iForum)
				ForumSubject = allForumData(fF_SUBJECT, iForum)
				ForumPrivateForums = allForumData(fF_PRIVATEFORUMS,iForum)
				ForumFPasswordNew = allForumData(fF_PASSWORD_NEW,iForum)
				if ChkDisplayForum(ForumPrivateForums,ForumFPasswordNew,ForumID,MemberID) then
					Response.Write 	"                	<option value=""" & ForumCatID & "|" & ForumID & """"
					if cLng(strRqForumId) = ForumID then
						Response.Write 	" selected"
					end if
					Response.Write 	">" & ChkString(ForumSubject,"display") & "</option>" & vbNewline
				end if
			next
		end if
	else
		fCAT_ID = 1
		fFORUM_ID = 2
		fF_SUBJECT = 3
		ForumCatID = allForumData(fCAT_ID, 0)
		ForumID = allForumData(fFORUM_ID, 0)
		ForumSubject = allForumData(fF_SUBJECT, 0)

		Response.Write 	"                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & ChkString(ForumSubject,"display") & "</font>" & vbNewLine & _
				"                <input type=""hidden"" name=""Forum"" value=""" & ForumCatID & "|" & ForumID & """>" & vbNewLine
	end if
		
	set rsForum = nothing

	if mlev = 3 or mlev = 4 then 
	        Response.Write 	"                </select>" & vbNewline
	end if
        Response.Write 	"                </td>" & vbNewline & _
        		"              </tr>" & vbNewLine
end if 

if strRqMethod = "Forum" or _
strRqMethod = "EditForum" then
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Default Days:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """><select name=""DefaultDays"" size=""1"">" & vbNewLine & _
			"                	<option value=""0"""
	if fDefaultDays = "0" then Response.Write(" SELECTED")
	Response.Write	">Show all topics</option>" & vbNewLine & _
			"                	<option value=""-1"""
	if fDefaultDays = "-1" then Response.Write(" SELECTED")
	Response.Write	">Show all open topics</option>" & vbNewLine & _
			"                	<option value=""1"""
	if fDefaultDays = "1" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last day</option>" & vbNewLine & _
			"                	<option value=""2"""
	if fDefaultDays = "2" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 2 days</option>" & vbNewLine & _
			"                	<option value=""5"""
	if fDefaultDays = "5" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 5 days</option>" & vbNewLine & _
			"                	<option value=""7"""
	if fDefaultDays = "7" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 7 days</option>" & vbNewLine & _
			"                	<option value=""14"""
	if fDefaultDays = "14" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 14 days</option>" & vbNewLine & _
			"                	<option value=""30"""
	if fDefaultDays = "30" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 30 days</option>" & vbNewLine & _
			"                	<option value=""60"""
	if fDefaultDays = "60" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 60 days</option>" & vbNewLine & _
			"                	<option value=""120"""
	if fDefaultDays = "120" then Response.Write(" SELECTED")
	Response.Write	">Show topics from last 120 days</option>" & vbNewLine & _
			"                	<option value=""365"""
	if fDefaultDays = "365" then Response.Write(" SELECTED")
	Response.Write	">Show topics from the last year</option>" & vbNewLine & _
			"                </select>" & vbNewLine & _
			"                <a href=""Javascript:openWindow3('pop_help.asp?mode=options#defaultdays')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if

if strRqMethod = "Forum" or _
strRqMethod = "EditForum" then
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Increase Post Count:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """><select name=""ForumCntMPosts"" size=""1"">" & vbNewLine & _
			"                	<option value=""0"""
	if fForumCntMPosts = "0" then Response.Write(" selected")
	Response.Write	">No</option>" & vbNewLine & _
			"                	<option value=""1"""
	if fForumCntMPosts = "1" or fForumCntMPosts = "" then Response.Write(" selected")
	Response.Write	">Yes</option>" & vbNewLine & _
			"                </select>" & vbNewLine & _
			"                <a href=""Javascript:openWindow3('pop_help.asp?mode=options#forumcntmposts')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if

if strRqMethod = "Category" or _
strRqMethod = "EditCategory" or _
strRqMethod = "URL" or _
strRqMethod = "EditURL" or _
strRqMethod = "Forum" or _
strRqMethod = "EditForum" or _
strRqMethod = "EditTopic" or _
strRqMethod = "Topic" then
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Subject:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """><input maxLength=""50"" name=""Subject"" value=""" & Trim(ChkString(TxtSub,"edit")) & """ size=""40""></td>" & vbNewLine & _
			"              </tr>" & vbNewLine & _
			"              <script language=""JavaScript"" type=""text/javascript"">document.PostTopic.Subject.focus();</script>" & vbNewLine
end if

if strRqMethod = "URL" or _
strRqMethod = "EditURL" then 
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Address:</b></font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """><input maxLength=""150"" name=""Address"" value="""
	if (TxtURL <> "") then Response.Write(TxtURL) else Response.Write("http://")
	Response.Write	""" size=""40""><a href=""Javascript:openWindow3('pop_help.asp?mode=options#address')"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if
 
if strRqMethod = "Edit" or strRqMethod = "URL" or strRqMethod = "EditURL" or _
strRqMethod = "Forum" or strRqMethod = "EditForum" or _
strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
strRqMethod = "EditTopic" or strRqMethod = "Topic" or strRqMethod = "TopicQuote" then 
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Message:</b><br />" & vbNewLine & _
			"                <br />" & vbNewLine & _
			"                  <table border=""0"">" & vbNewLine & _
			"                    <tr>" & vbNewLine & _
			"                      <td align=""left"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
	if strAllowHTML = "1" then
		Response.Write	"                      * HTML is ON<br />" & vbNewLine
	else
		Response.Write	"                      * HTML is OFF<br />" & vbNewLine
	end if
	if strAllowForumCode = "1" then
		Response.Write	"                      * <a href=""JavaScript:openWindow6('pop_forum_code.asp')"" tabindex=""-1"">Forum Code</a> is ON<br />" & vbNewLine
	else
		Response.Write	"                      * Forum Code is OFF<br />" & vbNewLine
	end if
	if strIcons = "1" and strShowSmiliesTable = "1" then
		if strRqMethod = "Edit" or strRqMethod = "EditTopic" or _
			strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
			strRqMethod = "Topic" or strRqMethod = "TopicQuote" then 
%>
<!--#INCLUDE FILE="inc_smilies.asp" -->
<%
		end if
	end if
	Response.Write	"                      </font></td>" & vbNewLine & _
			"                    </tr>" & vbNewLine & _
			"                  </table>" & vbNewLine & _
			"                </font></td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """><textarea cols=""" & intCols & """ name=""Message"" rows=""" & intRows & """ wrap=""VIRTUAL"" onselect=""storeCaret(this);"" onclick=""storeCaret(this);"" onkeyup=""storeCaret(this);"" onchange=""storeCaret(this);"">" & Trim(CleanCode(TxtMsg)) & "</textarea><br /></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if
select case strRqMethod
	case "Reply", "ReplyQuote", "TopicQuote"
		Response.Write	"              <script language=""JavaScript"" type=""text/javascript"">document.PostTopic.Message.focus();</script>" & vbNewLine
end select

'#################################################################################
'## Forum Moderators - listbox Code
'#################################################################################
if (strRqMethod = "Forum" or _
strRqMethod = "URL" or _
strRqMethod = "EditURL" or _
strRqMethod = "EditForum") and (mLev > 3 or lcase(strNoCookies) = "1") then 
	Response.Write	"              <tr>" & vbNewLine & _
		      	"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Moderators:</b></font></td>" & vbNewLine
	strSql = "SELECT MEMBER_ID, M_NAME "
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS "
	strSql = strSql & " WHERE M_LEVEL > 1 "
	strSql = strSql & " AND M_STATUS = " & 1
	strSql = strSql & " ORDER BY M_NAME ASC "

	set rsModerators = Server.CreateObject("ADODB.Recordset")
	rsModerators.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

	if rsModerators.EOF then
		recModeratorsCount = ""
	else
		allModeratorsData = rsModerators.GetRows(adGetRowsRest)
		recModeratorsCount = UBound(allModeratorsData,2)
		meMEMBER_ID = 0
		meM_NAME = 1
	end if

	rsModerators.close
	set rsModerators = nothing

	tmpStrUserList  = ""

	if strRqMethod = "EditForum" or strRqMethod = "EditURL" then
		strSql = "SELECT MEMBER_ID "
		strSql = strSql & " FROM " & strTablePrefix & "MODERATOR "
		strSql = strSql & " WHERE FORUM_ID = " & strRqForumID

		set rsForumModerator = Server.CreateObject("ADODB.Recordset")
		rsForumModerator.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

		if rsForumModerator.EOF then
			recForumModeratorCount = ""
		else
			allForumModeratorData = rsForumModerator.GetRows(adGetRowsRest)
			recForumModeratorCount = UBound(allForumModeratorData,2)
			moMEMBER_ID = 0
		end if

		rsForumModerator.close
		set rsForumModerator = nothing

		if recForumModeratorCount <> "" then
			for iForumModerator = 0 to recForumModeratorCount
				ForumModeratorMemberID = allForumModeratorData(moMEMBER_ID, iForumModerator)
				if tmpStrUserList = "" then
					tmpStrUserList = ForumModeratorMemberID
				else
					tmpStrUserList = tmpStrUserList & "," & ForumModeratorMemberID
				end if
			next
		end if
	end if
	SelectSize = 6
	Response.Write	"                <td bgColor=""" & strPopUpTableColor & """>" & vbNewLine & _
			"                  <table>" & vbNewLine & _
			"                    <tr>" & vbNewLine & _
			"                      <td align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Available</b></font><br />" & vbNewLine & _
			"                      <select name=""ForumModCombo"" size=""" & SelectSize & """ multiple onDblClick=""moveSelectedOptions(document.PostTopic.ForumModCombo, document.PostTopic.ForumMod, true, '')"">" & vbNewLine
	'## Pick from list
	if recModeratorsCount <> "" then
		for iModerators = 0 to recModeratorsCount
			MembersMemberID = allModeratorsData(meMEMBER_ID, iModerators)
			MembersMemberName = allModeratorsData(meM_NAME, iModerators)

			if not(Instr("," & tmpStrUserList & "," , "," & MembersMemberID & ",") > 0) then
				Response.Write 	"                      		<option value=""" & MembersMemberID & """>" & ChkString(MembersMemberName,"display") & "</option>" & vbNewline
			end if
		next
	end if
	Response.Write	"                      </select>" & vbNewLine & _
			"                      </td>" & vbNewLine & _
			"                      <td width=""15"" align=""center"" valign=""middle""><br />" & vbNewLine & _
			"                      <a href=""javascript:moveAllOptions(document.PostTopic.ForumMod, document.PostTopic.ForumModCombo, true, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateRemAll,"","") & "</a>" & vbNewLine & _
			"                      <a href=""javascript:moveSelectedOptions(document.PostTopic.ForumMod, document.PostTopic.ForumModCombo, true, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateRemove,"","") & "</a>" & vbNewLine & _
			"                      <a href=""javascript:moveSelectedOptions(document.PostTopic.ForumModCombo, document.PostTopic.ForumMod, true, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateAdd,"","") & "</a>" & vbNewLine & _
			"                      <a href=""javascript:moveAllOptions(document.PostTopic.ForumModCombo, document.PostTopic.ForumMod, true, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateAddAll,"","") & "</a>" & vbNewLine & _
			"                      </td>" & vbNewLine & _
			"                      <td align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Selected</b></font><br />" & vbNewLine & _
			"                      <select name=""ForumMod"" size=""" & SelectSize & """ tabindex=""-1"" multiple onDblClick=""moveSelectedOptions(document.PostTopic.ForumMod, document.PostTopic.ForumModCombo, true, '')"">" & vbNewLine
	'## Selected List
	if strRqMethod = "EditForum" or strRqMethod = "EditURL" then	
		if recForumModeratorCount <> "" then
			for iForumModerator = 0 to recForumModeratorCount
				ForumModeratorMemberID = allForumModeratorData(moMEMBER_ID, iForumModerator)
				if ForumModeratorMemberID <> "" then
					Response.Write 	"                      		<option value=""" & ForumModeratorMemberID & """>" & getMemberName(ForumModeratorMemberID) & "</option>" & vbNewline
				end if
			next
		end if
	end if
	Response.Write	"                      </select>" & vbNewLine & _
			"                      </td>" & vbNewLine & _
			"                      <td valign=""top"">&nbsp;<a href=""Javascript:openWindow3('pop_help.asp?mode=options#moderators')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></td>" & vbNewLine & _
			"                    </tr>" & vbNewLine & _
			"                  </table>" & vbNewLine & _
			"                </td>" & vbNewLine & _
			"              </tr>" & vbNewLine
end if
'#################################################################################
'## Forum Moderators - End of listbox code
'#################################################################################

' DEM --> Start of Code added for full moderation and subscription services
if strRqMethod = "Forum" or strRqMethod = "EditForum" or _
strRqMethod = "Category" or strRqMethod = "EditCategory" then
	if strSubscription > 0 and strEmail = "1" and _ 
	((strRqMethod = "Category" or strRqMethod = "EditCategory") or _
	((strRqMethod = "Forum" or strRqMethod = "EditForum") and (CatSubscription > 0))) then
		' Subscription service first.....
		Response.Write 	"              <tr>" & vbNewline
		Response.Write 	"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Subscription:</b></font></td>" & vbNewLine
		Response.Write 	"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
		Response.Write 	"                <select name=""Subscription"">" & vbNewLine
		if strRqMethod = "Category" or strRqMethod = "EditCategory" then
			Response.Write 	"                	<option"
			if CatSubscription = 0 then
				Response.Write 	" selected "
			end if
			Response.Write " value=""0"">No Subscriptions Allowed</option>" & vbNewLine
			' If Whole Board or Category Level Subscriptions Allowed, show option
			if strSubscription < 3 then
				Response.Write	"                	<option"
				if CatSubscription = 1 then
					Response.Write	" selected "
				end if
				Response.Write 	" value=""1"">Category Subscriptions Allowed</option>" & vbNewLine
			end if
			' If Whole Board, Category Level or Forum Level Subscriptions Allowed, show option
			if strSubscription < 4 then
				Response.Write 	"                	<option"
				if CatSubscription = 2 then
					Response.Write	" selected "
				end if
				Response.Write 	" value=""2"">Forum Subscriptions Allowed</option>" & vbNewLine
			end if
			Response.Write 	"                	<option"
			if CatSubscription = 3 then
				Response.Write 	" selected "
			end if
			Response.Write 	" value=""3"">Topic Subscriptions Allowed</option>" & vbNewLine
		else
			Response.Write 	"                	<option"
			if ForumSubscription = 0 then
				Response.Write 	" selected "
			end if
			Response.Write " value=""0"">No Subscriptions Allowed</option>" & vbNewLine
			' If Whole Board, Category Level or Forum Level Subscriptions Allowed, show option
			if strSubscription < 4 and CatSubscription < 3 then
				Response.Write 	"                	<option"
				if ForumSubscription = 1 then
					Response.Write 	" selected "
				end if
				Response.Write 	" value=""1"">Forum Subscriptions Allowed</option>" & vbNewLine
			end if
			Response.Write 	"                	<option"
			if ForumSubscription = 2 then
				Response.Write 	" selected "
			end if
			Response.Write 	" value=""2"">Topic Subscriptions Allowed</option>" & vbNewLine
		end if
		Response.Write 	"                </select>" & vbNewline
		Response.Write 	"                <a href=""Javascript:openWindow3('pop_help.asp?mode=options#subscription')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></font></td>" & vbNewline
		Response.Write	"              </tr>" & vbNewLine
	end if
   
	' Topic Moderation Code - Check if Moderation is allowed over the entire board, then
	' check if Moderation is allowed for the next level up.
   	if strModeration > 0 and _
	((strRqMethod = "Category" or strRqMethod = "EditCategory") or _
	((strRqMethod = "Forum"   or strRqMethod = "EditForum") and CatModeration > 0)) then
   		Response.Write 	"              <tr>" & vbNewline
	   	Response.Write 	"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Moderation:</b></font></td>" & vbNewLine
		Response.Write 	"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
		Response.Write 	"                <select name=""Moderation"">" & vbNewLine
		if strRqMethod = "Category" or strRqMethod = "EditCategory" then
			Response.Write 	"                	<option"
			if CatModeration = 0 then
				Response.Write 	" selected "
			end if
			Response.Write 	" value=""0"">Moderation Not Allowed in this Category</option>" & vbNewLine
			Response.Write 	"                	<option"
			if CatModeration = 1 then
				Response.Write 	" selected "
			end if
			Response.Write 	" value=""1"">Moderation Allowed in this Category</option>" & vbNewLine
   		else  	  
			Response.Write 	"                	<option"
	      		if ForumModeration = 0 then
		     		Response.Write 	" selected "
	  		end if
	  		Response.Write 	" value=""0"">No Moderation for this forum</option>" & vbNewLine
			Response.Write 	"                	<option"
      			if ForumModeration = 1 then
		     		Response.Write 	" selected "
	  		end if
	  		Response.Write 	" value=""1"">All Posts Moderated</option>" & vbNewLine
			Response.Write 	"                	<option"
      			if ForumModeration = 2 then
	     			Response.Write 	" selected "
	  		end if
	  		Response.Write 	" value=""2"">Original Posts Only Moderated</option>" & vbNewLine
			Response.Write 	"                	<option"
	      		if ForumModeration = 3 then
		     		Response.Write 	" selected "
	  		end if
	  		Response.Write 	" value=""3"">Replies Only Moderated</option>" & vbNewLine
   		end if
   		Response.Write 	"                </select>" & vbNewline
   		Response.Write 	"                <a href=""Javascript:openWindow3('pop_help.asp?mode=options#moderation')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a>&nbsp;</font></td>" & vbNewline
   		Response.Write 	"              </tr>" & vbNewline
	end if
end if
' DEM --> End of Code Added for Moderation and Subscription
 
if strRqMethod = "Edit" or _
strRqMethod = "URL" or strRqMethod = "EditURL" or _
strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
strRqMethod = "EditTopic" or strRqMethod = "Topic" or strRqMethod = "TopicQuote" then 
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """>&nbsp;</td>" & vbNewLine & _
			"                <td bgColor=""" & strPopUpTableColor & """>" & vbNewLine
	if strRqMethod = "Edit" or strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
	strRqMethod = "Topic" or strRqMethod = "EditTopic" or strRqMethod = "TopicQuote" then 
		if (strRqMethod = "Reply" or strRqMethod = "ReplyQuote" or _
		strRqMethod = "Topic" or strRqMethod = "TopicQuote") and strSignatures = "1" and strDSignatures <> "1" then 
			Response.Write	"                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
		        intSigDefault = getSigDefault(MemberID)
		        Response.Write	"                <input name=""Sig"" id=""Sig"" type=""checkbox"" value=""yes""" & chkCheckbox(intSigDefault,1,true) & "><label for=""Sig"">Check here to include your profile signature.</label><br /></font>" & vbNewLine
		end if
		if strSignatures = "1" and strDSignatures = "1" then
	        	Response.Write "                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>"
			if strRqMethod = "Edit" then
			        Response.Write "<input name=""Sig"" id=""Sig"" type=""checkbox"" value=""yes""" & chkCheckbox(rs("R_SIG"),1,true) & "><label for=""Sig"">Check here to include your profile signature.</label><br /></font>" & vbNewLine
        		elseif strRqMethod = "EditTopic" then
	        		Response.Write "<input name=""Sig"" id=""Sig"" type=""checkbox"" value=""yes""" & chkCheckbox(rs("T_SIG"),1,true) & "><label for=""Sig"">Check here to include your profile signature.</label><br /></font>" & vbNewLine
			else
			        intSigDefault = getSigDefault(MemberID)
			        Response.Write	"<input name=""Sig"" id=""Sig"" type=""checkbox"" value=""yes""" & chkCheckbox(intSigDefault,1,true) & "><label for=""Sig"">Check here to include your profile signature.</label><br /></font>" & vbNewLine
			end if 
		end if 
		'## Subscribe checkbox start ##
		if strSubscription > 0 and postCat_Subscription > 0 and postForum_Subscription > 0 and strEmail = 1 then
			' -- Check for a topic subscription held by the user
			Dim strSubString, strSubArray, strBoardSubs, strCatSubs, strForumSubs, strTopicSubs
			if MySubCount > 0 then
				strSubString = PullSubscriptions(0, 0, 0)
				strSubArray  = Split(strSubString,";")
				if uBound(strSubArray) < 0 then
					strBoardSubs = ""
					strCatSubs = ""
					strForumSubs = ""
					strTopicSubs = ""
				else
					strBoardSubs = strSubArray(0)
					strCatSubs = strSubArray(1)
					strForumSubs = strSubArray(2)
					strTopicSubs = strSubArray(3)
				end If
			end if
			SubLinkFontStart = "                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>"
			SubLinkFontEnd = "<br /></font>" & vbNewLine
			if InArray(strTopicSubs, strRqTopicID) and strRqMethod <> "Topic" then
				Response.Write SubLinkFontStart & ShowSubLink ("U", strRqCatID, strRqForumID, strRqTopicID, "Y") & SubLinkFontEnd
			elseif strBoardSubs <> "Y" and not(InArray(strForumSubs,strRqForumID) or InArray(strCatSubs,strRqCatID)) then
				Response.Write SubLinkFontStart & ShowSubLink ("S", strRqCatID, strRqForumID, strRqTopicID, "Y") & SubLinkFontEnd
			end if
		end if
		'# Subscribe checkbox end ##
		if ((mLev = 4) or (chkForumModerator(strRqForumId, strDBNTUserName) = "1")) _
		and (strRqMethod = "Topic" or strRqMethod = "EditTopic" or strRqMethod = "Reply" or _
		strRqMethod = "ReplyQuote" or strRqMethod = "TopicQuote") then
			if strStickyTopic = "1" then
				if strRqMethod = "Topic" then
					Response.Write	"                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""sticky"" id=""sticky"" type=""checkbox"" value=""1""><label for=""sticky"">Check here to make this topic sticky.</label><br /></font>" & vbNewLine
				elseif strRqMethod = "EditTopic" then
					Response.Write	"                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""sticky"" id=""sticky"" type=""checkbox"" value=""1""" & chkCheckbox(strTopicSticky,1,true) & "><label for=""sticky"">Check here to make this topic sticky.</label><br /></font>" & vbNewLine
				end if
			end if
			if blnTStatus = 1 then
				if strRqMethod <> "EditTopic" then
					Response.Write	"                <font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><input name=""lock"" id=""lock"" type=""checkbox"" value=""1""><label for=""lock"">Check here to lock the topic after this post.</label><br /></font>" & vbNewLine
				end if
			end if
		end if
		if (strDBNTUserName = "" and strSignatures <> "1") or (strRqMethod = "EditTopic" and strDSignatures <> "1") then
			Response.Write	"                &nbsp;" & vbNewLine
		end if
	end if
	Response.Write	"                </td>" & vbNewline
	Response.Write	"              </tr>" & vbNewline
end if 

if strPrivateForums <> "0" then 
	if strRqMethod = "Forum" or _
	strRqMethod = "URL" or _
	strRqMethod = "EditURL" or _
	strRqMethod = "EditForum" then 
		if strRqMethod = "EditForum" or _
		strRqMethod = "EditURL" then
			ForumAuthType = rs("F_PRIVATEFORUMS")
		else
			ForumAuthType = 0
		end if
		Response.Write	"              <tr>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Auth Type:</b></font></td>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """>" & vbNewLine & _
				"                <select readonly name=""AuthType"">" & vbNewLine & _
				"                	<option value=""0"""
		if ForumAuthType = 0 then Response.Write(" selected")
		Response.Write	">All Visitors</option>" & vbNewLine & _
				"                	<option value=""4"""
		if ForumAuthType = 4 then Response.Write(" selected")
		Response.Write	">Members Only</option>" & vbNewLine & _
				"                	<option value=""5"""
		if ForumAuthType = 5 then Response.Write(" selected")
		Response.Write	">Members Only (Hidden)</option>" & vbNewLine
		if strRqMethod = "Forum" or _
		strRqMethod = "EditForum" then 
			Response.Write	"                	<option value=""2"""
			if ForumAuthType = 2 then Response.Write(" selected")
			Response.Write	">Password Protected</option>" & vbNewLine & _
					"                	<option value=""7"""
			if ForumAuthType = 7 then Response.Write(" selected")
			Response.Write	">Members Only & Password Protected</option>" & vbNewLine & _
					"                	<option value=""3"""
			if ForumAuthType = 3 then Response.Write(" selected")
			Response.Write	">Allowed Member List & Password Protected</option>" & vbNewLine
		end if
		Response.Write	"                	<option value=""1"""
		if ForumAuthType = 1 then Response.Write(" selected")
		Response.Write	">Allowed Member List</option>" & vbNewLine & _
				"                	<option value=""6"""
		if ForumAuthType = 6 then Response.Write(" selected")
		Response.Write	">Allowed Member List (Hidden)</option>" & vbNewLine
		if strNTGroups = "1" then
			Response.Write	"                	<option value=""9"""
			if ForumAuthType = 9 then Response.Write(" selected")
			Response.Write	">NT Global Group</option>" & vbNewLine & _
					"                	<option value=""8"""
			if ForumAuthType = 8 then Response.Write(" selected")
			Response.Write	">NT Global Group (Hidden)</option>" & vbNewLine
		end if
		Response.Write	"                </select>&nbsp;<a href=""Javascript:openWindow3('pop_help.asp?mode=options#authtype')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a>" & vbNewLine
		if strRqMethod = "Forum" or _
		strRqMethod = "EditForum" then 
			if strRqMethod = "EditForum" then 
				If rs("F_PASSWORD_NEW") <> " " Then
					strPassword = rs("F_PASSWORD_NEW")
				else 
					strPassword = " "
				end if
			else
				strPassword = " "
			end if
			Response.Write	"                <br /><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Password"
			if strNTGroups = "1" then Response.Write(" or Global Groups")
			Response.Write	":</b><br /></font>" & vbNewLine & _
					"                <input maxLength=""255"" type=""text"" name=""AuthPassword"" size=""50"" value=""" & strPassword & """>"
		end if
		Response.Write	"</td>" & vbNewLine & _
				"              </tr>" & vbNewLine & _
				"              <tr>" & vbNewLine & _
				"                <td bgColor=""" & strPopUpTableColor & """ noWrap vAlign=""top"" align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Allowed Member List:</b></font></td>" & vbNewLine
		'#################################################################################
		'## Allowed User - listbox Code
		'#################################################################################
		strSql = "SELECT MEMBER_ID, M_NAME "
		strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS "
		strSql = strSql & " WHERE M_STATUS = " & 1
		strSql = strSql & " ORDER BY M_NAME ASC "

		set rsMember = Server.CreateObject("ADODB.Recordset")
		rsMember.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

		if rsMember.EOF then
			recMemberCount = ""
		else
			allMemberData = rsMember.GetRows(adGetRowsRest)
			recMemberCount = UBound(allMemberData,2)
			meMEMBER_ID = 0
			meM_NAME = 1
		end if

		rsMember.close
		set rsMember = nothing

		tmpStrUserList  = ""

		if strRqMethod = "EditForum" or strRqMethod = "EditURL" then
			strSql = "SELECT MEMBER_ID "
			strSql = strSql & " FROM " & strTablePrefix & "ALLOWED_MEMBERS "
			strSql = strSql & " WHERE FORUM_ID = " & strRqForumID

			set rsAllowedMember = Server.CreateObject("ADODB.Recordset")
			rsAllowedMember.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

			if rsAllowedMember.EOF then
				recAllowedMemberCount = ""
			else
				allAllowedMemberData = rsAllowedMember.GetRows(adGetRowsRest)
				recAllowedMemberCount = UBound(allAllowedMemberData,2)
				amMEMBER_ID = 0
			end if

			rsAllowedMember.close
			set rsAllowedMember = nothing

			if recAllowedMemberCount <> "" then
				for iAllowedMember = 0 to recAllowedMemberCount
					AllowedMembersMemberID = allAllowedMemberData(amMEMBER_ID, iAllowedMember)
					if tmpStrUserList = "" then
						tmpStrUserList = AllowedMembersMemberID
					else
						tmpStrUserList = tmpStrUserList & "," & AllowedMembersMemberID
					end if
				next
			end if
		end if
		SelectSize = 6
		Response.Write	"                <td bgColor=""" & strPopUpTableColor & """>" & vbNewLine & _
				"                  <table>" & vbNewLine & _
				"                    <tr>" & vbNewLine & _
				"                      <td align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Available</b></font><br />" & vbNewLine & _
				"                      <select name=""AuthUsersCombo"" size=""" & SelectSize & """ multiple onDblClick=""moveSelectedOptions(document.PostTopic.AuthUsersCombo, document.PostTopic.AuthUsers, false, '')"">" & vbNewLine
		'## Pick from list
		if recMemberCount <> "" then
			for iMembers = 0 to recMemberCount
				MembersMemberID = allMemberData(meMEMBER_ID, iMembers)
				MembersMemberName = allMemberData(meM_NAME, iMembers)
				if not(Instr("," & tmpStrUserList & "," , "," & MembersMemberID & ",") > 0) then
					Response.Write 	"                      		<option value=""" & MembersMemberID & """>" & ChkString(MembersMemberName,"display") & "</option>" & vbNewline
				end if
			next
		end if
		Response.Write	"                      </select>" & vbNewLine & _
				"                      </td>" & vbNewLine & _
				"                      <td width=""15"" align=""center"" valign=""middle""><br />" & vbNewLine & _
				"                      <a href=""javascript:moveAllOptions(document.PostTopic.AuthUsers, document.PostTopic.AuthUsersCombo, false, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateRemAll,"","") & "</a>" & vbNewLine & _
				"                      <a href=""javascript:moveSelectedOptions(document.PostTopic.AuthUsers, document.PostTopic.AuthUsersCombo, false, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateRemove,"","") & "</a>" & vbNewLine & _
				"                      <a href=""javascript:moveSelectedOptions(document.PostTopic.AuthUsersCombo, document.PostTopic.AuthUsers, false, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateAdd,"","") & "</a>" & vbNewLine & _
				"                      <a href=""javascript:moveAllOptions(document.PostTopic.AuthUsersCombo, document.PostTopic.AuthUsers, false, '')"" tabindex=""-1"">" & getCurrentIcon(strIconPrivateAddAll,"","") & "</a>" & vbNewLine & _
				"                      </td>" & vbNewLine & _
				"                      <td align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Selected</b></font><br />" & vbNewLine & _
				"                      <select name=""AuthUsers"" size=""" & SelectSize & """ tabindex=""-1"" multiple onDblClick=""moveSelectedOptions(document.PostTopic.AuthUsers, document.PostTopic.AuthUsersCombo, false, '')"">" & vbNewLine
		'## Selected List
		if strRqMethod = "EditForum" or strRqMethod = "EditURL" then	
			if recAllowedMemberCount <> "" then
				for iAllowedMember = 0 to recAllowedMemberCount
					AllowedMembersMemberID = allAllowedMemberData(amMEMBER_ID, iAllowedMember)
					if AllowedMembersMemberID <> "" then
						Response.Write 	"                      		<option value=""" & AllowedMembersMemberID & """>" & getMemberName(AllowedMembersMemberID) & "</option>" & vbNewline
					end if
				next
			end if
		end if
		Response.Write	"                      </select>" & vbNewLine & _
				"                      </td>" & vbNewLine & _
				"                      <td valign=""top"">&nbsp;<a href=""Javascript:openWindow3('pop_help.asp?mode=options#memberlist')"" tabindex=""-1"">" & getCurrentIcon(strIconSmileQuestion,"Click here to get more help on this option","") & "</a></td>" & vbNewLine & _
				"                    </tr>" & vbNewLine & _
				"                  </table>" & vbNewLine & _
				"                </td>" & vbNewLine & _
				"              </tr>" & vbNewLine
		'#################################################################################
		'## Allowed User - End of listbox code
		'#################################################################################
	end if
end if 

Response.Write	"              <tr>" & vbNewline & _
		"                <td bgColor=""" & strPopUpTableColor & """>&nbsp;</td>" & vbNewline & _
		"                <td bgColor=""" & strPopUpTableColor & """><input name=""Submit"" type=""submit"" value=""" & btn & """"
if strRqMethod = "Forum" or _
strRqMethod = "URL" or _
strRqMethod = "EditURL" or _
strRqMethod = "EditForum" then 
	if strPrivateForums <> "0" then
		if mLev = 3 then
			Response.Write	" onclick=""selectAllOptions(document.PostTopic.AuthUsers);"""
		else
			Response.Write	" onclick=""selectAllOptions(document.PostTopic.AuthUsers);selectAllOptions(document.PostTopic.ForumMod);"""
		end if
	else
		if mLev > 3 then Response.Write	" onclick=""selectAllOptions(document.PostTopic.ForumMod);"""
	end if
end if
Response.Write	">"

if strAllowForumCode = "1" or strAllowHTML = "1" then
	if strRqMethod = "Reply" or _
	strRqMethod = "ReplyQuote" or _
	strRqMethod = "Edit" or _
	strRqMethod = "EditTopic" or _
	strRqMethod = "Topic" or _
	strRqMethod = "TopicQuote" then 
		Response.Write	"&nbsp;<input name=""Preview"" type=""button"" value="" Preview "" onclick=""OpenPreview()"">"
	end if 
end if
'Response.Write	"&nbsp;<input name=""Reset"" type=""reset"" value=""Reset Fields"" tabindex=""-1""></td>" & vbNewline & _
Response.Write	"</td>" & vbNewline & _
		"              </tr>" & vbNewline & _
		"              </form>" & vbNewLine & _
		"            </table>" & vbNewline & _
		"          </td>" & vbNewline & _
		"        </tr>" & vbNewline & _
		"      </table>" & vbNewline & _
		"      <br />" & vbNewline

if strRqMethod = "Reply" or _
strRqMethod = "TopicQuote" or _
strRqMethod = "ReplyQuote" then
	Response.Write	"    </td>" & vbNewLine & _
			"  </tr>" & vbNewLine & _
			"</table>" & vbNewLine & _
			"<table align=""center"" border=""0"" cellPadding=""0"" cellSpacing=""0"" width=""95%"">" & vbNewLine & _
			"  <tr>" & vbNewLine & _
			"    <td>" & vbNewLine & _
			"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbNewLine & _
			"        <tr>" & vbNewLine & _
			"          <td bgcolor=""" & strTableBorderColor & """>" & vbNewLine & _
			"            <table border=""0"" width=""100%"" cellspacing=""1"" cellpadding=""4"">" & vbNewLine & _
			"              <tr>" & vbNewLine & _
			"                <td bgcolor=""" & strHeadCellColor & """ colspan=""2"" align=""center""><b><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strHeadFontColor & """>T O P I C&nbsp;&nbsp;&nbsp;&nbsp;R E V I E W</font></b></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
	' DEM --> Added Select of Moderation Fields
	strSQL = "SELECT C.CAT_MODERATION, F.F_MODERATION "
	strSQL = strSQL & "FROM " & strTablePrefix & "CATEGORY C, " & strTablePrefix & "FORUM F "
	strSQL = strSQL & " WHERE C.CAT_ID = " & strRqCatID
	strSQL = strSQL & " AND F.FORUM_ID = " & strRqForumID
	set rsa = my_Conn.Execute (strSql) 
	' ## Moderators and Admins can see unmoderated posts.
	if (mLev = 4) or (chkForumModerator(strRqForumId, strDBNTUserName) = "1") then
		Moderation = "N"
	else
		if strModeration = 1 and rsa("CAT_MODERATION") = 1 and (rsa("F_MODERATION") = 1 or rsa("F_MODERATION") = 3) then
			Moderation = "Y"
		else
			Moderation = "N"
		end if
	end if
	' DEM --> End of Moderation Code

	'## Forum_SQL
	strSql = "SELECT M.M_NAME, T.T_DATE, T.T_MESSAGE " 
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS M, " & strActivePrefix & "TOPICS T "
	strSql = strSql & " WHERE M.MEMBER_ID = T.T_AUTHOR AND T.TOPIC_ID = " &  strRqTopicID

	set rs = my_Conn.Execute (strSql) 

	Response.Write "              <tr>" & vbNewline
	Response.Write "                <td bgcolor=""" & strForumFirstCellColor & """ valign=""top"" width=""" & strTopicWidthLeft & """"
	if lcase(strTopicNoWrapLeft) = "1" then
		Response.Write " nowrap"
	end if 
	Response.Write "><font color=""" & strForumFontColor & """ face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>" & ChkString(rs("M_NAME"),"display") & "</b></font></td>" & vbNewline
	Response.Write "                <td bgcolor=""" & strForumFirstCellColor & """ valign=""top"" width=""" & strTopicWidthRight & """"
	if lcase(strTopicNoWrapRight) = "1" then
		Response.Write " nowrap"
	end if 
	Response.Write "><font color=""" & strForumFontColor & """ face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><small>Posted&nbsp;-&nbsp;" & ChkDate(rs("T_DATE"), "&nbsp;:" ,true) & "</small><hr size=""" & strFooterFontSize & """><span class=""spnMessageText"">" & formatStr(rs("T_MESSAGE")) & "</span></font></td>" & vbNewline
	Response.Write "              </tr>" & vbNewline

	rs.close
	set rs = nothing
	'## Forum_SQL - Get all replies to Topic from the DB
	strSql ="SELECT M.M_NAME, R.R_DATE, R.R_MESSAGE "
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS M, " & strActivePrefix & "REPLY R "
	strSql = strSql & " WHERE M.MEMBER_ID = R.R_AUTHOR AND R.TOPIC_ID = " & strRqTopicID
	' DEM --> Added check for moderation so that only admins and moderators can see the unapproved posts.
	if Moderation = "Y" then
		strSql = strSql & " AND R.R_STATUS < 2 " ' Ignore unapproved and rejected posts...
	else
		strSql = strSql & " AND R.R_STATUS < 3 " ' Ignore all rejected posts....
	end if
	strSql = strSql & " ORDER BY R.R_DATE DESC;"

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open TopSQL(strSql,strPageSize), my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

	if rs.EOF then
		recReplyCount = ""
	else
		allReplyData = rs.GetRows(adGetRowsRest)
		recReplyCount = UBound(allReplyData,2)
	end if

	rs.close
	set rs = nothing

	strI = 0 
	if recReplyCount = "" then
		Response.Write ""
	else
		Response.Write	"              <tr>" & vbNewLine & _
				"                <td bgcolor=""" & strHeadCellColor & """ colspan=""2"" align=""center""><b><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strHeadFontColor & """>" & recReplyCount+1 & "&nbsp;&nbsp;&nbsp;L A T E S T&nbsp;&nbsp;&nbsp;&nbsp;R E P L I E S&nbsp;&nbsp;&nbsp;&nbsp;(Newest First)</font></b></td>" & vbNewLine & _
				"              </tr>" & vbNewLine

		mM_NAME = 0
		rR_DATE = 1
		rR_MESSAGE = 2

		for iReply = 0 to recReplyCount

			ReplyMemberName = allReplyData(mM_NAME, iReply)
			ReplyDate = allReplyData(rR_DATE, iReply)
			ReplyMessage = allReplyData(rR_MESSAGE, iReply)

			if strI = 0 then
	 			CColor = strAltForumCellColor
			else
				CColor = strForumCellColor
			end if
			Response.Write 	"              <tr>" & vbNewline & _
					"                <td bgcolor=""" & CColor & """ valign=""top""" & vbNewline
			if lcase(strTopicNoWrapLeft) = "1" then
				Response.Write " nowrap"
			end if 
			Response.Write 	"><b><font color=""" & strForumFontColor & """ face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" &  ChkString(ReplyMemberName,"display") & "</font></b></td>" & vbNewline & _
					"                <td bgcolor=""" & CColor & """ valign=""top"""
			if lcase(strTopicNoWrapRight) = "1" then
				Response.Write " nowrap"
			end if
			Response.Write 	"><font color=""" & strForumFontColor & """ face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><small>Posted&nbsp;-&nbsp;" & ChkDate(ReplyDate, "&nbsp;:" ,true) & "</small><hr size=""" & strFooterFontSize & """><span class=""spnMessageText"">" & formatStr(ReplyMessage) & "</span></font></td>" & vbNewline & _
					"              </tr>" & vbNewline
			strI = strI + 1
			if strI = 2 then 
				strI = 0
			end if
		next
	end if

	Response.Write	"            </table>" & vbNewline  & _
			"          </td>" & vbNewline & _
			"        </tr>" & vbNewline  & _
			"      </table>" & vbNewline & _
			"      <br />" & vbNewline  
end if
WriteFooter

function Go_Result(message) 
	Response.write 	"      <br /><div align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHiliteFontColor & """>" & message & "</font></div>" &_
			"      <br />" &_
			"      <meta http-equiv=""Refresh"" content=""2; URL=default.asp"">"
	WriteFooter
	Response.end
end function
%>
