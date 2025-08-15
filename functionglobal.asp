<%
session.lcid = 2057

'CONNECTION QUERY
Private Function setRs(cmdx, dbconn)
	Dim rs, rs_cmd
	Set rs_cmd = Server.CreateObject("ADODB.Command")
	
	rs_cmd.ActiveConnection = dbconn
	rs_cmd.CommandText 		= cmdx
	rs_cmd.CommandTimeout 	= 120
	rs_cmd.Prepared 		= True
	
	'response.write rs_cmd.CommandText
	Set setRs = rs_cmd.execute
End Function

'Execute query directly without recordset
Private Function setExec(cmdx,dbconn)
	On Error Resume Next
	Dim rs, rs_cmd
	Set rs_cmd = Server.CreateObject("ADODB.Command")
	rs_cmd.ActiveConnection = dbconn
	rs_cmd.CommandText = cmdx
	rs_cmd.Prepared = True
	rs_cmd.execute
	if err then
		setExec = false
	else
		setExec = true
	end if
	
End Function

'QUERY USING PARAMETER
Private Function ParaRs(cmdtxt, arr, conn)
	Dim para_cmd, i
	
	Set para_cmd = Server.CreateObject ("ADODB.Command")
	para_cmd.ActiveConnection = conn
	para_cmd.CommandText = cmdtxt
	para_cmd.Prepared = true 
	With para_cmd
		for each i in arr
			.Parameters.Append .CreateParameter(i(0), i(1), i(2), i(3), i(4))
		next
	End With
	
	set ParaRs = para_cmd.Execute
End Function

'AUTO GET ID VALUE
Private Function fid(idx)
	if not isNumeric(idx) then
		if isNull(idx) or len(trim(idx)) = 0 then
			Response.Redirect("?action=home")
		else
			Response.Redirect("?action=error&errid=2")
		end if
	else
		fid = idx
	end if
End Function

'OLD PERMISSION STYLE
private function permission(v1,v2)
	if v1<>"0" then
		dim xyz 
		xyz = split(v1,",")	
		dim found
		found = 0
		for i=0 to ubound(xyz)
			if v2=xyz(i) then
				found = found + 1
				exit for
			end if
		next
		if found>0 then 
			permission = true 'true
		else
			permission = false 'false
		end if
	else
		permission = false 'false
	end if
end function

'NEW PERMISSION STYLE
private function permission2(v2)
	if session("perm")<>"0" then
		dim xyz 
		xyz = split(lcase(session("perm")),",")	
		dim found
		found = 0
		for i=0 to ubound(xyz)
			if lcase(v2)=xyz(i) then
				found = found + 1
			exit for
			end if
		next
	
		if found>0 then 
			permission2 = true 'true
		else
			permission2 = false 'false
		end if
	else
		permission2 = false 'false
	end if
end function

'RANDOM STRING WITHOUT SYMBOL
function RandomString2()
    Randomize()

    dim CharacterSetArray
    CharacterSetArray = Array(_
        Array(15, "abcdefghijklmnopqrstuvwxyz"), _
		Array(15, "ABCDEFGHIJKLMNOPQRSTUVWXYZ"), _
        Array(15, "0123456789") _
    )

    dim i
    dim j
    dim Count
    dim Chars
    dim Index
    dim Temp

    for i = 0 to UBound(CharacterSetArray)
        Count = CharacterSetArray(i)(0)
        Chars = CharacterSetArray(i)(1)
        for j = 1 to Count
            Index = Int(Rnd() * Len(Chars)) + 1
            Temp = Temp & Mid(Chars, Index, 1)
        next
    next

    dim TempCopy

    do until Len(Temp) = 0
        Index 	 = Int(Rnd() * Len(Temp)) + 5
        TempCopy = TempCopy & Mid(Temp, Index, 5)
        Temp 	 = Mid(Temp, 5, Index - 1) & Mid(Temp, Index + 5)
    loop

    RandomString2 = TempCopy
