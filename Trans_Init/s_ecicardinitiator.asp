<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../inc.asp"-->

<%
'==============================================================================
' ECI CARD INITIATOR - MAIN PROCESSING PAGE
'==============================================================================

'------------------------------------------------------------------------------
' DELETE OPERATION HANDLING
'------------------------------------------------------------------------------
if request.form("delete_id") <> "" then
    dim deleteToken
    deleteToken = ReplaceSQL(request.form("delete_id"))
    
    ' Log the delete operation for debugging
    response.write "<!-- DELETE_DEBUG: Starting delete operation -->" & vbCrLf
    response.write "<!-- DELETE_DEBUG: Token to delete: " & deleteToken & " -->" & vbCrLf
    
    ' Build and execute delete query
    sqldel = "DELETE FROM Trans_cidcardapplications WHERE token = '" & deleteToken & "' "
    response.write "<!-- DELETE_DEBUG: SQL Query: " & sqldel & " -->" & vbCrLf
    
    set execdel = ParaRs(sqldel, array(array("@delete_id", 202, 1, -1, deleteToken)), con_cidcard)
    
    ' Return result
    if not execdel is nothing then
        response.write "<!-- DELETE_DEBUG: Delete operation completed successfully -->" & vbCrLf
        response.write "SUCCESS"
    else
        response.write "<!-- DELETE_DEBUG: Delete operation failed or no rows affected -->" & vbCrLf
        response.write "FAILED"
    end if
end if

'------------------------------------------------------------------------------
' SEARCH PARAMETERS PROCESSING
'------------------------------------------------------------------------------
search = ReplaceSQL(request.querystring("search"))
appsNo = ReplaceSQL(request.Form("appsNo"))
datefrom = ReplaceSQL(request.Form("datefrom"))
dateto = ReplaceSQL(request.Form("dateto"))
statusFilter = ReplaceSQL(request.Form("statusFilter"))
appTypeFilter = ReplaceSQL(request.Form("appTypeFilter"))
staffFilter = ReplaceSQL(request.Form("staffFilter"))

'------------------------------------------------------------------------------
' BUILD SQL WHERE CLAUSE FOR FILTERING
'------------------------------------------------------------------------------
sqlWhere = ""

' Filter by Application Number
if appsNo <> "" and searchall(appsNo)=false then
    sqlWhere = sqlWhere & " AND a.application_no LIKE '%" & appsNo & "%' "
end if

' Filter by Status
if statusFilter <> "" and statusFilter <> "all" then
    sqlWhere = sqlWhere & " AND a.status = '" & statusFilter & "' "
end if

' Filter by Application Type
if appTypeFilter <> "" and appTypeFilter <> "all" then
    sqlWhere = sqlWhere & " AND a.applicationType = '" & appTypeFilter & "' "
end if

' Filter by Staff Name
if staffFilter <> "" and searchall(staffFilter)=false then
    sqlWhere = sqlWhere & " AND a.EmployeeName LIKE '%" & staffFilter & "%' "
end if

' Filter by Date Range
if datefrom <> "" then
    ' Convert dd/mm/yyyy to yyyy-mm-dd for SQL
    dim datefromParts, datetoParts, datefromSQL, datetoSQL
    
    if dateto <> "" then
        ' Date range filtering
        datefromParts = split(datefrom, "/")
        datetoParts = split(dateto, "/")
        
        if ubound(datefromParts) = 2 and ubound(datetoParts) = 2 then
            datefromSQL = datefromParts(2) & "-" & right("00" & datefromParts(1), 2) & "-" & right("00" & datefromParts(0), 2)
            datetoSQL = datetoParts(2) & "-" & right("00" & datetoParts(1), 2) & "-" & right("00" & datetoParts(0), 2)
            sqlWhere = sqlWhere & " AND CONVERT(DATE,a.Created_Date) BETWEEN '" & datefromSQL & "' AND '" & datetoSQL & "'"
        end if
    else
        ' Single date filtering
        datefromParts = split(datefrom, "/")
        if ubound(datefromParts) = 2 then
            datefromSQL = datefromParts(2) & "-" & right("00" & datefromParts(1), 2) & "-" & right("00" & datefromParts(0), 2)
            sqlWhere = sqlWhere & " AND CONVERT(DATE,a.Created_Date) = '" & datefromSQL & "'"
        end if
    end if	
end if	

' No permission restrictions - show all data
sqlWhereView = ""
%>

