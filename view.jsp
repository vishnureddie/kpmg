<%@page import="com.kpmg.citizenTables.service.HomePageNewsLocalService"%> 
<%@page import="com.kpmg.citizenTables.service.HomePageNewsLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HomePageNews"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>   
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.List"%>
<%@ include file="/init.jsp" %>
<liferay-ui:success key="entryAdded" message="Home Page News LINK added successfully." />
<liferay-ui:success key="entryUpdated" message="Home Page News updated successfully."  />
<liferay-ui:success key="entryDeleted" message="Home Page News deleted successfully." />
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


<%
if(!role.equalsIgnoreCase("DepartmentUser")){
 %>
 <section class="newsticker" id="news">
	<div class="container" >
	
		<div class="row align-items-center">
			<div class="col-lg-3 news_heading"><h3 class="sub_heading "><i class="fa-sharp fa-regular fa-newspaper"></i><liferay-ui:message key="NEWS"/></h3></div>
			<div class="col-lg-9">
				 <div class="news">
	<ul> 
	<%   List<HomePageNews> homegageNews=null;
	try{  
		homegageNews=HomePageNewsLocalServiceUtil.getHomePageNewses(0, HomePageNewsLocalServiceUtil.getHomePageNewsesCount());
	 int j=1;
	if(homegageNews.size()>0){
	  for(HomePageNews news:homegageNews){
		if(j>1){
			//out.print(" | ");
		}
		j++;
		String url=news.getRedirectLink();
		String title=news.getTitle();
		if(languageId.equals("hi_IN")){
		     url=news.getHi_redirectLink();
			 title=news.getHi_title();	
		}  %>									
	  	 <li><a href="<%=url%>" target="_blank"><%=title %></a></li>
		 <% }  } } 
	catch(Exception e){
		e.getMessage();
	} %>
     </ul>
</div>			
			</div>
		</div>
		
	</div>	  
</section>

<section id="services_section" class="counternumbers">
        <div class="container">
          <div class="row">
            <div class="col-lg-4 col-sm-6 col-xs-6 infra_financing">
              <div class="card">
                <div class="yellow_box">
                  <h2>
                    <liferay-ui:message key="Infra"/><br>
                    <liferay-ui:message key="Finance"/>
                  </h2>
                  <div class="counter_content_home">
						<div class="container">
							<div class="row">
							<div class="col">
							<div class="counter_value_home"><i class="fa-solid fa-indian-rupee-sign"></i> <span class="value">100</span> <span class="small_text">Lakh Crore</span></div>
							<div class="counter_title_home">Capital Expenditure <br />Allocation(FY 20-24) </div>
						</div>
							<div class="col">
							<div class="counter_value_home"><i class="fa-solid fa-indian-rupee-sign"></i> <span class="value">100</span> <span class="small_text">Lakh Crore</span></div>
							<div class="counter_title_home">NIP Investment <br />Planned(FY 20-25)</div>
						</div>
						</div>
						</div>
			
						</div><!--counter_content-->
                  <p class="card-link"><a href="/infra-financing"><liferay-ui:message key="Knowmore"/></a></p>
                </div>
              </div>
            </div>

            <div class="col-lg-4 col-sm-6 col-xs-6 capacity_building">
              <div class="card">
                <div class="red_box">
                  <h2>
                    <liferay-ui:message key="Capacity"/><br>
                    <liferay-ui:message key="Building"/>
                  </h2>
                  <div class="counter_content_home">
						
						<div class="container">
							<div class="row">
							<div class="col"><div class="counter_inner">
							<div class="counter_value_home"><span class="value">52</span></div>
							<div class="counter_title_home">Trainings <br />Conducted </div>
						</div></div>
							<div class="col">
						<div class="counter_inner">
							<div class="counter_value_home"><span class="value">100</span></div>
							<div class="counter_title_home">Officers <br />Trained</div>
						</div>	
						</div>
						</div>
						</div>
			
						</div><!--counter_content-->
                  <p class="card-link"><a href="/capacity-building"><liferay-ui:message key="Knowmore"/></a></p>
                </div>
              </div>
            </div>
            
            <div class="col-lg-4 col-sm-6 col-xs-6 infra_knowledge">
              <div class="card">
                <div class="green_box">
                  <h2>
                    <liferay-ui:message key="Knowledge"/><br>
                    <liferay-ui:message key="Resources"/>
                  </h2>
                  <div class="counter_content_home">
						
						<div class="container">
							<div class="row">
							<div class="col"><div class="counter_inner">
							<div class="counter_value_home"><span class="value">100</span></div>
							<div class="counter_title_home">Total Policies &amp; <br />Guidelines available </div>
						</div></div>
						</div>
						</div>
			
						</div><!--counter_content-->
                  <p class="card-link"><a href="/infra-knowledge"><liferay-ui:message key="Knowmore"/></a></p>
                </div>
              </div>
            </div>
            
          </div>
        </div>
      </section>	


 <%
	}else{
%>
 
<div class="createuser-page">
<div class="">
 <div class="<%if(!role.equalsIgnoreCase("Departmentuser")){%>  jhansiall-pagestwo <%}%>">

<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="homePageNews.Title"/></span></h1>
           </div>
         
		<div class="container">
		<%
			if(role.equalsIgnoreCase("Departmentuser")){
		%>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
	   					<a href ="<%=createFormsURL%>" cssClass="btn btn-black btn-sm-block" >    
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add News</button></a>
                            </div>
                      </div>
                      <%
                      	}
                      %>
                      
			<div class="table-responsive">
		<%
		try{
			List<HomePageNews> resultList=null;
			int size=HomePageNewsLocalServiceUtil.getHomePageNewsesCount();
			List<HomePageNews> DownloadFormsList =HomePageNewsLocalServiceUtil.getHomePageNewses(0, size) ;
		%>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size%>" emptyResultsMessage="No records found" iteratorURL="<%=iteratorNewURL%>" >			 
	<%
			 		try{
			 			resultList = ListUtil.subList(DownloadFormsList, searchContainer.getStart(),searchContainer.getEnd());
			 		}catch(Exception e){
			 			e.printStackTrace();
			 		}
			 	%>
	
	 <liferay-ui:search-container-results results="<%=resultList%>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.HomePageNews" keyProperty="homePageNewsId" modelVar="homePageNews">
		      		
				      	<%
		      						      		long homePageNewsId =0L;
		      						      			      	String redirectLink ="";
		      						      			       	
		      						      			        String title="";
		      						      			        String hi_title="";
		      						      			        String hi_redirectLink ="";
		      						      			      	try{
		      						      			      		  homePageNewsId =homePageNews.getHomePageNewsId();
		      						      			      		redirectLink =homePageNews.getRedirectLink(); 
		      						      			      		title=homePageNews.getTitle(); 
		      						      	 
		      						      			      		 if(languageId.equals("hi_IN")){
		      						      				      		redirectLink =homePageNews.getRedirectLink(); 
		      						      				      		title=homePageNews.getTitle(); 
		      						      			      		 }
		      						      			      		hi_redirectLink =homePageNews.getHi_redirectLink(); 
		      						      			      		hi_title=homePageNews.getHi_title(); 
		      						      				      	   
		      						      	 
		      						      		 }catch(Exception e){
		      						      			e.printStackTrace();
		      						      		}
		      						      	%>

	  <liferay-ui:search-container-column-text name="S.No." value="<%= String.valueOf(sNo++) %>" />
		<liferay-ui:search-container-column-text name="Title" value="<%= title %>" />  
		<liferay-ui:search-container-column-text name="Redirect Link" cssClass="reditlinkwdth" target="_blank" href="<%= redirectLink %>" value="<%= redirectLink %>" /> 
		 <liferay-ui:search-container-column-text name="Title in Hindi" value="<%= hi_title %>" />  
		   
		
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=homePageNewsId %>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deleteRecord('<%=homePageNewsId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
		</div>
		</liferay-ui:search-container-column-text>
		<% } %>
		
 	</liferay-ui:search-container-row>

	<liferay-ui:search-iterator  />
					</liferay-ui:search-container>
					<% }catch(Exception e){} %>
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
		
		 <portlet:actionURL var="deleteRecordURL" name="deleteHomePageNews">
         </portlet:actionURL>
         
         <script>
function updateRecord(recordId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />homePageNewsId]').val(recordId);
	$("#<portlet:namespace />update").submit();
}
function deleteRecord(recordId){
	if(confirm('Are you sure you want to delete?')){
		$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />homePageNewsId]').val(recordId);
		$('#<portlet:namespace />delete').submit();
	}
	else{
		return false;
	}
}
</script>
<aui:form name="update" method="post" action="<%=updateRecordURL %>" style="display:none;">
   <aui:input type="text" name="homePageNewsId" value=""></aui:input>
</aui:form>
<aui:form name="delete" method="post" action="<%=deleteRecordURL %>" style="display:none;">
   <aui:input type="text" name="homePageNewsId" value=""></aui:input>
</aui:form>

<% } %>