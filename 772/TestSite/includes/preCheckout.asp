<!-- #include virtual="includes/db_open.inc.asp" -->
<%

	'Problems still:
		'It seems that you have to click refresh for the items to update, 
		' probably preferable if a user didn't have to do this

	Dim strQ
	
	set objRS2 = Server.CreateObject("ADODB.RecordSet")
	Set objRS2.ActiveConnection = objConn
	
	
	'Selecting the items that the current user has added
	'Both placeOrder and invoice
	strQ = "SELECT item_number, item_qty FROM shopping_carts WHERE user_id = " & MemberID
	objRS.Open strQ, objConn
	
	'If the cart is empty then warn the user
	If objRS.EOF Then
	%>
		<table width="100%" border="1">
		<tr><td><b>You shopping cart is empty.</b></td></tr>
		</table>
	<%

	Else
		i=0
%>
	<hr>
	<table valign="top" align="center" width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr class="Body-Std-Bold-txt"> 
          <td nowrap>&nbsp;</td>
          <td nowrap><div align="center">Item Name</div></td>
          <td nowrap><div align="center">Unit Price</div></td>
          <td nowrap><div align="center">Quantity</div></td>
          <td nowrap><div align="center">Total Price</div></td>
        </tr>
<%
		Do Until objRS.EOF
			Response.Write "<tr>"

			'Get each individual item number's information
			strQ = "SELECT i.item_name, i.item_price, i.item_id, p.file_name FROM items i, item_pictures p WHERE (i.item_id = " & objRS("item_number") & ") AND (p.item_id = " & objRS("item_number") & ")"
			'strQ = "SELECT * FROM items i INNNER JOIN item_class c ON (i.class_id = c.class_id) LEFT OUTER JOIN item_pictures p ON (i.item_id = p.item_id) WHERE (p.primary_picture = '1') AND (i.item_id = 25)"
			' " & objRS(item_number) & ");"
			objRS2.Open strQ, objConn
			
			If i=0 Then
				i = i+1
%>
       			<tr class="Table_AltColor_1"> <!-- Dark Grey : #828282 -->
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
			Response.Write "</tr>"
			
			'Compute total price so far
			totalPrice = totalPrice + CDbl(objRS2("item_price")) * CDbl(objRS("item_qty"))
			objRS2.Close
			objRS.MoveNext
		Loop
			
%>		
		</table>
<%
	End If
	
	Response.Write "<hr>"
	Response.Write "<b><center>Total Price:  </b>"
	Response.Write "$" & totalPrice & "</center>"
%>

	<hr>
	<div align="right"> 
	<br><A href="cart_view_items.asp">Edit your shopping cart</A></br>
	<br><input name="Checkout" type="button" onClick="parent.location='invoice.asp'" value="Purchase Items in cart"></br>
	</div>
<%
	
	'End If
	'Close Database Connections
	Set objRS2 = Nothing
%>
<!-- #include virtual="includes/db_close.inc.asp" -->