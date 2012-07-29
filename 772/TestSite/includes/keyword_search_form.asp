<table width="100%" border="0">
	<tr align="center">
		<td>
			<%
			If (URL="/search.asp") Then
				Response.Write "<p><br>"
				Response.Write "<img src='/images/search_graphic.gif' border='0'>"
				Response.Write "</p>"
			End If
			%>

			<form name="Search_Form" action="keyword_search_results_init.asp" method="post">
			<p><br>
			<input name="Keywords" type="text" value="<%
			If (not (Request("Query") = "@null")) Then
				Response.Write Request("Query")
			End If
			%>" size="40">
			<br><br>
			<input type="submit" name="Submit_Search" value="Search!">
			&nbsp; 
			<input type="reset" name="Reset_Search" value="Reset">
			<br></p>

			<% If cLng(Session.Contents("intInvAdmin")) > 0 Then	%>
			<!-- Only for Administrator to see -->
			<p><input type="checkbox" name="Search_All" value=1 checked> Search ALL items (includes items that are not for sale)</p>
			<% End If	%>

			</form>

			<br>
		</td>
	</tr>
</table>