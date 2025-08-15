<!-- Project Card Example -->
<p class="text-white pl-3 pt-1 mb-3 fw-bold border-opacity-50 "><i class="fa-solid fa-qrcode"></i>&nbsp;&nbsp;LAWA AS OF <%=dateformat(DATE)%></p>
<%

'INITIATOR
sqlInit1 = "SELECT COUNT(*) cnt1 FROM Trans_ETAJA WHERE trx_docstatus IN (0,1,21,22,23) "&sqlWhereInit&" "&sqlWhereIM&"  " 
'response.write sqlInit1
set initStmt1 = SetRs(sqlInit1, con_ETAJA)

if(permission2("LAWA_Admin_View") = true) then

	'Ketua Jabatan
	sqlInit2 = "SELECT COUNT(*) cnt2 FROM vw_ETAJAlisting WHERE trx_docstatus IN (2)  " 
	'response write sqlInit2
	set initStmt2 = SetRs(sqlInit2, con_ETAJA)
	
	
	'IN PROGRESS
	sqlInit11 = "SELECT COUNT(*) cnt1 FROM Trans_ETAJA WHERE trx_docstatus IN (2,3,4,5,6,7,10,11,12,13,14,15)  " 
	'response write sqlInit1
	set initStmt11 = SetRs(sqlInit11, con_ETAJA)

else

		if ((getStaff("DivisionCode")="6011") AND ((getStaff("DepartmentCode")="0044") OR (getStaff("DepartmentCode")="3356"))) then

			if(getKJ("cnt") > 0) then 
				'Ketua Jabatan
				sqlInit2 = "SELECT COUNT(*) cnt2 FROM vw_ETAJAlisting WHERE trx_docstatus IN (2) "&sqlWhereDept&"  " 
				'response write sqlInit2
				set initStmt2 = SetRs(sqlInit2, con_ETAJA)
				
				
				'IN PROGRESS
				sqlInit11 = "SELECT COUNT(*) cnt1 FROM Trans_ETAJA WHERE trx_docstatus IN (2,3,4,5,6,7,10,11,12,13,14,15) "&sqlWhereDept&"  " 
				'response write sqlInit1
				set initStmt11 = SetRs(sqlInit11, con_ETAJA)
			
			else
				'IM
				sqlInit2 = "SELECT COUNT(*) cnt2 FROM vw_ETAJAlisting WHERE trx_docstatus IN (2) "&sqlWhereIM&"  " 
				'response write sqlInit2
				set initStmt2 = SetRs(sqlInit2, con_ETAJA)	
				
				'IN PROGRESS
				sqlInit11 = "SELECT COUNT(*) cnt1 FROM Trans_ETAJA WHERE trx_docstatus IN (2,3,4,5,6,7,10,11,12,13,14,15) AND employeeNo = '"&SESSION("LoginID")&"'  " 
				'response write sqlInit1
				set initStmt11 = SetRs(sqlInit11, con_ETAJA)
				
			end if	
			
		else

			'IM
			sqlInit2 = "SELECT COUNT(*) cnt2 FROM vw_ETAJAlisting WHERE trx_docstatus IN (2) "&sqlWhereIM&"  " 
			'response write sqlInit2
			set initStmt2 = SetRs(sqlInit2, con_ETAJA)
			
			if(getCnt("cnt") > 1) then
			
				'IN PROGRESS
				sqlInit11 = "SELECT COUNT(*) cnt1 FROM Trans_ETAJA WHERE trx_docstatus IN (2,3,4,5,6,7,10,11,12,13,14,15) AND employeeNo = '"&SESSION("LoginID")&"' " 
				'response write sqlInit1
				set initStmt11 = SetRs(sqlInit11, con_ETAJA)
			
			else
			
				'IN PROGRESS
				sqlInit11 = "SELECT COUNT(*) cnt1 FROM Trans_ETAJA WHERE trx_docstatus IN (2,3,4,5,6,7,10,11,12,13,14,15) "&sqlWhereInit&"  " 
				'response write sqlInit1
				set initStmt11 = SetRs(sqlInit11, con_ETAJA)	
			
			end if

		end if
end if

'SM LPW
sqlInit3 = "SELECT COUNT(*) cnt3 FROM Trans_ETAJA WHERE trx_docstatus IN (3,9)   " 
'response write sqlInit3
set initStmt3 = SetRs(sqlInit3, con_ETAJA)

sqlWherePIC = ""
trx_zone 	= "0"
sqlZone 	= " SELECT * FROM Setup_piczonearea WHERE staffno_pic='"&SESSION("LoginID")&"' "
set getPIC	= setRs(sqlZone, con_ETAJA)
do while not getPIC.eof 
	trx_zone = trx_zone & ","&getPIC("trx_zone")		
getPIC.movenext
loop

if(permission2("LAWA_Admin_View") = true) then
	sqlWherePIC = ""
else
	sqlWherePIC = " AND trx_zone IN ("&trx_zone&") "
end if

'PIC CHECKING & UPDATE
sqlInit4 = "SELECT COUNT(*) cnt4 FROM Trans_ETAJA WHERE trx_docstatus IN (4,5,6,7,10,11,12,13,14,15) "&sqlWherePIC&"  " 
'response.write sqlInit4
set initStmt4 = SetRs(sqlInit4, con_ETAJA)

