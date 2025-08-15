<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001" %>
	<!--#include file="global.asp" -->
	<!--#include file="../global_inc/global_ETAJA.asp"-->
	<!--#include file="Apps/ETAJA/functionglobal.asp" -->
	<!--#include file="Apps/ETAJA/function.asp" -->
	<!DOCTYPE html>
	<html lang="en">

	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<title>Company Identity Card Application (eCICard)</title>
		<!--#include file="headcustom.asp" -->
		<!-- Bootstrap 5 CSS -->
		<link rel='stylesheet' href='/include/bootstrap-5.3.0-dist/css/bootstrap.min.css'>
		<!-- Font Awesome CSS -->
		<link rel='stylesheet' href='/include/fontawesome-free-6.4.0-web/css/all.min.css'>

		<link rel="stylesheet" href="jQuery/jquery-ui-1.13.2/jquery-ui.css">
		<link rel="stylesheet" href="include/MonthPicker/src/MonthPicker.css">

		<script type="text/javascript" src="jQuery/jquery-3.7.0.min.js"></script>
		<script src="jQuery/jquery-ui-1.13.2/jquery-ui.js"></script>
		<script src="jQuery/ui/jquery-ui-timepicker-addon.js"></script>
		<script type="text/javascript" src="include/MonthPicker/src/MonthPicker.js"></script>

		<!-- SELECT2 -->
		<link href="include/select2/select2_2.min.css" rel="stylesheet" />
		<script src="include/select2/select2_2.min.js"></script>
		<link href="Include/a_ETAJA.css?refresh=true2" rel="stylesheet" type="text/css">
		<script src="include/a_ETAJA.js?upd=txapr"></script>

		<!-- HIGHCHARTS -->
		<script src="include/Highcharts-7.0.1/code/highcharts.js"></script>
		<script src="include/Highcharts-7.0.1/code/modules/series-label.js"></script>
		<script src="include/Highcharts-7.0.1/code/modules/exporting.js"></script>
		<script src="include/Highcharts-7.0.1/code/modules/export-data.js"></script>


		<!-- TINYMCE -->
		<script src="include/tinymce_7/js/tinymce/tinymce.min.js" referrerpolicy="origin"></script>

		<!-- SweetAlert -->
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		

		<!--Bootstrap 5.3.0 -->
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

		<script>
			// In your Javascript (external .js resource or <script> tag)
			$(document).ready(function () {
				$('select').select2({
					width: '100%'
				});
				$("input").attr("autocomplete", "off");
			});
		</script>
		<style>
			.form-check-input {
				border: var(--bs-border-width) solid #424548;
			}

			legend {
				font-size: 0.9rem;
				font-weight: bold;
			}

			.highcharts-credits {
				display: none;
			}
		</style>
	</head>

	<body class="d-flex flex-column min-vh-100">
		<!-- Spinner -->
		<div class="se-pre-con"></div>

		<header class="intro">
			<div class="row">
				<div class="col-lg col-md text-start align-middle algctr"><img src="/images/logo_l.png?x=x"
						class="img-fluid" width="300" alt="SESB LOGO" /></div>
				<div class="col-lg col-md text-end align-middle pt-3 text-muted algctr webonly">Company Identity Card
					Application (eCICard)</div>
			</div>
		</header>

		<main>
			<!-- Start Mega Menu HTML -->
			<nav class="navbar navbar-expand-lg navbar-light bg-dark navbar-dark shadow-sm">
				<div class="container-fluid">
					<button class="navbar-toggler collapsed shadow-none mb-3" type="button" data-bs-toggle="collapse"
						data-bs-target="#navbar-content">
						<div class="hamburger-toggle border border-secondary">
							<div class="hamburger">
								<span class="bg-white"></span>
								<span class="bg-white"></span>
								<span class="bg-white"></span>
							</div>
						</div>
					</button>
					<a href="/" class="navbar-brand mobionly text-white fw-bold">Company Identity Card Application
						(eCICard)</a>

					<div class="collapse navbar-collapse" id="navbar-content">
						<ul id="mainmenu" class="navbar-nav mr-auto mb-2 mb-lg-0">
							<li class="nav-item">
								<a class="nav-link active" aria-current="page" href="?action=home">HOME</a>
							</li>
							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
									data-bs-auto-close="outside">TRANSACTION</a>
								<ul class="dropdown-menu shadow-sm ">

									<li><a class="dropdown-item" href="?action=ecicardinitiator">Application</a></li>
									<li>
										<hr class="dropdown-divider">
									</li>

									<li><a class="dropdown-item" href="?action=smapproval">SM Approval</a></li>
									<li>
										<hr class="dropdown-divider">
									</li>

									<li><a class="dropdown-item" href="?action=processor">Processor</a></li>
				
								</ul>
							</li>

							<li class="nav-item">
								<a class="nav-link" aria-current="page" href="?action=listing">Listing</a>
							</li>

							<li class="nav-item dropdown">
								<a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"
									data-bs-auto-close="outside">Information Setup</a>
								<ul class="dropdown-menu shadow-sm ">
									<li><a class="dropdown-item" href="?action=cardapplicationstatus">Card Application Status</a></li>									
								</ul>
							</li>
							<li class='nav-item'><a class="nav-link" href='?action=login'><span>MAIN MENU</span></a></li>

						</ul>
						<div class="d-flex ms-auto" style="float: right !important;">
							<a class="nav-link font-weight-bold" title="Logout" href="?action=logout"
								onclick="return confirm('Are you sure you want to Logout?')">
								<b class="text-warning">
									<span class="border-bottom border-warning">
										<%= UCase(Session.Contents("name")) %>
									</span>
									&nbsp;<i class="fa-solid fa-right-from-bracket"></i></b></a>
						</div>
					</div>
				</div>
			</nav>
			<% 'CONTENT
			%>
			<section>
				<%
				Session("dontexecutemenu") = false
				
				Server.execute("Apps/" & defaultApp & "/definition.asp") 				
				
				apn = replace(Request.QueryString("apn"), "'", "")
				if apn <> "" then
					response.write apn
				end if
				
				Session(" dontexecutemenu")=true %>
				</section>

				<% 'FOOTER
			%>
			<footer class="credit p-5 pt-0">
				<div class="row border-top pt-2">
					<div class="cusfoot col-lg-4 text-start mb-2">Copyright &copy; 2019 - <%=YEAR(DATE())%> Sabah Electricity Sdn Bhd. All Rights Reserved.</div>
					<div class="cusfoot col-lg-8 text-end">Sabah Electricity Sdn Bhd, Wisma SESB, Jalan Tunku Abd Rahman, 88673 Kota Kinabalu, Sabah. 
					<br />Tel: 088 282 699, Fax: 088 223 320</div>
				</div>
			</footer>
		</main>
	</body>
</html>