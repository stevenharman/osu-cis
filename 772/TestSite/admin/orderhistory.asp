<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>www.BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
function MM_jumpMenu(targ,selObj,restore){ //v3.0
  eval(targ+".location='"+selObj.options[selObj.selectedIndex].value+"'");
  if (restore) selObj.selectedIndex=0;
}
//-->
</script>
</head>
<body>
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/security.inc.asp" -->
<!-- #include virtual="/includes/header_std_close.inc.html" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->
<%
Select Case Request.Form("Method")
Case "GetDetails"

	objRS.Open "SELECT  * " _
			 & "FROM orders_completed oc INNER  JOIN orders_completed_itemlist oci ON ( oc.order_number = oci.order_number ) " _
			 & "WHERE oc.order_number = " & Request.Form("fOrderNum") _
			 & " ORDER  BY oc.order_number DESC", objConn, 1
	If objRS.BOF OR objRS.EOF Then
		Response.Write("<p class=""Body-Std-Bold-txt""><font color=""#FF0000"">There are currently no closed orders to view.</font></p>")
	Else
		objRS.MoveFirst
%>	
	<table border="0" align="left" cellpadding="0" cellspacing="0">
		<tr>
			    <td colspan="4" align="left" class="Body-Std-txt"><span class="Body-Std-Bold-txt">Order #:</span> 
                  <%= objRS("order_number") %></td>
		</tr>
		<tr>
			<td colspan="4" align="left" class="Body-Std-txt"><span class="Body-Std-Bold-txt">Customer Username:</span> <%= objRS("user_name") %></td>
		</tr>
		<tr>
			<td colspan="4" align="left" class="Body-Std-txt"><span class="Body-Std-Bold-txt">Point of Sale:</span> <%= objRS("place_of_sale") %></td>
		</tr>
		<tr>
			<td colspan="4" align="left" class="Body-Std-txt"><span class="Body-Std-Bold-txt">Order Placed: </span>&nbsp; <%= objRS("date_placed") %></td>
		</tr>
		<tr>
			<td colspan="4" align="left" class="Body-Std-txt"><span class="Body-Std-Bold-txt">Order Shipped:</span> <%= objRS("date_shipped") %></td>
		</tr>
		<tr>
			<td colspan="4" align="left" class="Body-Std-txt"><span class="Body-Std-Bold-txt">Shipping Method:</span> <%= objRS("shipping_method") %>
			&nbsp; &nbsp; <span class="Body-Std-Bold-txt">Tracking #:</span> <%= objRS("tracking_number") %>
			</td>
		</tr>
		<tr><td colspan="4"><hr></td></tr>
		<tr class="Body-Std-Bold-txt"><td><font color="#FF0000">Order Contents:</font></td></tr>
		<tr><td colspan="4"><hr></td></tr>
		<tr class="Body-Std-Bold-txt">
			<td>Item Name: &nbsp; &nbsp; &nbsp;</td>
			<td>Unit Price: &nbsp; &nbsp; &nbsp;</td>
			<td>Quantity: &nbsp; &nbsp; &nbsp;</td>
			<td>Total Price: &nbsp; &nbsp; &nbsp;</td>
		</tr>
<%
		totPrice = 0
		totItems = 0
		i = 0
		Do Until objRS.EOF
			If i = 0 Then
				i = 1
%>		<tr class="Table_AltColor_1"> <%
			Else
				i = 0
%>		<tr class="Table_AltColor_2"> <%			
			End If
%>			<td><%= objRS("item_name") %> &nbsp; &nbsp; &nbsp; </td>
			<td>$<%= objRS("price") %> &nbsp; &nbsp; &nbsp; </td>
			<td><%= objRS("quantity") %> &nbsp; &nbsp; &nbsp;</td>
			<td>$<%= CDbl(objRS("quantity"))*CDbl(objRS("price")) %> &nbsp; &nbsp; &nbsp;</td>
		</tr>			
<%			
			totPrice = totPrice + CDbl(objRS("quantity"))*CDbl(objRS("price"))
			totItems = totItems + objRS("quantity")
			objRS.MoveNext
		Loop
	End If
	objRS.Close
%>		<tr><td colspan="4"><hr></td></tr>
		<tr><td colspan="2" align="right" class="Body-Std-Bold-txt">Total Items: &nbsp;</td>
			<td colspan="2" class="Body-Std-txt"><%= totItems %></td>
		</tr>
		<tr><td colspan="3" align="right" class="Body-Std-Bold-txt">Total Price: &nbsp;</td>
			<td class="Body-Std-txt">$<%= totPrice %></td>
		</tr>
		<tr>
                <td height="50" colspan="4" align="right"><a href="javascript:history.go(-1);">Back 
                  to Closed Orders</a></td>
              </tr>
	</table>
