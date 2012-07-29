<%
'Need to get new values for NavBar Cart
	Set objConnTmp = Server.CreateObject("ADODB.Connection")
	objConnTmp.ConnectionString = "DRIVER={MySQL ODBC 3.51 Driver};"_
   		                 & "SERVER=24.208.173.202;"_ 
            	             & " DATABASE=cis772;"_
                	         & "UID=cis772;PWD=hakan; OPTION=3"
	objConnTmp.Open
	set objRSTmp = Server.CreateObject("ADODB.RecordSet")
	objRSTmp.Open "SELECT i.item_price, sc.item_qty AS item_order_qty " _
			& "FROM shopping_carts sc, items i " _
			& "WHERE '" & MemberID & "' = sc.user_id AND sc.item_number = i.item_id AND i.active = 1 " _
			& "GROUP BY sc.item_number LIMIT 0 , 9999 ", objConnTmp
	If objRSTmp.BOF or objRSTmp.EOF Then
		Session.Contents("Cart_TotItems") = 0
		Session.Contents("Cart_TotPrice") = "0.00"
	Else
		'dim totItems, totPrice
		totItems = 0
		totPrice = 0
		objRSTmp.MoveFirst
		Do Until objRSTmp.EOF
			totItems = totItems + objRSTmp("item_order_qty")
			totPrice = totPrice + CDbl(objRSTmp("item_price"))*CDbl(objRSTmp("item_order_qty"))
			objRSTmp.MoveNext
		Loop
		objRSTmp.close
		Session.Contents("Cart_TotItems") = totItems
		Session.Contents("Cart_TotPrice") = totPrice
	End If
	
	Set objRSTmp = Nothing
	Set objConnTmp = Nothing
%>