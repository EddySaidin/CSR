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

'------------------------------------------------------------------------------
' FORM SUBMISSION HANDLING
'------------------------------------------------------------------------------
trigbtn = ProtectSQL(request.form("trigbtn"))

' Handle insert operation (trigbtn = "1")
If trigbtn = "1" Then
    ' Debug information (optional - can be removed in production)
    Response.Write "EmployeeCode: " & sessionInfo("EmployeeCode") & "<br>"
    Response.Write "Description: " & Request.Form("description") & "<br>"
    Response.Write "ApplicationType: " & Request.Form("application_type") & "<br>"

    '------------------------------------------------------------------------------
    ' BUILD PARAMETERIZED SQL INSERT QUERY
    '------------------------------------------------------------------------------
    sql = "INSERT INTO Trans_cidcardapplications " & _
          "(token, trx_employeeNo, status, description, applicationType, LastUpdate_Date, LastUpdate_By, Created_Date) " & _
          "VALUES ('" & sessionInfo("token") & "', ?, 'Pending', ?, ?, getdate(), ?, getdate())"

    '------------------------------------------------------------------------------
    ' PREPARE PARAMETERS FOR PARAMETERIZED QUERY
    ' Format: Array("@paramName", dataType, size, direction, nullability, value)
    '------------------------------------------------------------------------------
    arr_employeeNo      = Array("@param01", 202, 1, -1, IIF_Null(sessionInfo("EmployeeCode")))
    arr_description     = Array("@param02", 203, 1, -1, IIF_Null(Request.Form("description")))
    arr_applicationType = Array("@param03", 202, 1, -1, IIF_Null(Request.Form("application_type")))
    arr_lastUpdateBy    = Array("@param04", 202, 1, -1, IIF_Null(sessionInfo("EmployeeCode")))

    ' Combine all parameters into one array
    arrlist = Array(arr_employeeNo, arr_description, arr_applicationType, arr_lastUpdateBy)

    ' Execute parameterized query
    Set stmt = ParaRs(sql, arrlist, con_cidcard)

    ' Redirect to success message page
    Response.Redirect "?action=msg&msgid=1&lvl=ecicardinitiator"
end if
%>

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
                            <input class="form-control" value="-" disabled />
                        </div> 
                    </div>
                    <div class="col-md">
                        <label class="form-label">Tarikh</label>  
                        <div></div> 
                        <div>
                            <input class="form-control" value="<%=dateformat(DATE)%>" disabled />
                        </div> 
                    </div>
                </div>
                
                <!-- Status and Created By Row -->
                <div class="row g-3 mb-3">
                    <div class="col-md">
                        <label class="form-label">Status</label>
                        <div>
                            <input class="form-control" value="New" disabled />
                        </div>
                    </div>
                    <div class="col-md">
                        <label class="form-label">Created By & Date</label>
                        <div>
                            <input class="form-control" 
                                   value="<%=requestorname(Session.contents("staffid")) &" - "&DATE%>" 
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
                                  required><%=submittedDescription%></textarea> 
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
                                   <%If submittedApplicationType = "BAHARU" Then Response.Write "checked"%> 
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
                                   <%If submittedApplicationType = "PEMBAHARUAN" Then Response.Write "checked"%> 
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
            
            <!-- Create Button -->
            <button id="btnSave" class="btn btn-primary">
                <i class="fas fa-save"></i>&nbsp;&nbsp;CREATE
            </button>

            <!-- Reset Button -->
            <a href="?action=addecicardinitiator">
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