<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>www.BCRocket.com View Item</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
<script src="/vwd_justsopw.js" language = "JavaScript"></script>
</head>
<body>
<!--#include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/header_std_close.inc.html" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->

<%
	item_id = Request("item_id")
	search_type = Request("ST")
	search_all = Int(Request("SA"))
	sort_by = Request("SB")
	page_string = Request("Page")
	
	If (search_type = "keyword") Then
		query_string = Request("Query")
	Else
		category = Request("Category")
	End If


	strQVID1 = "SELECT * FROM items i INNER JOIN item_class c ON (i.class_id = c.class_id) WHERE (i.item_id = '" & item_id & "')"
	strQVID2 = "SELECT * FROM item_pictures p WHERE (p.item_id = '" & item_id & "')"
%>

<table width="100%" border="0" cols="2" cellpadding="1">
	<tr><td valign="top">
		<%
		objRS.Open strQVID1, objConn
		objRS.MoveFirst

		item_id = objRS("item_id")
		Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
		Response.Write "<b>Item Name: </b>" & objRS("item_name")
'		Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
		Response.Write "<hr>"		
		Response.Write "<b>Item Category: </b>" & objRS("class_name")
'		Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
		Response.Write "<hr>"
		Response.Write "<b>Item Quantity: </b>" & objRS("quantity") - objRS("qty_pending")
'		Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
		Response.Write "<hr>"
		
		iprice = objRS("item_price")
		pt_location = Instr(iprice, ".")
		price_length = Len(iprice)
		If (pt_location = 0) Then
			Response.Write "<b>Item Price: </b>$" & objRS("item_price") & ".00"
'			Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
			Response.Write "<hr>"
		ElseIf ((price_length - pt_location) = 2) Then
			Response.Write "<b>Item Price: </b>$" & objRS("item_price")
'			Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
			Response.Write "<hr>"
		ElseIf ((price_length - pt_location) = 1) Then
			Response.Write "<b>Item Price: </b>$" & objRS("item_price") & "0"
'			Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
			Response.Write "<hr>"
		End If

		If objRS("for_sale") = 0 Then
			item_for_sale = "No"
		Else
			item_for_sale = "Yes"
		End If
		Response.Write "<b>Item For Sale: </b>" & item_for_sale
'		Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
		Response.Write "<hr>"
		Response.Write "<b>Item Description: </b>" & objRS("description")
		Response.Write "<p><table width='100%' border='0'><tr bgcolor='#990000'><td></td></tr></table></p>"
		
		objRS.Close
		%>
    </td>
	<td width="370" align="center" valign="middle"><br>
		<%
		objRS.Open strQVID2, objConn

		If objRS.EOF Then
			Response.Write "<p>No Image Available</p>"
		Else
			picture_num = 1
			objRS.MoveFirst
			Do Until objRS.EOF
%>
				<a href="javascript:;" onClick="JustSoPicWindow('/item_images/<%= objRS("file_name") %>','width','height','* * Click window to close * * ','#','hug image','20')">
				<img src="/item_images/<%= objRS("file_name") %>" width="80" height="80" border="0"></a> 
<%
'				Response.Write "<a href='/view_item_full_image.asp?filename=" & objRS("file_name") & "' target='_blank'>"
'				Response.Write "<img src='/item_images/" & objRS("file_name") & "' width='110' height='110' border='1'></a> "
				If ((picture_num Mod 3) = 0) Then
					Response.Write "<br><br>"
				End If
				picture_num = picture_num + 1
				objRS.MoveNext
			Loop
			Response.Write "<p>Click on an image to view it full size.</p>"
		End If
		
		objRS.Close	
		%>
	</td></tr>
</table>

<table width="100%" border="0">
	<tr align="center"><td>
		<%
		Response.Write "<br>"
		
		If (search_type = "keyword") Then
			Response.Write "<form name='Return_To_Search_Results_Form' action='keyword_search_results.asp?SA=" & search_all & "&SB=" & sort_by & "&Page=" & page_string & "&Query=" & query_string & "' method='post'>"
		Else
			Response.Write "<form name='Return_To_Search_Results_Form' action='category_search_results.asp?SA=" & search_all & "&SB=" & sort_by & "&Page=" & page_string & "&Category=" & category & "' method='post'>"
		End If
		Response.Write "<input name='Return_To_Search_Results' type='submit' value='Return To Search Results'>"
		Response.Write "</form>"
		
		If (MemberID > 0) Then
		
		%><!-- #include virtual="includes/additembutton.inc.asp" --><%
		
		End If

		Response.Write "</br><br>"
		%>
	</td></tr>
</table>

<!-- #include virtual="/includes/db_close.inc.asp" -->
<!-- #include virtual="/includes/footer_std.inc.html"-->
</body>
</html>
