/**
 * Copyright (c) 2000-present Liferay, Inc. All rights reserved.
 *
 * This library is free software; you can redistribute it and/or modify it under
 * the terms of the GNU Lesser General Public License as published by the Free
 * Software Foundation; either version 2.1 of the License, or (at your option)
 * any later version.
 *
 * This library is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
 * details.
 */

package com.jhansi.citizenTables.service.impl;
 
import com.jhansi.citizenTables.model.CitizenRegisterOtp;
import com.jhansi.citizenTables.model.Citizens;
import com.jhansi.citizenTables.model.impl.CitizenRegisterOtpImpl;
import com.jhansi.citizenTables.service.CitizenRegisterOtpLocalServiceUtil;
import com.jhansi.citizenTables.service.CitizensLocalServiceUtil;
import com.jhansi.citizenTables.service.base.CitizensLocalServiceBaseImpl;
import com.jhansi.citizenTables.service.constants.CustomTablePortletKeys;
import com.jhansi.citizenTables.service.util.CustomUtil;
import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.document.library.kernel.service.DLAppServiceUtil;
import com.liferay.mail.kernel.model.MailMessage;
import com.liferay.mail.kernel.service.MailServiceUtil;
import com.liferay.portal.aop.AopService;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.json.JSON;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.service.UserService;
import com.liferay.portal.kernel.util.PropsUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;

import org.osgi.service.component.annotations.Component;

/**
 * The implementation of the citizens local service.
 *
 * <p>
 * All custom service methods should be put in this class. Whenever methods are added, rerun ServiceBuilder to copy their definitions into the <code>com.jhansi.citizenTables.service.CitizensLocalService</code> interface.
 *
 * <p>
 * This is a local service. Methods of this service will not have security checks based on the propagated JAAS credentials because this service can only be accessed from within the same VM.
 * </p>
 *
 * @author Brian Wing Shun Chan
 * @see CitizensLocalServiceBaseImpl
 */
@Component(
	property = "model.class.name=com.jhansi.citizenTables.model.Citizens",
	service = AopService.class
)
public class CitizensLocalServiceImpl extends CitizensLocalServiceBaseImpl {
	private static Log _log = LogFactoryUtil.getLog(CitizensLocalServiceImpl.class.getName());
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never reference this class directly. Use <code>com.jhansi.citizenTables.service.CitizensLocalService</code> via injection or a <code>org.osgi.util.tracker.ServiceTracker</code> or use <code>com.jhansi.citizenTables.service.CitizensLocalServiceUtil</code>.
	 */
	
	public Citizens findByuserId(long userId)
			throws com.jhansi.citizenTables.exception.NoSuchCitizensException {
			return citizensPersistence.findByuserId(userId);
		}
	
	public static Folder getFolderData(long scopeGroupId, long parentFolderId, String rootFolderName) {
		Folder folder = null;
		try {
			folder = DLAppServiceUtil.getFolder(scopeGroupId, parentFolderId, rootFolderName);
		} catch (Exception e) {
			_log.info(e.getMessage());
		}
		return folder;
	}

