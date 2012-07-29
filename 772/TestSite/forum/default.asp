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
<!--#INCLUDE FILE="inc_func_secure.asp" -->
<!--#INCLUDE FILE="inc_sha256.asp"-->
<!--#INCLUDE FILE="inc_header.asp" -->
<!--#INCLUDE FILE="inc_func_member.asp" -->
<!--#INCLUDE FILE="inc_moderation.asp" -->
<!--#INCLUDE FILE="inc_subscription.asp" -->
<%
Dim UnapprovedFound, UnModeratedPosts

if Request.QueryString("CAT_ID") <> "" and IsNumeric(Request.QueryString("CAT_ID")) = True then
	Cat_ID = cLng(Request.QueryString("CAT_ID"))
end if

scriptname = request.servervariables("script_name")

if strAutoLogon = 1 then
	if (ChkAccountReg() <> "1") then
		Response.Redirect("register.asp?mode=DoIt")
	end if
end if

if IsEmpty(Session(strCookieURL & "last_here_date")) then
	Session(strCookieURL & "last_here_date") = ReadLastHereDate(strDBNTUserName)
end if

if strModeration = "1" and mLev > 2 then
	UnModeratedPosts = CheckForUnmoderatedPosts("BOARD", 0, 0, 0)
end if

' -- Get all the high level(board, category, forum) subscriptions being held by the user
Dim strSubString, strSubArray, strBoardSubs, strCatSubs, strForumSubs
if MySubCount > 0 then
	strSubString = PullSubscriptions(0,0,0)
	strSubArray  = Split(strSubString,";")
	if uBound(strSubArray) < 0 then
		strBoardSubs = ""
		strCatSubs = ""
		strForumSubs = ""
	else
		strBoardSubs = strSubArray(0)
		strCatSubs = strSubArray(1)
		strForumSubs = strSubArray(2)
	end if
end If

if strShowStatistics <> "1" then

	'## Forum_SQL
	strSql = "SELECT P_COUNT, T_COUNT, U_COUNT " &_
		 " FROM " & strTablePrefix & "TOTALS"

	Set rs1 = Server.CreateObject("ADODB.Recordset")
	rs1.open strSql, my_Conn

	Users = rs1("U_COUNT")
	Topics = rs1("T_COUNT")
	Posts = rs1("P_COUNT")

	rs1.Close
	set rs1 = nothing
end if

if (strShowModerators = "1") or (mlev = 4 or mlev = 3) then
	'## Forum_SQL
	strSql = "SELECT MO.FORUM_ID, ME.MEMBER_ID, ME.M_NAME " & _
		 " FROM " & strTablePrefix & "MODERATOR MO" & _
		 " , " & strMemberTablePrefix & "MEMBERS ME"  & _
		 " WHERE (MO.MEMBER_ID = ME.MEMBER_ID )" & _
		 " ORDER BY MO.FORUM_ID, ME.M_NAME"

	Set rsChk = Server.CreateObject("ADODB.Recordset")
	rsChk.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

	if rsChk.EOF then
		recModeratorCount = ""
	else
		allModeratorData = rsChk.GetRows(adGetRowsRest)
		recModeratorCount = UBound(allModeratorData,2)
	end if

	rsChk.close
	set rsChk = nothing

	if recModeratorCount = "" then
		fMods = "&nbsp;"
	else
		mFORUM_ID = 0
		mMEMBER_ID = 1
		mM_NAME = 2

		for iModerator = 0 to recModeratorCount
			ModForumID = allModeratorData(mFORUM_ID, iModerator)
			ModMemID = allModeratorData(mMEMBER_ID, iModerator)
			ModMemName = replace(allModeratorData(mM_NAME, iModerator),"|","&#124")

			if iModerator = 0 then
				strForumMods = ModForumID & "," & ModMemID & "," & ModMemName
			else
				strForumMods = strForumMods & "|" & ModForumID & "," & ModMemID & "," & ModMemName
			end if
		next
	end if
end if

'## Forum_SQL - Get all Categories from  the DB
strSql = "SELECT CAT_ID, CAT_STATUS, CAT_NAME, CAT_ORDER, CAT_SUBSCRIPTION, CAT_MODERATION " &_
	 " FROM " & strTablePrefix & "CATEGORY "
'############################## Group Cat MoD #####################################
if Cat_ID <> "" then
	strSql = strSql & " WHERE CAT_ID = " & Cat_ID
else
	if Group > 1 and strGroupCategories = "1" then
		strSql = strSql & " WHERE CAT_ID = 0"
		if recGroupCatCount <> "" then
			for iGroupCat = 0 to recGroupCatCount
				strSql = strSql & " or CAT_ID = " & allGroupCatData(1, iGroupCat)
			next
		end if
	end if
end if
'############################## Group Cat MoD #####################################
strSql = strSql & " ORDER BY CAT_ORDER ASC, CAT_NAME ASC;"

set rs = Server.CreateObject("ADODB.Recordset")
rs.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

if rs.EOF then
	if Cat_ID <> "" then response.redirect("default.asp")
	recCategoryCount = ""
else
	allCategoryData = rs.GetRows(adGetRowsRest)
	recCategoryCount = UBound(allCategoryData,2)
end if

rs.close
set rs = nothing

if mlev = 3 then
	strSql = "SELECT FORUM_ID FROM " & strTablePrefix & "MODERATOR " & _
		 " WHERE MEMBER_ID = " & MemberID

	Set rsMod = Server.CreateObject("ADODB.Recordset")
	rsMod.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

	if rsMod.EOF then
		recModCount = ""
	else
		allModData = rsMod.GetRows(adGetRowsRest)
		recModCount = UBound(allModData,2)
	end if

	RsMod.close
	set RsMod = nothing

	if recModCount <> "" then
		for x = 0 to recModCount
			if x = 0 then
				ModOfForums = allModData(0,x)
			else
				ModOfForums = ModOfForums & "," & allModData(0,x)
			end if
		next
	else
		ModOfForums = ""
	end if
else
	ModOfForums = ""
end if