end function

'SELECTED ITEM
Private Function selectedItem(x1,x2)
	if trim(x1)=trim(x2) then 
		selectedItem = " selected "
	else
		selectedItem = ""
	end if
End Function

'CHECKED ITEM
Private Function checkedItem(x1,x2)
	if trim(x1)=trim(x2) then 
		checkedItem = " checked "
	else
		checkedItem = ""
	end if
End Function

'CONVERT DATE : Y-M-D
Private Function udateformat(p_date)
	if isDate(p_date) then
		udateformat=  year(p_date) & "-" &  right("00" & month(p_date),2) & "-" & right("00" & day(p_date),2)
		if udateformat="1900-1-1" then
			udateformat = "N/A"
		end if
	else
		udateformat = p_date
	end if
End Function

'CONVERT DATE : D/Y/M
Private Function dateformat(p_date)
	if isDate(p_date) then
		dateformat=  right("00" & day(p_date),2) & "/" &  right("00" & month(p_date),2) & "/" & year(p_date)
		if dateformat="1900-1-1" then
			dateformat = "N/A"
		end if
	else
		dateformat = p_date
	end if
End Function

'CONVERT DATE : Y-M-D H:S
Private Function udatelong(p_date)
	if isDate(p_date) then
		udatelong = year(p_date) & "-" & right("00" + cstr(month(p_date)),2) & "-"
		udatelong = udatelong & right("00" + cstr(day(p_date)),2) & " " & right("00" + cstr(hour(p_date)),2)
		udatelong = udatelong & ":" & right("00" + cstr(minute(p_date)),2)  & ":" & right("00" + cstr(second(p_date)),2)
		
		if udatelong="1900-01-01 00:00:00" then
			udatelong = null
		end if
	else
		udatelong = p_date
	end if
End Function

Private Function datelong(p_date)
	if isDate(p_date) then
		datelong =  right("00" & day(p_date),2) & "/" &  right("00" & month(p_date),2) & "/" & year(p_date) & " " & right("00" + cstr(hour(p_date)),2)
		datelong = datelong & ":" & right("00" + cstr(minute(p_date)),2)  & ":" & right("00" + cstr(second(p_date)),2)
		
		if datelong="1900-01-01 00:00:00" then
			datelong = null
		end if
	else
		datelong = p_date
	end if
End Function

'GET TIME : H:S
Private Function utime(p_date)
	if isDate(p_date) then
		utime = right("00" + cstr(hour(p_date)),2)
		utime = utime & ":" & right("00" + cstr(minute(p_date)),2)
		'utime = utime & ":" & right("00" + cstr(second(p_date)),2)
		
		if utime="1900-01-01 00:00:00" then
			utime = null
		end if
	else
		utime = p_date
	end if
End Function

function ampmTime(InTime)
	if hour(InTime) < 12 then
		OutHour = hour(InTime)
		ampm = "am"
	end if
	
	if hour(InTime) = 12 then
		OutHour = hour(InTime)
		ampm = "pm"
	end if
	
	if hour(InTime) > 12 then
		OutHour = hour(InTime) - 12
		ampm = "pm"
	end if
	
	minutes = minute(intime)
	IF LEN(minutes) < 2 THEN minutes = minutes & "0"
	
	IF LEN(OutHour) < 2 THEN OutHour = "0" & OutHour
	
	ampmTime = OutHour & ":" & minutes & ampm
end function

'REMOVE LAST COMMA
function ctrim(str, trimstr)
	while trim(left(str,1))=trimstr
		str=trim(right(str,Len(str)-1))
	wend
	
	while trim(right(str,1))=trimstr
		str=trim(Left(str,Len(str)-1))
	wend
	ctrim=str
end function

function deleteLastComma(valStr)
	if valStr <> "" then
		lastCommaPos = instrrev(valStr, ",")
		valStr = mid(valStr, 1, lastCommaPos - 1)
		deleteLastComma = valStr
	end if
end function

