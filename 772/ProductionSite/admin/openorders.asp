<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>

<body>

	<!-- #include file="../includes/db_open.inc.asp" -->
	<!-- #include file="../includes/header_std_open.inc.html" -->
	Admin - View Open Orders
	<!-- #include file="../includes/header_admin_close.inc.html" -->
	
	
	<p>New / Open Orders</p>
	<p>DB call - Populate table with all open orders.</p>
      <form name="form1" method="post" action="orderdetails.asp">
        <p>Example:<br>
          <strong>Date - Order Number - Amount - Name - Item(s)</strong> 
          <input type="submit" name="Submit" value="Get More Information">
        </p>
      </form><br>
      Sort by date? Customer? Item(s)? Amount?</td>
  </tr>
</table>
<!--#include file="../includes/footer_std.inc.html"-->
</body>
</html>