'## Forum_SQL - Build SQL to get forums via category
strSql = "SELECT F.FORUM_ID, F.F_STATUS, F.CAT_ID, F.F_SUBJECT, F.F_URL, F.F_TOPICS, " &_
	 "F.F_COUNT, F.F_LAST_POST, F.F_LAST_POST_TOPIC_ID, F.F_LAST_POST_REPLY_ID, F.F_TYPE, " & _
	 "F.F_ORDER, F.F_A_COUNT, F.F_SUBSCRIPTION, F_PRIVATEFORUMS, F_PASSWORD_NEW, " & _
	 "M.MEMBER_ID, M.M_NAME, " & _
         "T.T_REPLIES, T.T_UREPLIES, " & _
         "F.F_DESCRIPTION " & _
	 "FROM ((" & strTablePrefix & "FORUM F " &_
	 "LEFT JOIN " & strMemberTablePrefix & "MEMBERS M ON " &_
	 "F.F_LAST_POST_AUTHOR = M.MEMBER_ID) " & _
         "LEFT JOIN " & strTablePrefix & "TOPICS T ON " & _
         "F.F_LAST_POST_TOPIC_ID = T.TOPIC_ID) "
'############################## Group Cat MoD #####################################
if Cat_ID <> "" then
	strSql = strSql & " WHERE F.CAT_ID = " & Cat_ID
else
	if Group > 1 and strGroupCategories = "1" then
		strSql = strSql & " WHERE F.CAT_ID = 0"
		if recGroupCatCount <> "" then
			for iGroupCat = 0 to recGroupCatCount
				strSql = strSql & " OR F.CAT_ID = " & allGroupCatData(1, iGroupCat)
			next
		end if
	end if
end if
'############################## Group Cat MoD #####################################
strSql = strSql & " ORDER BY F.F_ORDER ASC, F.F_SUBJECT ASC;"
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

if Cat_ID <> "" then
	Cat_Name = allCategoryData(2,0)
	Response.Write	"      <script language=""javascript"" type=""text/javascript"">" & vbNewLine & _
			"      document.title='" & chkString(Cat_Name,"pagetitle") & " - " & chkString(strForumTitle,"pagetitle") & "';" & vbNewLine & _
			"      </script>" & vbNewLine
end if
Response.Write	"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbNewline & _
		"        <tr>" & vbNewline & _
		"          <td>"
' If Whole Board Subscription is allowed, check for a subscription by this user.
if strSubscription = 1 and strEmail = 1 and strDBNTUserName <> "" then
	Response.Write	vbNewLine
	Response.Write 	"            <table width=""100%"" border=""0"">" & vbNewline
	Response.Write 	"              <tr>" & vbNewLine
	Response.Write	"                <td align=""right"">"
	If strBoardSubs = "Y" then
		Response.Write ShowSubLink ("U", 0, 0, 0, "Y")
	Else
		Response.Write ShowSubLink ("S", 0, 0, 0, "Y")
	End If
   	Response.Write 	"</td>" & vbNewLine
   	Response.Write	"              </tr>" & vbNewline
   	Response.Write  "            </table>" & vbNewline
   	Response.Write 	"          </td>" & vbNewline
	Response.Write 	"        </tr>" & vbNewline
   	Response.Write 	"        <tr>" & vbNewline
   	Response.Write 	"          <td>"
end if

ShowLastHere = (mLev > 0)
if strShowStatistics <> "1" then
	Response.Write	vbNewLine & _
			"            <table width=""100%"" border=""0"">" & vbNewline & _
			"              <tr>" & vbNewline & _
			"                <td>"
	if ShowLasthere then 
		Response.Write	"<font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>You Last Visited - " & ChkDate(Session(strCookieURL & "last_here_date"), " " ,true) & "</font>"
	else
		Response.Write	"&nbsp;"
	end if 
	Response.Write	"</td>" & vbNewline & _
			"                <td align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>There are " & Posts & " Posts in " & Topics & " Topics and " & Users & " Users&nbsp;&nbsp;</font></td>" & vbNewline & _
			"              </tr>" & vbNewline & _
			"            </table>" & vbNewline & _
			"          </td>" & vbNewline
else
	Response.Write	"</td>" & vbNewline
end if
Response.Write	"        </tr>" & vbNewline & _
		"        <tr>" & vbNewline & _
		"          <td bgcolor=""" & strTableBorderColor & """>" & vbNewline & _
		"            <table border=""0"" width=""100%"" cellspacing=""1"" cellpadding=""4"">" & vbNewline & _
		"              <tr>" & vbNewline & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """ nowrap valign=""top""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>"
if Cat_ID <> "" then
	Response.Write	"<a href=""default.asp"">" & getCurrentIcon(strIconFolder,"Show All Categories","hspace=""0""") & "</a>"
else
	Response.Write 	"&nbsp;"
