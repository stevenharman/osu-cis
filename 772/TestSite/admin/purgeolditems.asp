<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>www.BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<!-- #include virtual="/includes/security.inc.asp" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->
<!-- #include virtual="/includes/header_std_close.inc.html" -->
<%
	verified = Request.Form("form_verified")
	form_date = Request.Form("form_month") & "/" & Request.Form("form_day") & "/" & Request.Form("form_year")
	If Not IsDate(form_date) Then
		verified = ""
		%>
		<table width=400 border=0 cellpadding="0" cellspacing="0">
		<tr><td><b>The date you selected (<%= form_date %>) is invalid.</b></td></tr>
		</table>
		<%
	End if
	If verified = "" Then
	%>
		<table width=400 border=0 cellpadding="0" cellspacing="0">
		<tr>
		        <td>A purge allows you to remove all items which were deleted before a 
                  certain date.</td>
		</tr>
		<tr><Td height="5">&nbsp;</Td></tr>
		<tr>
		        <td><em>Please input a date below. All items deleted before this 
                  date will be forever removed from the database. Note that you 
                  <strong>must</strong> check the box to the left of the &quot;date&quot; 
                  selection before purging; this is to ensure that you actually 
                  wish to purge these items, and did not accidentally request 
                  the purge.</em></td>
		</tr>
		</table>
		<form action="purgeolditems.asp" method="post">
		<table width=400 border=0 cellpadding="0" cellspacing="0">
		<tr><td>
		<table border=0 cellpadding="0" cellspacing="0" align="center">
		<tr>
		<td><input type=checkbox name="form_verified"></td>		
		<td width="5">&nbsp;</td>
		<td>Date:</td>
		<td width=5>&nbsp;</td>
		<td><select name="form_month">
		<%
			For i = 1 to 12 
				If i = Month(date) Then
					%><option value="<%= i %>" selected><%= i %></option><%
				Else
					%><option value="<%= i %>"><%= i %></option><%
				End If
			Next
		%>
		</select>
		</td>
		<td width=5>&nbsp;</td>
		                <td><strong>/</strong></td>
		<td width=5>&nbsp;</td>
		<td><select name="form_day">
		<%
			For i = 1 to 31 
				If i = Day(date) Then
					%><option value="<%= i %>" selected><%= i %></option><%
				Else
					%><option value="<%= i %>"><%= i %></option><%
				End If
			Next
		%>
		</select>
		</td>
		<td width=5>&nbsp;</td>		
		                <td><strong>/</strong></td>
		<td width=5>&nbsp;</td>		
		<td><select name="form_year">
		<%
			For i = 2000 to 2010 
				If i = Year(date) Then
					%><option value="<%= i %>" selected><%= i %></option><%
				Else
					%><option value="<%= i %>"><%= i %></option><%
				End If
			Next
		%>
		</select>
		</td>
		<td width="15">&nbsp;</td>
		<td><input type=submit name=cmdSubmit value="Purge Items"></td>
		</tr>
		</table>
		</td></tr></table>
		</form>
	<%
	Else
		i = 1
	
		objRS.Open "SELECT * FROM items WHERE active = '0' ORDER BY purge_date", objConn, 3, 3
		If objRS.EOF Then
			%><p>No items have been deleted but not purged in the database; nothing can be purged.</p><%
		Else
			objRS.MoveFirst
			%><p>Items deleted:</p>
			<table width=500 border=0>
			<tr>
                <td><div align="center"><strong>ID</strong></div></td>
                <td><div align="center"><strong>Name</strong></div></td>
                <td><div align="center"><strong>Last Price</strong></div></td>
                <td><div align="center"><strong>Description</strong></div></td>
              </tr>
			<%
			Do Until objRS.EOF
				If DateDiff("d", date, DateValue(objRS("purge_date"))) < 0 Then
					%><tr><td><%= objRS("item_id") %></td><td><%= objRS("item_name") %></td><td><%= "$" & objRS("item_price") %></td><td><%= left(objRS("description"), 40) & "..." %></td></tr><%
					objConn.Execute ("delete from items where item_id = '" & objRS("item_id") & "'")
				End If
				objRS.MoveNext
			Loop
			%></table><%
	
		End If
		objRS.Close
	End If

%>
<!-- #include virtual="/includes/footer_std.inc.html"-->
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>