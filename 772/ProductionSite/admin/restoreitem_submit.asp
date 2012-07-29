<!-- #include virtual="/includes/db_open.inc.asp" -->
<%
	objConn.Execute("UPDATE items SET active = 1 WHERE item_id = '" & Request.Form("item_id") & "'")
	Response.Redirect("viewitem.asp?item_id=" & Request.Form("item_id"))
%>
<!-- #include virtual="/includes/db_close.inc.asp" -->