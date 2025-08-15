<%
Dim con_info
Dim con_project
Dim con_profile
Dim con_cidcard
Dim con_ETAJA
Dim con_tender
Dim con_vendor
Dim con_smp
Dim con_qms 
Dim con_cmc
Dim con_wayleave
Dim con_landtracking
Dim con_kiosk
Dim con_softIn
Dim con_softIn_v2
Dim con_solar
Dim con_clinic
Dim con_ir
Dim con_hed
Dim con_monitor
Dim con_logsheet 
Dim con_logsheetgx
Dim con_oldesams
Dim con_efiling
Dim con_ictmarval
Dim con_cmcmarval
Dim con_smodkpi
Dim con_epm
Dim con_psod
Dim con_erecruit
Dim con_erecruitdel
Dim con_ocs
dim con_ocsReport
Dim con_ocs2
Dim con_ocs3
Dim con_web
Dim con_cbpms4
Dim con_care
Dim con_qmsmot
Dim con_disturbance
Dim con_SMS
Dim con_steps
Dim con_esams
Dim con_docket
Dim con_engagement
Dim con_uniq
Dim con_mo
Dim con_quotender
Dim con_9AM
Dim con_TL
Dim con_8AM
Dim con_SLA
Dim con_eCounselling
Dim con_capitalization
Dim con_msvt
Dim con_rca
Dim con_sistemtempahan
Dim con_eregulatory
Dim con_eJHTTx
Dim con_ePantau
Dim con_dns
Dim con_dfs
Dim con_DPROMS
Dim con_PJM
Dim con_loaddemand
Dim con_cbpms5
Dim con_SeSTA
Dim con_BPC
Dim con_efiling_system
Dim con_DASA
Dim con_ABMS
Dim con_lawa
Dim con_ehk
Dim con_prsm
Dim con_txeadm
Dim con_Event
Dim con_eDebt
Dim con_OLCS
Dim con_apc
Dim con_RiMMS
Dim con_SSHMon
Dim con_gproms
Dim con_eVirement
Dim con_pcs
Dim con_DSSA

Dim resetTempPassword
resetTempPassword = "SE$Buser1234"
Dim superAdminId


superAdminId="90001594"

'============
con_info 			= "Provider=SQLNCLI11;Persist Security Info=False;Data Source=192.168.159.37;User ID=sa;password=sesb;Initial Catalog=info"
'con_profile 		= "Provider=SQLNCLI11;Persist Security Info=False;Data Source=192.168.159.37;User ID=sa;password=sesb;Initial Catalog=profile"
'con_profile 		= "Provider=SQLNCLI11;Persist Security Info=false;User ID=project;password=Q!@WE#$R;Initial Catalog=Profile;Data Source=192.168.159.37"

con_vendor 			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=vendormy;Data Source=192.168.159.37"
'con_vendor 		= "DSN=con_vendor;Uid=project;Pwd=Q!@WE#$R;"
con_project 		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=tendermy;Data Source=192.168.159.37"
con_tender			= "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=TENDERMY;Trusted_Connection=yes;"
con_cidcard			= "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=cidcard;Trusted_Connection=yes;"
con_ETAJA			= "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=ETAJA;Trusted_Connection=yes;"
'con_tender 		= "DSN=con_tender;Uid=project;Pwd=Q!@WE#$R;"
con_wayleave 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=wayleave"
'con_wayleave 		= "DSN=con_wayleave;Uid=project;Pwd=papuser;"
con_landtracking 	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=landtracking"
'con_landtracking 	= "DSN=con_landtracking;Uid=papuser;Pwd=papuser;"
con_kiosk 	 		= "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=192.168.160.61; DATABASE=kiosk; UID=web_kiosk;PASSWORD=bkntFA=47?BF; OPTION=3"
'con_ocs      		= "DRIVER={MySQL ODBC 3.51 Driver};SERVER=192.168.161.96;DATABASE=ocs;USER=root;PASSWORD=SE$Buser1234;OPTION=3;"
con_care     		= "DRIVER={MySQL ODBC 3.51 Driver};SERVER=192.168.161.96;DATABASE=care;USER=root;PASSWORD=SE$Buser1234;OPTION=3;"
con_cbpms4   		= "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=192.168.160.138; DATABASE=cbpms4; UID=root; PASSWORD=; OPTION=3"
con_web		 		= "DRIVER={MySQL ODBC 3.51 Driver};SERVER=192.168.161.96;DATABASE=website;USER=root;PASSWORD=SE$Buser1234;OPTION=3;"
con_qmsmot	 		= "DRIVER={MySQL ODBC 3.51 Driver};SERVER=192.168.161.147;PORT=3306;DATABASE=branchqms;USER=root;PASSWORD=root123;OPTION=3;"
con_qmsutc	 		= "DRIVER={MySQL ODBC 3.51 Driver};SERVER=192.168.230.20;PORT=3306;DATABASE=branchqms;USER=root;PASSWORD=root123;OPTION=3;"
con_papuser  		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=tendermy;Data Source=192.168.159.37"


