<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>www.BCRocket.com Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>
<body>
<!-- #include virtual="/includes/header_std_open.inc.html" --> 
<!--#include virtual="/includes/security.inc.asp" --> 
<!-- #include virtual="/includes/db_open.inc.asp" --> 
<!-- #include virtual="/includes/header_std_close.inc.html" --> 
<table width="100%" border="0" align="left" cellpadding="0" cellspacing="0">
        <tr align="left"> 
		  <td><img src="/images/spacer.gif" width="10"></td>
          <td><h1><strong>Admin Tools - Order Details</strong></h1>
            <hr></td>
        </tr>
        <tr> 
          <!-- Not sure why this navigation is here, so i'm commenting it out. -S. Harman    
	<td width="26%" valign="top">
	  <p><a href="addinventory.asp">Add / Update Inventory</a></p>
      <p><a href="deleteinventory.asp">Delete Inventory</a></p>
      <p><a href="password.asp">Change User Password</a></p>
      <p><a href="openorders.asp">New / Open Orders</a></p>
      <p><a href="orderhistory.asp">Closed Orders</a></p>
	 </td>
-->
		  <td><img src="/images/spacer.gif" width="10"></td>
          <td align="center" valign="top"> 
		  <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="32%"><p>First Name</p></td>
                <td width="68%">DB Call get information</td>
              </tr>
              <tr> 
                <td>Last Name</td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td><p>Address1</p></td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td height="29">Address 2</td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td>City, State, Zip</td>
                <td>DB Call get information</td>
              </tr>
            </table>
            <br>
            <hr> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr align="center"> 
                <td width="29%">Item#</td>
                <td width="37%">Description</td>
                <td width="34%">Cost</td>
              </tr>
              <tr align="center"> 
                <td>DB Call get information</td>
                <td>DB Call get information</td>
                <td>DB Call get information</td>
              </tr>
              <tr align="center"> 
                <td>DB Call get information</td>
                <td>DB Call get information</td>
                <td>DB Call get information</td>
              </tr>
              <tr align="center"> 
                <td>DB Call get information</td>
                <td>DB Call get information</td>
                <td>DB Call get information</td>
              </tr>
              <tr align="center"> 
                <td>DB Call get information</td>
                <td>DB Call get information</td>
                <td>DB Call get information</td>
              </tr>
            </table>
            <br>
            <hr> <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td>Total Order Price</td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td>Pay Method</td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td>Customer Comments</td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td>Payment Status</td>
                <td>DB Call get information</td>
              </tr>
              <tr> 
                <td>Order Status</td>
                <td>DB Call get information</td>
              </tr>
			  
            </table>
            <form name="form1" method="post" action="">
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td>Payment Recieved?</td>
                  <td><input type="radio" name="radiobutton" value="radiobutton">
                    Yes </td>
                </tr>
                <tr> 
                  <td>Order Shipped?</td>
                  <td> <input type="radio" name="radiobutton" value="radiobutton">
                    Yes </td>
                </tr>
                <tr> 
                  <td>Order Closed?</td>
                  <td><input type="radio" name="radiobutton" value="radiobutton">
                    Yes </td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2">&nbsp;</td>
                </tr>
              </table>
              <input type="submit" name="Submit" value="Submit Changes">
            </form>
            <p>Display Order Change Verification</p>
			</td>
        </tr>
      </table>
      <!--#include virtual="/includes/footer_std.inc.html"-->
</body>
</html>
