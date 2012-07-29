<%
	item_id = CStr(Request.Form("item_id"))
	If item_id = "" Then
		%><p>Please select an item to remove from the database:</p><%
		objRS.Open "SELECT * FROM items WHERE active = 1", objConn
		If objRS.EOF Then
			Response.Write "<p>Unfortunately, no items exist in the database. </p>"
		Else
			objRS.MoveFirst
			%>
			<form action="deleteinventory.asp?page=deleteitem.asp" method=POST>
			<table width="361" border=0 cellpadding="0" cellspacing="0">
			<tr><td>Select an Item:</td>
			<td>
			<select name="item_id">
			<option value="">None.<strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</strong></option>
			<%			
			Do Until objRS.EOF
				Response.Write "<option value=" & objRS("item_id") & ">" & objRS("item_name") & "</option>" & vbCrLf
				objRS.MoveNext
			Loop
			%>			
			</select>
			</td></tr>
			<tr><td colspan="2">
			<input type=submit name=cmdSubmit value=Delete>
			</td></tr>
			</form>
			</table>
			<%
		End If	
		objRS.Close			
		
	Else

		objRS.Open "SELECT * FROM items WHERE item_id = " & item_id & " AND active = 1", objConn
		If objRS.EOF Then
			Response.Write "<p>You've selected an invalid item id, somehow.</p>"
		Else
		item_id = Request.Form("item_id")
			objRS.MoveFirst
			%>
			<p>Attributes of the item:</p>
			<ul>
			
			<li><strong>Item Name</strong>: <%=objRS("item_name")%></li>
			
			<li><strong>Item Price: </strong><%=objRS("item_price") %></li>
			
			<li><strong>Item Quantity:</strong> <%= objRS("quantity")%></li>
			
			<li><strong>Item Forsale:</strong> 
		    <%
			If objRS("for_sale") = 0 Then 
				Response.Write "No" 
			Else 
				Response.Write "Yes" 
			End If 
			%></li>
			
			<li><strong>Item Description:</strong> <%= objRS("description") %></li>
			<%
			class_id = objRS("class_id")
			objRS.Close
			objRS.Open "SELECT class_name FROM item_class WHERE class_id = " & class_id, objConn
			objRS.MoveFirst			
			%>			
			
			<li><strong>Item Category:</strong> <%= objRS("class_name") %></li>			
			</ul>		
		<%
			set objRS2 = Server.CreateObject("ADODB.Recordset")
			set objRS3 = Server.CreateObject("ADODB.Recordset")
			objRS2.Open "SELECT * FROM purchases WHERE item_id = " & item_id, objConn
			If objRS2.EOF Then
				%><p>This item is not part of an order.<%
			Else
				objRS2.MoveFirst
				%><p>This item is part of the following orders:</p><ul><%
				Do Until objRS2.EOF
					objRS.Open "SELECT * FROM orders WHERE order_id = " & objRS2("order_id"), objConn
					objRS.MoveFirst
					Do Until objRS.EOF
						objRS3.Open "SELECT * FROM users WHERE user_id = " & objRS("user_id"), objConn					
						objRS3.MoveFirst
						%><li><%= objRS3("first_name") %> <%= objRS3("last_name") %> - <%= objRS("order_date") %></li><%
						objRS3.Close
						objRS.MoveNext
					Loop
					objRS.Close
					objRS2.MoveNext
				Loop
				objRS2.Close		
			End If
			%>
			<p>Are you sure you want to delete this item? If so, click "delete" below.</p>
			<table width="40%" border="0">
			<tr><td><form action="viewinventory.asp" method="POST">
			<input type=submit name=cmdSubmitCancel value="Cancel">
			</form>
			</td><td>
			<form action="deleteitem_submit.asp" method=POST>
			<input type=hidden name="item_id" value="<%= item_id %>">
			<input type=submit name=cmdSubmitDelete value="Delete it.">
			</form>
			</td></tr>
			</table>
			<%
			set objRS2 = Nothing
			set objRS3 = Nothing
	
		End If
	End If
%>