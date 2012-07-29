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

Response.Write	"    </td>" & vbNewLine & _
		"  </tr>" & vbNewLine & _
		"</table>" & vbNewLine & _
		"<table width=""100%"" align=""center"" border=""0"" bgcolor=""" & strForumCellColor & """ cellpadding=""0"" cellspacing=""1"">" & vbNewLine & _
		"  <tr>" & vbNewLine & _
		"    <td>" & vbNewLine & _
		"      <table border=""0"" width=""100%"" align=""center"" cellpadding=""4"" cellspacing=""0"">" & vbNewLine & _
		"        <tr>" & vbNewLine & _
		"          <td bgcolor=""" & strForumCellColor & """ align=""left"" valign=""top"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>" & strForumTitle & "</font></td>" & vbNewLine & _
		"          <td bgcolor=""" & strForumCellColor & """ align=""right"" valign=""top"" nowrap><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """ color=""" & strForumFontColor & """>&copy; " & strCopyright & "</font></td>" & vbNewLine & _
		"          <td bgcolor=""" & strForumCellColor & """ width=""10"" nowrap><a href=""#top""" & dWStatus("Go To Top Of Page...") & " tabindex=""-1"">" & getCurrentIcon(strIconGoUp,"Go To Top Of Page","align=""right""") & "</a></td>" & vbNewLine & _
		"        </tr>" & vbNewLine & _
		"      </table>" & vbNewLine & _
		"    </td>" & vbNewLine & _
		"  </tr>" & vbNewLine & _
		"</table>" & vbNewLine & _
		"<table border=""0"" width=""100%"" align=""center"" cellpadding=""4"" cellspacing=""0"">" & vbNewLine & _
		"  <tr valign=""top"">" & vbNewLine
if strShowTimer = "1" then
	Response.Write	"    <td align=""left""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>" & chkString(replace(strTimerPhrase, "[TIMER]", abs(round(StopTimer(1), 2)), 1, -1, 1),"display") & "</font></td>" & vbNewLine
end if
Response.Write	"    <td align=""right""><font face=""" & strDefaultFontFace & """ size=""" & strFooterFontSize & """>"


'## START - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT
Response.Write	"<a href=""http://forum.snitz.com"" target=""_blank"" tabindex=""-1""><acronym title=""Powered By: " & strVersion & """>"
if strShowImagePoweredBy = "1" then 
	Response.Write	getCurrentIcon("logo_powered_by.gif||","Powered By: " & strVersion,"")
else
	Response.Write	"Snitz Forums 2000"
end if
Response.Write	"</acronym></a></font></td>" & vbNewline
'## END   - REMOVAL, MODIFICATION OR CIRCUMVENTING THIS CODE WILL VIOLATE THE SNITZ FORUMS 2000 LICENSE AGREEMENT


Response.Write	"  </tr>" & vbNewLine & _
		"</table>" & vbNewLine
%>
<!--#include virtual="/includes/footer_forum.inc.html" -->
<%
Response.Write		"</body>" & vbNewLine & _
		"</html>" & vbNewLine

my_Conn.Close
set my_Conn = nothing 
%>
