<html>
<head>
<title>www.BCRocket.com Shopping Cart</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/header_std_close.inc.html" -->
<!--#include virtual="/includes/db_open.inc.asp" -->
<table valign="top" align="center" width="95%" border="0" cellpadding="2" cellspacing="0">
  <tr> 
    <td colspan="2"><span class="Cart-Title">YOUR SHOPPING CART</span><br> <hr></td>
  </tr>
</table>

<%
'build & execute query to get contents of current user's shopping cart
dim i, totItems, subTotal 'strQ 
'strQ = "SELECT c1. * , SUM(c2.item_qty) AS total_items FROM shopping_carts c1, shopping_carts c2 "
'strQ = strQ & "WHERE " & MemberID & " = c1.user_id GROUP BY c1.item_number ORDER BY c1.item_number ASC LIMIT 0 , 30"
objRS.Open "SELECT p.file_name, i.item_id, i.item_name, i.description, c.class_name, i.item_price, " _
	& "i.quantity AS item_avail_qty, sc.item_number, sc.item_qty AS item_order_qty " _
	& "FROM shopping_carts sc, items i, item_pictures p, item_class c " _
	& "WHERE " & MemberID & " = sc.user_id AND sc.item_number = i.item_id AND p.item_id = i.item_id AND i.class_id = c.class_id AND i.active =1 " _
	& "GROUP BY sc.item_number " _
	& "ORDER BY c.class_name ASC, i.item_name ASC", objConn
if objRS.BOF or objRS.EOF then 'cart is empty
	
%>
<table valign="top" align="center" width="95%" border="0" cellpadding="2" cellspacing="0">
  <tr> 
    <td><span class="Body-Std-txt">It appears your cart is empty.<br>
      <a href="/search.asp">Browse our available items and add something!</a> 
      </span><br></td>
  </tr>
</table>
<%
else 'cart is NOT empty, so display items.
	'Session.Contents("Cart_TotItems") = objRS("total_items")
	subTotal = 0
	totItems = 0
	i = 0
	j=0
%>
<table valign="top" align="center" width="95%" border="0" cellpadding="2" cellspacing="0">
        <tr class="Body-Std-txt">
			<td colspan="6">Note: if you've updated quantities, and they appear not to change, you may be trying to add more items to your cart than are available; check quantities.</td>
		</tr>
		<tr class="Body-Std-Bold-txt"> 
          <td nowrap>&nbsp;</td>
          <td nowrap><div align="center">Item Name</div></td>
          <td nowrap><div align="center">Unit Price</div></td>
          <td nowrap><div align="center">Quantity</div></td>
          <td nowrap><div align="center">Total Price</div></td>
          <td nowrap>&nbsp;</td>
        </tr>
			<form action="updatecartquantities.asp" method=post>
        <%
	objRS.MoveFirst
	Do Until objRS.EOF
		j = j + 1
		If i = 0 Then
			i = i + 1
%>
        <tr bgcolor="#CCCCCC" class="Body-Std-txt"> <!-- Dark Grey : #828282 -->
          <%
		Else
			i = 0
%>
        <tr bgcolor="#FFFFFF" class="Body-Std-txt"> 
          <%
		End If
%>
          <td width="70" height="70" align="center"><a href="/view_item_details.asp?item_id=<%= objRS("item_id") %>"><img src="/item_images/<%= objRS("file_name") %>" height="64" width="64" border="0"></a></td>
		  <td align="center"><%= objRS("item_name") %></td>
		  <td align="center">$<%= objRS("item_price") %></td>
		  <td align="center">
		      <input type=hidden name="item_id_<%= j %>" value="<%= objRS("item_id") %>">
              <input name="item_qty_<%= j %>" type="text" value="<%= objRS("item_order_qty") %>" size="4"></td>
		  <td width="1%" align="center" nowrap>$<%= CDbl(objRS("item_price"))*CDbl(objRS("item_order_qty")) %></td>
		  <td width="1%" align="center"> 
              <!--input name="btnRemove" type="submit" id="btnRemove" value="Remove"--></td>
        </tr>
		
        <%	
		subTotal = subTotal + CDbl(objRS("item_price"))*CDbl(objRS("item_order_qty"))
  		totItems = totItems + 1	
		objRS.MoveNext
	Loop
	objRS.close
	%>
	<input type=hidden name="user_id" value="<%= MemberID %>">
	<input type=hidden name="num_items" value="<%= j %>">
	<%
	Session.Contents("Cart_TotItems") = totItems
	Session.Contents("Cart_TotPrice") = subTotal
%>	
		<tr>
            <td colspan="6"><hr></td>
        </tr>
		<tr class="Body-Std-txt">
		    <td colspan="4"><div align="right"><span class="Body-Std-Bold-txt">* Order Sub-Total =</span></div></td>  
			<td><div align="center"><span class="Body-Std-Bold-txt"> $<%= subTotal %></span></div></td>
		  <td>&nbsp;</td>
		</tr>

        <tr class="Body-Std-txt"> 
          <td colspan="6"><div align="left">Total Items: <b> 
              <% = Session.Contents("Cart_TotItems") %>
              </b></div>
            <div align="right"> 

                <b>
                <input name="btnUpdateQuantities" type="submit" id="btnUpdateQuantities2" value="Update Quantities">
                </b> 
              </form>
              <img src="/images/spacer.gif" width="10px"> 
			  <form action="checkout.asp" method=post>
                <input name="btnCheckOut" type="submit" id="btnCheckOut5" value="Checkout!">
              </form>




              <img src="/images/spacer.gif" width="15px"> </div></td>
        </tr>
      </table>
<%	
end if

%>
<!--#include virtual="/includes/db_close.inc.asp" -->
<!--#include virtual="/includes/footer_std.inc.html" -->
</body>
</html>
