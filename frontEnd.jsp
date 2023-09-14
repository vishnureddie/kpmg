<%@page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@page import="com.liferay.portal.kernel.theme.ThemeDisplay"%>
<%@page import="com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>   
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import ="com.liferay.portal.kernel.dao.orm.OrderFactoryUtil"%>;
<%@page import="com.kpmg.citizenTables.model.Ministry"%>
<%@page import="com.kpmg.citizenTables.service.MinistryLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeSubCategoryLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeCategoryLocalServiceUtil"%>
<%@page import="java.util.List"%>
<%@page import="com.kpmg.infraknowledge.portlet.InfraKnowledgePortlet"%>
<%@page import="com.kpmg.infraknowledge.constants.InfraKnowledgePortletKeys"%>
<%@page import="com.kpmg.citizenTables.service.InfraKnowledgeLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledge"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledgeCategory"%>
<%@page import="com.kpmg.citizenTables.model.InfraKnowledgeSubCategory"%>
 <%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
 <%@page import="com.kpmg.citizenTables.service.constants.CustomTablePortletKeys"%>
 
<%@page import="com.kpmg.citizenTables.service.KPILocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.KPI"%>
 
 <portlet:resourceURL var="getMinistryOption"></portlet:resourceURL>
 <section class="top_innerBanner " style="margin-top: -84px !important;">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1>Knowledge Resources</h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/home">Home</a></li>
				<li class="breadcrumb-item active">Knowledge Resources</li>
			  </ol>
			</nav>
		</div>	
</section>

<section class="counternumbers mt-0" data-aos="zoom-in" data-aos-duration="1000">
  <div class="container">
	  <div class="counter_content_individual">
		 <div class="owl-carousel owl-theme counter_carousel">
<% 
String languageId=ThemeDisplay.getLanguageId();

List<KPI> kpis=null;
String title1="";
long count =0L;
DynamicQuery dqs = KPILocalServiceUtil.dynamicQuery();
dqs.add(RestrictionsFactoryUtil.eq("type", "Infra Financing"));
  try{
	  kpis =KPILocalServiceUtil.dynamicQuery(dqs);
  }
  catch(Exception e){
	  e.getMessage();
  }
       int c=1;
  for(KPI report:kpis){
	  title1=report.getTitle();
	  count = report.getKpiCount();
	  
	  if(languageId.equals("hi_IN")){ 
    		title1=report.getHi_title(); 
		 }
%>
			<div class="item">
				<div class="counter_inner_individual">
				<div class="counter_value_individual"><span class="value"><%=count %></span>  </div>
				<div class="counter_title_individual"><%=title1 %></div>
			</div>
			 </div>
<% c++; } %>
		</div>
	  </div>			
	</div>
</section>