Function ProtectSQL(SQLString)
	SQLString = Replace(SQLString, "&", "&amp;")
	SQLString = Replace(SQLString, "'", "&#39;") ' replace single Quotes with Double Quotes
	SQLString = Replace(SQLString, ">", "&gt;") ' replace > with &gt;
	SQLString = Replace(SQLString, "<", "&lt;") ' replace < with &lt;
	SQLString = Replace(SQLString, "(",	"&#40;") ' replace ( with &#40;
	SQLString = Replace(SQLString, ")",	"&#41;") ' replace ) with &#41;
	SQLString = Replace(SQLString, "%", "&#37;")
	' replace vblf with <br /> (This is mainly used for Memo fields).
	SQLString = Replace(SQLString, vblf,"<br />") 
	SQLString = Trim(SQLString)
	ProtectSQL = SQLString
End Function

'NOT SUITABLE FOR EDITOR WITH HTML SUCH AS TINYMCE
Function ReverseSQL(SQLString)
	SQLRevString = Replace(SQLRevString, "&#39;", "'") 
	SQLRevString = Replace(SQLRevString, "&gt;", ">") 
	SQLRevString = Replace(SQLRevString, "&lt;", "<") 
	SQLRevString = Replace(SQLRevString, "&#40;","(") 
	SQLRevString = Replace(SQLRevString, "&#41;",")") 
	SQLRevString = Replace(SQLRevString, "&amp;", "&")
	SQLRevString = Replace(SQLRevString, "%", "&#37;")
	SQLRevString = Replace(SQLRevString,"<br />", vblf)
	SQLRevString = Trim(SQLRevString)
	ReverseSQL = SQLRevString
End Function

Function ReplaceSQL(SQLString)
	SQLString = Replace(SQLString, "'", "") ' replace single Quotes with Double Quotes
	SQLString = Trim(SQLString)
	ReplaceSQL = SQLString
End Function

' IIf implementation
Function RR_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    RR_IIf = ifFalse
  Else
    RR_IIf = ifTrue
  End If
End Function

'WAYLEAVE ISSUEMOVE
Private Function issuemove(i,frsec,tosec,frid,frdt)
	on error resume next
	Dim upCon, upRec, upLog
	Set upCon 	= Server.CreateObject("ADODB.Connection")
	upCon.Open 	= con_wayleave
	
	Set upLog 					= Server.CreateObject("ADODB.Recordset")
	Set upLog.ActiveConnection 	= upCon
	upLog.Source				= "Select * from IssueMovement"
	
	upLog.LockType = 3
	upLog.Open	
	
	upLog.AddNew	
	upLog("Trx_Issue") 		= i
	upLog("From_section") 	= frsec
	upLog("From_by") 		= frid				
	upLog("From_date") 		= frdt
	upLog("To_section") 	= tosec
	upLog("To_by") 			= Session.Contents("staffID")		
	upLog("To_date") 		= Now() 
	upLog.update	
	upLog.Close
	
	upCon.Close			
		
	if err then
		response.Redirect("?action=error&errorid=5")
	end if
End Function

'IFNULL
function IIF_Null(str)
	if str = "" then
		IIF_Null = NULL
	else
		IIF_Null = str
	end if
end function

