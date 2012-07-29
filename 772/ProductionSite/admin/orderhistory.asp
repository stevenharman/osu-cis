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
	Admin - View Closed Order History
	<!-- #include file="../includes/header_admin_close.inc.html" -->
	
	
	<form name="form1" method="post" action="">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="32%"><p>First Name</p></td>
            <td width="68%"><input type="text" name="textfield34"></td>
          </tr>
          <tr> 
            <td>Last Name</td>
            <td><input type="text" name="textfield33"></td>
          </tr>
          <tr> 
            <td>Item#</td>
            <td><input type="text" name="textfield32"></td>
          </tr>
          <tr> 
            <td>Order#</td>
            <td><input type="text" name="textfield3"></td>
          </tr>
          <tr> 
            <td>Date Range: (mm/dd/yyyy)</td>
            <td>From <input name="textfield" type="text" value="mm/dd/yyyy" size="10">
              To <input name="textfield2" type="text" value="mm/dd/yyyy" size="10"> 
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input type="submit" name="Submit" value="Find">
            </td>
          </tr>
        </table>
      </form><form name="form2" method="post" action="orderdetails.asp">
      <p>DB Call Display Results:</p>
        <p><strong>Order # / Date / Name 
          <input type="submit" name="Submit2" value="More Information">
          </strong></p>
      
      </form>
      <p>&nbsp;</p>
      </td>
  </tr>
</table>
<!--#include file="../includes/footer_std.inc.html"-->
</body>
</html>
