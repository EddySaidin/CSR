<%
' Database Connection Configuration
Dim con_main
Dim con_profile

' Main application database
con_main = "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=your_username;password=your_password;Initial Catalog=your_database;Data Source=your_server"

' Profile/authentication database (if separate)
con_profile = "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=your_username;password=your_password;Initial Catalog=Profile;Data Source=your_server"

' File upload paths
Dim uploadPath
uploadPath = "C:\inetpub\wwwroot\uploads\"

' Database timeout settings
Dim dbTimeout
dbTimeout = 30 ' seconds
%> 