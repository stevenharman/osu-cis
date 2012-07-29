<!-- #include virtual="includes/db_open.inc.asp" -->
<%
	'Problems still:
		'How to update qty_pending in items table
		'How to give a date to orders_pending table
		'Get Mark's PayPal email address
		'Make it look pretty :)

	set objRS2 = Server.CreateObject("ADODB.RecordSet")
	Session("Cart_TotItems") = 0
	Session("Cart_TotPrice") = "0.00"
	
	'Selecting the items that the current user has added
	'Both placeOrder and invoice
	strQ = "SELECT item_number, item_qty FROM shopping_carts WHERE user_id = " & MemberID
	objRS.Open strQ, objConn, 1, 3
	
	'If the cart is empty then warn the user
	If objRS.EOF or objRS.BOF Then
		Response.Write "<table width='100%' border='1'>"
		Response.Write "<tr><td><b>You shopping cart is empty.</b></td></tr>"
		Response.Write "</table>"

	Else
		
		'Add in that this is the Invoice of sale here
		Response.Write "<h1><center>Invoice of Sale</center></h1>"
%>
	<table valign="top" align="center" width="100%" border="0" cellpadding="2" cellspacing="0">
        <tr class="Body-Std-Bold-txt"> 
          <td nowrap>&nbsp;</td>
          <td nowrap><div align="center">Item Name</div></td>
          <td nowrap><div align="center">Unit Price</div></td>
          <td nowrap><div align="center">Quantity</div></td>
          <td nowrap><div align="center">Item Total Price</div></td>
        </tr>

<%
		objRS.MoveFirst
		Do Until objRS.EOF
			'Response.Write "<tr>"

			'Get each individual item number's information
			strQ = "SELECT i.item_name, i.item_price, i.item_id, i.qty_pending, p.file_name FROM items i, item_pictures p WHERE (i.item_id = " & objRS("item_number") & ") AND (p.item_id = " & objRS("item_number") & ")"
			'strQ = "SELECT * FROM items i INNNER JOIN item_class c ON (i.class_id = c.class_id) LEFT OUTER JOIN item_pictures p ON (i.item_id = p.item_id) WHERE (p.primary_picture = '1') AND (i.item_id = 25)"
			' " & objRS(item_number) & ");"
			objRS2.Open strQ, objConn
			
			If i=0 Then
				i = i+1
%>
       			<tr class="Table_AltColor_1">
<%
			Else
				i = 0
%>
        		<tr class="Table_AltColor_2"> 
<%
			End If			
		
			'Write to table
%>
			 <td width="70" height="70" align="center"><a href="/view_item_details.asp?item_id=<%= objRS2("item_id") %>"><img src="/item_images/<%= objRS2("file_name") %>" height="64" width="64" border="0"></a></td>
<%
 			Response.Write "<td><center>" & objRS2("item_name") & "</center></td>"
			'Response.Write "<td><center>" & objRS2("item_id") & "</center></td>"
			Response.Write "<td><center>$" & objRS2("item_price") & "</center></td>"
			Response.Write "<td><center>" & objRS("item_qty") & "</center></td>"
			qty_price = CDbl(objRS("item_qty")) * CDbl(objRS2("item_price"))
			Response.Write "<td><center>" & qty_price & "</center></td>"
%>				</tr>

