package com.kpmg.AboutIFS.portlet;

import com.kpmg.AboutIFS.constants.AboutIFSPortletKeys;
import com.kpmg.citizenTables.model.Aboutus;
import com.kpmg.citizenTables.model.StructureofIFS;
import com.kpmg.citizenTables.model.IFSKeyOfficers;
import com.kpmg.citizenTables.model.impl.AboutusImpl;
import com.kpmg.citizenTables.model.impl.StructureofIFSImpl;
import com.kpmg.citizenTables.model.impl.IFSKeyOfficersImpl;
import com.kpmg.citizenTables.service.AboutusLocalServiceUtil;
import com.kpmg.citizenTables.service.StructureofIFSLocalServiceUtil;
import com.kpmg.citizenTables.service.IFSKeyOfficersLocalServiceUtil;
import com.kpmg.citizenTables.service.constants.CustomTablePortletKeys;
import com.kpmg.AboutIFS.portlet.AboutIFSPortlet;
import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.model.DLFolder;
import com.liferay.document.library.kernel.model.DLFolderConstants;
import com.liferay.document.library.kernel.service.DLAppServiceUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCPortlet;
import com.liferay.portal.kernel.repository.model.FileEntry;
import com.liferay.portal.kernel.repository.model.Folder;
import com.liferay.portal.kernel.service.ServiceContext;
import com.liferay.portal.kernel.service.ServiceContextFactory;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.portal.kernel.theme.ThemeDisplay;
import com.liferay.portal.kernel.upload.UploadPortletRequest;
import com.liferay.portal.kernel.util.ParamUtil;
import com.liferay.portal.kernel.util.PortalUtil;
import com.liferay.portal.kernel.util.Validator;
import com.liferay.portal.kernel.util.WebKeys;

import java.io.File;
import java.util.Arrays;
import java.util.Date;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;

import org.apache.commons.validator.routines.UrlValidator;
import org.osgi.service.component.annotations.Component;

/**
 * @author VISHNU
 */
