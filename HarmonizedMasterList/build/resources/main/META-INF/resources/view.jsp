<%@page import="java.time.Year"%>
<%@page import="com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"%>
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
 <%@page import="com.kpmg.citizenTables.service.HmlCategoryListServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HmlCategoryList"%>
<%@page import="com.kpmg.citizenTables.service.HmlCategoryListLocalServiceUtil"%>
 <%@page import="java.text.SimpleDateFormat"%>
 <%@page import="javax.portlet.PortletURL"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.HarmonizedMasterList.constants.HarmonizedMasterListPortletKeys"%> 
<%@page import="com.kpmg.HarmonizedMasterList.portlet.HarmonizedMasterListPortlet"%>

<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeLocalServiceUtil"%>

<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeSubCategoryLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeCategoryLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledge"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledgeCategory"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledgeSubCategory"%>


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

<portlet:renderURL var="addCategoryURL">
	<portlet:param name="mvcPath" value="/addCategoryList.jsp"/>
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
<section class="top_innerBanner" style=" margin-top: -60px !important;">
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
	 
	for(int i=Year.now().getValue();i>=2012;i--)
{
	System.out.println("i: "+i);
					List<HmlTimeline> reports=null;
  DynamicQuery dyq = null;
  try {
  	dyq = HmlTimelineLocalServiceUtil.dynamicQuery();
     // dyq.addOrder(OrderFactoryUtil.desc("year"));
      dyq.add(RestrictionsFactoryUtil.eq("year", Integer.toString(i)));
      reports = HmlTimelineLocalServiceUtil.dynamicQuery(dyq, 0,
    		  HmlTimelineLocalServiceUtil.getHmlTimelinesCount());
  } catch (Exception e) {
      e.getMessage();
  }
  System.out.println("Reports Size:"+reports.size());
  if(reports.size()>0)
  {
  %>
                             <div class="timeline">
								<div href="#" class="timeline-content" data-aos="fade-down" data-aos-duration="2000">
									<div class="timeline-year"><%=i%></div>
  
  <% 
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
	  if(reports.size()==1){
		 			 if(month.length()>2){
		  				%>
		  						<h3 class="title"><%=month %></h3>
		  						<% } %> 
									<p class="description">
										<%=hmlDescription %>
									</p>
									<p><a href="<%=fileUrl %>" class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
		<%   
	  }else{
       %> 
       
				 		
									<div class="accordion accordion-flush" id="accordionFlushExample2017">
									  <div class="accordion-item">
										<h2 class="accordion-header" id="headingOne2017">
										  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%=month %><%=i %>" aria-expanded="false" aria-controls="collapseOne">
											 <h3 class="title"><%=month %></h3>
										  </button>
										</h2>
										<div id="collapse<%=month %><%=i %>" class="accordion-collapse collapse" aria-labelledby="headingOne<%=i %>" data-bs-parent="#accordionFlushExample<%=i%>">
										  <div class="accordion-body">
											 <p class="description"><%=hmlDescription %> </p>
											 <% if(fileUrl.length()>2){ %>
											  <p><a href="<%=fileUrl %>" class="view_pdf" target="_blank"><i class="fa-solid fa-file-pdf"></i> View PDF</a></p>
											 <% }%>
											</div>
										</div>
									  </div>
									</div> <!--ACCORDION-->
									<%} }%>
								</div>
							</div>
<% y++;  }}%>
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
				    <% 
 
					List<InfraKnowledgeCategory> hmlc=null;
  DynamicQuery dyq1 = null;
  try {
	  long i = 1;
  	dyq1 = InfraKnowledgeCategoryLocalServiceUtil.dynamicQuery();
  	dyq1.add(RestrictionsFactoryUtil.ne("catId", i));
      dyq1.addOrder(OrderFactoryUtil.asc("catId"));
      
      hmlc = InfraKnowledgeCategoryLocalServiceUtil.dynamicQuery(dyq1, 0,
    		  InfraKnowledgeCategoryLocalServiceUtil.getInfraKnowledgeCategoriesCount());
  } catch (Exception e) {
      e.getMessage();
  }

       int z=1;
       
  for(InfraKnowledgeCategory abt:hmlc){
	 long catId=abt.getCatId();
	 String catname=abt.getCategoryName();

	 String arr[] = catname.split(" ", 2);
	 String firstWord = arr[0]; 
       %>
				<tr>
					<th><%=catname %></th>
					<td>
						<div class="accordion-item">
							<h2 class="accordion-header" id="flush-headingTransport">
							  <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapse<%=firstWord %>" aria-expanded="false" aria-controls="flush-collapseTransport">
							   Explore Sub Sector
							  </button>
							</h2>
							<div id="flush-collapse<%=firstWord %>" class="accordion-collapse collapse" aria-labelledby="flush-headingTransport" data-bs-parent="#accordionsubsectorlist">
							  <div class="accordion-body">
								<ul>
								<%
								
								List<InfraKnowledgeSubCategory> hmlc1=null;
								  DynamicQuery dyq2 = null;
								  try {
								  	dyq2 = InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery();
								     // dyq2.addOrder(OrderFactoryUtil.asc("catId"));
								      dyq2.add(RestrictionsFactoryUtil.eq("catId", catId));
								      hmlc1 = InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery(dyq2, 0,
								    		  InfraKnowledgeSubCategoryLocalServiceUtil.getInfraKnowledgeSubCategoriesCount());
								  } catch (Exception e) {
								      e.getMessage();
								  }
								  for(InfraKnowledgeSubCategory su:hmlc1){
										 long subCatId=su.getCatId();
										 String subcatname=su.getSubCategoryName();
										
								%>
									
									<li><%=subcatname %>
									<%
									List<HmlCategoryList> reports=null;
									  DynamicQuery dy = null;
									  try {
									  	dy = HmlCategoryListLocalServiceUtil.dynamicQuery();
									     
									      dy.add(RestrictionsFactoryUtil.eq("subcatId", subCatId));
									      reports = HmlCategoryListLocalServiceUtil.dynamicQuery(dy, 0,
									    		  HmlCategoryListLocalServiceUtil.getHmlCategoryListsCount());
									  } catch (Exception e) {
									      e.getMessage();
									  }
									  for(HmlCategoryList hm:reports){
											String des=hm.getHmlCategoryInfo();
											System.out.print("description" + des);
											if(des.length()>0){
									%>
									
									<i class="fa-solid fa-circle-exclamation" data-bs-toggle="tooltip" data-bs-placement="top" title="<%=des%>"></i> 	
									<%} }%>
									</li>
									<%} %>
									</ul>
							  </div>
							</div>
						  </div>
					</td>
				</tr>
					
			<% z++; } %>
					
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

