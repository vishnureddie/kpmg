<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="java.util.List"%>
<%@ include file="/init.jsp" %>
<%@page import="com.kpmg.citizenTables.service.AboutusLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.AboutusServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Aboutus"%>
 <%@page import="com.kpmg.citizenTables.service.IFSKeyOfficersServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.IFSKeyOfficers"%>
<%@page import="com.kpmg.citizenTables.service.IFSKeyOfficersLocalServiceUtil"%>
 <%@page import="java.text.SimpleDateFormat"%>
 <%@page import="javax.portlet.PortletURL"%>
 <%@page import="com.kpmg.AboutIFS.constants.AboutIFSPortletKeys"%> 
<%@page import="com.kpmg.AboutIFS.portlet.AboutIFSPortlet"%>


 <% 
 String languageId=themeDisplay.getLanguageId();
 System.out.println("getLanguageId>>>>"+themeDisplay.getLanguageId());
 PortletURL iteratorNewURL = renderResponse.createRenderURL(); 
 iteratorNewURL.setParameter("mvcPath", "/view.jsp");
 long cur = 1;
 long delta=1;
 if(ParamUtil.getLong(request, "cur")!=0){
 	cur =ParamUtil.getLong(request, "cur");
 }
 if(ParamUtil.getLong(request, "delta")!=0){
 	delta =ParamUtil.getLong(request, "delta");
 }
 long Plid=themeDisplay.getPlid();
 long sNo=(delta * (cur-1))+1;
%>
<portlet:renderURL var="createFormsURL">
	<portlet:param name="mvcPath" value="/createForm.jsp"/>
</portlet:renderURL> 

<portlet:renderURL var="addPeopleURL">
	<portlet:param name="mvcPath" value="/addPeople.jsp"/>
</portlet:renderURL> 

  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Infrastructure in India</title>
  <link type="text/css" rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
  
    <!-- Font Awesome  -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.2.0/css/all.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.2.0/css/sharp-solid.css" />
    <script src="https://site-assets.fontawesome.com/releases/v6.2.0/js/all.js" data-auto-add-css="false" data-auto-replace-svg="false"></script>
    <script src="https://site-assets.fontawesome.com/releases/v6.2.0/js/sharp-solid.js" data-auto-add-css="false" data-auto-replace-svg="false"></script>
  

  <!-- Owl Carousel -->
 <link type="text/css" rel="stylesheet" href="css/owl.carousel.min.css" />
 <link type="text/css" rel="stylesheet"  href="css/owl.theme.default.min.css" />

<!-- Calendar CSS -->
<link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
<!-- Custom CSS -->
<link href="css/style.css" rel="stylesheet" />
	  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">

  
 <!--FONTS--> 	  
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&family=Roboto+Slab:wght@300;400;500;700&display=swap" rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->

<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
<script src="https://oss.maxcdn.com/libs/respond.js/1.3.0/respond.min.js"></script>
<![endif]-->
	  
<style type="text/css">
	  :root {
  --level-1: #2C3443;
  --level-2:  #4C8DDA;
  --level-3: #7b9fe0;
  --level-4: #49C389;
  --black: black;
}

ol {
  list-style: none;
	padding-left:0;
}
	
	H1.rectangle,H2.rectangle,H3.rectangle,H4.rectangle,H5.rectangle,H6.rectangle{ FONT-SIZE:16px;}	

