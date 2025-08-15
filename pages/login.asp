<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../includes/functions.asp"-->
<!--#include file="../includes/auth.asp"-->
<!--#include file="../includes/security.asp"-->
<%
pageTitle = "Login - My Application"

' Check if already logged in
If isLoggedIn() Then
    Response.Redirect "../default.asp"
End If

' Process login form
If Request.Form("action") = "login" Then
    Dim username, password
    username = Request.Form("username")
    password = Request.Form("password")
    
    If checkBasicAuth(username, password) Then
        ' Generate CSRF token for new session
        Session("csrftoken") = generateCSRFToken()
        Response.Redirect "../default.asp"
    Else
        errorMessage = "Invalid username or password"
    End If
End If
%>
<!--#include file="../includes/header.asp"-->

<div class="row justify-content-center">
    <div class="col-md-6 col-lg-4">
        <div class="card shadow">
            <div class="card-header bg-primary text-white text-center">
                <h4 class="mb-0"><i class="fas fa-sign-in-alt"></i> Login</h4>
            </div>
            <div class="card-body">
                <% If IsDefined("errorMessage") Then %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle"></i> <%=errorMessage%>
                    </div>
                <% End If %>
                
                <form method="post" action="login.asp">
                    <input type="hidden" name="action" value="login">
                    
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                    </div>
                    
                    <div class="d-grid">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!--#include file="../includes/footer.asp"--> 