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
<%
if strDBNTUserName = "" then
	Err_Msg = "<li>You must be logged in to view the Members List</li>"

	Response.Write	"      <table width=""100%"" border=""0"">" & vbNewLine & _
			"        <tr>" & vbNewLine & _
			"          <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
			"          " & getCurrentIcon(strIconFolderOpen,"","") & "&nbsp;<a href=""default.asp"">All Forums</a><br />" & vbNewLine & _
			"          " & getCurrentIcon(strIconBar,"","") & getCurrentIcon(strIconFolderOpenTopic,"","") & "&nbsp;Member Information</font></td>" & vbNewLine & _
			"        </tr>" & vbNewLine & _
			"      </table>" & vbNewLine & _
			"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strHeaderFontSize & """ color=""" & strHiLiteFontColor & """>There Was A Problem!</font></p>" & vbNewLine & _
			"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHiLiteFontColor & """>You must be logged in to view this page</font></p>" & vbNewLine & _
			"      <p align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><a href=""JavaScript:history.go(-1)"">Back to Forum</a></font></p>" & vbNewLine & _
			"      <br />" & vbNewLine
	WriteFooter
	Response.End
end if

Response.Write	"      <script language=""JavaScript"" type=""text/javascript"">" & vbNewLine & _
		"      function ChangePage(fnum){" & vbNewLine & _
		"		if (fnum == 1) {" & vbNewLine & _
		"			document.PageNum1.submit();" & vbNewLine & _
		"		}" & vbNewLine & _
		"		else {" & vbNewLine & _
		"			document.PageNum2.submit();" & vbNewLine & _
		"		}" & vbNewLine & _
		"      }" & vbNewLine & _
		"      </script>" & vbNewLine

if trim(chkString(Request("method"),"SQLString")) <> "" then
	SortMethod = trim(chkString(Request("method"),"SQLString"))
	strSortMethod = "&method=" & SortMethod
	strSortMethod2 = "?method=" & SortMethod
end if

if trim(chkString(Request("mode"),"SQLString")) <> "" then
	strMode = trim(chkString(Request("mode"),"SQLString"))
	if strMode <> "search" then strMode = ""
end if

SearchName = trim(chkString(Request("M_NAME"),"SQLString"))
if SearchName = "" then
	SearchName = trim(chkString(Request.Form("M_NAME"),"SQLString"))
end if

if Request("UserName") <> "" then
	if IsNumeric(Request("UserName")) = True then srchUName = cLng(Request("UserName")) else srchUName = "1"
end if
if Request("FirstName") <> "" then
	if IsNumeric(Request("FirstName")) = True then srchFName = cLng(Request("FirstName")) else srchFName = "0"
end if
if Request("LastName") <> "" then
	if IsNumeric(Request("LastName")) = True then srchLName = cLng(Request("LastName")) else srchLName = "0"
end if
if Request("INITIAL") <> "" then
	if IsNumeric(Request("INITIAL")) = True then srchInitial = cLng(Request("INITIAL")) else srchInitial = "0"
end if

mypage = trim(chkString(request("whichpage"),"SQLString"))
if ((mypage = "") or (IsNumeric(mypage) = FALSE)) then mypage = 1
mypage = cLng(mypage)

'New Search Code
If strMode = "search"  and (srchUName = "1" or srchFName = "1" or srchLName = "1" or srchInitial = "1" ) then 
	strSql = "SELECT MEMBER_ID, M_STATUS, M_NAME, M_LEVEL, M_EMAIL, M_COUNTRY, M_HOMEPAGE, "
	strSql = strSql & "M_AIM, M_ICQ, M_MSN, M_YAHOO, M_TITLE, M_POSTS, M_LASTPOSTDATE, M_LASTHEREDATE, M_DATE "
	strSql2 = " FROM " & strMemberTablePrefix & "MEMBERS " 
