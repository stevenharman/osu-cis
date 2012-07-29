<form action="/includes/additemtocart.asp" method=POST>
<input type=hidden name="user_id" value="<%= MemberID %>">
<input type=hidden name="item_id" value="<%= item_id %>">
<input type=hidden name="item_qty" value="1">
<input type=hidden name="referring_url" value="<%= Request.ServerVariables("URL") %>">
<input type=hidden name="referring_querystring" value="<%= Request.Querystring() %>">
<input type=submit name=addSubmit value="Add Item to Cart">
</form>