end if
Response.Write	"</font></b></td>" & vbNewline & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """ nowrap valign=""top""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>"
if strGroupCategories = "1" then Response.Write(GROUPNAME) else Response.Write("Forum")
Response.Write	"</font></b></td>" & vbNewline & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """ nowrap valign=""top""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Topics</font></b></td>" & vbNewline & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """ nowrap valign=""top""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Posts</font></b></td>" & vbNewline & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """ nowrap valign=""top""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Last&nbsp;Post</font></b></td>" & vbNewline
if (strShowModerators = "1") or (mlev = 4 or mlev = 3) then
	Response.Write	"                <td align=""center"" bgcolor=""" & strHeadCellColor & """ nowrap valign=""top""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Moderator(s)</font></b></td>" & vbNewline
end if 
	Response.Write	"                <td align=""center"" bgcolor=""" & strHeadCellColor & """>"
if (mlev = 4 or mlev = 3) or (lcase(strNoCookies) = "1") then 
	call PostingOptions()
else
	Response.write "&nbsp;"
end if 
Response.Write	"</td>" & vbNewline
Response.Write	"              </tr>" & vbNewline
If recCategoryCount = "" then
	Response.Write	"              <tr>" & vbNewline & _
			"                <td bgcolor=""" & strCategoryCellColor & """ colspan="""
	if (strShowModerators = "1") or (mlev > 0 ) then 
		Response.Write	"6" 
	else 
		Response.Write	"5"
	end if
	Response.Write	"""><font face=""" & strDefaultFontFace & """ color=""" & strCategoryFontColor & """ size=""" & strDefaultFontSize & """><b>No Categories/Forums Found</b></font></td>" & vbNewline & _
       			"                <td bgcolor=""" & strCategoryCellColor & """><font face=""" & strDefaultFontFace & """ color=""" & strCategoryFontColor & """ size=""" & strDefaultFontSize & """>&nbsp;</font></td>" & vbNewline & _
			"              </tr>" & vbNewline
else
	intPostCount  = 0
	intTopicCount = 0
	intForumCount = 0
	strLastPostDate = ""

	cCAT_ID = 0
	cCAT_STATUS = 1
	cCAT_NAME = 2
	cCAT_ORDER = 3
	cCAT_SUBSCRIPTION = 4
	cCAT_MODERATION = 5

	fFORUM_ID = 0
	fF_STATUS = 1
	fCAT_ID = 2
	fF_SUBJECT = 3
	fF_URL = 4
	fF_TOPICS = 5
	fF_COUNT = 6
	fF_LAST_POST = 7
	fF_LAST_POST_TOPIC_ID = 8
	fF_LAST_POST_REPLY_ID = 9
	fF_TYPE = 10
	fF_ORDER = 11
	fF_A_COUNT = 12
	fF_SUBSCRIPTION = 13
	fF_PRIVATEFORUMS = 14
	fF_PASSWORD_NEW = 15
	fMEMBER_ID = 16
	fM_NAME = 17
	fT_REPLIES = 18
	fT_UREPLIES = 19
	fF_DESCRIPTION = 20

	blnHiddenForums = false
	for iCategory = 0 to recCategoryCount
		CatID = allCategoryData(cCAT_ID,iCategory)
		CatStatus = allCategoryData(cCAT_STATUS,iCategory)
		CatName = allCategoryData(cCAT_NAME,iCategory)
		CatOrder = allCategoryData(cCAT_NAME,iCategory)
		CatSubscription = allCategoryData(cCAT_SUBSCRIPTION,iCategory)
		CatModeration = allCategoryData(cCAT_MODERATION,iCategory)

		chkDisplayHeader = true
				 
		bContainsForum = False
		if recForumCount <> "" then
			for iForumCheck = 0 to recForumCount
				if CatID = allForumData(fCAT_ID, iForumCheck) then bContainsForum = True
			next
		end if

		if (recForumCount = "" or not bContainsForum) and (mLev = 4) then
			Response.Write	"              <tr>" & vbNewline & _
					"                <td bgcolor=""" & strCategoryCellColor & """ colspan=""" & sGetColspan(6,5) & """>"
			if Cat_ID = "" then
				Response.Write "<a href=""default.asp?CAT_ID=" & CatID & """ title=""View only the Forums in this Category""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """><b>" & ChkString(CatName,"display") & "</b></font></a></td>" & vbNewline
			else
				Response.Write "<font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """><b>" & ChkString(CatName,"display") & "</b></font></td>" & vbNewline
			end if
			if (mlev = 4) or (lcase(strNoCookies) = "1") then 
				Response.Write	"                <td bgcolor=""" & strCategoryCellColor & """ align=center valign=""top"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>"
				call CategoryAdminOptions()
				Response.Write	"</font></b></td>" & vbNewline
			end if 
			Response.Write	"              </tr>" & vbNewline & _
					"              <tr>" & vbNewline & _
					"                <td bgcolor=""" & strForumCellColor & """ colspan=""" & sGetColspan(7,6) &_
					"""><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strDefaultFontSize & """><b>No Forums Found</b></font></td>" & vbNewline & _
					"              </tr>" & vbNewline
		else
			for iForum = 0 to recForumCount
				if CatID = allForumData(fCAT_ID, iForum) then '## Forum exists
					ForumID = allForumData(fFORUM_ID,iForum)
					ForumStatus = allForumData(fF_STATUS,iForum)
					ForumCatID = allForumData(fCAT_ID,iForum)
					ForumSubject = allForumData(fF_SUBJECT,iForum)
					ForumURL = allForumData(fF_URL,iForum)
					ForumTopics = allForumData(fF_TOPICS,iForum)
					ForumCount = allForumData(fF_COUNT,iForum)
					ForumLastPost = allForumData(fF_LAST_POST,iForum)
					ForumLastPostTopicID = allForumData(fF_LAST_POST_TOPIC_ID,iForum)
					ForumLastPostReplyID = allForumData(fF_LAST_POST_REPLY_ID,iForum)
					ForumFType = allForumData(fF_TYPE,iForum)
					ForumOrder = allForumData(fF_ORDER,iForum)
					ForumACount = allForumData(fF_A_COUNT,iForum)
					ForumSubscription = allForumData(fF_SUBSCRIPTION,iForum)
					ForumPrivateForums = allForumData(fF_PRIVATEFORUMS,iForum)
					ForumFPasswordNew = allForumData(fF_PASSWORD_NEW,iForum)
					ForumMemberID = allForumData(fMEMBER_ID,iForum)
					ForumMemberName = allForumData(fM_NAME,iForum)
					ForumTopicReplies = allForumData(fT_REPLIES,iForum)
					ForumTopicUReplies = allForumData(fT_UREPLIES,iForum)
					ForumDescription = allForumData(fF_DESCRIPTION,iForum)

					Dim AdminAllowed, ModerateAllowed
					if mLev = 4 then
						AdminAllowed = "Y"
					else
					    	AdminAllowed = "N"
					end if
					if mLev = 4 then
						ModerateAllowed = "Y"
					elseif mLev = 3 and ModOfForums <> "" then
						if (strAuthType = "nt") then
							if (chkForumModerator(ForumID, Session(strCookieURL & "username")) = "1") then ModerateAllowed = "Y" else ModerateAllowed = "N"
						else 
							if (instr("," & ModOfForums & "," ,"," & ForumID & ",") <> 0) then ModerateAllowed = "Y" else ModerateAllowed = "N"
						end if
					else
						ModerateAllowed = "N"
					end if
					if ModerateAllowed = "Y" and ForumTopicUReplies > 0 then
						ForumTopicReplies = ForumTopicReplies + ForumTopicUReplies
					end if
					if ChkDisplayForum(ForumPrivateForums,ForumFPasswordNew,ForumID,MemberID) then
						if ForumFType <> "1" then 
							intPostCount  = intPostCount + ForumCount
							intTopicCount = intTopicCount + ForumTopics
							intForumCount = intForumCount + 1
							if ForumLastPost > strLastPostDate then 
								strLastPostDate = ForumLastPost
								intLastPostTopic_ID = ForumLastPostTopicID
								intLastPostReply_ID = ForumLastPostReplyID
								intTopicReplies = ForumTopicReplies
								intLastPostForum_ID = ForumID
								intLastPostMember_ID = ForumMemberID
								strLastPostMember_Name = ForumMemberName
							end if
						end if
						if chkDisplayHeader then
							Call DoHideCategory(CatID)
							Response.Write	"              <tr>" & vbNewline & _
									"                <td bgcolor=""" & strCategoryCellColor & """ colspan=""" & sGetColspan(6,5) & """ valign=""top"">"
							'##### This code will specify whether or not to show the forums under a category #####
							HideForumCat = strUniqueID & "HideCat" & CatID
				 			if Request.Cookies(HideForumCat) = "Y" then
						        	Response.Write	"<a href=""" & ScriptName & "?" & HideForumCat & "=N"">" & getCurrentIcon(strIconPlus,"Expand This Category","") & "</a>"
							else
					       			Response.Write	"<a href=""" & ScriptName & "?" & HideForumCat & "=Y"">" & getCurrentIcon(strIconMinus,"Collapse This Category","") & "</a>"
							end if
							if Cat_ID = "" then
								Response.Write	"&nbsp;<a href=""default.asp?CAT_ID=" & CatID & """ title=""View only the Forums in this Category""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """><b>" & ChkString(CatName,"display") & "</b></font></a>&nbsp;&nbsp;</td>" & vbNewline
							else
								Response.Write 	"&nbsp;<font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """><b>" & ChkString(CatName,"display") & "</b></font>&nbsp;&nbsp;</td>" & vbNewline
							end if
							'##### Above code will specify whether or not to show the forums under a category #####
							 
							Response.Write	"                <td bgcolor=""" & strCategoryCellColor & """ align=""center"" valign=""top"" nowrap><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>"
							if (mLev = 4 or mLev = 3) or (lcase(strNoCookies) = "1") then
								call CategoryAdminOptions()
							elseif (mLev > 0) then
								call CategoryMemberOptions()
							else
								Response.Write("&nbsp;")
							end if
							Response.Write	"</font></b></td>" & vbNewline 
							Response.Write	"              </tr>" & vbNewline
							chkDisplayHeader = false
						end if
				       		if Request.Cookies(HideForumCat) <> "Y" then  '##### added as part of Minimize Category Mod #####
							Response.Write	"              <tr>" & vbNewline & _
									"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top"">"
							if ForumFType = 0 then
								ChkIsNew(ForumLastPost)
							else 
								Response.Write	"<a href=""" & ForumURL & """ target=""_blank"">" & getCurrentIcon(strIconUrl,"Visit " & chkString(ForumSubject,"display"),"hspace=""0""") & "</a>"
							end if 
							Response.Write	"</td>" & vbNewline & _
									"                <td"
							if ForumFType = 1 then
								Response.Write	" colspan=""4"""
							end if
							Response.Write	" bgcolor=""" & strForumCellColor & """ valign=""top"">" & _
									"<font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strDefaultFontSize & """><span class=""spnMessageText""><a href="""
							if ForumFType = 0 then
								Response.Write	"forum.asp?FORUM_ID=" & ForumID
							else 
								Response.Write	ForumURL & """ target=""_blank"
							end if 
							Response.Write	""">" & chkString(ForumSubject,"display") & "</a><br />" & _
									"<font size=""" & strFooterFontSize & """>" & _
									formatStr(ForumDescription) & _
									"</font></span></font></td>" & vbNewline
							if ForumFType = 0 then
								if IsNull(ForumTopics) then 
									Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top""><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strDefaultFontSize & """>0</font></td>" & vbNewline
								else
									Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top""><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strDefaultFontSize & """>" & ForumTopics & "</font></td>" & vbNewline
								end if 
								if IsNull(ForumCount) then 
									Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top""><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strDefaultFontSize & """>0</font></td>" & vbNewline
								else
									Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top""><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strDefaultFontSize & """>" & ForumCount & "</font></td>" & vbNewline
								end if 
								if IsNull(ForumMemberID) then
									strLastUser = "&nbsp;"
								else
									strLastUser = "<br />by:&nbsp;<span class=""spnMessageText"">" & profileLink(chkString(ForumMemberName,"display"),ForumMemberID) & "</span>"
									if strJumpLastPost = "1" then strLastUser = strLastUser & "&nbsp;" & DoLastPostLink(true)
								end if
								Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top"" nowrap><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strFooterFontSize & """>" & _
										"<b>" & ChkDate(ForumLastPost, "</b><br />" ,true) & strLastUser & "</font></td>" & vbNewline
							else 
								'## Do Nothing 
							end if 
							if (strShowModerators = "1") or (mlev = 4 or mlev = 3) then 
								Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""left"" valign=""top""><font face=""" & strDefaultFontFace & """ color=""" & strForumFontColor & """ size=""" & strFooterFontSize & """><span class=""spnMessageText"">" & listForumModerators(ForumID) & "</span></font></td>" & vbNewline
							end if 
							Response.Write	"                <td bgcolor=""" & strForumCellColor & """ align=""center"" valign=""top"" nowrap>"
							if ModerateAllowed = "Y" or (lcase(strNoCookies) = "1") then 
								call ForumAdminOptions
							else
								call ForumMemberOptions
							end if
							Response.Write	"</td>" & vbNewline
							Response.Write	"              </tr>" & vbNewline
						end if ' ##### Added as part of Minimize Category Mod #####					
					else
						blnHiddenForums = true
					end if ' ChkDisplayForum() 
				end if
			next '## Next Forum
		end if
	next '## Next Category
end if 
if strShowStatistics = "1" then
	WriteStatistics
end if 
Response.Write	"            </table>" & vbNewline & _
		"          </td>" & vbNewline & _
		"        </tr>" & vbNewline & _
		"        <tr>" & vbNewline & _
		"          <td>" & vbNewline & _
		"            <table width=""100%"">" & vbNewline & _
		"              <tr>" & vbNewline & _
		"                <td><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & vbNewline & _
		"                " & getCurrentIcon(strIconFolderNew,"New Posts","align=""absmiddle""") & " Contains new posts since last visit.<br />" & vbNewline & _
		"                " & getCurrentIcon(strIconFolder,"Old Posts","align=""absmiddle""") & " No new posts since the last visit.<br /></font></td>" & vbNewline & _
		"              </tr>" & vbNewline & _
		"            </table>" & vbNewline & _
		"          </td>" & vbNewline & _
		"        </tr>" & vbNewline & _
		"      </table>" & vbNewline
