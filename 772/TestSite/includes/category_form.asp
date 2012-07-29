<table width="100%" border="1">
	<tr align="center">
		<td><b>Browse Categories</b></td>	
	</tr>
</table>

<table width="100%" border="1">
	<tr align="center">
	<%
		strQ = "SELECT * FROM item_class c"

		objRS.Open strQ, objConn

		If (objRS.EOF = false) Then
			objRS.MoveFirst
			Do Until objRS.EOF

				Response.Write "<td>"				
				Response.Write "<a href='/search_results.asp?Keywords=" & objRS("class_name") & "'>" & objRS("class_name") & "</a>"
				Response.Write "</td>"
				objRS.MoveNext
			
			Loop
			objRS.MoveFirst
		End If
	
		objRS.Close
	%>
	</tr>
</table>