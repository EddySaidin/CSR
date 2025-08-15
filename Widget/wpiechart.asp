<%
sqlpie = "SELECT a.description kelulusanstatus , (SELECT COUNT(*) cnt FROM vw_ETAJAlisting b WHERE b.appsstatus = a.trx_id) total "
sqlpie = sqlpie & "FROM  Setup_Option a WHERE a.trx_id IN (3,4,5) "

set stmt = setRs(sqlpie, con_ETAJA)
nom      = 0
totalval = 0

'CHART
pie = ""
do while not stmt.eof
	nom = nom + 1
	pie = pie &"{name: '"&stmt("kelulusanstatus")&"',y: "&(stmt("total"))&", sliced: true, selected: true},"
stmt.movenext
loop
'response.write pie
%>
<p class="text-dark pl-3 pt-1 mb-3 fw-bold border-opacity-50 "><i class="fa-solid fa-graph"></i>&nbsp;&nbsp;APPROVAL APPLICATION STATUS AS OF <%=dateformat(DATE)%></p>
<div id="container" style="width:100%;height:350px !important;"></div>
<script>
//CHART PIE
Highcharts.chart('container', {
    chart: {
        type: 'pie',
		backgroundColor: '',
		style: {
			fontFamily: 'Lato, Helvetica, sans-serif',
			fontSize: '10px'
		}
    },
	credits: {
    	enabled: false
  	},
    title: {
        text: ''
    },
    tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
    },
    accessibility: {
        point: {
            valueSuffix: '%'
        }
    },
    plotOptions: {
        pie: {
            allowPointSelect: true,
            cursor: 'pointer',
            dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.percentage:.1f} %'
            }
        }
    },
	exporting: {
		enabled: false
	},
    series: [{
        name: 'Percentage',
        colorByPoint: true,
        data: [<%=pie%>]
    }]
});
</script>