'	if Request.querystring("link") <> "sort" then
		whereSql = " WHERE ("
		tmpSql = ""
		if srchUName = "1" then
			tmpSql = tmpSql & "M_NAME LIKE '%" & SearchName & "%' OR "
			tmpSql = tmpSql & "M_USERNAME LIKE '%" & SearchName & "%'"
		end if
		if srchFName = "1" then
			if srchUName = "1" then
					tmpSql = tmpSql & " OR "
			end if
			tmpSql = tmpSql & "M_FIRSTNAME LIKE '%" & SearchName & "%'"
		end if
		if srchLName = "1" then
			if srchFName = "1" or srchUName = "1" then 
				tmpSql = tmpSql & " OR "
			end if
			tmpSql = tmpSql & "M_LASTNAME LIKE '%" & SearchName & "%' "
		end if
		if srchInitial = "1" then 
			tmpSQL = "M_NAME LIKE '" & SearchName & "%'"
		end if

		whereSql = whereSql & tmpSql &")"
		Session(strCookieURL & "where_Sql") = whereSql
'	end if	

	if Session(strCookieURL & "where_Sql") <> "" then
		whereSql = Session(strCookieURL & "where_Sql")
	else
		whereSql = ""
	end if
	strSQL3 = whereSql
else
	'## Forum_SQL - Get all members
	strSql = "SELECT MEMBER_ID, M_STATUS, M_NAME, M_LEVEL, M_EMAIL, M_COUNTRY, M_HOMEPAGE, "
	strSql = strSql & "M_AIM, M_ICQ, M_MSN, M_YAHOO, M_TITLE, M_POSTS, M_LASTPOSTDATE, M_LASTHEREDATE, M_DATE "
	strSql2 = " FROM " & strMemberTablePrefix & "MEMBERS "
	if mlev = 4 then
		strSql3 = " WHERE M_NAME <> 'n/a' "
	else
		strSql3 = " WHERE M_STATUS = " & 1
	end if
end if
select case SortMethod
	case "nameasc"
		strSql4 = " ORDER BY M_NAME ASC"
	case "namedesc"
		strSql4 = " ORDER BY M_NAME DESC"
	case "levelasc"
		strSql4 = " ORDER BY M_TITLE ASC, M_NAME ASC"
	case "leveldesc"
		strSql4 = " ORDER BY M_TITLE DESC, M_NAME ASC"
	case "lastpostdateasc"
		strSql4 = " ORDER BY M_LASTPOSTDATE ASC, M_NAME ASC"
	case "lastpostdatedesc"
		strSql4 = " ORDER BY M_LASTPOSTDATE DESC, M_NAME ASC"
	case "lastheredateasc"
		strSql4 = " ORDER BY M_LASTHEREDATE ASC, M_NAME ASC"
	case "lastheredatedesc"
		strSql4 = " ORDER BY M_LASTHEREDATE DESC, M_NAME ASC"
	case "dateasc"
		strSql4 = " ORDER BY M_DATE ASC, M_NAME ASC"
	case "datedesc"
		strSql4 = " ORDER BY M_DATE DESC, M_NAME ASC"
	case "countryasc"
		strSql4 = " ORDER BY M_COUNTRY ASC, M_NAME ASC"
	case "countrydesc"
		strSql4 = " ORDER BY M_COUNTRY DESC, M_NAME ASC"
	case "postsasc"
		strSql4 = " ORDER BY M_POSTS ASC, M_NAME ASC"
	case else
		strSql4 = " ORDER BY M_POSTS DESC, M_NAME ASC"
end select

