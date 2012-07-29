<!-- #include virtual="/includes/db_open.inc.asp" -->

<%
	num_items = Cint(Request.Form("num_items"))
	For i = 1 to num_items
		item_id = Cint(Request.Form("item_id_" & i))
		item_qty = Cint(Request.Form("item_qty_" & i))
		user_id = Cint(Request.Form("user_id"))
		If item_qty <= 0 Then
			objConn.Execute("DELETE FROM shopping_carts WHERE user_id = '" & user_id & "' AND item_number = '" & item_id & "'")			
		Else
			objRS.Open "SELECT * FROM items WHERE item_id = '" & item_id & "'", objConn
			objRS.MoveFirst
			qty_in_db = objRS("quantity") - objRS("qty_pending")
			If item_qty <= qty_in_db Then
				objConn.Execute("UPDATE shopping_carts SET item_qty = '" & item_qty & "' WHERE user_id = '" & user_id & "' AND item_number = '" & item_id & "'")
			Else				
				objConn.Execute("UPDATE shopping_carts SET item_qty = '" & qty_in_db & "' WHERE user_id = '" & user_id & "' AND item_number = '" & item_id & "'")
			End If
			objRS.close
			'ABOVE LINE ADDED BY STEVE because I was getting an error:
			'
			'ADODB.Recordset error '800a0e79' 
			'Operation is not allowed when the object is open. 
			'/updatecartquantities.asp, line 13 

		End If
	Next
	'Need to update the Session Variables for the navbar Shopping Cart display
	'the variable "MemberID" is needed by the navbar_getCartValues.asp fileS
	MemberID = Request.Form("user_id")	
%>
<!--#include virtual="/includes/navbar_getCartValues.asp" -->

<!-- #include virtual="/includes/db_close.inc.asp" -->
<%	
	Response.Redirect("/cart_view_items.asp")
	%>