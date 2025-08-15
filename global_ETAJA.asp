<%
uploadPathecidcard  = "G:\Project\ETAJA\upload\"
filepath        = "apps\ETAJA\upload\"
Dim allowedFilesUpload
allowedFilesUpload = "htm,txt,jpg,gif,png,pdf"

Dim maxFileUploadSize
maxFileUploadSize = 10000000

Dim totalMaxFileUploadSize
totalMaxFileUploadSize = 20000000
Dim formdataid
Set formdataid = Server.CreateObject("aspSmartUpload.SmartUpload")
Dim id
id = fid(request.querystring("id"))
if id="" then id= fid(formdataid.form("id"))
'response.write request.form("id")
set formdataid = nothing

Dim imagePath
imagePath = "images/"

Dim iconPath
iconPath = "images/icons1/"

Dim formSubmitAction
Dim targetFrame
%>