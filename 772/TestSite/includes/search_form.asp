<table width="100%" border="1">
	<tr align="center">
		<td>
			<p><br>
			<img src="/images/search_graphic.gif" border="0">
			</p>

			<form name="Search_Form" action="search_results.asp" method="post">
			<p><br>
			<input name="Keywords" type="text" value="<% Response.Write Request.Form("Keywords") %>" size="40">
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