if strDBType = "mysql" then 'MySql specific code
	if mypage > 1 then 
		OffSet = cLng((mypage - 1) * strPageSize)
		strSql5 = " LIMIT " & OffSet & ", " & strPageSize & " "
	end if

	'## Forum_SQL - Get the total pagecount 
	strSql1 = "SELECT COUNT(MEMBER_ID) AS PAGECOUNT "

	set rsCount = my_Conn.Execute(strSql1 & strSql2 & strSql3)
	iPageTotal = rsCount(0).value
	rsCount.close
	set rsCount = nothing

	if iPageTotal > 0 then
		maxpages = (iPageTotal \ strPageSize )
		if iPageTotal mod strPageSize <> 0 then
			maxpages = maxpages + 1
		end if
		if iPageTotal < (strPageSize + 1) then
			intGetRows = iPageTotal
		elseif (mypage * strPageSize) > iPageTotal then
			intGetRows = strPageSize - ((mypage * strPageSize) - iPageTotal)
		else
			intGetRows = strPageSize
		end if
	else
		iPageTotal = 0
		maxpages = 0
	end if 

	if iPageTotal > 0 then
		set rs = Server.CreateObject("ADODB.Recordset")
		rs.open strSql & strSql2 & strSql3 & strSql4 & strSql5, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText
			arrMemberData = rs.GetRows(intGetRows)
			iMemberCount = UBound(arrMemberData, 2)
		rs.close
		set rs = nothing
	else
		iMemberCount = ""
	end if

else 'end MySql specific code

	set rs = Server.CreateObject("ADODB.Recordset")
	rs.cachesize = strPageSize
	rs.open strSql & strSql2 & strSql3 & strSql4, my_Conn, adOpenStatic
		If not (rs.EOF or rs.BOF) then
			rs.movefirst
			rs.pagesize = strPageSize
			rs.absolutepage = mypage '**
			maxpages = cLng(rs.pagecount)
			arrMemberData = rs.GetRows(strPageSize)
			iMemberCount = UBound(arrMemberData, 2)
		else
			iMemberCount = ""
		end if
	rs.Close
	set rs = nothing
end if
 
Response.Write	"      <table width=""100%"" border=""0"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
		"          " & getCurrentIcon(strIconFolderOpen,"","") & "&nbsp;<a href=""default.asp"">All Forums</a><br />" & vbNewLine & _
		"          " & getCurrentIcon(strIconBar,"","") & getCurrentIcon(strIconFolderOpenTopic,"","") & "&nbsp;Member Information</font></td>" & vbNewLine & _
		"          <td align=""right"" valign=""bottom"">" & vbNewLine
if maxpages > 1 then
	Response.Write	"            <table border=""0"" align=""right"">" & vbNewLine & _
			"              <tr>" & vbNewLine
	Call Paging2(1)
	Response.Write	"              </tr>" & vbNewLine & _
			"            </table>" & vbNewLine
else
	Response.Write	"          &nbsp;" & vbNewLine
end if
Response.Write	"          </td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine

Response.Write	"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbNewline & _
		"        <tr>" & vbNewline & _
		"          <td bgcolor=""" & strPopUpBorderColor & """>" & vbNewline & _
		"            <table border=""0"" width=""100%"" cellspacing=""1"" cellpadding=""4"">" & vbNewline & _
		"              <tr>" & vbNewline & _
		"              <form action=""members.asp" & strSortMethod2 & """ method=""post"" name=""SearchMembers"">" & vbNewline & _
		"                <td bgcolor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>Search:</b>&nbsp;" & vbNewline & _
		"                <input type=""checkbox"" name=""UserName"" value=""1"""
if ((srchUName <> "")  or (srchUName = "" and srchFName = "" and srchLName = "") ) then Response.Write(" checked")
Response.Write	">User Names" & vbNewline
if strFullName = "1" then
	Response.Write	"                &nbsp;&nbsp;<input type=""checkbox"" name=""FirstName"" value=""1""" & chkCheckbox(srchFName,1,true) & ">First Name" & vbNewline & _
			"                &nbsp;&nbsp;<input type=""checkbox"" name=""LastName"" value=""1""" & chkCheckbox(srchLName,1,true) & ">Last Name" & vbNewline
