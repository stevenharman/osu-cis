<%
	Set objConn = Server.CreateObject("ADODB.Connection")
	objConn.ConnectionString = "DRIVER={MySQL ODBC 3.51 Driver};"_
    		                 & "SERVER=24.208.173.202;"_ 
            	             & " DATABASE=cis772;"_
                	         & "UID=cis772;PWD=hakan; OPTION=3"
	objConn.Open
	set objRS = Server.CreateObject("ADODB.RecordSet")
%>