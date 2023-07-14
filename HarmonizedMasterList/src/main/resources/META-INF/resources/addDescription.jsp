<%@page import="com.liferay.portal.kernel.util.UnicodeFormatter"%>
<%@page import="com.kpmg.citizenTables.service.HmlMainDescriptionLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.HmlMainDescriptionServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HmlMainDescription"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.HarmonizedMasterList.constants.HarmonizedMasterListPortletKeys"%> 
<%@page import="com.kpmg.HarmonizedMasterList.portlet.HarmonizedMasterListPortlet"%>
<%@ include file="/init.jsp"%>  
 <portlet:actionURL var="manageFormsURL" name="manageForms">
 </portlet:actionURL>
 <%
 	long hmlId = ParamUtil.getLong(request, "hmlId");
     System.out.println("hmlId >>>"+hmlId );
     
     HmlMainDescription hml=null; 
     
     String hmlmainDescription =  "";
	 String hi_hmlmainDescription = "";
	 String languageId="en_US";
	 
	 
     SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
     if(hmlId!=0){
     	try{
     		hml=HmlMainDescriptionLocalServiceUtil.fetchHmlMainDescription(hmlId);
     		 if(hml!=null){
     			hmlmainDescription = hml.getHmlmainDescription();
     			hi_hmlmainDescription = hml.getHi_hmlmainDescription();
     			
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
  	<liferay-ui:error key="hmlmainDescription.errorMsg.missing" message="hmlmainDescription.errorMsg.missing"/>
    <liferay-ui:error key="hi_hmlmainDescription.errorMsg.missing" message="hi_hmlmainDescription.errorMsg.missing"/>
  		  <div class="col-md-12">
                <h1 class="tendertext-main mb-5"><span><%
                	if(hmlId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> HML Description</span></h1>
           </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=manageFormsURL%>" method="post" name="fm">
	       <aui:input type="hidden" label="" name="hmlId" value="<%=hmlId%>"></aui:input>
	       <div class="row">
	       
	       <div class="col-md-6">
	       
	        <div class="form-group"> 
             <label>Description</label>
	         <liferay-ui:input-editor name="hmlmainDescription"  initMethod="initEditor1" width="50" height="20" resizable="true">
             </liferay-ui:input-editor>   
        </div>
	        
	       </div>
	       <div class="col-md-6">
	       
	       <div class="form-group"> 
             <label>Description in Hindi</label>
	         <liferay-ui:input-editor name="hi_hmlmainDescription"  initMethod="initEditor2" width="50" height="20" resizable="true">
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

function <portlet:namespace/>initEditor1(){
 return  "<%= UnicodeFormatter.toString(hmlmainDescription) %>";
 }
 
 function <portlet:namespace/>initEditor2(){
 return  "<%= UnicodeFormatter.toString(hi_hmlmainDescription) %>";
 }
 
 
</aui:script>
