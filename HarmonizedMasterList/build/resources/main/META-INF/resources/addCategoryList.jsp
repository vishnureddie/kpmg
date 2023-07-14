 <%@page import="java.util.List"%>
 <%@page import="com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.UnicodeFormatter"%>
<%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 <%@page import="com.kpmg.citizenTables.service.HmlCategoryListLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HmlCategoryList"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.HarmonizedMasterList.constants.HarmonizedMasterListPortletKeys"%> 
<%@page import="com.kpmg.HarmonizedMasterList.portlet.HarmonizedMasterListPortlet"%>

<%@page import="com.kpmg.citizenTables.model.InfraKnowledgeCategory"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledgeSubCategory"%>
<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeSubCategoryLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeCategoryLocalServiceUtil"%>
<%@ include file="/init.jsp"%>  
 <portlet:actionURL var="manageCategoryListURL" name="manageCategoryList">
 </portlet:actionURL>
 <%
 	long hmlCategoryListId = ParamUtil.getLong(request, "hmlCategoryListId");
     System.out.println("hmlCategoryListId >>>"+hmlCategoryListId );
     HmlCategoryList hml=null; 
     
     String hmlCategoryInfo="";
     String hi_hmlCategoryInfo="";
     long catId=0l;
     long subcatId=0l;
     
     String languageId="en_US";
     SimpleDateFormat dateformat = new SimpleDateFormat("yyyy-MM-dd");
     if(hmlCategoryListId!=0){
     	try{
     		hml=HmlCategoryListLocalServiceUtil.fetchHmlCategoryList(hmlCategoryListId);
     		 if(hml!=null){
     			catId=hml.getCatId();
     			subcatId=hml.getSubcatId();
     			hmlCategoryInfo = hml.getHmlCategoryInfo();
     			hi_hmlCategoryInfo = hml.getHi_hmlCategoryInfo();
     			 
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
  	<liferay-ui:error key="name.errorMsg.missing" message="name.errorMsg.missing"/>
    <liferay-ui:error key="hi_name.errorMsg.missing" message="hi_name.errorMsg.missing"/>
    <liferay-ui:error key="redirectLink.errorMsg.missing" message="redirectLink.errorMsg.missing"/>
    <liferay-ui:error key="hi_redirectLink.errorMsg.missing" message="hi_redirectLink.errorMsg.missing"/>
  	<liferay-ui:error key="document.errorMsg.missing" message="document.errorMsg.missing"/>
     <liferay-ui:error key="document.errorMsg.sizeIssue" message="document.errorMsg.sizeIssue"/>
  		  <div class="col-md-12">
                <h1 class="tendertext-main mb-5"><span><%
                	if(hmlCategoryListId==0){
                %>Create <%
                	} else {
                %>Update <%
                	}
                %> HML Category List</span></h1>
           </div>	
	    <div class="tender-form">
	      <aui:form  action="<%=manageCategoryListURL%>" method="post" name="fm">
	       <aui:input type="hidden" label="" name="hmlCategoryListId" value="<%=hmlCategoryListId%>"></aui:input>
	       <div class="row">
	       <div class="col-md-6">
	       <div class="form-group">
	       						<aui:select name="catId" onchange="getSubCategoryData(this.value);" value="<%=catId%>" label="Select Category" >
									<aui:option selected="true" value="-1">Select Category</aui:option>
									<% List<InfraKnowledgeCategory> infraKnowledgeCategory=null;
									try{
										infraKnowledgeCategory=InfraKnowledgeCategoryLocalServiceUtil.getInfraKnowledgeCategories(0, InfraKnowledgeCategoryLocalServiceUtil.getInfraKnowledgeCategoriesCount());
									
									for(InfraKnowledgeCategory data:infraKnowledgeCategory){
									%>
									<aui:option value="<%=data.getCatId() %>"><%=data.getCategoryName() %></aui:option>
					<% } }catch(Exception e){} %>			 
								</aui:select>
					        </div>
	     <%  System.out.print("categ iD"+catId);  %>
	        <div class="form-group"> 
             	<label>Description</label>
	        		 <liferay-ui:input-editor name="hmlCategoryInfo"  initMethod="initEditor1" width="50" height="20" resizable="true">
             	</liferay-ui:input-editor>   
        	</div>
        	
	       </div>
	       
	       <div class="col-md-6">
	      	<div class="form-group">
	       						<aui:select name="subcatId"   value="<%=subcatId%>" label="Select Sub Category">
									<aui:option  selected="true" value="-1">Select Sub Category</aui:option>
										<% 
										if(subcatId>0)
										{
											DynamicQuery dynamicQuery1 = InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery();
                                            dynamicQuery1.add(RestrictionsFactoryUtil.eq("catId",catId));
										List<InfraKnowledgeSubCategory> infraKnowledgesubCategory=null;
									try{
										infraKnowledgesubCategory=InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery(dynamicQuery1, 0,
                                                InfraKnowledgeSubCategoryLocalServiceUtil.getInfraKnowledgeSubCategoriesCount());
									
									for(InfraKnowledgeSubCategory data1:infraKnowledgesubCategory){
									%>
									
									<aui:option value="<%=data1.getSubcatId() %>"><%=data1.getSubCategoryName()%></aui:option>
									
									<% } }catch(Exception e){} }%>	
								</aui:select>

					        </div>
	        
	         <div class="form-group"> 
	         
             	<label>Hindi Description</label>
	         		<liferay-ui:input-editor name="hi_hmlCategoryInfo"  initMethod="initEditor2" width="50" height="20" resizable="true">
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
								console.log(data);
	                            var textElement="";
	                            textElement= textElement+"<option value=''>Select SubCategory</option>";
	                            $('#<portlet:namespace />subcatId').html("");
	                            jQuery.each(data, function(i, val) {
	                            textElement=textElement+"<option value='" + val.id + "'>"+ val.name + "</option>";
	                           });
	                            $('#<portlet:namespace />subcatId').append(textElement);
	                             //$("select").select2();
	                            }  
	               }
	           });
	    }); 
	     //$("select").select2();
	}
 

</script>
<aui:script >

function <portlet:namespace/>initEditor1(){
 return  "<%= UnicodeFormatter.toString(hmlCategoryInfo) %>";
 }
 
 function <portlet:namespace/>initEditor2(){
 return  "<%= UnicodeFormatter.toString(hi_hmlCategoryInfo) %>";
 }
 
 
</aui:script>
