<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<html>
<head>
<title>View Image <%= Request("filename") %></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<img src="/item_images/<%= Request("filename")%>">
</body>
</html>