WriteFooter
 
sub PostingOptions() 
	if (mlev = 4) or (lcase(strNoCookies) = "1") then 
		Response.Write	"<font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>"
		if Session(strCookieURL & "Approval") = "15916941253" then Response.Write("<a href=""down.asp"">" & getCurrentIcon(strIconLock,"Shut Down the Forum","hspace=""0""") & "</a>")
		Response.Write	"&nbsp;<a href=""post.asp?method=Category"">" & getCurrentIcon(strIconFolderNewTopic,"Create New Category","hspace=""0""") & "</a>"
		if strArchiveState = "1" then Response.Write("&nbsp;<a href=""admin_forums.asp"">" & getCurrentIcon(strIconFolderArchive,"Archive Forum Topics","hspace=""0""") & "</a>")
		Response.Write("</font>")
	        ' DEM --> Start of Code for Full Moderation
        	if UnModeratedPosts > 0 then
			Response.Write	" <a href=""moderate.asp"">" & getCurrentIcon(strIconFolderModerate,"View All UnModerated Posts","hspace=""0""") & "</a>"
			'Response.Write	" <a href=""JavaScript:openWindow('pop_moderate.asp')"">" & getCurrentIcon(strIconFolderModerate,"Approve/Hold/Reject all UnModerated Posts","hspace=""0""") & "</a>"
	        end if
        	' DEM --> End of Code for Full Moderation
		' DEM - Added to allow for sorting
		Response.Write	"&nbsp;<a href=""Javascript:openWindow3('admin_config_order.asp')"">" & getCurrentIcon(strIconSort,"Set the order of Forums and Categories","hspace=""0""") & "</a>"
		'############################## Group Cat MoD #####################################
		if strGroupCategories = "1" then Response.Write("&nbsp;<a href=""admin_config_groupcats.asp?method=Edit"">" & getCurrentIcon(strIconGroupCategories,"Configure Group Categories","hspace=""0""") & "</a>")
		'############################## Group Cat MoD #####################################
	elseif (mlev = 3) then
        	if UnModeratedPosts > 0 then
			Response.Write	" <a href=""moderate.asp"">" & getCurrentIcon(strIconFolderModerate,"View All UnModerated Posts","hspace=""0""") & "</a>"
		else
			Response.Write	"&nbsp;"
	        end if
	else
		Response.Write	"&nbsp;"
	end if
