<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>www.BCRocket.com Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
<script>
<!--
function setFocus() {
	document.Search_Form.Keywords.focus();
}
// -->
</script>
</head>
<body onLoad="setFocus()">
<!--#include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/header_std_close.inc.html" -->
<!--#include virtual="/includes/db_open.inc.asp" -->

<!--#include virtual="/includes/keyword_search_form.asp" -->

<!--#include virtual="/includes/category_search_form.asp" -->

<!--#include virtual="/includes/db_close.inc.asp" -->
<!--#include virtual="/includes/footer_std.inc.html" -->
</body>
</html>
