<%

sqlbar_division = "SELECT DISTINCT DivisionCode, Division FROM  vw_ESS_Department "
set getDivision_graph= setRs(sqlbar_division,con_ETAJA)	

Dim getDivision_graph
Dim checkTotalDivision_graph
Dim percentageDivision
Dim totalDeclareDivision_graph



percentage_division = ""
division       = "["
percentage_division  = "{colorByPoint: true, data: ["

do while not getDivision_graph.eof

	set checkTotalDivision_graph = setRs("SELECT COUNT(*) AS checkTotal FROM vw_ETAJAlisting WHERE DivisionCode='"& getDivision_graph("DivisionCode") &"' ", con_ETAJA)
	if not checkTotalDivision_graph.eof then	
			totalDeclareDivision_graph = checkTotalDivision_graph("checkTotal")
			percentageDivision = (totalDeclareDivision_graph)
	end if	
	
	division       = division &  "'" & getDivision_graph("Division") & "',"   
	percentage_division  = percentage_division & percentageDivision & ","
	
getDivision_graph.movenext
loop
		
'Zone
division     = Left(division,Len(division)-1)
division     = division & "]"
 
'percentage_division
percentage_division   = Left(percentage_division,Len(percentage_division)-1)
percentage_division   = percentage_division & "]}"

'percentageDivision = percentageDivision & percentage_division 
percentage_division_data = percentage_division_data & percentage_division & ", " 

'END ZONE GRAPH INTERFACE

%>

<div id="container_division" style="width:100%; !important;"></div>
<script>
//CHART PIE
Highcharts.chart('container_division', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'APPLICATION BY DIVISION AS OF <%=dateformat(DATE)%>'
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
	
	
     "series": [<%=percentage_division_data%>],
	
});
</script>