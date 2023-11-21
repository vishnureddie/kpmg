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
import com.jhansi.citizenTables.model.Mohallas;
import com.jhansi.citizenTables.model.Otp;
import com.jhansi.citizenTables.model.Wards;
import com.jhansi.citizenTables.model.impl.CitizensImpl;
import com.jhansi.citizenTables.service.CitizenRegisterOtpLocalServiceUtil;
import com.jhansi.citizenTables.service.CitizensLocalServiceUtil;
import com.jhansi.citizenTables.service.OtpLocalServiceUtil;
import com.jhansi.citizenTables.service.base.CitizensServiceBaseImpl;
import com.jhansi.citizenTables.service.constants.CustomTablePortletKeys;
import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.portal.aop.AopService;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.model.Role;
import com.liferay.portal.kernel.model.User;
import com.liferay.portal.kernel.security.pwd.PasswordEncryptor;
import com.liferay.portal.kernel.security.pwd.PasswordEncryptorUtil;
import com.liferay.portal.kernel.service.GroupLocalServiceUtil;
import com.liferay.portal.kernel.service.RoleLocalServiceUtil;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.UserLocalServiceUtil;
import com.liferay.portal.kernel.util.PropsUtil;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;
import java.util.Random;

import org.osgi.service.component.annotations.Component;

/**
 * The implementation of the citizens remote service.
 *
 * <p>
 * All custom service methods should be put in this class. Whenever methods are added, rerun ServiceBuilder to copy their definitions into the <code>com.jhansi.citizenTables.service.CitizensService</code> interface.
 *
 * <p>
 * This is a remote service. Methods of this service are expected to have security checks based on the propagated JAAS credentials because this service can be accessed remotely.
 * </p>
 *
 * @author Brian Wing Shun Chan
 * @see CitizensServiceBaseImpl
 */
