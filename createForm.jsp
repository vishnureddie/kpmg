 <%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.kpmg.InfraFinancingHub.portlet.InfraFinancingHubPortlet"%>
<%@page import="com.kpmg.citizenTables.service.InfrafinancinghubLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Infrafinancinghub"%>
 <%@page import="com.kpmg.InfraFinancingHub.constants.InfraFinancingHubPortletKeys"%>
 <%@page import="java.text.SimpleDateFormat"%>
 <%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@ include file="/init.jsp"%>  
 <portlet:actionURL var="infrafinancinghubURL" name="manageInfraFinance">
 </portlet:actionURL>
 <%
 	long recordId = ParamUtil.getLong(request, "recordId");
     //System.out.println("recordId >>>"+recordId );
     Infrafinancinghub ifh=null;
     String name=""; 
     String date="";
     long fileEntryId=0L;
     int home=0,spotlight=0,asri=0,ehs=0,aarogyaraksha=0,wjhs=0;
     SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
     if(recordId!=0){
     	try{
     		ifh=InfrafinancinghubLocalServiceUtil.fetchInfrafinancinghub(recordId);
     		 if(ifh!=null){
     		 	 name=ifh.getName();
     		 	 if(ifh.getDate()!=null){
     				 date = dateformat.format(ifh.getDate());
     			 }
     			 fileEntryId=ifh.getFileEntryId();
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
  	 <liferay-ui:error key="title.errorMsg.missing" message="title.errorMsg.missing" /> 
  	 <liferay-ui:error key="document.errorMsg.missing" message="document.errorMsg.missing"/>
     <liferay-ui:error key="document.errorMsg.sizeIssue" message="document.errorMsg.sizeIssue"/>
  		  <div class="col-md-12">
                <h1 class="tendertext-main"><span><%
                	if(recordId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> InfraFinanacingHub</span></h1>
          </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=infrafinancinghubURL%>" method="post" name="fm" enctype="multipart/form-data">
	      <aui:input type="hidden" label="" name="recordId" value="<%=recordId%>"></aui:input>
	      <div class="col-md-12 row">
	       <div class="col-md-6">
	       <div class="form-group"> 
	       
	       <aui:input type="textarea" value="<%=name %>" name="name" label="Name" cssClass="form-control">
	         <aui:validator name="required"></aui:validator>

	          </aui:input> 
	       
	         </div>
	        
	       </div>
	        <div class="col-md-6">
	       <div class="form-group">  
                                    <aui:select name="sector" label="Sector" cssClass="form-select">
                                    <aui:option>Select Sector</aui:option>
                                   	<%
	        	JSONObject obj = InfraFinancingHubPortlet.getSectors();
	        	for (int i=1; i<=obj.length(); i++){   %>
	        	<aui:option value="<%=i %>"><%=obj.get(String.valueOf(i)) %></aui:option>
	        	<% } %>
                                </aui:select>
                                
                  </div></div>              
	           
	       </div>

	       
	       
	         <div class="col-md-12 row">
	      
	         
	       <div class="col-md-6">
	       
	       
	       <div class="form-group">
	          <aui:input type="date" value="<%=date%>" name="date" label="Date" cssClass="form-control">
	              <aui:validator name="required"></aui:validator>
	          </aui:input>
	        </div> 
	        </div>
	        <div class="col-md-6"> 
	       <div class="form-group">
	          <aui:input type="file" name="newsDocument" label="Upload Document (Note: Upload document accept only .pdf,.jpg,.png,.gif and .webp format.)" accept="<%=InfraFinancingHubPortletKeys.INFRAFINANCINGHUB_FILE_CHOOSE_TYPE%>" cssClass="form-control">
	         <%--  <aui:validator name="acceptFiles">'<%=NewsAndEventsPortletKeys.NEWS_FILE_UPLOAD_TYPES%>'</aui:validator>
	          --%> <%-- <% if(recordId==0){ %>
	          <aui:validator name="required"></aui:validator>	
	          <% } %> --%>
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
	          <p><b>Max file upload size 20MB</b></p>
	        </div>
	       </div> 
	         <div class="col-md-6">
	        <div class="form-group" style="padding-top: 20px;">
	        <aui:button type="submit" name="createNewsForm" value="Submit" cssClass="btn btn-submit" />
	        </div>
	       </div>
	        </div>
	       
	       </aui:form>
	       </div>
	      
	    </div>
	</div>
  </div>
 </div></div>
 