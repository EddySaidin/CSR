<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../inc.asp"-->
<!--#include file="../plugin/clsUpload.asp"-->
<%
response.write uploadPathecidcard
Dim o
set o = new clsUpload
if o.Exists("token") then 
	if o("txtFile").Length <= 20485760 then
		'KALAU UPLOAD EMPTY
		if o.FileNameOf("txtFile") <> "" then
			'GET FILE NAME WITHOUT PATH
			timesuffix1 = replace(udatelong(now()), ":", "")
			timesuffix2 = replace(timesuffix1, " ", "")
			timesuffix  = replace(timesuffix2, "-", "")
			
			
			sFileSplit = split(timesuffix & "_" & o.FileNameOf("txtFile"), "\")
			sFile = sFileSplit(Ubound(sFileSplit))

			o.FileInputName = "txtFile"
			o.FileFullPath = uploadPathecidcard & sFile
			o.save
			
			'response.Write o.FileFullPath
			'response.Write o.Error
			
			if o.Error = "" then                                                
                sql = "INSERT INTO Upload_cidcard ("
                sql = sql & "token, "
                sql = sql & "token_trans_cidcard, "
                sql = sql & "trx_trans_cidcardapplications, "
                sql = sql & "rename, " 
                sql = sql & "fileName, "
                sql = sql & "fileType, "
                sql = sql & "fileSize, "
                sql = sql & "uploaded_by, "
                sql = sql & "uploaded_datetime "
                sql = sql & ") VALUES ("
                sql = sql & "'" & o.ValueOf("new_token")   & "', "
                sql = sql & "'" & o.ValueOf("existing_token_trans_cidcardapplications")   & "', "
                sql = sql & "'" & o.ValueOf("trx_trans_cidcardapplications")   & "', "
                sql = sql & "'" & o.ValueOf("rename")   & "', "
                sql = sql & "'" & sFile   & "', "
                sql = sql & "'" & o("txtFile").ContentType & "', "
                sql = sql & "'" & o("txtFile").Length & "', "
                sql = sql & CInt(Session("staffid")) & ", "
                sql = sql & "getDate()) "
                
                response.Write sql
                set insupload  = setRS(sql, con_cidcard)
                
                'response.write "Success."& o.ValueOf(("trx_id"))      
                response.Redirect("default.asp?action=editecicardinitiator&token="& o.ValueOf("token") &"&statussave=3")      
            else
				response.write "Failed due to the following error: " & o.Error
			end if
		end if
	else
		response.Write "Files is too large"  
	end if
end if
set o = nothing
%>

<script>
    console.log("Upload Success");

</script>