<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="inc.asp"-->

<%

sqlWhereIM = " "
'PULL STAFF INFORMATION
sqlStaff = "SELECT * FROM vw_staff_ess WHERE 1=1 "
set getStaff = setRs(sqlStaff, con_ETAJA)	

'GET DOWNLINE
set getCnt= setRs("SELECT COUNT(*) cnt FROM vw_staff_ess WHERE 1=1 ", con_ETAJA)
'response.write getCnt("cnt")

%>

<div class="row margin-bottom-10">

  This is home page

 </div>