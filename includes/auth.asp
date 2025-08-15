<%
' Authentication and Permission Functions

' Check if user is logged in
Function isLoggedIn()
    isLoggedIn = (Session("id") <> "" And Session("id") <> Null And Session("id") <> False)
End Function

' Load user permissions
Function loadPermission(appId)
    Dim sql, rsApps, xGroup
    
    sql = "SELECT x1.trx_apps, x1.trx_group, x2.apps_name apps, x2.apps_description apps_desc " & _
          "FROM profileAccess x1 " & _
          "INNER JOIN Apps x2 ON x1.trx_apps = x2.appsID " & _
          "WHERE x1.trx_profile = " & Session("trx_profile") & " " & _
          "AND x1.isActive = 1 " & _
          "AND x1.trx_apps = " & appId & " " & _
          "ORDER BY x2.apps_order"
    
    Set rsApps = setRs(sql, con_profile)
    
    Do While Not rsApps.EOF
        If xGroup = "" Then
            xGroup = rsApps("trx_group")
        Else
            xGroup = xGroup & "," & rsApps("trx_group")
        End If
        rsApps.MoveNext
    Loop
    
    rsApps.Close
    Set rsApps = Nothing
    
    xGroup = RemoveDuplicates(xGroup, ",")
    xGroup = Replace(xGroup, ",,", ",")
    
    Session("xGroup") = xGroup
    loadPermission = xGroup
End Function

' Require authentication
Sub requireAuth()
    If Not isLoggedIn() Then
        Response.Redirect "pages/login.asp"
    End If
End Sub

' Require specific permission
Sub requirePermission(appId)
    Call requireAuth()
    
    Dim permissions
    permissions = loadPermission(appId)
    
    If permissions = "" Then
        Response.Redirect "pages/error.asp?error=access_denied"
    End If
End Sub

' Simple login check (for basic auth)
Function checkBasicAuth(username, password)
    Dim sql, rs
    
    sql = "SELECT StaffID, Name, trx_profile FROM staff " & _
          "WHERE LoginID = '" & safeString(username) & "' " & _
          "AND Password = '" & safeString(password) & "' " & _
          "AND Status_Active = 1"
    
    Set rs = setRs(sql, con_profile)
    
    If Not rs.EOF Then
        Session("id") = rs("StaffID")
        Session("name") = rs("Name")
        Session("trx_profile") = rs("trx_profile")
        checkBasicAuth = True
    Else
        checkBasicAuth = False
    End If
    
    rs.Close
    Set rs = Nothing
End Function
%> 