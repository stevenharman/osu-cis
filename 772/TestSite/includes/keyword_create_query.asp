<%
	If (keywords(0) = "@null") Then
		strQ = "SELECT * FROM items i INNER JOIN item_class c ON (i.class_id = c.class_id) LEFT OUTER JOIN item_pictures p ON (i.item_id = p.item_id) WHERE 1=2"

	ElseIf (keywords(0) = "*") Then
		strQ = "SELECT * FROM items i INNER JOIN item_class c ON (i.class_id = c.class_id) LEFT OUTER JOIN item_pictures p ON (i.item_id = p.item_id) WHERE (i.active = 1) AND (p.primary_picture = 1) AND ((i.quantity - i.qty_pending) > 0)"
		
		If (not (search_all = 1)) Then
			strQ = strQ & " AND (i.for_sale = 1)"
		End If

	Else
		strQ = "SELECT * FROM items i INNER JOIN item_class c ON (i.class_id = c.class_id) LEFT OUTER JOIN item_pictures p ON (i.item_id = p.item_id) WHERE (i.active = 1) AND (p.primary_picture = 1) AND ((i.quantity - i.qty_pending) > 0)"
		
		If (not (search_all = 1)) Then
			strQ = strQ & " AND (i.for_sale = 1)"
		End If

		For Each keyword In keywords
			strQ = strQ & " AND ((i.item_name LIKE '%" & keyword & "%') OR (i.description LIKE '%" & keyword & "%') OR (c.class_name LIKE '%" & keyword & "%'))"	
		Next
		
	End If

	If (sort_by = "name-asc") Then
		strQ = strQ & " ORDER BY i.item_name ASC"
	ElseIf (sort_by = "price-asc") Then
		strQ = strQ & " ORDER BY i.item_price ASC, i.item_name ASC"
	ElseIf (sort_by = "quantity-asc") Then
		strQ = strQ & " ORDER BY i.quantity ASC, i.item_name ASC"
	ElseIf (sort_by = "category-asc") Then
		strQ = strQ & " ORDER BY c.class_name ASC, i.item_name ASC"
	ElseIf (sort_by = "name-desc") Then
		strQ = strQ & " ORDER BY i.item_name DESC"
	ElseIf (sort_by = "price-desc") Then
		strQ = strQ & " ORDER BY i.item_price DESC, i.item_name DESC"
	ElseIf (sort_by = "quantity-desc") Then
		strQ = strQ & " ORDER BY i.quantity DESC, i.item_name DESC"
	ElseIf (sort_by = "category-desc") Then
		strQ = strQ & " ORDER BY c.class_name DESC, i.item_name DESC"
	Else
		strQ = strQ & " ORDER BY c.class_name ASC, i.item_name ASC"
	End If
%>