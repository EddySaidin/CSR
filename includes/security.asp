<%
' Security Utility Functions

' Generate CSRF token
Function generateCSRFToken()
    Dim guid
    guid = CreateObject("Scriptlet.TypeLib").GUID
    generateCSRFToken = guid
End Function

' Validate CSRF token
Function validateCSRFToken(token)
    validateCSRFToken = (Session("csrftoken") = token)
End Function

' Sanitize input
Function sanitizeInput(input)
    If IsNull(input) Then
        sanitizeInput = ""
    Else
        sanitizeInput = Replace(Replace(input, "<", "&lt;"), ">", "&gt;")
    End If
End Function

' Generate random string
Function generateRandomString(length)
    Dim chars, result, i
    chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    result = ""
    
    Randomize
    For i = 1 To length
        result = result & Mid(chars, Int(Rnd() * Len(chars)) + 1, 1)
    Next
    
    generateRandomString = result
End Function

' Hash password (basic implementation)
Function hashPassword(password)
    ' In production, use proper hashing like bcrypt
    ' This is just a placeholder
    hashPassword = password
End Function

' Validate email format
Function isValidEmail(email)
    Dim pattern
    pattern = "^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$"
    
    ' Basic email validation
    If InStr(email, "@") > 0 And InStr(email, ".") > InStr(email, "@") Then
        isValidEmail = True
    Else
        isValidEmail = False
    End If
End Function

' Log security events
Sub logSecurityEvent(eventType, description, userId)
    Dim sql, rs
    
    sql = "INSERT INTO SecurityLog (event_type, description, user_id, ip_address, log_datetime) " & _
          "VALUES ('" & safeString(eventType) & "', '" & safeString(description) & "', " & _
          safeNumber(userId) & ", '" & Request.ServerVariables("REMOTE_ADDR") & "', GETDATE())"
    
    Set rs = setRs(sql, con_profile)
    Set rs = Nothing
End Sub
%> 