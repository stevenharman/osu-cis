<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Welcome to www.BCRocket.com</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!--#include virtual="/includes/db_open.inc.asp" -->
<!--#include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/header_std_close.inc.html" -->
            <div align="center"><br>
              <img src="/images/firetruck.gif" width="460" height="128"><br>
            </div>
<br>
<br>
<table width="95%" border="0">
  <tr bgcolor="#990000">
    <td></td>
  </tr>
</table>
<table width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
     <td align="center"><h2>Your Home for Firefighting Antiques, Collector's Items, 
                    and Much More!</h2></td>
  </tr>
  <tr align="center" class="Body-Std-Bold-txt">
  	<td>Please take a look around the site and feel free to 
	buy any of the many terrific items. Also, please register with our site as soon as 
	possible so that you can become part of the BCRocket crew!</td>
  </tr>
</table>
<table width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr bgcolor="#990000">
    <td></td>
  </tr>
</table>
<br>
<br>
<table width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td align="center"><img src="/images/hot_items.gif" border="0"></td>
  </tr>
</table>
<br>
<br>
<%
	strQ_IOD = "SELECT * FROM items i INNER JOIN item_class c ON (i.class_id = c.class_id) LEFT OUTER JOIN item_pictures p ON (i.item_id = p.item_id) WHERE (i.active = 1) AND (p.primary_picture = 1) AND ((i.quantity - i.qty_pending) > 0) AND (i.for_sale = 1)"

'	Find results size
	objRS.Open strQ_IOD, objConn
	max_results_size = 0
	If (objRS.EOF = false) Then
		objRS.MoveFirst
		Do Until objRS.EOF
			max_results_size = max_results_size + 1
			objRS.MoveNext
		Loop
		objRS.MoveFirst
	End If
	objRS.Close

	Randomize
	item_of_the_day1 = Rnd() * max_results_size
	
	Randomize
	item_of_the_day2 = Rnd() * max_results_size
	
	Randomize
	item_of_the_day3 = Rnd() * max_results_size
	
	item_of_the_day1 = Int(item_of_the_day1)
	item_of_the_day2 = Int(item_of_the_day2)
	item_of_the_day3 = Int(item_of_the_day3)

	Response.Write "<table width='95%' border='0'><tr align='center' valign='middle'>"

	objRS.Open strQ_IOD, objConn

	If (objRS.EOF = false) Then
		objRS.MoveFirst
		results_counter = 0
		Do Until objRS.EOF
			If ((results_counter = item_of_the_day1) Or (results_counter = item_of_the_day2) Or (results_counter = item_of_the_day3)) Then
				Response.Write "<td>"
				Response.Write "<a href='/view_item_details.asp?item_id=" & objRS("item_id") & "&ST=keyword" & "&SA=0" & "&SB=name-asc" & "&Page=1-1" & "&Query=" & objRS("item_name") & "'><b>" & objRS("item_name") & "</b></a>"
				Response.Write "<br><br>"
				Response.Write "<a href='/view_item_details.asp?item_id=" & objRS("item_id") & "&ST=keyword" & "&SA=0" & "&SB=name-asc" & "&Page=1-1" & "&Query=" & objRS("item_name") & "'>"
				Response.Write "<img src='/item_images/" & objRS("file_name") & "'" & " width='120' height='120' border='1'></a>"
				Response.Write "</td>"
			End If
			results_counter = results_counter + 1
			objRS.MoveNext
		Loop
	End If
	
	objRS.Close

	Response.Write "</tr></table>"
%>
<br>
<!--#include virtual="/includes/db_close.inc.asp" -->
<!--#include virtual="/includes/footer_std.inc.html" -->
</body>
</html>