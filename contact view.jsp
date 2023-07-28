<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="com.kpmg.citizenTables.model.ContactAddress"%>
<%@page import="com.kpmg.citizenTables.model.Aboutus"%>
<%@page import="java.util.List"%>
<%@page import="com.kpmg.citizenTables.service.ContactAddressLocalServiceUtil"%>
<%@page import="com.kpmg.Contactus.portlet.ContactusPortlet"%>
<%@page import="javax.portlet.PortletURL"%>
<%@ page import="javax.servlet.http.HttpServletRequest" %>
<%@ include file="/init.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<liferay-theme:defineObjects />

<portlet:defineObjects /> 
<liferay-ui:success key="entryUpdated" message="Contact Us updated successfully."  /> 
<portlet:resourceURL var="sendOTPURL"></portlet:resourceURL>
<portlet:resourceURL var="verifyOTPURL"></portlet:resourceURL>
<portlet:actionURL var="mailSent" name="EmailSent"></portlet:actionURL>
<style>
.required{
padding-right: 165px;
}
</style>
<% 
String languageId=themeDisplay.getLanguageId();
PortletURL iteratorNewURL = renderResponse.createRenderURL(); 
iteratorNewURL.setParameter("mvcPath", "/view.jsp");

%>
<main class="main_innerlayout">
	
	
	<portlet:renderURL var="createFormsURL">
			<portlet:param name="mvcPath" value="/createForm.jsp"/>  
		</portlet:renderURL>
	<portlet:renderURL var="updateRecordURL">
			<portlet:param name="mvcPath" value="/createForm.jsp"/>  
		</portlet:renderURL>
		 		 
	<%  int size=0;
	
    List<ContactAddress> resultList=null;
    List<ContactAddress> contactAddress=null;
	try{ 
		size=ContactAddressLocalServiceUtil.getContactAddressesCount();
		contactAddress=ContactAddressLocalServiceUtil.getContactAddresses(0, size) ;
	}
	catch(Exception e){
		
	}
		 %>	
	 <% if(role.equalsIgnoreCase("Departmentuser")){ %>
	   
<div class="createuser-page"> 

<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="Contact US"/></span></h1>
           </div>
         
		<div class="container">
		<% 
 
		if(size==0){ %>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=createFormsURL %>" cssClass="btn btn-black btn-sm-block" > 
                           	   
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add Contact Us</button></a>
                           </div>
                      </div>
                      <% } %>
                       
			<div class="table-responsive">
		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList = ListUtil.subList(contactAddress, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	 <liferay-ui:search-container-results results="<%=resultList %>"  /> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.ContactAddress" keyProperty="addressid" modelVar="abt">
		 		      	<%
				      	long addressid =0L;
				      	String paddress =  "";
				   	 	String hi_paddress = "";
				   	 	String phonenumber = "";
				      	String email="";
				      	String feedBackEmail="";
				      	try{
				      		addressid =abt.getAddressid();
				      		paddress =abt.getPaddress(); 
				      		phonenumber=abt.getPhonenumber(); 
 
				      		 if(languageId.equals("hi_IN")){
				      			//keyDescription =abt.getKeyDescription(); 
					      		//mainDescription=abt.getMainDescription(); 
				      		 } 
				      		feedBackEmail=abt.getFeedBackEmail(); 
				      		email=abt.getEmail();
					      	 
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>

		<liferay-ui:search-container-column-text name="Address" value="<%= paddress %>" />  
		<liferay-ui:search-container-column-text name="Phone Number" value="<%= phonenumber %>" />
		<liferay-ui:search-container-column-text name="Email" value="<%= email %>" />  
		<liferay-ui:search-container-column-text name="FeedBack Email" value="<%= feedBackEmail %>" />  
		  
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="Manage" cssClass="managekwdth">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=addressid%>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
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
</div>

        <% }else{ %>
        
        <section class="top_innerBanner " style="margin-top: -60px !important;">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1><liferay-ui:message key="ContactUs"/></h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/home"><liferay-ui:message key="Home"/></a></li>
				<li class="breadcrumb-item active"><liferay-ui:message key="ContactUs"/></li>

			  </ol>
			</nav>
		</div>	
</section> <!--Top Inner Banner-->
        
        	<section>
		<div class="container">
			<div class="main_heading"><h1><liferay-ui:message key="ContactUs"/></h1></div>
			<% 
			long addressid =0L;
	      	String paddress =  "";
	   	 	String hi_paddress = "";
	   	 	String phonenumber = "";
	      	String email="";
	      	String feedBackEmail="";
	      	ContactAddress address=null;
	      		
			if(contactAddress!=null){
				try{
				address=contactAddress.get(0);
				addressid =address.getAddressid();
	      		paddress =address.getPaddress(); 
	      		phonenumber=address.getPhonenumber(); 

	      		 if(languageId.equals("hi_IN")){
	      			//keyDescription =abt.getKeyDescription(); 
		      		//mainDescription=abt.getMainDescription(); 
	      		 } 
	      		feedBackEmail=address.getFeedBackEmail(); 
	      		email=address.getEmail();
				}
				catch(Exception e){
					
				}
				

			}
			
			%>
			
			<div class="row">
				<div class="col-lg-5">
					<div class="contact_box_content style_one">
                           <div class="contact_box_inner icon_yes">
                              <div class="icon_bx">
                                 <span class=" icon-placeholder"><i class="fa-sharp fa-regular fa-location-dot"></i></span>
                              </div>
                              <div class="contnet">
                                 <h3><liferay-ui:message key="PostAddress"/></h3>
                                 <p><a href="https://www.google.com/maps?q=<%=paddress%>" target="_blank"><%=paddress %></a></p>
                              </div>
                           </div>
                        </div>
					<div class="contact_box_content style_one">
                           <div class="contact_box_inner icon_yes">
                              <div class="icon_bx">
                                 <i class="fa-solid fa-phone"></i>
                              </div>
                              <div class="contnet">
                                 <h3><liferay-ui:message key="PhoneNo"/></h3>
                                 <p>
                                   <%=phonenumber %> 
                                 </p>
                              </div>
                           </div>
                        </div>
					<div class="contact_box_content style_one">
                           <div class="contact_box_inner icon_yes">
                              <div class="icon_bx">
                                 <i class="fa-solid fa-envelope"></i>
                              </div>
                              <div class="contnet">
                                 <h3><liferay-ui:message key="Email"/> </h3>
                                 <p>
                                   <a href = "mailto: <%=email %>"><%=email %></a> 
                                 </p>
                              </div>
                           </div>
                        </div>
				</div>
				<div class="col-lg-7 feedback_section">
					<h6><liferay-ui:message key="FeedbackForm"/></h6>
					<p><liferay-ui:message key="description"/></p>
					<aui:form class="form_email" name="contactUs"  method="post">
						<label class="form-label"><liferay-ui:message key="EnteryourofficialEmailID"/></label><br>
						<aui:input type="email" label="" placeholder="<liferay-ui:message key="EmailID"/>" name="email_value" >
						<aui:validator name="required"></aui:validator>
						</aui:input><br>
						<input type="button" onClick="sendotp()" class="btn btn-primary" value="<liferay-ui:message key="Submit"/>" >
					</aui:form>
					<aui:form cssClass="form_comment" name="form_comment" style="display:none">
						<label class="form-label"><liferay-ui:message key="EnteryourFeedback"/></label>
						<aui:input type="textarea" cssClass="textareaclass" name="feedback" label="">
						<aui:validator name="required"></aui:validator>
						</aui:input>
						<!-- <a href="#" class=" btn btn-primary" >SEND</a> -->
						<input type="button" onClick="sendFeedback()" class="btn btn-primary" value="SEND" >
						 
					</aui:form>
					<div class="alert alert-success d-flex align-items-center" id="form-alert" style="display:none !important;" role="alert">
						  <svg class="bi flex-shrink-0 me-2" width="24" height="24" role="img" aria-label="Success:"><use xlink:href="#check-circle-fill"/></svg>
						  <div>
							<liferay-ui:message key="Thankyou"/>
						  </div>
						</div> 
					<!-- Modal For help & Support-->
            <div class="modal fade" id="otpscreenModal" tabindex="-1" aria-labelledby="otpscreenModalLabel" aria-hidden="true">
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content otp_screen">
                <div class="modal-header">
					<h6 class="mb-0"><liferay-ui:message key="VerifyOTP"/></h6>    
				</div>
                  <div class="modal-body">
                    <aui:form name="verifyOtp" csslass="form" method="post"> 
                          <div class="col-lg-12">
                              <p class="mb-2"><liferay-ui:message key="Enter4-digitOTP"/></p>
                              <div style="padding-left:135px;">
                              <aui:input cssClass="field form-control" label="" type="text" style="border: solid 1px #666666;width: 150px;" name="digi1">
                            <aui:validator name="required"></aui:validator>
                             </aui:input></div>
                             <p id="error" class="text-danger small_text" style="display:none;"><liferay-ui:message key="PleaseentervalidOTP"/>.</p>
							  <div><button id="resend" style="display:none;" type="button" class="btn btn-primary mt-3"><liferay-ui:message key="ResendOTP"/></button> <button type="button" class="btn btn-primary mt-3" onClick="verifyOTP()" ><liferay-ui:message key="VerifyOTP"/></button></div> 
							  
							   <p id="timeDisplay" style="display:none;" class="small_text mt-1"><a class="primary text-muted"><liferay-ui:message key="Resend"/></a>  <i class="fa-regular fa-clock"></i><span id="timer"></span>  
							   
							  
							  </div> 
							  </aui:form>
                          </div>
                   </div>
                </div>
              </div> 
        </div></div>  
        </div></section>
        <% } %>
  		
<script>
function updateRecord(recordId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />addressid]').val(recordId);
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
   <aui:input type="text" name="addressid" value=""></aui:input>
</aui:form>


		<script type="text/javascript">
		function sendotp()
		{
			
			var auiForm = Liferay.Form.get('<portlet:namespace />contactUs');
	                 var auiValidator = auiForm.formValidator;
	                 auiValidator.validate();
	                 if (!auiValidator.hasErrors()) {
			var emailAddress=$("#<portlet:namespace />email_value").val();
			 
			console.log("emailAddress>>>"+emailAddress);
			AUI().use('aui-base','aui-io-request-deprecated', 'aui-node', function(A)
					{
		        A.io.request('<%=sendOTPURL.toString() %>',{
		            dataType : 'json',
		            method : 'POST',
		            data : {
		<portlet:namespace />emailAddress :emailAddress,
		<portlet:namespace />cmd:'sendOTP'
		            },
		            
		            on : {
		            success : function() {
		                            var data=this.get('responseData');
		                            console.log("-----------data-----------");
		                            console.log(data);
		                            if(data.sendOTP){
		                            	  $("#otpscreenModal").modal('show');
		                            	  $("#timeDisplay").show();
		                            	  timer(120);
		                            	  /* $("#<portlet:namespace />contactUs").hide() */;
		                             }
		                            else{
		                            	
		                            }
		                             var textElement="";
		                           }
		                        }  
		               });
		           });
		    }	
		}
		function verifyOTP()
		{
			var auiForm = Liferay.Form.get('<portlet:namespace />verifyOtp');
	                 var auiValidator = auiForm.formValidator;
	                 auiValidator.validate();
	                 if (!auiValidator.hasErrors()) {
		
		 	var entered_otp=$("#<portlet:namespace />digi1").val();
		/* 	var digi2=$("#<portlet:namespace />digi2").val();
			var digi3=$("#<portlet:namespace />digi3").val();
			var digi4=$("#<portlet:namespace />digi4").val();
			var entered_otp=digi1+digi2+digi3+digi4;
		 */
		 var emailAddress=$("#<portlet:namespace />email_value").val();
			console.log(entered_otp);
		
			console.log("entered_otp>>>"+entered_otp);
			AUI().use('aui-base','aui-io-request-deprecated', 'aui-node', function(A)
					{
		        A.io.request('<%=verifyOTPURL.toString() %>',{
		            dataType : 'json',
		            method : 'POST',
		            data : {
		<portlet:namespace />emailAddress :emailAddress,
		<portlet:namespace />entered_otp :entered_otp,
		<portlet:namespace />cmd:'verifyOTP'
		            },       
		            on : {
		            success : function() {
		                            var data=this.get('responseData');
		                            console.log("-----------data-----------");
		                            console.log(data);
		                             if(data.OTPValidate=="true"){
		                            	 console.log("Enter 1"); 	 
		                            	  $("#otpscreenModal").modal('hide');
		                            	  $("#<portlet:namespace />contactUs").hide() 
		                            	  $("#error").hide();
		                            	  $("#<portlet:namespace />form_comment").show();
		                             }
		                             else{
		                            	 console.log("Enter 2");
		                            	 $("#otpscreenModal").modal('show');
		                            	 // $("#timeDisplay").show();
		                            	  //timer(120);
		                            	  //$("#<portlet:namespace />contactUs").hide();
		                            	  $("#error").show();
		                            	  
		                             	 //$("#otpscreenModal").modal('hide'); 
		                             }
		                            //var textElement="";

		                           }
		                        }  
		               });
		           });
		    }	
		}
		function sendFeedback(){
			var emailAddress=$("#<portlet:namespace />email_value").val();
			 var auiForm = Liferay.Form.get('<portlet:namespace />form_comment');
	                 var auiValidator = auiForm.formValidator;
	                 auiValidator.validate();
	                 if (!auiValidator.hasErrors()) {
		
		 	var feedback=$("#<portlet:namespace />feedback").val();
		 	console.log(feedback);
		 	AUI().use('aui-base','aui-io-request-deprecated', 'aui-node', function(A)
					{
		        A.io.request('<%=verifyOTPURL.toString() %>',{
		            dataType : 'json',
		            method : 'POST',
		            data : {
		<portlet:namespace />emailAddress :emailAddress,
		<portlet:namespace />feedback :feedback,
		<portlet:namespace />cmd:'feedback'
		            },		            
		            on : {
		            success : function() {
		                            var data=this.get('responseData');
		                            console.log("-----------data-----------");
		                            console.log(data);
		                             if(data.sendFeedback){
		                            	 $("#<portlet:namespace />form_comment").hide();
		                            	   $("#form-alert").show();
		                            	   //$("#form_alert").show();
		                             }
		                             else{
		                            	 $("#<portlet:namespace />form_comment").show();
		                             }
		                            //var textElement="";

		                           }
		                        }  
		               });
		           });
		    }
		}		
</script>
<aui:script>
$('#<portlet:namespace />digi1').keyup(function() {
			  if ($('#<portlet:namespace />digi1').val().length > 4){ 
				  $('#<portlet:namespace />digi1').val($('#<portlet:namespace />digi1').val().substring(0, 4));
			   }
			});
       $('#resend').on('click', function(event){
       console.log("start");
       $('#resend').hide();
       
       sendotp();
        console.log("end"); 
        });
 
function timer(remaining) {
let timerOn = true;
  var m = Math.floor(remaining / 60);
  var s = remaining % 60;
  m = m < 10 ? '0' + m : m;
  s = s < 10 ? '0' + s : s;
  document.getElementById('timer').innerHTML = m + ':' + s;
  remaining -= 1;
  if(remaining >= 0 && timerOn) {
    setTimeout(function() {
        timer(remaining);
    }, 1000);
    return;
  }
  if(!timerOn) { 
    return;
  }
   $("#timeDisplay").hide();
   $("#resend").show();
}
</aui:script>
</main>
