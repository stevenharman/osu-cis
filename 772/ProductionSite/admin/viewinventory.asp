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
<span class="Header-Title-txt">Admin - View Inventory</span><br/> 
<img src="/images/spacer.gif" width="50" height="1">
<span class="Header-Subtitle-txt">- 
Something catchy goes here! -
</span> 
<!-- #include virtual="/includes/header_admin_close.inc.html" --> <%



	objRS.Open "SELECT p.file_name, i.item_name, c.class_name, i.for_sale, "_
	&  		"i.item_price, i.quantity, i.item_id FROM items i, "_
	&		"item_pictures p, item_class c WHERE i.class_id = c.class_id "_
	&		"AND i.active = 1 AND p.item_id = i.item_id	GROUP BY i.item_id ORDER BY "_
	&		"i.for_sale DESC, c.class_name ASC, i.item_name ASC", objConn
	If objRS.EOF Then
		%>
      <p>No items with photos linked to view.</p>
      <%
	Else
		objRS.MoveFirst
		%> <p>Click on a thumbnail to view an items full details.</p>
		<p>Items with photos:</p>
      <table width="98%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="70"><div align="center"><strong>Thumbnail</strong></div></td>
          <td><div align="center"><strong>Item Name</strong></div></td>
          <td><div align="center"><strong>Category</strong></div></td>
          <td><div align="center"><strong>For Sale</strong></div></td>
          <td><div align="center"><strong>Price</strong></div></td>
          <td><div align="center"><strong>Quantity</strong></div></td>
		  <td><div align="center"><strong>Links</strong></div></td>
        </tr>
        <%
		Do Until objRS.EOF
		last_id = -1
		If Not (CINT(objRS("item_id")) = last_id) Then
		last_id = objRS("item_id")
			If i = 0 Then
				i = i + 1
				%>
        <tr bgcolor="#CC0033">
          <%
			Else
				i = 0
				%>
        <tr bgcolor="#999999">
          <%
			End If
		%>
          <td height="70"><div align="center"><a href="viewitem.asp?item_id=<%= objRS("item_id") %>"><img src="/item_images/<%= objRS("file_name") %>" height="64" width="64"></a></div></td>
          <td><div align="center"><%= objrs("item_name") %></div></td>
          <td><div align="center"><%= objrs("class_name") %></div></td>
          <td><div align="center"> 
              <%  If objRS("for_sale") = 0 Then
				Response.Write "No"
			Else
				Response.Write "Yes"
			End If
		%>
            </div></td>
          <td><div align="center">$<%= objrs("item_price") %></div></td>
          <td><div align="center"><%= objrs("quantity") %></div></td>
		  <td><div align="center"><form action="/admin/addinventory.asp?page=edititem.asp" method="post"><input type=hidden name=item_id value="<%= objRS("item_id") %>"><input type=submit name=cmdSubmit value=Edit></form><form action="deleteinventory.asp" method=POST><input type=hidden name=item_id value="<%= objRS("item_id")%>"><input type=submit name=submit value=Delete></form></div></td>
        </tr>
      <%
		End If
		objRS.MoveNext

		Loop
		%></table><%
	End If
	
	objRS.Close
	objRS.Open "SELECT i.item_name, c.class_name, i.for_sale, "_
	&  		"i.item_price, i.quantity, i.item_id, ip.file_name FROM items i, item_class c "_
	&		"LEFT JOIN item_pictures ip ON i.item_id = ip.item_id WHERE i.class_id = c.class_id AND "_
	&		"i.active = 1 AND ip.file_name IS NULL ORDER BY i.for_sale DESC, "_
	&		"c.class_name ASC, i.item_name ASC", objConn
	If objRS.EOF Then
		%><p>No items without pictures to view.</p><%
	Else
	 %>
	 <p>Items without photos:</p>
	<table width="98%" border="0" cellpadding="0" cellspacing="0">
        <tr> 
          <td height="70"><div align="center"><strong>Item Name</strong></div></td>
          <td><div align="center"><strong>Category</strong></div></td>
          <td><div align="center"><strong>For Sale</strong></div></td>
          <td><div align="center"><strong>Price</strong></div></td>
          <td><div align="center"><strong>Quantity</strong></div></td>
		  <td><div align="center"><strong>Links</strong></div></td>
        </tr>
	<%
	     
		Do Until objRS.EOF
			If i = 0 Then
				i = i + 1
				%>
        <tr bgcolor="#CC0033">
          <%
			Else
				i = 0
				%>
        <tr bgcolor="#999999">
          <%
			End If
		%>
          <td><div align="center"><%= objrs("item_name") %></div></td>
          <td><div align="center"><%= objrs("class_name") %></div></td>
          <td><div align="center"> 
              <%  If objRS("for_sale") = 0 Then
				Response.Write "No"
			Else
				Response.Write "Yes"
			End If
		%>
            </div></td>
          <td><div align="center">$<%= objrs("item_price") %></div></td>
          <td><div align="center"><%= objrs("quantity") %></div></td>
		  <td><div align="center"><form action="/admin/addinventory.asp?page=edititem.asp" method="post"><input type=hidden name=item_id value="<%= objRS("item_id") %>"><input type=submit name=cmdSubmit value=Edit></form><form action="deleteinventory.asp" method=POST><input type=hidden name=item_id value="<%= objRS("item_id")%>"><input type=submit name=submit value=Delete></form></div></td>
        </tr>
      <%
		objRS.MoveNext
		Loop
	Response.Write "</table>"
	End If

	objRS.Close
	
%> <!-- #include virtual="/includes/footer_std.inc.html"-->
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>