end if
Response.Write	"                </font></td>" & vbNewline & _
		"                <td bgcolor=""" & strPopUpTableColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """><b>For:</b>&nbsp;" & vbNewline & _
		"                <input type=""text"" name=""M_NAME"" value=""" & SearchName & """></font></td>" & vbNewline & _
		"                <input type=""hidden"" name=""mode"" value=""search"">" & vbNewline & _
		"                <input type=""hidden"" name=""initial"" value=""0"">" & vbNewline & _
		"                <td bgcolor=""" & strPopUpTableColor & """ align=""center"">" & vbNewline
if strGfxButtons = "1" then
	'Response.Write	"                <input type=""submit"" value=""search"" style=""color:" & strPopUpBorderColor & ";border: 1px solid " & strPopUpBorderColor & "; background-color: " & strPopUpTableColor & "; cursor: hand;"" id=""submit1"" name=""submit1"">" & vbNewline
	Response.Write	"                <input src=""" & strImageUrl & "button_go.gif"" alt=""Quick Search"" type=""image"" value=""search"" id=""submit1"" name=""submit1"">" & vbNewline
else
	Response.Write	"                <input type=""submit"" value=""search"" id=""submit1"" name=""submit1"">" & vbNewline
end if
Response.Write	"                </td>" & vbNewline & _
		"              </form>" & vbNewline & _
		"              </tr>" & vbNewline & _
		"              <tr bgcolor=""" & strPopUpTableColor & """>" & vbNewLine & _
		"                <td colspan=""3"" align=""center"" valign=""top""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine & _
		"                <a href=""members.asp""" & dWStatus("Display ALL Member Names") & ">All</a>&nbsp;" & vbNewLine
for intChar = 65 to 90
	if intChar <> 90 then
		Response.Write	"                <a href=""members.asp?mode=search&M_NAME=" & chr(intChar) & "&initial=1" & strSortMethod & """" & dWStatus("Display Member Names starting with the letter '" & chr(intChar) & "'") & ">" & chr(intChar) & "</a>&nbsp;" & vbNewLine
	else
		Response.Write	"                <a href=""members.asp?mode=search&M_NAME=" & chr(intChar) & "&initial=1" & strSortMethod & """" & dWStatus("Display Member Names starting with the letter '" & chr(intChar) & "'") & ">" & chr(intChar) & "</a><br /></font></td>" & vbNewLine
	end if
next
Response.Write	"              </tr>" & vbNewLine & _
		"            </table>" & vbNewLine & _
		"          </td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine & _
		"      <br />" & vbNewLine & _
		"      <table border=""0"" width=""100%"" cellspacing=""0"" cellpadding=""0"" align=""center"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td bgcolor=""" & strTableBorderColor & """>" & vbNewLine & _
		"            <table border=""0"" width=""100%"" cellspacing=""1"" cellpadding=""3"">" & vbNewLine & _
		"              <tr>" & vbNewLine
strNames = "UserName=" & srchUName  &_
	   "&FirstName=" & srchFName &_
	   "&LastName=" & srchLName &_
	   "&INITIAL=" &srchInitial & "&"

Response.Write	"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>&nbsp;&nbsp;</font></b></td>" & vbNewLine & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?" & strNames & "link=sort&mode=search&M_NAME=" & SearchName & "&method="
if Request.QueryString("method") = "nameasc" then Response.Write("namedesc") else Response.Write("nameasc")
Response.Write	"""" & dWStatus("Sort by Member Name") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Member Name</font></b></a></td>" & vbNewLine & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?" & strNames & "link=sort&mode=search&M_NAME=" & SearchName & "&method="
if Request.QueryString("method") = "levelasc" then Response.Write("leveldesc") else Response.Write("levelasc")
Response.Write	"""" & dWStatus("Sort by Member Level") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Title</font></b></a></td>" & vbNewLine & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?" & strNames & "link=sort&mode=search&M_NAME=" & SearchName & "&method="
if Request.QueryString("method") = "postsdesc" then Response.Write("postsasc") else Response.Write("postsdesc")
Response.Write	"""" & dWStatus("Sort by Post Count") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Posts</font></b></a></td>" & vbNewLine & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?" & strNames & "link=sort&mode=search&M_NAME=" & SearchName & "&method="
if Request.QueryString("method") = "lastpostdatedesc" then Response.Write("lastpostdateasc") else Response.Write("lastpostdatedesc")
Response.Write	"""" & dWStatus("Sort by Last Post Date") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Last Post</font></b></a></td>" & vbNewLine & _
		"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?" & strNames & "link=sort&mode=search&M_NAME=" & SearchName & "&method="
