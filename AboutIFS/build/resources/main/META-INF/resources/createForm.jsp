<%@page import="com.liferay.portal.kernel.util.UnicodeFormatter"%>
<%@page import="com.kpmg.citizenTables.service.AboutusLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.AboutusServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Aboutus"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.AboutIFS.constants.AboutIFSPortletKeys"%> 
<%@page import="com.kpmg.AboutIFS.portlet.AboutIFSPortlet"%>
<%@ include file="/init.jsp"%>  
 <portlet:actionURL var="manageFormsURL" name="manageForms">
 </portlet:actionURL>
 <%
 	long aboutusId = ParamUtil.getLong(request, "aboutusId");
     System.out.println("aboutusId >>>"+aboutusId );
     
     Aboutus aboutus=null; 
     
     String mainDescription =  "";
	 String hi_mainDescription = "";
	 String hi_keyDescription = "";
	 String keyDescription = "";
	 long fileEntryId=0L;
	 String fileUrl="";
	 String languageId="en_US";
	 
	 
     SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
     if(aboutusId!=0){
     	try{
     		aboutus=AboutusLocalServiceUtil.fetchAboutus(aboutusId);
     		 if(aboutus!=null){
     			mainDescription = aboutus.getMainDescription();
     			 fileEntryId=aboutus.getFileEntryId();
     			keyDescription=aboutus.getKeyDescription();
     			hi_mainDescription = aboutus.getHi_mainDescription();
     			hi_keyDescription=aboutus.getHi_keyDescription();
     			 if(fileEntryId!=0L){
     				 try{
 					fileUrl =AboutIFSPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
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
  	<liferay-ui:error key="mainDescription.errorMsg.missing" message="mainDescription.errorMsg.missing"/>
    <liferay-ui:error key="hi_mainDescription.errorMsg.missing" message="hi_mainDescription.errorMsg.missing"/>
    <liferay-ui:error key="keyDescription.errorMsg.missing" message="keyDescription.errorMsg.missing"/>
    <liferay-ui:error key="hi_keyDescription.errorMsg.missing" message="hi_keyDescription.errorMsg.missing"/>
  	<liferay-ui:error key="document.errorMsg.missing" message="document.errorMsg.missing"/>
     <liferay-ui:error key="document.errorMsg.sizeIssue" message="document.errorMsg.sizeIssue"/>
  		  <div class="col-md-12">
                <h1 class="tendertext-main mb-5"><span><%
                	if(aboutusId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> About US</span></h1>
           </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=manageFormsURL%>" method="post" name="fm">
	       <aui:input type="hidden" label="" name="aboutusId" value="<%=aboutusId%>"></aui:input>
	       <div class="row">
	       
	       <div class="col-md-6">
	       
	        <div class="form-group"> 
             <label>mainDescription</label>
	         <liferay-ui:input-editor name="mainDescription"  initMethod="initEditor" width="50" height="20" resizable="true">
             </liferay-ui:input-editor>   
        </div>

	        
	       <div class="form-group"> 
             <label>keyDescription</label>
	         <liferay-ui:input-editor name="keyDescription"  initMethod="initEditor" width="50" height="20" resizable="true">
             </liferay-ui:input-editor>   
        </div>
	        
	        <div class="form-group">
	         <div class="row">
	         <div class="col-md-8">
	          <aui:input type="file" onChange="getUploadImageURL(this);" name="importantDocument" label="Image Upload (Note: Upload image accept only .jpg,.png,.gif format.)" accept="<%=AboutIFSPortletKeys.ABOUTIFS_FILE_CHOOSE_TYPE%>" cssClass="form-control">
	          <aui:validator name="acceptFiles">'<%=AboutIFSPortletKeys.ABOUTIFS_FILE_UPLOAD_TYPES%>'</aui:validator>
	          <% if(aboutusId==0){ %>
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
             <label>mainDescription in Hindi</label>
	         <liferay-ui:input-editor name="hi_mainDescription"  initMethod="initEditor" width="50" height="20" resizable="true">
             </liferay-ui:input-editor>   
        </div>
        
	       <div class="form-group"> 
             <label>keyDescription in Hindi</label>
	         <liferay-ui:input-editor name="hi_keyDescription"  initMethod="initEditor" width="50" height="20" resizable="true">
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

<aui:script use="liferay-auto-fields">

function <portlet:namespace/>initEditor(){
 return  "<%= UnicodeFormatter.toString(mainDescription) %>";
 }
 
 function <portlet:namespace/>initEditor(){
 return  "<%= UnicodeFormatter.toString(hi_mainDescription) %>";
 }
 
 function <portlet:namespace/>initEditor(){
 return  "<%= UnicodeFormatter.toString(keyDescription) %>";
 }
 
 function <portlet:namespace/>initEditor(){
 return  "<%= UnicodeFormatter.toString(hi_keyDescription) %>";
 }
 
</aui:script>
