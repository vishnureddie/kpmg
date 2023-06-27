<%@page import="java.util.Date"%>
<%@page import="com.kpmg.ReportsandInsights.portlet.ReportsandInsightsPortlet"%>
<%@page import="com.kpmg.citizenTables.service.ReportsandInsightsLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.ReportsandInsights"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>   
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.List"%>


<%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.citizenTables.service.InfrafinancinghubLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Infrafinancinghub"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="java.text.SimpleDateFormat"%>

<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.theme.ThemeDisplay"%>


<%@page import="com.kpmg.citizenTables.service.InfrafinancingLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Infrafinancing"%>


<%@page import="com.kpmg.citizenTables.model.GalleryDocuments"%>
<%@page import="com.kpmg.citizenTables.service.GalleryDocumentsLocalServiceUtil"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.kpmg.citizenTables.service.EventsLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Events"%>

<%@ include file="/init.jsp" %>

<liferay-ui:success key="entryAdded" message="ReportsandInsights added successfully." />
<liferay-ui:success key="entryUpdated" message="ReportsandInsights updated successfully."  />
<liferay-ui:success key="entryDeleted" message="ReportsandInsights deleted successfully." />
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

<portlet:renderURL var="viewall">
	<portlet:param name="mvcPath" value="/viewall.jsp"/>
</portlet:renderURL> 

