<%
'--------------------------------------------------------------------
' Microsoft ADO
'
' Copyright (c) 1996-1998 Microsoft Corporation.
'
' ADO constants include file for VBScript
' (This is a trimmed down version with only the required constants)
'--------------------------------------------------------------------

on error resume next

'---- CursorTypeEnum Values ----
Const adOpenForwardOnly = 0
Const adOpenKeyset = 1
Const adOpenDynamic = 2
Const adOpenStatic = 3

'---- LockTypeEnum Values ----
Const adLockReadOnly = 1
Const adLockPessimistic = 2
Const adLockOptimistic = 3
Const adLockBatchOptimistic = 4

'---- ExecuteOptionEnum Values ----
Const adAsyncExecute = &H00000010
Const adAsyncFetch = &H00000020
Const adAsyncFetchNonBlocking = &H00000040
Const adExecuteNoRecords = &H00000080
Const adExecuteStream = &H00000400

'---- CursorLocationEnum Values ----
Const adUseServer = 2
Const adUseClient = 3

'---- GetRowsOptionEnum Values ----
Const adGetRowsRest = -1

'---- CommandTypeEnum Values ----
Const adCmdUnknown = &H0008
Const adCmdText = &H0001
Const adCmdTable = &H0002
Const adCmdStoredProc = &H0004
Const adCmdFile = &H0100
Const adCmdTableDirect = &H0200

err.clear
on error goto 0
%>