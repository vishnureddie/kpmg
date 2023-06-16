<%@page import="com.kpmg.ReportsandInsights.portlet.ReportsandInsightsPortlet"%>
<%@page import="com.kpmg.citizenTables.service.ReportsandInsightsLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.ReportsandInsights"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>   
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.List"%>
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


<% if(!role.equalsIgnoreCase("Departmentuser")){ %>

<section class="top_innerBanner ">
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
			<a href="#" class="btnview_sm">View All</a>
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