<% if(!role.equalsIgnoreCase("Departmentuser")){ %>

<section class="top_innerBanner" style="margin-top: -60px !important;">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1>Infra Finance</h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Home</a></li>
				<li class="breadcrumb-item active">Infra Finance</li>
			  </ol>
			</nav>
		</div>	
</section>

<section class="report_insight" >
<div class="main_heading"><h1>Reports and Insights</h1></div>
		
		
	<div class="col-lg-12"> 
		  <div class="container d-flex align-items-center flex-wrap">
			<div class="me-auto">&nbsp;</div>
			<a href ="<%=viewall%>" class="btnview_sm">View All</a>
			
		</div>
		  
  	<div class="container">
  	<div class="resources_scroller">
    <div class="owl-carousel owl-theme scroller">
 
         	
         	<% 
 
List<ReportsandInsights> reports=null;
  try{
	 // int size=ImportantLinksLocalServiceUtil.getImportantLinksCount();
	  //importantLinks=ImportantLinksLocalServiceUtil.findBylanguageId(languageId, 0, ImportantLinksLocalServiceUtil.countBylanguageId(languageId));
		 reports =ReportsandInsightsLocalServiceUtil.getReportsandInsightses(0, ReportsandInsightsLocalServiceUtil.getReportsandInsightsesCount());

  }
  catch(Exception e){
	  e.getMessage();
  }
       int x=1;
  for(ReportsandInsights report:reports){
	  String fileUrl="";
	  String fileUrl1=""; 
	  String title=report.getTitle();
	  String redirectLink =report.getRedirectLink(); 
	  if(languageId.equals("hi_IN")){
    		redirectLink =report.getHi_redirectLink(); 
    		title=report.getHi_title(); 
		 }
	  long fileEntryId=report.getFileEntryId();
	  if(fileEntryId!=0L){
			try{
				fileUrl =ReportsandInsightsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
			}
			catch(Exception e){
				
			}
	  }
	  
	  long fileEntryId1=report.getFileEntryId1();
	  if(fileEntryId1!=0L){
			try{
				fileUrl1 =ReportsandInsightsPortlet.getFile(fileEntryId1, themeDisplay.getScopeGroupId());	  
			}
			catch(Exception e){
				
			}
	  }
	  
       %> 
       
		<div class="item">
		<div class="card">
			<img src="<%=fileUrl %>" class="card-img-top" alt="...">
				<div class="card-body">
					<p class="card-title text-truncate"><%=title %></p>
					<p class="card-link"><a href="<%=fileUrl1 %>?download=true">Download</a></p>
				</div>
		</div>
		</div><!--item-->
 
<% x++; } %>
       	
	</div><!--Owl Carousel-->
	</div>
	</div><!--Container-->
	</div><!--Policies and Guidelines-->	
 </section><!--end of Important Links Section-->
 
 
 	<section>
	 	<div class="container d-flex align-items-start flex-wrap">
			<div class="">		
		    </div>
		</div>	
		<div class="container">
			<div class="main_heading"><h1>Circulars &amp; Orders</h1></div>
		    	<div class="accordion accordion-flush filterbar" id="accordionFlushExample">
                    <div class="accordion-item">
                      <h2 class="accordion-header" id="flush-headingOne">
                        <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#flush-collapseOne" aria-expanded="false" aria-controls="flush-collapseOne">
                          Filter
                        </button>
                      </h2>
                      <div id="flush-collapseOne" class="accordion-collapse collapse" aria-labelledby="flush-headingOne" data-bs-parent="#accordionFlushExample">
                        <div class="accordion-body">
                            <div class="row">
                                <div class="col-lg-3"> 
									<label class="form-label">Issued by</label>
									<br/>
										<input type="search" value="" id="searchitem" placeholder="Searchitem">
                            
                                
                                </div>
                                 <div class="col-lg-3"> 
									<label class="form-label">Start Date</label> 
                                	<input type="text" placeholder="Select start Date" id="min" onchange="dateChangeFilter()" name="min" class="form-control target">
                                	</div>
                                 <div class="col-lg-3"> 
                                 <label class="form-label">End Date</label> 
                                	<input type="text" placeholder="Select End Date" id="max" name="max" onchange="dateChangeFilter()" class="form-control target"> 
								</div> 
								 
                            </div>
                        </div>
                      </div>
                    </div>
                  </div>
			
			<div class="table-responsive fixTableHead">
				<table id="example123" class="table table-bordered table-striped" style="width:100%">
				  <thead>
				<tr>
				  <th>Name</th>
				  <th>Issued by</th>
				  <th class="text-center">Date</th>
				  <th class="text-center" width="50px">View/Download</th>
				</tr>
			  </thead>	
				  <tbody id="example1234">
         	
         	<% 
 
List<Infrafinancinghub> ifh=null;
  try{
	   ifh=InfrafinancinghubLocalServiceUtil.getInfrafinancinghubs(0, InfrafinancinghubLocalServiceUtil.getInfrafinancinghubsCount());

  }
  catch(Exception e){
	  e.getMessage();
  }
       int y=1;
   	
   	 
  for(Infrafinancinghub infh:ifh){
	  String fileUrl="";
	  String viewUrl=infh.getViewurl();
	  String name=infh.getName();
	  String issuedby=infh.getIssuedby();
	  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	  long fileEntryId=infh.getFileEntryId();
	  String date="";
	  if(fileEntryId!=0L){
			try{
				fileUrl =ReportsandInsightsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());
				
			}
			catch(Exception e){
				
			}
	  }
	  try{	
				Date dt = infh.getDate();
				date = sdf.format(dt);
			}catch(Exception e){
				//e.printStackTrace();
			}
       %> 
        <tr>
					  <td><%=name %></td>
					  <td><%=issuedby %> </td>
					  <td class="text-center"><%=date %></td>
					  <td class="text-center">
					  <% if(fileUrl!=null && fileUrl!=""){ %>
					  <a href="<%=fileUrl %>?download=true" class="download_pdf_link">
					   <i class="fa-solid fa-arrow-down-to-line"></i></a>
					  <% } %>
					  
					  <% if(viewUrl!=null && viewUrl!=""){ %>
					    <a target="_blank" href="<%=viewUrl %>"> <i class="fa-solid fa-eye"></i></a>
					  <% } %>
					  </td>
					</tr>
			
  
<% y++; } %>

  </tbody>
				</table>
			  </div>
		</div>
		</section>
 

<section id="NIP_section">
  <div class="container py-5">
      <div class="row">
 
         	
         	<% 
 
