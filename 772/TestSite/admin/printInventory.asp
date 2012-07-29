<html>
<title>www.BCRocket.com - Admin</title>
<body>

<!-- #include virtual="/includes/db_open.inc.asp" -->
<%
	objRS.Open "SELECT * FROM items WHERE active = 1 ORDER BY item_name asc", objConn
	If objRS.EOF Then
		Response.Write "<p>Inventory is empty.</p>"
	Else
		objRS.MoveFirst
		%>
<table width=500 border=1 cellpadding="1" cellspacing="1">
  <tr> 
    <td width="200"><div align="left">Name</div></td>
    <td width="80"><div align="center">Quantity</div></td>
    <td width="80"><div align="center">Qty Sold,<br>
        not Shipped</div></td>
    <td width="70"><div align="center">Price</div></td>
    <td width="70"><div align="center">For Sale</div></td>
  </tr>
  <%
		Do Until objRS.EOF
		%>
  <tr> 
    <td><%= objRS("item_name") %></td>
    <td><div align="center"><%= objRS("quantity") %></div></td>
    <td><div align="center"><%= objRS("qty_pending") %></div></td>
    <td><div align="center"><%= objRS("item_price") %></div></td>
    <td> <div align="center"> 
        <%	If objRS("for_sale") = 0 Then
				Response.Write "No"
			Else
				Response.Write "Yes"
			End If
		%>
      </div></td>
  </tr>
  <%
  		objRS.MoveNext
		Loop
		%>
</table>
<%
	End If
	objRS.Close
%>
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>