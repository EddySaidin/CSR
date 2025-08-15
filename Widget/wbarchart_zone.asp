<%

sqlbar_zone = "SELECT * FROM  vw_tbzon ORDER BY Description ASC "
set getZone_graph= setRs(sqlbar_zone,con_ETAJA)	

Dim getZone_graph
Dim checkTotalZone_graph
Dim percentageZone
Dim totalDeclareZone_graph



percentage_zone = ""
powerstation_Zone       = "["
percentage_zone  = "{colorByPoint: true, data: ["

do while not getZone_graph.eof

	set checkTotalZone_graph = setRs("SELECT COUNT(*) AS checkTotal FROM Trans_ETAJA WHERE trx_zone='"& getZone_graph("trx_id") &"' ", con_ETAJA)
	if not checkTotalZone_graph.eof then	
			totalDeclareZone_graph = checkTotalZone_graph("checkTotal")
			percentageZone = (totalDeclareZone_graph)
	end if	
	
	powerstation_Zone       = powerstation_Zone &  "'" & getZone_graph("Description") & "',"   
	percentage_zone  = percentage_zone & percentageZone & ","
	
getZone_graph.movenext
loop
		
'Zone
powerstation_Zone     = Left(powerstation_Zone,Len(powerstation_Zone)-1)
powerstation_Zone     = powerstation_Zone & "]"
 
'percentage_zone
percentage_zone   = Left(percentage_zone,Len(percentage_zone)-1)
percentage_zone   = percentage_zone & "]}"

'percentageZone = percentageZone & percentage_zone 
percentage_zone_data = percentage_zone_data & percentage_zone & ", " 

'END ZONE GRAPH INTERFACE

%>

<div id="container_zone" style="width:100%; !important;"></div>
<script>
//CHART PIE
Highcharts.chart('container_zone', {
    chart: {
        type: 'column'
    },
    title: {
        text: 'APPLICATION BY ZONE AS OF <%=dateformat(DATE)%>'
    },
    xAxis: {
        type: 'category'
    },

    xAxis: {
      categories: <%=powerstation_Zone%>,
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
	
	
     "series": [<%=percentage_zone_data%>],
	
});
</script>