List<Infrafinancing> importantLinks=null;
  try{
	 // int size=ImportantLinksLocalServiceUtil.getImportantLinksCount();
	  //importantLinks=ImportantLinksLocalServiceUtil.findBylanguageId(languageId, 0, ImportantLinksLocalServiceUtil.countBylanguageId(languageId));
		 importantLinks =InfrafinancingLocalServiceUtil.getInfrafinancings(0, InfrafinancingLocalServiceUtil.getInfrafinancingsCount());

  }
  catch(Exception e){
	  e.getMessage();
  }
       int z=1;
  for(Infrafinancing importantLink:importantLinks){
	  String fileUrl=""; 
	  String title=importantLink.getTitle();
	  String redirectLink =importantLink.getRedirectLink(); 
	  String description= importantLink.getDescription();
	  if(languageId.equals("hi_IN")){
    		redirectLink =importantLink.getHi_redirectLink(); 
    		description=importantLink.getHi_description();
    		title=importantLink.getHi_title(); 
		 }
	  long fileEntryId=importantLink.getFileEntryId();
	  if(fileEntryId!=0L){
			try{
				fileUrl =ReportsandInsightsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
			}
			catch(Exception e){
				
			}
	  }
	  
       %> 
       
			 <div class="col-lg-6 <%if(x==1){ %>margin_bottom_sm <%}%>">
      <div class="row">
        <h4 class="sub_heading text_white"><%=title %></h4>
        <div class="col-lg-6 col-md-6 text-center"><img src="<%=fileUrl %>" class="img-fluid leftimage rounded" alt="About National Infrastructure Pipeline (NIP)"></div>
        <div class="col-lg-6  col-md-6"> <p class="text_justify"><%=description %>  </p>
        <a href="<%=redirectLink %>" class="white_btn  mt-4" target="_blank">KNOW MORE</a></div>
      </div>  
    </div>
			
  
<% z++; } %>

          	
 </div>
	  </div>
</section>


 <section id="mediagallery_section" class="py-5 my-0">
	    <div class="container">
	        <div class="main_heading">
	            <h1>Media Gallery &amp; Videos</h1>
	        </div>
	        <div class="row mediagallery_slider mediagallery_card">
	            <% 
	         //   ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
	            Date todayDate = new Date();
	            todayDate.setHours(0);
	            todayDate.setMinutes(0);
	            todayDate.setSeconds(0);
	            List<Events> eventLinks = null;
	            DynamicQuery dq1 = EventsLocalServiceUtil.dynamicQuery(); 
	           // dq1.add(PropertyFactoryUtil.forName("startDate").le(todayDate));
	            dq1.add(RestrictionsFactoryUtil.eq("eventtype","Gallery"));
	           // dq1.add(RestrictionsFactoryUtil.eq("eventtype", "Training"));
	            eventLinks = EventsLocalServiceUtil.dynamicQuery(dq1);

	            try {
	                eventLinks= EventsLocalServiceUtil.dynamicQuery(dq1, 0,
	                		EventsLocalServiceUtil.getEventsesCount());
	            } catch (Exception e) {
	                e.printStackTrace();
	            }

	            int t = 1;
	            for (Events eventLink : eventLinks) {
	                if (t > 4) {
	                    break;
	                } 
	                String color="";
	          	  if(t%4==0)
	          		  color="green";
	          	  else if(t%4==1)
	          		  color="red";
	          	  else if(t%4==2)
	          		  color="yellow";
	          	  else if(t%4==3)
	          		  color="blue";
	                String eventtype=eventLink.getEventtype();
	                System.out.println(eventtype);
	                long eventid = eventLink.getEventId();
	                List<GalleryDocuments> galleryDocumentsList = GalleryDocumentsLocalServiceUtil.findByeventId(eventid);
	                if (galleryDocumentsList.size()>0) {
	                    %>
	                    <div class="col-md-4 col-lg-3 col-sm-12 p-2">	
	                        <div class="card h-100 <%=color%>">
	                            <div class="owl-carousel owl-theme mediagallery_scroller" uk-lightbox>
	                                <% 
	                                String title = eventLink.getTitle();
	                                String description = eventLink.getDescription();
	                                String location = eventLink.getLocation();
	                                String startTime = eventLink.getStartTime();
	                                String endTime = eventLink.getEndTime();
	                                String startDate = "";
	                                String endDate = "";
	                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	                                String heventtype=eventLink.getEventtype();
	                                try {	
	                                    Date dt = eventLink.getStartDate();
	                                    startDate = sdf.format(dt);
	                                } catch (Exception e) {
	                                    e.printStackTrace();
	                                }

	                                try {	
	                                    Date dt = eventLink.getEndDate();
	                                    endDate = sdf.format(dt);
	                                } catch (Exception e) {
	                                    e.printStackTrace();
	                                }

	                                for (GalleryDocuments galleryDoc : galleryDocumentsList) {  
	                                    String fileUrl = ""; 
	                                    long fileEntryId = galleryDoc.getFileEntryId();
	                                    if (fileEntryId != 0L) {
	                                        try {
	                                            fileUrl =ReportsandInsightsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
	                                        } catch (Exception e) {
	                                            e.printStackTrace();
	                                        }
	                                    }
	                                    %> 
	                                    <div class="item">	
	                                        <a class="uk-inline" href="<%=fileUrl %>">
	                                            <img class="img-fluid img-thumbnail" src="<%=fileUrl %>" alt="">
	                                        </a>
	                                    </div>					    
	                                <% } %>   		
	                            </div>		
	                            <div class="card-body">
	                                <h5 class="card-title"><%=title %></h5>
	                                <ul class="event_detailslist">
	                                    <li class="time"><%=startDate %> - <%=endDate %></li>
	                                    <li class="location"><%=location %></li>
	                                </ul>
	                            </div>
	                             <p class="card-link"><a href="/eventlist?eventId=<%=eventid%>&eventtype=<%=heventtype%>">Read More</a></p>
	                        </div>	
	                    </div>
	                    <% t++; %>
	                <% }
	            } %>
	            <div class="col-lg-12 text-center"> <a href="/eventlist?eventtype1=<%="InfraFinancing"%>" class="black_btn text-center" target="_blank">VIEW ALL</a></div>
	        </div>
	    </div>
	</section>

