<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../includes/functions.asp"-->
<%
pageTitle = "Error - My Application"

Dim errorType, errorMessage
errorType = Request.QueryString("error")

Select Case errorType
    Case "access_denied"
        errorMessage = "You do not have permission to access this resource."
    Case "not_found"
        errorMessage = "The requested page was not found."
    Case "server_error"
        errorMessage = "An internal server error occurred."
    Case Else
        errorMessage = "An unexpected error occurred."
End Select
%>
<!--#include file="../includes/header.asp"-->

<div class="row justify-content-center">
    <div class="col-md-8">
        <div class="card border-danger">
            <div class="card-header bg-danger text-white">
                <h4 class="mb-0"><i class="fas fa-exclamation-triangle"></i> Error</h4>
            </div>
            <div class="card-body text-center">
                <i class="fas fa-exclamation-circle fa-5x text-danger mb-3"></i>
                <h5 class="card-title">Something went wrong</h5>
                <p class="card-text"><%=errorMessage%></p>
                <a href="../default.asp" class="btn btn-primary">
                    <i class="fas fa-home"></i> Go Home
                </a>
            </div>
        </div>
    </div>
</div>

<!--#include file="../includes/footer.asp"--> 