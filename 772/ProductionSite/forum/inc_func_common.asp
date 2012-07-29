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
<%

'##############################################
'##            Post Formatting               ##
'##############################################


function chkQuoteOk(fString)
	chkQuoteOk = not(InStr(1, fString, "'", 0) > 0)
end function


function ChkURLs(ByVal strToFormat, ByVal sPrefix, ByVal iType)
	Dim strArray
	Dim Counter

	ChkURLs = strToFormat

	if InStr(1, strToFormat, sPrefix) > 0 Then
		strArray = Split(strToFormat, sPrefix, -1)
		ChkURLs = strArray(0)

		for Counter = 1 To UBound(strArray)
			if ((strArray(Counter-1) = "" Or Len(strArray(Counter-1)) < 5) And strArray(Counter)<> "") then
				ChkURLs = ChkURLs & edit_hrefs(sPrefix & strArray(Counter), iType)
			elseif ((UCase(Right(strArray(Counter-1), 6)) <> "HREF=""") and _
				(UCase(Right(strArray(Counter-1), 5)) <> "[IMG]") and _
				(UCase(Right(strArray(Counter-1), 5)) <> "[URL]") and _
				(UCase(Right(strArray(Counter-1), 6)) <> "[URL=""") and _
				(UCase(Right(strArray(Counter-1), 6)) <> "FTP://") and _
				(UCase(Right(strArray(Counter-1), 8)) <> "FILE:///") and _
				(UCase(Right(strArray(Counter-1), 7)) <> "HTTP://") and _
				(UCase(Right(strArray(Counter-1), 8)) <> "HTTPS://") and _
				(UCase(Right(strArray(Counter-1), 5)) <> "SRC=""") and _
				(UCase(Right(strArray(Counter-1), 1)) <> "-") and _
				(UCase(Right(strArray(Counter-1), 1)) <> "=") and _
				(strArray(Counter) <> "")) then

				ChkURLs = ChkURLs & edit_hrefs(sPrefix & strArray(Counter), iType)
			else
				ChkURLs = ChkURLs & sPrefix & strArray(Counter)
			end if
		next
	end if
end function


function ChkMail(ByVal strToFormat)
	Dim strArray
	Dim Counter
	
	if InStr(1, strToFormat, " ") > 0 Then
	
		strArray = Split(Replace(strToFormat, "<br />", " <br />", 1, -1, vbTextCompare), " ", -1)
		'ChkMail = strArray(0)

		for Counter = 0 to UBound(strArray)
			If (InStr(strArray(Counter), "@") > 0) and _
			not(InStr(UCase(strArray(Counter)), "MAILTO:") > 0) and _
			not(InStr(UCase(strArray(Counter)), "FTP:") > 0) and _
			not(InStr(UCase(strArray(Counter)), "[URL") > 0) then
				ChkMail = ChkMail & " " & edit_hrefs(strArray(counter), 4)
			else
				ChkMail = ChkMail & " " & strArray(counter)
			end if
		next
		ChkMail = Replace(ChkMail, " <br />", "<br />", 1, -1, vbTextCompare)
	else
		if (InStr(strToFormat, "@") > 0) and _
		not(InStr(UCase(strToFormat), "MAILTO:") > 0) and _
		not(InStr(UCase(strToFormat), "FTP:") > 0) and _
		not(InStr(UCase(strToFormat), "[URL") > 0) then
			ChkMail = ChkMail & " " & edit_hrefs(strToFormat, 4)
		else
			ChkMail = strToFormat
		end if
	end if
end function


function FormatStr(fString)
	on Error resume next
	fString = Replace(fString, CHR(13), "")
	'fString = Replace(fString, CHR(10) & CHR(10), "<br /><br />")
	fString = Replace(fString, CHR(10), "<br />")
	if strBadWordFilter = 1 or strBadWordFilter = "1" then
		fString = ChkBadWords(fString)
	end if

	if strAllowForumCode = "1" then
		fString = ReplaceURLs(fString)
		fString = ReplaceCodeTags(fString)
		if strIMGInPosts = "1" then
			fString = ReplaceImageTags(fString)
		end if
	end if

	fString = ChkURLs(fString, "http://", 1)
	fString = ChkURLs(fString, "https://", 2)
	fString = ChkURLs(fString, "www.", 3)
	fString = ChkMail(fString)
	fString = ChkURLs(fString, "ftp://", 5)
	fString = ChkURLs(fString, "file:///", 6)

	if strIcons = "1" then
		fString = smile(fString)
	end if
	if strAllowForumCode = "1" then
		fString = extratags(fString)
	end if
	FormatStr = fString
	on Error goto 0
end function


function doCode(fString, fOTag, fCTag, fROTag, fRCTag)
	fOTagPos = Instr(1, fString, fOTag, 1)
	fCTagPos = Instr(1, fString, fCTag, 1)
	while (fCTagPos > 0 and fOTagPos > 0)
		fString = replace(fString, fOTag, fROTag, 1, 1, 1)
		fString = replace(fString, fCTag, fRCTag, 1, 1, 1)
		fOTagPos = Instr(1, fString, fOTag, 1)
		fCTagPos = Instr(1, fString, fCTag, 1)
	wend
	doCode = fString
end function


function Smile(fString)
	fString = replace(fString, "[:(!]", getCurrentIcon(strIconSmileAngry,"","align=""middle"""))
	fString = replace(fString, "[B)]", getCurrentIcon(strIconSmileBlackeye,"","align=""middle"""))
	fString = replace(fString, "[xx(]", getCurrentIcon(strIconSmileDead,"","align=""middle"""))
	fString = replace(fString, "[XX(]", getCurrentIcon(strIconSmileDead,"","align=""middle"""))
	fString = replace(fString, "[:I]", getCurrentIcon(strIconSmileBlush,"","align=""middle"""))
	fString = replace(fString, "[:(]", getCurrentIcon(strIconSmileSad,"","align=""middle"""))
	fString = replace(fString, "[:o]", getCurrentIcon(strIconSmileShock,"","align=""middle"""))
	fString = replace(fString, "[:O]", getCurrentIcon(strIconSmileShock,"","align=""middle"""))
	fString = replace(fString, "[:0]", getCurrentIcon(strIconSmileShock,"","align=""middle"""))
	fString = replace(fString, "[|)]", getCurrentIcon(strIconSmileSleepy,"","align=""middle"""))
	fString = replace(fString, "[:)]", getCurrentIcon(strIconSmile,"","align=""middle"""))
	fString = replace(fString, "[:D]", getCurrentIcon(strIconSmileBig,"","align=""middle"""))
	fString = replace(fString, "[}:)]", getCurrentIcon(strIconSmileEvil,"","align=""middle"""))
	fString = replace(fString, "[:o)]", getCurrentIcon(strIconSmileClown,"","align=""middle"""))
	fString = replace(fString, "[:O)]", getCurrentIcon(strIconSmileClown,"","align=""middle"""))
	fString = replace(fString, "[:0)]", getCurrentIcon(strIconSmileClown,"","align=""middle"""))
	fString = replace(fString, "[8)]", getCurrentIcon(strIconSmileShy,"","align=""middle"""))
	fString = replace(fString, "[8D]", getCurrentIcon(strIconSmileCool,"","align=""middle"""))
	fString = replace(fString, "[:P]", getCurrentIcon(strIconSmileTongue,"","align=""middle"""))
	fString = replace(fString, "[:p]", getCurrentIcon(strIconSmileTongue,"","align=""middle"""))
	fString = replace(fString, "[;)]", getCurrentIcon(strIconSmileWink,"","align=""middle"""))
	fString = replace(fString, "[8]", getCurrentIcon(strIconSmile8ball,"","align=""middle"""))
	fString = replace(fString, "[?]", getCurrentIcon(strIconSmileQuestion,"","align=""middle"""))
	fString = replace(fString, "[^]", getCurrentIcon(strIconSmileApprove,"","align=""middle"""))
	fString = replace(fString, "[V]", getCurrentIcon(strIconSmileDisapprove,"","align=""middle"""))
	fString = replace(fString, "[v]", getCurrentIcon(strIconSmileDisapprove,"","align=""middle"""))
	fString = replace(fString, "[:X]", getCurrentIcon(strIconSmileKisses,"","align=""middle"""))
	fString = replace(fString, "[:x]", getCurrentIcon(strIconSmileKisses,"","align=""middle"""))
	Smile = fString
end function


