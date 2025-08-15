<%
msgid = replace(request.QueryString("msgid"), "'", "")
lvl   = replace(request.QueryString("lvl"), "'", "")
total = replace(request.QueryString("total"), "'", "")

Select Case msgid
	Case "0":
	msg="Record has been successfully updated to the system. <a href='?action="&lvl&"'>Back to List</a>"

	Case "1":
	msg="Record has been successfully added to the system. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "2":
	msg="Record has been successfully deleted from the system. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "3:"
	msg="Record has been completed. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "4":
	msg="Record has been submitted for IM Verification. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "5":
	msg="Record has been submitted for SM LPW Approval. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "6":
	msg="Record has been submitted for PIC Checking. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "7":
	msg="Record has been submitted to Report Verifier for Verification. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "8":
	msg="Record has been submitted to PIC for Additional Visit update. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "9":
	msg="Record has been submitted to PIC for Sebutharga Juruukur update. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "10":
	msg="Record has been submitted to PIC for Payment & Application Status update. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "11":
	msg="Record has been submitted to PIC for Penyerahan Kelulusan Izin Lalu update. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "30":
	msg="Record has been Terminated. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "0":
	msg="Record has been rejected to Correction. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case "100":
	msg="Record has been Completed. <a href='?action="&lvl&"'>Back to List</a>"
	
	Case else
	response.Redirect("?action=home")
End Select
 
if msg <> "" then
    response.Write "<div class='success-box-stay'>"&msg&"</div>"
end if

if msgerr <> "" then
    response.Write "<div class='alert-box-stay'>"&msgerr&"</div>"
end if

if msgid = "" or isnumeric(msgid) = false then
	response.Redirect("?action=nopermission")
end if
%>