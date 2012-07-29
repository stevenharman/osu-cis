<p> 
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
	
	If Not (URL = "/search.asp") AND Not (URL = "/search_results.asp") AND Not (URL = "/view_item_details.asp") Then
		%>
  <a href="/search.asp"><img src="/images/nav_search_up.gif" name="Button_Search_up" border="0" id="Button_Search_up"></a><br>
  <%
	Else
		%>
  <img src="/images/nav_search_dn.gif" name="Button_Search_dn" border="0" id="Button_Search_dn"><br>
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
	
	If Not InStr(1, URL, "/admin/", vbTextCompare) > 0 Then
    %>
  <a href="/admin/admin.asp"><img src="/images/nav_admin_up.gif" name="Button_Admin_up" border="0" id="Button_Admin_up"></a><br>
  <%
	Else
	%>
  <img src="/images/nav_admin_dn.gif" name="Button_Admin_dn" border="0" id="Button_Admin_dn"><br>
  <%
	  If Not (URL = "/admin/addinventory.asp") Then
			%><p><a href="../admin/addinventory.asp">Add / Update Inventory</a></p><%
		Else
			%><p><strong>Add / Update Inventory</strong></p>
			<ul>
			<li><a href="addinventory.asp?page=addcategory.asp"><font size="-1">Add Category</font></a></li>
			<li><a href="addinventory.asp?page=additem.asp"><font size="-1">Add Items</font></a></li>
			<li><a href="addinventory.asp?page=edititem.asp"><font size="-1">Edit Item</font></a></li>
			<li><a href="addinventory.asp?page=addimages.asp"><font size="-1">Link New Images</font></a></li>
			</ul>
			<%
		End If
	
		If Not (URL = "/admin/deleteinventory.asp") Then
    	%><p><a href="../admin/deleteinventory.asp">Delete Inventory</a></p><%
		Else
			%><p><strong>Delete Inventory</strong></p>
			<ul>
			<li><a href="deleteinventory.asp?page=deletecategory.asp"><font size="-1">Delete Categories</font></a></li>
			<li><a href="deleteinventory.asp?page=deleteitem.asp"><font size="-1">Delete Items</font></a></li>
			<li><a href="deleteinventory.asp?page=deleteimages.asp"><font size="-1">Delete Images</font></a></li>
			<li><a href="deleteinventory.asp?page=restoreitem.asp"><font size="-1">Restore Items</font></a></li>
			</ul>
			
			<%
		End If
	
		If Not (URL = "/admin/password.asp") Then
		    %><p><a href="../admin/password.asp">Change User Password</a></p><%
		Else
			%><p><strong>Change User Password</strong></p><%
		End If

		If Not (URL = "/admin/openorders.asp") Then
		    %><p><a href="../admin/openorders.asp">New / Open Orders</a></p><%
		Else
			%><p><strong>New / Open Orders</strong></p><%
		End If

		If Not (URL = "/admin/orderhistory.asp") Then
		    %><p><a href="../admin/orderhistory.asp">Closed Orders</a></p><%
		Else
			%><p><strong>Closed Orders</strong></p><%
		End If
	
	If Not ( URL = "/admin/viewinventory.asp") Then
		    %><p><a href="../admin/viewinventory.asp">View Inventory</a></p><%
		Else
			%><p><strong>View Inventory</strong></p><%
		End If
	End If
	
	If Not (URL = "/contact.asp") Then
    %>
  <a href="contactinfo.asp"><img src="/images/nav_contact_up.gif" name="Button_Contact_up" border="0" id="Button_Contact_up"></a><br>
  <%
	Else
	%>
  <img src="/images/nav_contact_dn.gif" name="Button_Contact_dn" border="0" id="Button_Contact_dn"><br>
  <%
	End If
	%>
  <% ' <!--#include virtual="/includes/login.inc.asp" --> %>
  <!-- #include virtual="/forum/inc_loginform.asp" -->