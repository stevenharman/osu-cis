<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>www.BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/security.inc.asp" -->
<!-- #include virtual="/includes/header_std_close.inc.html" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->
<%'Use Case Select to remove/add admins
Select Case Request.Form("Method")
	Case "RemoveAdmins"
		n = Cint(Request.Form("num_users"))
		For i = 1 to n
			removeNum = Cint(Request.Form("fUserNum_" & i))
			If removeNum = 1 Then
				uID = Request.Form("fUserID_"& i)
				objConn.Execute("UPDATE forum_members SET M_INV_ADMIN = '0' WHERE MEMBER_ID = '" & uID & "'")
			End If
		Next
	Case "AddAdmins"
		n = Cint(Request.Form("num_users"))
		For i = 1 to n
			AddNum = Cint(Request.Form("fUserNum_" & i))
			If AddNum = 1 Then
				uID = Request.Form("fUserID_"& i)
				objConn.Execute("UPDATE forum_members SET M_INV_ADMIN = '1' WHERE MEMBER_ID = '" & uID & "'")
			End If
		Next
End Select
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
	<td width="50%" class="Body-Std-Bold-txt">Current Inventory Administrators</td>
	<td width="50%" class="Body-Std-Bold-txt">Available Members</td>
</tr>
<tr> 
	<td colspan="2"><hr></td>
</tr>
<tr>
	<td class="Body-Small-txt"><font color="#FF0000">To remove Inventory Administrators</font>:<br>Check the box next to their name and click the "Remove Admins!" button.</td>
	<td class="Body-Small-txt"><font color="#FF0000">To add Inventory Administrators</font>:<br>Check the box next to their name and click the "Add Admins!" button.</td>
</tr>

<tr> 
	<td class="Body-Std-txt" valign="top">
<%
	objRS.Open "SELECT m.MEMBER_ID, m.M_NAME, m.M_INV_ADMIN FROM forum_members m " _
			& "WHERE m.M_INV_ADMIN = '1' " _
			& "ORDER BY m.M_USERNAME DESC LIMIT 0 , 99999", objConn
	If objRS.BOF OR objRS.EOF Then
	%>
                  There are currently no Inventory Administrators...?<br>
		If that's the case, you shouldn't even be seeing this!!!
	<%
	Else
		%><form action="/admin/manageadmins.asp?" method="post" name="fRemoveAdmins">
			<input type="hidden" name="Method" value="RemoveAdmins">
		<table align="left" border="0">
		<%
		objRS.MoveFirst
		j = 0
		Do Until objRS.EOF
		j = j + 1
		%>
			<tr><td><%=objRS("M_NAME")%></td>
			<td><input name="fUserNum_<%= j %>" type="checkbox" value="1">
			<input type="hidden" name="fUserID_<%= j %>" value="<%=objRS("MEMBER_ID")%>">
			</td></tr>
		<%			
			objRS.MoveNext
		Loop
		%><tr><td colspan="2"><div align="right"><input name="bRemoveAdmins" type="submit" id="bRemoveAdmins" value="Remove Admins!"></div></td>
		  </tr>
		</table>
		<input type=hidden name="num_users" value="<%= j %>">
		</form>
		<%
	End If
	objRS.close
%>
	</td>
	<td class="Body-Std-txt" valign="top">
<%
	'Show Non-Inv Admins
	objRS.Open "SELECT m.MEMBER_ID, m.M_NAME, m.M_INV_ADMIN FROM forum_members m " _
			& "WHERE m.M_INV_ADMIN = '0' " _
			& "ORDER BY m.M_USERNAME DESC LIMIT 0 , 99999", objConn
	If objRS.BOF OR objRS.EOF Then
	%>
                  There are currently no available members! 
                  <%
	Else
		%><form action="/admin/manageadmins.asp" method="post" name="fAddAdmins">
			<input type="hidden" name="Method" value="AddAdmins">
		<table align="left" border="0">
		<%
		objRS.MoveFirst
		j = 0
		Do Until objRS.EOF
		j = j + 1
		%>
			<tr><td><%=objRS("M_NAME")%></td>
			<td><input name="fUserNum_<%= j %>" type="checkbox" value="1">
			<input type="hidden" name="fUserID_<%= j %>" value="<%=objRS("MEMBER_ID")%>">
			</td></tr>
		<%			
			objRS.MoveNext
		Loop
		%><tr><td colspan="2"><div align="right"><input name="bAddAdmins" type="submit" id="bAddAdmins" value="Add Admins!"></div></td>
		  </tr>
		</table>
		<input type="hidden" name="num_users" value="<%= j %>">
		</form>
		<%
	End If
	objRS.close
%>
	</td>
</tr>
</table>
            <!--#include virtual="/includes/db_close.inc.asp" --> <!--#include file="../includes/footer_std.inc.html"-->
</body>
</html>