<script type="text/javascript">
		
        var table=$('#example123').DataTable({
            "lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]],
            fixedColumns: true,        
            initComplete: function () {            	 
           	 var j=1;
               this.api()
                   .columns([1])
                   .every(function () {
                       var column = this;
                       //alert("test");
                       $('#searchitem').keyup(function(){ 
                            //if (column.search() !== this.value) {  
                            	var val = $('#searchitem').val();
                                column.search(val,true,false,true).draw();
                            	
                            //}
                        });
                           	
                   });
 
           },
           processing: true,
        });
        
        var minDate, maxDate;
        
     // Custom filtering function which will search data in column four between two values
     $.fn.dataTable.ext.search.push(
         function( settings, data, dataIndex ) {
              var min = minDate.val();
              var max = maxDate.val();
              console.log("min Date ="+min);
              console.log("max Date ="+max);
             
              var d1=getFormattedDate(data[2]);
              var date = new Date( d1 );
             // console.log("Date ="+date);
               
             if (
                 ( min === null && max === null ) ||
                 ( min === null && date <= max ) ||
                 ( min <= date   && max === null ) ||
                 ( min <= date   && date <= max )
             ) {
            	// console.log("enter to loop>>>>"+date);
                 return true;
             }
             return false;
         }
     );
      
     
     $(document).ready(function() {
         // Create date inputs
         minDate = new DateTime($('#min'), {
             format: 'DD/MM/YYYY'
         });
         maxDate = new DateTime($('#max'), {
             format: 'DD/MM/YYYY'
         });
       
         $('#min').on('change', function () {
            console.log("min onchange");
        	 table.draw();
         });
         $('#max').on('change', function () {
        	 console.log("min onchange");
        	 table.draw();
         });
     });
     function dateChangeFilter(){
    	 
    	 console.log("Date Updates");
          table.draw();
     }
     function getFormattedDate(date) {
    	 var nameArr = date.split('/');
     	  
    	    return nameArr[1] + '/' + nameArr[0] + '/' + nameArr[2] +' 05:30:00';
    	}
               /* $('select').on('change', function() {
         	alert(this.value);
             table.search( this.value ).draw();
         }); */
    // }); 

