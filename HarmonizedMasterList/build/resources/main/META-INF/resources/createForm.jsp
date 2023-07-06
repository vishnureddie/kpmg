 <%@page import="com.liferay.portal.kernel.util.UnicodeFormatter"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.HmlTimelineLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HmlTimeline"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.HarmonizedMasterList.constants.HarmonizedMasterListPortletKeys"%> 
<%@page import="com.kpmg.HarmonizedMasterList.portlet.HarmonizedMasterListPortlet"%>
<%@ include file="/init.jsp"%>  
 <portlet:actionURL var="manageTimelineURL" name="manageTimeline">
 </portlet:actionURL>
 <%
 	long hmlTimelineId = ParamUtil.getLong(request, "hmlTimelineId");
     System.out.println("hmlTimelineId >>>"+hmlTimelineId );
     HmlTimeline hmlTimeline=null; 
     String year="";
     String month="";
     String hmlDescription="";
     String hi_hmlDescription="";
     
     long fileEntryId=0L;
     String languageId="en_US";
     String fileUrl="";
     SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
     if(hmlTimelineId!=0){
     	try{
     		hmlTimeline=HmlTimelineLocalServiceUtil.fetchHmlTimeline(hmlTimelineId);
     		 if(hmlTimeline!=null){
     			 
     			 year = hmlTimeline.getYear();
     			 month = hmlTimeline.getMonth();
     			 hmlDescription = hmlTimeline.getHmlDescription();
     			 hi_hmlDescription = hmlTimeline.getHi_hmlDescription();
     			 
     			 fileEntryId=hmlTimeline.getFileEntryId();
     			 if(fileEntryId!=0L){
     				 try{
 					fileUrl =HarmonizedMasterListPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
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
                	if(hmlTimelineId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> HML timeline</span></h1>
           </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=manageTimelineURL%>" method="post" name="fm">
	       <aui:input type="hidden" label="" name="hmlTimelineId" value="<%=hmlTimelineId%>"></aui:input>
	       <div class="row">
	       <div class="col-md-6">
	       
	       <div class="form-group"> 
             	
             	<aui:select name="year" value="<%=year%>" label="Year " >
									<aui:option selected="true" value="-1">Select Year</aui:option>
									<% 
									for(int i= 2012; i<= 2023; i++){
									%>
									<aui:option value="<%=i %>"><%=i %></aui:option>
					<% } %>			 
								</aui:select>
	         		  
        	</div>
	       
	        <div class="form-group"> 
             	<label>Description</label>
	        		 <liferay-ui:input-editor name="hmlDescription"  initMethod="initEditor" width="50" height="20" resizable="true">
             	</liferay-ui:input-editor>   
        	</div>
        	
        	 <div class="form-group">
	          <aui:input type="file" name="newsDocument" label="Upload Document (Note: Upload document accept only .pdf,.jpg,.png,.gif and .webp format.)" accept="<%=HarmonizedMasterListPortletKeys.HARMONIZEDMASTERLIST_FILE_CHOOSE_TYPE%>" cssClass="form-control">
	           
	          </aui:input>
	          <% if(fileUrl!=null && fileUrl!=""){ %>
					  <a href="<%=fileUrl %>?download=true" class="download_pdf_link" >
					  <i class="fa-solid fa-arrow-down-to-line"></i> </a>
					  <% } %>
	          <p><b>Max file upload size 20MB</b></p>
	        </div>
   <!--      	
	     <div class="form-group">
	         <div class="row">
	          <div class="col-md-8">
	          <aui:input type="file" name="newsDocument" label="Upload Document (Note: Upload document accept only .pdf,.jpg,.png,.gif and .webp format.)" accept="<%=HarmonizedMasterListPortletKeys.HARMONIZEDMASTERLIST_FILE_CHOOSE_TYPE%>" cssClass="form-control">
				<aui:validator name="acceptFiles">'<%=HarmonizedMasterListPortletKeys.HARMONIZEDMASTERLIST_FILE_UPLOAD_TYPES%>'</aui:validator>
	          <% if(hmlTimelineId==0){ %>
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
	     -->    
	       </div>
	       <div class="col-md-6">
	      
	      	<div class="form-group"> 
             	<aui:select name="month" value="<%=month%>" label="Month" >
									<aui:option selected="true" value="-1">Select Month</aui:option>
									<% 
									String[] months = new String[] { "January", "February", "March", "April", "May", "June", "July", "August","September", "October", "November", "December"  };

									for (int i = 0; i < months.length; i++) {
									
									%>
									<aui:option value="<%=months[i] %>"><%=months[i] %></aui:option>
					<% } %>			 
								</aui:select>
	         		  
        	</div>
	        
	         <div class="form-group"> 
             	<label>Hindi Description</label>
	         		<liferay-ui:input-editor name="hi_hmlDescription"  initMethod="initEditor" width="50" height="20" resizable="true">
             	</liferay-ui:input-editor>   
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
<aui:script >

function <portlet:namespace/>initEditor(){
 return  "<%= UnicodeFormatter.toString(hmlDescription) %>";
 }
 
 function <portlet:namespace/>initEditor(){
 return  "<%= UnicodeFormatter.toString(hi_hmlDescription) %>";
 }
 
 
</aui:script>
