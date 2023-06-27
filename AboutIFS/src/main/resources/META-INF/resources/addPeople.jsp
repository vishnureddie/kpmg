<%@page import="java.util.List"%>
<%@page import="com.liferay.portal.kernel.util.UnicodeFormatter"%>
<%@page import="com.kpmg.citizenTables.service.IFSKeyOfficersLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.StructureofIFSLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.IFSKeyOfficersServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.IFSKeyOfficers"%>
<%@page import="com.kpmg.citizenTables.model.StructureofIFS"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.AboutIFS.constants.AboutIFSPortletKeys"%> 
<%@page import="com.kpmg.AboutIFS.portlet.AboutIFSPortlet"%>
<%@ include file="/init.jsp"%>  

 <portlet:actionURL var="managePeopleURL" name="managePeople">
 </portlet:actionURL>
 
	<% 
    
    IFSKeyOfficers keyofficers=null; 
				      	long keyofficerId =0L;
				      	String name="";  	
				        String email="";
				        String designation="";
				        String landlineNo ="";
				        String intercom ="";
				        if(keyofficerId!=0){
				         	try{
				         		keyofficers=IFSKeyOfficersLocalServiceUtil.fetchIFSKeyOfficers(keyofficerId);
				         		 if(keyofficers!=null){
				         			keyofficerId =keyofficers.getKeyofficerId();
						      		name=keyofficers.getName();
						      		designation=keyofficers.getDesignation();
						      		email=keyofficers.getEmail();
						      		landlineNo=keyofficers.getLandlineNo();
						      		intercom=keyofficers.getIntercom();
				         			 
				         		 }
				         	}
				         	catch(Exception e){
				         		
				         	}
				         }
		%> 
		
		
<portlet:resourceURL var="getSubCategoryURL"></portlet:resourceURL>

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
                	if(keyofficerId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> Key People</span></h1>
           </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=managePeopleURL%>" method="post" name="fm">
	       <aui:input type="hidden" label="" name="keyofficerId" value="<%=keyofficerId%>"></aui:input>
	       
	       <div class="row">
	       <div class="col-md-6">
	       					<div class="form-group">
	       						<aui:select name="category" onchange="getSubCategoryData(this.value);" value="<%=keyofficerId%>" label="Select Category" >
									<aui:option selected="true" value="-1">Select Category</aui:option>
									<% List<StructureofIFS> structureofIFS=null;
									try{
										structureofIFS=StructureofIFSLocalServiceUtil.getStructureofIFSs(0, StructureofIFSLocalServiceUtil.getStructureofIFSsCount());
									
									for(StructureofIFS data:structureofIFS){
									%>
									<aui:option value="<%=data.getIfsId() %>"><%=data.getSecretariatName() %></aui:option>
					<% } }catch(Exception e){} %>			 
								</aui:select>
					        </div>
	       				</div>
	       </div>

	       <div class="row">
	       <div class="col-md-6">
	        <div class="form-group"> 
	         <aui:input type="text" value="<%=name %>" name="name" lable="Name" cssClass="form-control">
	         <aui:validator name="required"></aui:validator>
	          </aui:input>   
        </div>

	       <div class="form-group"> 
	         <aui:input type="text" value="<%=email %>" name="email" label="Email" cssClass="form-control">
	         <aui:validator name="required"></aui:validator>
	          </aui:input>  
        </div>
        
        <div class="form-group"> 
	         <aui:input type="text" value="<%=intercom %>" name="intercom" label="Intercom" cssClass="form-control">
	         <aui:validator name="required"></aui:validator>
	          </aui:input>  
        </div>
	       </div>
	       
	       <div class="col-md-6">
	       <div class="form-group"> 
	         <aui:input type="text" value="<%=designation %>" name="designation" label="Designation" cssClass="form-control">
	         <aui:validator name="required"></aui:validator>
	          </aui:input>   
        </div>
        
	       <div class="form-group"> 
	         <aui:input type="text" value="<%=landlineNo %>" name="landlineNo" label="Landline No" cssClass="form-control">
	         <aui:validator name="required"></aui:validator>
	          </aui:input>   
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
 
<aui:script use="liferay-auto-fields">


 
</aui:script>
<script type="text/javascript">
<!--

//-->
function getSubCategoryData(categoryId){alert(categoryId);
AUI().use('aui-base','aui-io-request-deprecated', 'aui-node', function(A){
        A.io.request('<%=getSubCategoryURL.toString() %>',{
            dataType : 'json',
            method : 'POST',
            data : {
<portlet:namespace />categoryId :categoryId,
<portlet:namespace />cmd:'getsubcategories'
            },
            on : {
            success : function() {
                            var data=this.get('responseData');
                            var textElement="";
                            textElement= textElement+"<option value=''>Select SubCategory</option>";
                            $('#<portlet:namespace />subCatId').html("");
                            jQuery.each(data, function(i, val) {
                            textElement=textElement+"<option value='" + val.id + "'>"+ val.name + "</option>";
                           });
                            $('#<portlet:namespace />subCatId').append(textElement);
                             //$("select").select2();
                            }  
               }
           });
    }); 
     //$("select").select2();
}
</script>
