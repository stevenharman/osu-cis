<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>	

<!--#include virtual="/includes/db_open.inc.asp" -->

<%
	strKeywords = Request.Form("Keywords")
	keywords = Split(strKeywords, " ")

	search_all = Int(Request.Form("Search_All"))
%>

<!--#include virtual="/includes/keyword_create_query.asp" -->

<%
'	Displays SQL Query
'	Response.Write "<table width='100%' border='1'><tr><td><b>Query: " & strQ & "</b></td></tr></table>"

	item_limit_per_page = 10

	objRS.Open strQ, objConn
	
	results_size = 0
	
	If (objRS.EOF = false) Then
		objRS.MoveFirst
		Do Until objRS.EOF
			results_size = results_size + 1
			objRS.MoveNext
		Loop
		objRS.MoveFirst
	End If
	
	objRS.Close
%>

<!--#include virtual="/includes/db_close.inc.asp" -->

<%
'	Response.Write "<table width='100%' border='1'><tr><td><b>Number of Results Returned: " & results_size & "</b></td></tr></table>"
	
	If ((results_size Mod item_limit_per_page) = 0) Then
		number_of_pages = results_size \ item_limit_per_page
	Else
		number_of_pages = (results_size \ item_limit_per_page) + 1
	End If
	
'	Response.Write "<table width='100%' border='1'><tr><td>Item Limit Per Page: " & item_limit_per_page & "<br>" & number_of_pages & " page(s)</td></tr></table>"

	first_iteration = true

	For Each keyword In keywords
		If (first_iteration = true) Then
			query_string = keyword
			first_iteration = false
		Else
			query_string = query_string & "+" & keyword
		End If
	Next

'	Response.Write "<table width='100%' border='1'><tr><td>Query String: " & query_string & "</td></tr></table>"

	If (number_of_pages = 0) Then
		redirection_address = "keyword_search_results.asp?SA=" & search_all & "&Page=1-1&Query=" & query_string
	Else
		redirection_address = "keyword_search_results.asp?SA=" & search_all & "&Page=1-" & number_of_pages & "&Query=" & query_string
	End If

	Response.Redirect(redirection_address)
%>