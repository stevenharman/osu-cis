<!-- #include virtual="/includes/db_open.inc.asp" -->
<%
	objRS.Open "SELECT * FROM item_pictures WHERE item_id = '" & Request.Form("item_id") & "' AND file_name = '" & Request.Form("item_image") & "'", objConn, 1, 3
	If objRS.EOF Then
		objRS.AddNew
		objRS("item_id") = Request.Form("item_id")
		objRS("file_name") = Request.Form("item_image")
		objRS.Update
	End If
	objRS.Close
	Response.Redirect("addinventory.asp?page=addimages.asp")
%>
<!-- #include virtual="/includes/db_close.inc.asp" -->