function emailContent(appno,token,lvl,project_name,requestorname,requestorno,trxzon,trxarea)
	
	'url = "https://appsuat.sesb.com.my/"
	url = "https://apps.sesb.com.my/"
	sqlZonArea 	= "SELECT * FROM vw_zonearea WHERE trx_zone='"&trxzon&"' AND trx_area='"&trxarea&"' "
	set getZonArea   = setRs(sqlZonArea, con_ETAJA)
	if not getZonArea.eof then
		zone    = getZonArea("zone")
		daerah  = getZonArea("area")
	end if
	'response.write reg&" "&area&" "&subs
	
	'SENDING EMAIL CODING START HERE
	ec = "Hi, Mr./Ms. <br />"
	ec = ec & "<br />"		
	ec = ec & "<span>This is a notification from the Land and Wayleave Application System.</span><br />"
	ec = ec & "Applicaton No. "& appno &" "
	
	'SUBMITTED
	if lvl = 1 then		
		ec    = ec & "<span>has been submitted to IM Submission.</span><br />"	
		links = url&"?action=editETAJAinitiator&token="&token&"&app=LAWA&redirect=true"
	'response.write links 
	elseif lvl = 2 then	
		ec    = ec & "<span>has been submitted to Ketua Jabatan for Verification.</span><br />"	
		links = url&"?action=editETAJAim&token="&token&"&app=LAWA&redirect=true"
	'response.write links 
	elseif lvl = 3 then		
		ec = ec & "<span>has been submitted to SM LPW.</span><br />"
		links = url&"?action=editsmapproval&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 4 then
		ec = ec & "<span>has been submitted to PIC for Checking.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 5 then
		ec = ec & "<span>has been submitted to PIC for RFC & JAHT Memo Updates.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 6 then
		ec = ec & "<span>has been submitted to PIC for Perlantikan Juruukur Updates.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 7 then
		ec = ec & "<span>has been submitted to PIC for Lawatan Tapak Updates.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 8 then
		ec = ec & "<span>has been submitted to Report Verifier.</span><br />"
		links = url&"?action=editpicreport&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 9 then
		ec = ec & "<span>has been submitted to SM LPW for Approval. </span><br />"
		links = url&"?action=editsmapproval&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 10 then
		ec = ec & "<span>has been submitted to PIC for Sebutharga Updates.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 12 then
		ec = ec & "<span>has been submitted to PIC Pembayaran.</span><br />"
		links = url&"?action=editETAJApembayaran&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 13 then
		ec = ec & "<span>has been submitted to PIC for Status Izin Lalu Updates.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 14 then
		ec = ec & "<span>has been submitted to PIC for Penyerahan Izin Lalu.</span><br />"
		links = url&"?action=editpiccheck&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = 20 then
		ec = ec & "<span>has been Completed.</span><br />"
		links = url&"?action=desclisting&token="&token&"&app=LAWA&redirect=true"
		
	'REJECTED
	elseif lvl = "21" then
		ec = ec & "<span>has been reverted to Initiator for Correction.</span><br />"
		links = url&"?action=editETAJAinitiator&token="&token&"&app=LAWA&redirect=true"
	elseif lvl = "24" then
		ec = ec & "<span>has been reverted to PIC for Correction.</span><br />"
		links = url&"?action=editETAJAinitiator&token="&token&"&app=LAWA&redirect=true"
		
	'TERMINATE
	elseif lvl = "9" then
		ec = ec & "<span>has been declined by DCC Planning.</span><br />"
		links = url&"?action=l_desc_dns&token="&token&"&app=DNS&redirect=true"
	elseif lvl = "15" then
		ec = ec & "<span>has been declined by JPO Engineer.</span><br />"
		links = url&"?action=l_desc_dns&token="&token&"&app=DNS&redirect=true"

	end if
	'response.end
	'DEFAULT EMAIL FOR ALL LEVEL
	ec = ec & "<br />"
	ec = ec & "<strong>Application Details</strong><br />"
	ec = ec & "Application No.: " & appno & "<br />"
	ec = ec & "Tajuk Projek: " & project_name & "<br />"
	ec = ec & "Requestor Name: " & requestorname & "<br />"
	ec = ec & "Requestor No.: " & requestorno & "<br />"
	ec = ec & "Zon: " & zone & "<br />"
	ec = ec & "Daerah: " & daerah & "<br />"
	ec = ec & "<BR /><B>Click <a href="&links&">Here</a> to Log In into the System.</B>"
	ec = ec & "<br /><BR /><BR /><B><center>(This is an automated email, please do not reply to this email)</center></B>"	
	emailContent = ec
	
	end function