<%
Case Else 
	If Request("num_show") <> "" Then
		ordersPerPage = Cint(Request("num_show"))
	Else
		ordersPerPage = 5
	End If
	
	If Request("current_page") <> "" Then
		pageStart = (Cint(Request("current_page")) - 1)* ordersPerPage
	Else
		pageStart = 0
	End If
	
	If Request("current_page") <> "" Then
		current_page = CInt(Request("current_page"))
	Else
		current_page = 1
	End If
	
	objRS.Open "SELECT * FROM orders_completed WHERE 1=1 ORDER BY order_number DESC LIMIT " & pageStart & ", " & ordersPerPage, objConn, 1
	If objRS.BOF OR objRS.EOF Then
		Response.Write("<p class=""Body-Std-Bold-txt""><font color=""#FF0000"">There are currently no closed orders to view.</font></p>")
	Else
		objRS.MoveFirst
%>
<table border="0" align="left" cellpadding="0" cellspacing="0">
	<tr class="Body-Std-Bold-txt">
		<td>Order# &nbsp; &nbsp; &nbsp;</td>
		<td>Customer Username &nbsp; &nbsp; &nbsp; </td>
		<td>Order Placed &nbsp; &nbsp; &nbsp; </td>
		<td>Order Shipped &nbsp; &nbsp; &nbsp; </td>
		<td align="center" valign="bottom">
			        <select name="fNumOrders" onChange="MM_jumpMenu('parent',this,0)">
                      <option value="/admin/orderhistory.asp?num_show=5&current_page=1"<%If ordersPerPAge = 5 Then Response.Write(" selected")%>>5</option>
                      <option value="/admin/orderhistory.asp?num_show=10&current_page=1"<%If ordersPerPAge = 10 Then Response.Write(" selected")%>>10</option>
                      <option value="/admin/orderhistory.asp?num_show=25&current_page=1"<%If ordersPerPAge = 25 Then Response.Write(" selected")%>>25</option>
                      <option value="/admin/orderhistory.asp?num_show=50&current_page=1"<%If ordersPerPAge = 50 Then Response.Write(" selected")%>>50</option>
                      <option value="/admin/orderhistory.asp?num_show=100&current_page=1"<%If ordersPerPAge = 100 Then Response.Write(" selected")%>>100</option>
                    </select>		
		</td>
	</tr>
	<tr><td colspan="5"><hr></td>
</tr>
<%
		i = 0
		Do Until objRS.EOF
			If i = 0 Then
				i = 1
%><tr class="Table_AltColor_1">
<%
			Else
				i = 0
%><tr class="Table_AltColor_2">
<%
			End If
%>	<form action="/admin/orderhistory.asp" method="post">
	<input type="hidden" name="Method" value="GetDetails">
	<input type="hidden" name="fOrderNum" value="<%= objRS("order_number") %>">	
	<td class="Body-Std-txt" align="left"><%= objRS("order_number") %></td>
	<td class="Body-Std-txt" align="left"><%= objRS("user_name") %></td>
	<td class="Body-Std-txt" align="left"><%= objRS("date_placed") %></td>
	<td class="Body-Std-txt" align="left"><%= objRS("date_shipped") %></td>
	<td class="Body-Std-txt" align="left"><input name="bDetails" type="submit" value="Order Details"></td>
	</form>
  </tr>
  <tr align="center">
	<td colspan="5">
<%	
		objRS.MoveNext
		Loop
		objRs.Close
		objRS.Open "SELECT Count(*) FROM orders_completed WHERE 1=1", objConn
	
		total_pages = Int(objRS(0) / ordersPerPage)
		If Int(objRS(0) Mod ordersPerPage) <> 0 Then
			total_pages = total_pages + 1
		End If 
		If total_pages > 1 Then
			Response.Write("<strong>Page</strong> ")
			i = 1		
			Do Until i > total_pages
				If current_page <> i Then
					%>
					<a href="orderhistory.asp?num_show=<%= ordersPerPage %>&current_page=<%= i %>"><%= i %></a>
					<%
				Else
					Response.Write "<b><u>" & i & "</u></b>"
				End If
				i = i + 1
			Loop
		End If
%>
		</td>
	</tr>
</table>
<%
	End If
End Select
%>
<!-- #include virtual="/includes/footer_std.inc.html"-->
</body>
</html>