@Component(
	property = {
		"json.web.service.context.name=jhansi",
		"json.web.service.context.path=Citizens"
	},
	service = AopService.class
)
public class CitizensServiceImpl extends CitizensServiceBaseImpl {
	/*
	 * NOTE FOR DEVELOPERS:
	 *
	 * Never reference this class directly. Always use <code>com.jhansi.citizenTables.service.CitizensServiceUtil</code> to access the citizens remote service.
	 */
	public JSONObject registerUser(String firstName,String lastName,String emailAddress,String birthDate,int gender,String aadhaarNumber,
			String panNumber,String mobileNumber,String password,int userType,long wardId,long mohallaId,String address,String fcmToken,
			String deviceType,String deviceModel,boolean notificationAllowed) throws Exception {
		JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
		JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
		boolean male =false;
		 
		jsonObj.put("firstName",firstName);
		jsonObj.put("lastName",lastName);	
		jsonObj.put("emailAddress",emailAddress);			
		jsonObj.put("birthDate",birthDate);
		jsonObj.put("gender",gender);
		jsonObj.put("aadhaarNumber",aadhaarNumber);
		jsonObj.put("panNumber",panNumber);
		jsonObj.put("mobileNumber",mobileNumber);
		jsonObj.put("userType",userType);
		jsonObj.put("wardId",wardId);
		jsonObj.put("mohallaId",mohallaId);	
		jsonObj.put("address",address);
		jsonObj.put("fcmToken",fcmToken);
		jsonObj.put("deviceType",deviceType);
		jsonObj.put("deviceModel",deviceModel);
		jsonObj.put("notificationAllowed",notificationAllowed);	
		jsonObj.put("accessKey",CustomTablePortletKeys.ACCESSKEY);
		  try {
			  Mohallas mohallas= mohallasPersistence.fetchByPrimaryKey(mohallaId); 
			  jsonObj.put("mohallaName",mohallas.getMohallaName());
			}
			catch(Exception e) {	
			}
			try {
				Wards wards= wardsPersistence.fetchByPrimaryKey(wardId);
				jsonObj.put("wardName",wards.getWardName());
				}
				catch(Exception e) {				
				}
		if(gender==1) {
			male=true;
		}
		long companyId=35241L;
		long groupId=35887L;
	    boolean autoPassword=false;
	    boolean autoScreenName=false;
		User newUser = null;
		long facebookId=0;
		String openId="";
		long[] userGroupIds = null;
		long[] groupIds = null;
		long[] organizationIds = null;
		long[] roleIds = null;
		String middleName="";
		int prefixId = 0;
		int suffixId = 0;
		Locale locale =new Locale("en_US");
		int birthdayDay = 0;
		int birthdayMonth = 0;
		int birthdayYear = 0;
		Date dtBirth=null;

			if(birthDate.isEmpty()) {
				birthDate = "1970-01-01";
			}
		SimpleDateFormat simpledate=new SimpleDateFormat("yyyy-MM-dd");
	    dtBirth=simpledate.parse(birthDate);
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(dtBirth);
	    birthdayDay = cal.get(Calendar.DATE);
	    birthdayMonth = cal.get(Calendar.MONTH);
	    birthdayYear = cal.get(Calendar.YEAR);
	    boolean sendEmail = false;
	    
	    ServiceContext serviceContext = new ServiceContext();
	    serviceContext.setAddGroupPermissions(true);
	    String jobTitle = null;
		try {
			 if(emailAddress.isEmpty() || emailAddress==null) {
				 String noEmailDomain = "@noemail.com";
					 emailAddress = mobileNumber + noEmailDomain;
				}
			 long creatorUserId=35275;//CounterLocalServiceUtil.increment(User.class.getName());
			// _log.info("creatorUserId>>>>"+creatorUserId);
			 newUser= UserLocalServiceUtil.addUser(creatorUserId, companyId, autoPassword, password, password, autoScreenName, mobileNumber, emailAddress, facebookId, openId, locale, firstName, middleName, lastName, prefixId, suffixId, male, birthdayMonth, birthdayDay, birthdayYear, jobTitle, groupIds, organizationIds, roleIds, userGroupIds, sendEmail, serviceContext);
			// _log.info("newUser.getUserId>>>>"+newUser.getUserId());
			 /*newUser = _userService.addUserWithWorkflow(companyId, autoPassword, password, password, autoScreenName, mobileNumber, 
					emailAddress, facebookId, openId, locale, firstName, middleName, lastName, prefixId, suffixId, male, birthdayMonth, 
					birthdayDay, birthdayYear, jobTitle, groupIds, organizationIds, roleIds, userGroupIds, sendEmail, serviceContext);*/
			
		} catch (Exception e) {
					String msg = "Screen name " +mobileNumber + " must not be duplicate but is already used";
					if(e.getMessage().startsWith("Password for user")) {
						msg="Password must not be null";
					}
			mainJsonObj.put("status", "Failed");
			mainJsonObj.put("message", msg); 
			/*
			 * e.getMessage(); e.printStackTrace();
			 */
		}
		if(newUser != null) {
			
			jsonObj.put("userId", newUser.getUserId());
			newUser.setEmailAddressVerified(true);
			UserLocalServiceUtil.updateUser(newUser);
			GroupLocalServiceUtil.addUserGroup(newUser.getUserId(),groupId); 
			if(userType==2) {
				Role memberRole = RoleLocalServiceUtil.getRole(companyId, "Hotel Vendor");
				RoleLocalServiceUtil.addUserRole(newUser.getUserId(), memberRole);
			}
			try{
				Citizens citizens =new CitizensImpl();
				long entryId= CounterLocalServiceUtil.increment(Citizens.class.getName());
				citizens.setEntryId(entryId);
				citizens.setUserId(newUser.getUserId());
				citizens.setAadhaarNumber(aadhaarNumber);
				citizens.setPanNumber(panNumber);
				citizens.setMobileNumber(mobileNumber);
				citizens.setGender(gender);
				citizens.setWardId(wardId);
				citizens.setMohallaId(mohallaId);
				citizens.setAddress(address);
				citizens.setFcmToken(fcmToken);
				citizens.setDeviceType(deviceType); 
				citizens.setDeviceModel(deviceModel);
				citizens.setNotificationAllowed(notificationAllowed);
				citizens.setDateofBirth(dtBirth);
				CitizensLocalServiceUtil.addCitizens(citizens);
				mainJsonObj.put("status", "success");
				mainJsonObj.put("message", "Citizen registered successfully.");
			 }catch(Exception e){
				    mainJsonObj.put("status", "Failed");
					mainJsonObj.put("message", e.getMessage());
				 e.printStackTrace();
			}
		}else {
			
		}
		
		mainJsonObj.put("data", jsonObj);
		return mainJsonObj;

}
public JSONObject updateUser(long userId,String emailAddress,String mobileNumber,long wardId,long mohallaId,String address,boolean notificationAllowed) throws Exception {
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject(); 
 
	jsonObj.put("emailAddress",emailAddress);			
 
	jsonObj.put("mobileNumber",mobileNumber);
	jsonObj.put("wardId",wardId);	
	jsonObj.put("userId",userId);	
	jsonObj.put("mohallaId",mohallaId);	
	jsonObj.put("mohallaName","");	
	jsonObj.put("wardName","");
	jsonObj.put("address",address);		
	jsonObj.put("notificationAllowed",notificationAllowed);	
 
	User user=null;
	  try {
		  user= UserLocalServiceUtil.fetchUser(userId);
		} 
		catch(Exception e) {
			 mainJsonObj.put("status", "Failed");
			 mainJsonObj.put("message", e.getMessage());
		}
	  if(user!=null) {
		  
		  try {
		  Citizens citizens=CitizensLocalServiceUtil.findByuserId(userId);
			  if(citizens!=null) {
					citizens.setMobileNumber(mobileNumber); 
					citizens.setWardId(wardId);
					citizens.setMohallaId(mohallaId);
					citizens.setAddress(address);
					citizens.setNotificationAllowed(notificationAllowed); 
					CitizensLocalServiceUtil.updateCitizens(citizens);
			  }
			  user.setEmailAddress(emailAddress);
			  user.setScreenName(mobileNumber);
			  UserLocalServiceUtil.updateUser(user);
			    mainJsonObj.put("status", "success");
				mainJsonObj.put("message", "Citizen data updated successfully."); 
			  }
				catch(Exception e) {
					 mainJsonObj.put("status", "Failed");
					 mainJsonObj.put("message", e.getMessage());
				}
	  }
	  
	  try {
		  Mohallas mohallas= mohallasPersistence.fetchByPrimaryKey(mohallaId); 
		  jsonObj.put("mohallaName",mohallas.getMohallaName());	
		} 
		catch(Exception e) {
			
		}
		
		try {
			Wards wards= wardsPersistence.fetchByPrimaryKey(wardId);
			jsonObj.put("wardName",wards.getWardName());
			}
			catch(Exception e) {
				
			}
	mainJsonObj.put("data", jsonObj);
	return mainJsonObj;
}
public JSONObject updatePassword(long userId,String password) throws Exception {
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject(); 
	jsonObj.put("userId",userId);
	 
	User user=null;
	  try {
		  String encrypedPassword=PasswordEncryptorUtil.encrypt(password);
		  user= UserLocalServiceUtil.fetchUser(userId);
		  if(user!=null) {
			  user.setPassword(encrypedPassword); 
 			  UserLocalServiceUtil.updateUser(user);
			  mainJsonObj.put("status", "success");
			  mainJsonObj.put("message", "Citizen password updated successfully."); 
		  }
		} 
		catch(Exception e) {
			 mainJsonObj.put("status", "Failed");
			 mainJsonObj.put("message", e.getMessage());
		}
	mainJsonObj.put("data", jsonObj);
	return mainJsonObj;
}
public JSONObject deleteUser(String mobileNumber) throws Exception {  //IccUser
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
	long companyId=35241L;
	User user=null;
	  try {
		  user=UserLocalServiceUtil.getUserByScreenName(companyId, mobileNumber);
			 if(user!=null) { 
			  UserLocalServiceUtil.deleteUser(user);
			  try {
			     Citizens citizens=CitizensLocalServiceUtil.findByuserId(user.getUserId());
				  if(citizens!=null) {
				  CitizensLocalServiceUtil.deleteCitizens(citizens);
				 }
				 
			  }
			  catch (Exception e) {
				// TODO: handle exception
			}
			  mainJsonObj.put("status", "success");
			  mainJsonObj.put("message", "User deleted Successfully.");
		}
	   }
		catch(Exception e) {
			 mainJsonObj.put("status", "Failed");
			 mainJsonObj.put("message", e.getMessage());
		}                                                                                                                                                                                                                                                                 
	mainJsonObj.put("data", jsonObj);
	return mainJsonObj;
}
	/*
	 * public JSONObject citizenDetails(long userId) throws Exception {
	 * 
	 * JSONObject jsonObj = JSONFactoryUtil.createJSONObject(); JSONObject
	 * mainJsonObj = JSONFactoryUtil.createJSONObject();
	 * jsonObj.put("birthDate",""); jsonObj.put("gender","");
	 * jsonObj.put("aadhaarNumber",""); jsonObj.put("panNumber","");
	 * jsonObj.put("mobileNumber",""); jsonObj.put("userType","");
	 * jsonObj.put("wardId",""); jsonObj.put("mohallaId","");
	 * jsonObj.put("address",""); jsonObj.put("fcmToken","");
	 * jsonObj.put("deviceType",""); jsonObj.put("deviceModel","");
	 * jsonObj.put("notificationAllowed",""); jsonObj.put("userId",userId); Citizens
	 * citizens=null; try { if(userId!=0) {
	 * citizens=CitizensLocalServiceUtil.findByuserId(userId); SimpleDateFormat
	 * simpledate=new SimpleDateFormat("yyyy-MM-dd"); if(citizens!=null) {
	 * if(citizens.getDateofBirth()!=null) {
	 * jsonObj.put("birthDate",simpledate.format(citizens.getDateofBirth())); }
	 * jsonObj.put("gender",citizens.getGender());
	 * jsonObj.put("aadhaarNumber",citizens.getAadhaarNumber());
	 * jsonObj.put("panNumber",citizens.getPanNumber());
	 * jsonObj.put("mobileNumber",citizens.getMobileNumber());
	 * jsonObj.put("wardId",citizens.getWardId());
	 * jsonObj.put("mohallaId",citizens.getMohallaId());
	 * jsonObj.put("address",citizens.getAddress());
	 * jsonObj.put("fcmToken",citizens.getFcmToken());
	 * jsonObj.put("deviceType",citizens.getDeviceType());
	 * jsonObj.put("deviceModel",citizens.getDeviceModel());
	 * jsonObj.put("notificationAllowed",citizens.getNotificationAllowed());
	 * mainJsonObj.put("status", "Success"); mainJsonObj.put("message",
	 * "Citizen Details."); } } } catch(Exception e) { mainJsonObj.put("status",
	 * "Failed"); mainJsonObj.put("message", e.getMessage()); e.getMessage(); }
	 * mainJsonObj.put("data", jsonObj); return mainJsonObj; }
	 */
   public JSONObject citizenLogin(String mobileNumber,String password) throws Exception {
	    
		JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
		JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
		long companyId=35241L;
	    long userId=0;
        User userData=null; 
		try { 
		if (mobileNumber !="" && password!="") {
			 
			int userStatus=UserLocalServiceUtil.authenticateByScreenName(companyId, mobileNumber, password, null, null, null);//userStatus is 1 ot -1
			System.out.println("userStatus>>>>>>>>>"+userStatus);
		 if(userStatus==1) {
			 try {
				 userData=UserLocalServiceUtil.getUserByScreenName(companyId, mobileNumber);
				 if(userData!=null) {
				    userId=userData.getUserId();
				    jsonObj.put("userId",userId);
				    jsonObj.put("firstName",userData.getFirstName());
					jsonObj.put("lastName",userData.getLastName());	
					jsonObj.put("emailAddress",userData.getEmailAddress());	 
					 			
					jsonObj.put("birthDate","");
					jsonObj.put("gender","");
					jsonObj.put("aadhaarNumber","");
					jsonObj.put("panNumber","");	
					jsonObj.put("mobileNumber","");
					jsonObj.put("wardId","");	
					jsonObj.put("mohallaId","");	
					jsonObj.put("address","");	
					jsonObj.put("fcmToken","");	
					jsonObj.put("deviceType","");	
					jsonObj.put("deviceModel","");	
					jsonObj.put("notificationAllowed","");

					jsonObj.put("accessKey",CustomTablePortletKeys.ACCESSKEY);
				    mainJsonObj.put("status", "Success");
					mainJsonObj.put("message", "Citizen login successfully.");
				 }
			 }
			 catch(Exception e) {
				    mainJsonObj.put("status", "Failed");
					mainJsonObj.put("message", e.getMessage());
				   e.getMessage();
				   
			 }
			 
			 Citizens citizens=null;
			 try {
				 if(userId!=0) {
			     citizens=CitizensLocalServiceUtil.findByuserId(userId);
				 }
			 }
			 catch(Exception e) {
				   e.getMessage();
			 } 
				SimpleDateFormat simpledate=new SimpleDateFormat("yyyy-MM-dd");
				if(citizens!=null) {
					if(citizens.getDateofBirth()!=null) {
					    jsonObj.put("birthDate",simpledate.format(citizens.getDateofBirth()));
					}
					jsonObj.put("gender",citizens.getGender());
					jsonObj.put("aadhaarNumber",citizens.getAadhaarNumber());
					jsonObj.put("panNumber",citizens.getPanNumber());	
					jsonObj.put("mobileNumber",userData.getScreenName());
					jsonObj.put("wardId",citizens.getWardId());	
					jsonObj.put("mohallaId",citizens.getMohallaId());	
					jsonObj.put("address",citizens.getAddress());	
					jsonObj.put("fcmToken",citizens.getFcmToken());	
					jsonObj.put("deviceType",citizens.getDeviceType());	
					jsonObj.put("deviceModel",citizens.getDeviceModel());	
					jsonObj.put("notificationAllowed",citizens.getNotificationAllowed());	
					mainJsonObj.put("status", "Success");
					mainJsonObj.put("message", "Citizen login successfully.");
				}
		 }
		 else {
			    mainJsonObj.put("status", "Failed");
				mainJsonObj.put("message", "Invalid Credentials.");
		 }
		}else {
			    mainJsonObj.put("status", "Failed");
				mainJsonObj.put("message", "mobileNumber and password not empty.");
		}
		  }catch(Exception e) {
			    mainJsonObj.put("status", "Failed");
				mainJsonObj.put("message", e.getMessage());
		 }
		mainJsonObj.put("data", jsonObj);
      return mainJsonObj;
	
	}
	public JSONObject sendOTPRequestTypes() {
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	jsonObj.put("1", "Registration");
	jsonObj.put("2", "UpdateProfile");
	jsonObj.put("3", "ForgotPassword");
	return jsonObj;
}
public JSONObject sendOTP(String mobileNumber,int requestType,boolean sendSMS) throws Exception {
	return CitizensLocalServiceImpl.sendOTP(mobileNumber,requestType,sendSMS);
}

public JSONObject updatedSendOTP(String mobileNumber,int requestType,boolean sendSMS) throws Exception {
	return CitizensLocalServiceImpl.updatedSendOTP(mobileNumber,requestType,sendSMS);
}

public JSONObject sendCustomSMS(String mobileNumber,String message,boolean sendSMS) throws Exception {
 
		JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
		JSONObject jsonObjNull = JSONFactoryUtil.createJSONObject();
		jsonObjNull.put("mobileNumber",mobileNumber);
		JSONObject mainJsonObj = JSONFactoryUtil.createJSONObject();
	 
		jsonObj.put("mobileNumber",mobileNumber);
		jsonObj.put("message",message);
		jsonObj.put("message length()",message.length());
		String environment = PropsUtil.get("jhansi.site.environment");
		System.out.println("environment.. "+environment);  
		_log.info("message>>>"+message);
		_log.info("mobileNumber>>>"+mobileNumber); 
	    URLConnection myURLConnection=null;
	    URL myURL=null;
	    BufferedReader reader=null;  
	    String smsContentType="english";
	    String routeId="1";
	    String AUTH_KEY = "c0828d5e44dcee84d2bfe0371d2799a1"; 
	    String mobiles = mobileNumber; 
	    _log.info(mobiles); 
	    String senderId = "JSICCC"; 
	      message=URLEncoder.encode(message);  
	    String mainUrl="http://msg.icloudsms.com/rest/services/sendSMS/sendGroupSms?"; 
	    StringBuilder sbPostData= new StringBuilder(mainUrl);
	    sbPostData.append("AUTH_KEY="+AUTH_KEY);
	    sbPostData.append("&message="+message);
	    sbPostData.append("&senderId="+senderId);
	    sbPostData.append("&routeId="+routeId);
	    sbPostData.append("&mobileNos="+mobileNumber);
	    sbPostData.append("&smsContentType="+smsContentType);
	    mainUrl = sbPostData.toString();
	    _log.info(mainUrl);   
	    if(sendSMS) {
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
			        _log.info(reader);
			    }
			    catch (IOException e)
			    {
			    	 mainJsonObj.put("status", "Failed");
					 mainJsonObj.put("message", e.getMessage());
			         e.printStackTrace();
			    }
	    }
	   return mainJsonObj;
	  }
