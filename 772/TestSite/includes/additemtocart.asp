<!-- #include virtual="/includes/db_open.inc.asp" -->
<%

	item_id = Request.Form("item_id")
	user_id = Request.Form("user_id")
	item_qty = Request.Form("item_qty")
	item_qty2 = item_qty
	objRS.Open "SELECT item_price FROM items WHERE item_id = '" & item_id & "'", objConn
	objRS.MoveFirst
	item_price = objRS("item_price")
	objRS.Close
	
	objRS.Open  "SELECT * FROM shopping_carts WHERE item_number = '" & item_id & "' AND "_
			&	"user_id = '" & user_id & "'", objConn
	
	If objRS.EOF Then
		str_query = "INSERT INTO shopping_carts ( `user_id` , "_
				&	"`item_number` , `item_qty` ) VALUES ("_
				&	"'" & user_id & "','" & item_id & "','" & item_qty & "');"
		Session.Contents("Cart_TotItems") = Session.Contents("Cart_TotItems") + cint(item_qty)
		Session.Contents("Cart_TotPrice") = Session.Contents("Cart_TotPrice") + cdbl(item_qty) * cdbl(item_price)				
		objConn.Execute(str_query)
	Else
		set objRS2 = Server.CreateObject("ADODB.RecordSet")
		objRS.MoveFirst
		item_qty = item_qty + CInt(objRS("item_qty"))
		objRS2.Open "SELECT * FROM items WHERE item_id = '" & item_id & "'", objConn
		objRS2.MoveFirst
		qty_in_db = objRS2("quantity") - objRS2("qty_pending")
		If item_qty <= qty_in_db Then
			str_query = "UPDATE shopping_carts SET item_qty = '"_
					 & item_qty & "' WHERE user_id = '" & user_id & "' AND "_
					 & "item_number = '" & item_id & "';"
			Session.Contents("Cart_TotItems") = Session.Contents("Cart_TotItems") + cint(item_qty2)
			Session.Contents("Cart_TotPrice") = Session.Contents("Cart_TotPrice") + cdbl(item_qty2) * cdbl(item_price)					 
			objConn.Execute(str_query)
		Else
			item_qty = qty_in_db
			str_query = "UPDATE shopping_carts SET item_qty = '"_
					 & item_qty & "' WHERE user_id = '" & user_id & "' AND "_
					 & "item_number = '" & item_id & "';"
			objConn.Execute(str_query)
		End If
			
	End If
	objRS.Close
%>
<!-- #include virtual="/includes/db_close.inc.asp" -->
<%
	If Request.Form("referring_querystring") = "" Then
		Response.Redirect(request.form("referring_url"))
	Else
		Response.Redirect(request.form("referring_url") & "?" & Request.Form("referring_querystring"))
	End If
%>