end sub

sub ChkIsNew(dt)
	Response.Write	"<a href=""forum.asp?FORUM_ID=" & ForumID & """>"
	if CatStatus <> 0 and ForumStatus <> 0 then
		if dt > Session(strCookieURL & "last_here_date") and (ForumCount > 0 or ForumTopics > 0) then
			Response.Write	getCurrentIcon(strIconFolderNew,"New Posts","hspace=""0""") & "</a>"
		else
			Response.Write	getCurrentIcon(strIconFolder,"Old Posts","hspace=""0""") & "</a>"
		end if
	elseif ForumLastPost > Session(strCookieURL & "last_here_date") then
		if CatStatus = 0 then
			strAltText = "Category Locked"
		else
			strAltText = "Forum Locked"
		end if
		Response.Write	getCurrentIcon(strIconFolderNewLocked,strAltText,"hspace=""0""") & "</a>"
	else
		if CatStatus = 0 then
			strAltText = "Category Locked"
		else
			strAltText = "Forum Locked"
		end if
		Response.Write	getCurrentIcon(strIconFolderLocked,strAltText,"hspace=""0""") & "</a>"
	end if
end sub

sub CategoryAdminOptions() 
	if (mlev = 4 or mlev = 3) or (lcase(strNoCookies) = "1") then
                if (mlev = 4) or (lcase(strNoCookies) = "1") then
	               	if (CatStatus <> 0) then 
		              	Response.Write "&nbsp;<a href=""JavaScript:openWindow('pop_lock.asp?mode=Category&CAT_ID=" & CatID & "')"">" & getCurrentIcon(strIconLock,"Lock Category","hspace=""0""") & "</a>"
	               	else
	               		Response.Write "&nbsp;<a href=""JavaScript:openWindow('pop_open.asp?mode=Category&CAT_ID=" & CatID & "')"">" & getCurrentIcon(strIconUnlock,"Un-Lock Category","hspace=""0""") & "</a>"
	               	end if 
                end if
		if (mlev = 4) or (lcase(strNoCookies) = "1") then
			if (CatStatus <> 0) then
				Response.Write "&nbsp;<a href=""post.asp?method=EditCategory&CAT_ID=" & CatID & """>" & getCurrentIcon(strIconPencil,"Edit Category Name","hspace=""0""") & "</a>"
			end if
		end if
                if mlev = 4 or (lcase(strNoCookies) = "1") then
			Response.Write "&nbsp;<a href=""JavaScript:openWindow('pop_delete.asp?mode=Category&CAT_ID=" & CatID & "')"">" & getCurrentIcon(strIconTrashcan,"Delete Category","hspace=""0""") & "</a>"
                end if
		if (mlev = 4) or (lcase(strNoCookies) = "1") then
			if (CatStatus <> 0) then
				Response.Write "&nbsp;<a href=""post.asp?method=Forum&CAT_ID=" & CatID & "&type=0"">" & getCurrentIcon(strIconFolderNewTopic,"Create New Forum","hspace=""0""") & "</a>"
			end if
		end if 
		if (mlev = 4) or (lcase(strNoCookies) = "1") then
			if (CatStatus <> 0) then
				Response.Write "&nbsp;<a href=""post.asp?method=URL&CAT_ID=" & CatID & "&type=1"">" & getCurrentIcon(strIconUrl,"Create New Web Link","hspace=""0""") & "</a>"
			end if
		end if 
		if (mlev = 4) or (lcase(strNoCookies) = "1") then
			if (CatStatus <> 0) and strArchiveState = "1" then
				''## Forum_SQL
				'strSQL = "SELECT FORUM_ID FROM " & strTablePrefix & "FORUM WHERE CAT_ID=" & CatID & " AND F_TYPE = 0"

				'Set rsArchive = Server.CreateObject("ADODB.Recordset")
				'rsArchive.open strSql, my_Conn

				'archID = ""
				'do while not rsArchive.EOF
				'	if archID <> "" then
				'		archID = archID & ", "
				'	end if
				'	archID = archID & rsArchive("FORUM_ID")
				'	rsArchive.movenext
				'loop
				'if archID <> "" then Response.Write "&nbsp;<a href=""admin_forums.asp?action=archive&target=admin_forums.asp&id=" & Server.URLEncode(archID) & """>" & getCurrentIcon(strIconFolderArchive,"Archive All Forums in Category","hspace=""0""") & "</a>"
				'rsArchive.close
				'set rsArchive = nothing
			end if
		end if
		if (strSubscription = 1 or strSubscription = 2) and CatSubscription = 1 and strEmail = 1 then
			if InArray(strCatSubs,CatID) then
				Response.Write  "&nbsp;" & ShowSubLink ("U", CatID, 0, 0, "N")
			elseif strBoardSubs <> "Y" then
				Response.Write  "&nbsp;" & ShowSubLink ("S", CatID, 0, 0, "N")
			end if
		elseif mLev = "3" then
			Response.Write	"&nbsp;"
		end if
	else
		Response.Write "&nbsp;"
	end if
