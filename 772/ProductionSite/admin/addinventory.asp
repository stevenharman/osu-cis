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
<span class="Header-Title-txt">Admin - Add / Update Inventory</span><br/>
<img src="/images/spacer.gif" width="50" height="1"><span class="Header-Subtitle-txt">- 
Something catchy goes here! -</span> 
<!-- #include virtual="/includes/header_admin_close.inc.html" -->

<% If Request("item_added") = "true" Then %>
<p><strong>Item added succesfully!</strong></p>
<% End If %>
<%
	page = Request("page")
	Select Case page
	Case "additem.asp"
		%><!-- #include virtual="/admin/additem.asp" --><%
	Case "addcategory.asp" 
		%><!-- #include virtual="/admin/addcategory.asp" --><%
	Case "addimages.asp"
		%><!-- #include virtual="/admin/addimages.asp" --><%
	Case "edititem.asp"
		%><!-- #include virtual="/admin/edititem.asp" --><%
	Case Else
		%><!-- #include virtual="/admin/additem.asp" --><%
	End Select
%>
<!-- #include virtual="/includes/footer_std.inc.html"-->
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>