'PIC REPORT
sqlInit5 = "SELECT COUNT(*) cnt5 FROM Trans_ETAJA WHERE trx_docstatus IN (8)  " 
'response write sqlInit4
set initStmt5 = SetRs(sqlInit5, con_ETAJA)

'PIC PEMBAYARAN
sqlInit6 = "SELECT COUNT(*) cnt6 FROM Trans_ETAJA WHERE trx_docstatus IN (12,13)  "  
'response write sqlInit6
set initStmt6 = SetRs(sqlInit6, con_ETAJA)

'COMPLETED
sqlInit7 = "SELECT COUNT(*) cnt7 FROM vw_ETAJAlisting WHERE trx_docstatus IN (20)  "&sqlWhereIM&" "&sqlWhereInit&" "   
'response write sqlInit7
set initStmt7= SetRs(sqlInit7, con_ETAJA)


'TERMINATED
sqlInit8 = "SELECT COUNT(*) cnt8 FROM vw_ETAJAlisting WHERE trx_docstatus IN (-1)   "&sqlWhereIM&"  "  
'response write sqlInit8
set initStmt8= SetRs(sqlInit8, con_ETAJA)


%>

<% if((permission2("LAWA_Initiator_Submenu")) = true) then %>	
<p>
	<a class="wlink" href="?action=ETAJAinitiator&search=true">Pending Submission</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=ETAJAinitiator&search=true"><%=initStmt1("cnt1")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt1("cnt1")%>%"
		aria-valuenow="<%=initStmt1("cnt1")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>

<p>
	<a class="wlink" href="?action=listing&status=inprogress&search=true">In Progress</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=listing&status=inprogress&search=true"><%=initStmt11("cnt1")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt11("cnt1")%>%"
		aria-valuenow="<%=initStmt1("cnt1")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>
					
<% end if %>
<!--3356: OLD Department-->
<% if(getStaff("DepartmentCode")="0044") then %>

		<% if(getKJ("cnt") > 0) then %>	

		<p>
			<a class="wlink" href="?action=imverification&search=true">Pending IM</a>
			<span class="forcend fw-bold">
				<a class="wlink" href="?action=imverification&search=true"><%=initStmt2("cnt2")%></a></span>
		</p>
		<div class="progress mb-2">
			<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt2("cnt2")%>%"
				aria-valuenow="<%=initStmt2("cnt2")%>" aria-valuemin="0" aria-valuemax="1000">
			</div>
		</div>
<% end if %>
		
<% elseif(getCnt("cnt") > 1) then %>	

		<p>
			<a class="wlink" href="?action=imverification&search=true">Pending IM</a>
			<span class="forcend fw-bold">
				<a class="wlink" href="?action=imverification&search=true"><%=initStmt2("cnt2")%></a></span>
		</p>
		<div class="progress mb-2">
			<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt2("cnt2")%>%"
				aria-valuenow="<%=initStmt2("cnt2")%>" aria-valuemin="0" aria-valuemax="1000">
			</div>
		</div>
<% end if %>

<% if((permission2("LAWA_SMLPW_Submenu")) = true) then %>	

<p>
	<a class="wlink" href="?action=smapproval&search=true">Pending SM LPW</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=smapproval&search=true"><%=initStmt3("cnt3")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt3("cnt3")%>%"
		aria-valuenow="<%=initStmt3("cnt3")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>
<% end if %>

<% if((permission2("LAWA_PICChecking_Submenu")) = true) then %>		

<p>
	<a class="wlink" href="?action=picchecking&search=true">Pending PIC Checking & Update</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=picchecking&search=true"><%=initStmt4("cnt4")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt4("cnt4")%>%"
		aria-valuenow="<%=initStmt4("cnt4")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>
<% end if %>

<% if((permission2("LAWA_ReportVerifier_Submenu")) = true) then %>	

<p>
	<a class="wlink" href="?action=reportverifier&search=true">Pending Report Verifier</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=reportverifier&search=true"><%=initStmt5("cnt5")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt5("cnt5")%>%"
		aria-valuenow="<%=initStmt5("cnt5")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>
<% end if %>

<% if((permission2("LAWA_PicPembayaran_Submenu")) = true) then %>	

<p>
	<a class="wlink" href="?action=picpembayaran&search=true">Pending PIC Pembayaran</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=picpembayaran&search=true"><%=initStmt6("cnt6")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt6("cnt6")%>%"
		aria-valuenow="<%=initStmt6("cnt6")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>
<% end if %>


<p>
	<a class="wlink" href="?action=listing&search=true&docid=20">Completed</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=listing&search=true&docid=20"><%=initStmt7("cnt7")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt7("cnt7")%>%"
		aria-valuenow="<%=initStmt7("cnt7")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>

<p>
	<a class="wlink" href="?action=listing&search=true&docid=-1">Terminated</a>
	<span class="forcend fw-bold">
		<a class="wlink" href="?action=listing&search=true&docid=-1"><%=initStmt8("cnt8")%></a></span>
</p>
<div class="progress mb-2">
	<div class="progress-bar bg-secondary" role="progressbar" style="width: <%=initStmt8("cnt8")%>%"
		aria-valuenow="<%=initStmt8("cnt8")%>" aria-valuemin="0" aria-valuemax="1000">
	</div>
</div>