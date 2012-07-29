<!-- #include virtual="/includes/db_open.inc.asp" -->
<%
	objConn.Execute "UPDATE items SET active = 0 WHERE item_id = " & Request.Form("item_id") & ""
%>
<!-- #include virtual="/includes/db_close.inc.asp" -->
<%
	Response.Redirect("/admin/deleteinventory.asp?msg=deleteditem")
%>