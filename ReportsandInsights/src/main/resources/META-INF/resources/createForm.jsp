 <%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.ReportsandInsightsLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.ReportsandInsights"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.ReportsandInsights.constants.ReportsandInsightsPortletKeys"%> 
<%@page import="com.kpmg.ReportsandInsights.portlet.ReportsandInsightsPortlet"%>
<%@ include file="/init.jsp"%>  
 <portlet:actionURL var="manageFormsURL" name="manageForms">
 </portlet:actionURL>
 <%
 	long reportId = ParamUtil.getLong(request, "reportId");
     System.out.println("reportId >>>"+reportId );
     ReportsandInsights reports=null; 
     String redirectLink="";
     String title="";
     String hi_redirectLink="";
     String hi_title="";
     long fileEntryId=0L;
     String languageId="en_US";
     String fileUrl="";
     SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
     if(reportId!=0){
     	try{
     		reports=ReportsandInsightsLocalServiceUtil.fetchReportsandInsights(reportId);
     		 if(reports!=null){
     			 title = reports.getTitle();
     			 fileEntryId=reports.getFileEntryId();
     			 redirectLink=reports.getRedirectLink();
     			 hi_title = reports.getHi_title();
     			 hi_redirectLink=reports.getHi_redirectLink();
     			 if(fileEntryId!=0L){
     				 try{
 					fileUrl =ReportsandInsightsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
 				}
 				catch(Exception e){
 					
 				}
 		      	  }
     		 }
     	}
     	catch(Exception e){
     		
     	}
     }
 %>
<div class="createuser-page">
<div class="">
	<div class=" jhansiall-pages">
  <div class="tenderspage-main">
  	<div class="container">
  	<liferay-ui:error key="name.errorMsg.missing" message="name.errorMsg.missing"/>
    <liferay-ui:error key="hi_name.errorMsg.missing" message="hi_name.errorMsg.missing"/>
    <liferay-ui:error key="redirectLink.errorMsg.missing" message="redirectLink.errorMsg.missing"/>
    <liferay-ui:error key="hi_redirectLink.errorMsg.missing" message="hi_redirectLink.errorMsg.missing"/>
  	<liferay-ui:error key="document.errorMsg.missing" message="document.errorMsg.missing"/>
     <liferay-ui:error key="document.errorMsg.sizeIssue" message="document.errorMsg.sizeIssue"/>
  		  <div class="col-md-12">
                <h1 class="tendertext-main mb-5"><span><%
                	if(reportId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> Reports and Insights</span></h1>
           </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=manageFormsURL%>" method="post" name="fm">
	       <aui:input type="hidden" label="" name="reportId" value="<%=reportId%>"></aui:input>
	       <div class="row">
	       <div class="col-md-6">
	        <div class="form-group">
	          <aui:input type="text" value="<%=title%>" onkeypress="return ((event.charCode > 64 && 
event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode > 39 && event.charCode < 58) || event.charCode == 0 || event.charCode == 32)" name="title" label="Name" cssClass="form-control">
	          <aui:validator name="required"></aui:validator>
<aui:validator name="custom" errorMessage="Please remove special characters.">
					function (val, fieldNode, ruleValue) {
						var returnValue = true;
						var iChars = "<%=CustomTablePortletKeys.FRONTEND_NOT_ALLOWES_SPECIAL_CHARACTERS%>";
						   for (var i = 0; i < val.length; i++) {
								if (iChars.indexOf(val.charAt(i)) != -1) {    
								 returnValue = false;
								}
							}
							if(val.includes("&lt;") || val.includes("&gt;") || val.includes("&apos;") || val.includes("&quot;") ||val.includes("&QUOT;") ||val.includes("&equals;")){
							   returnValue = false;
							}
						return returnValue;
					}
				 </aui:validator>
	          </aui:input>
	        </div>
	        
	        <div class="form-group">
	         <div class="row">
	         <div class="col-md-8">
	          <aui:input type="file" onChange="getUploadImageURL(this);" name="importantDocument" label="Image Upload (Note: Upload image accept only .jpg,.png,.gif format.)" accept="<%=ReportsandInsightsPortletKeys.REPORTSANDINSIGHTS_FILE_CHOOSE_TYPE%>" cssClass="form-control">
	          <aui:validator name="acceptFiles">'<%=ReportsandInsightsPortletKeys.REPORTSANDINSIGHTS_FILE_UPLOAD_TYPES%>'</aui:validator>
	          <% if(reportId==0){ %>
	          <aui:validator name="required"></aui:validator>	
	          <% } %>
	          		<aui:validator name="custom" errorMessage="File too Big, please select a file less than 2mb.">
					 function (val, fieldNode, ruleValue) {
							 const fi = document.getElementById('<portlet:namespace />importantDocument');
							 var returnValue = true;
						        if (fi.files.length > 0) { 
						                const fsize = fi.files.item(0).size; 
						                const fileSize = Math.round((fsize / 1024)); 
											if (fileSize > 2048) { 
							                 returnValue = false;
							                }
									}        
				                      return returnValue;
								    }
				 </aui:validator>						
	          </aui:input>
	            </div>
	           <div class="col-md-4">
	           <img src="<%= fileUrl %>" <% if(fileUrl==""){ %> style="display:none;" <% } %> id="uploadImage" width="100px;" height="100px;" class="">
	          </div>
	          </div>
	          <p><b>Max file upload size 2MB</b></p>
	        </div>
	       </div>
	       <div class="col-md-6">
	       <div class="form-group">
	          <aui:input type="text" value="<%=hi_title %>" onkeypress="return ((event.charCode > 64 && 
