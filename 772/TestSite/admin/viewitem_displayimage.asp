<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>View Image <%= Request("filename") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<%
' The following three #include files are need to protect this page from being seen my non Inventory Admins
'
' If this page is ever set up to also include the standard "/includes/header_std_open.inc.html" file, then 
' remove these two #inlcude statements
'
%>
<!-- include virtual="/forum/config.asp" -->
<!-- include virtual="/forum/inc_func_common.asp" -->
<%
' The following #include is needed to block non Inventory Admins from accessing this page
%>
<!-- include virtual="/includes/security.inc.asp" -->


<img src="/item_images/<%= Request("filename")%>">
</body>
</html>