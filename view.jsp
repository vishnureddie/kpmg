<%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.InfraFinancingHub.portlet.InfraFinancingHubPortlet"%> 
<%@page import="com.kpmg.citizenTables.service.InfrafinancinghubLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Infrafinancinghub"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.theme.ThemeDisplay"%>
<%@ include file="/init.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/core" prefix = "c" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<liferay-theme:defineObjects />

<portlet:defineObjects />
<style>
.alert-notifications{
display:none;
} 
.alert-notifications-fixed{
display:none;
} 
</style>
<%
//System.out.println(".getURLCurrent()()>>>"+themeDisplay.getURLCurrent());

String pageUrl=themeDisplay.getURLCurrent();
JSONObject obj = InfraFinancingHubPortlet.getSectors();
//System.out.println("pageUrl>>>"+pageUrl);
if(!role.equalsIgnoreCase("Departmentuser")){
	%>
<!-- jQuery is supplied by theme, holding on removing for now however would like to clean up before finalizing project to avoid conflicts. -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.13.1/js/jquery.dataTables.min.js"></script>
 <script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/bootstrap-modal.js"></script>
 <link rel="stylesheet" type="text/css" href="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/DataTables-1.10.15/css/dataTables.jqueryui.min.css"/>
<link rel="stylesheet" type="text/css" href="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/DataTables-1.10.15/css/jquery.dataTables.min.css"/>
<link rel="stylesheet" type="text/css" href="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/Buttons-1.3.1/css/buttons.dataTables.min.css"/>
<!-- <link rel="stylesheet" type="text/css" href="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/DataTables-1.10.15/css/datatables.min.css"/>  -->
<link rel="stylesheet" type="text/css" href="<%=renderRequest.getContextPath()%>/css/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/datetime/1.4.1/css/dataTables.dateTime.min.css"/>

<script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/Buttons-1.3.1/js/dataTables.buttons.min.js"></script>
<script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/Buttons-1.3.1/js/buttons.flash.min.js"></script>
<script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/JSZip-3.1.3/jszip.min.js"></script>
<script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/Buttons-1.3.1/js/buttons.html5.min.js"></script>
<script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/Buttons-1.3.1/js/buttons.print.min.js"></script>
<script type="text/javascript" src="<%=renderRequest.getContextPath()%>/js/DataTables-Buttons/pdfmake-0.1.27/build/pdfmake.min.js"></script>
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.2/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/datetime/1.4.1/js/dataTables.dateTime.min.js"></script>

 	
<section class="top_innerBanner ">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1>Infra Financing Hub</h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="#">Home</a></li>
				<li class="breadcrumb-item active">Infra Financing Hub</li>
			  </ol>
			</nav>
		</div>	
</section>
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
                                    <select id="select-1" class="form-select">
                                    <option value="">Select Sector</option>
                                   	<%
	        	//JSONObject obj = InfraFinancingHubPortlet.getSectors();
	        	for (int i=1; i<=obj.length(); i++){   %>
	        	<option value="<%=obj.get(String.valueOf(i)) %>"><%=obj.get(String.valueOf(i)) %></option>
	        	<% } %>
                                </select></div>
                                 <div class="col-lg-3"> 
									<label class="form-label">Notification</label> 
                                	<input type="text" placeholder="Select Date" id="min" name="min" class="form-control"> 
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
				  <th>Sector</th>
				  <th class="text-center">Date</th>
				  <th class="text-center" width="50px">View/Download</th>
				</tr>
			  </thead>	
				  <tbody>
         	
         	<% 
 
List<Infrafinancinghub> ifh=null;
  try{
	 // int size=ImportantLinksLocalServiceUtil.getImportantLinksCount();
	  //importantLinks=ImportantLinksLocalServiceUtil.findBylanguageId(languageId, 0, ImportantLinksLocalServiceUtil.countBylanguageId(languageId));
		 ifh=InfrafinancinghubLocalServiceUtil.getInfrafinancinghubs(0, InfrafinancinghubLocalServiceUtil.getInfrafinancinghubsCount());

  }
  catch(Exception e){
	  e.getMessage();
  }
       int x=1;
   	
   	 
  for(Infrafinancinghub infh:ifh){
	  String fileUrl=""; 
	  String name=infh.getName();
	  long sector=infh.getSector();
	  SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	  long fileEntryId=infh.getFileEntryId();
	  String date="";
	  if(fileEntryId!=0L){
			try{
				fileUrl =InfraFinancingHubPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
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
					  <td><%=obj.get(String.valueOf(sector)) %> </td>
					  <td class="text-center"><%=date %></td>
					  <td class="text-center"><a href="<%=fileUrl %>?download=true" class="download_pdf_link"><img src="<%=request.getContextPath()%>/css/PDF_file_icon.png" alt="#"></a></td>
					</tr>
			
  
<% x++; } %>

  </tbody>
				</table>
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
                        	$('#select-'+column[0][0]).on('change', function () {
                        		console.log("onchange action for >>>"+"#select-"+column[0][0]);
                               var val = $('#select-'+column[0][0]).val();                             
                               column.search(val,true,false,true).draw();
                      });
                                     	
                   });
 
           },
           processing: true,
        });
        
        var minDate;
        
     // Custom filtering function which will search data in column four between two values
     $.fn.dataTable.ext.search.push(
         function( settings, data, dataIndex ) {
             var min = minDate.val(); 
            // alert(min);
            // const d = new Date(data[2]);
             var d1=getFormattedDate(data[2]);
             //alert(d1);
             var date = new Date( d1 );
      //   alert(dataConvert(date));
             if (
                     ( min === null)  ||   ( dataConvert(min) == dataConvert(date)  )
             ) {
                 return true;
             }
             return false;
         }
     );
     function getFormattedDate(date) {
    	 var nameArr = date.split('/');
     	  
    	    return nameArr[1] + '/' + nameArr[0] + '/' + nameArr[2];
    	}
     $(document).ready(function() {
         // Create date inputs
         minDate = new DateTime($('#min'), {
             format: 'DD/MM/YYYY'
         });

      
         // DataTables initialisation
         var table = $('#example123').DataTable();
      
         // Refilter the table
         $('#min').on('change', function () {
             table.draw();
         });
     });
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
 <% 
}
if(role.equalsIgnoreCase("Departmentuser"))
{
%>

<liferay-ui:success key="entryAdded" message="InfraFinancingHub added successfully." />
<liferay-ui:success key="entryUpdated" message="InfraFinancingHub updated successfully."  />
<liferay-ui:success key="entryDeleted" message="InfraFinancingHub deleted successfully." />



<div class="createuser-page">
<div class="">
 <div class="">
 <%
 	String languageId=themeDisplay.getLanguageId();
  String thSno="S.No.";
  String thname="Name";
  String thdate="Date";
  String thDownload="Download";
 
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
  long sNo=(delta * (cur-1))+1;
  
  String friendlyURL= themeDisplay.getPortalURL();//http://localhost:7070/
  //System.out.println("getPortalURL()>>>"+friendlyURL);
  //System.out.println("role>>>"+role);
  
  
  
  
  
  //System.out.println(".getURLCurrent()()>>>"+themeDisplay.getURLCurrent());
  //System.out.println("getURLHome()>>>"+themeDisplay.getURLHome());
  //System.out.t.println("getPortalURL()>>>"+themeDisplay);
   
  
 %>
<portlet:renderURL var="createinfrafinancinghub">
	<portlet:param name="mvcPath" value="/createForm.jsp"/>
</portlet:renderURL> 
<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span>Infra Financing Hub</span></h1>
           </div>
         
		<div class="container">
		 
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=createinfrafinancinghub%>" cssClass="btn btn-black btn-sm-block" >    
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right"> Create InfraFinancingHub</button></a>
                           </div>
                      </div>
                     
                      
			<div class="table-responsive">
		<%
			List<Infrafinancinghub> resultList=null;
		List<Infrafinancinghub> ifh =null;
			int size=0;
			try{
				size=InfrafinancinghubLocalServiceUtil.getInfrafinancinghubsCount();
				ifh =InfrafinancinghubLocalServiceUtil.getInfrafinancinghubs(0, size) ;
			}
			catch(Exception e){
				
			}
		%>
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size%>" emptyResultsMessage="No records found" iteratorURL="<%=iteratorNewURL%>" >			 
	<%
			 		try{
			 			resultList = ListUtil.subList(ifh, searchContainer.getStart(),searchContainer.getEnd());
			 		}catch(Exception e){
			 			////e.printStackTrace();
			 		}
			 	%>
	
	 <liferay-ui:search-container-results results="<%=resultList%>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.Infrafinancinghub" keyProperty="infrafinancingId" modelVar="infh">
		      		
				      	<%
		      						      		long ifhId =0L;
		      						      			      	String name="";
		      						      			      	String date="";
		      						      			      	long fileEntryId=0L;
		      						      			      	String fileUrl="";
		      						      			      	String sectorName="";
		      						      			      	long sector=0L;
		      						      			      	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
		      						      			      	try{
		      						      			      	
		      						      			      	ifhId =infh.getInfrafinancingId();
		      						      			      	name=infh.getName();
		      						      			        sector=infh.getSector();
		      						      			      		  fileEntryId=infh.getFileEntryId();
		      						      				      	  if(fileEntryId!=0L){
		      						      								try{
		      						      									fileUrl = InfraFinancingHubPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
		      						      								}
		      						      								catch(Exception e){
		      						      									
		      						      								}
		      						      				      	  }
		      						      	                           try{	
		      						      							Date dt = infh.getDate();
		      						      							date = sdf.format(dt);
		      						      							if(sector!=0){
		      						      						sectorName=obj.getString(String.valueOf(sector));
		      						      							}
		      						      						}catch(Exception e){
		      						      							//e.printStackTrace();
		      						      						}
		      						      	                           
		      						      		 }catch(Exception e){
		      						      			////e.printStackTrace();
		      						      		}
		      						      	%>
	  	<liferay-ui:search-container-column-text name="<%=thSno %>" value="<%= String.valueOf(sNo++) %>" />
		<liferay-ui:search-container-column-text name="<%=thname %>" value="<%= name %>" />
		<liferay-ui:search-container-column-text name="Sector" value="<%=sectorName %>" />
	  	<liferay-ui:search-container-column-text name="<%=thdate %>" value="<%=date %>"  /> 
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage">
		<div>
		     <% if(!fileUrl.isEmpty()){ %> <a href="<%=fileUrl %>?download=true" class="btn btn-primary m-0 hotooltip" target="_blank"><i class="fas fa-download"><span class="hotooltiptext"></span></i></a><% } %>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=ifhId %>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deleteRecord('<%=ifhId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
		</div>
		</liferay-ui:search-container-column-text>
		<% }else{ %>
		<liferay-ui:search-container-column-text name="<%=thDownload %>">

		    <% if(!fileUrl.isEmpty()){ %> <a href="<%=fileUrl %>?download=true" class="btn btn-primary m-0 hotooltip" target="_blank"><i class="fas fa-download"><span class="hotooltiptext"></span></i></a><% } %>
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
<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<portlet:renderURL var="updateRecordURL">
			<portlet:param name="mvcPath" value="/createForm.jsp"/>  
		</portlet:renderURL>
		
		 <portlet:actionURL var="deleteRecordURL" name="deleteNews"> 
         </portlet:actionURL>
<script>
function updateRecord(recordId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />recordId]').val(recordId);
	$("#<portlet:namespace />update").submit();
}
function deleteRecord(recordId){
	if(confirm('Are you sure you want to delete?')){
		$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />recordId]').val(recordId);
		$('#<portlet:namespace />delete').submit();
	}
	else{
		return false;
	}
}
</script>
<aui:form name="update" method="post" action="<%=updateRecordURL %>" style="display:none;">
   <aui:input type="text" name="recordId" value=""></aui:input>
</aui:form>
<aui:form name="delete" method="post" action="<%=deleteRecordURL %>" style="display:none;">
   <aui:input type="text" name="recordId" value=""></aui:input>
</aui:form>
<% } } %>