end sub 

sub CategoryMemberOptions() 
	if (strSubscription = 1 or strSubscription = 2) and CatSubscription = 1 and CatStatus <> 0 and strEmail = 1 then
		if InArray(strCatSubs,CatID) then
			Response.Write  "&nbsp;" & ShowSubLink ("U", CatID, 0, 0, "N")
		elseif strBoardSubs <> "Y" then
			Response.Write  "&nbsp;" & ShowSubLink ("S", CatID, 0, 0, "N")
		end If
	else
		Response.Write	"&nbsp;"
	end if
end sub 

sub ForumAdminOptions() 
	if (ModerateAllowed = "Y") or (lcase(strNoCookies) = "1") then
		if ForumFType = 0 then
			if CatStatus = 0 then
				if (mlev = 4) then 
					Response.Write	"&nbsp;<a href=""JavaScript:openWindow('pop_open.asp?mode=Category&CAT_ID=" & CatID & "')"">" & getCurrentIcon(strIconUnlock,"Un-Lock Category","hspace=""0""") & "</a>"
				end if
			else 
				if ForumStatus = 1 then 
					Response.Write	"&nbsp;<a href=""JavaScript:openWindow('pop_lock.asp?mode=Forum&FORUM_ID=" & ForumID & "&CAT_ID=" & ForumCatID & "')"">" & getCurrentIcon(strIconLock,"Lock Forum","hspace=""0""") & "</a>"
				else 
					Response.Write	"&nbsp;<a href=""JavaScript:openWindow('pop_open.asp?mode=Forum&FORUM_ID=" & ForumID & "&CAT_ID=" & ForumCatID & "')"">" & getCurrentIcon(strIconUnlock,"Un-Lock Forum","hspace=""0""") & "</a>"
				end if 
			end if
		end if
		if ForumFType = 0 then
			if (CatStatus <> 0 and ForumStatus <> 0) or (ModerateAllowed = "Y") or (lcase(strNoCookies) = "1") then 
				Response.Write	"&nbsp;<a href=""post.asp?method=EditForum&FORUM_ID=" & ForumID & "&CAT_ID=" & ForumCatID & "&type=0"">" & getCurrentIcon(strIconPencil,"Edit Forum Properties","hspace=""0""") & "</a>"
			end if
		else 
			if ForumFType = 1 then 
				Response.Write	"&nbsp;<a href=""post.asp?method=EditURL&FORUM_ID=" & ForumID & "&CAT_ID=" & ForumCatID & "&type=1"">" & getCurrentIcon(strIconPencil,"Edit URL Properties","hspace=""0""") & "</a>"
			end if 
		end if 
		if (mlev = 4) or (lcase(strNoCookies) = "1") then 
			Response.Write	"&nbsp;<a href=""JavaScript:openWindow('pop_delete.asp?mode=Forum&FORUM_ID=" & ForumID & "&CAT_ID=" & ForumCatID & "')"">" & getCurrentIcon(strIconTrashcan,"Delete Forum","hspace=""0""") & "</a>"
		end if
		if ForumFType = 0 then
			Response.Write	"&nbsp;<a href=""post.asp?method=Topic&FORUM_ID=" & ForumID & """>" & getCurrentIcon(strIconFolderNewTopic,"New Topic","hspace=""0""") & "</a>"
		end if 
		if ((mlev = 4) or (lcase(strNoCookies) = "1")) and (ForumFType = 0) and (strArchiveState = "1") then 
			Response.Write	"&nbsp;<a href=""admin_forums.asp?action=archive&id=" & ForumID & """>" & getCurrentIcon(strIconFolderArchive,"Archive Forum","hspace=""0""") & "</a>"
		end if
		if (ForumFType = 0 and ForumACount > 0) and strArchiveState = "1" then
			Response.Write	"&nbsp;<a href=""forum.asp?ARCHIVE=true&FORUM_ID=" & ForumID & """>" & getCurrentIcon(strIconFolderArchived,"View Archived posts","hspace=""0""") & "</a>"
		end if
		if (strSubscription > 0 and strSubscription < 4) and CatSubscription > 0 and ForumSubscription = 1 and strEmail = 1 then
			if InArray(strForumSubs,ForumID) then
				Response.Write "&nbsp;" & ShowSubLink ("U", ForumCatID, ForumID, 0, "N")
			elseif strBoardSubs <> "Y" and not(InArray(strCatSubs,ForumCatID)) then
				Response.Write "&nbsp;" & ShowSubLink ("S", ForumCatID, ForumID, 0, "N")
			end if
		end if
	else
		Response.Write	"&nbsp;"
	end if
end sub 