if Request.QueryString("method") = "datedesc" then Response.Write("dateasc") else Response.Write("datedesc")
Response.Write	"""" & dWStatus("Sort by Date of Registration") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Member Since</font></b></a></td>" & vbNewLine
if strCountry = "1" then
	Response.Write	"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?" & strNames & "link=sort&mode=search&M_NAME=" & SearchName & "&method="
	if Request.QueryString("method") = "countryasc" then Response.Write("countrydesc") else Response.Write("countryasc")
	Response.Write	"""" & dWStatus("Sort by Country") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Country</font></b></a></td>" & vbNewLine
end if
if mlev = 4 or mlev = 3 then
	Response.Write	"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><a href=""members.asp?method="
	if Request.QueryString("method") = "lastheredatedesc" then Response.Write("lastheredateasc") else Response.Write("lastheredatedesc")
	Response.Write	"""" & dWStatus("Sort by Last Visit Date") & "><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>Last Visit</font></b></a></td>" & vbNewLine
end if
if mlev = 4 or (lcase(strNoCookies) = "1") then
	Response.Write	"                <td align=""center"" bgcolor=""" & strHeadCellColor & """><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strHeadFontColor & """>&nbsp;</font></b></td>" & vbNewLine
end if
Response.Write	"              </tr>" & vbNewLine
if iMemberCount = "" then '## No Members Found in DB
	Response.Write	"              <tr>" & vbNewLine & _
			"                <td colspan=""" & sGetColspan(9, 8) & """ bgcolor=""" & strForumCellColor & """ ><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """><b>No Members Found</b></font></td>" & vbNewLine & _
			"              </tr>" & vbNewLine
