<form action="../admin/additem_submit.asp" method=POST>
<!-- CODE FOR ERROR CHECKING --><%
	err_count = Request("err_count")	
	Response.Write "<ol>"
	If err_count >= 8 Then
		err_count = err_count - 8
		Response.Write "<li><strong>Error: </strong>Please select a non-empty item class.</li>"
	End If
	If err_count >= 4 Then
		err_count = err_count - 4
		Response.Write "<li><strong>Error: </strong>Quantity too low. Quantity must be 0 or greater.</li>"
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

  <table width="361" border="1" cellspacing="0" cellpadding="0">
    <!--DWLayoutTable-->
    <tr> 
      <td height="26" colspan="2" valign="top">Category</td>
      <td width="221" valign="top"> <%
			objRS.Open "SELECT * FROM item_class ORDER BY class_name ASC", objConn
			If Not(objRS.EOF) Then
				objRS.MoveFirst
				%> <select name="item_class">
          <%
				Do Until objRS.EOF				
					%>
          <option value="<%= objRS("class_id") %>" <%
					If Not(Session("item_class") = "") Then
						If (CInt(Session("item_class")) = CInt(objRS("class_id"))) Then 
							Response.Write " SELECTED"
						End If 
					End If
					%>
					><%= objRS("class_name") %></option>
          <%
					objRS.MoveNext
				Loop

				%>
        </select> </td>
    </tr>
    <tr> 
      <td height="24" colspan="2" valign="top">Item Name:</td>
      <td valign="top"><input type=text size="30" maxlength="60" name="item_name" value="<%= Session("item_name") %>"></td>
    </tr>
    <tr> 
      <td height="40" colspan="2" valign="top">Primary Image:</td>
      <td valign="top"> <select name="item_image">
          <option value=""></option>
          <%
		Set oFS = Server.CreateObject("Scripting.FileSystemObject")
		Set images_folder = oFS.GetFolder(Server.MapPath("/item_images/"))
		For Each File in images_folder.Files
			%>
          <option value="<%= File.Name %>"<%
			If File.Name = Session("item_image") Then
				Response.Write " selected"
			End If
			%>><%= File.Name %></option>
          <%
		Next
	%>
        </select> </td>
    </tr>
    <tr> 
      <td height="24" colspan="2" valign="top">Quantity</td>
      <td valign="top"><input type="text" name="item_quantity" value="<%= Session("item_quantity") %>"></td>
    </tr>
    <tr> 
      <td  colspan="2" valign="top">Price (dd.cc, no $)</td>
      <td valign="top"><input type="text" name="item_price" value="<%= Session("item_price") %>"></td>
    </tr>
    <tr> 
      <td colspan="2" valign="top">For Sale</td>
      <td valign="top"> <% 
	If Not (Session("item_forsale") = "") Then
		If (Session("item_forsale") = 0) Then 
			%> <input type="radio" name="item_forsale" value="1">
        Yes <br> <input type="radio" name="item_forsale" value="0" checked>
        No 
        <% 
		Else
		%> <input type="radio" name="item_forsale" value="1" checked>
        Yes <br> <input type="radio" name="item_forsale" value="0">
        No 
        <% 
		End If		
		
	Else
		%> <input type="radio" name="item_forsale" value="1" checked>
        Yes <br> <input type="radio" name="item_forsale" value="0">
        No 
        <% 
	End If 
	  %> </td>
    </tr>
    <tr> 
      <td width="79" height="184">Description</td>
      <td colspan="2"><textarea name="item_description" rows=10 cols=40><%= Session("item_description") %></textarea></td>
    </tr>
    <tr align="center"> 
      <td height="26" colspan="3"> <input type="submit" name="cmdSubmit-AddItem" value="Submit Item"> 
      </td>
    </tr>
    <%
			Else
				%>
    <p>No categories exist; please add a category before adding items.</p>
	<% End If %>
    <tr> 
      <td height="6"></td>
      <td></td>
      <td></td>
  </table>
</form>
