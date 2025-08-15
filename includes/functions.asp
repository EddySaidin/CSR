<%
' Core Utility Functions
session.lcid = 2057

' Database query execution
Function setRs(cmdx, dbconn)
    Dim rs, rs_cmd
    Set rs_cmd = Server.CreateObject("ADODB.Command")
    
    rs_cmd.ActiveConnection = dbconn
    rs_cmd.CommandText = cmdx
    rs_cmd.Prepared = True
    
    Set setRs = rs_cmd.execute
End Function

' Parameterized query execution
Function ParaRs(cmdtxt, arr, conn)
    Dim para_cmd, i
    
    Set para_cmd = Server.CreateObject("ADODB.Command")
    para_cmd.ActiveConnection = conn
    para_cmd.CommandText = cmdtxt
    para_cmd.Prepared = true 
    
    With para_cmd
        for each i in arr
            .Parameters.Append .CreateParameter(i(0), i(1), i(2), i(3), i(4))
        next
    End With
    
    set ParaRs = para_cmd.Execute
End Function

' ID validation
Function fid(idx)
    if not isNumeric(idx) then
        if isNull(idx) or len(trim(idx)) = 0 then
            Response.Redirect("?action=home")
        else
            Response.Redirect("?action=error&errid=2")
        end if
    else
        fid = idx
    end if
End Function

' Array utilities
Function InArray(arr, key, index)
    Dim x
    InArray = True
    
    For x = 0 to index-1
        If arr(x) = key Then Exit Function
    Next
    InArray = False
End Function

Function RemoveDuplicates(str, delimeter)
    Dim result, arrTmp, x
    result = ""
    
    if not isNull(str) then
        arrTmp = Split(str, delimeter)
        For x = 0 To UBound(arrTmp)
            If Not(InArray(arrTmp, arrTmp(x), x)) Then
                result = result & arrTmp(x) & delimeter
            End If
        Next
        
        If Len(result) > 0 Then 
            result = Left(result, Len(result) - Len(delimeter))
        End If
        Erase arrTmp
    end if
    
    RemoveDuplicates = result
End Function

' String utilities
Function safeString(str)
    If IsNull(str) Or str = "" Then
        safeString = ""
    Else
        safeString = Trim(str)
    End If
End Function

Function safeNumber(num)
    If IsNull(num) Or Not IsNumeric(num) Then
        safeNumber = 0
    Else
        safeNumber = CDbl(num)
    End If
End Function
%> 