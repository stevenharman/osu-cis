<%
If Session.Contents("bValidated") <> "True" Then
	'if failed login attempt, don't display login in navbar
	If Request("success") <> "false" Then

	Dim Login_Referrer
	Login_Referrer = Request.ServerVariables("URL")
	If Request.QueryString <> "" Then 
		Login_Referrer = Login_Referrer & "?" & Request.QueryString
	End If
%>
<form name="FormLogin" method="post" action="/login.asp?HTTP_Referrer=<% Response.Write(Server.URLEncode(Login_Referrer)) %>">
<input name="validate_form" type="hidden" value="validate_login">
  <table width="110" border="1" align="left" cellpadding="0" cellspacing="0" bordercolor="#4c4c4c">
    <tr> 
      <td><table border="0" align="center" cellpadding="0" cellspacing="0" bordercolor="#4c4c4c">
          <tr class="Body-Std-txt"> 
            <td>Username:</td>
          </tr>
          <tr> 
            <td><div align="center"> 
                <input name="txtUserName" type="text" id="txtUserName" size="15" maxlength="40">
              </div></td>
          </tr>
          <tr> 
            <td>Password:</td>
          </tr>
          <tr> 
            <td><div align="center"> 
                <input name="txtPassWord" type="password" id="txtPassWord" size="15" maxlength="40">
              </div></td>
          </tr>
          <tr> 
            <td><div align="center"> 
                <input name="btnLogin" type="submit" id="btnLogin3" value="Login">
              </div></td>
          </tr>
        </table></td>
    </tr>
  </table>
</form>
<% 
	End If
'User is validated, so display their name, etc...
Else 
	Dim Logout_Referrer
	Logout_Referrer = Request.ServerVariables("URL")
	If Request.QueryString <> "" Then 
		Logout_Referrer = Logout_Referrer & "?" & Request.QueryString
	End If
%>
<p><span class="Body-Std-txt">Welcome <strong>
  <% Response.Write(Session.Contents("sUser")) %>
  </strong>.</span></p>
<form action="/logout.asp?HTTP_Referrer=<% Response.Write(Server.URLEncode(Logout_Referrer)) %>" method="post" name="formLogout">
  <input name="LogMeOut" type="hidden" value="ContinueLogout">
  <input name="btnLogout" type="submit" id="btnLogout" value="Logout">
</form>
<% 
End If %>