<style>
.resources_scroller .card .card-link.url-link a:before{ font-family: "FontAwesome"; font-size: 14px; position: absolute; left: 5px; content: "\f08e";}
</style>
<main class="main_innerlayout">
    <section>
        <div class="container resources_link">
            <ul class="nav nav-pills d-none d-lg-flex" id="myTab" role="tablist">
                <% 
                int tabIndex = 0;
                List<InfraKnowledgeCategory> ik = null;
                String tab = "";
                String type="";
                long cid = 0L;
                DynamicQuery dyq = null;
                try {
                	dyq = InfraKnowledgeCategoryLocalServiceUtil.dynamicQuery();
                    dyq.addOrder(OrderFactoryUtil.asc("catId"));
                    ik = InfraKnowledgeCategoryLocalServiceUtil.dynamicQuery(dyq, 0,
                            InfraKnowledgeCategoryLocalServiceUtil.getInfraKnowledgeCategoriesCount());
                } catch (Exception e) {
                    e.getMessage();
                }
                if (ik != null) {
                    for (InfraKnowledgeCategory data : ik) {
                        tab = data.getCategoryName();
                        cid = data.getCatId();
                %>
                <li class="nav-item" role="presentation">
                
                    <button class="nav-link <%=tabIndex==0?"active":"" %>" id="tab-<%=cid%>" data-bs-toggle="tab" data-bs-target="#tab-pane-<%=cid %>" type="button" role="tab" aria-controls="tab-pane-<%=cid %>" aria-selected="<%=tabIndex==0?"true":"false" %>"><%=tab %></button>
                </li>
                <% tabIndex++; } } %>
            </ul>
            <div class="tab-content accordion" id="myTabContent">
                <%
                int innerTabIndex = 0;
                for (InfraKnowledgeCategory data : ik) {
                  
                    tab = data.getCategoryName();
                    cid = data.getCatId();
                    System.out.println(tab);
                    System.out.println(cid);
                %>
                <div class="tab-pane fade <%if(innerTabIndex==0){%>show active<%} %> accordion-item" id="tab-pane-<%=cid %>" role="tabpanel" aria-labelledby="tab-<%=cid %>" tabindex="0">
                    
                    <%-- <h2 class="accordion-header d-lg-none" id="heading<%=cid%>">
                        <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#collapse<%=cid %>" aria-expanded="true" aria-controls="collapse<%=cid %>">All</button>
                    </h2> --%>
                    <div id="collapse<%=cid %>" class="accordion-collapse collapse show d-lg-block" aria-labelledby="heading<%=cid %>" data-bs-parent="#myTabContent">
                    <%if(cid==1){
                    	System.out.println("Inside All");
                    	 System.out.println("tab:"+tab);
                         System.out.println("cid:"+cid);
                         type="PAG";
                    	%>
                    <div class="accordion-body">
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="container d-flex align-items-center flex-wrap">
                                        <div class="me-auto"><h4 class="subheading blue_leftborder">POLICIES AND GUIDELINES</h4></div>
                                       <p class="btnview_sm"> <a  href="/knowledgeresourcesdetails?tab=<%=cid%>&type=<%=type%>" target="_blank">View All</a></p>
                                    </div>

                                    <div class="container">
                                        <div class="resources_scroller">
                                                <%
                                                
                                                String title = "";
                                                String fileUrl = "";
                                                String fileUrl1 = "";
                                                String viewUrl="";
                                                DynamicQuery dq1 = InfraKnowledgeLocalServiceUtil.dynamicQuery();
                                                dq1.add(RestrictionsFactoryUtil.eq("type", "CENTRAL POLICIES"));
                                             //   dq1.add(RestrictionsFactoryUtil.eq("cateId", cid));
                                                List<InfraKnowledge> ikd = null;
                                                try {
                                                    ikd = InfraKnowledgeLocalServiceUtil.dynamicQuery(dq1, 0,
                                                            InfraKnowledgeLocalServiceUtil.getInfraKnowledgesCount());
                                                } catch (Exception e) {
                                                    e.getMessage();
                                                }
                                                System.out.println("Size----------"+ikd.size());
                                                int centralPoliieSize=ikd.size();
                                                
                                                if(centralPoliieSize > 3){ %>
                                                
                                                <div class="owl-carousel owl-theme scroller" >
                                                    <% } else{ %>
                                                    	<div class="owl-theme " >
                                                    	
                                                    <% }
                                               
                                            if(centralPoliieSize!=0){ 
                                                for (InfraKnowledge newik : ikd) {
                                                    try {
                                                        title = newik.getHeadingText();
                                                         viewUrl=newik.getViewurl();
                                                        System.out.println(title);
                                                    } catch (Exception e) {
                                                    }
                                                    long fileEntryId = newik.getThumbnailfileEntryId();
                                                    if (fileEntryId != 0L) {
                                                        try {
                                                            fileUrl = InfraKnowledgePortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                    long fileEntryId1 = newik.getFileEntryId();
                                                    if (fileEntryId1 != 0L) {
                                                        try {
                                                            fileUrl1 = InfraKnowledgePortlet.getFile(fileEntryId1, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                   /*  if(fileUrl1==null || fileUrl1=="" || fileUrl1.length()<=0)
                                                    	fileUrl1=viewUrl; */
                                                    
                                                %>
                                                <div class="item" <% if(centralPoliieSize<=3){ %> style="width:33%;float: left;" <% } %>>
                                                    <div class="card">
                                                        <img src="<%=fileUrl %>" class="card-img-top" alt="...">
                                                        <div class="card-body">
                                                            <p class="card-title"><%=title %></p>
                                                            
                                                            <%
                                                            //fileUrl1==null || fileUrl1=="" || fileUrl1.length()<=0
                                                            if(viewUrl.length()>0){ %>
                                                            <p class="card-link url-link"><a href="<%=viewUrl%>?download=true">Website</a></p>
                                                            <%}else{ %>
                                                            <p class="card-link"><a href="<%=fileUrl1%>?download=true">Download</a></p>
                                                            <%} %>
                                                        </div>
                                                    </div>
                                                </div><!-- item -->
                                                <% } }else{ %>
                                                <p style="text-align: center;">No Record Found.</p>
                                                <% } %>
                                            </div><!-- Owl Carousel -->
                                        </div>
                                    </div><!-- Container -->
                                </div><!-- Central Policies -->
                            </div><!-- row -->
                            <hr class="seperator" />
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="container d-flex align-items-center flex-wrap">
                                    <%type="IFS"; %>
                                        <div class="me-auto"><h4 class="subheading yellow_leftborder">IFS Document Repository</h4></div>
                                        <p class="btnview_sm"> <a href="/knowledgeresourcesdetails?tab=<%=cid%>&type=<%=type%>" target="_blank">View All</a></p>
                                        
                                    </div>
                                    <div class="container">
                                       <!--  <div class="col-lg-3">
                                            <label class="form-label"><span class="text-danger">*</span> Document Type</label>
                                            <select class="form-select form-select-sm">
                                                <option selected>All</option>
                                                <option>Policy</option>
                                                <option>Report</option>
                                                <option>Model Concession Agreement</option>
                                                <option>Model RFP</option>
                                            </select>
                                        </div> -->
                                        <div class="resources_scroller">
                                        <%
                                                String title1 = "";
                                                String fileUrl2 = "";
                                                String fileUrl3 = "";
                                                String viewUrl1="";
                                                DynamicQuery dqt1 = InfraKnowledgeLocalServiceUtil.dynamicQuery();
                                                dqt1.add(RestrictionsFactoryUtil.eq("type", "PPP DOCUMENT REPOSITORY"));
                                               //dq2.add(RestrictionsFactoryUtil.eq("cateId", cid));
                                                List<InfraKnowledge> ikd1 = null;
                                                try {
                                                    ikd1 = InfraKnowledgeLocalServiceUtil.dynamicQuery(dqt1, 0,
                                                            InfraKnowledgeLocalServiceUtil.getInfraKnowledgesCount());
                                                } catch (Exception e) {
                                                    e.getMessage();
                                                }
                                                System.out.println("size PPP------------"+ikd1.size());
                                                System.out.println("C ID------------"+cid);
                                               int recordsSize=ikd1.size();
                                               
                                               if(recordsSize>3){
                                                %>
                                             <div class="owl-carousel owl-theme scroller">
                                         <% }else{ %>
                                         <div class=" owl-theme">
                                         <% } %>
                                                <%
                                                if(recordsSize!=0){
                                                for (InfraKnowledge newik1 : ikd1) {
                                                    try {
                                                        title1 = newik1.getHeadingText();
                                                         viewUrl1=newik1.getViewurl();              
                                                        System.out.println("View URL:"+viewUrl1);
                                                    } catch (Exception e) {
                                                    }
                                                    long fileEntryId2 = newik1.getThumbnailfileEntryId();
                                                    if (fileEntryId2 != 0L) {
                                                        try {
                                                            fileUrl2 = InfraKnowledgePortlet.getFile(fileEntryId2, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                    long fileEntryId3 = newik1.getFileEntryId();
                                                    if (fileEntryId3 != 0L) {
                                                        try {
                                                            fileUrl3 = InfraKnowledgePortlet.getFile(fileEntryId3, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                  /*   if(fileUrl3==null || fileUrl3=="")
                                                    	fileUrl3=viewUrl1; */
                                                %>
                                                <div class="item" <% if(recordsSize<=3){ %> style="width:33%;float: left;" <% } %>>
                                                    <div class="card">
                                                        <img src="<%=fileUrl2 %>" class="card-img-top" alt="...">
                                                        <div class="card-body">
                                                            <p class="card-title"><%=title1 %></p>
                                                            <%  if(viewUrl1.length()>0){%>
                                                            <p class="card-link url-link"><a href="<%=viewUrl1%>?download=true">Website</a></p>
                                                            <%}else{ %>
                                                            <p class="card-link">
                                                            <a href="<%=fileUrl3%>?download=true">Download</a>
                                                            </p>
                                                            <%} %>
                                                        </div>
                                                    </div>
                                                </div><!-- item -->
                                                <% } }else{ %>
                                                <p style="text-align: center;">No Record Found.</p>
                                                <% } %>
                                            </div><!-- Owl Carousel -->
                                        </div>
                                    </div><!-- Container -->
                                </div><!-- PPP Document Repository -->
                            </div><!-- row -->
                        </div>
                        <%}else{ 
                        System.out.println(cid);
                        System.out.println(tab);
                        long subcatid=0l;
                        long ministry1=0l;
                        
                        %>
                     <div class="accordion-body">
                            <div class="filter_form">
                                <div class="row">
                                    <div class="col-auto">
                                        <label class="form-label"><span class="text-danger">*</span>Select Subsector</label>
                                        <% String subcat="subCatId-"+cid;
                                           String min="getMinistry1(this.value,"+cid+",'Subsector');";
                                        %>
                                        <aui:select  name="<%=subcat %>" label="" onChange="<%=min %>" value="<%=subcatid%>" class="form-select form-select-sm">
                                         <aui:option selected="true" value="">All</aui:option>
                                            <% String options = "";
                                            DynamicQuery dynamicQuery1 = InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery();
                                            dynamicQuery1.add(RestrictionsFactoryUtil.eq("catId", cid));
                                            List<InfraKnowledgeSubCategory> ikc = null;
                                            try {
                                                ikc = InfraKnowledgeSubCategoryLocalServiceUtil.dynamicQuery(dynamicQuery1);
                                            } catch (Exception e) {
                                                e.getMessage();
                                            }
                                            for (InfraKnowledgeSubCategory c1 : ikc) {
                                                options = c1.getSubCategoryName();
                                                subcatid=c1.getSubcatId();
                                            %>
                                            <option value="<%=subcatid%>"><%=options %></option>
                                            <% } %>
                                        </aui:select>
                                    </div>
                                    <div class="col-auto">
                                        <label class="form-label"><span class="text-danger">*</span>Select Ministry</label>
                                        <% 
                                        String ministryname="ministry-"+cid; 
                                        String method="getMinistry1(this.value,"+cid+",'Ministry');";
                                         
                                        %>
                                        <aui:select name="<%=ministryname %>" label="" onChange="<%=method %>" class="form-select form-select-sm">
                                        <aui:option selected="true" value="">All</aui:option>
                                        </aui:select>
                                    </div>
                                </div>
                            </div><!-- filter -->
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="container d-flex align-items-center flex-wrap">
                                    <%type="PAG"; %>
                                        <div class="me-auto"><h4 class="subheading blue_leftborder">POLICIES AND GUIDELINES</h4></div>
                                        <%System.out.println("SubCatId::::::"+subcatid);
                                        String pg="policiesAndGuidelinesLink-"+cid;
                                        %>
                                        <p class="btnview_sm"> <a id="<%=pg %>" href="/knowledgeresourcesdetails?tab=<%=cid%>&type=<%=type%>" target="_blank">View All</a></p>
                                      
                                    </div>

                                    <div class="container">
                                        <div class="resources_scroller" id="policiesAndGuidelines-<%=cid%>">
                                        <% 
                                        String title = "";
                                        String fileUrl = "";
                                        String fileUrl1 = "";
                                        String viewUrl2="";
                                        DynamicQuery dq1 = InfraKnowledgeLocalServiceUtil.dynamicQuery();
                                        dq1.add(RestrictionsFactoryUtil.eq("type", "CENTRAL POLICIES"));
                                        dq1.add(RestrictionsFactoryUtil.eq("cateId", cid));
                                        List<InfraKnowledge> ikd2 = null;
                                        try {
                                            ikd2 = InfraKnowledgeLocalServiceUtil.dynamicQuery(dq1);
                                        } catch (Exception e) {
                                            e.getMessage();
                                        }
                                        System.out.println(cid+"Size:-----"+ikd2.size());
                                       int recordsSize=ikd2.size();
                                        if(recordsSize > 3){ %>
                                        
                                            <div class="owl-carousel owl-theme scroller" >
                                                <% } else{ %>
                                                	<div class="owl-theme " >
                                                	
                                                <% }
                                        if(recordsSize!=0){
                                         for (InfraKnowledge newik : ikd2) {
                                                    try {
                                                        title = newik.getHeadingText();
                                                         viewUrl2=newik.getViewurl();
                                                        System.out.println("View URL:"+viewUrl2);
                                                    } catch (Exception e) {
                                                    }
                                                    long fileEntryId = newik.getThumbnailfileEntryId();
                                                    if (fileEntryId != 0L) {
                                                        try {
                                                            fileUrl = InfraKnowledgePortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                    long fileEntryId1 = newik.getFileEntryId();
                                                    if (fileEntryId1 != 0L) {
                                                        try {
                                                            fileUrl1 = InfraKnowledgePortlet.getFile(fileEntryId1, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                   /*  if(fileUrl1==null || fileUrl1=="")
                                                    	fileUrl1=viewUrl2; */
                                                %>
                                                <div class="item" <% if(recordsSize<=3){ %> style="width:33%;float: left;" <% } %>>
                                                    <div class="card">
                                                        <img src="<%=fileUrl %>" class="card-img-top" alt="...">
                                                        <div class="card-body">
                                                            <p class="card-title"><%=title %></p>
                                                            <%if(viewUrl2.length()>0){ %>
                                                            <p class="card-link url-link"><a href="<%=viewUrl2%>?download=true">Website</a></p>
                                                            <%}else{ %>
                                                            <p class="card-link"><a href="<%=fileUrl1%>?download=true">Download</a></p>
                                                            <%} %>
                                                        </div>
                                                    </div>
                                                </div><!-- item -->
                                                <% } }else{ %>
                                                <p style="text-align: center;">No Record Found.</p>
                                                <% } %>
                                            </div><!-- Owl Carousel -->
                                        </div>
                                    </div><!-- Container -->
                                </div><!-- Central Policies -->
                            </div><!-- row -->
                            
                            
                            <hr class="seperator" />
                            <div class="row">
                                <div class="col-lg-12">
                                    <div class="container d-flex align-items-center flex-wrap">
                                     <%type="IFS";
                                       String is="IFSLink-"+cid; %>
                                        <div class="me-auto"><h4 class="subheading yellow_leftborder">IFS Document Repository</h4></div>
                                        <p class="btnview_sm"> <a id="<%=is %>" href="/knowledgeresourcesdetails?tab=<%=cid%>&type=<%=type%>" target="_blank">View All</a></p>
                                    </div>

                                    <div class="container">
                                        <div class="resources_scroller" id="IFSDocuments-<%=cid%>">
  <%
                                                String title1 = "";
                                                String fileUrl2 = "";
                                                String viewUrl3="";
                                                String fileUrl3 = "";
                                                DynamicQuery dq2 = InfraKnowledgeLocalServiceUtil.dynamicQuery();
                                                dq2.add(RestrictionsFactoryUtil.eq("type", "PPP DOCUMENT REPOSITORY"));
                                                dq2.add(RestrictionsFactoryUtil.eq("cateId", cid));
                                                List<InfraKnowledge> ikd1 = null;
                                                try {
                                                    ikd1 = InfraKnowledgeLocalServiceUtil.dynamicQuery(dq2);
                                                } catch (Exception e) {
                                                    e.getMessage();
                                                }
                                                System.out.println(cid+"Size:----- PPP"+ikd1.size());
                                            int recordsSize1=ikd1.size();
                                             if(recordsSize1 > 3){ %>
                                        
                                            <div class="owl-carousel owl-theme scroller">
                                                <% } else{ %>
                                                	<div class="owl-theme ">
                                                	
                                                <% }
                                                  if(recordsSize1!=0){
                                                	for (InfraKnowledge newik1 : ikd1) {
                                                
                                                    try {
                                                        title1 = newik1.getHeadingText();
                                                         viewUrl3=newik1.getViewurl();
                                                        System.out.println("View URL:"+viewUrl3);
                                                    } catch (Exception e) {
                                                    }
                                                    long fileEntryId2 = newik1.getThumbnailfileEntryId();
                                                    if (fileEntryId2 != 0L) {
                                                        try {
                                                            fileUrl2 = InfraKnowledgePortlet.getFile(fileEntryId2, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                    long fileEntryId3 = newik1.getFileEntryId();
                                                    if (fileEntryId3 != 0L) {
                                                        try {
                                                            fileUrl3 = InfraKnowledgePortlet.getFile(fileEntryId3, themeDisplay.getScopeGroupId());
                                                        } catch (Exception e) {
                                                        }
                                                    }
                                                    /* if(fileUrl3==null || fileUrl3=="")
                                                    	fileUrl3=viewUrl3; */
                                                %>
                                                <div class="item" <% if(recordsSize1<=3){ %> style="width:33%;float: left;" <% } %>>
                                                    <div class="card">
                                                        <img src="<%=fileUrl2 %>" class="card-img-top" alt="...">
                                                        <div class="card-body">
                                                            <p class="card-title"><%=title1 %></p>
                                                            <% if(viewUrl3.length()>0){%>
                                                            <p class="card-link url-link"><a href="<%=viewUrl3%>?download=true">Website</a></p>
                                                            <%}else{ %>
                                                            <p class="card-link"><a href="<%=fileUrl3%>?download=true">Download</a></p>
                                                            <%} %>
                                                        </div>
                                                    </div>
                                                </div><!-- item -->
                                                <% } }else{ %>
                                                 <p style="text-align: center;">No Record Found.</p>
                                                <% } %>
                                            </div><!-- Owl Carousel -->
                                        </div>
                                    </div><!-- Container -->
                                </div><!-- PPP Document Repository -->
                            </div><!-- row -->
                        </div><%}%><!-- Accordion Body -->
                    </div><!-- Accordion Collapse -->
                </div><!-- Accordion Item -->
                <% innerTabIndex++; } %>
            </div><!-- tab-content -->
        </div><!-- container -->
    </section>
</main>
<script>



function getMinistry1(reordId,cid,seletion){
	//alert(subcategoryId);
	var subcategoryId="";
	var ministryId="";
	if(seletion=="Subsector"){
		subcategoryId=reordId;
	}
	else{
		subcategoryId=$("#<portlet:namespace />subCatId-"+cid).val();
		ministryId=reordId;
	}
	
	
AUI().use('aui-base','aui-io-request-deprecated', 'aui-node', function(A){
 A.io.request('<%=getMinistryOption.toString() %>',{
 dataType : 'json',
 method : 'POST',
 data : {
<portlet:namespace />subcategoryId :subcategoryId,
<portlet:namespace />ministryId :ministryId,
<portlet:namespace />cid :cid,
<portlet:namespace />scopeGroupId :"<%=themeDisplay.getScopeGroupId()%>",
	<portlet:namespace />cmd:'getministries1'
 },
 on : {
 success : function() {
	                       var data=this.get('responseData');
                            console.log(data); 
                            var length=data['centralPoliciesData'].length;
                            var ifslength=data['ifsDocumentData'].length;
                            
                            
if(seletion=="Subsector"){
                            var textElement="";
                            textElement="<option value=''>All</option>"; 
                            $('#<portlet:namespace />ministry-'+cid).html("");
                            jQuery.each(data['ministryData'], function(i, val) {
                            textElement=textElement+"<option value='" + val.id + "'>"+ val.name + "</option>";
                           });
                            $('#<portlet:namespace />ministry-'+cid).append(textElement);
}

var policiesAndGuidelinesLink = document.getElementById("policiesAndGuidelinesLink-"+cid);
var IFSLink = document.getElementById("IFSLink-"+cid);
var viewAllUrl = "/knowledgeresourcesdetails?tab=" + cid;

var subcategoryId = "";
var ministryId = "";

if (seletion == "Subsector") {
    subcategoryId = reordId;
    ministryId = $("#<portlet:namespace />ministry-" + cid).val();
} else {
    subcategoryId = $("#<portlet:namespace />subCatId-" + cid).val();
    ministryId = reordId;
}
// Check if Subsector and Ministry are selected
if (subcategoryId !== null && subcategoryId !== "") {
    viewAllUrl += "&subsector=" + subcategoryId;
}

if (ministryId !== null && ministryId !== "") {
    viewAllUrl += "&ministry=" + ministryId;
}
console.log(viewAllUrl);
// Set type=PAG for policiesAndGuidelinesLink and type=IFS for IFSLink
policiesAndGuidelinesLink.href = viewAllUrl + "&type=PAG";
IFSLink.href = viewAllUrl + "&type=IFS";




 	         $('#policiesAndGuidelines-'+cid).html("");
	         var j=0;
	         var centralPoliciesText="";
			jQuery.each(data['centralPoliciesData'], function(i, val) { 
				j++;
			var dl="";
			var vu=val.viewUrl;
			if(vu.length>0)
				{
				dl="<p class='card-link url-link'><a href='"+vu+"?download=true'>Website</a></p>";
				}
			else
				{
				dl="<p class='card-link'><a href='"+val.fileUrl3+"?download=true'>Download</a></p>";
				}
			if(length>3){
				    centralPoliciesText=centralPoliciesText+"<div class='item'><div class='card'><img src='"+val.fileUrl2+"' class='card-img-top' alt='...'><div class='card-body'><p class='card-title'>"+val.title1+"</p>"+dl+"</div></div></div>";
			}
			else{
				    centralPoliciesText=centralPoliciesText+"<div class='item' style='width:33%;float: left;'><div class='card'><img src='"+val.fileUrl2+"' class='card-img-top' alt='...'><div class='card-body'><p class='card-title'>"+val.title1+"</p>"+dl+"</div></div></div>";
			}
					});
			
			if(j==0)
			 $('#policiesAndGuidelines-'+cid).append("<p style='text-align: center;'>No Record Found.</p>");
			else{ 
				var centralPolicies="";
			if(j>3){
				centralPolicies="<div class='owl-carousel owl-theme scroller-"+cid+"'>"+centralPoliciesText+"</div>";
			}
			else{
				centralPolicies="<div class='owl-theme'>"+centralPoliciesText+"</div>";
			 }
			  $('#policiesAndGuidelines-'+cid).append(centralPolicies);
			
			
			}
 
 if(j>3){
 $('.scroller-'+cid).owlCarousel({
	    loop:true,
	    dots:false,
		nav:true,
		responsiveClass:true,
	    responsive:{
	        0:{
	            items:1,
	            nav: false
	        },
	        600:{
	            items:2,
	            nav: false
	        },
	        1000:{
	            items:3,
	            nav: true
	        }
	    }
	});
 }
 
 
 $('#IFSDocuments-'+cid).html("");
  var IFSDocsText="";
jQuery.each(data['ifsDocumentData'], function(i, val) { 
	var dl="";
	var vu=val.viewUrl;
	if(vu.length>0)
		{
		dl="<p class='card-link url-link'><a href='"+vu+"?download=true'>Website</a></p>";
		}
	else
		{
		dl="<p class='card-link'><a href='"+val.fileUrl3+"?download=true'>Download</a></p>";
		}
if(ifslength>3){
	    IFSDocsText=IFSDocsText+"<div class='item'><div class='card'><img src='"+val.fileUrl2+"' class='card-img-top' alt='...'><div class='card-body'><p class='card-title'>"+val.title1+"</p>"+dl+"</div></div></div>";
}
else{
	    IFSDocsText=IFSDocsText+"<div class='item' style='width:33%;float: left;'><div class='card'><img src='"+val.fileUrl2+"' class='card-img-top' alt='...'><div class='card-body'><p class='card-title'>"+val.title1+"</p>"+dl+"</div></div></div>";
}
		});

if(ifslength==0)
 $('#IFSDocuments-'+cid).append("<p style='text-align: center;'>No Record Found.</p>");
else{ 
	var ifsPolicies="";
if(ifslength>3){
	ifsPolicies="<div class='owl-carousel owl-theme IFSscroller-"+cid+"'>"+IFSDocsText+"</div>";
}
else{
	ifsPolicies="<div class='owl-theme'>"+IFSDocsText+"</div>";
 }
  $('#IFSDocuments-'+cid).append(ifsPolicies);
}

if(ifslength>3){
$('.IFSscroller-'+cid).owlCarousel({
loop:true,
dots:false,
nav:true,
responsiveClass:true,
responsive:{
0:{
    items:1,
    nav: false
},
600:{
    items:2,
    nav: false
},
1000:{
    items:3,
    nav: true
}
}
});
}

 
 
                              }  
 }
 });
 });
 //$("select").select2();
}
</script>