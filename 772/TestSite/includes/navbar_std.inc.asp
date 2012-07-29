  <%
	URL = Request.ServerVariables("URL")
	If Not (URL = "/index.asp") Then
		%>
  <a href="/index.asp"><img src="/images/nav_home_up.gif" name="Button_Home_up" border="0" id="Button_Home_up"></a><br>
  <%
	Else
		%>
  <img src="/images/nav_home_dn.gif" name="Button_Home_dn" border="0" id="Button_Home_dn"><br>
  <%
	End If
	
	If (Not (URL="/search.asp") AND Not (URL="/category_search_results.asp") AND Not (URL="/keyword_search_results.asp") AND Not (URL="/view_item_details.asp")) Then
		%>
  <a href="/search.asp"><img src="/images/nav_search_up.gif" name="Button_Search_up" border="0" id="Button_Search_up"></a><br>
  <%
	Else
		%>
  <a href="/search.asp"><img src="/images/nav_search_dn.gif" name="Button_Search_dn" border="0" id="Button_Search_dn"></a><br>
  <%
	End If
	
		If Not InStr(1, URL, "/forum/", vbTextCompare) > 0 Then
		%>
  <a href="/forum/default.asp"><img src="/images/nav_forums_up.gif" name="Button_forums_up" border="0" id="Button_Forums_up"></a><br>
  <%
	Else
		%>
  <img src="/images/nav_forums_dn.gif" name="Button_Forums_dn" border="0" id="Button_Forums_dn"><br>
  <%
	End If
	
' Need to hide this link from non-Inventory Admins
	If cLng(Session.Contents("intInvAdmin")) > 0 Then	
		If Not InStr(1, URL, "/admin/", vbTextCompare) > 0 Then
   	%>
 	 <a href="/admin/admin.asp"><img src="/images/nav_admin_up.gif" name="Button_Admin_up" border="0" id="Button_Admin_up"></a><br>
  <%
		Else
		%>
 	 <img src="/images/nav_admin_dn.gif" name="Button_Admin_dn" border="0" id="Button_Admin_dn"><br>
 	 <%
		  	If Not (URL = "/admin/addinventory.asp") Then
	%>
<a href="/admin/addinventory.asp"><img src="/images/nav_admin_addupdateinv_up.gif" width="120" height="22" border="0"></a><br>
<%
			Else
			%>
			<img src="/images/nav_admin_addupdateinv_dn.gif" width="120" height="22" border="0"><br>
			<a href="addinventory.asp?page=addcategory.asp"><img src="/images/nav_admin_addcategory.gif" width="120" height="22" border="0"></a><br>
			<a href="addinventory.asp?page=additem.asp"><img src="/images/nav_admin_additems.gif" width="120" height="22" border="0"></a><br>
			<a href="addinventory.asp?page=edititem.asp"><img src="/images/nav_admin_edititem.gif" width="120" height="22" border="0"></a><br>
			<a href="addinventory.asp?page=addimages.asp"><img src="/images/nav_admin_linkimg.gif" width="120" height="22" border="0"></a><br>
			<%
			End If
	
			If Not (URL = "/admin/deleteinventory.asp") AND Not (URL = "/admin/purgeolditems.asp") Then
    	%>
<a href="/admin/deleteinventory.asp"><img src="/images/nav_admin_deleteinv_up.gif" width="120" height="22" border="0"></a><br>
<%
			Else
			%>	
				<img src="/images/nav_admin_deleteinv_dn.gif" width="120" height="22"><br>
<a href="deleteinventory.asp?page=deletecategory.asp"><img src="/images/nav_admin_deletecategory.gif" width="120" height="22" border="0"></a><br>
<a href="deleteinventory.asp?page=deleteitem.asp"><img src="/images/nav_admin_deleteitem.gif" width="120" height="22" border="0"></a><br>
<a href="deleteinventory.asp?page=deleteimages.asp"><img src="/images/nav_admin_deleteimg.gif" width="120" height="22" border="0"></a><br>
<a href="deleteinventory.asp?page=restoreitem.asp"><img src="/images/nav_admin_restoreitems.gif" width="120" height="22" border="0"></a><br>
<a href="purgeolditems.asp"><img src="/images/nav_admin_purgeolditems.gif" width="120" height="22" border="0"></a><br>
<%
			End If
	
			If Not (URL = "/admin/openorders.asp") Then
%>
<a href="/admin/openorders.asp"><img src="/images/nav_admin_neworders_up.gif" width="120" height="22" border="0"></a><br>
<%
			Else
%>
<img src="/images/nav_admin_neworders_up.gif" width="120" height="22" border="0"><br>
<%
			End If

			If Not (URL = "/admin/orderhistory.asp") Then
		    %>	
<a href="/admin/orderhistory.asp"><img src="/images/nav_admin_closedorders_up.gif" width="120" height="22" border="0"></a><br>
<%
			Else
			%>	
<img src="/images/nav_admin_closedorders_up.gif" width="120" height="22" border="0"><br>
<%
			End If
	
			If Not ( URL = "/admin/viewinventory.asp") Then
		    %>	
<a href="/admin/viewinventory.asp"><img src="/images/nav_admin_viewinv_up.gif" width="120" height="22" border="0"></a><br>
<%
			Else
			%>	
<img src="/images/nav_admin_viewinv_up.gif" width="120" height="22" border="0"><br>
<%
			End If
			
			If Not (URL = "/admin/manageadmins.asp") Then
		    %>	
<a href="/admin/manageadmins.asp"><img src="/images/nav_admin_manageadmins_up.gif" width="120" height="22" border="0"></a><br>
<%
			Else
			%>	
<img src="/images/nav_admin_manageadmins_up.gif" width="120" height="22" border="0"><br>
<%
			End If
			
		End If 'End of Admin links
		
	End If	' End of hiding Admin links from non-Inventory Admins
	
	If Not (URL = "/faq.asp") Then
    %>
  <a href="/faq.asp"><img src="/images/nav_faq_up.gif" name="Button_faq_up" border="0" id="Button_faq_up"></a><br>
  <%
	Else
	%>
  <img src="/images/nav_faq_dn.gif" name="Button_faq_dn" border="0" id="Button_faq_dn"><br>
  <%
	End If
	
	If Not (URL = "/contactinfo.asp") Then
    %>
  <a href="/contactinfo.asp"><img src="/images/nav_contact_up.gif" name="Button_Contact_up" border="0" id="Button_Contact_up"></a><br>
  <%
	Else
	%>
  <img src="/images/nav_contact_dn.gif" name="Button_Contact_dn" border="0" id="Button_Contact_dn"><br>
  <%
	End If
	
	If Session.Contents("Cart_TotItems") = "" Then
		Session.Contents("Cart_TotItems") = 0
	End If
	If Session.Contents("Cart_TotPrice") = "" Then
		Session.Contents("Cart_TotPrice") = "0.00"
	End If
	%>
<table>
  <tr class="Body-Small-txt">	   	
    	<td rowspan="2" valign="top"><a href="/cart_view_items.asp"><img src="/images/view_cart1.gif" border="0"></a></td>	
    	<td valign="baseline">Contains <b><%= Session.Contents("Cart_TotItems") %></b> items</td>
	</tr>
		<tr class="Body-Small-txt">		
    	<td valign="baseline">Subtotal: <b>$<%= Session.Contents("Cart_TotPrice") %></b></td>
	</tr>
</table>
<!-- #include virtual="/forum/inc_loginform.asp" -->