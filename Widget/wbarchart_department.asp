<%
sqlbar_department = "SELECT DISTINCT c.DepartmentCode, (SELECT b.Department FROM vw_ESS_Department b WHERE b.DepartmentCode=c.DepartmentCode) Department "
sqlbar_department = sqlbar_department &"FROM  vw_ETAJAlisting a  "
sqlbar_department = sqlbar_department &"LEFT JOIN  vw_staff_ess c  ON c.EmployeeCode=a.EmployeeNo    " 
sqlbar_department = sqlbar_department &" WHERE 1=1 "&sqlWhereDept&" "

set getDepartment_graph= setRs(sqlbar_department,con_ETAJA)	

Dim getDepartment_graph
Dim checkTotalDepartment_graph
Dim percentageDepartment
Dim totalDeclareDepartment_graph



percentage_department = ""
division       = "["
percentage_department  = "{colorByPoint: true, data: ["

do while not getDepartment_graph.eof

	set checkTotalDepartment_graph = setRs("SELECT COUNT(*) AS checkTotal FROM vw_ETAJAlisting WHERE DepartmentCode='"& getDepartment_graph("DepartmentCode") &"' ", con_ETAJA)
	if not checkTotalDepartment_graph.eof then	
			totalDeclareDepartment_graph = checkTotalDepartment_graph("checkTotal")
			percentageDepartment = (totalDeclareDepartment_graph)
	end if	
	
	division       = division &  "'" & getDepartment_graph("Department") & "',"   
	percentage_department  = percentage_department & percentageDepartment & ","
	
getDepartment_graph.movenext
loop
		
'Zone
division     = Left(division,Len(division)-1)
division     = division & "]"
 
'percentage_department
percentage_department   = Left(percentage_department,Len(percentage_department)-1)
percentage_department   = percentage_department & "]}"

'percentageDepartment = percentageDepartment & percentage_department 
percentage_department_data = percentage_department_data & percentage_department & ", " 

'END ZONE GRAPH INTERFACE

%>

<div id="container_department" style="width:100%; !important;"></div>
<script>
//CHART PIE
Highcharts.chart('container_department', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'APPLICATION BY DEPARTMENT AS OF <%=dateformat(DATE)%>'
    },
    xAxis: {
        type: 'category'
    },

    xAxis: {
      categories: <%=division%>,
    },
	
    yAxis: {
        title: {
            text: 'Total'
        }

    },
    legend: {
        enabled: false
    },
    plotOptions: {
        series: {
            borderWidth: 0,
            dataLabels: {
                enabled: false,
                format: '{point.y}'
            }
        }
		
    },
		

    tooltip: {
        headerFormat: '<span style="font-size:11px">{point.x}</span><br>',
        pointFormat: '<span style="color:{point.color}">Total Application</span> : <b>{point.y}</b>'
    },
	
	
     "series": [<%=percentage_department_data%>],
	
});
</script>