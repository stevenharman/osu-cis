<%
	err_count = Request("err_count")
	Response.Write "<ol>"
	If err_count >= 1 Then
		Response.Write "<li><strong>Error: </strong>Category's must have non-empty names.</li>"
	End If
	If Request("cat_added") = "true" Then
		Response.Write "<p><strong>Category added succesfully!</strong></p>"
	End If
	Response.Write "</ol>"
	%>
	
    <table width="361" border="1" cellspacing="0" cellpadding="0">
	            <tr> 
            <td width="30%">New Category</td>
            <td width="70%">
			<form action="addcategory_submit.asp" method=POST>
			<input type="text" name="category_name">
            <input type="submit" name="cmdSubmit-AddCategory" value="Add Category">
			</form>
			</td>
			
          </tr>
		            <tr align="center"> 
            
          <td colspan="2">&nbsp; </td>
          </tr>
	</table>
