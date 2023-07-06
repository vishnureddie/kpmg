<%@page import="com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="java.util.List"%>
<%@ include file="/init.jsp" %>
<%@page import="com.kpmg.citizenTables.service.HmlMainDescriptionLocalServiceUtil"%>
 <%@page import="com.kpmg.citizenTables.service.HmlMainDescriptionServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HmlMainDescription"%>
 <%@page import="com.kpmg.citizenTables.service.HmlTimelineServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HmlTimeline"%>
<%@page import="com.kpmg.citizenTables.service.HmlTimelineLocalServiceUtil"%>
 <%@page import="java.text.SimpleDateFormat"%>
 <%@page import="javax.portlet.PortletURL"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.HarmonizedMasterList.constants.HarmonizedMasterListPortletKeys"%> 
<%@page import="com.kpmg.HarmonizedMasterList.portlet.HarmonizedMasterListPortlet"%>


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
<portlet:renderURL var="addDescriptionURL">
	<portlet:param name="mvcPath" value="/addDescription.jsp"/>
</portlet:renderURL> 

<portlet:renderURL var="createFormsURL">
	<portlet:param name="mvcPath" value="/createForm.jsp"/>
</portlet:renderURL>

<!doctype html>
<html lang="en">
  <head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Infrastructure in India</title>
  <link type="text/css" rel="stylesheet" href="bootstrap/css/bootstrap.min.css" />
  
    <!-- Font Awesome  -->
    <script src="https://site-assets.fontawesome.com/releases/v6.2.0/js/sharp-solid.js" data-auto-add-css="false" data-auto-replace-svg="false"></script>


  <!-- Owl Carousel -->
 <link type="text/css" rel="stylesheet" href="css/owl.carousel.min.css" />
 <link type="text/css" rel="stylesheet"  href="css/owl.theme.default.min.css" />

	   <!-- Font Awesome  -->
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.2.0/css/all.css" />
    <link rel="stylesheet" href="https://site-assets.fontawesome.com/releases/v6.2.0/css/sharp-solid.css" />
    <script src="https://site-assets.fontawesome.com/releases/v6.2.0/js/all.js" data-auto-add-css="false" data-auto-replace-svg="false"></script>
    <script src="https://site-assets.fontawesome.com/releases/v6.2.0/js/sharp-solid.js" data-auto-add-css="false" data-auto-replace-svg="false"></script>

