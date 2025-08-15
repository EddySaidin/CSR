<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../inc.asp"-->

<%
'==============================================================================
' ECI CARD INITIATOR - ADD NEW APPLICATION PAGE
'==============================================================================

'------------------------------------------------------------------------------
' SESSION AND VARIABLE INITIALIZATION
'------------------------------------------------------------------------------
Dim sessionInfo, key, value
Set sessionInfo = getSessionInfo()
'NEW TOKEN'
new_token = sessionInfo("token")

'GET EXISTING DATA'
existing_token = ProtectSQL(request.QueryString("token"))
sqlApps = "SELECT * FROM vw_applicationslist WHERE token = ?"
set getApps = ParaRs(sqlApps, Array(Array("@token", 202, 1, -1, IIF_Null(existing_token))), con_cidcard)
existing_trx_employeeno = getApps("trx_employeeNo")
existing_applicationtype = getApps("applicationType")
existing_status = getApps("status")
existing_description = getApps("description")
existing_lastupdateBy = getApps("LastUpdate_By")
existing_trx_id = getApps("trx_id")
'GET DOCS
Set getUploadedDocs = setRs("SELECT * FROM getAllCidcardDocs('" & existing_token & "')", con_cidcard)

'------------------------------------------------------------------------------
' FORM SUBMISSION HANDLING
'------------------------------------------------------------------------------
trigbtn = ProtectSQL(request.form("trigbtn"))

' Handle update operation (trigbtn = "0")
If trigbtn = "0" Then
    ' Debug information (optional - can be removed in production)
    Response.Write "UPDATE_DEBUG: EmployeeCode: " & sessionInfo("EmployeeCode") & "<br>"
    Response.Write "UPDATE_DEBUG: Description: " & Request.Form("description") & "<br>"
    Response.Write "UPDATE_DEBUG: ApplicationType: " & Request.Form("application_type") & "<br>"
    Response.Write "UPDATE_DEBUG: Token: " & token & "<br>"

    '------------------------------------------------------------------------------
    ' BUILD PARAMETERIZED SQL UPDATE QUERY
    '------------------------------------------------------------------------------
    sql = "UPDATE Trans_cidcardapplications " & _
          "SET description = ?, applicationType = ?, LastUpdate_Date = getdate(), LastUpdate_By = ? " & _
          "WHERE token = ?"

    '------------------------------------------------------------------------------
    ' PREPARE PARAMETERS FOR PARAMETERIZED QUERY
    ' Format: Array("@paramName", dataType, size, direction, nullability, value)
    '------------------------------------------------------------------------------
    arr_description     = Array("@param01", 203, 1, -1, IIF_Null(Request.Form("description")))
    arr_applicationType = Array("@param02", 202, 1, -1, IIF_Null(Request.Form("application_type")))
    arr_lastUpdateBy    = Array("@param03", 202, 1, -1, IIF_Null(sessionInfo("EmployeeCode")))
    arr_token           = Array("@param04", 202, 1, -1, IIF_Null(token))

    ' Combine all parameters into one array
    arrlist = Array(arr_description, arr_applicationType, arr_lastUpdateBy, arr_token)

    ' Execute parameterized query
    Set stmt = ParaRs(sql, arrlist, con_cidcard)

    ' Redirect to success message page
    Response.Redirect "?action=msg&msgid=0&lvl=ecicardinitiator"
end if


'------------------------------------------------------------------------------
' DELETE OPERATION HANDLING
'------------------------------------------------------------------------------
if request.form("delete_doc_id") <> "" then
    dim deleteToken
    deleteToken = ReplaceSQL(request.form("delete_doc_id"))
    
    ' Log the delete operation for debugging
    response.write "<!-- DELETE_DEBUG: Starting delete operation -->" & vbCrLf
    response.write "<!-- DELETE_DEBUG: Token to delete: " & deleteToken & " -->" & vbCrLf
    
    ' Build and execute delete query
         sqldel = "DELETE FROM Upload_cidcard WHERE token = '" & deleteToken & "' "
     response.write "<!-- DELETE_DEBUG: SQL Query: " & sqldel & " -->" & vbCrLf
     
     set execdel = setRS(sqldel, con_cidcard)
     
     ' Return result
     if not execdel is nothing then
         response.write "<!-- DELETE_DEBUG: Delete operation completed successfully -->" & vbCrLf
         response.write "SUCCESS"
     else
         response.write "<!-- DELETE_DEBUG: Delete operation failed or no rows affected -->" & vbCrLf
         response.write "FAILED"
     end if