'SPLIT REMARKS
function srem(str)
	if str <> "" then
		txt   = split(str, ") :")
		srem = LEFT(str, 19) &" - "&txt(1)
	end if
end function

'GENERATE LENGTH OF REFERENCE NO.
function length_reference_no(number, width)
   dim lengthofnum : lengthofnum = cStr(number)

   while (len(lengthofnum) < width)
	   lengthofnum = "0" & lengthofnum
   wend

   length_reference_no = lengthofnum
end function	

function token_transcicard()

	set getToken = setRs("SELECT (row_number() over(order by trx_id)) AS rowid, (NEWID()) AS newtoken FROM Trans_cidcardapplications WHERE NOT token='' ", con_cidcard)
	if not getToken.eof then
		token_transcicard = getToken("newtoken")		
		token_transcicard = replace(token_transcicard, "{", "")		
		token_transcicard = replace(token_transcicard, "}", "")
	else
		token_transcicard = "D0BA394F-A9D4-4D51-93BA-E1E7A03F2A01"	
	end if

end function

function generatappsno_kiv()	
	
	selectedYear = Year(now())
	init_first   = "LAWA"

	set sqlChkYear = setRs("SELECT COUNT(*) countExist FROM generated_no WHERE table_name='Trans_ETAJA' AND year='"&selectedYear&"' ", con_ETAJA)
	if not sqlChkYear.eof then
		countExist = sqlChkYear("countExist")
	end if

	if countExist = 0 then

		previous_no 	= 0
		current_no  	= 0
		newcurrent_no 	= current_no + 1
		
		yearof 			= selectedYear
		
		appsNo = init_first&"/"&yearof&"/"&length_reference_no(newcurrent_no,3)
		
		sqlYear = "INSERT INTO generated_no (table_name,year,previous_no,current_no) "
		sqlYear = sqlYear &" VALUES ('Trans_ETAJA','"&selectedYear&"','0','1') "
		set sqlInsertYear = setRs(sqlYear, con_ETAJA)
		
	else

		set sqlRefNo = setRs("SELECT previous_no, current_no FROM generated_no WHERE table_name='Trans_ETAJA' AND year='"&selectedYear&"' ", con_ETAJA)
		if not sqlRefNo.eof then
			previous_no 	= sqlRefNo("previous_no")
			current_no  	= sqlRefNo("current_no")
			newcurrent_no 	= current_no + 1
		else
			newcurrent_no = current_no + 1 
		end if
		
		yearof = selectedYear

		appsNo = init_first&"/"&yearof&"/"&length_reference_no(newcurrent_no,3)

	end if
	'response.write appsNo
	 generatappsno = appsNo
	
end function
'END GENERATE LENGTH OF REFERENCE NO.

function requestorname(sid)
	if isNumeric(sid) then
		set stmtgp = setRs("SELECT name FROM profile.dbo.Staff WHERE staffid='"&sid&"'", con_ETAJA)
		if not stmtgp.eof then
			requestorname = stmtgp("name")
		end if
	end if
end function

function gpersno(sid)
	if isNumeric(sid) then
		set stmtgp = setRs("SELECT loginid FROM profile.dbo.staff WHERE staffid='"&sid&"'", con_sccs)
		if not stmtgp.eof then
			gpersno = stmtgp("loginid")
		end if
	end if
end function

function savestatus(token,u,tbl)

	'CHECK EXIST
	set countExt = setRs("SELECT COUNT(*) countExt FROM "&tbl&" WHERE token='"& token &"' AND updated_code='"&u&"' ",con_ETAJA)
	if not countExt.eof then
		countExist = countExt("countExt")
	end if

	if (countExist > 0) then
		set update = setRs("UPDATE "&tbl&" SET updated_code='Updated' WHERE token='"& token &"' ",con_ETAJA)
		savestatus = "<div class='alert alert-info'  role='alert'>Record has been successfully updated to the system.</div>"
		'response.Redirect("?action=e_initiator&token="&token)
	else
		'savestatus = countExist
	end if

