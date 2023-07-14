package com.kpmg.HarmonizedMasterList.portlet;

import com.kpmg.HarmonizedMasterList.constants.HarmonizedMasterListPortletKeys;
import com.kpmg.citizenTables.model.HmlMainDescription;
import com.kpmg.citizenTables.model.HmlTimeline;
import com.kpmg.citizenTables.model.InfraKnowledge;
import com.kpmg.citizenTables.model.InfraKnowledgeSubCategory;
import com.kpmg.citizenTables.model.Ministry;
import com.kpmg.citizenTables.model.HmlCategoryList;
import com.kpmg.citizenTables.model.impl.HmlMainDescriptionImpl;
import com.kpmg.citizenTables.model.impl.HmlTimelineImpl;
import com.kpmg.citizenTables.model.impl.HmlCategoryListImpl;
import com.kpmg.citizenTables.service.HmlMainDescriptionServiceUtil;
import com.kpmg.citizenTables.service.HmlTimelineLocalServiceUtil;
import com.kpmg.citizenTables.service.InfraKnowledgeLocalServiceUtil;
import com.kpmg.citizenTables.service.InfraKnowledgeSubCategoryLocalServiceUtil;
import com.kpmg.citizenTables.service.MinistryLocalServiceUtil;
import com.kpmg.citizenTables.service.HmlMainDescriptionLocalServiceUtil;
import com.kpmg.citizenTables.service.HmlCategoryListLocalServiceUtil;
import com.kpmg.citizenTables.service.constants.CustomTablePortletKeys;
import com.liferay.counter.kernel.service.CounterLocalServiceUtil;
import com.liferay.document.library.kernel.model.DLFileEntry;
import com.liferay.document.library.kernel.model.DLFolder;
import com.liferay.document.library.kernel.model.DLFolderConstants;
import com.liferay.document.library.kernel.service.DLAppServiceUtil;
import com.liferay.portal.kernel.dao.orm.DynamicQuery;
import com.liferay.portal.kernel.dao.orm.OrderFactoryUtil;
import com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil;
import com.liferay.portal.kernel.exception.PortalException;
import com.liferay.portal.kernel.exception.SystemException;
import com.liferay.portal.kernel.json.JSONArray;
import com.liferay.portal.kernel.json.JSONFactoryUtil;
import com.liferay.portal.kernel.json.JSONObject;
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
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.Portlet;
import javax.portlet.ResourceRequest;
import javax.portlet.ResourceResponse;

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
		"javax.portlet.display-name=HarmonizedMasterList",
		"javax.portlet.init-param.template-path=/",
		"javax.portlet.init-param.view-template=/view.jsp",
		"javax.portlet.name=" + HarmonizedMasterListPortletKeys.HARMONIZEDMASTERLIST,
		"javax.portlet.resource-bundle=content.Language",
		"javax.portlet.security-role-ref=power-user,user"
	},
	service = Portlet.class
)
public class HarmonizedMasterListPortlet extends MVCPortlet {
	
	private static Log _log = LogFactoryUtil.getLog(HarmonizedMasterListPortlet.class.getName());
	
	public void serveResource(ResourceRequest request, ResourceResponse response) {
	       String cmd = ParamUtil.getString(request, "cmd");
	        _log.info("cmd----------->"+cmd);
		if(cmd.equalsIgnoreCase("getsubcategories")) {
			long categoryId = ParamUtil.getLong(request, "categoryId");
			_log.info("categoryId>>"+categoryId);
			try {
				JSONArray jsonArray = JSONFactoryUtil.createJSONArray();
				DynamicQuery dynamicQuery = null;
				dynamicQuery = InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery();
			     if(categoryId!=0) {
			         dynamicQuery.add(RestrictionsFactoryUtil.eq("catId", categoryId));
			    }
	           dynamicQuery.addOrder(OrderFactoryUtil.asc("SubCategoryName"));
	           List<InfraKnowledgeSubCategory> iksList=InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery(dynamicQuery, 0, InfraKnowledgeSubCategoryLocalServiceUtil.getInfraKnowledgeSubCategoriesCount());
	           //_log.info("iksList.size>>"+iksList.size());
	           for(InfraKnowledgeSubCategory data:iksList) {
	           	JSONObject jsonOb = JSONFactoryUtil.createJSONObject();
	           	jsonOb.put("id", data.getSubcatId());
	           	String str = data.getSubCategoryName();
	           	 jsonOb.put("name",str);
	               jsonArray.put(jsonOb);
	               }
	                    System.out.println("jsonArray length"+jsonArray.length());
	                    PrintWriter writer = response.getWriter();
	                    writer.print( jsonArray.toJSONString());
			} catch (Exception e) {
				// TODO: handle exception
			}  
			}

		}
	