end if

%>

<!-- DEBUG AREA -->
<script>
    console.log("Employee No: <%= existing_trx_employeeno %>");
    console.log("Application Type: <%= existing_applicationtype %>");
    console.log("Last Updated By: <%= existing_lastupdateBy %>");
    console.log("Description: <%= existing_description %>");
    console.log("Existing Token: <%= existing_token %>");
    console.log("New Token: <%= new_token %>");
    console.log("TRX ID: <%= existing_trx_id %>");
    <% If Not getUploadedDocs Is Nothing Then %>
        console.log("Uploaded Docs: <%= getUploadedDocs.RecordCount %>");
    <% Else %>
        console.log("Uploaded Docs: [No recordset]");
    <% End If %>
</script>

<!--==============================================================================
MAIN FORM SECTION
==============================================================================-->
<div class="row margin-bottom-10">
    <form method="post" action="" id="apssforms" class="col-sm-12 needs-validation" novalidate>
        
        <!--------------------------------------------------------------------------------
        SESSION DEBUG INFORMATION (HIDDEN)
        -------------------------------------------------------------------------------->
        <div class="d-none">
            <h3>Session Information</h3>
            <%
            For Each key In sessionInfo.Keys
                value = sessionInfo.Item(key)
                If IsNull(value) Or Trim(value) = "" Then
                    Response.Write key & ": no value<br>"
                Else
                    Response.Write key & ": " & value & "<br>"
                End If
            Next
            %>
        </div>

        <!--------------------------------------------------------------------------------
        APPLICATION INFORMATION CARD
        -------------------------------------------------------------------------------->
        <div class="card mb-3">
            <div class="card-header card-bgcust">
                <i class="fa-solid fa-info-circle"></i> Maklumat Permohonan
                <a class="float-end" 
                   data-bs-toggle="collapse" 
                   href="#collapseApps" 
                   aria-expanded="false" 
                   aria-controls="collapseApps">+</a>
            </div>
            
            <div class="card-body collapse show" id="collapseApps">
                <!-- Application Number and Date Row -->
                <div class="row g-3 mb-3">
                    <div class="col-md">
                        <label class="form-label">Application No.</label>
                        <div>
                            <input class="form-control" value="<%=token%>" disabled />
                        </div> 
                    </div>
                    <div class="col-md">
                        <label class="form-label">Tarikh</label>  
                        <div></div> 
                        <div>
                            <input class="form-control" value="<%=dateformat(getApps("Created_Date"))%>" disabled />
                        </div> 
                    </div>
                </div>
                
                <!-- Status and Created By Row -->
                <div class="row g-3 mb-3">
                    <div class="col-md">
                        <label class="form-label">Status</label>
                        <div>
                            <input class="form-control" value="<%=existing_status%>" disabled />
                        </div>
                    </div>
                    <div class="col-md">
                        <label class="form-label">Last Updated By & Date</label>
                        <div>
                            <input class="form-control" 
                                   value="<%=requestorname(existing_lastupdateBy) &" - "&dateformat(getApps("LastUpdate_Date"))%>" 
                                   disabled />
                        </div> 
                    </div>
                </div>
                
                <!-- Employee Name and Department Row -->
                <div class="row g-3 mb-3">
                    <div class="col-md">
                        <label class="form-label">Nama Pemohon & No. Pekerja</label>
                        <div>
                            <input class="form-control" 
                                   value="<%=sessionInfo("EmployeeName") &" ("&Session("loginid")&")"%>" 
                                   disabled />
                        </div> 
                    </div>
                    <div class="col-md">
                        <label class="form-label">Department Code</label>  
                        <div>
                            <input class="form-control" value="<%=sessionInfo("DepartmentCode")%>" disabled />
                        </div> 
                    </div>
                </div>
                
                <!-- Position and Email Row -->
                <div class="row g-3 mb-3">
                    <div class="col-md">
                        <label class="form-label">Jawatan</label>
                        <div>
                            <input class="form-control" value="<%=Nz(sessionInfo("PositionName"), "-")%>" disabled />
                        </div> 
                    </div>
                    <div class="col-md">
                        <label class="form-label">E-Mail</label>  
                        <div>
                            <input class="form-control" value="<%=Nz(sessionInfo("Email1"), "-")%>" disabled />
                        </div> 
                    </div>				
                </div>
                
                <!-- Manager and Department Head Row -->
                <div class="row g-3 mb-3">
                    <div class="col-md">
                        <label class="form-label">IManager</label>
                        <div>
                            <input class="form-control" value="<%=sessionInfo("ManagerName")%>" disabled />
                        </div> 
                    </div>
                    <div class="col-md">
                        <label class="form-label">Ketua Jabatan</label>  
                        <div>
                            <input class="form-control" value="<%=sessionInfo("KJabatanName")%>" disabled />
                        </div> 
                    </div>				
                </div>
            </div>
        </div>

        <!--------------------------------------------------------------------------------
        APPLICATION DETAILS CARD
        -------------------------------------------------------------------------------->
        <div class="card mb-3">
            <div class="card-header card-bgcust">
                <i class="fa-solid fa-archive"></i> Application Details
                <a class="float-end" 
                   data-bs-toggle="collapse" 
                   href="#collapseProject" 
                   aria-expanded="false" 
                   aria-controls="collapseProject">+</a>
            </div>
            
            <div class="card-body collapse show" id="collapseProject">
                <div class="row g-3 mb-3">
                    <!-- Description Field -->
                    <div class="col-md">
                        <label class="form-label">Description*</label>  
                        <textarea class="form-control" 
                                  name="description" 
                                  rows="3" 
                                  required><%=existing_description%></textarea> 
                    </div>
                    
                    <!-- Application Type Radio Buttons -->
                    <div class="col-md">
                        <label class="form-label">Application Type*</label>  
                        
                        <!-- New Application Option -->
                        <div class="form-check">
                            <input class="form-check-input" 
                                   type="radio" 
                                   name="application_type" 
                                   id="typeNew" 
                                   value="BAHARU" 
                                   <%If existing_applicationtype = "BAHARU" Then Response.Write "checked"%> 
                                   required>
                            <label class="form-check-label" for="typeNew">
                                BAHARU
                            </label>
                        </div>
                        
                        <!-- Renewal Application Option -->
                        <div class="form-check">
                            <input class="form-check-input" 
                                   type="radio" 
                                   name="application_type" 
                                   id="typeReplace" 
                                   value="PEMBAHARUAN" 
                                   <%If existing_applicationtype = "PEMBAHARUAN" Then Response.Write "checked"%> 
                                   required>
                            <label class="form-check-label" for="typeReplace">
                                PEMBAHARUAN
                            </label>
                        </div>
                    </div>
                </div>
            </div>          

        </div>
        
        <!--------------------------------------------------------------------------------
        ACTION BUTTONS SECTION
        -------------------------------------------------------------------------------->
        <div class="mb-3 mt-3 text-center btnctr">
            <input type="hidden" name="trigbtn" id="trigbtn" value="" />
            
            <!-- Update Button -->
            <button id="btnUpdate" class="btn btn-primary">
                <i class="fas fa-save"></i>&nbsp;&nbsp;UPDATE
            </button>

            <!-- Reset Button -->
            <a href="?action=editecicardinitiator&token=<%=token%>">
                <button type="button" class="btn btn-secondary btncust" name="reset">
                    <i class="fa fa-refresh"></i>&nbsp;&nbsp;RESET
                </button>
            </a>

            <!-- Cancel Button -->
            <a href="?action=ecicardinitiator">
                <button type="button" class="btn btn-danger btncust" name="cancel">
                    <i class="fa-solid fa-xmark"></i>&nbsp;&nbsp;CANCEL
                </button>
            </a>
        </div>
    </form>


     <div class="row g-1 mb-3">
        <div class="col-md">
            <table id="tableatt" class="table table-sm table-bordered table-hover align-middle">
                <thead class="table-success">
                    <tr>
                        <th colspan="5">
                            Lampiran * <span class="msg msgattachment blink"></span>
                            <span style="float:right">
                                <button type="button" class="btn btn-secondary btn-sm btnUpload">
                                    <i class="fa-solid fa-upload"></i> Muat Naik
                                </button>
                            </span>
                        </th>
                    </tr>
                </thead>
                <tbody class="ups totupload">
                    <tr>
                        <!-- <th>Token</th> -->
                        <!-- <th>TRX Application ID</th> -->
                        <th>File Name</th>
                        <!-- <th>File Name</th> -->
                        <th>File Type</th>
                        <!-- <th>File Size (Bytes)</th> -->
                        <!-- <th>Uploaded By</th> -->
                        <th>Uploaded Date</th>
                        <th colspan="2">Action</th>
                    </tr>

                    <%
                        If Not getUploadedDocs.EOF Then
                            Do Until getUploadedDocs.EOF
                        %>
                            <tr id="delete_<%= getUploadedDocs("token") %>">
                                <td class="d-none"><%= getUploadedDocs("token") %></td>
                                <td class="d-none"><%= getUploadedDocs("trx_trans_cidcardapplications") %></td>
                                <td><%= getUploadedDocs("rename") %></td>
                                <td class="d-none"><%= getUploadedDocs("fileName") %></td>
                                <td><%= getUploadedDocs("fileType") %></td>
                                <td class="d-none"><%= getUploadedDocs("fileSize") %></td>
                                <td class="d-none"><%= getUploadedDocs("uploaded_by") %></td>
                                <td><%= getUploadedDocs("uploaded_datetime") %></td>
                                 <td align="center" style="width:10%">
                                    <a href="apps/ecicard/upload/<%= getUploadedDocs("fileName") %>" data-toggle="tooltip" download title="Download">
                                        <i class="fa-solid fa-download text-success"></i>
                                    </a>
                                </td>
                                <td align="center" style="width:30px">
                                    <a data-toggle="tooltip" 
                                    title="Delete Record" 
                                    href="javascript:void(0)" 
                                    onclick="deleteApplicationDocuments(
                                            '<%= Replace(getUploadedDocs("token"), "'", "\'") %>',
                                            '<%= Replace(existing_token, "'", "\'") %>'
                                    );"
                                        <i class="fa-solid fa-trash text-danger"></i>
                                    </a>
                                </td>
                            </tr>
                        <%
                                getUploadedDocs.MoveNext
                            Loop
                        Else
                        %>
                            <tr>
                                <td colspan="10">No uploaded documents found.</td>
                            </tr>
                        <%
                        End If
                    %>


                
                    <!-- No file message row if no documents exist -->
                    <!--
                    <tr class="nofail">
                        <td colspan="4" align="center">--Tiada Fail--</td>
                    </tr>
                    -->
                </tbody>
            </table>

            <!-- Replace totup value as needed -->
            <div id="ref">
                <input type="hidden" id="totup" value="2" />
            </div>
        </div>
    </div>

    