function extratags(fString)
	fString = doCode(fString, "[spoiler]", "[/spoiler]", "<font color=""" & CColor & """>", "</font id=""" & CColor & """>")
	extratags = fString
end function


function chkBadWords(fString)
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
	txtBadWordReplace = Application(strCookieURL & "STRBADWORDREPLACE")
	if fString = "" or IsNull(fString) then fString = " "
	bwords = split(txtBadWordWords, ",")
	breplace = split(txtBadWordReplace, ",")
	for i = 0 to ubound(bwords)
		fString = Replace(fString, bwords(i), breplace(i), 1, -1, 1) 
	next
	chkBadWords = fString
end function


function HTMLEncode(pString)
	fString = trim(pString)
	if fString = "" or IsNull(fString) then
		fString = " "
	else
		fString = replace(fString, ">", "&gt;")
		fString = replace(fString, "<", "&lt;")
	end if
	HTMLEncode = fString
end function


function HTMLDecode(pString)
	fString = trim(pString)
	if fString = "" then
		fString = " "
	else
		fString = replace(fString, "&gt;", ">")
		fString = replace(fString, "&lt;", "<")
	end if
	HTMLDecode = fString
end function


function chkString(pString,fField_Type) '## Types - name, password, title, message, url, urlpath, email, number, list


	fString = Trim(pString)

	if fString = "" or isNull(fString) then
		fString = " "
	else
'		chkBadWords(fString)
	end if
	Select Case lcase(fField_Type)
		Case "refer"
			fString = Replace(fString, "&#", "#")
			fString = Replace(fString, """", "&quot;")
			fString = HTMLEncode(fString)
			ChkString = fString
			exit function
		Case "archive"
			fString = Replace(fString, "'", "''")
			if strDBType = "mysql" then
				fString = Replace(fString, "\", "\\")
			end if
			chkString = fString
			exit function
		Case "displayimage"
			fString = Replace(fString, " ", "")
			fString = Replace(fString, """", "")
			fString = Replace(fString, "<", "")
			fString = Replace(fString, ">", "")
			chkString = fString
			exit function
		Case "pagetitle"
			if strBadWordFilter = "1" then
   				fString = chkBadWords(fString)
	        	end if
			fString = Replace(fString,"\","\\")
			fString = Replace(fString,"'","\'")
			fString = HTMLDecode(fString)
			chkString = fString
			exit function
		Case "title"
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
			if strBadWordFilter = "1" then
   				fString = chkBadWords(fString)
	        	end if
			chkString = fString
			exit function
		Case "password"
			fString = trim(fString)
			chkString = fString
		Case "decode"
			fString = HTMLDecode(fString)
			chkString = fString
			exit function
		Case "urlpath"
			fString = Server.URLEncode(fString)
			chkString = fString
			exit function
		Case "sqlstring"
			fString = Replace(fString, "'", "''")
			if strDBType = "mysql" then
				fString = Replace(fString, "\", "\\")
			end if
			fString = HTMLEncode(fString)
			chkString = fString
			exit function
		Case "jsurlpath"
			fString = Replace(fString, "'", "\'")
			fString = Server.URLEncode(fString)
			chkString = fString
			exit function
		Case "edit"
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
			fString = Replace(fString, """", "&quot;")
			ChkString = fString
			exit function
		Case "admindisplay"
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
			chkString = fString
			exit function
		Case "display"
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
	                if strBadWordFilter = "1" then
        	                fString = ChkBadWords(fString)
                	end if
			fString = replace(fString,"+","&#043;")
			fString = replace(fString, """", "&quot;")
			chkString = fString
			exit function
		Case "search"
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
	                if strBadWordFilter = "1" then
        	                fString = ChkBadWords(fString)
                	end if
			fString = Replace(fString, """", "&quot;")
			chkString = fString
			exit function
		Case "message"
	                if strBadWordFilter = "1" then
        	                fString = ChkBadWords(fString)
                	end if
			fString = Replace(fString,"&#","#")
			if strDBType = "mysql" then
				fString = Replace(fString, "\", "\\")
			end if
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
		Case "preview"
	                if strBadWordFilter = "1" then
        	                fString = ChkBadWords(fString)
                	end if
			if strAllowHTML <> "1" then
				fString = HTMLEncode(fString)
			end if
		Case "hidden"
			fString = HTMLEncode(fString)
	End Select
	if fField_Type <> "signature" and fField_Type <> "title" then
		fString = doCode(fString, "[quote]", "[/quote]", "<blockquote id=""quote""><font size=""" & strFooterFontSize & """ face=""" & strDefaultFontFace & """ id=""quote"">quote:<hr height=""1"" noshade id=""quote"">", "<hr height=""1"" noshade id=""quote""></font id=""quote""></blockquote id=""quote"">")
	end if
	if strAllowForumCode = "1" and fField_Type <> "signature" then
		fString = doCode(fString, "[b]", "[/b]", "<b>", "</b>")
		fString = doCode(fString, "[s]", "[/s]", "<s>", "</s>")
		fString = doCode(fString, "[strike]", "[/strike]", "<s>", "</s>")
		fString = doCode(fString, "[u]", "[/u]", "<u>", "</u>")
		fString = doCode(fString, "[i]", "[/i]", "<i>", "</i>")
		if fField_Type <> "title" then
			fString = doCode(fString, "[font=Andale Mono]", "[/font=Andale Mono]", "<font face=""Andale Mono"">", "</font id=""Andale Mono"">")
			fString = doCode(fString, "[font=Arial]", "[/font=Arial]", "<font face=""Arial"">", "</font id=""Arial"">")
			fString = doCode(fString, "[font=Arial Black]", "[/font=Arial Black]", "<font face=""Arial Black"">", "</font id=""Arial Black"">")
			fString = doCode(fString, "[font=Book Antiqua]", "[/font=Book Antiqua]", "<font face=""Book Antiqua"">", "</font id=""Book Antiqua"">")
			fString = doCode(fString, "[font=Century Gothic]", "[/font=Century Gothic]", "<font face=""Century Gothic"">", "</font id=""Century Gothic"">")
			fString = doCode(fString, "[font=Courier New]", "[/font=Courier New]", "<font face=""Courier New"">", "</font id=""Courier New"">")
			fString = doCode(fString, "[font=Comic Sans MS]", "[/font=Comic Sans MS]", "<font face=""Comic Sans MS"">", "</font id=""Comic Sans MS"">")
			fString = doCode(fString, "[font=Georgia]", "[/font=Georgia]", "<font face=""Georgia"">", "</font id=""Georgia"">")
			fString = doCode(fString, "[font=Impact]", "[/font=Impact]", "<font face=""Impact"">", "</font id=""Impact"">")
			fString = doCode(fString, "[font=Tahoma]", "[/font=Tahoma]", "<font face=""Tahoma"">", "</font id=""Tahoma"">")
			fString = doCode(fString, "[font=Times New Roman]", "[/font=Times New Roman]", "<font face=""Times New Roman"">", "</font id=""Times New Roman"">")
			fString = doCode(fString, "[font=Trebuchet MS]", "[/font=Trebuchet MS]", "<font face=""Trebuchet MS"">", "</font id=""Trebuchet MS"">")
			fString = doCode(fString, "[font=Script MT Bold]", "[/font=Script MT Bold]", "<font face=""Script MT Bold"">", "</font id=""Script MT Bold"">")
			fString = doCode(fString, "[font=Stencil]", "[/font=Stencil]", "<font face=""Stencil"">", "</font id=""Stencil"">")
			fString = doCode(fString, "[font=Verdana]", "[/font=Verdana]", "<font face=""Verdana"">", "</font id=""Verdana"">")
			fString = doCode(fString, "[font=Lucida Console]", "[/font=Lucida Console]", "<font face=""Lucida Console"">", "</font id=""Lucida Console"">")

			fString = doCode(fString, "[red]", "[/red]", "<font color=""red"">", "</font id=""red"">")
			fString = doCode(fString, "[green]", "[/green]", "<font color=""green"">", "</font id=""green"">")
			fString = doCode(fString, "[blue]", "[/blue]", "<font color=""blue"">", "</font id=""blue"">")
			fString = doCode(fString, "[white]", "[/white]", "<font color=""white"">", "</font id=""white"">")
			fString = doCode(fString, "[purple]", "[/purple]", "<font color=""purple"">", "</font id=""purple"">")
			fString = doCode(fString, "[yellow]", "[/yellow]", "<font color=""yellow"">", "</font id=""yellow"">")
			fString = doCode(fString, "[violet]", "[/violet]", "<font color=""violet"">", "</font id=""violet"">")
			fString = doCode(fString, "[brown]", "[/brown]", "<font color=""brown"">", "</font id=""brown"">")
			fString = doCode(fString, "[black]", "[/black]", "<font color=""black"">", "</font id=""black"">")
			fString = doCode(fString, "[pink]", "[/pink]", "<font color=""pink"">", "</font id=""pink"">")
			fString = doCode(fString, "[orange]", "[/orange]", "<font color=""orange"">", "</font id=""orange"">")
			fString = doCode(fString, "[gold]", "[/gold]", "<font color=""gold"">", "</font id=""gold"">")

			fString = doCode(fString, "[beige]", "[/beige]", "<font color=""beige"">", "</font id=""beige"">")
			fString = doCode(fString, "[teal]", "[/teal]", "<font color=""teal"">", "</font id=""teal"">")
			fString = doCode(fString, "[navy]", "[/navy]", "<font color=""navy"">", "</font id=""navy"">")
			fString = doCode(fString, "[maroon]", "[/maroon]", "<font color=""maroon"">", "</font id=""maroon"">")
			fString = doCode(fString, "[limegreen]", "[/limegreen]", "<font color=""limegreen"">", "</font id=""limegreen"">")

			fString = doCode(fString, "[h1]", "[/h1]", "<h1>", "</h1>")
			fString = doCode(fString, "[h2]", "[/h2]", "<h2>", "</h2>")
			fString = doCode(fString, "[h3]", "[/h3]", "<h3>", "</h3>")
			fString = doCode(fString, "[h4]", "[/h4]", "<h4>", "</h4>")
			fString = doCode(fString, "[h5]", "[/h5]", "<h5>", "</h5>")
			fString = doCode(fString, "[h6]", "[/h6]", "<h6>", "</h6>")
			fString = doCode(fString, "[size=1]", "[/size=1]", "<font size=""1"">", "</font id=""size1"">")
			fString = doCode(fString, "[size=2]", "[/size=2]", "<font size=""2"">", "</font id=""size2"">")
			fString = doCode(fString, "[size=3]", "[/size=3]", "<font size=""3"">", "</font id=""size3"">")
			fString = doCode(fString, "[size=4]", "[/size=4]", "<font size=""4"">", "</font id=""size4"">")
			fString = doCode(fString, "[size=5]", "[/size=5]", "<font size=""5"">", "</font id=""size5"">")
			fString = doCode(fString, "[size=6]", "[/size=6]", "<font size=""6"">", "</font id=""size6"">")
			fString = doCode(fString, "[list]", "[/list]", "<ul>", "</ul>")
			fString = doCode(fString, "[list=1]", "[/list=1]", "<ol type=""1"">", "</ol id=""1"">")
			fString = doCode(fString, "[list=a]", "[/list=a]", "<ol type=""a"">", "</ol id=""a"">")
			fString = doCode(fString, "[*]", "[/*]", "<li>", "</li>")
			fString = doCode(fString, "[left]", "[/left]", "<div align=""left"">", "</div id=""left"">")
			fString = doCode(fString, "[center]", "[/center]", "<center>", "</center>")
			fString = doCode(fString, "[centre]", "[/centre]", "<center>", "</center>")
			fString = doCode(fString, "[right]", "[/right]", "<div align=""right"">", "</div id=""right"">")
			'fString = doCode(fString, "[code]", "[/code]", "<pre id=""code""><font face=""courier"" size=""" & strDefaultFontSize & """ id=""code"">", "</font id=""code""></pre id=""code"">")
			fString = replace(fString, "[br]", "<br />", 1, -1, 1)
			fString = replace(fString, "[hr]", "<hr noshade size=""1"">", 1, -1, 1)
		end if
	end if
	if fField_Type <> "hidden" and _
	fField_Type <> "preview" then
		fString = Replace(fString, "'", "''")
	end if
	if fField_Type = "message" and strDBType = "mysql" then
		fString = Replace(fString, """", "\""")
	end if
	chkString = fString
end function

'##############################################
'##            Date Formatting               ##
'##############################################

function doublenum(fNum)
	if fNum > 9 then 
		doublenum = fNum 
	else 
		doublenum = "0" & fNum
	end if
end function


function chkDateFormat(strDateTime)
	chkDateFormat = isdate("" & Mid(strDateTime, 5,2) & "/" & Mid(strDateTime, 7,2) & "/" & Mid(strDateTime, 1,4) & " " & Mid(strDateTime, 9,2) & ":" & Mid(strDateTime, 11,2) & ":" & Mid(strDateTime, 13,2) & "")
end function


function StrToDate(strDateTime)
	if ChkDateFormat(strDateTime) then 
		'Testing for server format
		if strComp(Month("04/05/2002"),"4") = 0 then
			StrToDate = cdate("" & Mid(strDateTime, 5,2) & "/" & Mid(strDateTime, 7,2) & "/" & Mid(strDateTime, 1,4) & " " & Mid(strDateTime, 9,2) & ":" & Mid(strDateTime, 11,2) & ":" & Mid(strDateTime, 13,2) & "")
		else
			StrToDate = cdate("" & Mid(strDateTime, 7,2) & "/" & Mid(strDateTime, 5,2) & "/" & Mid(strDateTime, 1,4) & " " & Mid(strDateTime, 9,2) & ":" & Mid(strDateTime, 11,2) & ":" & Mid(strDateTime, 13,2) & "")
		end if
	else
		if strComp(Month("04/05/2002"),"4") = 0 then
			tmpDate = DatePart("m",strForumTimeAdjust) & "/" & DatePart("d",strForumTimeAdjust) & "/" & DatePart("yyyy",strForumTimeAdjust) & " " & DatePart("h",strForumTimeAdjust) & ":" & DatePart("n",strForumTimeAdjust) & ":" & DatePart("s",strForumTimeAdjust)
		else
			tmpDate = DatePart("d",strForumTimeAdjust) & "/" & DatePart("m",strForumTimeAdjust) & "/" & DatePart("yyyy",strForumTimeAdjust) & " " & DatePart("h",strForumTimeAdjust) & ":" & DatePart("n",strForumTimeAdjust) & ":" & DatePart("s",strForumTimeAdjust)
		end if
		StrToDate = tmpDate
	end if
end function


function oldStrToDate(strDateTime)
	if ChkDateFormat(strDateTime) then
		StrToDate = cdate("" & Mid(strDateTime, 5,2) & "/" & Mid(strDateTime, 7,2) & "/" & Mid(strDateTime, 1,4) & " " & Mid(strDateTime, 9,2) & ":" & Mid(strDateTime, 11,2) & ":" & Mid(strDateTime, 13,2) & "")
	else
		tmpDate = DatePart("m",strForumTimeAdjust) & "/" & DatePart("d",strForumTimeAdjust) & "/" & DatePart("yyyy",strForumTimeAdjust) & " " & DatePart("h",strForumTimeAdjust) & ":" & DatePart("n",strForumTimeAdjust) & ":" & DatePart("s",strForumTimeAdjust)
		StrToDate = "" & tmpDate
	end if
end function


function DateToStr(dtDateTime)
	if not isDate(dtDateTime) then
		dtDateTime = strToDate(dtDateTime)
	end if
	DateToStr = year(dtDateTime) & doublenum(Month(dtdateTime)) & doublenum(Day(dtdateTime)) & doublenum(Hour(dtdateTime)) & doublenum(Minute(dtdateTime)) & doublenum(Second(dtdateTime)) & ""
end function


function ReadLastHereDate(UserName)
	dim rs_date
	dim strSql
	if trim(UserName) = "" then 
		ReadLastHereDate = DateToStr(DateAdd("d", -10, strForumTimeAdjust))
		exit function
	end if
	'## Forum_SQL
	strSql = "SELECT M_LASTHEREDATE "
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS "
	strSql = strSql & " WHERE " & strDBNTSQLName & " = '" & ChkString(UserName, "SQLString") & "' "
	Set rs_date = Server.CreateObject("ADODB.Recordset")
	rs_date.open strSql, my_Conn
	if (rs_date.BOF and rs_date.EOF) then
		ReadLastHereDate = DateToStr(DateAdd("d",-10,strForumTimeAdjust))
	else
		if rs_date("M_LASTHEREDATE") = "" or IsNull(rs_date("M_LASTHEREDATE")) then
			ReadLastHereDate = DateToStr(DateAdd("d",-10,strForumTimeAdjust))
		else
			ReadLastHereDate = rs_date("M_LASTHEREDATE")
		end if
	end if
	rs_date.close
	set rs_date = nothing
	UpdateLastHereDate DateToStr(strForumTimeAdjust),UserName
end function


function UpdateLastHereDate(fTime,UserName)
	'## Forum_SQL - Do DB Update
	strSql = "UPDATE " & strMemberTablePrefix & "MEMBERS "
	strSql = strSql & " SET M_LASTHEREDATE = '" & fTime & "'"
	strSql = strSql & ",    M_LAST_IP = '" & Request.ServerVariables("REMOTE_ADDR") & "'"
	strSql = strSql & " WHERE " & strDBNTSQLName & " = '" & ChkString(UserName, "SQLString") & "' "
	my_conn.Execute (strSql),,adCmdText + adExecuteNoRecords
end function


function chkDate(fDate,separator,fTime)
	if fDate = "" or isNull(fDate) then
		if fTime then
			chkTime(fDate)
		end if
		exit function
	end if
	select case strDateType
		case "dmy"
			chkDate = Mid(fDate,7,2) & "/" & _
			Mid(fDate,5,2) & "/" & _
			Mid(fDate,1,4)
		case "mdy"
			chkDate = Mid(fDate,5,2) & "/" & _
			Mid(fDate,7,2) & "/" & _
			Mid(fDate,1,4)
		case "ymd"
			chkDate = Mid(fDate,1,4) & "/" & _
			Mid(fDate,5,2) & "/" & _
			Mid(fDate,7,2)
		case "ydm"
			chkDate =Mid(fDate,1,4) & "/" & _
			Mid(fDate,7,2) & "/" & _
			Mid(fDate,5,2)
		case "dmmy"
			chkDate = Mid(fDate,7,2) & " " & _
			Monthname(Mid(fDate,5,2),1) & " " & _
			Mid(fDate,1,4)
		case "mmdy"
			chkDate = Monthname(Mid(fDate,5,2),1) & " " & _
			Mid(fDate,7,2) & " " & _
			Mid(fDate,1,4)
		case "ymmd"
			chkDate = Mid(fDate,1,4) & " " & _
			Monthname(Mid(fDate,5,2),1) & " " & _
			Mid(fDate,7,2)
		case "ydmm"
			chkDate = Mid(fDate,1,4) & " " & _
			Mid(fDate,7,2) & " " & _
			Monthname(Mid(fDate,5,2),1)
		case "dmmmy"
			chkDate = Mid(fDate,7,2) & " " & _
			Monthname(Mid(fDate,5,2),0) & " " & _
			Mid(fDate,1,4)
		case "mmmdy"
			chkDate = Monthname(Mid(fDate,5,2),0) & " " & _
			Mid(fDate,7,2) & " " & _
			Mid(fDate,1,4)
		case "ymmmd"
			chkDate = Mid(fDate,1,4) & " " & _
			Monthname(Mid(fDate,5,2),0) & " " & _
			Mid(fDate,7,2)
		case "ydmmm"
			chkDate = Mid(fDate,1,4) & " " & _
			Mid(fDate,7,2) & " " & _
			Monthname(Mid(fDate,5,2),0)
		case else
			chkDate = Mid(fDate,5,2) & "/" & _
			Mid(fDate,7,2) & "/" & _
			Mid(fDate,1,4)
	end select
	if fTime then
		chkDate = chkDate & separator & chkTime(fDate)
	end if
end function


function chkTime(fTime)
	if fTime = "" or isNull(fTime) then
		exit function
	end if
	if strTimeType = 12 then
		if cLng(Mid(fTime, 9,2)) > 12 then
			chkTime = ChkTime & " " & _
			(cLng(Mid(fTime, 9,2)) -12) & ":" & _
			Mid(fTime, 11,2) & ":" & _
			Mid(fTime, 13,2) & " " & "PM"
		elseif cLng(Mid(fTime, 9,2)) = 12 then
			chkTime = ChkTime & " " & _
			cLng(Mid(fTime, 9,2)) & ":" & _
			Mid(fTime, 11,2) & ":" & _
			Mid(fTime, 13,2) & " " & "PM"
		elseif cLng(Mid(fTime, 9,2)) = 0 then
			chkTime = ChkTime & " " & _
			(cLng(Mid(fTime, 9,2)) +12) & ":" & _
			Mid(fTime, 11,2) & ":" & _
			Mid(fTime, 13,2) & " " & "AM"
		else
			chkTime = ChkTime & " " & _
			Mid(fTime, 9,2) & ":" & _
			Mid(fTime, 11,2) & ":" & _
			Mid(fTime, 13,2) & " " & "AM"
		end if
		
	else
		ChkTime = ChkTime & " " & _
		Mid(fTime, 9,2) & ":" & _
		Mid(fTime, 11,2) & ":" & _
		Mid(fTime, 13,2) 
	end if
end function


function widenum(fNum)
	if fNum > 9 then 
		widenum = "" 
	else 
		widenum = "&nbsp;"
	end if
end function


'##############################################
'##           Multi-Moderators               ##
'##############################################

function chkForumModerator(fForum_ID, fMember_Name)
	'## Forum_SQL 
	strSql = "SELECT mo.FORUM_ID "	
	strSql = strSql & " FROM " & strTablePrefix & "MODERATOR mo, " & strMemberTablePrefix & "MEMBERS me "	
	strSql = strSql & " WHERE mo.FORUM_ID = " & fForum_ID & " "	
	strSql = strSql & " AND   mo.MEMBER_ID = me.MEMBER_ID "	
	strSql = strSql & " AND   me." & strDBNTSQLName & " = '" & chkString(fMember_Name,"SQLString") & "'"

	set rsChk = Server.CreateObject("ADODB.Recordset")
	rsChk.open strSql, my_Conn
	
	if rsChk.bof or rsChk.eof then		
		chkForumModerator = "0"
	else
		chkForumModerator = "1"	
	end if 	
	rsChk.close	
	set rsChk = nothing
end function


'##############################################
'##            NT Authentication             ##
'##############################################

sub NTUser()

dim strSql
dim rs_chk

	if Session(strCookieURL & "username")="" then

		'## Forum_SQL
		strSql ="SELECT MEMBER_ID, M_LEVEL, M_PASSWORD, M_USERNAME, M_NAME "
		strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS "
		strSql = strSql & " WHERE M_USERNAME = '" & ChkString(Session(strCookieURL & "userid"), "SQLString") & "'"
		strSql = strSql & " AND M_STATUS = " & 1

		Set rs_chk = Server.CreateObject("ADODB.Recordset")
		rs_chk.open strSql, my_Conn

		if rs_chk.BOF or rs_chk.EOF then
			strLoginStatus = 0
		else
			Session(strCookieURL & "username") = rs_chk("M_NAME")
			if strSetCookieToForum = 1 then
				Response.Cookies(strUniqueID & "User").Path = strCookieURL
			end if
			Response.Cookies(strUniqueID & "User")("Name") = rs_chk("M_NAME")
			Response.Cookies(strUniqueID & "User")("Pword") = rs_chk("M_PASSWORD")
			'Response.Cookies(strUniqueID & "User")("Cookies") = ""
			Response.Cookies(strUniqueID & "User").Expires = dateAdd("d", intCookieDuration, strForumTimeAdjust)
			Session(strCookieURL & "last_here_date") = ReadLastHereDate(Request.Form("Name"))
			if strAuthType = "nt" then
				Session(strCookieURL & "last_here_date") = ReadLastHereDate(Session(strCookieURL & "userID"))
			end if

			strLoginStatus = 1
			
			mLev = cLng(chkUser(Session(strCookieURL & "userID"), Request.Cookies(strUniqueID & "User")("Pword"),-1))
			if mLev = 4 then 
				Session(strCookieURL & "Approval") = "15916941253"
			end if
		end if

		rs_chk.close	
		set rs_chk = nothing
	end if
end sub


function chkAccountReg()

	dim strSql
	dim rs_chk

	'## Forum_SQL 
	strSql ="SELECT M_LEVEL, M_USERNAME "
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS "
	strSql = strSql & " WHERE M_USERNAME = '" & ChkString(Session(strCookieURL & "userid"), "SQLString") & "'"
	strSql = strSql & " AND M_STATUS = " & 1

	Set rs_chk = Server.CreateObject("ADODB.Recordset")
	rs_chk.open strSql, my_Conn

	if rs_chk.BOF or rs_chk.EOF then
		chkAccountReg = "0"
	else
		chkAccountReg = "1"
	end if

	rs_chk.close
	set rs_chk = nothing
end function


sub NTAuthenticate()
	dim strUser, strNTUser, checkNT
	strNTUser = Request.ServerVariables("AUTH_USER")
	strNTUser = replace(strNTUser, "\", "/")
	if Session(strCookieURL & "userid") = "" then
		strUser = Mid(strNTUser,(instr(1,strNTUser,"/")+1),len(strNTUser))
		Session(strCookieURL & "userid") = strUser
	end if
	if strNTGroups="1" then
		strNTGroupsSTR = Session(strCookieURL & "strNTGroupsSTR")
		if Session(strCookieURL & "strNTGroupsSTR") = "" then
			Set strNTUserInfo = GetObject("WinNT://"+strNTUser)
			For Each strNTUserInfoGroup in strNTUserInfo.Groups
				strNTGroupsSTR=strNTGroupsSTR+", "+strNTUserInfoGroup.name
			NEXT
			Session(strCookieURL & "strNTGroupsSTR") = strNTGroupsSTR
		end if
	end if
	if strAutoLogon="1" then
		strNTUserFullName = Session(strCookieURL & "strNTUserFullName")
		if Session(strCookieURL & "strNTUserFullName") = "" then
			Set strNTUserInfo = GetObject("WinNT://"+strNTUser)
			strNTUserFullName=strNTUserInfo.FullName
			Session(strCookieURL & "strNTUserFullName") = strNTUserFullName
		end if
	end if
end sub


'##############################################
'##        Cookie functions and Subs         ##
'##############################################

sub doCookies(fSavePassWord)
	if strSetCookieToForum = 1 then
		Response.Cookies(strUniqueID & "User").Path = strCookieURL
	else
		Response.Cookies(strUniqueID & "User").Path = "/"
	end if
	Response.Cookies(strUniqueID & "User")("Name") = strDBNTFUserName
	Response.Cookies(strUniqueID & "User")("Pword") = strEncodedPassword
	'Response.Cookies(strUniqueID & "User")("Cookies") = Request.Form("Cookies")
	if fSavePassWord = "true" then
		Response.Cookies(strUniqueID & "User").Expires = dateAdd("d", intCookieDuration, strForumTimeAdjust)
	end if
	Session(strCookieURL & "last_here_date") = ReadLastHereDate(strDBNTFUserName)	
end sub


sub ClearCookies()
	if strSetCookieToForum = 1 then
		Response.Cookies(strUniqueID & "User").Path = strCookieURL
	else
		Response.Cookies(strUniqueID & "User").Path = "/"
	end if
	Response.Cookies(strUniqueID & "User") = ""
	Session(strCookieURL & "Approval") = ""
	Session.Contents("intInvAdmin") = ""
	Session.Abandon
	'Response.Cookies(strUniqueID & "User").Expires = dateadd("d", -2, strForumTimeAdjust)
end sub


'##############################################
'##              Private Forums              ##
'##############################################

function chkUser(fName, fPassword, fAuthor)

	dim rsCheck
	dim strSql

	'## Forum_SQL
	strSql = "SELECT MEMBER_ID, M_LEVEL, M_NAME, M_PASSWORD , M_INV_ADMIN"
	strSql = strSql & " FROM " & strMemberTablePrefix & "MEMBERS "
	strSql = strSql & " WHERE " & strDBNTSQLName & " = '" & ChkString(fName, "SQLString") & "' "
	if strAuthType="db" then	
		strSql = strSql & " AND M_PASSWORD = '" & ChkString(fPassword, "SQLString") &"'"
	End If
	strSql = strSql & " AND M_STATUS = " & 1
	Set rsCheck = my_Conn.Execute(strSql)
	if rsCheck.BOF or rsCheck.EOF or not(ChkQuoteOk(fName)) or not(ChkQuoteOk(fPassword)) then
		MemberID = -1
		chkUser = 0 '##  Invalid Password
		if strDBNTUserName <> "" and chkCookie = 1 then
			Call ClearCookies()
			strDBNTUserName = ""
		end if		
	else
		MemberID = rsCheck("MEMBER_ID")
		'set session var for Inventory Admin Authentication
		Session.Contents("intInvAdmin") = cLng(rsCheck("M_INV_ADMIN"))
		if (rsCheck("MEMBER_ID") & "" = fAuthor & "") and (cLng(rsCheck("M_LEVEL")) <> 3) then 
			chkUser = 1 '## Author
		else
			select case cLng(rsCheck("M_LEVEL"))
				case 1
					chkUser = 2 '## Normal User
				case 2
					chkUser = 3 '## Moderator
				case 3
					chkUser = 4 '## Admin
				case else
					chkUser = cLng(rsCheck("M_LEVEL"))
			end select
		end if	
	end if

	rsCheck.close	
	set rsCheck = nothing

end function

Function ReplaceURLs(ByVal strToFormat)
	Dim oTag, c1Tag, oTag2, c2Tag
	Dim roTag, rc1Tag, rc2Tag
	Dim oTagPos, c1TagPos, oTagPos2, c1TagPos2
	Dim Counter
	Dim strArray, strArray2
	Dim strFirstPart, strSecondPart

	oTag = "[url="""
	c1Tag = """]"
	oTag2 = "[url]"
	c2Tag = "[/url]"

	roTag = "<a href="""
	rc1Tag = """ target=""_blank"">"
	rc2Tag = "</a>"

	oTagPos = InStr(1, strToFormat, oTag, 1) 'Position of opening tag
	c1TagPos = InStr(1, strToFormat, c1Tag, 1) 'Position of closing tag

	'if opening tag and closing tag is found...
	If (oTagpos > 0) And (c1TagPos > 0) Then
		'Split string at the opening tag
		strArray = Split(strToFormat, oTag, -1, 1)
		
		'Loop through array
		For Counter = 0 To UBound(strArray)
			'if the closing tag is found in the string then...
			If (InStr(1, strArray(Counter), c1Tag, 1) > 0) Then
				'split string at the closing tag...
				strArray2 = Split(strArray(Counter), c1Tag, -1, 1)

				strArray2(0) = replace(strArray2(0), """", " ") ' ## filter out "
				'strArray2(0) = replace(strArray2(0), "&", " ", 1, -1, 1) ' ## filter out &
				'strArray2(0) = replace(strArray2(0), "#", " ", 1, -1, 1) ' ## filter out #
				strArray2(0) = replace(strArray2(0), ";", " ", 1, -1, 1) ' ## filter out ;
				strArray2(0) = replace(strArray2(0), "+", " ", 1, -1, 1) ' ## filter out +
				strArray2(0) = replace(strArray2(0), "(", " ", 1, -1, 1) ' ## filter out (
				strArray2(0) = replace(strArray2(0), ")", " ", 1, -1, 1) ' ## filter out )
				'strArray2(0) = replace(strArray2(0), "[", " ", 1, -1, 1) ' ## filter out [
				'strArray2(0) = replace(strArray2(0), "]", " ", 1, -1, 1) ' ## filter out ]
				'strArray2(0) = replace(strArray2(0), "=", " ", 1, -1, 1) ' ## filter out =
				strArray2(0) = replace(strArray2(0), "*", " ", 1, -1, 1) ' ## filter out *
				strArray2(0) = replace(strArray2(0), "'", " ", 1, -1, 1) ' ## filter out '
				strArray2(0) = replace(strArray2(0), ">", " ", 1, -1, 1) ' ## filter out >
				strArray2(0) = replace(strArray2(0), "<", " ", 1, -1, 1) ' ## filter out <
				strArray2(0) = replace(strArray2(0), vbTab, " ", 1, -1, 1) ' ## filter out Tabs
				strArray2(0) = replace(strArray2(0), "view-source", " ", 1, -1, 1) ' ## filter out view-source
				strArray2(0) = replace(strArray2(0), "javascript", " ", 1, -1, 1) ' ## filter out javascript
				strArray2(0) = replace(strArray2(0), "jscript", " ", 1, -1, 1) ' ## filter out jscript
				strArray2(0) = replace(strArray2(0), "vbscript", " ", 1, -1, 1) ' ## filter out vbscript

				'if the closing url tag is found in the string and
				'[URL] is not found in the string then...
				If InStr(1, strArray2(1), c2Tag, 1) And _
					Not InStr(1, UCase(strArray2(1)), "[URL]", 1) Then

					strFirstPart = Left(strArray2(1), InStr(1, strArray2(1), c2Tag, 1)-1)
					strSecondPart = Right(strArray2(1), (Len(strArray2(1)) - Instr(1, strArray2(1), c2Tag,1) - len(c2Tag)+1))

					If strFirstPart <> "" Then
						If UCase(Left(strFirstPart, 5)) = "[IMG]" Then
							ReplaceURLs = ReplaceURLs & "<a href=""" & strArray2(0) & """ target=""_blank"">" & strFirstPart & "</a>" & strSecondPart
						ElseIf UCase(Left(strArray2(0), 7)) = "HTTP://" Then
							'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 1) & strSecondPart
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 8)) = "HTTPS://" Then
							'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 2) & strSecondPart
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 4)) = "WWW." Then
							'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 3) & strSecondPart
							ReplaceURLs = ReplaceURLs & roTag & "http://" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 7)) = "MAILTO:" Then
							'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 4) & strSecondPart
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 6)) = "FTP://" Then
							'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 5) & strSecondPart
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf InStr(strArray2(0), "@") > 0 Then
							'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 4) & strSecondPart
							ReplaceURLs = ReplaceURLs & roTag & "mailto:" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 6)) = "FILE:///" Then
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						Else
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						End If
					Else
						If UCase(Left(strArray2(0), 7)) = "HTTP://" Then
							ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 1) & strSecondPart
							'ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 8)) = "HTTPS://" Then
							ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 2) & strSecondPart
							'ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 4)) = "WWW." Then
							ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 3) & strSecondPart
							'ReplaceURLs = ReplaceURLs & roTag & "http://" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 7)) = "MAILTO:" Then
							ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 4) & strSecondPart
							'ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 6)) = "FTP://" Then
							ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 5) & strSecondPart
							'ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf InStr(strArray2(0), "@") > 0 Then
							ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 4) & strSecondPart
							'ReplaceURLs = ReplaceURLs & roTag & "mailto:" & strArray2(0) & rc1Tag & strFirstPart & rc2Tag & strSecondPart
						ElseIf UCase(Left(strArray2(0), 6)) = "FILE:///" Then
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strSecondPart
						Else
							ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strSecondPart
						End If
					End If
				Else
					ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
				End If
			Else
				ReplaceURLs = ReplaceURLs & strArray(Counter)
			End If
		Next
	Else
		ReplaceURLs = strToFormat
	End If
	
	oTagPos2 = InStr(1, ReplaceURLs, oTag2, 1)
	c1TagPos2 = InStr(1, ReplaceURLs, c2Tag, 1)

	'if opening tag and closing tag is found then...
	If (oTagpos2 > 0) And (c1TagPos2 > 0) Then
		'split string at opening tag
		strArray = Split(ReplaceURLs, oTag2, -1, 1)

		ReplaceURLs = ""
		For Counter = 0 To Ubound(strArray)
			'if closing url tag is found in string then...
			If InStr(1, strArray(Counter), c2Tag, 1) > 0 Then
				'split string at closing url tag
				strArray2 = Split(strArray(Counter), c2Tag, -1, 1)
				
				strArray2(0) = replace(strArray2(0), """", " ") ' ## filter out "
				'strArray2(0) = replace(strArray2(0), "&", " ", 1, -1, 1) ' ## filter out &
				'strArray2(0) = replace(strArray2(0), "#", " ", 1, -1, 1) ' ## filter out #
				strArray2(0) = replace(strArray2(0), ";", " ", 1, -1, 1) ' ## filter out ;
				strArray2(0) = replace(strArray2(0), "+", " ", 1, -1, 1) ' ## filter out +
				strArray2(0) = replace(strArray2(0), "(", " ", 1, -1, 1) ' ## filter out (
				strArray2(0) = replace(strArray2(0), ")", " ", 1, -1, 1) ' ## filter out )
				'strArray2(0) = replace(strArray2(0), "[", " ", 1, -1, 1) ' ## filter out [
				'strArray2(0) = replace(strArray2(0), "]", " ", 1, -1, 1) ' ## filter out ]
				'strArray2(0) = replace(strArray2(0), "=", " ", 1, -1, 1) ' ## filter out =
				strArray2(0) = replace(strArray2(0), "*", " ", 1, -1, 1) ' ## filter out *
				strArray2(0) = replace(strArray2(0), "'", " ", 1, -1, 1) ' ## filter out '
				strArray2(0) = replace(strArray2(0), ">", " ", 1, -1, 1) ' ## filter out >
				strArray2(0) = replace(strArray2(0), "<", " ", 1, -1, 1) ' ## filter out <
				strArray2(0) = replace(strArray2(0), vbTab, " ", 1, -1, 1) ' ## filter out Tabs
				strArray2(0) = replace(strArray2(0), "view-source", " ", 1, -1, 1) ' ## filter out view-source
				strArray2(0) = replace(strArray2(0), "javascript", " ", 1, -1, 1) ' ## filter out javascript
				strArray2(0) = replace(strArray2(0), "jscript", " ", 1, -1, 1) ' ## filter out jscript
				strArray2(0) = replace(strArray2(0), "vbscript", " ", 1, -1, 1) ' ## filter out vbscript

				If UCase(Left(strArray2(0), 7)) = "HTTP://" Then
					ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 1) & strArray2(1)
				ElseIf UCase(Left(strArray2(0), 8)) = "HTTPS://" Then
					ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 2) & strArray2(1)
				ElseIf UCase(Left(strArray2(0), 4)) = "WWW." Then
					ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 3) & strArray2(1)
				ElseIf UCase(Left(strArray2(0), 7)) = "MAILTO:" Then
					'ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 4) & strArray2(1)
					ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
				ElseIf UCase(Left(strArray2(0), 6)) = "FTP://" Then
					ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 5) & strArray2(1)
				ElseIf InStr(strArray2(0), "@") > 0 Then
					ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 4) & strArray2(1)
				ElseIf UCase(Left(strArray2(0), 6)) = "FILE:///" Then
					ReplaceURLs = ReplaceURLs & edit_hrefs(strArray2(0), 7) & strArray2(1)
				Else
					ReplaceURLs = ReplaceURLs & roTag & strArray2(0) & rc1Tag & strArray2(0) & rc2Tag & strArray2(1)
				End If
			Else
				ReplaceURLs = ReplaceURLs & strArray(Counter)
			End If
		Next
	End If
End Function


function isAllowedMember(fForum_ID,fMemberID)
	if fMemberID <> MemberID then
		isAllowedMember = OldisAllowedMember(fForum_ID,fMemberID)
		exit function
	end if
	if Session(strCookieURL & "AllowedForums" & MemberID) = "" or IsNull(Session(strCookieURL & "AllowedForums" & MemberID)) then
		strSql = "SELECT FORUM_ID FROM " & strTablePrefix & "ALLOWED_MEMBERS "
		strSql = strSql & " WHERE MEMBER_ID = " & cLng(fMemberID)

		Set rsAllowedMember = Server.CreateObject("ADODB.Recordset")
		rsAllowedMember.open strSql, my_Conn, adOpenForwardOnly, adLockReadOnly, adCmdText

		if (rsAllowedMember.EOF or rsAllowedMember.BOF) then
			isAllowedMember2 = "-1"
			Session(strCookieURL & "AllowedForums" & MemberID) = isAllowedMember2
			Session(strCookieURL & "AllowedForums" & MemberID) = isAllowedMember2
		else
			arrAllowedForums = rsAllowedMember.GetRows(adGetRowsRest)
			For AllowCount = 0 to ubound(arrAllowedForums,2) ' Total Numer of Rows
				if AllowCount = 0 then
					isAllowedMember2 = arrAllowedForums(0,AllowCount)
				else
					isAllowedMember2 = isAllowedMember2 & "," & arrAllowedForums(0,AllowCount)
				end if
			next
			Session(strCookieURL & "AllowedForums" & MemberID) = isAllowedMember2
			Session(strCookieURL & "AllowedForums" & MemberID) = isAllowedMember2
		end if
		rsAllowedMember.close
		set rsAllowedMember = nothing
	end if
	if Session(strCookieURL & "AllowedForums" & MemberID) = "-1" then
		isAllowedMember = 0
	elseif InStr("," & Session(strCookieURL & "AllowedForums" & MemberID) & ",","," & fForum_ID & ",") then
		isAllowedMember = 1
	else
		isAllowedMember = 0
	end if
end function


function OldisAllowedMember(fForum_ID,fMemberID)
	OldisAllowedMember = 0
	strSql = "SELECT MEMBER_ID, FORUM_ID FROM " & strTablePrefix & "ALLOWED_MEMBERS "
	strSql = strSql & " WHERE FORUM_ID = " & cLng(fForum_ID)
	strSql = strSql & " AND MEMBER_ID = " & cLng(fMemberID)

	Set rsAllowedMember = Server.CreateObject("ADODB.Recordset")
	rsAllowedMember.open strSql, my_Conn

	if (rsAllowedMember.EOF or rsAllowedMember.BOF) then
		OldisAllowedMember = 0
		rsAllowedMember.close
		set rsAllowedMember = nothing
		exit function
	else
		OldisAllowedMember = 1
		rsAllowedMember.close
		set rsAllowedMember = nothing
	end if
end function


Function ReplaceImageTags(fString)
 	Dim oTag, cTag
 	Dim roTag, rcTag
 	Dim oTagPos, cTagPos
 	Dim nTagPos
 	Dim counter1, counter2, counter3
 	Dim strUrlText
 	Dim Tagcount
 	Dim strTempString, strResultString
 	TagCount = 7
  	Dim ImgTags(7,2,2)
 	Dim strArray, strArray2

 	ImgTags(1,1,1) = "[img]"
 	ImgTags(1,2,1) = "[/img]"
 	ImgTags(1,1,2) = "<img src="""
 	ImgTags(1,2,2) = """ border=""0"">"

 	ImgTags(2,1,1) = "[IMG]"
 	ImgTags(2,2,1) = "[/IMG]"
 	ImgTags(2,1,2) = ImgTags(1,1,2)
 	ImgTags(2,2,2) = ImgTags(1,2,2)

 	ImgTags(3,1,1) = "[image]"
 	ImgTags(3,2,1) = "[/image]"
 	ImgTags(3,1,2) = ImgTags(1,1,2)
 	ImgTags(3,2,2) = ImgTags(1,2,2)

 	ImgTags(4,1,1) = "[img=right]"
 	ImgTags(4,2,1) = "[/img=right]"
 	ImgTags(4,1,2) = "<img align=""right"" src="""
 	ImgTags(4,2,2) = """ id=""right"" border=""0"">"

 	ImgTags(5,1,1) = "[image=right]"
 	ImgTags(5,2,1) = "[/image=right]"
 	ImgTags(5,1,2) = ImgTags(4,1,2)
 	ImgTags(5,2,2) = ImgTags(4,2,2)

 	ImgTags(6,1,1) = "[img=left]"
 	ImgTags(6,2,1) = "[/img=left]"
 	ImgTags(6,1,2) = "<img align=""left"" src="""
 	ImgTags(6,2,2) = """ id=""left"" border=""0"">"

 	ImgTags(7,1,1) = "[image=left]"
 	ImgTags(7,2,1) = "[/image=left]"
 	ImgTags(7,1,2) = ImgTags(6,1,2)
 	ImgTags(7,2,2) = ImgTags(6,2,2)

 	strResultString = ""
 	strTempString = fString

 	for counter1 = 1 to TagCount

 		oTag   = ImgTags(counter1,1,1)
 		roTag  = ImgTags(counter1,1,2)
 		cTag   = ImgTags(counter1,2,1)
 		rcTag  = ImgTags(counter1,2,2)
 		oTagPos = InStr(1, strTempString, oTag, 1)
 		cTagPos = InStr(1, strTempString, cTag, 1)

 		if (oTagPos > 0) and (cTagPos > oTagPos) then
 		 	strArray = Split(strTempString, oTag, -1)
 		 	for counter2 = 0 to Ubound(strArray)
 		 		if (Instr(1, strArray(counter2), cTag, 1) > 0) then
 		 			strArray2 = split(strArray(counter2), cTag, -1)
					strUrlText = trim(strArray2(0))
 					strUrlText = replace(strUrlText, """", " ") ' ## filter out "
					'## Added to exclude Javascript and other potentially hazardous characters
					strUrlText = replace(strUrlText, "&", " ", 1, -1, 1) ' ## filter out &
					strUrlText = replace(strUrlText, "#", " ", 1, -1, 1) ' ## filter out #
					strUrlText = replace(strUrlText, ";", " ", 1, -1, 1) ' ## filter out ;
					strUrlText = replace(strUrlText, "+", " ", 1, -1, 1) ' ## filter out +
					strUrlText = replace(strUrlText, "(", " ", 1, -1, 1) ' ## filter out (
					strUrlText = replace(strUrlText, ")", " ", 1, -1, 1) ' ## filter out )
					strUrlText = replace(strUrlText, "[", " ", 1, -1, 1) ' ## filter out [
					strUrlText = replace(strUrlText, "]", " ", 1, -1, 1) ' ## filter out ]
					strUrlText = replace(strUrlText, "=", " ", 1, -1, 1) ' ## filter out =
					strUrlText = replace(strUrlText, "*", " ", 1, -1, 1) ' ## filter out *
					strUrlText = replace(strUrlText, "'", " ", 1, -1, 1) ' ## filter out '
					strUrlText = replace(strUrlText, vbTab, " ", 1, -1, 1) ' ## filter out Tabs
					strUrlText = replace(strUrlText, "view-source", " ", 1, -1, 1) ' ## filter out view-source
					strUrlText = replace(strUrlText, "javascript", " ", 1, -1, 1) ' ## filter out javascript
					strUrlText = replace(strUrlText, "jscript", " ", 1, -1, 1) ' ## filter out jscript
					strUrlText = replace(strUrlText, "vbscript", " ", 1, -1, 1) ' ## filter out vbscript
					strUrlText = replace(strUrlText, "mailto", " ", 1, -1, 1) ' ## filter out mailto
					'## End Added
 					strUrlText = replace(strUrlText, "<", " ") ' ## filter out <
 					strUrlText = replace(strUrlText, ">", " ") ' ## filter out >
 		 			strResultString = strResultString & roTag & strUrlText & rcTag & strArray2(1)
 		 			for counter3 = 2 to UBound(strArray2)
 		 				strResultString = strResultString & strArray2(counter3)
 		 			next
 		 		else
 		 			strResultString = strResultString & strArray(counter2)
 		 		end if	
 		 	next  

			strTempString = strResultString
 			strResultString = ""
 		end if
	next

	ReplaceImageTags = strTempString
end function

Function ReplaceCodeTags(fString)
 	Dim oTag, cTag
 	Dim roTag, rcTag
 	Dim oTagPos, cTagPos
 	Dim nTagPos
 	Dim counter1, counter2
 	Dim strCodeText
 	Dim Tagcount
 	Dim strTempString, strResultString
 	TagCount = 2
  	Dim CodeTags(2,2,2)
 	Dim strArray, strArray2

 	CodeTags(1,1,1) = "[code]"
 	CodeTags(1,2,1) = "[/code]"
 	CodeTags(1,1,2) = "<pre id=""code""><font face=""courier"" size=""" & strDefaultFontSize & """ id=""code"">"
 	CodeTags(1,2,2) = "</font id=""code""></pre id=""code"">"

 	CodeTags(2,1,1) = "[CODE]"
 	CodeTags(2,2,1) = "[/CODE]"
 	CodeTags(2,1,2) = CodeTags(1,1,2)
 	CodeTags(2,2,2) = CodeTags(1,2,2)

 	strResultString = ""
 	strTempString = fString

 	for counter1 = 1 to TagCount

 		oTag   = CodeTags(counter1,1,1)
 		roTag  = CodeTags(counter1,1,2)
 		cTag   = CodeTags(counter1,2,1)
 		rcTag  = CodeTags(counter1,2,2)
 		oTagPos = InStr(1, strTempString, oTag, 1)
 		cTagPos = InStr(1, strTempString, cTag, 1)

 		if (oTagpos > 0) and (cTagPos > 0) then
 		 	strArray = Split(strTempString, oTag, -1)
 		 	for counter2 = 0 to Ubound(strArray)
 		 		if (Instr(1, strArray(counter2), cTag) > 0) then
 		 			strArray2 = split(strArray(counter2), cTag, -1)
					strCodeText = trim(strArray2(0))
 					strCodeText = replace(strCodeText, "<br />", vbNewLine)
 		 			strResultString = strResultString & roTag & strCodeText & rcTag & strArray2(1)
 		 		else
 		 			strResultString = strResultString & strArray(counter2)
 		 		end if	
 		 	next  

			strTempString = strResultString
 			strResultString = ""
 		end if
	next

	ReplaceCodeTags = strTempString
end function


'##############################################
'##              Page Title                  ##
'##############################################

Function GetNewTitle(strTempScriptName)
	Dim StrTempScript
	Dim strNewTitle
	arrTempScript = Split(strTempScriptName, "/")
	strTempScript = arrTempScript(Ubound(arrTempScript))
	strTempScript = lcase(strTempScript)

	Select Case strTempScript
		Case "topic.asp"
			strTempTopic = cLng(request.querystring("TOPIC_ID"))
			if strTempTopic <> 0 then
				strsql = "SELECT FORUM_ID, T_SUBJECT FROM " & strActivePrefix & "TOPICS WHERE TOPIC_ID=" & strTempTopic
				set ttopics = my_conn.execute(strsql)
				if ttopics.bof or ttopics.eof then
					GetNewTitle = strForumTitle
					set ttopics = nothing
				else
					if mLev = 4 then
						ForumChkSkipAllowed = 1
					elseif mLev = 3 then
						if chkForumModerator(ttopics("FORUM_ID"), ChkString(strDBNTUserName, "decode")) = "1" then
							ForumChkSkipAllowed = 1
						else
							ForumChkSkipAllowed = 0
						end if
					else
						ForumChkSkipAllowed = 0
					end if 
					intShowTopicTitle = 1
					if strPrivateForums = "1" and ForumChkSkipAllowed = 0 then
						if not(chkForumAccess(ttopics("FORUM_ID"),MemberID,false)) then
				    			intShowTopicTitle = 0
				  		end if
					end if
					if intShowTopicTitle = 1 then strTempTopicTitle = " - " & chkString(ttopics("T_SUBJECT"),"display")
					set ttopics = nothing
					strNewTitle = strForumTitle & strTempTopicTitle
				end if
			else
				GetNewTitle = strForumTitle
			end if
		Case "forum.asp"
			strTempForum = cLng(request.querystring("FORUM_ID"))
			if strTempForum <> 0 then
				strsql = "SELECT F_SUBJECT FROM " & strTablePrefix & "FORUM WHERE FORUM_ID=" & strTempForum
				set tforums = my_conn.execute(strsql)
				if tforums.bof or tforums.eof then
					strNewTitle = strForumTitle
					set tforums = nothing
				else	
					strTempForumTitle = chkString(tforums("F_SUBJECT"),"display")
					set tforums = nothing
					strNewTitle = strForumTitle & " - " & strTempForumTitle
				end if
			else
				strNewTitle = strForumTitle
			end if
		Case "members.asp"
			strNewTitle = strForumTitle & " - Members"
		Case "active.asp"
			strNewTitle = strForumTitle & " - Active Topics"
		Case "faq.asp"
			strNewTitle = strForumTitle & " - Frequently Asked Questions"
		Case "search.asp"
			strNewTitle = strForumTitle & " - Search"
		Case "pop_profile.asp"
			if request.querystring("mode") = "display" then
				strNewTitle = strForumTitle & " - View Profile"
			elseif request.querystring("mode") = "edit" then
				strNewTitle = strForumTitle & " - Edit Profile"
			else
				strNewTitle = strForumTitle & " - Profile"
			end if
		Case "policy.asp"
			strNewTitle = strForumTitle & " - User Agreement"
		Case "register.asp"
			strNewTitle = strForumTitle & " - Register"
		Case "down.asp"
			strNewTitle = strForumTitle & " is currently closed."
		Case "default.asp"
			strNewTitle = strForumTitle
		Case else
			strNewTitle = strForumTitle
	End Select
	GetNewTitle = strNewTitle
End Function


'## Function to limit the amount of records to retrieve from the database
Function TopSQL(strSQL, lngRecords)
	if ucase(left(strSQL,7)) = "SELECT " then
 		select case strDBType 
			case "sqlserver"
				TopSQL = "SET ROWCOUNT " & lngRecords & vbNewLine & strSQL & vbNewLine & "SET ROWCOUNT 0"
			case "access"
				TopSQL = "SELECT TOP " & lngRecords & mid(strSQL,7)
			case "mysql"
				if instr(strSQL,";") > 0 then
					strSQL1 = Mid(strSQL, 1, Instr(strSQL, ";")-1)
					strSQL2 = Mid(strSQL, InstrRev(strSQL, ";"))
					TopSQL = strSQL1 & " LIMIT " & lngRecords & strSQL2
				else
					TopSQL = strSQL & " LIMIT " & lngRecords
				end if
		end select
	else
		TopSQL = strSQL
	end if
End Function


Function sGetColspan(lIN, lOUT)
	if (strShowModerators = "1") then lOut = lOut + 1
	if (mlev = "4" or mlev = "3") and (strShowModerators = "1") then lOut = lOut + 1
	if (mlev = "4" or mlev = "3") and (strShowModerators <> "1") then lOut = lOut + 2
	if lOut > lIn then
		sGetColspan = lIN
	else
		sGetColspan = lOUT
	end if
End Function


function dWStatus(strMsg)
	dWStatus = " onMouseOver=""(window.status='" & Replace(strMsg, "'", "\'") & "'); return true"" onMouseOut=""(window.status=''); return true"""
end function


function profileLink(fName, fID)
	if instr(fName,"img src=") > 0 then
		strExtraStuff = ""
	else
		strExtraStuff = " title=""View " & fName & "'s Profile""" & dWStatus("View " & fName & "'s Profile")
	end if
	if strUseExtendedProfile then
		strReturn = "<a href=""pop_profile.asp?mode=display&id=" & fID & """" & strExtraStuff & ">"
	else
		strReturn = "<a href=""JavaScript:openWindow3('pop_profile.asp?mode=display&id=" & fID & "')""" & strExtraStuff & ">"
	end if
	profileLink = strReturn & fName & "</a>"
end function


function chkSelect(actualValue, thisValue)
	if isNumeric(actualValue) then actualValue = cLng(actualValue)
	if actualValue = thisValue then
		chkSelect = " selected"
	else 
		chkSelect = ""
	end if
end function


function chkExist(actualValue)
	if trim(actualValue) <> "" then
		chkExist = actualValue
	else 
		chkExist = ""
	end if
end function


function chkExistElse(actualValue, elseValue)
	if trim(actualValue) <> "" then
		chkExistElse = actualValue
	else 
		chkExistElse = elseValue
	end if
end function


function chkRadio(actualValue, thisValue, boltf)
	if isNumeric(actualValue) then actualValue = cLng(actualValue)
	if actualValue = thisValue EQV boltf then
		chkRadio = " checked"
	else 
		chkRadio = ""
	end if
end function


function chkCheckbox(actualValue, thisValue, boltf)
	if isNumeric(actualValue) then actualValue = cLng(actualValue)
	if actualValue = thisValue EQV boltf then
		chkCheckbox = " checked"
	else 
		chkCheckbox = ""
	end if
end function


function InArray(strArray,strValue)
	if strArray <> "" and strArray <> "0" then
		if (instr("," & strArray & "," ,"," & strValue & ",") > 0) then
			InArray = True
			exit function
		end if
	end if
	InArray = False
end function


function oldInArray(strArray,strValue)
	if IsArray(strArray) then
		Dim Ix
		for Ix = 0 To UBound(strArray)
			if cLng(strArray(Ix)) = cLng(strValue) then
				oldInArray = True
				exit function
			end if
		next
	end if
	oldInArray = False
end function


Sub WriteFooter() %>
<!--#INCLUDE FILE="inc_footer.asp"-->
<% end sub


Sub WriteFooterShort() %>
<!--#INCLUDE FILE="inc_footer_short.asp"-->
<% end sub
%>


<script language="javascript1.2" runat="server">
function edit_hrefs(sURL, iType) {
	sOutput = new String(sURL);

	if (iType == 1) {
		sOutput = sOutput.replace(/\b(http\:\/\/[\w+\.]+[\w+\.\:\/\@\_\?\=\&\-\'\#\%\~\;\,\$\!\+\*]+)/gi,
			"<a href=\"$1\" target=\"_blank\">$1<\/a>");
	} else if (iType == 2) {
		sOutput = sOutput.replace(/\b(https\:\/\/[\w+\.]+[\w+\.\:\/\@\_\?\=\&\-\'\#\%\~\;\,\$\!\+\*]+)/gi,
			"<a href=\"$1\" target=\"_blank\">$1<\/a>");
	} else if (iType == 3) {
		sOutput = sOutput.replace(/\b(www\.[\w+\.\:\/\@\_\?\=\&\-\'\#\%\~\;\,\$\!\+\*]+)/gi,
			"<a href=\"http://$1\" target=\"_blank\">$1<\/a>");
	} else if (iType == 4) {
		sOutput = sOutput.replace(/\b([\w+\-\'\#\%\.\_\,\$\!\+\*]+@[\w+\.?\-\'\#\%\~\_\.\;\,\$\!\+\*]+\.[\w+\.?\-\'\#\%\~\_\.\;\,\$\!\+\*]+)/gi,
			"<a href=\"mailto\:$1\">$1<\/a>");
	} else if (iType == 5) {
		sOutput = sOutput.replace(/\b(ftp\:\/\/[\w+\.]+[\w+\.\:\/\@\_\?\=\&\-\'\#\%\~\;\,\$\!\+\*]+)/gi,
			"<a href=\"$1\" target=\"_blank\">$1<\/a>");
	} else if (iType == 6) {
		sOutput = sOutput.replace(/\b(file\:\/\/\/[\w+\:\/\\]+[\w+\/\w+\.\:\/\\\@\_\?\=\&\-\'\#\%\~\;\,\$\!\+\*]+)/gi,
		  	"<a href=\"$1\" target=\"_blank\">$1<\/a>");
	}

	return sOutput;
}
</script>