	public static boolean isFolderExist(long scopeGroupId, long parentFolderId, String rootFolderName) {
		boolean folderExist = false;
		try {
			DLAppServiceUtil.getFolder(scopeGroupId, parentFolderId, rootFolderName);
			folderExist = true;
			_log.info("Folder is already Exist");
		} catch (Exception e) {
			_log.info(e.getMessage());
		}
		return folderExist;
	}
 
public static String getFile(long docEntryId,long scopeId){
	String fileUrl="";
	 FileEntry fileEntry;
	 _log.info("Enter to getFile");
	 _log.info("docEntryId>>>>>"+docEntryId);
	 _log.info("scopeId>>>>"+scopeId);
	try {
		fileEntry = DLAppServiceUtil.getFileEntry(docEntryId);
		if(fileEntry!=null){
			_log.info("Enter to fileEntry not empty");
			fileUrl = "/documents/" + scopeId + "/" + 
					fileEntry.getFolderId() +  "/" +fileEntry.getTitle();
		  }
	} catch (PortalException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return fileUrl;	  
 }




public static JSONObject sendOTP(String mobileNumber,int requestType,boolean sendSMS) throws Exception {
	  
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	JSONObject jsonObjNull = JSONFactoryUtil.createJSONObject();
	jsonObjNull.put("mobileNumber",mobileNumber);
	JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
	int otp=generateOtp();
	_log.info("opt>>>"+otp);
	jsonObj.put("OTP",otp);
	jsonObj.put("mobileNumber",mobileNumber);
	jsonObj.put("sendSMS",sendSMS);
	
	String environment = PropsUtil.get("jhansi.site.environment");
	_log.info("environment.. "+environment);
	String message="";
	long companyId=35241L;
	User userData=null;
	
		
		try {
			  userData=UserLocalServiceUtil.getUserByScreenName(companyId, mobileNumber);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		if(userData!=null) {
			if(requestType==1 || requestType==2) {
			 mainJsonObj.put("status", "Failed");
			 mainJsonObj.put("message", "Mobile number is already registered");
			 mainJsonObj.put("data", jsonObjNull);
			   return mainJsonObj;
			}
			else if(requestType==3) {
				jsonObj.put("userId",userData.getUserId());
			}
		}
		else {
			if(requestType==3) {
				 mainJsonObj.put("status", "Failed");
				 mainJsonObj.put("message", "Mobile number is not registered with Application");
				 mainJsonObj.put("data", jsonObjNull);
				 return mainJsonObj;
		   }			
	 }
 
	String requestTypeMessage="";
	String templateid="";
	  if(requestType == 1) {
		requestTypeMessage = "Register";
		templateid=CustomTablePortletKeys.REGISTER_JSCL_TEMPLATE_ID;
	  } else if (requestType == 2) {
		requestTypeMessage = "Update Profile";
		templateid=CustomTablePortletKeys.UPDATE_PROFILE_JSCL_TEMPLATE_ID;
	} else if (requestType == 3) {
		requestTypeMessage = "Forgot Password";
		templateid=CustomTablePortletKeys.FORGOT_PASSWORD_JSCL_TEMPLATE_ID;
	}
	if(environment.equalsIgnoreCase("PROD")){
		message="OTP to "+requestTypeMessage+" in JSCL Application is "+otp+". Do not share this OTP to any one for security reasons.";
	}else{
		message="OTP to "+requestTypeMessage+" in JSCL Application is "+otp+". Do not share this OTP to any one for security reasons.";
	}
	try {
		
		
		  CitizenRegisterOtp citizenRegisterOtp=null;
		     try {
			   	 citizenRegisterOtp = CitizenRegisterOtpLocalServiceUtil.findByMobileNumberAndRequestType(mobileNumber, requestType);
			  }
			  catch(Exception e) {
			    
			  }	  
		
		if(citizenRegisterOtp!=null) {

			 int smscount=citizenRegisterOtp.getSmsCount();
			 Date todayDate1 = new Date();
			 System.out.println("urrent Date and TIme : " + todayDate1);
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			 Date smsSendDate=citizenRegisterOtp.getModifiedDate();
			  System.out.println("Last SMS send Date and TIme : " + smsSendDate);
			 long timeInSecs = smsSendDate.getTime();
			 Date afterAdding3Mins = new Date(timeInSecs + (3 * 60 * 1000));
			 System.out.println("After adding 3 mins : " + afterAdding3Mins);
			 
			 if(todayDate1.before(afterAdding3Mins) || smscount >= 5) {
				     mainJsonObj.put("status", "Failed"); 
					 mainJsonObj.put("message", "You’ve reached the maximum send OTP attempts. Please try after some time.");
				     mainJsonObj.put("data", jsonObjNull);
					 return mainJsonObj; 
			 }	
		}
		try { 
		mainJsonObj=CitizensLocalServiceUtil.sendSMS(mobileNumber, message,templateid,true);
		CustomUtil.manageSmsInfo(mobileNumber,  otp, requestType, mainJsonObj);
		}
		catch(Exception e) {
			
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	mainJsonObj.put("data", jsonObj);
   return mainJsonObj;
}

public static JSONObject updatedSendOTP(String mobileNumber,int requestType,boolean sendSMS) throws Exception {
	  
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	JSONObject jsonObjNull = JSONFactoryUtil.createJSONObject();
	jsonObjNull.put("mobileNumber",mobileNumber);
	JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
	int otp=generateOtp();
	//_log.info("opt>>>"+otp);
	jsonObj.put("requestType",requestType);
	jsonObj.put("mobileNumber",mobileNumber);
	jsonObj.put("sendSMS",sendSMS);
	
	String environment = PropsUtil.get("jhansi.site.environment");
	//_log.info("environment.. "+environment);
	String message="";
	long companyId=35241L;
	User userData=null;
	
		
		try {
			  userData=UserLocalServiceUtil.getUserByScreenName(companyId, mobileNumber);
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		if(userData!=null) {
			if(requestType==1 || requestType==2) {
			 mainJsonObj.put("status", "Failed");
			 mainJsonObj.put("message", "Mobile number is already registered");
			 mainJsonObj.put("data", jsonObjNull);
			   return mainJsonObj;
			}
			else if(requestType==3) {
				jsonObj.put("userId",userData.getUserId());
			}
		}
		else {
			if(requestType==3) {
				 mainJsonObj.put("status", "Failed");
				 mainJsonObj.put("message", "Mobile number is not registered with Application");
				 mainJsonObj.put("data", jsonObjNull);
				 return mainJsonObj;
		   }			
	 }
 
	String requestTypeMessage="";
	String templateid="";
	  if(requestType == 1) {
		requestTypeMessage = "Register";
		templateid=CustomTablePortletKeys.REGISTER_JSCL_TEMPLATE_ID;
	  } else if (requestType == 2) {
		requestTypeMessage = "Update Profile";
		templateid=CustomTablePortletKeys.UPDATE_PROFILE_JSCL_TEMPLATE_ID;
	} else if (requestType == 3) {
		requestTypeMessage = "Forgot Password";
		templateid=CustomTablePortletKeys.FORGOT_PASSWORD_JSCL_TEMPLATE_ID;
	}
	if(environment.equalsIgnoreCase("PROD")){
		message="OTP to "+requestTypeMessage+" in JSCL Application is "+otp+". Do not share this OTP to any one for security reasons.";
	}else{
		message="OTP to "+requestTypeMessage+" in JSCL Application is "+otp+". Do not share this OTP to any one for security reasons.";
	}
	try {
		
		
		  CitizenRegisterOtp citizenRegisterOtp=null;
		     try {
			   	 citizenRegisterOtp = CitizenRegisterOtpLocalServiceUtil.findByMobileNumberAndRequestType(mobileNumber, requestType);
			  }
			  catch(Exception e) {
			    
			  }	  
		
		if(citizenRegisterOtp!=null) {

			 int smscount=citizenRegisterOtp.getSmsCount();
			 Date todayDate1 = new Date();
			 System.out.println("urrent Date and TIme : " + todayDate1);
			 SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
			 Date smsSendDate=citizenRegisterOtp.getModifiedDate();
			  System.out.println("Last SMS send Date and TIme : " + smsSendDate);
			 long timeInSecs = smsSendDate.getTime();
			 Date afterAdding3Mins = new Date(timeInSecs + (3 * 60 * 1000));
			 System.out.println("After adding 3 mins : " + afterAdding3Mins);
			 
			 if(todayDate1.before(afterAdding3Mins) || smscount >= 5) {
				     mainJsonObj.put("status", "Failed"); 
					 mainJsonObj.put("message", "You’ve reached the maximum send OTP attempts. Please try after some time.");
				     mainJsonObj.put("data", jsonObjNull);
					 return mainJsonObj; 
			 }	
		}
		try { 
		mainJsonObj=CitizensLocalServiceUtil.sendSMS(mobileNumber, message,templateid,true);
		CustomUtil.manageSmsInfo(mobileNumber,  otp, requestType, mainJsonObj);
		}
		catch(Exception e) {
			
		}
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	mainJsonObj.put("data", jsonObj);
   return mainJsonObj;
}

public static int generateOtp() {
	 String subString;
	Random rand = new Random();
	subString = String.format("%04d", rand.nextInt(10000));
	//_log.info("otpp : "+subString);
	int otp = Integer.parseInt(subString.trim());
	if(otp > 999) {
		return otp;
	}
	else {
		return generateOtp();
	}
}
 
 
public static void manageSmsInfo(String mobileNumber,String emailAddress,int otp,String response) {
		boolean newRecord=true;
		int smsCount=1;
		String status = null;
		String code = null;
		String reason = null;
		String clientSMSId = null;
		String messageId = null;
		CitizenRegisterOtp otpOnj=new CitizenRegisterOtpImpl();
		List<CitizenRegisterOtp> optList;
		/*
		 * try { optList =
		 * CitizenRegisterOtpLocalServiceUtil.findByMobileNumberAndEmail(mobileNumber,
		 * emailAddress); if(optList!=null && optList.size()>0) {
		 * _log.info("record existed"); otpOnj=optList.get(0);
		 * smsCount+=otpOnj.getSmsCount(); newRecord=false; } } catch (Exception e) {
		 * _log.info("record not existed"); // TODO Auto-generated catch block
		 * e.printStackTrace(); }
		 */
 
		_log.info("response... "+response);
		if(newRecord) {
			long otpEntityId=CounterLocalServiceUtil.increment(CitizenRegisterOtp.class.getName());
			otpOnj.setOtpId(otpEntityId);
		}
	    otpOnj.setSmsCount(smsCount);
		//otpOnj.setEmailAddress(emailAddress);
		otpOnj.setMobileNumber(mobileNumber);
		otpOnj.setOtp(otp);
		otpOnj.setResponse(response);
		otpOnj.setStatus(status);
		otpOnj.setCode(code);
		otpOnj.setReason(reason);
		otpOnj.setClientSMSId(clientSMSId);
		otpOnj.setMessageId(messageId);
		otpOnj.setVerified(false);
		otpOnj.setModifiedDate(new Date());
		if(newRecord) {
			CitizenRegisterOtpLocalServiceUtil.addCitizenRegisterOtp(otpOnj);
		}
		else {
			CitizenRegisterOtpLocalServiceUtil.updateCitizenRegisterOtp(otpOnj);
		}
}

 
private static UserService _userService;
//	http://msg.msgclub.net/rest/services/sendSMS/sendGroupSms?AUTH_KEY=99cc1b1853f3caebc5bd5a9e4ca8bb54&message=message&senderId=KMICCC&routeId=1&mobileNos=9177992552&smsContentType=english


public JSONObject sendSMS(String mobileNumber,String message,String templateId,boolean sendSMS) throws Exception {
	_log.info("enter to sendSMS : Step 1"); 
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	JSONObject jsonObjNull = JSONFactoryUtil.createJSONObject();
	jsonObjNull.put("mobileNumber",mobileNumber);
	JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
	_log.info("enter to sendSMS : Step 2"); 
	jsonObj.put("mobileNumber",mobileNumber);
	jsonObj.put("message",message);
	jsonObj.put("message length()",message.length());
	  URLConnection myURLConnection=null;
    URL myURL=null;
    BufferedReader reader=null;   
      message=URLEncoder.encode(message);  
    String mainUrl=CustomTablePortletKeys.SEND_SMS_API;
    _log.info("enter to sendSMS : Step 3"); 
    StringBuilder sbPostData= new StringBuilder(mainUrl);
    sbPostData.append("AUTH_KEY=" + "c0828d5e44dcee84d2bfe0371d2799a1");
    sbPostData.append("&message=" + message);
    sbPostData.append("&senderId=" + "JSICCC");
    sbPostData.append("&routeId=" + "1");
  	sbPostData.append("&mobileNos=" + mobileNumber);
  	sbPostData.append("&smsContentType=" + "english");
  	sbPostData.append("&entityid=" + "1201161045766324023");
  	sbPostData.append("&tmid=" + "JIO-K-140200000022");
  	sbPostData.append("&templateid=" + templateId);
    mainUrl = sbPostData.toString();
    _log.info("enter to sendSMS : Step 4"); 
    _log.info(mainUrl);   
    if(sendSMS) {
    	 _log.info("enter to sendSMS : Step 5");
		    try
		    {
		        myURL = new URL(mainUrl);
		        myURLConnection = myURL.openConnection();
		        myURLConnection.connect();
		        reader= new BufferedReader(new InputStreamReader(myURLConnection.getInputStream()));
		        String response;
		        while ((response = reader.readLine()) != null) {
		        	JSONObject array = JSONFactoryUtil.createJSONObject(response);
		        	jsonObj.put("smsGatewayResponse",array);
		        }
		        reader.close();
		    	mainJsonObj.put("status", "Success");
				mainJsonObj.put("message", "SMS Triggered successfully.");
		        reader.close();
		        _log.info("enter to sendSMS : Step 6");
		        _log.info(reader);
		        _log.info("enter to sendSMS : Step 6.1");
		    }
		    catch (IOException e)
		    {
		    	 mainJsonObj.put("status", "Failed");
				 mainJsonObj.put("message", e.getMessage());
		         e.printStackTrace();
		    }
    }
    _log.info("enter to sendSMS : Step 7");
   return mainJsonObj;
  }
public boolean sendMail(String to, String subject, String body) {
	 InternetAddress fromAddress = null;
			InternetAddress toAddress = null;
		
			try {
				fromAddress = new InternetAddress(CustomTablePortletKeys.EMAIL_FROM_ADDRESS);
				toAddress = new InternetAddress(to);
				MailMessage mailMessage = new MailMessage();
				
				mailMessage.setTo(toAddress);
				mailMessage.setFrom(fromAddress);
				mailMessage.setSubject(subject);
				mailMessage.setBody(body);
				mailMessage.setHTMLFormat(true);
				MailServiceUtil.sendEmail(mailMessage);
				_log.info("Email sent to:"+toAddress);
			} catch (AddressException e) {
				e.getMessage();
			}
			return true;
	 } 
    public Citizens findBymobileNumber(String mobileNumber)
		throws com.jhansi.citizenTables.exception.NoSuchCitizensException {

		return  citizensPersistence.findBymobileNumber(mobileNumber);
	}
}
