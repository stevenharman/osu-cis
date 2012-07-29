	<form action="addimages_submit.asp" method=POST>
		<table width="361" border="1" cellspacing="0" cellpadding="0">
		<tr>
		<td width="40%">Select Image File:</td>
		<td>
		<select name="item_image">
		<%
			Set oFS = Server.CreateObject("Scripting.FileSystemObject")
			Set images_folder = oFS.GetFolder(Server.MapPath("/item_images/"))
			For Each File in images_folder.Files
				%><option value="<%= File.Name %>"><%= File.Name %></option><%
			Next
		%>
		</select>
		</td></tr>
		<tr>
		<td>Select Item to Link To:</td>
		<td>
		<%
		objRS.Open "SELECT * FROM items WHERE active = 1 ORDER BY item_id ASC", objConn
		If objRS.EOF Then
			Response.Write "<p>Sorry, no items to link to.</p>"
		Else
			Response.Write "<select name=item_id>"
			objRS.MoveFirst
			Do Until objRS.EOF
				Response.Write "<option value=" & objRS("item_id") & ">" & objRS("item_name") & "</option>" & vbCrLf
				objRS.MoveNext
			Loop
			Response.Write "</select>"
		End If
		objRS.Close
		%>

		</td></tr>
		<tr><td colspan="2"><div align="center"><input type=submit name=cmdsubmit value="Link Image"></div></td></tr>
<!--
		<td width="70%"><input type=file size=50 name="FILE1"></td></tr>
        <tr> <td>Select Item:</td><td><select name=itemname><option value=""></option><option value=1>Item 1 ObjName</option><option value=2>Item 2 ObjName</option></select>
           <input type="submit" name="Submit" value="Upload!"></td>
        </tr>
		-->
			          <tr align="center"> 
            
          <td colspan="2">&nbsp; </td>
          </tr>
	</table>		
  </form>
