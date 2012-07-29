
<%
	item_id = Request.Form("item_id")
	If Not Cstr(item_id) = "" Then
		objRS.Open "SELECT * FROM items i, item_class c WHERE c.class_id = i.class_id AND item_id = " & Request.Form("item_id"), objConn
		objRS.MoveFirst
		%>
		<form action="edititem_submit.asp" method=POST>
		<input type=hidden name="item_id" value="<%= Request.Form("item_id") %>">
  <table width="361" border="1" cellspacing="0" cellpadding="0">
    <tr> 
	<td>
		<strong>Item Name:</strong> 
	</td>
	<td>
		<input type=text name=item_name value="<%= objRS("item_name") %>" size=10 maxlength=40>
	</td>	
		</tr><tr>	
	<td>
		<strong>Item Price:</strong> 
	</td>
	<td>
		<input type=text name=item_price value="<%= objRS("item_price") %>" size=10 maxlength=6>		
	</td>
		</tr><tr>
	<td>
		<strong>Item Quantity:</strong> 
	</td>
	<td>
		<input type=text name=quantity value="<%= objRS("quantity") %>" size=10 maxlength=3>				
	</td>	
		</tr><tr>
	<td>
		<strong>Item Forsale?</strong>
	</td>
	<td>
		 <input type=radio name=item_forsale value=0 <% If objRS("for_sale") = 0 Then Response.Write "checked"%>>No <input type=radio name=item_forsale value=1 <% If objRS("for_sale") = 1 Then Response.Write "checked" End If%>> Yes
	</td>
		</tr><tr>
	<td>
		<strong>Item Description:</strong> 
	</td>
	<td>
		<textarea rows=10 cols=40 name=item_description ><%= objRS("description") %></textarea>						
		
	</td>
		</tr><tr>
	<td>
		<strong>Item Class:</strong>
	</td>
	<td>		
		<select name="item_class">
		<%
		class_id = objRS("class_id")
		objRS.Close
		objRS.Open "SELECT * FROM item_class ORDER BY class_name", objConn
		objRS.MoveFirst
		Do Until objRS.EOF		
			%>
			<option value="<%= objRS("class_id") %>" <% If CInt(objRS("class_id")) = CInt(class_id) Then Response.Write "selected" End If%>><%= objRS("class_name") %></option>
			<%
			objRS.MoveNext
		Loop
		%>
		</select>
	</td>
</tr>
<tr><td colspan=2><div align="center"><input type=submit name=cmdSubmit value="Save Changes"></div></td></tr>
</table>
</form>
		<%
	Else
		%>
<!-- CODE FOR ERROR CHECKING --><%
	err_count = Request("err_count")	
	Response.Write "<ol>"
	If err_count >= 8 Then
		err_count = err_count - 8
		Response.Write "<li><strong>Error: </strong>Please select a non-empty item class.</li>"
	End If
	If err_count >= 4 Then
		err_count = err_count - 4
		Response.Write "<li><strong>Error: </strong>Quantity too low. Quantity must be 1 or greater.</li>"
	End If
	If err_count >= 2 Then
		err_count = err_count - 2
		Response.Write "<li><strong>Error: </strong>Price too low. Price must be at least $0.01</li>"
	End If
	If err_count >= 1 Then
		err_count = 0
		Response.Write "<li><strong>Error: </strong>All items must have a non-empty description.</li>"
	End If
	Response.Write "</ol>"
	%>
	<!-- END CODE FOR ERROR CHECKING -->

		<p>Select an item to edit:</p>
		<form action="../admin/addinventory.asp?page=edititem.asp" method=POST>

		<%
		objRS.Open "SELECT i.item_id, i.item_name FROM items i, item_class c WHERE active = 1 AND i.class_id = c.class_id ORDER BY class_name, item_id", objConn, 1, 3
		If Not objRS.EOF Then
			objRS.MoveFirst
			%>		<select name="item_id"><%
			Do Until objRS.EOF
				%>
				<option value="<%= objRS("item_id") %>"><%= objRS("item_name") %></option>
				<%
				objRS.MoveNext
			Loop
			%><input type=submit name=cmdSubmit value=Submit></select><%
		Else
			Response.Write "<p>Unfortunately no items exist in the database to edit.</p>"
		End If
		objRS.Close
		%></form><%
	End If
%>