	public void manageCategoryList(ActionRequest request, ActionResponse response) throws Exception {
		
        ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
		 long userId = themeDisplay.getUserId();
		 
		 long hmlCategoryListId = ParamUtil.getLong(request, "hmlCategoryListId");
		 long catId = ParamUtil.getLong(request, "catId");
		 long subcatId = ParamUtil.getLong(request, "subcatId");
		 String hmlCategoryInfo = ParamUtil.getString(request, "hmlCategoryInfo"); 
		 String hi_hmlCategoryInfo = ParamUtil.getString(request, "hi_hmlCategoryInfo"); 
		 boolean isnewRecord=true; 	 
	   		HmlCategoryList hml=null;
	  if(hmlCategoryListId==0) {
		  hml=new HmlCategoryListImpl();
		  hmlCategoryListId=CounterLocalServiceUtil.increment(HmlCategoryList.class.getName());
		  hml.setHmlCategoryListId(hmlCategoryListId);
		  hml.setCreatedBy(userId);
		  hml.setCreatedDate(new Date());	
	  }
	  else {
		  isnewRecord=false;
		  hml=HmlCategoryListLocalServiceUtil.fetchHmlCategoryList(hmlCategoryListId);
		  hml.setModifiedBy(userId);
		  hml.setModifiedDate(new Date());
	  }
	  
	  hml.setCatId(catId);
	  hml.setSubcatId(subcatId);
	  hml.setHmlCategoryInfo(hmlCategoryInfo);
	  hml.setHi_hmlCategoryInfo(hi_hmlCategoryInfo);
      
		 boolean flag=true;
		 
		 UrlValidator urlValidator = new UrlValidator();

		 
		 String[] specialChars= CustomTablePortletKeys.BACKEND_NOT_ALLOWED_SPECIAL_CHARACTERS;
		 for (String item : specialChars) {
			 
			 if(!item.equals(";")&& !item.equals("<") &&!item.equals(">"))
		        {
			 
		        if (Validator.isNotNull(hmlCategoryInfo) && hmlCategoryInfo.contains(item)) {
			        	SessionErrors.add(request, "hmlCategoryInfo.errorMsg.missing");
						flag =false;
			        }
	                if (Validator.isNotNull(hi_hmlCategoryInfo) && hi_hmlCategoryInfo.contains(item)) {
	                	SessionErrors.add(request, "hi_hmlCategoryInfo.errorMsg.missing");
	    				flag =false;
			        } 
		        }
		    } 
		 	  
		 if(flag) {
		 
      if(isnewRecord) { 
    	  HmlCategoryListLocalServiceUtil.addHmlCategoryList(hml);
   	   SessionMessages.add(request, "entryAdded");
      }
      else {
    	  HmlCategoryListLocalServiceUtil.updateHmlCategoryList(hml);
   	   SessionMessages.add(request, "entryUpdated");
      }
		 }
		 else {
			 response.setRenderParameter("jspPage","/createForm.jsp");
		 }
	}

public void deleteHmlCategoryList(ActionRequest request, ActionResponse response) throws Exception {
		
       ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY); 
		long hmlCategoryListId = ParamUtil.getLong(request, "hmlCategoryListId");   
	  if(hmlCategoryListId!=0) {
		  try { 
			  HmlCategoryListLocalServiceUtil.deleteHmlCategoryList(hmlCategoryListId);
			  SessionMessages.add(request, "entryDeleted");
		  }
		  catch(Exception e) {
			  
		  }
	  }   
	}

	
	// HML category List end
	public void manageTimeline(ActionRequest request, ActionResponse response) throws Exception {
		
        ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
		 long userId = themeDisplay.getUserId();
		 
		 long hmlTimelineId = ParamUtil.getLong(request, "hmlTimelineId"); 
		 String year = ParamUtil.getString(request, "year"); 
		 String month = ParamUtil.getString(request, "month");  
		 String hmlDescription = ParamUtil.getString(request, "hmlDescription"); 
		 String hi_hmlDescription = ParamUtil.getString(request, "hi_hmlDescription"); 
		 boolean isnewRecord=true; 
	   		System.out.println("first"+hmlDescription);		 
		 HmlTimeline hml=null;
	  if(hmlTimelineId==0) {
		  hml=new HmlTimelineImpl();
		  hmlTimelineId=CounterLocalServiceUtil.increment(HmlTimeline.class.getName());
		  hml.setHmlTimelineId(hmlTimelineId);
		  hml.setCreatedBy(userId);
		  hml.setCreatedDate(new Date());
		  System.out.println("second"+hmlDescription);	
	  }
	  else {
		  isnewRecord=false;
		  hml=HmlTimelineLocalServiceUtil.fetchHmlTimeline(hmlTimelineId);
		  hml.setModifiedBy(userId);
		  hml.setModifiedDate(new Date());
	  }
	  hml.setYear(year);
	  hml.setMonth(month);
	  hml.setHmlDescription(hmlDescription);
	  hml.setHi_hmlDescription(hi_hmlDescription);
		 long userFolderId = getUserFolderId(themeDisplay, request);
      
		 boolean flag=true;
		 
		 UrlValidator urlValidator = new UrlValidator();

		 
		 String[] specialChars= CustomTablePortletKeys.BACKEND_NOT_ALLOWED_SPECIAL_CHARACTERS;
		 for (String item : specialChars) {
			 
			 if(!item.equals(";")&& !item.equals("<") &&!item.equals(">"))
		        {
			 if (Validator.isNotNull(year)  && year.contains(item)) {
		        	SessionErrors.add(request, "name.errorMsg.missing");
					flag =false;
		        }
		        if (Validator.isNotNull(month) && month.contains(item)) {
		        	SessionErrors.add(request, "hi_name.errorMsg.missing");
					flag =false;
		        } 
		        if (Validator.isNotNull(hmlDescription) && hmlDescription.contains(item)) {
			        	SessionErrors.add(request, "hmlDescription.errorMsg.missing");
						flag =false;
			        }
	                if (Validator.isNotNull(hi_hmlDescription) && hi_hmlDescription.contains(item)) {
	                	SessionErrors.add(request, "hi_hmlDescription.errorMsg.missing");
	    				flag =false;
			        } 
		        }
		    }
		 try {
			  //_log.info("Step-1"); 
	 		    UploadPortletRequest uploadPortletRequest = PortalUtil.getUploadPortletRequest(request);
					String uploadFileName = null;
					String uploadType="newsDocument";
					uploadFileName = uploadPortletRequest.getFileName(uploadType);
					//_log.info("Step-2>"+uploadFileName);	
					 String nameArray[]=uploadFileName.split("\\."); 
					 if (uploadFileName != null && !uploadFileName.isEmpty()) {
						 //_log.info("Step-3>");
						 long uploadSize =  uploadPortletRequest.getSize(uploadType);
							int fileSize= Math.round((uploadSize / 1024)); 
				             if (fileSize > 20480) {
				            	    SessionErrors.add(request, "document.errorMsg.sizeIssue");
									flag =false; 
				             }
				             //_log.info("Step-4>"+flag);
						 String[] extensionsList= new String[]  {"pdf"};
					     if(nameArray.length>2 || !(Arrays.asList(extensionsList).contains(nameArray[nameArray.length-1]))){
							SessionErrors.add(request, "document.errorMsg.missing");
							flag =false;
						 }
					     //_log.info("Step-5>"+flag);
			    		     if(flag) {
					    	 FileEntry entry = fileUpload(themeDisplay, request, "newsDocument","", themeDisplay.getUserId(),userFolderId, hmlTimelineId);
								if(entry!=null){
									hml.setFileEntryId(entry.getFileEntryId());
								} 
					     }
			    		     //_log.info("Step-6>"+flag);
					 }
			  }
	 	catch(Exception e) {
	 		//_log.info("Step-7>"+e.getMessage());
	    	SessionErrors.add(request, "document.errorMsg.missing");
	    	flag=false;
		} 
		 	  
		 if(flag) {
		 
      if(isnewRecord) { 
    	  HmlTimelineLocalServiceUtil.addHmlTimeline(hml);
   	   SessionMessages.add(request, "entryAdded");
      }
      else {
    	  HmlTimelineLocalServiceUtil.updateHmlTimeline(hml);
   	   SessionMessages.add(request, "entryUpdated");
      }
		 }
		 else {
			 response.setRenderParameter("jspPage","/createForm.jsp");
		 }
	}