<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="HML Category List"/></span></h1>
           </div>
         
		<div class="container">
		<% 
		if(role.equalsIgnoreCase("Departmentuser")){ %>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=addCategoryURL %>" cssClass="btn btn-black btn-sm-block" >    
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add Category List</button></a>
                           </div>
                      </div>
                      <% } %>
                      
			<div class="table-responsive">
		<% 
		    List<HmlCategoryList> resultList2=null;
			int size2=HmlCategoryListLocalServiceUtil.getHmlCategoryListsCount();
			List<HmlCategoryList> DownloadFormsList2 =HmlCategoryListLocalServiceUtil.getHmlCategoryLists(0, size2) ;
			
		 %>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size2 %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList2 = ListUtil.subList(DownloadFormsList2, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList2 %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.HmlCategoryList" keyProperty="hmlCategoryListId" modelVar="hmlt">
		      		
				      	<% 
				      	long hmlCategoryListId =0L;
				      	long catId=0L;
				      	long subcatId=0L;
				      	String publishDate="";
				        String hmlCategoryInfo="";
				        String hi_hmlCategoryInfo ="";
				      	try{
				      		hmlCategoryListId =hmlt.getHmlCategoryListId();
				      		
				      		hmlCategoryInfo = hmlt.getHmlCategoryInfo();
				      		catId=hmlt.getCatId();
				      		subcatId=hmlt.getSubcatId();
 
				      		 if(languageId.equals("hi_IN")){
				      			hmlCategoryInfo =hmlt.getHi_hmlCategoryInfo(); 
				      		 }
				      		hi_hmlCategoryInfo =hmlt.getHi_hmlCategoryInfo(); 
				      		
					      
					      
 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

	  <liferay-ui:search-container-column-text name="S.No." value="<%= String.valueOf(sNo++) %>" />
		<liferay-ui:search-container-column-text name="catId" value="<%= String.valueOf(catId) %>" /> 
		<liferay-ui:search-container-column-text name="subcatId" value="<%= String.valueOf(subcatId) %>" /> 
		<liferay-ui:search-container-column-text name="hmlCategoryInfo" value="<%= hmlCategoryInfo %>" />   
		<liferay-ui:search-container-column-text name="hi_hmlCategoryInfo" value="<%= hi_hmlCategoryInfo %>" /> 
		 
		
		
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateCategory('<%=hmlCategoryListId%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deleteCategory('<%=hmlCategoryListId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
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
         
     <portlet:renderURL var="updateCategoryURL">
			<portlet:param name="mvcPath" value="/addCategoryList.jsp"/>  
		</portlet:renderURL>
		
		<portlet:actionURL var="deleteCategoryURL" name="deleteHmlCategoryList">
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

function updateCategory(hmlCategoryListId){
	$('#<portlet:namespace />update2').find('input[name=<portlet:namespace />hmlCategoryListId]').val(hmlCategoryListId);
	$("#<portlet:namespace />update2").submit();
}

function deleteCategory(hmlCategoryListId){
	if(confirm('Are you sure you want to delete?')){
		$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />hmlCategoryListId]').val(hmlCategoryListId);
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

<aui:form name="update2" method="post" action="<%=updateCategoryURL %>" style="display:none;">
   <aui:input type="text" name="hmlCategoryListId" value=""></aui:input>
</aui:form>	  	  

<aui:form name="delete" method="post" action="<%=deleteCategoryURL %>" style="display:none;">
   <aui:input type="text" name="hmlCategoryListId" value=""></aui:input>
</aui:form>	 	  
  </body>
</html>