con_softIn			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=softwareinventory;Data Source=192.168.159.37"
con_softIn_v2		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=softwareinventory_v2;Data Source=192.168.159.37"
'con_softIn 		= "DSN=con_softIn;Uid=papuser;Pwd=papuser;"
'con_clinic 		= "Provider=MSOLEDBSQL;password=12345;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=emedical;Data Source=192.168.159.37"
con_clinic  		= "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=emedical;Trusted_Connection=yes;Initial Catalog=emedical"
'con_clinic 		= "DSN=con_clinic;Uid=papuser;Pwd=papuser;"

con_profile  		= "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=Profile;Trusted_Connection=yes;"
'con_profile 		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=Profile;Data Source=192.168.159.37"
'con_profile 		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=Profile;Data Source=192.168.161.93"
'con_profile 		= "Provider=MSOLEDBSQL;Server=tcp:192.168.159.37;Database=Profile;Trusted_Connection=yes;"

'con_profile 		= "Provider=MSOLEDBSQL;Server=192.168.159.37;Database=profile;Uid=papuser;Pwd=papuser;"
'con_profile 		= "DSN=con_profile2;Uid=papuser;Pwd=papuser;"
session.contents("con_profile")=con_profile
con_smp 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.160.51;User ID=psiiso_dbuser;password=>&xcmN9^\pG$;Initial Catalog=smp"
'con_smp 			= "DSN=con_smp;Uid=psiiso_dbuser;Pwd=>&xcmN9^\pG$;"
con_qms 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.160.51;User ID=psiiso_dbuser;password=>&xcmN9^\pG$;Initial Catalog=qms"
'con_qms 			= "DSN=con_qms;Uid=psiiso_dbuser;Pwd=>&xcmN9^\pG$;"
con_cmc 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.160.51;User ID=psiiso_dbuser;password=>&xcmN9^\pG$;Initial Catalog=TCSDB"
'con_cmc 			= "DSN=con_cmc;Uid=psiiso_dbuser;Pwd=>&xcmN9^\pG$;"
con_solar 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.110;User ID=papuser;password=papuser;Initial Catalog=solar"
'con_solar 			= "DSN=con_solar;Uid=papuser;Pwd=papuser;"
con_ir 				= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=ir"
'con_ir 			= "DSN=con_ir;Uid=papuser;Pwd=papuser;"
con_hed 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=tatatertib"
con_monitor 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=backuplog"
con_logsheet 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=Logsheet"
con_logsheetgx 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=LogsheetGx"
con_oldesams 		= "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\websites\esams\db\esams.mdb;Persist Security Info=False"
con_efiling 		= "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=D:\websites\efilling\efiling.mdb;Persist Security Info=False"
'con_ictmarval 		= "Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=192.168.160.52;User ID=msmadmin;password=msmadmin;Initial Catalog=MSM"
con_ictmarval 		= "Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=192.168.161.83;User ID=apps;password=C$$apps;Initial Catalog=MSM"
con_cmcmarval 		= "Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=CMCDB\CMCMSSQL; Database=MSM;User ID=msm;password=msmadmin;Initial Catalog=MSM"

'Performance Monitoring System
con_smodkpi 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=SMODKPI"
'con_smodkpi 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=SMODKPI"


