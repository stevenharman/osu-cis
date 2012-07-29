<!-- #include file="../includes/db_open.inc.asp" -->
<%
	category_name = Request.Form("category_name")
	If Len(category_name) = 0 Then
		Response.Redirect ("addinventory.asp?page=addcategory.asp&err_count=1")
	Else
		objRS.Open "SELECT * FROM item_class WHERE 1=2", objConn, 1, 3
		objRS.AddNew
		objRS("class_name") = Request.Form("category_name")
		objRS.Update
		objRS.Close
		Response.Redirect("addinventory.asp?page=addcategory.asp&cat_added=true")
	End If

%>
<!-- #include file="../includes/db_close.inc.asp" -->