sub ForumMemberOptions() 
	if (mlev > 0) then
		if ForumFType = 0 and ForumStatus > 0 and CatStatus > 0 then
			Response.Write	"<a href=""post.asp?method=Topic&FORUM_ID=" & ForumID & """>" & getCurrentIcon(strIconFolderNewTopic,"New Topic","hspace=""0""") & "</a>"
		else
			Response.Write "&nbsp;"
		end if 
	else
		Response.Write "&nbsp;"
	end if
	if (ForumFType = 0 and ForumACount > 0) and strArchiveState = "1" then
		Response.Write	"&nbsp;<a href=""forum.asp?ARCHIVE=true&FORUM_ID=" & ForumID & """>" & _
				getCurrentIcon(strIconFolderArchived,"View Archived posts","hspace=""0""") & "</a>"
	end if
	' DEM --> Start of code for Subscription
	if ForumFType = 0 and (strSubscription > 0 and strSubscription < 4) and CatSubscription > 0 and ForumSubscription = 1 and (mlev > 0) and strEmail = 1 then
		if InArray(strForumSubs,ForumID) then 
			Response.Write "&nbsp;" & ShowSubLink ("U", ForumCatID, ForumID, 0, "N")
		elseif strBoardSubs <> "Y" and not(InArray(strCatSubs,ForumCatID)) then
			Response.Write "&nbsp;" & ShowSubLink ("S", ForumCatID, ForumID, 0, "N")
		end if
	end if
	' DEM --> End of Code for Subscription
end sub 

