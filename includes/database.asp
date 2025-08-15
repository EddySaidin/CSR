<%
' Database Helper Functions

' Execute stored procedure
Function execStoredProc(procName, params, conn)
    Dim cmd, rs
    
    Set cmd = Server.CreateObject("ADODB.Command")
    cmd.ActiveConnection = conn
    cmd.CommandText = procName
    cmd.CommandType = 4 ' adCmdStoredProc
    
    ' Add parameters if provided
    If IsArray(params) Then
        Dim i
        For i = 0 To UBound(params)
            cmd.Parameters.Append cmd.CreateParameter(params(i)(0), params(i)(1), params(i)(2), params(i)(3), params(i)(4))
        Next
    End If
    
    Set rs = cmd.Execute
    Set execStoredProc = rs
End Function

' Get record count
Function getRecordCount(sql, conn)
    Dim rs
    Set rs = setRs(sql, conn)
    
    If Not rs.EOF Then
        getRecordCount = rs(0)
    Else
        getRecordCount = 0
    End If
    
    rs.Close
    Set rs = Nothing
End Function

' Check if record exists
Function recordExists(sql, conn)
    Dim rs
    Set rs = setRs(sql, conn)
    
    recordExists = Not rs.EOF
    
    rs.Close
    Set rs = Nothing
End Function

' Get single value
Function getSingleValue(sql, conn)
    Dim rs
    Set rs = setRs(sql, conn)
    
    If Not rs.EOF Then
        getSingleValue = rs(0)
    Else
        getSingleValue = ""
    End If
    
    rs.Close
    Set rs = Nothing
End Function

' Begin transaction
Sub beginTransaction(conn)
    conn.BeginTrans
End Sub

' Commit transaction
Sub commitTransaction(conn)
    conn.CommitTrans
End Sub

' Rollback transaction
Sub rollbackTransaction(conn)
    conn.RollbackTrans
End Sub
%> 