event.charCode < 91) || (event.charCode > 96 && event.charCode < 123) || (event.charCode > 39 && event.charCode < 58) || event.charCode == 0 || event.charCode == 32)" name="hi_title" label="Name in Hindi" cssClass="form-control">
	          <aui:validator name="required"></aui:validator>
<aui:validator name="custom" errorMessage="Please remove special characters.">
					function (val, fieldNode, ruleValue) {
						var returnValue = true;
						var iChars = "<%=CustomTablePortletKeys.FRONTEND_NOT_ALLOWES_SPECIAL_CHARACTERS %>";
						   for (var i = 0; i < val.length; i++) {
								if (iChars.indexOf(val.charAt(i)) != -1) {    
								 returnValue = false;
								}
							}
							if(val.includes("&lt;") || val.includes("&gt;") || val.includes("&apos;") || val.includes("&quot;") ||val.includes("&QUOT;") ||val.includes("&equals;")){
							   returnValue = false;
							}
						return returnValue;
					}
				 </aui:validator>
	          </aui:input>
	        </div>
	        
	         <div class="form-group">
	         <div class="row">
	          <div class="col-md-8">
	          <aui:input type="file" name="newsDocument" label="Upload Document (Note: Upload document accept only .pdf,.jpg,.png,.gif and .webp format.)" accept="<%=ReportsandInsightsPortletKeys.REPORTSANDINSIGHTS_FILE_CHOOSE_TYPE%>" cssClass="form-control">
				<aui:validator name="acceptFiles">'<%=ReportsandInsightsPortletKeys.REPORTSANDINSIGHTS_FILE_UPLOAD_TYPES%>'</aui:validator>
	          <% if(reportId==0){ %>
	          <aui:validator name="required"></aui:validator>	
	          <% } %>
	           <aui:validator name="custom" errorMessage="File too Big, please select a file less than 20mb.">
					 function (val, fieldNode, ruleValue) {
							 const fi = document.getElementById('<portlet:namespace />newsDocument');
							 var returnValue = true;
						        if (fi.files.length > 0) { 
						                const fsize = fi.files.item(0).size; 
						                const fileSize = Math.round((fsize / 1024)); 
											if (fileSize > 20480) { 
							                 returnValue = false;
							                }
									}        
				                      return returnValue;
								    }
				 </aui:validator>
	          </aui:input>
	        </div>
	           <div class="col-md-4">
	           <img src="<%= fileUrl %>" <% if(fileUrl==""){ %> style="display:none;" <% } %> id="uploadImage" width="100px;" height="100px;" class="">
	          </div>
	          </div>
	          <p><b>Max file upload size 2MB</b></p>
	        </div>
	        <aui:button type="submit" name="createimportantLinks" value="Submit" cssClass="btn btn-submit" />
	       </div>
	       </div>
              
	       
	      </aui:form>
	    </div>
	</div>
  </div>
 </div></div>
 </div>
 <script>
function getUploadImageURL(uploader){
	if ( uploader.files && uploader.files[0]){
        $('#uploadImage').attr('src',  window.URL.createObjectURL(uploader.files[0]) );	
         $('#uploadImage').show();
    }
	else{
		$('#uploadImage').attr('src',"");
		$('#uploadImage').hide();
	}
} 
</script>