<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr align="left"> 
    <td colspan="2"> <h1><strong><img src="../images/logo.jpg" width="100" > Admin 
        Tools - Order Details</strong></h1>
      <hr></td>
  </tr>
  <tr> 
    <td width="26%" valign="top"><p><a href="addinventory.asp">Add / Update Inventory</a></p>
      <p><a href="deleteinventory.asp">Delete Inventory</a></p>
      <p><a href="password.asp">Change User Password</a></p>
      <p><a href="openorders.asp">New / Open Orders</a></p>
      <p><a href="orderhistory.asp">Closed Orders</a></p></td>
    <td width="74%" align="center" valign="top"> 
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
      </table><br><hr>
      <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
      </table><br><hr>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0">
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
<!--#include file="../includes/footer_std.inc.html"-->
</body>
</html>