<!--==============================================================================
SEARCH FORM SECTION
==============================================================================-->
<div class="row margin-bottom-10">
    <form method="post" action="?<%=Request.ServerVariables("QUERY_STRING")%>" class="col-sm-10">
        <!-- Search Criteria Row -->
        <div class="row g-3">
            <!-- Application Number Filter -->
            <div class="col-md-4">
                <div class="mb-3">
                    <label class="form-label" for="appsNo">Application No.</label>
                    <small class="text-info">(Type 'all' to show all records)</small>
                    <input type="text" 
                           class="form-control" 
                           id="appsNo" 
                           name="appsNo" 
                           value="<%=appsNo%>" 
                           placeholder="Type to Search" />        
                </div>
            </div>
            
            <!-- Status Filter -->
            <div class="col-md-4">
                <div class="mb-3">
                    <label class="form-label" for="statusFilter">Status</label>
                    <select class="form-select" id="statusFilter" name="statusFilter">
                        <option value="all" <%if statusFilter="all" or statusFilter="" then response.write "selected"%>>All Status</option>
                        <option value="Pending" <%if statusFilter="Pending" then response.write "selected"%>>Pending</option>
                        <option value="Approved" <%if statusFilter="Approved" then response.write "selected"%>>Approved</option>
                        <option value="Rejected" <%if statusFilter="Rejected" then response.write "selected"%>>Rejected</option>
                        <option value="In Progress" <%if statusFilter="In Progress" then response.write "selected"%>>In Progress</option>
                        <option value="Completed" <%if statusFilter="Completed" then response.write "selected"%>>Completed</option>
                        <option value="Cancelled" <%if statusFilter="Cancelled" then response.write "selected"%>>Cancelled</option>
                    </select>
                </div>
            </div>
            
            <!-- Application Type Filter -->
            <div class="col-md-3">
                <div class="mb-3">
                    <label class="form-label" for="appTypeFilter">Application Type</label>
                    <select class="form-select" id="appTypeFilter" name="appTypeFilter">
                        <option value="all" <%if appTypeFilter="all" or appTypeFilter="" then response.write "selected"%>>All Types</option>
                        <option value="BAHARU" <%if appTypeFilter="BAHARU" then response.write "selected"%>>BAHARU (New)</option>
                        <option value="PEMBAHARUAN" <%if appTypeFilter="PEMBAHARUAN" then response.write "selected"%>>PEMBAHARUAN (Renewal)</option>
                    </select>
                </div>
            </div>
            
            <!-- Staff Name Filter -->
            <div class="col-md-3">
                <div class="mb-3">
                    <label class="form-label" for="staffFilter">Staff Name</label>
                    <small class="text-info">(Type to search)</small>
                    <input type="text" 
                           class="form-control" 
                           id="staffFilter" 
                           name="staffFilter" 
                           value="<%=staffFilter%>" 
                           placeholder="Type staff name to search" />        
                </div>
            </div>
        </div>
        
        <!-- Date Range Filter -->
        <div class="mb-3">
            <p class="form-label">Tarikh Permohonan Dari</p>			
            <input type="text" class="w-49 dates" id="datefrom" name="datefrom" value="<%=datefrom%>" />    
            ke
            <input type="text" class="w-49 dates" id="dateto" name="dateto" value="<%=dateto%>" />
        </div>
        
        <!-- Action Buttons -->
        <div class="mb-3 btnctr">
            <button type="submit" name="search" class="btn btn-primary">
                <i class="fa fa-search"></i>&nbsp;&nbsp;SEARCH
            </button>

            <a href="?action=ecicardinitiator">
                <button type="button" class="btn btn-secondary btncust" name="reset">
                    <i class="fa fa-refresh"></i>&nbsp;&nbsp;RESET
                </button>
            </a>

            <a href="?action=addecicardinitiator">
                <button type="button" class="btn btn-success" name="reset">
                    <i class="fa fa-plus"></i>&nbsp;&nbsp;ADD NEW
                </button>
            </a>
        </div>
    </form>
</div>

<!--==============================================================================
RESULTS TABLE SECTION
==============================================================================-->
<%
    ' Only show table if search criteria are provided
    if (search <> "" OR appsNo <> "" OR datefrom <> "" OR dateto <> "" OR statusFilter <> "" OR appTypeFilter <> "" OR staffFilter <> "") then