sub WriteStatistics() 
	Dim Forum_Count
	Dim NewMember_Name, NewMember_Id, Member_Count
	Dim LastPostDate, LastPostLink

	Forum_Count = intForumCount
	'## Forum_SQL - Get newest membername and id from DB

	strSql = "SELECT M_NAME, MEMBER_ID FROM " & strMemberTablePrefix & "MEMBERS " &_
	" WHERE M_STATUS = 1 AND MEMBER_ID > 1 " &_
	" ORDER BY MEMBER_ID desc;"

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open TopSQL(strSql,1), my_Conn

	if not rs.EOF then
		NewMember_Name = chkString(rs("M_NAME"), "display")
		NewMember_Id = rs("MEMBER_ID")
	else
		NewMember_Name = ""
	end if

	rs.close
	set rs = nothing

	'## Forum_SQL - Get Active membercount from DB 
	strSql = "SELECT COUNT(MEMBER_ID) AS U_COUNT FROM " & strMemberTablePrefix & "MEMBERS WHERE M_POSTS > 0 AND M_STATUS=1"

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open strSql, my_Conn

	if not rs.EOF then
		Member_Count = rs("U_COUNT")
	else
		Member_Count = 0
	end if

	rs.close
	set rs = nothing

	'## Forum_SQL - Get membercount from DB 
	strSql = "SELECT COUNT(MEMBER_ID) AS U_COUNT FROM " & strMemberTablePrefix & "MEMBERS WHERE M_STATUS=1"

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.open strSql, my_Conn

	if not rs.EOF then
		User_Count = rs("U_COUNT")
	else
		User_Count = 0
	end if

	rs.close
	set rs = nothing

	LastPostDate = ""
 	LastPostLink = ""
	LastPostAuthorLink = ""

	if not (intLastPostForum_ID = "") then	
		ForumTopicReplies = intTopicReplies
		ForumLastPostTopicID = intLastPostTopic_ID
		ForumLastPostReplyID = intLastPostReply_ID

		LastPostDate = ChkDate(strLastPostDate,"",true)
		LastPostLink = DoLastPostLink(false)
		LastPostAuthorLink = " by: <span class=""spnMessageText"">" & profileLink(chkString(strLastPostMember_Name,"display"),intLastPostMember_ID) & "</span>"
	end if

	ActiveTopicCount = -1
	if not IsNull(Session(strCookieURL & "last_here_date")) then 
		if not blnHiddenForums then

			'## Forum_SQL - Get ActiveTopicCount from DB
			strSql = "SELECT COUNT(" & strTablePrefix & "TOPICS.T_LAST_POST) AS NUM_ACTIVE " &_
				 " FROM " & strTablePrefix & "TOPICS " &_
				 " WHERE (((" & strTablePrefix & "TOPICS.T_LAST_POST)>'"& Session(strCookieURL & "last_here_date") & "'))" &_
				 " AND " & strTablePrefix & "TOPICS.T_STATUS <= 1"

			set rs = Server.CreateObject("ADODB.Recordset")
			rs.open strSql, my_Conn
			
			if not rs.EOF then
				ActiveTopicCount = rs("NUM_ACTIVE")
			else
				ActiveTopicCount = 0
			end if

			rs.close
			set rs = nothing
		end if
	end if

	ArchivedPostCount = 0
	ArchivedTopicCount = 0
	if not blnHiddenForums and strArchiveState = "1" then
		'## Forum_SQL
		strSql = "SELECT P_A_COUNT, T_A_COUNT FROM " & strTablePrefix & "TOTALS"

		set rs = Server.CreateObject("ADODB.Recordset")
		rs.open strSql, my_Conn

		if not rs.EOF then
			ArchivedPostCount = rs("P_A_COUNT")
			ArchivedTopicCount = rs("T_A_COUNT")
		else
			ArchivedPostCount = 0
			ArchivedTopicCount = 0
		end if

		rs.Close
		set rs = nothing
	end if

	'ShowLastHere = (cLng(chkUser(strDBNTUserName, Request.Cookies(strUniqueID & "User")("Pword"),-1)) > 0)
	Response.Write	"              <tr>" & vbNewline & _
			"                <td bgcolor=""" & strCategoryCellColor & """ colspan=""" & sGetColspan(7,6) &_
			"""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strCategoryFontColor & """><b>Statistics</b></font></td>" & vbNewline & _
			"              </tr>" & vbNewline & _
			"              <tr>" & vbNewline & _
			"                <td rowspan=""" 
	if ShowLastHere then
		Response.Write	"5"
	else
		Response.Write	"4"
	end if
	Response.Write	""" bgcolor=""" & strForumCellColor & """>&nbsp;</td>" & vbNewline
	if ShowLastHere then 
		Response.Write	"                <td bgcolor=""" & strForumCellColor & """ colspan=""" & sGetColspan(6,5) &_
				""">" & _
		       		"<font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>You last visited on " & ChkDate(Session(strCookieURL & "last_here_date"), " " ,true) & "</font></td>" & vbNewline & _
		       		"              </tr>" & vbNewline & _
		  		"              <tr>" & vbNewLine
	end if
	if intPostCount > 0 then
		Response.Write	"                <td bgcolor=""" & strForumCellColor & """ colspan=""" & sGetColspan(6,5) &_
				""">" & _
				"<font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>"
		if Member_Count = 1 and User_Count = 1 then
			Response.Write	"1 Member has "
		else
			Response.Write	Member_Count & " of " & User_Count & " <span class=""spnMessageText""><a href=""members.asp"">Members</a></span> have "
		end if
		Response.Write	" made "
		if intPostCount = 1 then
			Response.Write	"1 post "
		else
			Response.Write	intPostCount & " posts"
		end if
		Response.Write	" in "
		if intForumCount = 1 then
			Response.Write	"1 forum"
		else
			Response.Write	intForumCount & " forums"
		end if
		if (LastPostDate = "" or LastPostLink = "" or intPostCount = 0) then 
			Response.Write	"." 
		else
			Response.Write	", with the last post on <span class=""spnMessageText"">" & LastPostLink & LastPostDate & "</a></span>"
			if  LastPostAuthorLink <> "" then
				Response.Write	LastPostAuthorLink & "."
			else
				Response.Write	"."
			end if
		end if
		Response.Write	"</font></td>" & vbNewline & _
			    	"              </tr>" & vbNewline & _
				"              <tr>" & vbNewline
	end if
	Response.Write	"                <td bgcolor=""" & strForumCellColor & """ colspan=""" & sGetColspan(6,5) &_
			""">" & _
			"<font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>There "
	if intTopicCount = 1 then
		Response.Write	"is "
	else
		Response.Write	"are "
	end if
	Response.Write	" currently "
	if intTopicCount > 0 then
		Response.Write	intTopicCount
	else
		Response.Write	"no"
	end if
	if intTopicCount = 1 then
		Response.Write	" topic"
	else
		Response.Write	" topics"
	end if
	if ActiveTopicCount > 0 then
		Response.Write	" and " & ActiveTopicCount & " <span class=""spnMessageText""><a href=""active.asp"">active "
		if ActiveTopicCount = 1 then
			Response.Write	"topic"
		else
			Response.Write	"topics"
		end if
		Response.Write	"</a></span> since you last visited."
	elseif blnHiddenForums and (strLastPostDate > Session(strCookieURL & "last_here_date")) and ShowLastHere then
		Response.Write	" and there are <span class=""spnMessageText""><a href=""active.asp"">active topics</a></span> since you last visited."
	elseif not(ShowLastHere) then
		Response.Write	"."
	else
		Response.Write	" and no active topics since you last visited."
	end if
	Response.Write	"</font></td>" & vbNewline & _
			"              </tr>" & vbNewline

	if ArchivedPostCount > 0 and strArchiveState = "1" then 
		Response.Write	"              <tr>" & vbNewline & _
				"                <td bgcolor=""" & strForumCellColor & """ colspan=""" & sGetColspan(6,5) &_
				"""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>" & _
				"There "
		if ArchivedPostCount = 1 then
			Response.Write	"is "
		else
			Response.Write	"are "
		end if
		Response.Write	ArchivedPostCount & " "
		if ArchivedPostCount = 1 then
			Response.Write	" archived post "
		else
			Response.Write	" archived posts"
		end if
		if ArchivedTopicCount > 0 then
			Response.Write	" in " & ArchivedTopicCount 
			if ArchivedTopicCount = 1 then
				Response.Write	" archived topic"
			else
				Response.Write	" archived topics"
			end if
		end if
		Response.Write	"</font></td>" & vbNewline & _
				"              </tr>" & vbNewline
	end if 
	if NewMember_Name <> "" then 
		Response.Write	"              <tr>" & vbNewline & _
				"                <td bgcolor=""" & strForumCellColor & """ colspan=""" & sGetColspan(6,5) &_
				""">" & _
				"<font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>Please welcome our newest member: " & _
				"<span class=""spnMessageText"">" & profileLink(NewMember_Name,NewMember_Id) & "</span>.</font></td>" & vbNewline & _
				"              </tr>" & vbNewline
	end if 
end sub 

Sub DoHideCategory(intCatId)
       	HideForumCat = strUniqueID & "HideCat" & intCatId
     	if Request.QueryString(HideForumCat) = "Y" then
     		Response.Cookies(HideForumCat) = "Y"
       		Response.Cookies(HideForumCat).Expires = dateAdd("d", 30, strForumTimeAdjust)
       	else
       		if Request.QueryString(HideForumCat) = "N" then
       			Response.Cookies(HideForumCat) = "N"
       			Response.Cookies(HideForumCat).Expires = dateadd("d", -2, strForumTimeAdjust)
       		end if
       	end if
end sub

Function DoLastPostLink(showicon)
	if ForumLastPostReplyID <> 0 then
		PageLink = "whichpage=-1&"
		AnchorLink = "&REPLY_ID="
		DoLastPostLink = "<a href=""topic.asp?" & PageLink & "TOPIC_ID=" & ForumLastPostTopicID & AnchorLink & ForumLastPostReplyID & """>"
		if (showicon = true) then DoLastPostLink = DoLastPostLink & getCurrentIcon(strIconLastpost,"Jump to Last Post","align=""absmiddle""") & "</a>"
	elseif ForumLastPostTopicID <> 0 then
		DoLastPostLink = "<a href=""topic.asp?TOPIC_ID=" & ForumLastPostTopicID & """>"
		if (showicon = true) then DoLastPostLink = DoLastPostLink & getCurrentIcon(strIconLastpost,"Jump to Last Post","align=""absmiddle""") & "</a>"
	else
		DoLastPostLink = ""
	end if
end function

function listForumModerators(fForum_ID)
	fForumMods = split(strForumMods,"|")
	for iModerator = 0 to ubound(fForumMods)
		fForumMod = split(fForumMods(iModerator),",")
		ModForumID = fForumMod(0)
		ModMemID = fForumMod(1)
		ModMemName = fForumMod(2)
		if cLng(ModForumID) = cLng(fForum_ID) then
			if fMods = "" then
				fMods = "<nobr>" & profileLink(chkString(ModMemName,"display"),ModMemID) & "</nobr>"
			else
				fMods = fMods & ", <nobr>" & profileLink(chkString(ModMemName,"display"),ModMemID) & "</nobr>"
			end if
		end if
	next
	if fMods = "" then fMods = "&nbsp;"
	listForumModerators = fMods
end function
%>