public void deleteHmlTimeline(ActionRequest request, ActionResponse response) throws Exception {
		
       ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY); 
		long hmlTimelineId = ParamUtil.getLong(request, "hmlTimelineId");   
	  if(hmlTimelineId!=0) {
		  try { 
			  HmlTimelineLocalServiceUtil.deleteHmlTimeline(hmlTimelineId);
			  SessionMessages.add(request, "entryDeleted");
		  }
		  catch(Exception e) {
			  
		  }
	  }   
	}

// HML Time line end


	public void manageForms(ActionRequest request, ActionResponse response) throws Exception {
		
        ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
		 long userId = themeDisplay.getUserId();
		 long hmlId = ParamUtil.getLong(request, "hmlId"); 
		 String hmlmainDescription = ParamUtil.getString(request, "hmlmainDescription"); 
		 String hi_hmlmainDescription = ParamUtil.getString(request, "hi_hmlmainDescription"); 
		 boolean isnewRecord=true; 
	   				 
		 HmlMainDescription about=null;
	  if(hmlId==0) {
		  about=new HmlMainDescriptionImpl();
		  hmlId=CounterLocalServiceUtil.increment(HmlMainDescription.class.getName());
		  about.setHmlId(hmlId);
		  about.setCreatedBy(userId);
		  about.setCreatedDate(new Date());
	  }
	  else {
		  isnewRecord=false;
		  about=HmlMainDescriptionLocalServiceUtil.fetchHmlMainDescription(hmlId);
		  about.setModifiedBy(userId);
		  about.setModifiedDate(new Date());
	  }
	  
	  about.setHmlmainDescription(hmlmainDescription);
	  about.setHi_hmlmainDescription(hi_hmlmainDescription);
		 long userFolderId = getUserFolderId(themeDisplay, request);
      
		 boolean flag=true;
		 
		// urlValidator urlValidator = new UrlValidator();

		 
		 String[] specialChars= CustomTablePortletKeys.BACKEND_NOT_ALLOWED_SPECIAL_CHARACTERS;
		 for (String item : specialChars) {
			 
			 if(!item.equals(";")&& !item.equals("<") &&!item.equals(">"))
		        {
		        if (Validator.isNotNull(hmlmainDescription) && hmlmainDescription.contains(item)) {
		        	SessionErrors.add(request, "hmlmainDescription.errorMsg.missing");
					flag =false;
		        }
             if (Validator.isNotNull(hi_hmlmainDescription) && hi_hmlmainDescription.contains(item)) {
             	SessionErrors.add(request, "hi_hmlmainDescription.errorMsg.missing");
 				flag =false;
		        }
            
		     }

			
		    }
		
		  
		 if(flag) {
		 
      if(isnewRecord) { 
    	  HmlMainDescriptionLocalServiceUtil.addHmlMainDescription(about);
   	   SessionMessages.add(request, "entryAdded");
      }
      else {
    	  HmlMainDescriptionLocalServiceUtil.updateHmlMainDescription(about);
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
			//_log.info(e.getMessage());
		}
		return folder;
	}

	public boolean isFolderExist(long scopeGroupId, long parentFolderId, String rootFolderName) {
		boolean folderExist = false;
		try {
			DLAppServiceUtil.getFolder(scopeGroupId, parentFolderId, rootFolderName);
			folderExist = true;
			//_log.info("Folder is already Exist");
		} catch (Exception e) {
			//_log.info(e.getMessage());
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
			//e1.printStackTrace();
		} catch (SystemException e1) {
			//e1.printStackTrace();
		}
		return folder;
	}

public FileEntry fileUpload(ThemeDisplay themeDisplay, ActionRequest actionRequest, String uploadType, String docNumber, long userId, long folderId, long jobPortalJobId) {
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
public static String getFile(long docEntryId,long scopeId){
	String fileUrl="";
	 FileEntry fileEntry;
	 //_log.info("Enter to getFile");
	 //_log.info("docEntryId>>>>>"+docEntryId);
	 //_log.info("scopeId>>>>"+scopeId);
	try {
		fileEntry = DLAppServiceUtil.getFileEntry(docEntryId);
		if(fileEntry!=null){
			////_log.info("Enter to fileEntry not empty");
			fileUrl = "/documents/" + scopeId + "/" + 
					fileEntry.getFolderId() +  "/" +fileEntry.getTitle();
		  }
	} catch (PortalException e) {
		// TODO Auto-generated catch block
		//e.printStackTrace();
	}
	return fileUrl;	  
 }
}