.rectangle {
  position: relative;
	text-align: center;
  
  box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
}
	
	.rectangle .nav-link{ color:#fff; padding: 20px;}
	
	.rectangle h1, .rectangle h2, .rectangle h3{ font-size:12px;}


/* LEVEL-1 STYLES
–––––––––––––––––––––––––––––––––––––––––––––––––– */
.level-1 {
  width: 50%;
  margin: 0 auto 40px;
  background: var(--level-1);
}

.level-1::before {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  width: 2px;
  height: 20px;
  background: var(--black);
}


/* LEVEL-2 STYLES
–––––––––––––––––––––––––––––––––––––––––––––––––– */
.level-2-wrapper {
  position: relative;
  display: grid;
  grid-template-columns: repeat(2, 1fr);
}

.level-2-wrapper::before {
  content: "";
  position: absolute;
  top: -20px;
  left: 25%;
  width: 50%;
  height: 2px;
  background: var(--black);
}

.level-2-wrapper::after {
  display: none;
  content: "";
  position: absolute;
  left: -20px;
  bottom: -20px;
  width: calc(100% + 20px);
  height: 2px;
  background: var(--black);
}

.level-2-wrapper li {
  position: relative;
}

.level-2-wrapper > li::before {
  content: "";
  position: absolute;
  bottom: 100%;
  left: 50%;
  transform: translateX(-50%);
  width: 2px;
  height: 20px;
  background: var(--black);
}

.level-2 {
  width: 70%;
  margin: 0 auto 0px;
  background: var(--level-2);
}

/*.level-2::before {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  transform: translateX(-50%);
  width: 2px;
  height: 20px;
  background: var(--black);
}

.level-2::after {
  display: none;
  content: "";
  position: absolute;
  top: 50%;
  left: 0%;
  transform: translate(-100%, -50%);
  width: 20px;
  height: 2px;
  background: var(--black);
}*/


/* LEVEL-3 STYLES
–––––––––––––––––––––––––––––––––––––––––––––––––– */
.level-3-wrapper {
  position: relative;
  display: grid;
  grid-template-columns: repeat(1, 1fr);
  grid-column-gap: 0px;
  width: 80%;
  margin: 0 auto;
}

/*.level-3-wrapper::before {
  content: "";
  position: absolute;
  top: -20px;
  left: calc(25% - 5px);
  width: calc(50% + 10px);
  height: 2px;
  background: var(--black);
}

.level-3-wrapper > li::before {
  content: "";
  position: absolute;
  top: 0;
  left: 50%;
  transform: translate(-50%, -100%);
  width: 2px;
  height: 20px;
  background: var(--black);
}*/

.level-3 {
  margin-bottom: 20px;
  background: var(--level-3);
}


/* LEVEL-4 STYLES
–––––––––––––––––––––––––––––––––––––––––––––––––– */
.level-4-wrapper {
  position: relative;
  width: 80%;
  margin-left: auto;
}

.level-4-wrapper::before {
  content: "";
  position: absolute;
  top: -20px;
  left: -20px;
  width: 2px;
  height: calc(100% - 9px);
  background: var(--black);
}

.level-4-wrapper li + li {
  margin-top: 20px;
}

.level-4 {
  font-weight: normal;
  background: var(--level-4);
}

.level-4::before {
  content: "";
  position: absolute;
  top: 50%;
  left: 0%;
  transform: translate(-100%, -50%);
  width: 20px;
  height: 2px;
  background: var(--black);
}


/* MQ STYLES
–––––––––––––––––––––––––––––––––––––––––––––––––– */
@media screen and (max-width: 700px) {
  .rectangle {
    padding: 20px 10px;
  }

  .level-1,
  .level-2 {
    width: 100%;
  }

  .level-1 {
    margin-bottom: 20px;
  }

  .level-1::before,
  .level-2-wrapper > li::before {
    display: none;
  }
  
  .level-2-wrapper,
  .level-2-wrapper::after,
  .level-2::after {
    display: block;
  }

  .level-2-wrapper {
    width: 90%;
    margin-left: 10%;
  }

  .level-2-wrapper::before {
    left: -20px;
    width: 2px;
    height: calc(100% + 40px);
  }

  .level-2-wrapper > li:not(:first-child) {
    margin-top: 50px;
  }
}

	  
	  </style>	  

</head>

<% if(!role.equalsIgnoreCase("Departmentuser")){ %>

<main class="main_innerlayout">
<section class="top_innerBanner ">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1>About IFS</h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Home</a></li>
				<li class="breadcrumb-item active">About</li>
			  </ol>
			</nav>
		</div>	
</section>


	
	<section>
		<div class="container">
		
       <% 
 
List<Aboutus> about=null;
  try{
	 // int size=ImportantLinksLocalServiceUtil.getImportantLinksCount();
	  //importantLinks=ImportantLinksLocalServiceUtil.findBylanguageId(languageId, 0, ImportantLinksLocalServiceUtil.countBylanguageId(languageId));
		 about =AboutusLocalServiceUtil.getAboutuses(0, AboutusLocalServiceUtil.getAboutusesCount());

  }
  catch(Exception e){
	  e.getMessage();
  }
       int x=1;
       
  for(Aboutus abt:about){
	  String fileUrl=""; 
	  String mainDescription=abt.getMainDescription();
	  String keyDescription =abt.getKeyDescription(); 
	  if(languageId.equals("hi_IN")){
		  mainDescription =abt.getHi_mainDescription(); 
		  keyDescription=abt.getHi_keyDescription(); 
		 }
	  long fileEntryId=abt.getFileEntryId();
	  if(fileEntryId!=0L){
			try{
				fileUrl =AboutIFSPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
			}
			catch(Exception e){
				
			}
	  }
	  
	  
       %>
			<p><%=mainDescription %></p>
			<p><img src="<%=fileUrl %>"class="img-fluid my-3" alt="logo" /></p>
				
			<h2>Key Functions </h2>
			<div class="row">
				<div class="col-lg-4 ">
				  <div class="text-center block_step">
					<div class="block_step_img"><img src="<%=request.getContextPath()%>/Images/infra_knowledge_icon.jpg"></div>
					<h3>Infrastructure <br />Knowledge Generation</h3>
				</div>
				</div>
				<div class="col-lg-4 ">
				  <div class="text-center block_step">
					<div class="block_step_img"><img src="<%=request.getContextPath()%>/Images/infra_financing_icon.jpg"></div>
					<h3>Infrastructure  <br />Financing</h3>
				</div>
				</div>
				<div class="col-lg-4 ">
				  <div class="text-center block_step">
					<div class="block_step_img"><img src="<%=request.getContextPath()%>/Images/infra_capacitybuilding_icon.jpg"></div>
					<h3>Infra-focused  <br />Capacity Building</h3>
				</div>
				</div>
			</div>
				
			<p> <%=keyDescription %></p>
				
	<% x++; } %>
				
				<h4>Structure of Infrastructure Finance Secretariat</h4>
				<div class="container">
					<div id="pills-tab" role="tablist">
				  <h1 class="level-1 rectangle" data-aos="fade-down" data-aos-duration="2000"><span class="nav-link" id="pills-ifs-tab" data-bs-toggle="pill" data-bs-target="#pills-ifs" type="button" role="tab" aria-controls="pills-ifs" aria-selected="false">Infrastructure Finance Secretariat</span></h1>
					  <ol class="level-2-wrapper">
						<li>
						  <h2 class="level-2 rectangle" data-aos="fade-down" data-aos-duration="2000"><span class="nav-link" id="pills-ipp-tab" data-bs-toggle="pill" data-bs-target="#pills-ipp" type="button" role="tab" aria-controls="pills-ipp" aria-selected="false">Infrastructure Policy &amp; Planning (IPP Division)</span>


							</h2>
						  <ol class="level-3-wrapper">
							<li>
							  <ol class="level-4-wrapper">
								<li>
								  <h4 class="level-4 rectangle" data-aos="fade-down" data-aos-duration="500">  <span class="nav-link" id="pills-ppu-tab" data-bs-toggle="pill" data-bs-target="#pills-ppu" type="button" role="tab" aria-controls="pills-ppu" aria-selected="false">Policy &amp; Planning Unit</span></h4>
								</li>
								<li>
								  <h4 class="level-4 rectangle" data-aos="fade-down" data-aos-duration="500"><span class="nav-link" id="pills-ifu-tab" data-bs-toggle="pill" data-bs-target="#pills-ifu" type="button" role="tab" aria-controls="pills-ifu" aria-selected="false">Infra Finance Unit</span></h4>
								</li>
								<li>
								  <h4 class="level-4 rectangle" data-aos="fade-down" data-aos-duration="500"><span class="nav-link" id="pills-cbu-tab" data-bs-toggle="pill" data-bs-target="#pills-cbu" type="button" role="tab" aria-controls="pills-cbu" aria-selected="false">Capacity Building Unit (CBU)</span></h4>
								</li>
							  </ol>
							</li>
						  </ol>
						</li>
						<li>
						  <h2 class="level-2 rectangle" data-aos="fade-down" data-aos-duration="2000"><span class="nav-link" id="pills-isd-tab" data-bs-toggle="pill" data-bs-target="#pills-isd" type="button" role="tab" aria-controls="pills-isd" aria-selected="false">Infrastructure Support &amp; Development (ISD Division)</span></h2>
						  <ol class="level-3-wrapper">
							<li>
							  <ol class="level-4-wrapper">
								<li>
								  <h4 class="level-4 rectangle" data-aos="fade-down" data-aos-duration="500"><span class="nav-link" id="pills-piu-tab" data-bs-toggle="pill" data-bs-target="#pills-piu" type="button" role="tab" aria-controls="pills-piu" aria-selected="false">Project Implementation Unit</span></h4>
								</li>
								<li>
								  <h4 class="level-4 rectangle" data-aos="fade-down" data-aos-duration="500"><span class="nav-link" id="pills-eu-tab" data-bs-toggle="pill" data-bs-target="#pills-eu" type="button" role="tab" aria-controls="pills-eu" aria-selected="false">Energy Unit</span></h4>
								</li>
								<li>
								  <h4 class="level-4 rectangle" data-aos="fade-down" data-aos-duration="500"><span class="nav-link" id="pills-nfu-tab" data-bs-toggle="pill" data-bs-target="#pills-nfu" type="button" role="tab" aria-controls="pills-nfu" aria-selected="false">NIP/NMP Faciliation Unit (NFU)</span></h4>
								</li>

							  </ol>
							</li>

						  </ol>
						</li>
					  </ol>
					</div></div>

<div class="tab-content" id="pills-tabContent">
  <div class="tab-pane fade" id="pills-ifs" role="tabpanel" aria-labelledby="pills-ifs-tab" tabindex="0">
	  <h6>IFS - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Ajay Seth </th>
						<td data-label="Designation">Secretary </td>
						<td data-label="Email Id"><a href="mailto:secy-dea@nic.in">secy-dea@nic.in</a>  </td>
						<td data-label="Landline No.">23092611</td>
						<td data-label="Intercom">5000</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri K Abdulla Syed</th>
						<td data-label="Designation">PPS </td>
							<td data-label="Email Id"><a href="mailto:ka.syed68@gov.in"> ka.syed68@gov.in</a></td>
						<td data-label="Landline No.">23092611, 23092555 </td>
						<td data-label="Intercom">5000</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri V. Ravi</th>
						<td data-label="Designation">PPS </td>
						<td data-label="Email Id"> <a href="mailto:ravi.v@nic.in">ravi.v@nic.in	</a> </td>	
						<td data-label="Landline No.">23092611, 23092555</td>
						<td data-label="Intercom">5000, 5001</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri N Guruprasath</th>
						<td data-label="Designation">PPS</td>
						<td data-label="Email Id">&ndash;</td>	
						<td data-label="Landline No.">23095000</td>
						<td data-label="Intercom">5000</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Ram Rattan </th>
						<td data-label="Designation">Section Officer </td>
						<td data-label="Email Id"><a href="mailto:ram.rattan63@gov.in">ram.rattan63@gov.in</a></td>	
						<td data-label="Landline No.">23095000 </td>
						<td data-label="Intercom">5000</td>
					</tr>
					</tbody>
				</table>
	</div>
  <div class="tab-pane fade" id="pills-ipp" role="tabpanel" aria-labelledby="pills-ipp-tab" tabindex="0">
	  <h6>IPP - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Solomon Arokiaraj </th>
						<td data-label="Designation">Joint Secretary (IPP & G-20)</td>
						<td data-label="Email Id"><a href="mailto:solomona@nic.in">solomona@nic.in</a>  </td>
						<td data-label="Landline No.">011 -23701006, 1008</td>
						<td data-label="Intercom"></td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Surender Singh</th>
						<td data-label="Designation">PPS </td>
							<td data-label="Email Id"> &ndash;</td>
						<td data-label="Landline No.">011 -23701006 </td>
						<td data-label="Intercom">&ndash; </td>
					</tr>
						
					</tbody>
				</table>
  </div>
  <div class="tab-pane fade" id="pills-ppu" role="tabpanel" aria-labelledby="pills-ppu-tab" tabindex="0">
	  <h6>PPU - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Saurabh Singh</th>
						<td data-label="Designation">Deputy Secretary (PPU)</td>
						<td data-label="Email Id"><a href="mailto:singhsaurabh@cag.gov.in">singhsaurabh@cag.gov.in</a>  </td>
						<td data-label="Landline No.">011-23095007</td>
						<td data-label="Intercom">5007</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Ms. Mannu Jain</th>
						<td data-label="Designation">Assistant Director</td>
						<td data-label="Email Id"><a href="mailto:mannujain.824@gov.in">mannujain.824@gov.in</a></td>
						<td data-label="Landline No."> &ndash; </td>
						<td data-label="Intercom"> &ndash; </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Lalita Prasad</th>
						<td data-label="Designation"> Section Officer </td>
						<td data-label="Email Id"><a href="mailto:prasad.lalita@gov.in"> prasad.lalita@gov.in </a></td>	
						<td data-label="Landline No."> &ndash;  </td>
						<td data-label="Intercom">&ndash;  </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Ankit Jain</th>
						<td data-label="Designation">Assistant Section Officer </td>
						<td data-label="Email Id"><a href="mailto:ankit.jain88@nic.in">ankit.jain88@nic.in </a></td>	
						<td data-label="Landline No.">&ndash;  </td>
						<td data-label="Intercom">&ndash;  </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Mobashir Alam </th>
						<td data-label="Designation">Assistant Section Officer</td>
						<td data-label="Email Id"><a href="mailto:mobashir.alam@gov.in">mobashir.alam@gov.in</a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">209</td>
					</tr>
						
					</tbody>
				</table>
	</div>
  <div class="tab-pane fade" id="pills-ifu" role="tabpanel" aria-labelledby="pills-ifu-tab" tabindex="0">
	  <h6>IFU - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Aman Garg</th>
						<td data-label="Designation">Director, (IFU) </td>
						<td data-label="Email Id"><a href="mailto:aman.garg@nic.in">aman.garg@nic.in</a>  </td>
						<td data-label="Landline No.">011-23701071</td>
						<td data-label="Intercom">201</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Ms. Manshi Gupta</th>
						<td data-label="Designation">Deputy Director </td>
							<td data-label="Email Id"><a href="mailto:manshi.gupta@gov.in"> manshi.gupta@gov.in</a></td>
						<td data-label="Landline No.">011-23095158 </td>
						<td data-label="Intercom">5158 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Sabri Bin Kasim</th>
						<td data-label="Designation">Section Officer </td>
						<td data-label="Email Id"><a href="mailto:sabribin.kasim@nic.in">sabribin.kasim@nic.in</a>  </td>	
						<td data-label="Landline No."> &ndash;</td>
						<td data-label="Intercom">&ndash;</td>
					</tr>
						
					</tbody>
				</table>
	</div>
  <div class="tab-pane fade" id="pills-cbu" role="tabpanel" aria-labelledby="pills-cbu-tab" tabindex="0">
	  <h6>CBU - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Antony Cyriac</th>
						<td data-label="Designation">Advisor [IPP & Economic Div.(Prices)]  </td>
						<td data-label="Email Id"><a href="mailto:a.cyriac@nic.in">a.cyriac@nic.in</a>  </td>
						<td data-label="Landline No.">23094140</td>
						<td data-label="Intercom">5036</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Mannu Jain</th>
						<td data-label="Designation">Assistant Director</td>
							<td data-label="Email Id"><a href="mailto:mannujain.824@gov.in"> mannujain.824@gov.in</a></td>
						<td data-label="Landline No.">&ndash;</td>
						<td data-label="Intercom">&ndash; </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Sabri Bin Kasim </th>
						<td data-label="Designation">Section Officer </td>
						<td data-label="Email Id"><a href="mailto:sabribin.kasim@nic.in">sabribin.kasim@nic.in</a></td>	
						<td data-label="Landline No.">&ndash; </td>
						<td data-label="Intercom">&ndash;</td>
					</tr>

					</tbody>
				</table>
	</div>
  <div class="tab-pane fade" id="pills-isd" role="tabpanel" aria-labelledby="pills-isd-tab" tabindex="0">
	  <h6>ISD- Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Ajay Seth </th>
						<td data-label="Designation">Secretary, DEA </td>
						<td data-label="Email Id"><a href="mailto:secy-dea@nic.in">secy-dea@nic.in</a>  </td>
						<td data-label="Landline No.">23092611</td>
						<td data-label="Intercom">5000</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Solomon Arokiaraj</th>
						<td data-label="Designation">Joint Secretary (IPP) </td>
							<td data-label="Email Id"><a href="mailto:solomona@nic.in"> solomona@nic.in</a></td>
						<td data-label="Landline No.">23701006, 23701007 </td>
						<td data-label="Intercom">206,207 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Surender Singh  </th>
						<td data-label="Designation">PPS to JS(IPP) </td>
						<td data-label="Email Id"> &ndash; </td>	
						<td data-label="Landline No.">23701006, 23701007 </td>
						<td data-label="Intercom">208</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Baldeo Purshartha</th>
						<td data-label="Designation">Joint Secretary (ISD) </td>
						<td data-label="Email Id"><a href="mailto:purushartha.baldeo@ias.gov.in">purushartha.baldeo@ias.gov.in </a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">210,211 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri N. Srinivasan Sr. </th>
						<td data-label="Designation">PPS to JS(ISD) </td>
						<td data-label="Email Id"><a href="mailto:n.srinivasan@nic.in">n.srinivasan@nic.in </a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">209</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Jitendra Raje </th>
						<td data-label="Designation">Director (NFU) </td>
						<td data-label="Email Id"><a href="mailto:jitendra.singh14@nic.in">jitendra.singh14@nic.in </a></td>	
						<td data-label="Landline No.">-</td>
						<td data-label="Intercom">-</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Mukesh Kumar Gupta  </th>
						<td data-label="Designation">Director (IPP) </td>
						<td data-label="Email Id"><a href="mailto:mukesh.gupta1963@gov.in">mukesh.gupta1963@gov.in </a></td>	
						<td data-label="Landline No.">23701024</td>
						<td data-label="Intercom">202</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Aman Garg </th>
						<td data-label="Designation">Director (IFU) </td>
						<td data-label="Email Id"><a href="mailto:aman.garg@nic.in">aman.garg@nic.in </a></td>
						<td data-label="Landline No.">23701071 </td>
						<td data-label="Intercom">201</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Shiv Kumar  </th>
						<td data-label="Designation">Deputy Secretary (ISD) </td>
						<td data-label="Email Id"><a href="mailto:r.shivakumar@nic.in">r.shivakumar@nic.in </a></td>
						<td data-label="Landline No.">23701066</td>
						<td data-label="Intercom">204</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Dr. Molishree </th>
						<td data-label="Designation">Deputy Secretary </td>
						<td data-label="Email Id"><a href="mailto:moli.shree@gov.in">moli.shree@gov.in </a></td>
						<td data-label="Landline No.">23701040</td>
						<td data-label="Intercom">205</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Saurabh Singh </th>
						<td data-label="Designation">Deputy Secretary (IPP) </td>
						<td data-label="Email Id"><a href="mailto:singhsaurabh@cag.gov.in">singhsaurabh@cag.gov.in </a></td>
						<td data-label="Landline No.">23095007, 9882989770 </td>
						<td data-label="Intercom">5007</td>
					</tr>
					<tr>
						<th scope="row" data-label="Name">Shri Manoj Kumar Madholia </th>
						<td data-label="Designation">Joint Director (Energy) </td>
						<td data-label="Email Id"><a href="mailto:manoj.km@nic.in">manoj.km@nic.in </a></td>
						<td data-label="Landline No."> - </td>
						<td data-label="Intercom"> - </td>
					</tr>
					<tr>
						<th scope="row" data-label="Name">Shri Amit Agrahari  </th>
						<td data-label="Designation">Director (IER) </td>
						<td data-label="Email Id"> - </td>
						<td data-label="Landline No."> - </td>
						<td data-label="Intercom"> - </td>
					</tr>
					</tbody>
				</table>
	</div>
  <div class="tab-pane fade" id="pills-piu" role="tabpanel" aria-labelledby="pills-piu-tab" tabindex="0">
	  <h6>PIU - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Ajay Seth </th>
						<td data-label="Designation">Secretary, DEA </td>
						<td data-label="Email Id"><a href="mailto:secy-dea@nic.in">secy-dea@nic.in</a>  </td>
						<td data-label="Landline No.">23092611</td>
						<td data-label="Intercom">5000</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Solomon Arokiaraj</th>
						<td data-label="Designation">Joint Secretary (IPP) </td>
							<td data-label="Email Id"><a href="mailto:solomona@nic.in"> solomona@nic.in</a></td>
						<td data-label="Landline No.">23701006, 23701007 </td>
						<td data-label="Intercom">206,207 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Surender Singh  </th>
						<td data-label="Designation">PPS to JS(IPP) </td>
						<td data-label="Email Id"> &ndash; </td>	
						<td data-label="Landline No.">23701006, 23701007 </td>
						<td data-label="Intercom">208</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Baldeo Purshartha</th>
						<td data-label="Designation">Joint Secretary (ISD) </td>
						<td data-label="Email Id"><a href="mailto:purushartha.baldeo@ias.gov.in">purushartha.baldeo@ias.gov.in </a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">210,211 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri N. Srinivasan Sr. </th>
						<td data-label="Designation">PPS to JS(ISD) </td>
						<td data-label="Email Id"><a href="mailto:n.srinivasan@nic.in">n.srinivasan@nic.in </a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">209</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Jitendra Raje </th>
						<td data-label="Designation">Director (NFU) </td>
						<td data-label="Email Id"><a href="mailto:jitendra.singh14@nic.in">jitendra.singh14@nic.in </a></td>	
						<td data-label="Landline No.">-</td>
						<td data-label="Intercom">-</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Mukesh Kumar Gupta  </th>
						<td data-label="Designation">Director (IPP) </td>
						<td data-label="Email Id"><a href="mailto:mukesh.gupta1963@gov.in">mukesh.gupta1963@gov.in </a></td>	
						<td data-label="Landline No.">23701024</td>
						<td data-label="Intercom">202</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Aman Garg </th>
						<td data-label="Designation">Director (IFU) </td>
						<td data-label="Email Id"><a href="mailto:aman.garg@nic.in">aman.garg@nic.in </a></td>
						<td data-label="Landline No.">23701071 </td>
						<td data-label="Intercom">201</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Shiv Kumar  </th>
						<td data-label="Designation">Deputy Secretary (ISD) </td>
						<td data-label="Email Id"><a href="mailto:r.shivakumar@nic.in">r.shivakumar@nic.in </a></td>
						<td data-label="Landline No.">23701066</td>
						<td data-label="Intercom">204</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Dr. Molishree </th>
						<td data-label="Designation">Deputy Secretary </td>
						<td data-label="Email Id"><a href="mailto:moli.shree@gov.in">moli.shree@gov.in </a></td>
						<td data-label="Landline No.">23701040</td>
						<td data-label="Intercom">205</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Saurabh Singh </th>
						<td data-label="Designation">Deputy Secretary (IPP) </td>
						<td data-label="Email Id"><a href="mailto:singhsaurabh@cag.gov.in">singhsaurabh@cag.gov.in </a></td>
						<td data-label="Landline No.">23095007, 9882989770 </td>
						<td data-label="Intercom">5007</td>
					</tr>
					<tr>
						<th scope="row" data-label="Name">Shri Manoj Kumar Madholia </th>
						<td data-label="Designation">Joint Director (Energy) </td>
						<td data-label="Email Id"><a href="mailto:manoj.km@nic.in">manoj.km@nic.in </a></td>
						<td data-label="Landline No."> - </td>
						<td data-label="Intercom"> - </td>
					</tr>
					<tr>
						<th scope="row" data-label="Name">Shri Amit Agrahari  </th>
						<td data-label="Designation">Director (IER) </td>
						<td data-label="Email Id"> - </td>
						<td data-label="Landline No."> - </td>
						<td data-label="Intercom"> - </td>
					</tr>
					</tbody>
				</table>
	</div>
<div class="tab-pane fade" id="pills-eu" role="tabpanel" aria-labelledby="pills-eu-tab" tabindex="0">
	  <h6>EU - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Manoj Kumar Madholia </th>
						<td data-label="Designation">Joint Director (Energy Unit) </td>
						<td data-label="Email Id"><a href="mailto:manoj.km@nic.in">manoj.km@nic.in</a>  </td>
						<td data-label="Landline No.">011-23701219</td>
						<td data-label="Intercom">204</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Ms. Kaumudi Sharma</th>
						<td data-label="Designation">Deputy Director (Energy Unit) </td>
							<td data-label="Email Id"><a href="mailto:kaumudi.sharma@nic.in"> kaumudi.sharma@nic.in</a></td>
						<td data-label="Landline No.">011-23701020 </td>
						<td data-label="Intercom"> &ndash; </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Ms. Anjali Singh  </th>
						<td data-label="Designation">Assistant Section Officer </td>
						<td data-label="Email Id"> <a href="mailto:singh.anjali@gov.in">singh.anjali@gov.in</a> </td>	
						<td data-label="Landline No."> &ndash; </td>
						<td data-label="Intercom">&ndash;</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Kuldeep Meena</th>
						<td data-label="Designation">Assistant Section Officer </td>
						<td data-label="Email Id"> <a href="mailto:kuldeep.meena14@gov.in">kuldeep.meena14@gov.in</a> </td>	
						<td data-label="Landline No."> &ndash; </td>
						<td data-label="Intercom">&ndash; </td>
					</tr>
						
					</tbody>
				</table>
	</div>
	<div class="tab-pane fade" id="pills-nfu" role="tabpanel" aria-labelledby="pills-nfu-tab" tabindex="0">
	  <h6>NFU - Key Officers</h6>
	<table class="table table-bordered contact_table">
					<thead class="table-dark">
					<tr>
						<th scope="col">Name </th>
						<th scope="col">Designation</th>
						<th scope="col">Email Id</th>
						<th scope="col">Landline No. </th>
						<th scope="col">Intercom</th>
					</tr>

					</thead>
					<tbody>
					<tr>
						<th scope="row" data-label="Name">Shri Ajay Seth </th>
						<td data-label="Designation">Secretary, DEA </td>
						<td data-label="Email Id"><a href="mailto:secy-dea@nic.in">secy-dea@nic.in</a>  </td>
						<td data-label="Landline No.">23092611</td>
						<td data-label="Intercom">5000</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Solomon Arokiaraj</th>
						<td data-label="Designation">Joint Secretary (IPP) </td>
							<td data-label="Email Id"><a href="mailto:solomona@nic.in"> solomona@nic.in</a></td>
						<td data-label="Landline No.">23701006, 23701007 </td>
						<td data-label="Intercom">206,207 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Surender Singh  </th>
						<td data-label="Designation">PPS to JS(IPP) </td>
						<td data-label="Email Id"> &ndash; </td>	
						<td data-label="Landline No.">23701006, 23701007 </td>
						<td data-label="Intercom">208</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Baldeo Purshartha</th>
						<td data-label="Designation">Joint Secretary (ISD) </td>
						<td data-label="Email Id"><a href="mailto:purushartha.baldeo@ias.gov.in">purushartha.baldeo@ias.gov.in </a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">210,211 </td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri N. Srinivasan Sr. </th>
						<td data-label="Designation">PPS to JS(ISD) </td>
						<td data-label="Email Id"><a href="mailto:n.srinivasan@nic.in">n.srinivasan@nic.in </a></td>	
						<td data-label="Landline No.">23701037, 23701038 </td>
						<td data-label="Intercom">209</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Jitendra Raje </th>
						<td data-label="Designation">Director (NFU) </td>
						<td data-label="Email Id"><a href="mailto:jitendra.singh14@nic.in">jitendra.singh14@nic.in </a></td>	
						<td data-label="Landline No.">-</td>
						<td data-label="Intercom">-</td>
					</tr>
						<tr>

						<th scope="row" data-label="Name">Shri Mukesh Kumar Gupta  </th>
						<td data-label="Designation">Director (IPP) </td>
						<td data-label="Email Id"><a href="mailto:mukesh.gupta1963@gov.in">mukesh.gupta1963@gov.in </a></td>	
						<td data-label="Landline No.">23701024</td>
						<td data-label="Intercom">202</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Aman Garg </th>
						<td data-label="Designation">Director (IFU) </td>
						<td data-label="Email Id"><a href="mailto:aman.garg@nic.in">aman.garg@nic.in </a></td>
						<td data-label="Landline No.">23701071 </td>
						<td data-label="Intercom">201</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Shiv Kumar  </th>
						<td data-label="Designation">Deputy Secretary (ISD) </td>
						<td data-label="Email Id"><a href="mailto:r.shivakumar@nic.in">r.shivakumar@nic.in </a></td>
						<td data-label="Landline No.">23701066</td>
						<td data-label="Intercom">204</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Dr. Molishree </th>
						<td data-label="Designation">Deputy Secretary </td>
						<td data-label="Email Id"><a href="mailto:moli.shree@gov.in">moli.shree@gov.in </a></td>
						<td data-label="Landline No.">23701040</td>
						<td data-label="Intercom">205</td>
					</tr>
					<tr>

						<th scope="row" data-label="Name">Shri Saurabh Singh </th>
						<td data-label="Designation">Deputy Secretary (IPP) </td>
						<td data-label="Email Id"><a href="mailto:singhsaurabh@cag.gov.in">singhsaurabh@cag.gov.in </a></td>
						<td data-label="Landline No.">23095007, 9882989770 </td>
						<td data-label="Intercom">5007</td>
					</tr>
					<tr>
						<th scope="row" data-label="Name">Shri Manoj Kumar Madholia </th>
						<td data-label="Designation">Joint Director (Energy) </td>
						<td data-label="Email Id"><a href="mailto:manoj.km@nic.in">manoj.km@nic.in </a></td>
						<td data-label="Landline No."> - </td>
						<td data-label="Intercom"> - </td>
					</tr>
					<tr>
						<th scope="row" data-label="Name">Shri Amit Agrahari  </th>
						<td data-label="Designation">Director (IER) </td>
						<td data-label="Email Id"> - </td>
						<td data-label="Landline No."> - </td>
						<td data-label="Intercom"> - </td>
					</tr>
					</tbody>
				</table>
	</div>
</div>

		</div>
		</section>
	 
	  </main>

<!--End of footer-->	


 <% }else{ %>

<div class="createuser-page">
<div class="">
 <div class="<% if(!role.equalsIgnoreCase("Departmentuser")){ %>  jhansiall-pagestwo <% } %>">

<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="About US"/></span></h1>
           </div>
         
		<div class="container">
		<% 
		int size=AboutusLocalServiceUtil.getAboutusesCount();

		if(role.equalsIgnoreCase("Departmentuser") && size==0){ %>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=createFormsURL %>" cssClass="btn btn-black btn-sm-block" > 
                           	   
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add AboutUs</button></a>
                           </div>
                      </div>
                      
                      <% } %>
                      
                     
			<div class="table-responsive">
		<% 
		    List<Aboutus> resultList=null;
						List<Aboutus> DownloadFormsList =AboutusLocalServiceUtil.getAboutuses(0, size) ;
		 %>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList = ListUtil.subList(DownloadFormsList, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.Aboutus" keyProperty="aboutusId" modelVar="abt">
		      		
				      	<% 
				      	long aboutusId =0L;
				      	String mainDescription =  "";
				   	 	String hi_mainDescription = "";
				   	 	String hi_keyDescription = "";
				   	 	String keyDescription = "";
				   	 	long fileEntryId=0L;
				      	String publishDate="";
				      	String fileUrl="";
				      	try{
				      		aboutusId =abt.getAboutusId();
				      		keyDescription =abt.getKeyDescription(); 
				      		mainDescription=abt.getMainDescription(); 
 
				      		 if(languageId.equals("hi_IN")){
				      			keyDescription =abt.getKeyDescription(); 
					      		mainDescription=abt.getMainDescription(); 
				      		 }
				      		hi_keyDescription =abt.getHi_keyDescription(); 
				      		hi_mainDescription=abt.getHi_mainDescription(); 
					      	  fileEntryId=abt.getFileEntryId();
					      	  if(fileEntryId!=0L){
									try{
										fileUrl = AboutIFSPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
									}
									catch(Exception e){
										
									}
					      	  }
 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

		<liferay-ui:search-container-column-text name="Main description" value="<%= mainDescription %>" />  
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Main description in Hindi" value="<%= hi_mainDescription %>" />  
		
		<% } %>
		 
		<liferay-ui:search-container-column-text name="Reportsandinsights Image">
		<a href="#" data-toggle="modal" data-target="#myModalimge-<%=aboutusId%>"> 
		<div class=" ">
			<% if(fileUrl!=""){ %><img width="150px;" height="100px;" src="<%=fileUrl %>" class="btn btn-primary m-0" /><% } %>
		</div>
		</a>
		<div class="modal" id="myModalimge-<%=aboutusId%>">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
        </div>
        
       
        <div class="modal-body">
         <div class=" ">
			<% if(fileUrl!=""){ %><img width="100%;" height="250px;" src="<%=fileUrl %>" class="btn btn-primary m-0" /><% } %>
		</div>
        </div>
        
        
        
      </div>
    </div>
  </div>
		</liferay-ui:search-container-column-text>
		
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=aboutusId%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
		</div>
		</liferay-ui:search-container-column-text>
		<% } %>
		
 	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator  />
					</liferay-ui:search-container>
		    </div>
		    
		     <div class="row">
	   				<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=addPeopleURL %>" cssClass="btn btn-black btn-sm-block" > 
                           	   
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add key people</button></a>
                    </div>
              </div>
            <div class="table-responsive">
		<% 
		    List<IFSKeyOfficers> resultList1=null;
			int size1=IFSKeyOfficersLocalServiceUtil.getIFSKeyOfficersesCount();
			List<IFSKeyOfficers> DownloadFormsList1 =IFSKeyOfficersLocalServiceUtil.getIFSKeyOfficerses(0, size1) ;
		 %>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size1 %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList1 = ListUtil.subList(DownloadFormsList1, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList1 %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.IFSKeyOfficers" keyProperty="reportId" modelVar="officer">
		      		
				      	<% 
				      	long keyofficerId =0L;
				      	String name="";  	
				        String email="";
				        String designation="";
				        String landlineNo ="";
				        String intercom ="";
				      	try{
				      		keyofficerId =officer.getKeyofficerId();
				      		name =officer.getName(); 
				      		email=officer.getEmail(); 
				      		designation =officer.getDesignation(); 
				      		landlineNo=officer.getLandlineNo();
				      		intercom=officer.getIntercom();
					      	 
 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

	  <liferay-ui:search-container-column-text name="S.No." value="<%= String.valueOf(sNo++) %>" />
		<liferay-ui:search-container-column-text name="Title" value="<%= name %>" />
		<liferay-ui:search-container-column-text name="email" value="<%= email %>" />
		<liferay-ui:search-container-column-text name="designation" value="<%= designation %>" />
		<liferay-ui:search-container-column-text name="landlineNo" value="<%= landlineNo %>" />
		<liferay-ui:search-container-column-text name="intercom" value="<%= intercom %>" />
		
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updatekeyPeople('<%=keyofficerId%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deletekeyPeople('<%=keyofficerId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
		</div>
		</liferay-ui:search-container-column-text>
		<% } %>
		
 	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator  />
					</liferay-ui:search-container>
		    </div>   
		    
	    </div>
	</div>
</div> 
</div></div></div>


<% } %>

  <%  if(role.equalsIgnoreCase("Departmentuser")){ %>
<script type="text/javascript" src="js/jquery.min.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.bundle.min.js"></script>
	  <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>	  

<!-- Owl Carousel Slider -->
<script type="text/javascript" src="js/owl.carousel.min.js"></script>
<script src="js/app.js"></script>
	  
<!-- Lightbox JS -->
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.18/dist/js/uikit.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/uikit@3.16.18/dist/js/uikit-icons.min.js"></script>
	  
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" > </script>

		<portlet:renderURL var="updateRecordURL">
			<portlet:param name="mvcPath" value="/createForm.jsp"/>  
		</portlet:renderURL>
		
		
		
		<portlet:renderURL var="updatekeyPeopleURL">
			<portlet:param name="mvcPath1" value="/addPeople.jsp"/>  
		</portlet:renderURL>
		
		<portlet:actionURL var="deleteRecordURL" name="deleteKeypeople">
         </portlet:actionURL>
		  
<script>
function updateRecord(aboutusId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />aboutusId]').val(aboutusId);
	$("#<portlet:namespace />update").submit();
}


	
	function updatekeyPeople(keyofficerId){
		$('#<portlet:namespace />update').find('input[name=<portlet:namespace />keyofficerId]').val(keyofficerId);
		$("#<portlet:namespace />update").submit();
	}
	
	function deletekeyPeople(keyofficerId){
		if(confirm('Are you sure you want to delete?')){
			$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />keyofficerId]').val(keyofficerId);
			$('#<portlet:namespace />delete').submit();
		}
		else{
			return false;
		}
	}
  </script>	
  
  
<aui:form name="update" method="post" action="<%=updateRecordURL %>" style="display:none;">
   <aui:input type="text" name="aboutusId" value=""></aui:input>
</aui:form>


<aui:form name="update1" method="post" action="<%=updatekeyPeopleURL %>" style="display:none;">
   <aui:input type="text" name="keyofficerId" value=""></aui:input>
</aui:form>
<aui:form name="delete" method="post" action="<%=deleteRecordURL %>" style="display:none;">
   <aui:input type="text" name="keyofficerId" value=""></aui:input>
</aui:form>
    
	   <script type="text/javascript">
     AOS.init();
	  </script>

<% } %>