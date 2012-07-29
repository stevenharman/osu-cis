<%
Dim HTTP_Ref
HTTP_Ref = Request.ServerVariables("URL")

If mLev < 1 Then
	'user hasn't yet logged in, redirect to login page, including referal page in querystring
	If Request.QueryString <> "" Then HTTP_Ref = HTTP_Ref & "?" & Request.QueryString
	Response.Redirect "/forum/login.asp?target=" & Server.URLEncode(HTTP_Ref)
Else
	'user has logged in, check for appropriate rights
	If InStr(1, HTTP_Ref, "/admin/", vbTextCompare) > 0 AND cLng(Session.Contents("intInvAdmin")) < 1 Then 
		'user isn't an Inventory Admin, so redirect
		Response.Redirect("/unauthorized.asp")
	End If
End If

%>