<div class="modal fade DialogUpload" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
	<div class="modal-dialog modal-dialog-centered" role="document">
		<div class="modal-content rounded-0">
			<div class="modal-body p-4 px-5">
				<div class="main-content">	
                    <div class="upload-icon mb-4">
                        <i class="fa-solid fa-upload"></i>
                    </div>
                    <form id="formUpload" action="a_empty.asp?action=u_ecicardinitiatorfile" enctype="multipart/form-data" method="post" class="needs-validation">
                        <div class="row g-3 mb-3">
                            <div class="col-md">
                                <label class="form-label">Senarai Semak Dokumen</label>
                                <select class="form-control trx_checklist" name="trx_checklist" id="trx_checklist" required>
                                    <option value="">--Select--</option>
                                    <option id="opt3" value="3">Surat Sokongan</option>
                                    <option id="opt10" value="10">Gambar Passport</option>
                                    <option id="opt11" value="11">Salinan IC</option>
                                    <option id="opt12" value="12">Salinan Sijil</option>
                                    <option id="opt13" value="13">Borang Permohonan</option>
                                </select>
                                <span class="msg msgchecklist blink"></span>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md">
                                <label class="form-label">Nama Fail</label>  
                                <input type="text" class="form-control rename" name="rename" id="rename" required /> 
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md">
                                <input type="file" class="form-control" name="txtFile" id="f" required />

                                <!-- Replace values below as needed -->
                                <input name="token" type="hidden" value="<%=new_token%>" />
                                <input name="existing_token_trans_cidcardapplications" type="hidden" value="<%=existing_token%>" />
                                <input name="new_token" type="hidden" value="<%=new_token%>" />
                                <input name="action" type="hidden" value="u_initiatorfile" />
                                <input name="trx_trans_cidcardapplications" type="hidden" value="<%=existing_trx_id%>" />
                            </div>
                        </div>

                        <div class="d-flex">
                            <div class="mx-auto modal-footer">
                                <button type="button" class="buttons btn btn-primary submitupload">Upload</button>
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" id="cancel">Cancel</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>

<!--==============================================================================
JAVASCRIPT SECTION
==============================================================================-->
<script type="text/javascript">
jQuery.loadScript = function (url, callback) {
    jQuery.ajax({
        url: url,
        dataType: 'script',
        success: callback,
        async: true
    });
}

// Load additional JavaScript if not already loaded
if(typeof someObject == 'undefined') {
    $.loadScript('a_empty.asp?action=ecicardinitiatorjs', function(){});
}
</script>