else
	mMEMBER_ID = 0
	mM_STATUS = 1
	mM_NAME = 2
	mM_LEVEL = 3
	mM_EMAIL = 4
	mM_COUNTRY = 5
	mM_HOMEPAGE = 6
	mM_AIM = 7
	mM_ICQ = 8
	mM_MSN = 9
	mM_YAHOO = 10
	mM_TITLE = 11
	mM_POSTS = 12
	mM_LASTPOSTDATE = 13
	mM_LASTHEREDATE = 14
	mM_DATE = 15

	rec = 1
	intI = 0
	for iMember = 0 to iMemberCount
		if (rec = strPageSize + 1) then exit for

		Members_MemberID = arrMemberData(mMEMBER_ID, iMember)
		Members_MemberStatus = arrMemberData(mM_STATUS, iMember)
		Members_MemberName = arrMemberData(mM_NAME, iMember)
		Members_MemberLevel = arrMemberData(mM_LEVEL, iMember)
		Members_MemberEMail = arrMemberData(mM_EMAIL, iMember)
		Members_MemberCountry = arrMemberData(mM_COUNTRY, iMember)
		Members_MemberHomepage = arrMemberData(mM_HOMEPAGE, iMember)
		Members_MemberAIM = arrMemberData(mM_AIM, iMember)
		Members_MemberICQ = arrMemberData(mM_ICQ, iMember)
		Members_MemberMSN = arrMemberData(mM_MSN, iMember)
		Members_MemberYAHOO = arrMemberData(mM_YAHOO, iMember)
		Members_MemberTitle = arrMemberData(mM_TITLE, iMember)
		Members_MemberPosts = arrMemberData(mM_POSTS, iMember)
		Members_MemberLastPostDate = arrMemberData(mM_LASTPOSTDATE, iMember)
		Members_MemberLastHereDate = arrMemberData(mM_LASTHEREDATE, iMember)
		Members_MemberDate = arrMemberData(mM_DATE, iMember)

		if intI = 1 then 
			CColor = strAltForumCellColor
		else
			CColor = strForumCellColor
		end if

		Response.Write	"              <tr>" & vbNewLine & _
				"                <td bgcolor=""" & CColor & """ align=""center"">" & vbNewLine
		if strUseExtendedProfile then
			Response.Write	"                <a href=""pop_profile.asp?mode=display&id=" & Members_MemberID & """" & dWStatus("View " & ChkString(Members_MemberName,"display") & "'s Profile") & ">"
		else
			Response.Write	"                <a href=""JavaScript:openWindow3('pop_profile.asp?mode=display&id=" & Members_MemberID & "')""" & dWStatus("View " & ChkString(Members_MemberName,"display") & "'s Profile") & ">"
		end if
		if Members_MemberStatus = 0 then
			Response.Write	getCurrentIcon(strIconProfileLocked,"View " & ChkString(Members_MemberName,"display") & "'s Profile","align=""absmiddle"" hspace=""0""")
		else 
			Response.Write	getCurrentIcon(strIconProfile,"View " & ChkString(Members_MemberName,"display") & "'s Profile","align=""absmiddle"" hspace=""0""")
		end if 
		Response.Write	"</a>" & vbNewLine
		if strAIM = "1" and Trim(Members_MemberAIM) <> "" then
			Response.Write	"                <a href=""JavaScript:openWindow('pop_messengers.asp?mode=AIM&ID=" & Members_MemberID & "')""" & dWStatus("Send " & ChkString(Members_MemberName,"display") & " an AOL message") & ">" & getCurrentIcon(strIconAIM,"Send " & ChkString(Members_MemberName,"display") & " an AOL message","align=""absmiddle"" hspace=""0""") & "</a>" & vbNewLine
		end if
		if strICQ = "1" and Trim(Members_MemberICQ) <> "" then
			Response.Write	"                <a href=""JavaScript:openWindow('pop_messengers.asp?mode=ICQ&ID=" & Members_MemberID & "')""" & dWStatus("Send " & ChkString(Members_MemberName,"display") & " an ICQ Message") & ">" & getCurrentIcon(strIconICQ,"Send " & ChkString(Members_MemberName,"display") & " an ICQ Message","align=""absmiddle"" hspace=""0""") & "</a>" & vbNewLine
		end if
		if strMSN = "1" and Trim(Members_MemberMSN) <> "" then
			Response.Write	"                <a href=""JavaScript:openWindow('pop_messengers.asp?mode=MSN&ID=" & Members_MemberID & "')""" & dWStatus("Click to see " & ChkString(Members_MemberName,"display") & "'s MSN Messenger address") & ">" & getCurrentIcon(strIconMSNM,"Click to see " & ChkString(Members_MemberName,"display") & "'s MSN Messenger address","align=""absmiddle"" hspace=""0""") & "</a>" & vbNewLine
		end if
		if strYAHOO = "1" and Trim(Members_MemberYAHOO) <> "" then
			Response.Write	"                <a href=""http://edit.yahoo.com/config/send_webmesg?.target=" & ChkString(Members_MemberYAHOO, "urlpath") & "&.src=pg"" target=""_blank""" & dWStatus("Send " & ChkString(Members_MemberName,"display") & " a Yahoo! Message") & ">" & getCurrentIcon(strIconYahoo,"Send " & ChkString(Members_MemberName,"display") & " a Yahoo! Message","align=""absmiddle"" hspace=""0""") & "</a>" & vbNewLine
		end if
		Response.Write	"                </td>" & vbNewLine & _
				"                <td bgcolor=""" & CColor & """><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
		if strUseExtendedProfile then
			Response.Write	"                <span class=""spnMessageText""><a href=""pop_profile.asp?mode=display&id=" & Members_MemberID & """ title=""View " & ChkString(Members_MemberName,"display") & "'s Profile""" & dWStatus("View " & ChkString(Members_MemberName,"display") & "'s Profile") & ">"
		else
			Response.Write	"                <span class=""spnMessageText""><a href=""JavaScript:openWindow3('pop_profile.asp?mode=display&id=" & Members_MemberID & "')"" title=""View " & ChkString(Members_MemberName,"display") & "'s Profile""" & dWStatus("View " & ChkString(Members_MemberName,"display") & "'s Profile") & ">"
		end if
		Response.Write	ChkString(Members_MemberName,"display") & "</a></span></font></td>" & vbNewLine & _
				"                <td bgcolor=""" & CColor & """ align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & ChkString(getMember_Level(Members_MemberTitle, Members_MemberLevel, Members_MemberPosts),"display") & "</font></td>" & vbNewLine & _
				"                <td bgcolor=""" & CColor & """ align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>"
		if IsNull(Members_MemberPosts) then
			Response.Write("-")
		else
			Response.Write(Members_MemberPosts)
			if strShowRank = 2 or strShowRank = 3 then 
				Response.Write("<br />" & getStar_Level(Members_MemberLevel, Members_MemberPosts) & "")
			end if
		end if
		Response.Write	"</font></td>" & vbNewLine
		if IsNull(Members_MemberLastPostDate) or Trim(Members_MemberLastPostDate) = "" then
			Response.Write	"                <td bgcolor=""" & CColor & """ align=""center"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>-</font></td>" & vbNewLine
		else
			Response.Write	"                <td bgcolor=""" & CColor & """ align=""center"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & ChkDate(Members_MemberLastPostDate,"",false) & "</font></td>" & vbNewLine
		end if
		Response.Write	"                <td bgcolor=""" & CColor & """ align=""center"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & ChkDate(Members_MemberDate,"",false) & "</font></td>" & vbNewLine
		if strCountry = "1" then
			Response.Write	"                <td bgcolor=""" & CColor & """ align=""center""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>"
			if trim(Members_MemberCountry) <> "" then Response.Write(Members_MemberCountry & "&nbsp;") else Response.Write("-")
			Response.Write	"</font></td>" & vbNewLine
		end if
		if mlev = 4 or mlev = 3 then
			Response.Write	"                <td bgcolor=""" & CColor & """ align=""center"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """ color=""" & strForumFontColor & """>" & ChkDate(Members_MemberLastHereDate,"",false) & "</font></td>" & vbNewLine
		end if
		if mlev = 4 or (lcase(strNoCookies) = "1") then
			Response.Write	"                <td bgcolor=""" & CColor & """ align=""center""><b><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine
			if Members_MemberID = intAdminMemberID OR (Members_MemberLevel = 3 AND MemberID <> intAdminMemberID) then
				'## Do Nothing
			else
				if Members_MemberStatus <> 0 then
					Response.Write	"                <a href=""JavaScript:openWindow('pop_lock.asp?mode=Member&MEMBER_ID=" & Members_MemberID & "')""" & dWStatus("Lock Member") & ">" & getCurrentIcon(strIconLock,"Lock Member","hspace=""0""") & "</a>" & vbNewLine
				else
					Response.Write	"                <a href=""JavaScript:openWindow('pop_open.asp?mode=Member&MEMBER_ID=" & Members_MemberID & "')""" & dWStatus("Un-Lock Member") & ">" & getCurrentIcon(strIconUnlock,"Un-Lock Member","hspace=""0""") & "</a>" & vbNewLine
				end if
			end if
			if (Members_MemberID = intAdminMemberID and MemberID <> intAdminMemberID) OR (Members_MemberLevel = 3 AND MemberID <> intAdminMemberID AND MemberID <> Members_MemberID) then
				Response.Write	"                -" & vbNewLine
			else
				if strUseExtendedProfile then
					Response.Write	"                <a href=""pop_profile.asp?mode=Modify&ID=" & Members_MemberID & """" & dWStatus("Edit Member") & ">" & getCurrentIcon(strIconPencil,"Edit Member","hspace=""0""") & "</a>" & vbNewLine
				else
					Response.Write	"                <a href=""JavaScript:openWindow3('pop_profile.asp?mode=Modify&ID=" & Members_MemberID & "')""" & dWStatus("Edit Member") & ">" & getCurrentIcon(strIconPencil,"Edit Member","hspace=""0""") & "</a>" & vbNewLine
				end if
			end if
			if Members_MemberID = intAdminMemberID OR (Members_MemberLevel = 3 AND MemberID <> intAdminMemberID) then
				'## Do Nothing
			else
				Response.Write	"                <a href=""JavaScript:openWindow('pop_delete.asp?mode=Member&MEMBER_ID=" & Members_MemberID & "')""" & dWStatus("Delete Member") & ">" & getCurrentIcon(strIconTrashcan,"Delete Member","hspace=""0""") & "</a>" & vbNewLine
			end if
			Response.Write	"                </font></b></td>" & vbNewLine
		end if
		Response.Write	"              </tr>" & vbNewLine

		rec = rec + 1
		intI = intI + 1
		if intI = 2 then intI = 0
	next
