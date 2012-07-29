<!-- #include virtual="/includes/db_open.inc.asp" -->
<%

	item_class = Request.Form("item_class")
	item_quantity = Request.Form("quantity")
	item_price = Request.Form("item_price")
	item_forsale = Request.Form("item_forsale")
	item_description = Request.Form("item_description")
	item_name = Request.Form("item_name")
	err_count = 0

	If (item_name = "") Then
		err_count = err_count + 16
	End If
	If (item_class = "") Then
		err_count = err_count + 8
	End If
	If (CStr(item_quantity) = "") Then
		err_count = err_count + 4
	ElseIf (CInt(item_quantity) < 0) Then
		err_count = err_count + 4
	End If
	If (CStr(item_price) = "") Then
		err_count = err_count + 2
	ElseIf(CDbl(item_price) <= 0.0) Then
		err_count = err_count + 2
	End If
	If (item_description = "") Then
		err_count = err_count + 1
	End If
	
	item_description = Replace(item_description, "'", "&#8217;")
	
	If err_count > 0 Then
		Response.Redirect("/admin/addinventory.asp?page=edititem.asp&err_count=" & err_count)
	Else
		query = "UPDATE items SET description = '" & item_description & "', "_
			& "item_price = '" & item_price & "', quantity = '" & item_quantity & "', "_
			& "item_name = '" & item_name & "', for_sale = '" & item_forsale & "', "_
			& "class_id = '" & item_class & "' WHERE item_id = '" & Request.Form("item_id") & "'"
		objConn.Execute(query)
		Response.Redirect("viewitem.asp?item_id=" & Request.Form("item_id"))
	End If


%>

<!-- #include virtual="/includes/db_close.inc.asp" -->