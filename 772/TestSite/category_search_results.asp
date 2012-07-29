<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>www.BCRocket.com Search Results</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/header_std_close.inc.html" -->
<!--#include virtual="/includes/db_open.inc.asp" -->

<!--#include virtual="/includes/keyword_search_form.asp" -->
		
<%
	item_limit_per_page = 10
	search_type = "category"

	category = Request("Category")

	search_all = Int(Request("SA"))

	page_string = Request("Page")
	pages = Split(page_string, "-")
	current_page = Int(pages(0))
	last_page = Int(pages(1))
%>

<!--#include virtual="/includes/category_create_query.asp" -->

<!--#include virtual="/includes/display_results_size.asp" -->

<%
	start_limit = (current_page * item_limit_per_page) - item_limit_per_page
	end_limit = (current_page * item_limit_per_page)
	strQ = strQ & " LIMIT " & start_limit & ", " & item_limit_per_page
%>

<!--#include virtual="/includes/search_results.asp" -->

<%
	iteration_num = 1

	Response.Write "<table width='100%' border='0'><tr align='center'><td><br><b>Results Page: </b>"
	If (current_page > 1) Then
		Response.Write "<a href='/category_search_results.asp?SA=" & search_all & "&Page=" & current_page - 1 & "-" & last_page & "&Category=" & category & "'>Prev</a> "
	End If

	While (iteration_num <= last_page)
		If (iteration_num = current_page) Then
			Response.Write "<u>" & iteration_num & "</u> "
		Else
			Response.Write "<a href='/category_search_results.asp?SA=" & search_all & "&Page=" & iteration_num & "-" & last_page & "&Category=" & category & "'>" & iteration_num & "</a> "
		End If
		iteration_num = iteration_num + 1
	Wend

	If (current_page < last_page) Then
		Response.Write "<a href='/category_search_results.asp?SA=" & search_all & "&Page=" & current_page + 1 & "-" & last_page & "&Category=" & category & "'>Next</a>"
	End If
	Response.Write "<br><br></td></tr></table>"
%>

<!--#include virtual="/includes/db_close.inc.asp" -->
<!--#include virtual="/includes/footer_std.inc.html" -->
</body>
</html>