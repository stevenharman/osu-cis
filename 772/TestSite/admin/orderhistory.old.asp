<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>www.BCRocket Admin</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="/BCRocketStyleSheet.css" rel="stylesheet" type="text/css">
</head>

<body>
<!-- #include virtual="/includes/header_std_open.inc.html" -->
<!--#include virtual="/includes/security.inc.asp" -->
<!-- #include virtual="/includes/header_std_close.inc.html" -->
<!-- #include virtual="/includes/db_open.inc.asp" -->
<%'Use Case Select to find order...
Select Case Request.Form("Method")
	Case "FindOrder"
		UserName = Request.Form("fUserName")
		LastName = Request.Form("fLastName")
		ItemID = Request.Form("fItemID")
		OrderNumber = Request.Form("fOrderNumber")
		DateBeg = Request.Form("fDateBeg")
		DateEnd = Request.Form("fDateEnd")
		If UserName <> "" OR LastName <> "" OR ItemID <> "" OR OrderNumber <> "" OR DateBeg <> "" OR DateEnd <> "" Then
			
		Else
			ErrMsg = "Sorry, you must fill in at least one of the search fields!"	
		End If

End Select
%>	
	<form name="fFindOrder" method="post" action="orderhistory.asp">
		<input type="hidden" name="Method" value="FindOrder">
         <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
          	<td colspan="2" class="Body-Std-Bold-txt"><font color="#FF0000"><%= ErrMsg %></font></td>
		  </tr>
          <tr> 
            <td width="32%"><p>User Name</p></td>
            <td width="68%"><input type="text" name="fUserName"></td>
          </tr>
          <tr> 
            <td>Last Name</td>
            <td><input type="text" name="fLastName">
                  </td>
          </tr>
          <tr> 
            <td>Item#</td>
                  <td> <input type="text" name="fItemID"></td>
          </tr>
          <tr> 
            <td>Order#</td>
            <td><input type="text" name="fOrderNumber"></td>
          </tr>
          <tr> 
                  <td>Date Range: (mm/dd/yyyy)<div align="right">From</div></td>
            <td>
<input name="fDateBeg" type="text" size="10">
              To <input name="fDateEnd" type="text" size="10"> 
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr align="center"> 
            <td colspan="2"> 
              <input tabindex="0" type="submit" name="Submit" value="Find"> &nbsp; <input tabindex="1" name="Reset" type="reset" value="Clear">
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
<!-- #include virtual="/includes/footer_std.inc.html"-->
</body>
</html>
