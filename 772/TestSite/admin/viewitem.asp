<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>www.BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
<script src="/vwd_justsopw.js" language = "JavaScript"></script>
</head>
<body>
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/security.inc.asp" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->
<!-- #include virtual="/includes/header_std_close.inc.html" -->
<%
	item_id = Request("item_id")
	objRS.Open "SELECT * FROM items WHERE item_id = '" & item_id & "'", objConn	
	objRS.MoveFirst
	item_name = objRS("item_name")
	item_active = objRS("active")
	If objRS("for_sale") = 0 Then
		item_forsale = "No"
	Else
		item_forsale = "Yes"
	End If
	item_class = objRS("class_id")
	item_price = objRS("item_price")
	If objRS("active") = 0 Then
		item_active = "No"
	Else
		item_active = "Yes"
	End If
	item_description = objRS("description")
	item_quantity = objRS("quantity")
	objRS.Close
	objRS.Open "SELECT class_name FROM item_class WHERE class_id = " & item_class, objConn
	objRS.MoveFirst
	item_class = objRS("class_name")
	objRS.Close

	
%>
	<table width="100%" border="0" cellpadding="0" cellspacing="0" cols="2">
	<tr><td>
	  <table border="1" cellspacing="0" cellpadding="0">
	  <tr><td><strong>Item Name: </strong></td><td><%= item_name %></td></tr>
	 <tr><td><strong>Item Category:</strong></td><td> <%= item_class %></td></tr>
	 <tr><td><strong>Item Quantity:</strong></td><td> <%= item_quantity %></td></tr>
	  <tr><td><strong>Item Price:</strong></td><td> <%= item_price %></td></tr>
	  <tr><td><strong>Item For Sale:</strong></td><td> <%= item_forsale %></td></tr>
	  <tr><td><strong>Item Description:</strong></td><td><textarea rows=10 cols=40 readonly><%= item_description %></textarea> </td></tr>

	</table>
    </td>
	<td valign="middle">
	<%
	i = 0
		objRS.Open "SELECT * FROM item_pictures WHERE item_id = '" & item_id & "' ORDER BY primary_picture DESC", objConn
		If objRS.EOF Then
			%><p>Unfortunately, no images are linked for this item.</p><%
		Else
			%><p>Click on an image below to display the full image.  The primary picture will display the caption "Primary Picture" when you hover your mouse over it; to set an image as the primary image, go to the Edit Item page.</p><%
			objRS.MoveFirst
			Do Until objRS.EOF
				i = i + 1
'------- Use code below for just-so-popups... ------------------				
				%>
                  <a href="javascript:;" onClick="JustSoPicWindow('/item_images/<%= objRS("file_name") %>','width','height','* * Click window to close * * ','#','hug image','20')"
				  <% 
				If objRS("primary_picture") = 1 Then
					Response.Write " title=""Primary Picture"""
				End If
				%>
				> <img src="/item_images/<%= objRS("file_name") %>" width="80" height="80" border="0"></a> 
                  <%
'-------------------------
				If i = 3 Then
					i = 0
					response.write "<br>"
				End If
				
				objRS.MoveNext
			Loop
		End If	
	%>
	</td>
	</tr>
	<tr>
	<td colspan=2>
	<div align="center">
	<%
		If item_active = "Yes" Then
		%>
	<br>
	<table align="center" border="0" cellpadding="0" cellspacing="0">
	  <tr><td><form action="addinventory.asp?page=edititem.asp" method=post>
		<input type=hidden name="item_id" value="<%= item_id %>">
                      <input type=submit value="Edit Item" name=cmdSubmit2> &nbsp; 
                    </form></td>

		  <td><form action="deleteinventory.asp?page=deleteitem.asp" method=post>
		<input type=hidden name="item_id" value="<%= item_id %>">
		 &nbsp; <input type=submit value="Delete Item" name=cmdSubmit>
		</form></td>
	  </tr>
	</table>
		<%
		Else
		%>
		<form action="restoreitem_submit.asp" method=post>
		<input type=hidden name="item_id" value="<%= item_id %>">
		<input type=submit value="Restore Item" name=cmdSubmit>
		</form>
		<%
		End If
		%>
	</div>
	</td>
	</tr>
	</table>
	

<!-- #include virtual="/includes/footer_std.inc.html"-->
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>
