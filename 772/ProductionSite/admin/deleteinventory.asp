<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>

<body>

	<!-- #include virtual="/includes/db_open.inc.asp" -->
	<!-- #include virtual="/includes/header_std_open.inc.html" -->
	Admin - Delete Inventory
	<!-- #include virtual="/includes/header_admin_close.inc.html" -->
	<%
	If Request("msg") = "deleteditem" Then
		%><P><strong>Item deleted succesfully. If you believe you've deleted an item in error, select "Restore Items" in the navigation under the "Delete Inventory" heading.</strong></P><%
	End If		
	page = Request("page")
	Select Case page
	Case "deleteitem.asp"
		%><!-- #include virtual="/admin/deleteitem.asp" --><%
	Case "deletecategory.asp"
		%><!-- #include virtual="/admin/deletecategory.asp" --><%
	Case "deleteimages.asp"
		%><!-- #include virtual="/admin/deleteimages.asp" --><%
	Case "restoreitem.asp"
		%><!-- #include virtual="/admin/restoreitem.asp" --><%
	Case Else
		%><!-- #include virtual="/admin/deleteitem.asp" --><%
	End Select

	%>
	<!--#include virtual="/includes/footer_std.inc.html"-->
	<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>