end if 
Response.Write	"            </table>" & vbNewLine & _
		"          </td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td colspan=""2"">" & vbNewLine
if maxpages > 1 then
	Response.Write	"            <table border=""0"">" & vbNewLine & _
			"              <tr>" & vbNewLine
	Call Paging2(2)
	Response.Write	"              </tr>" & vbNewLine & _
			"            </table>" & vbNewLine
end if
Response.Write	"          </td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine & _
		"    <br />" & vbNewLine
WriteFooter
Response.End

sub Paging2(fnum)
	if maxpages > 1 then
		if mypage = "" then
			sPageNumber = 1
		else
			sPageNumber = mypage
		end if
		if SortMethod = "" then
			sMethod = "postsdesc"
		else
			sMethod = SortMethod
		end if

		Response.Write("              <form name=""PageNum" & fnum & """ action=""members.asp"">" & vbNewLine)
		if fnum = 1 then
			Response.Write("                <td align=""right"" valign=""bottom""><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine)
		else
			Response.Write("                <td><font face=""" & strDefaultFontFace & """ size=""" & strDefaultFontSize & """>" & vbNewLine)
		end if
		if srchInitial <> "" then Response.Write("                <input type=""hidden"" name=""initial"" value=""" & srchInitial & """>" & vbNewLine)
		if sMethod <> "" then Response.Write("                <input type=""hidden"" name=""method"" value=""" & sMethod & """>" & vbNewLine)
		if strMode <> "" then Response.Write("                <input type=""hidden"" name=""mode"" value=""" & strMode & """>" & vbNewLine)
		if searchName <> "" then Response.Write("                <input type=""hidden"" name=""M_NAME"" value=""" & searchName & """>" & vbNewLine)
		if srchUName <> "" then Response.write("                <input type=""hidden"" name=""UserName"" value=""" & srchUName & """>" & vbNewLine)
		if srchFName <> "" then Response.write("                <input type=""hidden"" name=""FirstName"" value=""" & srchFName & """>" & vbNewLine)
		if srchLName <> "" then Response.write("                <input type=""hidden"" name=""LastName"" value=""" & srchLName & """>" & vbNewLine)		
		if fnum = 1 then
			Response.Write("                <b>Page: </b><select name=""whichpage"" size=""1"" onchange=""ChangePage(" & fnum & ");"">" & vbNewLine)
        	else
			Response.Write("                <b>Members are " & maxpages & " Pages Long: </b><select name=""whichpage"" size=""1"" onchange=""ChangePage(" & fnum & ");"">" & vbNewLine)
		end if
		for counter = 1 to maxpages
			if counter <> cLng(sPageNumber) then
				Response.Write "                <option value=""" & counter &  """>" & counter & "</option>" & vbNewLine
			else
				Response.Write "                <option selected value=""" & counter &  """>" & counter & "</option>" & vbNewLine
			end if
		next
		if fnum = 1 then
			Response.Write("                </select><b> of " & maxPages & "</b>" & vbNewLine)
		else
			Response.Write("                </select>" & vbNewLine)
		end if
		Response.Write("                </font></td>" & vbNewLine)
		Response.Write("              </form>" & vbNewLine)
	end if
end sub 

Function sGetColspan(lIN, lOUT)
	if (mlev = "4" or mlev = "3") then lOut = lOut + 2
	If lOut > lIn then
		sGetColspan = lIN
	Else
		sGetColspan = lOUT
	End If
end Function
%>
