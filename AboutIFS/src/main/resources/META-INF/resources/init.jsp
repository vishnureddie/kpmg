<%@page import="com.liferay.portal.kernel.model.Role"%>
<%@page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>

<%@ taglib uri="http://liferay.com/tld/aui" prefix="aui" %><%@
taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %><%@
taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %><%@
taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>

<liferay-theme:defineObjects />

<portlet:defineObjects />
<link href="/o/com.kpmg.downloadForms/css/main.css" rel="stylesheet" />
<%
 String role = "";
 List<Role> roles= user.getRoles();
  System.out.println(roles);
	if(roles != null && roles.size() > 0){
		for(Role roleData:roles ){
			if(roleData.getName().equalsIgnoreCase("DepartmentUser")){
				role=roleData.getName();
				
				break;
			}
        }
    }
 %>