con_epm 			= "Provider=SQLOLEDB.1;Persist Security Info=False;Data Source=192.168.160.133; Database=WSS_Content_80;User ID=sa;password=p@ssw0rd123;Initial Catalog=WSS_Content_80"
con_psod 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=PSOD"
'ERECRUIT
con_erecruitdel 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=erecruitdel;Data Source=192.168.159.37"
con_erecruit 		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=EMadisDBSESB;Data Source=192.168.159.37"
con_sms 			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=sms;Data Source=192.168.159.37"
'Disturbance
con_disturbance 	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=disturbance"
'STEPS
con_steps 			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=STEPS"
'ESAMS
con_esams	 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=esams"
'DOCKET
con_docket 			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=docket;Data Source=192.168.159.37"
con_engagement 		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=engagement;Data Source=192.168.159.37"
con_uniq 	 		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=UNIQ;Data Source=192.168.159.37"
con_mo 	 			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=MO;Data Source=192.168.159.37"
con_quotender   	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=quotender;Data Source=192.168.159.37"
con_9AM   			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=9AM;Data Source=192.168.159.37"
con_TL   			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=TL;Data Source=192.168.159.37"
con_8AM   			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=8AM;Data Source=192.168.159.37"
con_SLA   			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=SLA;Data Source=192.168.159.37"
con_ocsReport		= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=OCS_Report;Data Source=192.168.159.37"
con_ocs2   			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=OCS;Data Source=192.168.159.37"
con_ocs3   			= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=OCS;Data Source=192.168.159.37"
con_eCounselling   	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=eCounselling;Data Source=192.168.159.37"
con_capitalization 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=capitalization;Data Source=192.168.159.37" 
con_msvt 	        = "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=MSVT;Data Source=192.168.159.37" 
con_rca 	        = "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=rca;Data Source=192.168.159.37"
con_sistemtempahan 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=SistemTempahan;Data Source=192.168.159.37"
con_eregulatory 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=eRegulatory;Data Source=192.168.159.37"
'con_eJHTTx	 		= "Provider=MSOLEDBSQL;Server=192.168.159.37;Database=eJHTTx;Trusted_Connection=yes;"
con_eJHTTx		 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=eJHTTx;Data Source=192.168.159.37"
con_eJHTDx		 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=eJHTDx;Data Source=192.168.159.37"
con_ePantau		 	= "Provider=MSOLEDBSQL;Persist Security Info=false;User ID=papuser;password=papuser;Initial Catalog=epantau;Data Source=192.168.159.37"
con_tproms	 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=TPROMS"
con_dns 	 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=DNS"
con_dfs 	 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=DFS"
con_DPROMS 	 		= "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=DPROMS;Trusted_Connection=yes;"
con_PJM 	 		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=PJM"
con_loaddemand 	 	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=LoadDemand"
con_sccs			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=CostCharging"
con_cbpms5			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=CBPMS5"
con_SeSTA			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=SeSTA"
con_BPC				= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=BPC"
con_eAttendance		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=eAttendance"
con_efiling_system	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=efiling_system"
con_DASA	        = "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=DASA"
con_ABMS	        = "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=ABMS"
con_lawa	        = "Provider=MSOLEDBSQL;Server=.\SQLEXPRESS;Database=LAWA;Trusted_Connection=yes;Catalog=LAWA"
con_ehk	        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=ehapuskira"
con_prsm	        = "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=PRSM"
con_txeadm	        = "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=TXEADM"
con_Event        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=Event"
con_eDebt        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=eDebtRecovery"
con_OLCS        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=OLCS"
con_apc        		= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=APC"
con_RiMMS        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=RiMMS"
con_SSHMon        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=SSHMon"
con_gproms        	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=GPROMS"
con_eVirement      	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=eVirement"
con_pcs		      	= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=PCS"
con_DSSA			= "Provider=MSOLEDBSQL;Persist Security Info=False;Data Source=192.168.159.37;User ID=papuser;password=papuser;Initial Catalog=DSSA"

Dim defaultApp
defaultApp = Session.Contents("system")

Dim PysPath
PysPath = Request.ServerVariables("APPL_PHYSICAL_PATH")


%>