@Component(
	immediate = true,
	property = {
		"com.liferay.portlet.display-category=category.sample",
		"com.liferay.portlet.header-portlet-css=/css/main.css",
		"com.liferay.portlet.instanceable=true",
		"javax.portlet.display-name=AboutIFS",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + AboutIFSPortletKeys.ABOUTIFS,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class AboutIFSPortlet extends MVCPortlet {
	
private static Log _log = LogFactoryUtil.getLog(AboutIFSPortlet.class.getName());


public void managePeople(ActionRequest request, ActionResponse response) throws Exception {
	
    ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
	 long userId = themeDisplay.getUserId();
	 long keyofficerId = ParamUtil.getLong(request, "keyofficerId"); 
	 String name = ParamUtil.getString(request, "name"); 
	 String email = ParamUtil.getString(request, "email");  
	 String designation = ParamUtil.getString(request, "designation"); 
	 String landlineNo = ParamUtil.getString(request, "landlineNo"); 
	 String intercom = ParamUtil.getString(request, "intercom"); 
	 boolean isnewRecord=true; 
   				 
	 IFSKeyOfficers officers = null; 
  if(keyofficerId==0) {
	  officers=new IFSKeyOfficersImpl();
	  keyofficerId=CounterLocalServiceUtil.increment(IFSKeyOfficers.class.getName());
	  officers.setKeyofficerId(keyofficerId);
	  officers.setCreatedBy(userId);
	  officers.setCreatedDate(new Date());
  }
  else {
	  isnewRecord=false;
	  officers=IFSKeyOfficersLocalServiceUtil.fetchIFSKeyOfficers(keyofficerId);
	  officers.setModifiedBy(userId);
	  officers.setModifiedDate(new Date());
  }
  
  officers.setName(name);
  officers.setEmail(email);
  officers.setDesignation(designation);
  officers.setLandlineNo(landlineNo);
  officers.setIntercom(intercom);
  
	 boolean flag=true;
	 
	// urlValidator urlValidator = new UrlValidator();

	 
	 String[] specialChars= CustomTablePortletKeys.BACKEND_NOT_ALLOWED_SPECIAL_CHARACTERS;
	 for (String item : specialChars) {
		 
		 if(!item.equals(";")&& !item.equals("<") &&!item.equals(">"))
	        {
	        if (Validator.isNotNull(name) && name.contains(item)) {
	        	SessionErrors.add(request, "name.errorMsg.missing");
				flag =false;
	        }
         if (Validator.isNotNull(email) && email.contains(item)) {
         	SessionErrors.add(request, "email.errorMsg.missing");
				flag =false;
	        }
         if (Validator.isNotNull(landlineNo) && landlineNo.contains(item)) {
	        	SessionErrors.add(request, "landlineNo.errorMsg.missing");
				flag =false;
	        }
      if (Validator.isNotNull(designation) && designation.contains(item)) {
      	SessionErrors.add(request, "designation.errorMsg.missing");
			flag =false;
	        }
      if (Validator.isNotNull(intercom) && intercom.contains(item)) {
        	SessionErrors.add(request, "intercom.errorMsg.missing");
  			flag =false;
  	        }
         
         
	        }

		
	    }
  
	 if(flag) {
	 
  if(isnewRecord) { 
	  IFSKeyOfficersLocalServiceUtil.addIFSKeyOfficers(officers);
	   SessionMessages.add(request, "entryAdded");
  }
  else {
	  IFSKeyOfficersLocalServiceUtil.updateIFSKeyOfficers(officers);
	   SessionMessages.add(request, "entryUpdated");
  }
	 }
	 else {
		 response.setRenderParameter("jspPage","/addPeople.jsp");
	 }
}

public void deleteKeypeople(ActionRequest request, ActionResponse response) throws Exception {
	
    ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY); 
		long keyofficerId = ParamUtil.getLong(request, "keyofficerId");   
	  if(keyofficerId!=0) {
		  try { 
			  IFSKeyOfficersLocalServiceUtil.deleteIFSKeyOfficers(keyofficerId);
			  SessionMessages.add(request, "entryDeleted");
		  }
		  catch(Exception e) {
			  
		  }
	  }   
	}
// end of manage people
	
	public void manageForms(ActionRequest request, ActionResponse response) throws Exception {
		
        ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
		 long userId = themeDisplay.getUserId();
		 long aboutusId = ParamUtil.getLong(request, "aboutusId"); 
		 String mainDescription = ParamUtil.getString(request, "mainDescription"); 
		 String hi_mainDescription = ParamUtil.getString(request, "hi_mainDescription");  
		 String hi_keyDescription = ParamUtil.getString(request, "hi_keyDescription"); 
		 String keyDescription = ParamUtil.getString(request, "keyDescription"); 
		 boolean isnewRecord=true; 
	   				 
		 Aboutus about=null;
	  if(aboutusId==0) {
		  about=new AboutusImpl();
		  aboutusId=CounterLocalServiceUtil.increment(Aboutus.class.getName());
		  about.setAboutusId(aboutusId);
		  about.setCreatedBy(userId);
		  about.setCreatedDate(new Date());
	  }
	  else {
		  isnewRecord=false;
		  about=AboutusLocalServiceUtil.fetchAboutus(aboutusId);
		  about.setModifiedBy(userId);
		  about.setModifiedDate(new Date());
	  }
	  
	  about.setMainDescription(mainDescription);
	  about.setHi_mainDescription(hi_mainDescription);
	  about.setHi_keyDescription(hi_keyDescription);
	  about.setKeyDescription(keyDescription);
		 long userFolderId = getUserFolderId(themeDisplay, request);
      
		 boolean flag=true;
		 
		// urlValidator urlValidator = new UrlValidator();

		 
		 String[] specialChars= CustomTablePortletKeys.BACKEND_NOT_ALLOWED_SPECIAL_CHARACTERS;
		 for (String item : specialChars) {
			 
			 if(!item.equals(";")&& !item.equals("<") &&!item.equals(">"))
		        {
		        if (Validator.isNotNull(mainDescription) && mainDescription.contains(item)) {
		        	SessionErrors.add(request, "mainDescription.errorMsg.missing");
					flag =false;
		        }
             if (Validator.isNotNull(hi_mainDescription) && hi_mainDescription.contains(item)) {
             	SessionErrors.add(request, "hi_mainDescription.errorMsg.missing");
 				flag =false;
		        }
             if (Validator.isNotNull(keyDescription) && keyDescription.contains(item)) {
		        	SessionErrors.add(request, "keyDescription.errorMsg.missing");
					flag =false;
		        }
          if (Validator.isNotNull(hi_keyDescription) && hi_keyDescription.contains(item)) {
          	SessionErrors.add(request, "hi_keyDescription.errorMsg.missing");
				flag =false;
		        }
             
             
		        }

			
		    }
		  try {

	 		    UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(request);
					String uploadFileName = null;
					String uploadType="importantDocument";
					uploadFileName = uploadPortletRequest.getFileName(uploadType);
					
					 String nameArray[]=uploadFileName.split("\\."); 
					 if (uploadFileName != null && !uploadFileName.isEmpty()) {
						 long uploadSize =  uploadPortletRequest.getSize(uploadType);
							int fileSize= Math.round((uploadSize / 1024)); 
				             if (fileSize > 2048) {
				            	    SessionErrors.add(request, "document.errorMsg.sizeIssue");
									flag =false; 
				             }
						 String[] extensionsList= new String[]  {"jpeg","jpg","png","gif"};
					     if(nameArray.length>2 || !(Arrays.asList(extensionsList).contains(nameArray[nameArray.length-1]))){
							SessionErrors.add(request, "document.errorMsg.missing");
							flag =false;
						 }
					     if(flag) {
					    	 FileEntry entry = fileUpload(themeDisplay, request, "importantDocument","", themeDisplay.getUserId(),userFolderId);
								if(entry!=null){
									about.setFileEntryId(entry.getFileEntryId());
								} 
					     }
					 }
			  }
	 	catch(Exception e) {
	    	SessionErrors.add(request, "document.errorMsg.missing");
	    	flag=false;
		} 
		 
		  
		 if(flag) {
		 
      if(isnewRecord) { 
    	  AboutusLocalServiceUtil.addAboutus(about);
   	   SessionMessages.add(request, "entryAdded");
      }
      else {
    	  AboutusLocalServiceUtil.updateAboutus(about);
   	   SessionMessages.add(request, "entryUpdated");
      }
		 }
		 else {
			 response.setRenderParameter("jspPage","/createForm.jsp");
		 }
	}


	public long getUserFolderId(ThemeDisplay themeDisplay, ActionRequest request) {

		long parentFolderId = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
		String usersFolderName = "users";
		String usersFolderDesc = "This folder is created for Upload all Users documnets";
		String rootFolderDescription = "This folder is create for Upload User(" + themeDisplay.getUserId()
				+ ") documents";
		Folder usersRootFolder = null;
		long userFolderId = 0L;
		String rootFolderName = Long.toString(themeDisplay.getUserId());

		boolean UsersFolderExist = isFolderExist(themeDisplay.getScopeGroupId(), parentFolderId, usersFolderName);
		long usersRootFolderId = DLFolderConstants.DEFAULT_PARENT_FOLDER_ID;
		if (!UsersFolderExist) {
			usersRootFolder = createFolder(request, themeDisplay, parentFolderId, usersFolderName, usersFolderDesc);
			usersRootFolderId = usersRootFolder.getFolderId();
		} else {
			usersRootFolder = getFolder(themeDisplay.getScopeGroupId(), parentFolderId, usersFolderName);
			usersRootFolderId = usersRootFolder.getFolderId();
		}

		boolean folderExist = isFolderExist(themeDisplay.getScopeGroupId(), usersRootFolderId, rootFolderName);
		if (!folderExist) {
			Folder userFolder = createFolder(request, themeDisplay, usersRootFolderId, rootFolderName,
					rootFolderDescription);
			userFolderId = userFolder.getFolderId();
		} else {
			Folder userFolder = getFolder(themeDisplay.getScopeGroupId(), usersRootFolderId, rootFolderName);
			userFolderId = userFolder.getFolderId();
		}
		return userFolderId;
	}
	public Folder getFolder(long scopeGroupId, long parentFolderId, String rootFolderName) {
		Folder folder = null;
		try {
			folder = DLAppServiceUtil.getFolder(scopeGroupId, parentFolderId, rootFolderName);
		} catch (Exception e) {
			_log.info(e.getMessage());
		}
		return folder;
	}

	public boolean isFolderExist(long scopeGroupId, long parentFolderId, String rootFolderName) {
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

	public Folder createFolder(ActionRequest actionRequest, ThemeDisplay themeDisplay, long parentFolderId,
			String rootFolderName, String rootFolderDescription) {
		Folder folder = null;
		long repositoryId = themeDisplay.getScopeGroupId();
		try {
			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFolder.class.getName(), actionRequest);
			folder = DLAppServiceUtil.addFolder(repositoryId, parentFolderId, rootFolderName, rootFolderDescription,
					serviceContext);
		} catch (PortalException e1) {
			e1.printStackTrace();
		} catch (SystemException e1) {
			e1.printStackTrace();
		}
		return folder;
	}

public FileEntry fileUpload(ThemeDisplay themeDisplay, ActionRequest actionRequest, String uploadType, String docNumber, long userId, long folderId) {
	_log.info("calling file uplodad" + docNumber);
	UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(actionRequest);
	String uploadFileName = null;
	FileEntry fileEntry = null;
	_log.info("uploadType>>" + uploadType);
	uploadFileName = uploadPortletRequest.getFileName(uploadType);
	File uploadFile = uploadPortletRequest.getFile(uploadType);
	long uploadSize =  uploadPortletRequest.getSize(uploadType);
	String uploadMimeType = uploadPortletRequest.getContentType(uploadType);
	_log.info("uploadFileName>>" + uploadFileName);
	String description = "This file is added via programatically";
	long repositoryId = themeDisplay.getScopeGroupId();
	if (uploadFileName != null && !uploadFileName.isEmpty()) {
		try {
			Date currentDate = new Date();
			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
					actionRequest);
			serviceContext.setScopeGroupId(repositoryId);
			uploadFileName =currentDate.getTime() + "_-_" + uploadFileName.replaceAll(" ", "_");
			String ProfilePictureTitle =  uploadFileName;
			fileEntry = DLAppServiceUtil.addFileEntry(repositoryId, folderId, uploadFileName, uploadMimeType, ProfilePictureTitle, description, "changeLog",uploadFile, serviceContext);
				 
		} catch (Exception e) {
			_log.info(e.getMessage());
			e.printStackTrace();
		}
	}
	return fileEntry;
}
public static String getFile(long docEntryId,long scopeId){
	String fileUrl="";
	 FileEntry fileEntry;
	try {
		fileEntry = DLAppServiceUtil.getFileEntry(docEntryId);
		if(fileEntry!=null){
			fileUrl = "/documents/" + scopeId + "/" + 
					fileEntry.getFolderId() +  "/" +fileEntry.getTitle();
		  }
	} catch (PortalException e) {
		e.printStackTrace();
	}
	return fileUrl;	  
}
public FileEntry fileUpload1(ThemeDisplay themeDisplay, ActionRequest actionRequest, String uploadType, String docNumber, long userId, long folderId, long jobPortalJobId) {
	//_log.info("calling file uplodad" + docNumber);
	UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(actionRequest);
	String uploadFileName = null;
	FileEntry fileEntry = null;
	//_log.info("uploadType>>" + uploadType);
	uploadFileName = uploadPortletRequest.getFileName(uploadType);
	File uploadFile = uploadPortletRequest.getFile(uploadType);
	long uploadSize =  uploadPortletRequest.getSize(uploadType);
	String uploadMimeType = uploadPortletRequest.getContentType(uploadType);
	//_log.info("uploadFileName>>" + uploadFileName);
	String description = "This file is added via programatically";
	long repositoryId = themeDisplay.getScopeGroupId();
	if (uploadFileName != null && !uploadFileName.isEmpty()) {
		try {
			Date currentDate = new Date();
			ServiceContext serviceContext = ServiceContextFactory.getInstance(DLFileEntry.class.getName(),
					actionRequest);
			serviceContext.setScopeGroupId(repositoryId);
			String ProfilePictureTitle = currentDate.getTime() + "_-_" +uploadFileName;
			uploadFileName =  currentDate.getTime() + "_-_" +uploadFileName.replaceAll(" ", "_");
			fileEntry = DLAppServiceUtil.addFileEntry(repositoryId, folderId, uploadFileName, uploadMimeType, ProfilePictureTitle, description, "changeLog",uploadFile, serviceContext);
				 
		} catch (Exception e) {
			//_log.info(e.getMessage());
			//e.printStackTrace();
		}
	}
	return fileEntry;
}
	
	
	
}