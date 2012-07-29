<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>www.BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/security.inc.asp" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->
<!-- #include virtual="/includes/header_std_close.inc.html" -->
<%
	objRS.Open "SELECT i.item_name, c.class_name, i.for_sale, "_
	&  		"i.item_price, i.quantity, i.item_id, ip.file_name FROM items i, item_class c "_
	&		"LEFT JOIN item_pictures ip ON i.item_id = ip.item_id WHERE i.class_id = c.class_id AND "_
	&		"i.active = 1 AND ip.file_name IS NULL ORDER BY i.for_sale DESC, "_
	&		"c.class_name ASC, i.item_name ASC LIMIT " & (Request("current_page") -1) * 10 & ",10", objConn
	If objRS.EOF Then
		%><p class="Body-Std-Bold-txt">No items without pictures to view.</p><%
	Else
	 %>
	 <p class="Body-Std-Bold-txt">Items with no photos:</p>
	  <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr class="Body-Std-Bold-txt"> 
          <td><div align="center">Item Name</div></td>
          <td><div align="center">Category</div></td>
          <td><div align="center">For Sale</div></td>
          <td><div align="center">Price</div></td>
          <td><div align="center">Quantity</div></td>
          <td><div align="center">Links</div></td>
        </tr>
        <%
	     
		Do Until objRS.EOF
			If i = 0 Then
				i = i + 1
				%>
        <tr class="Table_AltColor_1"> 
          <%
			Else
				i = 0
				%>
        <tr class="Table_AltColor_2"> 
          <%
			End If
		%>
          <td><div align="center"><%= objrs("item_name") %></div></td>
          <td><div align="center"><%= objrs("class_name") %></div></td>
          <td><div align="center"> 
              <%  If objRS("for_sale") = 0 Then
				Response.Write "No"
			Else
				Response.Write "Yes"
			End If
		%>
            </div></td>
          <td><div align="center">$<%= objrs("item_price") %></div></td>
          <td><div align="center"><%= objrs("quantity") %></div></td>
          <td valign="middle"><div align="center"> 
              <form action="/admin/addinventory.asp?page=edititem.asp" method="post">
                <input type=hidden name=item_id value="<%= objRS("item_id") %>">
                <input type=submit name=cmdSubmit value=Edit>
              </form>
              <form action="deleteinventory.asp" method=POST>
                <input type=hidden name=item_id value="<%= objRS("item_id")%>">
                <input type=submit name=submit value=Delete>
              </form>
            </div></td>
        </tr>
        <%
		objRS.MoveNext
		Loop
		objRS.Close
		%>
      </table>
		<div align="center">Page 
		<%
			objRS.Open "SELECT COUNT(*) FROM items i, item_class c "_
			&		"LEFT JOIN item_pictures ip ON i.item_id = ip.item_id "_
			&		"WHERE i.class_id = c.class_id AND "_
			&		"i.active = 1 AND ip.file_name IS NULL", objConn
		
		total_pages = Int(objRS(0) / 10)
		If Int(objRS(0) Mod 10) <> 0 Then
			total_pages = total_pages + 1
		End If
		i = 1
		current_page = CInt(Request("current_page"))
		Do Until i > total_pages
			If current_page <> i Then
				%>
				<a href="viewinventory_nophotos.asp?current_page=<%= i %>"><%= i %></a>
				<%
			Else
				Response.Write "<b><u>" & i & "</u></b>"
			End If
			i = i + 1
		Loop
		%>
		</div>
		<%
	End If
	%>

<!-- #include virtual="/includes/footer_std.inc.html"-->
<!-- #include virtual="/includes/db_close.inc.asp" -->
</body>
</html>