public JSONObject otpValidation(String mobileNumber, int otp, int requestType) {
	CitizenRegisterOtp otpObject = null;
	JSONObject jsonObj = JSONFactoryUtil.createJSONObject();
	boolean status = false;
	int orgOTP = 0;
	CitizenRegisterOtp citizenRegisterOtp = null;
	try {
		citizenRegisterOtp = CitizenRegisterOtpLocalServiceUtil.findByMobileNumberAndRequestType(mobileNumber,requestType);
		if (citizenRegisterOtp != null) {
			orgOTP = citizenRegisterOtp.getOtp();
			if (orgOTP == otp) {
				citizenRegisterOtp.setStatus("success");
				CitizenRegisterOtpLocalServiceUtil.updateCitizenRegisterOtp(citizenRegisterOtp);
				status = true;
				_log.info("otpObject.getOtp()>>>=>" + otpObject.getOtp());
				if (otpObject.getOtp() == otp) {
					status = true;
					otpObject.setVerified(true);
					CitizenRegisterOtpLocalServiceUtil.updateCitizenRegisterOtp(otpObject);
				}
				 
				jsonObj.put("status", "success");
				jsonObj.put("message", "OTP validated ccesfully.");
			}
		}
	} catch (Exception e1) {
		// TODO Auto-generated catch block
		jsonObj.put("status", "Failed");
		jsonObj.put("message", e1.getMessage());
	}
	return jsonObj;
}
 	private static Log _log = LogFactoryUtil.getLog(CitizensServiceImpl.class.getName());
}