<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- #include virtual="/includes/db_open.inc.asp" -->
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<span class="Header-Title-txt">Admin - View Item</span><br/>
<img src="/images/spacer.gif" width="50" height="1"><span class="Header-Subtitle-txt">- 
Something catchy goes here! -</span> 
<!-- #include virtual="/includes/header_admin_close.inc.html" -->
<%
	item_id = Request("item_id")
	objRS.Open "SELECT * FROM items WHERE item_id = " & item_id, objConn	
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
	<p><strong>Item Name: </strong><%= item_name %></p>
	  <p><strong>Item Category:</strong> <%= item_class %></p>
	  <p><strong>Item Quantity:</strong> <%= item_quantity %></p>
	  <p><strong>Item Price:</strong> <%= item_price %></p>
	  <p><strong>Item For Sale:</strong> <%= item_forsale %></p>
	  <p><strong>Item Description:</strong> <%= item_description %></p>
    </td>
	<td valign="middle">
	<%
	i = 0
		objRS.Open "SELECT * FROM item_pictures WHERE item_id = " & item_id, objConn
		If objRS.EOF Then
			%><p>Unfortunately, no images are linked for this item.</p><%
		Else
			%><p>Click on an image below to display the full image.</p><%
			objRS.MoveFirst
			Do Until objRS.EOF
				i = i + 1
				%>
				<a href="/admin/viewitem_displayimage.asp?filename=<%= objRS("file_name") %>" target="_blank">
					<img src="/item_images/<%= objRS("file_name") %>" width="80" height="80" align="">
				</a>
				<%
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
		<form action="addinventory.asp?page=edititem.asp" method=post>
		<input type=hidden name="item_id" value="<%= item_id %>">
		<input type=submit value="Edit Item" name=cmdSubmit>
		</form>

		<form action="deleteinventory.asp?page=deleteitem.asp" method=post>
		<input type=hidden name="item_id" value="<%= item_id %>">
		<input type=submit value="Delete Item" name=cmdSubmit>
		</form>
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