%>
<div class="table-responsive mt-3">
    <table id="tableecicard" class="table table-bordered table-hover align-middle">
        <!-- Table Header -->
        <thead class="table-success">
            <tr>
                <th>Bil.</th>
                <th>Employee No.</th>
                <th>Employee Name</th>
                <th>Position</th>
                <th>Department</th>
                <th>Division</th>
                <th>Application Type</th>
                <th>Status</th>
                <th>Created Date</th>
                <th align="center" colspan="2">Action</th>
            </tr>
        </thead>
        
        <!-- Table Body -->
        <tbody>
        <%
        '------------------------------------------------------------------------------
        ' DATA RETRIEVAL AND DISPLAY
        '------------------------------------------------------------------------------
        sql = "SELECT * FROM vw_applicationslist a "
        sql = sql & "WHERE 1=1 " & sqlWhere & " " & sqlWhereView & " ORDER BY a.Created_Date DESC"
        
        set stmt = setRs(sql, con_cidcard)

        nom = 0
        do while not stmt.eof
            nom = nom + 1
        %>
            <tr id="delete_<%=stmt("token")%>">
                <!-- Row Number -->
                <td><%=nom%></td>
                
                <!-- Employee Information -->
                <td><%=stmt("trx_employeeNo")%></td>
                <td><%=stmt("EmployeeName")%></td>
                <td><%=stmt("PositionName")%></td>
                <td><%=stmt("Department")%></td>
                <td><%=stmt("Division")%></td>
                
                <!-- Application Type with Badge -->
                <td>
                    <span class="badge 
                        <%if stmt("applicationType")="BAHARU" then%>bg-primary
                        <%elseif stmt("applicationType")="PEMBAHARUAN" then%>bg-info
                        <%elseif stmt("applicationType")="" or isNull(stmt("applicationType")) then%>bg-secondary
                        <%else%>bg-light text-dark<%end if%>">
                        <%if stmt("applicationType")="" or isNull(stmt("applicationType")) then%>N/A<%else%><%=stmt("applicationType")%><%end if%>
                    </span>
                </td>
                
                <!-- Status with Badge -->
                <td>
                    <span class="badge 
                        <%if stmt("status")="Pending" then%>bg-warning
                        <%elseif stmt("status")="Approved" then%>bg-success
                        <%elseif stmt("status")="Rejected" then%>bg-danger
                        <%elseif stmt("status")="In Progress" then%>bg-info
                        <%elseif stmt("status")="Completed" then%>bg-primary
                        <%elseif stmt("status")="Cancelled" then%>bg-secondary
                        <%elseif stmt("status")="" or isNull(stmt("status")) then%>bg-secondary
                        <%else%>bg-light text-dark<%end if%>">
                        <%if stmt("status")="" or isNull(stmt("status")) then%>N/A<%else%><%=stmt("status")%><%end if%>
                    </span>
                </td>
                
                <!-- Created Date -->
                <td><%=dateformat(stmt("Created_Date"))%></td>
                
                <!-- Action Buttons -->
                <td align="center" style="width:30px">
                    <a href="?action=editecicardinitiator&token=<%=stmt("token")%>">
                        <i class="fa-solid fa-edit text-success" alt="edit"></i>
                    </a>
                </td>
                <td align="center" style="width:30px">
                    <a data-toggle="tooltip" 
                       title="Delete Record" 
                       href="javascript:void(0)" 
                       onclick="deleteApplicationRecord('<%=stmt("token")%>');">
                        <i class="fa-solid fa-trash text-danger"></i>
                    </a>
                </td>
            </tr>		
        <% 
        stmt.movenext
        loop
        %>
        </tbody>
    </table>
</div>
<% end if %>

<!--==============================================================================
MODAL AND JAVASCRIPT SECTION
==============================================================================-->
<!-- Delete Modal -->
<div class="modal fade" 
     id="dialogdelete" 
     tabindex="-1" 
     role="dialog" 
     aria-labelledby="deleteModalLabel" 
     aria-hidden="true">
</div>

<!-- JavaScript Loading -->
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

// Staff Filter Autocomplete
$(document).ready(function() {
    $("#staffFilter").autocomplete({
        source: "a_empty.asp?action=auto_search_staff&typp=name",
        minLength: 3,
        select: function(event, ui) {
            if (ui.item === null) {
                $(this).val('').attr("placeholder",'Record does not exist!').addClass('custplahol');
            } else {
                $(this).removeClass("custplahol");
                $('#staffFilter').val(ui.item.value);
            }
        },
        change: function (event, ui) {
            if (ui.item === null) {
                $(this).val('').attr("placeholder",'Record does not exist!').addClass('custplahol');
            } else {
                $(this).removeClass("custplahol");
                $('#staffFilter').val(ui.item.value);
            }
        }
    });
});
</script>