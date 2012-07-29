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
	search_type = "keyword"

	search_all = Int(Request("SA"))
	sort_by = Request("SB")

	query_string = Request("Query")
	If (query_string = "") Then
		keywords(0) = ""
	Else
		keywords = Split(query_string, " ")
	End If

	page_string = Request("Page")
	pages = Split(page_string, "-")
	current_page = Int(pages(0))
	last_page = Int(pages(1))
%>

<!--#include virtual="/includes/keyword_create_query.asp" -->

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
		Response.Write "<a href='/keyword_search_results.asp?SA=" & search_all & "&SB=" & sort_by & "&Page=" & current_page - 1 & "-" & last_page & "&Query=" & query_string & "'>Prev</a> "
	End If

	While (iteration_num <= last_page)
		If (iteration_num = current_page) Then
			Response.Write "<u>" & iteration_num & "</u> "
		Else
			Response.Write "<a href='/keyword_search_results.asp?SA=" & search_all & "&SB=" & sort_by & "&Page=" & iteration_num & "-" & last_page & "&Query=" & query_string & "'>" & iteration_num & "</a> "
		End If
		iteration_num = iteration_num + 1
	Wend

	If (current_page < last_page) Then
		Response.Write "<a href='/keyword_search_results.asp?SA=" & search_all & "&SB=" & sort_by & "&Page=" & current_page + 1 & "-" & last_page & "&Query=" & query_string & "'>Next</a>"
	End If
	Response.Write "<br><br></td></tr></table>"
%>

<!--#include virtual="/includes/db_close.inc.asp" -->
<!--#include virtual="/includes/footer_std.inc.html" -->
</body>
</html>