<!-- Custom CSS -->
<link href="css/style.css" rel="stylesheet" />
	  <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
  
 <!--FONTS--> 	  
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:wght@300;400;700;900&family=Roboto+Slab:wght@300;400;500;700&display=swap" rel="stylesheet">


	  <style>
		   :root{ --main-color: #4C8DDA; }
		  
.view_pdf{ font-size:14px; color: #222; border: solid 1px #ccc; padding: 4px; background-color: #f2f2f2; margin-top: 10px;}
		  .view_pdf:hover{ color: #000;}
.main-timeline{ font-family: 'Poppins', sans-serif; }
.main-timeline:after{
    content: '';
    display: block;
    clear: both;
}
.main-timeline .timeline{
    width: 50%;
    padding: 60px 0 0 0;
    margin: 0 5px 10px 0;
    float: left;
}
.main-timeline .timeline-content{
   /* min-height: 100px;*/
    padding: 0 15px 0 0;
    border-right: 2px solid var(--main-color);
    display: block;
    position: relative;
}
.main-timeline .timeline-content:hover{ text-decoration: none; }
.main-timeline .timeline-content:before,
.main-timeline .timeline-content:after{
    content: '';
    background-color: var(--main-color);
    height: 6px;
    width: 6px;
    border-radius: 50%;
    position: absolute;
    right: -4px;
    top: 0;
}
.main-timeline .timeline-content:after{
    top: auto;
    bottom: 0;
}
.main-timeline .timeline-year{
    color: #fff;
    background-color: var(--main-color);
    font-size: 25px;
    font-weight: 600;
    letter-spacing: 0.5px;
    padding: 3px 20px 3px 50px;
    position: absolute;
    right: -2px;
    top: -30px;
    z-index: 1;
    clip-path: polygon(15% 0, 100% 0, 100% 100%, 15% 100%, 0 50%);
}
.main-timeline .title{
    color: var(--main-color);
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: capitalize;
    margin: 0 0 7px;
}
.main-timeline .description{
    color: #555;
    font-size: 13px;
    font-weight: 500;
    line-height: 22px;
    text-align: left;
    letter-spacing: 0.5px;
    margin: 0;
}
.main-timeline .timeline:nth-child(even){
    margin: 0 0 10px 5px;
    float: right;
}
.main-timeline .timeline:nth-child(even) .timeline-content{
    text-align: left;
    padding: 0 0 0 15px;
    border-left: 2px solid var(--main-color);
    border-right: none;
}
.main-timeline .timeline:nth-child(even) .timeline-content:before,
.main-timeline .timeline:nth-child(even) .timeline-content:after{
    right: auto;
    left: -4px;
}
.main-timeline .timeline:nth-child(even) .timeline-year{
    right: auto;
    left: -2px;
    clip-path: polygon(0 0, 85% 0, 100% 50%, 85% 100%, 0 100%);
}
.main-timeline .timeline:nth-child(2n+1){ --main-color:  #E1AA1D; }
.main-timeline .timeline:nth-child(3n+1){ --main-color: #49C389; }
.main-timeline .timeline:nth-child(4n+1){ --main-color: #DF3838; }
@media screen and (max-width:767px){
    .main-timeline .timeline,
    .main-timeline .timeline:nth-child(even){
        width: 100%;
        margin: 0 0 25px;
    }
}
		  
.accordion-button.collapsed, .accordion-button{font-weight: 500; font-size:14px; line-height: 20px; border-radius: 5px; padding: 5px 0; background: #000 !important;}
.accordion-button.collapsed{color: #12743b; border:0; background: rgba(0,0,0,0) !important;	}
.accordion-button:not(.collapsed){color: #12743b;}
.accordion-button{ background-color: rgba(0,0,0,0) !important; color: #000; border-radius: 5px 5px 0 0;  }
.accordion-button:focus{ border-color: transparent; box-shadow: transparent !important;}
.accordion-body{border-top:0;  }
h2.accordion-header{text-align: center; line-height: 2px; padding: 0px;  margin-bottom: 0px !important; border-radius: 0 !important; }
h2.accordion-header .accordion-button{  }
.accordion-item{ background: transparent;  border:0 !important; line-height: 25px; font-size: 14px; margin-bottom: 0px; color: #555;}
.accordion-button:not(.collapsed)::before {content: "\f068";	font-family: "FontAwesome";	color: #12743b; background-image: none; margin-right:10px;  }
.accordion-button:not(.collapsed)::after, .accordion-button.collapsed::after{ display:none;}
.accordion-button.collapsed::before {content: "\2b";	color: #111111; font-weight: 400;	font-family: "FontAwesome";	background-image: none;margin-right:10px;  }
</style>
	  
</head>

  <body>

<% if(!role.equalsIgnoreCase("Departmentuser")){ %>

<main class="main_innerlayout">
<section class="top_innerBanner ">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1>Harmonized Master List</h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/home">Home</a></li>
				<li class="breadcrumb-item active">Harmonized Master List</li>
			  </ol>
			</nav>
		</div>	
</section>

	<section>
		<div class="container">
		       <% 
 
List<HmlMainDescription> about=null;
  try{
	 // int size=ImportantLinksLocalServiceUtil.getImportantLinksCount();
	  //importantLinks=ImportantLinksLocalServiceUtil.findBylanguageId(languageId, 0, ImportantLinksLocalServiceUtil.countBylanguageId(languageId));
		 about =HmlMainDescriptionLocalServiceUtil.getHmlMainDescriptions(0, HmlMainDescriptionLocalServiceUtil.getHmlMainDescriptionsCount());

  }
  catch(Exception e){
	  e.getMessage();
  }
       int x=1;
       
  for(HmlMainDescription abt:about){
	  String hmlmainDescription=abt.getHmlmainDescription(); 
	  if(languageId.equals("hi_IN")){
		  hmlmainDescription =abt.getHi_hmlmainDescription();
		 }
       %>
			<p> <%=hmlmainDescription%> </p>
			
		<% x++; } %>
		
		</div>

		</section>
	
	
	<section class="light_bg">
		<div class="container">
			<div class="main_heading"><h1>Timeline</h1></div>
			<p>Below is the timeline of evolution of the Harmonized Master List of Infrastructure sub-sectors since 2012.</p>
				 <div class="main-timeline">
				 
<% 				 
					List<HmlTimeline> reports=null;
  try{
	 // int size=ImportantLinksLocalServiceUtil.getImportantLinksCount();
	  //importantLinks=ImportantLinksLocalServiceUtil.findBylanguageId(languageId, 0, ImportantLinksLocalServiceUtil.countBylanguageId(languageId));
		 reports = HmlTimelineLocalServiceUtil.getHmlTimelines(0, HmlTimelineLocalServiceUtil.getHmlTimelinesCount());
  }
  catch(Exception e){
	  e.getMessage();
  }
       int y=1;
  for(HmlTimeline report:reports){
	  String fileUrl="";
	  String year=report.getYear();
	  String month=report.getMonth();
	  String hmlDescription =report.getHmlDescription(); 
	  if(languageId.equals("hi_IN")){
		  hmlDescription =report.getHi_hmlDescription(); 
		 }
	  long fileEntryId=report.getFileEntryId();
	  if(fileEntryId!=0L){
			try{
				fileUrl =HarmonizedMasterListPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
			}
			catch(Exception e){
				
			}
	  }
	  
	  
       %> 
				 		<div class="timeline">
								<div href="#" class="timeline-content" data-aos="fade-down" data-aos-duration="2000">
									<div class="timeline-year"><%=year%></div>

									<div class="accordion accordion-flush" id="accordionFlushExample2017">
									  <div class="accordion-item">
										<h2 class="accordion-header" id="headingOne2017">
										  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne2017" aria-expanded="false" aria-controls="collapseOne">
											 <h3 class="title"><%=month %></h3>
										  </button>
										</h2>
										<div id="collapseOne2017" class="accordion-collapse collapse" aria-labelledby="headingOne2017" data-bs-parent="#accordionFlushExample2017">
										  <div class="accordion-body">
											 <p class="description"><%=hmlDescription %> </p>
											  <p><a href="<%=fileUrl %> class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
											</div>
										</div>
									  </div>
									</div> <!--ACCORDION-->
								</div>
							</div>
				 	
				 	<!--	
							<div class="timeline" data-aos="fade-down" data-aos-duration="500">
								<a href="#" class="timeline-content">
									<div class="timeline-year">2022</div>
									<h3 class="title">October</h3>
									<p class="description">
										2 sub-sectors i.e. “Data Centre” and “Energy Storage System” have been included in Harmonised Master List of Infrastructure Sub-Sector. 
									</p>
									<p><a href="pdf/1.pdf" class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
								</a>
							</div>

					 <div class="timeline">
								<div href="#" class="timeline-content" data-aos="fade-down" data-aos-duration="2000">
									<div class="timeline-year">2017</div>

									<div class="accordion accordion-flush" id="accordionFlushExample2017">
									  <div class="accordion-item">
										<h2 class="accordion-header" id="headingOne2017">
										  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseOne2017" aria-expanded="false" aria-controls="collapseOne">
											 <h3 class="title">November</h3>
										  </button>
										</h2>
										<div id="collapseOne2017" class="accordion-collapse collapse" aria-labelledby="headingOne2017" data-bs-parent="#accordionFlushExample2017">
										  <div class="accordion-body">
											 <p class="description">
									   “Transport” category was widened to “Transport and Logistics” category. “Logistics Infrastructure” was included by insertion of a new item in the renamed category of “Transport and Logistics”. “Logistics Infrastructure” includes Multimodal Logistics Park comprising Inland Container Depot (ICD) with minimum investment of Rs.50 crore and minimum area of 10-acre, Cold Chain facility with minimum investment of Rs.15 crore and minimum area of 20000 sq. ft. and/or Warehousing Facility with investment of minimum Rs.25 crore and minimum area of 1 lakh sq. ft.
									</p>
											  <p><a href="pdf/1.pdf" class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
											</div>
										</div>
									  </div>
									  <div class="accordion-item">
										<h2 class="accordion-header" id="headingTwo2017">
										  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapseTwo2017" aria-expanded="false" aria-controls="collapseTwo2017">
											<h3 class="title">October</h3>
										  </button>
										</h2>
										<div id="collapseTwo2017" class="accordion-collapse collapse" aria-labelledby="headingTwo2017" data-bs-parent="#accordionFlushExample2017">
										  <div class="accordion-body"><p class="description">
									   Under the Category of “Social and Commercial Infrastructure” the sub-category ‘Three-star or higher category hotels located outside cities with population of more than 1 million” was amended as “Tourism infrastructure viz. (i) three-star or higher category classified hotels located outside cities with population of more than 1 million, (ii) rope-ways and cable cars”. 
									</p>
											<p><a href="pdf/1.pdf" class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
											</div>
										</div>
									  </div>
									</div> 
								</div>
							</div>

					

					 		<div class="timeline">
								<div href="#" class="timeline-content" data-aos="fade-down" data-aos-duration="2000">
									 <div class="timeline-year">2014</div>
									<p class="description">
									 In October 2014, under the category of “Social and Commercial Infrastructure” the sub-category “Common infrastructure for industrial parks, Special Economic Zones, tourism facilities and agricultural markets” is amended as “Common infrastructure for Industrial Parks and other parks with industrial activity such as food parks, textile parks, Special Economic Zones, tourism facilities and agricultural markets”.
									</p>
									<p><a href="pdf/1.pdf" class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
								</div>
							</div>
					-->
					 
<% y++; } %>
			</div> <!--maintimeline-->
		</div>
	</section>
	
	
	<section>
		<div class="container">
			<div class="main_heading"><h1>Category List</h1></div>
			<table class="table table-bordered subsector_list">
				<div class="accordion accordion-flush" id="accordionsubsectorlist">
				<tr class="table-dark">
					<th width="50%">Category</th>
					<th>Infrastructure Sub Sectors</th>
				</tr>
				<tr>
					<th>Transport &amp; Logistic</th>
					<td>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingTransport">
							  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseTransport" aria-expanded="false" aria-controls="flush-collapseTransport">
							   Explore Sub Sector
							  </button>
							</h2>
							<div id="flush-collapseTransport" class="accordion-collapse collapse" aria-labelledby="flush-headingTransport" data-bs-parent="#accordionsubsectorlist">
							  <div class="accordion-body">
								<ul>
									<li>Roads and Bridges</li>
									<li>Ports <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes Capital Dredging"></i> </li>
									<li>Shipyards <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="“Shipyard” is defined as a floating or land-based facility with the essential features of waterfront, turning basin, berthing and docking facility, slipways and/or ship lifts, and which is self sufficient for carrying on shipbuilding/repair/breaking activities."></i> </li>
									<li>Inland Waterways</li>
									<li>Airport</li>
									<li>Railway track including electrical &amp; signalling system, tunnels, viaducts, bridges</li>
									<li>Railway rolling stock along with workshop and associated maintenance facilities </li>
									<li>Railway terminal infrastructure including stations and adjoining commercial infrastructure</li>
									<li>Urban Public Transport (except rolling stock in case of urban road transport)</li>
									<li>Logistics Infrastructure <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Logistics Infrastructure” means and includes Multimodal Logistics Park comprising Inland Container Depot (ICD) with minimum investment of Rs 50 crore and minimum area of 10 acre, Cold Chain Facility
						with minimum investment of Rs 15 crore and minimum area of 20,000 sft, and/or Warehousing Facility with investment of minimum Rs 25 crore and minimum area of 1 lakh sq ft."></i> </li>
									<li>Bulk Material Transportation Pipelines <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes Oil, Gas, Slurry, Water supply and Iron Ore Pipelines"></i> 	</li>
									</ul>
							  </div>
							</div>
						  </div>
					</td>
				</tr>
				<tr>
					<th>Energy</th>
					<td>
						  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingEnergy">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseEnergy" aria-expanded="false" aria-controls="flush-collapseEnergy">
       Explore Sub Sector
      </button>
    </h2>
    <div id="flush-collapseEnergy" class="accordion-collapse collapse" aria-labelledby="flush-headingEnergy" data-bs-parent="#accordionsubsectorlist">
      <div class="accordion-body">
		<ul>
								<li>Electricity Generation</li>
								<li>Electricity Transmission</li>
								<li>Electricity Distribution</li>
								<li>Oil/Gas/Liquefied Natural Gas (LNG) storage facility <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes Oil, Gas, Slurry, Water supply and Iron Ore Pipelines"></i> </li>
								<li>Energy Storage Systems (ESS) <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes strategic storage of crude oil."></i> </li>
							  </ul>
		</div>
    </div>
  </div>
					</td>
				</tr>	
				<tr>
					<th>Water and Sanitation</th>
					<td>
						  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingWater">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseWater" aria-expanded="false" aria-controls="flush-collapseWater">
       Explore Sub Sector
      </button>
    </h2>
    <div id="flush-collapseWater" class="accordion-collapse collapse" aria-labelledby="flush-headingWater" data-bs-parent="#accordionsubsectorlist">
      <div class="accordion-body">
		<ul>
		<li>Solid Waste Management</li>
		<li>Water treatment plants</li>
		<li>Sewage collection, treatment and disposal system</li>
		<li>Irrigation (dams, channels, embankments, etc.)</li>
		<li>Storm Water Drainage System</li>
		  </ul>
		</div>
    </div>
  </div>
					</td>
				</tr>
				<tr>
					<th>Communication</th>
					<td>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingCommunication">
							  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseCommunication" aria-expanded="false" aria-controls="flush-collapseCommunication">
							   Explore Sub Sector
							  </button>
							</h2>
							<div id="flush-collapseCommunication" class="accordion-collapse collapse" aria-labelledby="flush-headingCommunication" data-bs-parent="#accordionsubsectorlist">
							  <div class="accordion-body">
								<ul>
									<li>Telecommunication (fixed network) <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title=" Includes optic fibre/wire/cable networks which provide broadband / Internet."></i> </li>
									<li>Telecommunication towers</li>
									<li>Telecommunication &amp; Telecom Services</li>
									<li>Data Centres <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Data Centre housed in a dedicated/centralized building for storage and processing of digital data applications with a minimum capacity of 5 MW of IT load."></i> </li>
								  </ul>

								</div>
							</div>
						  </div>
					</td>
				</tr>
				<tr>
					<th>Social and Commercial Infrastructure</th>
					<td>
						  <div class="accordion-item">
    <h2 class="accordion-header" id="flush-headingSocial">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseSocial" aria-expanded="false" aria-controls="flush-collapseSocial">
       Explore Sub Sector
      </button>
    </h2>
    <div id="flush-collapseSocial" class="accordion-collapse collapse" aria-labelledby="flush-headingSocial" data-bs-parent="#accordionsubsectorlist">
      <div class="accordion-body">
			<ul>
		  	<li>Education Institutions (capital stock)</li>
<li>Sports Infrastructure <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes the provision of Sports Stadia and Infrastructure for Academies for Training/Research in Sports and Sports-related activities."></i> </li>
<li>Hospitals (capital stock) <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes Medical Colleges, Para Medical Training Institutes and Diagnostics Centres."></i> </li>
<li>Tourism infrastructure viz. (i) three-star or higher category classified hotels located outside cities with population of more than 1 million, (ii) ropeways and cable cars</li>
<li>Common infrastructure for Industrial Parks and other parks with industrial activity such as food parks, textile parks, Special Economic Zones, tourism facilities and
agriculture markets</li>
<li>Post-harvest storage infrastructure for agriculture and horticultural produce including cold storage</li>
<li>Terminal markets</li>
<li>Soil-testing laboratories</li>
<li>Cold Chain11</li>
<li>Affordable Housing <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Includes cold room facility for farm level pre-cooling, for preservation or storage of agriculture and allied produce, marine products and meat."></i> </li>
<li>Affordable Rental Housing Complex <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="“Affordable Housing” is defined as a housing project using at least 50% of the Floor Area Ratio (FAR)/Floor Space Index (FSI) for dwelling units with carpet area@ of not more than 60 square meters."></i> </li>
<li>Exhibition-cum-Convention Centre <i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="Affordable Rental Housing Complex” means a project to be used for rental purpose only for urban migrant/poor (EWS/LIG categories) for a minimum period of 25 years with basic civic infrastructure
facilities such as water, sanitation, sewerage/ septage, road, electricity along with necessary social/commercial infrastructure and the initial rent fixed by Local Authority/ Entities based on local survey of surrounding area wherein the project is situated."></i> </li>
		  </ul>
		</div>
    </div>
  </div>
					</td>
				</tr>	
					
				</div>	
			</table>

		</div>		
	</section>


	  
	  </main>
	  
 <% }else{ %>
 
 <div class="createuser-page">
<div class="">
 <div class="<% if(!role.equalsIgnoreCase("Departmentuser")){ %>  jhansiall-pagestwo <% } %>">

<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="HML"/></span></h1>
           </div>
         
		<div class="container">
		<% 
		int size= HmlMainDescriptionLocalServiceUtil.getHmlMainDescriptionsCount();

		if(role.equalsIgnoreCase("Departmentuser") && size==0){ %>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=addDescriptionURL %>" cssClass="btn btn-black btn-sm-block" > 
                           	   
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add Description</button></a>
                           </div>
                      </div>
                      
                      <% } %>
                      
                     
			<div class="table-responsive">
		<% 
		    List<HmlMainDescription> resultList=null;
						List<HmlMainDescription> DownloadFormsList =HmlMainDescriptionLocalServiceUtil.getHmlMainDescriptions(0, size) ;
		 %>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList = ListUtil.subList(DownloadFormsList, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.HmlMainDescription" keyProperty="hmlId" modelVar="abt">
		      		
				      	<% 
				      	long hmlId =0L;
				      	String hmlmainDescription =  "";
				   	 	String hi_hmlmainDescription = "";
				      	String publishDate="";
				      	String fileUrl="";
				      	try{
				      		hmlId =abt.getHmlId(); 
				      		hmlmainDescription=abt.getHmlmainDescription(); 
 
				      		 if(languageId.equals("hi_IN")){ 
				      			hmlmainDescription=abt.getHi_hmlmainDescription(); 
				      		 } 
				      		hi_hmlmainDescription=abt.getHi_hmlmainDescription(); 
					      	  
 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

		<liferay-ui:search-container-column-text name="Main description" value="<%= hmlmainDescription %>" />  
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Main description in Hindi" value="<%= hi_hmlmainDescription %>" />  
		
		<% } %>
		 
		
		
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=hmlId%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
		</div>
		</liferay-ui:search-container-column-text>
		<% } %>
		
 	</liferay-ui:search-container-row>
	<liferay-ui:search-iterator  />
					</liferay-ui:search-container>
		    </div>
	    </div>
	</div>

<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="HML TimeLine"/></span></h1>
           </div>
         
		<div class="container">
		<% 
		if(role.equalsIgnoreCase("Departmentuser")){ %>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=createFormsURL %>" cssClass="btn btn-black btn-sm-block" >    
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add Timeline</button></a>
                           </div>
                      </div>
                      <% } %>
                      
			<div class="table-responsive">
		<% 
		    List<HmlTimeline> resultList1=null;
			int size1=HmlTimelineLocalServiceUtil.getHmlTimelinesCount();
			List<HmlTimeline> DownloadFormsList1 =HmlTimelineLocalServiceUtil.getHmlTimelines(0, size1) ;
		 %>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size1 %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList1 = ListUtil.subList(DownloadFormsList1, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList1 %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.HmlTimeline" keyProperty="hmlTimelineId" modelVar="hmlt">
		      		
				      	<% 
				      	long hmlTimelineId =0L;
				      	String publishDate="";
				      	long fileEntryId=0L;
				      	String fileUrl="";
				        String year="";
				      	String month ="";
				        String hmlDescription="";
				        String hi_hmlDescription ="";
				      	try{
				      		hmlTimelineId =hmlt.getHmlTimelineId();
				      		year =hmlt.getYear(); 
				      		month=hmlt.getMonth();
				      		hmlDescription = hmlt.getHmlDescription();
 
				      		 if(languageId.equals("hi_IN")){
				      			hmlDescription =hmlt.getHi_hmlDescription(); 
				      		 }
				      		hi_hmlDescription =hmlt.getHi_hmlDescription(); 
				      		
					      	  fileEntryId=hmlt.getFileEntryId();
					      	  if(fileEntryId!=0L){
									try{
										fileUrl = HarmonizedMasterListPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
									}
									catch(Exception e){
										
									}
					      	  }
					      
 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

	  <liferay-ui:search-container-column-text name="S.No." value="<%= String.valueOf(sNo++) %>" />
		<liferay-ui:search-container-column-text name="Year" value="<%= year %>" />
		<liferay-ui:search-container-column-text name="Month" value="<%= month %>" />   
		<liferay-ui:search-container-column-text name="hmlDescription" value="<%= hmlDescription %>" /> 
		 
		
		
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateTimeline('<%=hmlTimelineId%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deleteRecord('<%=hmlTimelineId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
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
 
	<portlet:renderURL var="updateRecordURL">
			<portlet:param name="mvcPath" value="/addDescription.jsp"/>  
		</portlet:renderURL>
		
	<portlet:renderURL var="updateTimelineURL">
			<portlet:param name="mvcPath" value="/createForm.jsp"/>  
		</portlet:renderURL>
		
		<portlet:actionURL var="deleteRecordURL" name="deleteHmlTimeline">
         </portlet:actionURL>
		
<script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>	   
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="bootstrap/js/bootstrap.bundle.min.js"></script>
 
<script src="js/app.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js" > </script>	  
 <script type="text/javascript">
     AOS.init();
	 var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
  return new bootstrap.Tooltip(tooltipTriggerEl)
})
</script>

<script>
function updateRecord(hmlId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />hmlId]').val(hmlId);
	$("#<portlet:namespace />update").submit();
}

function updateTimeline(hmlTimelineId){
	$('#<portlet:namespace />update1').find('input[name=<portlet:namespace />hmlTimelineId]').val(hmlTimelineId);
	$("#<portlet:namespace />update1").submit();
}

function deleteRecord(hmlTimelineId){
	if(confirm('Are you sure you want to delete?')){
		$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />hmlTimelineId]').val(hmlTimelineId);
		$('#<portlet:namespace />delete').submit();
	}
	else{
		return false;
	}
}

  </script>	
	  	  
<aui:form name="update" method="post" action="<%=updateRecordURL %>" style="display:none;">
   <aui:input type="text" name="hmlId" value=""></aui:input>
</aui:form>

<aui:form name="update1" method="post" action="<%=updateTimelineURL %>" style="display:none;">
   <aui:input type="text" name="hmlTimelineId" value=""></aui:input>
</aui:form>	  	  

<aui:form name="delete" method="post" action="<%=deleteRecordURL %>" style="display:none;">
   <aui:input type="text" name="hmlTimelineId" value=""></aui:input>
</aui:form>	  	  
  </body>
</html>