<%
			
			'Compute total price so far
			totalPrice = totalPrice + CDbl(objRS2("item_price")) * CDbl(objRS("item_qty"))
			
			'Compute total quantity
			totalQty = totalQty + CDbl(objRS("item_qty"))
			
			'Update qty_pending in items table (qty_pending = qty_pending + objRS("item_qty") )
			'objRS2("qty_pending") = CDbl(objRS2("qty_pending")) + CDbl(objRS("item_qty"))
			'objRS2("qty_pending") = updatedQTYP
			'objRS.Update
			
			
			objRS2.Close
			objRS.MoveNext
		Loop
			
		'output the total price at the bottom of the table
		Response.Write "<hr><td></td><td></td><td></td>"
		Response.Write "<td><center><b>Total Quantity: </b></center></td>"
		Response.Write "<td><center><b>Total Price:  </b></center></td></tr>"
		
		Response.Write "<tr><td></td><td></td><td></td>"
		Response.Write "<td><center><b>" & totalQty & " </b></center></td>"
		Response.Write "<td><center><b>$" & totalPrice & " </b></center></td>"
		Response.Write "</tr>"
		
		Response.Write "</table>"
	End If
	
		'Add order to orders_pending table
		dim todayDate
		todayDate = date
		strI = "INSERT into orders_pending(order_number, user_id, date_placed, paymentmethod) values (NULL, '" & MemberID & "', '" & todayDate & "','" & Request.Form("paymentmethod") & "');"
		objConn.Execute(strI)
		
		'Move items from items table to orders_itemlist
			'Get order number
			objRS2.Open "SELECT MAX(order_number) FROM orders_pending", objConn, 1, 3
	'		max_ordernum = objRS2(0)
	'		objRS2.Close
	'		strQ = "SELECT order_number FROM orders_pending WHERE date_placed = '" & todayDate &  "' AND user_id = '" & MemberID & "' LIMIT 1;"
	'		objRS2.Open strQ, objConn
			
			orderNumber = objrs2(0)
			'objRS2("order_number")
			
			'For each item in the shopping cart, add it to orders_itemlist
			objRS.Close
			objRS.Open "SELECT item_number, item_qty FROM shopping_carts WHERE user_id = '" & MemberID & "'", objConn
			objRS.MoveFirst
			Do Until objRS.EOF
				strI = "INSERT into orders_itemlist values (" & orderNumber & ", " &  objRS("item_number") & ", " &  objRS("item_qty")  & ");"
				objConn.Execute(strI)
				set objRS3 = Server.CreateObject("ADODB.RecordSet")
				objRS3.Open "SELECT * FROM items WHERE item_id = '" & objRS("item_number") & "'", objConn
				objRS3.MoveFirst
				qty_in_db_pending = objRS3("qty_pending")
				objConn.Execute("UPDATE items SET qty_pending = '" & qty_in_db_pending + objRS("item_qty") & "' WHERE item_id = '" & objRS("item_number") & "'")
				objRS3.Close
				set objRS3 = Nothing
				objRS.MoveNext
			Loop
			
		'Remove items from shopping cart
		strQ = "DELETE FROM shopping_carts WHERE user_id = '" & MemberID & "'"
		objConn.Execute(strQ)
				
		objRS2.Close
		strQ = "SELECT M_CITY, M_STATE, M_ADDR1, M_ADDR2, M_ZIP, M_FIRSTNAME, M_LASTNAME FROM forum_members WHERE (MEMBER_ID = " & MemberID & ");"
		objRS2.Open strQ, objConn
		
		Response.Write "Your purchase will be shipped to:<br>" _
		& objRS2("M_FIRSTNAME") & " " & objRS2("M_LASTNAME") & "<br>" _
		& objRS2("M_ADDR1") & " " & objRS2("M_ADDR2") & "<br>" _
		& objRS2("M_CITY") & ", " & objRS2("M_STATE") & " " & objRS2("M_ZIP") & "<br>"
		
		Response.Write "<br>For your refrence your order number is: <br>" & orderNumber & "<br>"
		
		Response.Write "<br>Your order has been received. This is your invoice.  Please save this for your records. </br>"
		If Request.Form("paymentmethod") = "paypal" Then
			Response.Write "<br>To pay for your order, you have selected Paypal. A link is located below for your convenience:<br>"
			%>
		
			<form action="https://www.paypal.com/cgi-bin/webscr" method="post"> 
			<input type="hidden" name="cmd" value="_xclick"> 
			<input type="hidden" name="business" value="bcdevine@sbcglobal.net"> 
			<input type="hidden" name="item_name" value="BCRocket.com Purchase"> 
			<input type="hidden" name="item_number" value="
			
			<%
			Response.Write orderNumber
			%>	
			"> 
			<input type="hidden" name="amount" value="
			<%
			Response.Write totalPrice
			%>	
			"> 
			<input type="hidden" name="no_note" value="1"> 
			<input type="hidden" name="currency_code" value="USD"> 
			<input type="hidden" name="lc" value="US"> 
			<input type="image" 
			src="https://www.paypal.com/en_US/i/btn/x-click-but23.gif" border="0" 
			name="submit" alt="Make payments with PayPal - it's fast, free and 
			secure!"> 
			</form>

		<%	 
		 Else
		 	 Response.Write "As your form of payment you have selected " & Request.Form("paymentmethod") & ". Please mail to:"_
		 & "<br>DeVine Enterprises"_
		 & "<br>PO Box 14357"_
		 & "<br>Columbus, Ohio 43214"
   		End If	
	'Close Database Connections
	Set objRS = Nothing
	Set objRS2 = Nothing
	Set objConn = Nothing
	End If
%>