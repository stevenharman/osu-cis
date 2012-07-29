<!-- #include file="../includes/db_open.inc.asp" -->
<%
	item_class = Request.Form("item_class")
	item_quantity = Request.Form("item_quantity")
	item_price = Request.Form("item_price")
	item_forsale = Request.Form("item_forsale")
	item_description = Request.Form("item_description")
	item_image = Request.Form("item_image")
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
	
	If (err_count = 0) Then
		objRS.Open "SELECT * FROM items WHERE 1=2", objConn, 1, 3
		objRS.AddNew
		objRS("class_id") = CInt(item_class)
		objRS("quantity") = CInt(item_quantity)
		objRS("item_price") = item_price
		objRS("for_sale") = item_forsale
		objRS("description") = item_description
		objRS("item_name") = Request.Form("item_name")
		objRS("active") = 1
		objRS.Update
		objRS.Close
		objRS.Open "SELECT MAX(item_id) FROM items", objConn
		item_id = objRS(0)
		objRS.Close
		If NOT (item_image = "") Then
			objRS.Open "SELECT * FROM item_pictures WHERE 1=2", objConn, 1, 3
			objRS.AddNew
			objRS("item_id") = item_id
			objRS("file_name") = item_image
			objRS.Update
			objRS.Close
		End If		
		Session("item_class") = ""
		Session("item_quantity") = ""
		Session("item_price") = ""
		Session("item_forsale") = ""
		Session("item_description") = ""
		Session("item_image") = ""
		Session("item_name") = ""
		Response.Redirect ("addinventory.asp?item_added=true&item_id=" & item_id)
	Else
		Session("item_class") = Request.Form("item_class")
		Session("item_quantity") = Request.Form("item_quantity")
		Session("item_price") = Request.Form("item_price")
		Session("item_forsale") = Request.Form("item_forsale")
		Session("item_description") = Request.Form("item_description")
		Session("item_image") = Request.Form("item_image")
		Session("item_name") = Request.Form("item_name")
		Response.Redirect("addinventory.asp?page=additem.asp&err_count=" & err_count)
	End If
%>
<!-- #include file="../includes/db_close.inc.asp" -->
