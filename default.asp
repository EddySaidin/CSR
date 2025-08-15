<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="includes/functions.asp"-->
<!--#include file="includes/auth.asp"-->
<%
' Check if user is already logged in
If isLoggedIn() Then
    Response.Redirect "pages/dashboard.asp"
Else
    Response.Redirect "pages/login.asp"
End If
%> 