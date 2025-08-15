<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../inc.asp"-->
<%
Dim sqlCmd
Dim output 
Dim term

id   = ReplaceSQL(request.queryString("id"))
idy  = ReplaceSQL(request.queryString("idy"))
typp = ReplaceSQL(Request.QueryString("typp"))
term = ReplaceSQL(Request.QueryString("term"))

if typp = "name" AND term <> "" then	
	sql = "SELECT TOP 20 * FROM vw_staff_ess "
	sql = sql & "WHERE EmployeeName LIKE '%%%"  & term & "%%%' ORDER BY EmployeeName" 
	Set sqlCmd = setRs(sql, con_ETAJA)
	  
	output = "["
	While (NOT sqlCmd.EOF) 
		output = output & "{""id"":""" & sqlCmd.Fields.item("EmployeeID") & ""","
		output = output & """value"":""" & sqlCmd.Fields.Item("EmployeeName") & ""","
		output = output & """Division"":""" & sqlCmd.Fields.Item("Division") & ""","
		output = output & """Department"":""" & sqlCmd.Fields.Item("Department") & ""","
		output = output & """PositionName"":""" & sqlCmd.Fields.Item("PositionName") & ""","
		output = output & """PayScaleGroup"":""" & sqlCmd.Fields.Item("PayScaleGroup") & ""","
		output = output & """Email1"":""" & sqlCmd.Fields.Item("Email1") & ""","
		output = output & """ManagerName"":""" & sqlCmd.Fields.Item("ManagerName") & ""","
		output = output & """HODeptName"":""" & sqlCmd.Fields.Item("HODeptName") & ""","
		output = output & """employeecode"":""" & sqlCmd.Fields.Item("employeecode") & """},"
		sqlCmd.MoveNext()
	Wend

	sqlCmd.Close()
	Set sqlCmd = Nothing

	output = Left(output,Len(output)-1)
	output = output & "]"
	Response.Write output
end if
%> 