function dataConvert(date1){
	const yyyy = date1.getFullYear();
	let mm = date1.getMonth() + 1; // Months start at 0!
	let dd = date1.getDate();
	if (dd < 10) dd = '0' + dd;
	if (mm < 10) mm = '0' + mm;
	return formattedToday = dd + '/' + mm + '/' + yyyy;
}
$("#example123_length").hide();
$("#example123_filter").hide();
         </script>

 <% }else{ %>

<div class="createuser-page">
<div class="">
 <div class="<% if(!role.equalsIgnoreCase("Departmentuser")){ %>  jhansiall-pagestwo <% } %>">

<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="Reports and Insights"/></span></h1>
           </div>
         
		<div class="container">
		<% 
		if(role.equalsIgnoreCase("Departmentuser")){ %>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=createFormsURL %>" cssClass="btn btn-black btn-sm-block" >    
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add Reports and Insights</button></a>
                           </div>
                      </div>
                      <% } %>
                      
			<div class="table-responsive">
		<% 
		    List<ReportsandInsights> resultList=null;
			int size=ReportsandInsightsLocalServiceUtil.getReportsandInsightsesCount();
			List<ReportsandInsights> DownloadFormsList =ReportsandInsightsLocalServiceUtil.getReportsandInsightses(0, size) ;
		 %>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList = ListUtil.subList(DownloadFormsList, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.ReportsandInsights" keyProperty="reportId" modelVar="report">
		      		
				      	<% 
				      	long reportId =0L;
				      	String redirectLink ="";
				      	String publishDate="";
				      	long fileEntryId=0L;
				      	long fileEntryId1=0L;
				      	String fileUrl="";
				      	String fileUrl1="";
				        String title="";
				        String hi_title="";
				        String hi_redirectLink ="";
				      	try{
				      		reportId =report.getReportId();
				      		redirectLink =report.getRedirectLink(); 
				      		title=report.getTitle(); 
 
				      		 if(languageId.equals("hi_IN")){
					      		redirectLink =report.getRedirectLink(); 
					      		title=report.getTitle(); 
				      		 }
				      		hi_redirectLink =report.getHi_redirectLink(); 
				      		hi_title=report.getHi_title(); 
					      	  fileEntryId=report.getFileEntryId();
					      	  if(fileEntryId!=0L){
									try{
										fileUrl = ReportsandInsightsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
									}
									catch(Exception e){
										
									}
					      	  }
					      	  
					      	fileEntryId1=report.getFileEntryId1();
					      	  if(fileEntryId1!=0L){
									try{
										fileUrl1 = ReportsandInsightsPortlet.getFile(fileEntryId1, themeDisplay.getScopeGroupId());	  
									}
									catch(Exception e){
										
									}
					      	  }
 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

	  <liferay-ui:search-container-column-text name="S.No." value="<%= String.valueOf(sNo++) %>" />
		<liferay-ui:search-container-column-text name="Title" value="<%= title %>" />  
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Title in Hindi" value="<%= hi_title %>" />  
		
		<% } %>
		 
		<liferay-ui:search-container-column-text name="Reportsandinsights Image">
		<a href="#" data-toggle="modal" data-target="#myModalimge-<%=reportId%>"> 
		<div class=" ">
			<% if(fileUrl!=""){ %><img width="150px;" height="100px;" src="<%=fileUrl %>" class="btn btn-primary m-0" /><% } %>
		</div>
		</a>
		<div class="modal" id="myModalimge-<%=reportId%>">
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
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=reportId%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deleteRecord('<%=reportId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
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
		<portlet:renderURL var="updateRecordURL">
			<portlet:param name="mvcPath" value="/createForm.jsp"/>  
		</portlet:renderURL>
		
		 <portlet:actionURL var="deleteRecordURL" name="deleteImportantLink">
         </portlet:actionURL>
         
         <script>
function updateRecord(recordId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />reportId]').val(recordId);
	$("#<portlet:namespace />update").submit();
}
function deleteRecord(recordId){
	if(confirm('Are you sure you want to delete?')){
		$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />reportId]').val(recordId);
		$('#<portlet:namespace />delete').submit();
	}
	else{
		return false;
	}
}
</script>
<aui:form name="update" method="post" action="<%=updateRecordURL %>" style="display:none;">
   <aui:input type="text" name="reportId" value=""></aui:input>
</aui:form>
<aui:form name="delete" method="post" action="<%=deleteRecordURL %>" style="display:none;">
   <aui:input type="text" name="reportId" value=""></aui:input>
</aui:form>

<% } %>