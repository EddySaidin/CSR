<!--#include file="../../global.asp"-->
<%
on error resume next
Dim action, fileToReadExec, tajuk

action 		   = ""
fileToReadExec = "home.asp"
action 		   = replace(LCASE(Request.QueryString("action")), "'", "")

Select Case action
	'TRANSACTION
	'Initiator
	Case LCASE("ecicardinitiator"):
		fileToReadExec = "Trans_Init/s_ecicardinitiator.asp"
		tajuk = "eCICard Application"
	Case LCASE("addecicardinitiator"):
		fileToReadExec = "Trans_Init/a_ecicardinitiator.asp"
		tajuk = "eCICard Application (Create New)"
	Case LCASE("editecicardinitiator"):
		fileToReadExec = "Trans_Init/e_ecicardinitiator.asp"
		tajuk = "eCICard Application (Edit)"
	Case LCASE("ecicardinitiatorjs"):
		fileToReadExec = "Trans_Init/ecicardinitiator.js"
		tajuk = "eCICard Application JS"
	'START FILE UPLOAD
	Case LCASE("u_ecicardinitiatorfile"):
		fileToReadExec = "Trans_Init/uploadMain_r.asp"
		tajuk = "Upload eCICard Application Documents"
	'END FILE UPLOAD
		
	'SM eCICard APPROVAL
	Case LCASE("smapproval"):
		fileToReadExec = "Trans_SM/s_ecicsm.asp"
		tajuk = "eCICard - SM Approval"
		
	'Processor 
	Case LCASE("processor"):
		fileToReadExec = "Trans_Pros/s_ecicardprocessor.asp"
		tajuk = "eCICard Processor"
	
	
	'LISTING
	Case LCASE("listing"):
		fileToReadExec = "Listing/s_ecicardlisting.asp"
		tajuk = "List of eCICard Application"		
		
	
	'INFORMATION SETUP
	'Card Application Status
	Case LCASE("cardapplicationstatus"):
		fileToReadExec = "Setup_cardapplicationstatus/s_cardapplicationstatus.asp"
		tajuk = "List of Card Application Status"

	'POPULATE
	Case LCASE("auto_search_staff"):
		fileToReadExec = "Populate/auto_search_staff.asp"
		tajuk = "Search Staff"
		
	'BASIC
	Case LCASE("msg"):
		fileToReadExec = "msg.asp"
		tajuk = "Message"
	Case LCASE("nopermission"):
		fileToReadExec = "nopermission.asp"
		tajuk = "No Permission"
	Case LCASE("usermanual"):
		fileToReadExec = "usermanual.asp"
		tajuk = "User Manual List"
	case "sapdirectory"
		fileToReadExec = "sapdirectory/sapdirectory.asp"
		tajuk = "FTP - END TO END DIRECTORY"
			
End Select

SCRIPT_NAME = Request.ServerVariables("SCRIPT_NAME") 
'response.write SCRIPT_NAME
if SCRIPT_NAME = "/a_empty.asp" then
	server.Execute("Apps/" & defaultApp & "/" & fileToReadExec)
else
	Call tabx()
end if

if err<0 then
	response.write err.description
	response.write "Apps/" & defaultApp & "/" & fileToReadExec
end if

Private Sub tabx()
%>
	<div class="content mt-3 "> 
		<fieldset class="form-group border p-3 bg-white mb-3">
				<legend class="float-none w-auto px-3 border-0 bg-primary text-white pb-1 pt-1 fw-bold" 
				style="font-size: 16px;"><%=UCASE(tajuk)%></legend> 
				<div class="container-fluid min-h">
					<%server.Execute("Apps/" & defaultApp & "/" & fileToReadExec)%>
				</div>
		</fieldset>
	</div>
<%
End Sub
%>