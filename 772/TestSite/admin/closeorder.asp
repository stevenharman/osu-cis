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
		query = "INSERT INTO orders_completed(user_id,order_number,"_
		 	& "date_placed,date_shipped,shipping_method,tracking_number,"_
			& "place_of_sale,user_name) VALUES ('" & MemberID & "','" & Request.Form("order_number")_
			& "','" & Request.Form("date_placed") & "','" & Request.Form("ship_date")_
			& "','" & Request.Form("shipping") & "','" & Request.Form("tracking")_
			& "','" & Request.Form("venue") & "','" & Request.Form("user_name") & "');"
		objConn.Execute(query)
		
		objRS.Open "SELECT * FROM orders_itemlist WHERE order_number = '" & Request.Form("order_number") & "'", objConn
		objRS.MoveFirst
		set objRS2 = Server.CreateObject("ADODB.RecordSet")
		Do Until objRS.EOF
			objRS2.Open "SELECT * FROM items WHERE item_id = '" & objRS("item_number") & "'", objConn, 1, 3
			objRS2.MoveFirst
			query = "INSERT INTO orders_completed_itemlist(order_number, item_id,"_
					& "item_name, quantity, price) VALUES ('" & Request.Form("order_number")_
					& "','" & objRS2("item_id") & "','" & objRS2("item_name")_
					& "','" & objRS("item_quantity") & "','" & objRS2("item_price") & "');"
			objConn.Execute(query)
			item_id = objRS2("item_id")
			
			If (objRS2("quantity") - objRS("item_quantity")) = 0 Then
				objRS2.Close
				objConn.Execute("UPDATE items SET quantity = '0' AND active = '0'"_
								& " WHERE item_id = '" & item_id & "'")
			Else
				objRS2("quantity") = Cint(objRS2("quantity")) - Cint(objRS("item_quantity"))
				objRS2.Update
				objRS2.Close
			End If

			query = "DELETE FROM orders_itemlist WHERE order_number = '"_
					& Request.Form("order_number") & "' AND item_number ='"_
					& item_id & "'"
			objConn.Execute(query)					
			objRS.MoveNext
		Loop
		objRS.Close
		set objRS2 = Nothing
		order_number = Request.Form("order_number")
		objRS.Open "SELECT * FROM orders_completed WHERE order_number = '" & order_number & "'", objConn
		objRS.MoveFirst
	%>	
<table width="100%" border=0 cellpadding="0" cellspacing="0">
<tr><td>
<table width="500" border=0>
<tr><td width=25></td><td><strong>User: </strong></td><td colspan=3><%= objRS("user_name") %></td></tr>
<tr><td></td><td><strong>Order Number:</strong></td><td colspan=3><%= order_number %></td></tr>
<tr><td></td><td><strong>Place of Sale:</strong></td><td colspan=3><%= objRS("place_of_sale") %></td></tr>
<tr><td></td><td><strong>Date Placed:</strong></td><td colspan=3><%= objRS("date_placed") %></td></tr>
<tr><td></td><td><strong>Date Shipped:</strong></td><td colspan=3><%= objRS("date_shipped") %></td></tr>
<tr><td></td><td><strong>Shipping Method:</strong></td><td colspan=3><%= objRS("shipping_method") %></td></tr>
<tr><td></td><td><strong>Tracking Number:</strong></td><td colspan=3><%= objRS("tracking_number") %></td></tr>
<%
	objRS.Close
	objRS.Open "SELECT * FROM orders_completed_itemlist WHERE order_number = '" & order_number & "'", objConn
	objRS.MoveFirst
	i = 1
	total_price = 0.0
	Do Until objRS.EOF
		%>
		<tr><td></td>
                <td><strong>Item #<%= i %></strong></td><td><%= objRS("quantity") %>x <%= objRS("item_name") %> @$<%= objRS("price") %> each.</td></tr>
		<%
		total_price = total_price + CDbl(objRS("quantity")) * CDBl(objRS("price"))
		i = i + 1
		objRS.Movenext
	Loop
%>
</table>
</td></tr>
</table>
<!-- #include virtual="/includes/footer_std.inc.html"-->
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>