end function


function VAL_NULL(x)
	if x="" then
		VAL_NULL=NULL
	else
		VAL_NULL=x			
	end if			
end function

'START
Function Nz(val, defaultVal)
    If IsNull(val) Then
        Nz = defaultVal
    Else
        Nz = val
    End If
End Function

Function getSessionInfo()
    Dim result, token, sqlStaff, sqlKJ
    Dim getStaff, getIM, getKJ
    Dim ManagerName, ManagerEmployeeNo, ManagerEmail
    Dim KJabatanName, KJabatanNo, KJabatanEmail

    Set result = Server.CreateObject("Scripting.Dictionary")

    ' Token
    token = token_transcicard()
    result.Add "token", CStr(token)

    ' PULL STAFF INFORMATION
    sqlStaff = "SELECT * FROM vw_staff_ess WHERE EmployeeCode='" & Session.Contents("loginid") & "' "
    Set getStaff = setRs(sqlStaff, con_cidcard)

    If Not getStaff.EOF Then
        Dim i, fieldName, fieldValue

        For i = 0 To getStaff.Fields.Count - 1
            fieldName = getStaff.Fields(i).Name
            fieldValue = getStaff.Fields(i).Value

            If Not result.Exists(fieldName) Then
                result.Add fieldName, CStr(Nz(fieldValue, ""))
            Else
                result(fieldName) = CStr(Nz(fieldValue, ""))  ' overwrite existing
            End If
        Next
    End If

    getStaff.Close
    Set getStaff = Nothing

    ' GET IM (Immediate Manager)
    Set getIM = setRs("SELECT * FROM getManager(" & Session.Contents("loginid") & ")", con_profile)
    If Not getIM.EOF Then
        ManagerName = Replace(CStr(Nz(getIM("ManagerName"), "")), "'", "")
        
        If Not result.Exists("ManagerName") Then
            result.Add "ManagerName", ManagerName
        Else
            result("ManagerName") = ManagerName
        End If

        If Not result.Exists("ManagerEmployeeNo") Then
            result.Add "ManagerEmployeeNo", CStr(Nz(getIM("ManagerEmployeeNo"), ""))
        Else
            result("ManagerEmployeeNo") = CStr(Nz(getIM("ManagerEmployeeNo"), ""))
        End If

        If Not result.Exists("ManagerEmail") Then
            result.Add "ManagerEmail", CStr(Nz(getIM("email"), ""))
        Else
            result("ManagerEmail") = CStr(Nz(getIM("email"), ""))
        End If
    End If
    getIM.Close
    Set getIM = Nothing

    ' GET KETUA JABATAN
    sqlKJ = "SELECT b.* FROM Setup_verifier a " & _
            "LEFT JOIN vw_staff_ess b ON b.EmployeeCode = a.KJ_employeeNo " & _
            "WHERE a.trx_department='" & result.Item("DepartmentCode") & "' "
    Set getKJ = setRs(sqlKJ, con_cidcard)
    If Not getKJ.EOF Then
        KJabatanName = Replace(CStr(Nz(getKJ("EmployeeName"), "")), "'", "")

        If Not result.Exists("KJabatanName") Then
            result.Add "KJabatanName", KJabatanName
        Else
            result("KJabatanName") = KJabatanName
        End If

        If Not result.Exists("KJabatanNo") Then
            result.Add "KJabatanNo", CStr(Nz(getKJ("EmployeeCode"), ""))
        Else
            result("KJabatanNo") = CStr(Nz(getKJ("EmployeeCode"), ""))
        End If

        If Not result.Exists("KJabatanEmail") Then
            result.Add "KJabatanEmail", CStr(Nz(getKJ("Email1"), ""))
        Else
            result("KJabatanEmail") = CStr(Nz(getKJ("Email1"), ""))
        End If
    End If
    getKJ.Close
    Set getKJ = Nothing

    Set getSessionInfo = result
End Function

%>