<%@page import="java.util.Locale"%>
<%@page import="com.liferay.portal.kernel.dao.orm.RestrictionsFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.Criterion"%>
<%@page import="com.liferay.portal.kernel.dao.orm.PropertyFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.dao.orm.DynamicQuery"%>
<%@page import="com.liferay.portal.kernel.util.ParamUtil"%>
<%@page import="com.kpmg.citizenTables.model.GalleryDocuments"%>
<%@page import="com.kpmg.citizenTables.service.GalleryDocumentsLocalServiceUtil"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.kpmg.events.portlet.EventsPortlet"%>
<%@page import="com.kpmg.citizenTables.service.EventsLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.Events"%>
<%@page import="com.kpmg.citizenTables.service.HolidaysListLocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.HolidaysList"%>
<%@page import="com.liferay.portal.kernel.util.ListUtil"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="javax.portlet.PortletURL"%>
<%@page import="java.util.List"%>
<%@page import="com.kpmg.events.portlet.DateFor" %>
<%@page import="com.liferay.portal.kernel.json.JSON"%>
<%@page import="com.liferay.portal.kernel.json.JSONArray"%>
<%@page import="com.liferay.portal.kernel.json.JSONFactoryUtil"%>
<%@page import="com.liferay.portal.kernel.json.JSONObject"%>
<%@page import="com.kpmg.citizenTables.model.YouTubeLinks" %>
<%@page import="com.kpmg.citizenTables.service.YouTubeLinksLocalServiceUtil"%>

<%@page import="com.kpmg.citizenTables.service.KPILocalServiceUtil"%>
<%@page import="com.kpmg.citizenTables.model.KPI"%>

<%@ include file="/init.jsp" %>
<liferay-ui:success key="entryAdded" message="Event added successfully." />
<liferay-ui:success key="entryUpdated" message="Event updated successfully."  />
<liferay-ui:success key="entryDeleted" message="Event deleted successfully." />
<liferay-ui:success key="entryDeleted1" message="Image deleted successfully." />

 <%
 	String languageId=themeDisplay.getLanguageId();
  String thName="Name";
  String thSno="S.No.";
  String thOfficeNo="Office No";
  String thDesignation="Title";
  if(languageId.equalsIgnoreCase("hi_IN")){
 	   thName="\u0928\u093E\u092E";
 	   thSno="\u0915\u094D\u0930\u092E \u0938\u0902\u0916\u094D\u092F\u093E";
 	   thOfficeNo="\u0906\u0927\u093F\u0915\u093E\u0930\u093F\u0915 \u0938\u0902\u092A\u0930\u094D\u0915 \u0938\u0902\u0916\u094D\u092F\u093E";
 	   thDesignation="\u0936\u0940\u0930\u094D\u0937\u0915";
  }
  PortletURL iteratorNewURL = renderResponse.createRenderURL(); 
  iteratorNewURL.setParameter("mvcPath", "/view.jsp");
  long cur = 1;
  long delta=1;
  int size=0;
  if(ParamUtil.getLong(request, "cur")!=0){
  	cur =ParamUtil.getLong(request, "cur");
  }
  if(ParamUtil.getLong(request, "delta")!=0){
  	delta =ParamUtil.getLong(request, "delta");
  }
  long Plid=themeDisplay.getPlid();
  long sNo=(delta * (cur-1))+1;
  List<Events> resultList=null;
  List<Events> downloadFormsList =null;
 	 System.out.println("Page ID"+ Plid);
  downloadFormsList =EventsLocalServiceUtil.getEventses(0, EventsLocalServiceUtil.getEventsesCount());
  size=downloadFormsList.size();
 %>
<portlet:renderURL var="createFormsURL">
	<portlet:param name="mvcPath" value="/addEvent.jsp"/>
</portlet:renderURL> 
<portlet:renderURL var="eventDetails">
	<portlet:param name="mvcPath" value="/eventdetails.jsp"/>
</portlet:renderURL> 

<%
 	if(Plid==4 || Plid==14){
 %>

<section id="event_section" style="padding:60px 0;">
  <div class="container">
      <div class="row d-flex align-items-start">
        <div class="col-lg-3 ">
          <h3 class="sub_heading"><liferay-ui:message key="EVENTS"/></h3>
          <p class="large_text"><liferay-ui:message key="evmessage"/></p>
          
          <p class="btn_margin"><a href="/eventlist?eventtype1=<%="Events"%>" class="blue_btn" target="_blank"><liferay-ui:message key="km"/></a></p>
        </div>
        <div class="col-lg-9">
           <section id="inner_event_section">
  			<div class="container">
				<div class="event_card homecard">
				<div class="owl-carousel owl-theme scroller">
         	<%
         		List<Events> eventLinks=null;
         	        		  DynamicQuery dq1 = EventsLocalServiceUtil.dynamicQuery(); 
         	                 // dq1.add(RestrictionsFactoryUtil.eq("eventtype", "Events"));
         	                  eventLinks = EventsLocalServiceUtil.dynamicQuery(dq1);

         	                  try {
         	                      eventLinks= EventsLocalServiceUtil.dynamicQuery(dq1, 0,
         	                      		EventsLocalServiceUtil.getEventsesCount());
         	                  } catch (Exception e) {
         	                      e.printStackTrace();
         	                  }
         	       int x=1;
         	  for(Events eventLink:eventLinks){
         		  String fileUrl=""; 
         		  long eventid=eventLink.getEventId();
         		  String title="";

  				if(languageId.equals("hi_IN")){
  		       		title=eventLink.getHi_title();
  		       	}
         				  
         				title=  eventLink.getTitle();
         		  String description=eventLink.getDescription();
         		  long fileEntryId=eventLink.getFileEntryId();
         		  String location=eventLink.getLocation();
         		  String startTime= eventLink.getStartTime();
         	      String endTime= eventLink.getEndTime(); 
         	      String heventtype=eventLink.getEventtype();
         	      String startDate="";
         	    	String endDate="";
         	    	String sd="";
         	    	String ed="";
         	    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
         		  if(fileEntryId!=0L){
         		try{
         			fileUrl =EventsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
         		}
         		catch(Exception e){
         			
         		}
         		  }
         		  try{	
         		Date dt = eventLink.getStartDate();
         		startDate = sdf.format(dt);
         		Date date = sdf.parse(startDate);
         		SimpleDateFormat outputFormat = new SimpleDateFormat("d'"
         		                + DateFor.getOrdinalSuffix(Integer.parseInt(startDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
         		sd=outputFormat.format(date);
         	
         			}catch(Exception e){
         		e.printStackTrace();
         			}
         		 
         		 try{	
         		Date dt = eventLink.getEndDate();
         		endDate = sdf.format(dt);
         		Date date1 = sdf.parse(endDate);
         		SimpleDateFormat outputFormat1 = new SimpleDateFormat("d'"
         		                + DateFor.getOrdinalSuffix(Integer.parseInt(endDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
         		ed=outputFormat1.format(date1);
         			}catch(Exception e){
         		e.printStackTrace();
         			}
         		 
         		
         		 
         		  String color="";
         		  if(x%4==0)
         			  color="green";
         		  else if(x%4==1)
         			  color="red";
         		  else if(x%4==2)
         			  color="yellow";
         		  else if(x%4==3)
         			  color="blue";
         	%> 
       	<div class="item"><div  class="card <%=color%>">
					<img src="<%=fileUrl %>" class="card-img-top" alt="...">
					<div class="card-body">
					  <h5 class="card-title">
					  <%if(title.length()>25){ %> 
				<%= title.substring(0, 25)+". . . " %>
			<% }else{ %><%= title %><% } %>
					  
					  </h5>
						<ul class="event_detailslist">
							<li class="time"><%=sd %> - <%=ed %></li>
							<li class="location"><a href="https://www.google.com/maps" target="_blank"><%=location %></a></li>
						</ul>

					</div>
					<p class="card-link " ><a href="/eventlist?eventId=<%=eventid%>&eventtype=<%=heventtype%>"><liferay-ui:message key="rm"/></a></p>
				  </div>
				</div>
			
  
<% x++; } %>

          	
  </div>
			   </div>
		  </div>
		  
 </section>
  </div>
 </div>
	  </div>
</section>
 
 <% }
 else if(role.equalsIgnoreCase("Departmentuser")){ %>

<link href="/o/com.kpmg.carouselImages/css/main.css" rel="stylesheet" />
<div class="createuser-page">
<div class="">
<div class="<% if(!role.equalsIgnoreCase("Departmentuser")){ %>  jhansiall-pagestwo <% } %>">

<div class="tenderspage-main">
	<div class="tendersdata-table">
		  <div class="col-md-12">
                <h1><span><liferay-ui:message key="Events"/></span></h1>
           </div>
         
		<div class="container">
		<% 
		if(role.equalsIgnoreCase("Departmentuser")){
			
			%>
					<div class="row">
	   					<div class="col-md-12" style="justify-content: flex-end;">
                           	<a href ="<%=createFormsURL %>" cssClass="btn btn-black btn-sm-block" >    
                           	<button type="button" style="width: auto;" class="btn btn-defaulter btn-createTender float-right">Add Events</button></a>
                           </div>
                      </div>
                      <% } %>
                      
			<div class="table-responsive">
		
	     		
	 <liferay-ui:search-container deltaConfigurable="true" delta="10" total="<%=size %>" emptyResultsMessage="No records found" iteratorURL="<%= iteratorNewURL %>" >			 
	<% try{
		resultList = ListUtil.subList(downloadFormsList, searchContainer.getStart(),searchContainer.getEnd());
	}catch(Exception e){
		e.printStackTrace();
	}
	%>
	
	 <liferay-ui:search-container-results results="<%=resultList %>"/> 
	 <liferay-ui:search-container-row className="com.kpmg.citizenTables.model.Events" keyProperty="eventId" modelVar="event">
		      		
				      	<% 
				      	long eventId =0L;
				      	String description ="";
				      	String title="";
				      	String startDate="";
				      	String endDate="";
				      	String startTime="";
				      	String endTime="";
				      	long fileEntryId=0L;
				      	String fileUrl="";
				      	String hi_title="";
				      	SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
				      	try{
				      	    eventId =event.getEventId();
				      		 
				      		description=event.getDescription();
				      		title=event.getTitle();
				      		hi_title=event.getHi_title();
				      		startTime= event.getStartTime();
				          	endTime= event.getEndTime(); 
				      		 if(languageId.equals("hi_IN")){
				      		 
				      			description=event.getHi_description();
				      		 }
				      		 try{	
				     			Date dt = event.getStartDate();
				     			startDate = sdf.format(dt);
				     		}catch(Exception e){
				     			e.printStackTrace();
				     		}
				     	 
				     	 try{	
				     			Date dt = event.getEndDate();
				     			endDate = sdf.format(dt);
				     		}catch(Exception e){
				     			e.printStackTrace();
				     		}
				      	//	hi_description=event.getHi_description();
				      		 
				      		 long fileEntryId1=event.getFileEntryId();
				      		  if(fileEntryId!=0L){
				      				try{
				      					fileUrl =EventsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
				      				}
				      				catch(Exception e){
				      					
				      				}
				      		  }
					      		
					      	  
			 }catch(Exception e){
				e.printStackTrace();
			}
		%>
		 

	  
		<% if(role.equalsIgnoreCase("Departmentuser")){ %>
		<liferay-ui:search-container-column-text name="<%=thSno %>" value="<%= String.valueOf(sNo++) %>" /> 
		<liferay-ui:search-container-column-text name="<%=thDesignation %>" value="<%= title %>" /> 
		<liferay-ui:search-container-column-text name="Title in Hindi" value="<%= hi_title %>" />
		<liferay-ui:search-container-column-text name="Start Date & Time" value="<%=startDate+" "+startTime %>"  /> 
		<liferay-ui:search-container-column-text name="End Date & Time" value="<%=endDate+" "+endTime %>"  /> 
		<liferay-ui:search-container-column-text name="Manage">
		<div>
			<a class="btn btn-primary m-0 hotooltip" onClick="updateRecord('<%=eventId %>');"><i class="fas fa-edit editicon"><span class="hotooltiptext"></span></i></a> 
			<a class="btn btn-primary m-0 hotooltip" onClick="return deleteRecord('<%=eventId %>');"><i class="fas fa-trash-alt deleteicon"><span class="hotooltiptext"></span></i></a>
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
</div></div></div>

<script>
function updateRecord(eventId){
	$('#<portlet:namespace />update').find('input[name=<portlet:namespace />eventId]').val(eventId);
	$("#<portlet:namespace />update").submit();
}
function deleteRecord(eventId){
	if(confirm('Are you sure you want to delete?')){
		$('#<portlet:namespace />delete').find('input[name=<portlet:namespace />eventId]').val(eventId);
		$('#<portlet:namespace />delete').submit();
	}
	else{
		return false;
	}
}
</script>
		<portlet:renderURL var="updateRecordURL">
			<portlet:param name="mvcPath" value="/addEvent.jsp"/> 
		</portlet:renderURL>
		 <portlet:actionURL var="deleteRecordURL" name="deleteEvents"> 
         </portlet:actionURL>
<aui:form name="update" method="post" action="<%=updateRecordURL %>" style="display:none;">
   <aui:input type="text" name="eventId" value=""></aui:input>
</aui:form>
<aui:form name="delete" method="post" action="<%=deleteRecordURL %>" style="display:none;">
   <aui:input type="text" name="eventId" value=""></aui:input>
</aui:form>
 <%}else if(Plid==44||Plid==31 || Plid==58){ 
 // Capacity Building
 %>
 <section class="top_innerBanner " style="margin-top: -60px !important;">
<div class="container top_bannerImg d-flex align-items-center flex-wrap">
			<div class="me-auto"><h1>Capacity Building</h1></div>
			<nav style="--bs-breadcrumb-divider: '>';">
			  <ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="/home">Home</a></li>
				<li class="breadcrumb-item active">Capacity Building</li>
			  </ol>
			</nav>
		</div>	
</section>

<!-- kpi section -->
<section class="counternumbers mt-0" data-aos="zoom-in" data-aos-duration="1000">
  <div class="container">
	  <div class="counter_content_individual">
		 <div class="owl-carousel owl-theme counter_carousel">
<% 
List<KPI> kpis=null;
String title1="";
long count =0L;
DynamicQuery dqs = KPILocalServiceUtil.dynamicQuery();
dqs.add(RestrictionsFactoryUtil.eq("type", "Capacity Building"));
  try{
	  kpis =KPILocalServiceUtil.dynamicQuery(dqs);
  }
  catch(Exception e){
	  e.getMessage();
  }
      
  for(KPI report:kpis){
	  title1=report.getTitle();
	  count = report.getKpiCount();
	  
	  if(languageId.equals("hi_IN")){ 
    		title1=report.getHi_title(); 
		 }
	 
       %> 
       		 
		<div class="item"><div class="counter_inner_individual">
			<div class="counter_value_individual"> <span class="value"><%=count %></span></div>
				<div class="counter_title_individual"><%=title1 %></div>
			</div>
		</div>
<% } %>			
		  </div>
		</div>			
	</div>
</section>

<main class="main_innerlayout">
	<section  >
  <div class="container">
  <div class="main_heading"><h1><liferay-ui:message key="OfflineTraining"/></h1></div>
<div id='calendar'></div>
</div>
</section>
	<%
	JSONArray jsonArray = JSONFactoryUtil.createJSONArray();
	JSONArray jsonArray1 = JSONFactoryUtil.createJSONArray();
	 Date todayDate1 = new Date();
    todayDate1.setHours(0);
    todayDate1.setMinutes(0);
    todayDate1.setSeconds(0);
    List<Events> eventLinksot1 = null;
    DynamicQuery dqot = EventsLocalServiceUtil.dynamicQuery(); 
    dqot.add(RestrictionsFactoryUtil.eq("eventtype", "Training"));
    dqot.add(RestrictionsFactoryUtil.eq("trainingpartner", "Offline Training"));
    eventLinksot1 = EventsLocalServiceUtil.dynamicQuery(dqot);
    try {
        eventLinksot1= EventsLocalServiceUtil.dynamicQuery(dqot, 0,
                EventsLocalServiceUtil.getEventsesCount());
    } catch (Exception e) {
        e.printStackTrace();
    }
    for(Events data:eventLinksot1) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
       	JSONObject jsonOb = JSONFactoryUtil.createJSONObject();
       	jsonOb.put("groupId", data.getEventId());
       	long evid=data.getEventId();
       	String str = data.getTitle();
        String languageId1=themeDisplay.getLanguageId();
        //System.out.println("Capacity Building Language Id:"+languageId1);
       	if(languageId1.equals("hi_IN")){
       		str=data.getHi_title();
       		System.out.println(str);
       	}
                  String startDate = ""; 
       	            String link="/eventlist?eventId="+evid+"&eventtype=Training";
           String endDate = ""; 
           String st="";
           String et="";
           String location=data.getLocation();
           String venue=data.getVenue();
           try{	
   			Date dt = data.getStartDate();
   			Date dt1 = data.getEndDate();
   			startDate = sdf.format(dt);
   			endDate=sdf.format(dt1);
   			String starttime=data.getStartTime();
   			String endtime=data.getEndTime();
   			 st=startDate.substring(0,10)+" "+starttime+":00.0";
   			 System.out.println(startDate);
   			System.out.println(st);
   		    et=endDate.substring(0,10)+" "+endtime+":00.0";
   			System.out.println(et);
   		}catch(Exception e){
   			e.printStackTrace();
   		}
           jsonOb.put("title",str);
           jsonOb.put("start",st);
           jsonOb.put("end",et);
           jsonOb.put("url",link);
           jsonOb.put("location",location);
           jsonOb.put("venue",venue);
           jsonArray.put(jsonOb);

           }
    		int sizehl=HolidaysListLocalServiceUtil.getHolidaysListsCount();
	List<HolidaysList> hl =HolidaysListLocalServiceUtil.getHolidaysLists(0, sizehl) ;
	for(HolidaysList data1:hl)
	{
		String color=data1.getColor();
		String title="";
				title=data1.getTitle();
				 String languageId2=themeDisplay.getLanguageId();
				if(languageId2.equals("hi_IN")){
		       		title=data1.getHi_title();
		       	}
		String startDate="";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date dt1=new Date();
		dt1 = data1.getStartDate();
		startDate = sdf.format(dt1);
		JSONObject jsonOb1 = JSONFactoryUtil.createJSONObject();
		System.out.println("Date In Holidays List:"+startDate);
		jsonOb1.put("title",title);
		jsonOb1.put("color",color);
		jsonOb1.put("start",startDate);
		jsonOb1.put("overlap","false");
		jsonOb1.put("display","background");
		jsonArray1.put(jsonOb1);
	}
   /*  System.out.println(eventLinksot1.size());
    System.out.println("JSON ARRAY Length:"+jsonArray.length());
    System.out.println(jsonArray.toString());
    System.out.println("Today Date:"+todayDate1); */
    
    // Start Date
    
    String newdate = new SimpleDateFormat("yyyy-MM-dd").format(todayDate1);
    
   // System.out.println("Formatted Date_____"+newdate);
	%>
	<script src='/o/com.kpmg.events/js/index.global.js'></script>
<script>
 /*  document.addEventListener('DOMContentLoaded', function() { */
    var calendarEl = document.getElementById('calendar');
   <%--  var jsonArrayString= '<%=jsonArray.toString()%>'
    var events= JSON.parse(jsonArrayString);  --%>
    var events1=<%=jsonArray.toString()%>;
    var holidays=<%=jsonArray1.toString()%>;
    console.log(events1);
    var date1="<%=newdate%>";
    console.log("date:"+date1);
  /*  var holidays = [
  	  {
            start: '2023-08-15',
            title: 'Independence Day',
            overlap: false,
            display: 'background',
            color: '#F1D302'
          },
          {
              start: '2023-01-26',
              title: 'Republic Day',
              overlap: false,
              title:'Republic Day',
              display: 'background',
              color: '#ff9f89'
            }
    ]; */
var allevents=events1.concat(holidays);
    var calendar = new FullCalendar.Calendar(calendarEl, {
      initialDate: date1,
      initialView: 'dayGridMonth',
      headerToolbar: {
        left: 'prev,next today',
        center: 'title',
        right: 'dayGridMonth,listWeek'
      },
      height: 'auto',
      navLinks: true,
      editable: true,
      selectable: true,
      selectMirror: true,
      dayMaxEvents: true,
      nowIndicator: true,
      businessHours: true,
      eventDidMount: function(info) {
          if (info.view.type === 'listWeek') {
              var event = info.event;
              var location = event.extendedProps.location; // Access the "location" field from extendedProps
              var venue=event.extendedProps.venue;
              var dayOfWeek=event.extendedProps.day;
              var eventElement = info.el.querySelector('.fc-list-event-title');
              if (eventElement) {
            	//  var dayIndex = info.event.start.getDay();
            	//  eventElement.classList.add('fc-list-event-title-color-' + dayIndex);
            //	var eventIndex=info.view.currentStart.diff(event.start,'days')%6;
            	//eventElement.classList.add('fc-list-event-title-color-' + (eventIndex+1));
            	/* var eventIndex=info.view.currentStart.diff(event.start,'days');
            	var colorIndex=eventIndex%6;
            	console.log(colorIndex);
            	eventElement.classList.add('fc-list-event-title-color-' + (colorIndex+1)); */
            	
            	  var eventIdentifier = event.start.toISOString() + event.start.toISOString()+event.title;
                  var hashCode = getHashCode(eventIdentifier);
                  var colorIndex = Math.abs(hashCode) % 7;
                  var colorClass = 'fc-list-event-title-color-' + (colorIndex + 1);

                  eventElement.classList.add(colorClass);
                  
                  
                  var locationElement = document.createElement('td');
                  locationElement.classList.add('fc-list-event-location');
                  locationElement.textContent = location;
                  eventElement.parentElement.insertBefore(locationElement, eventElement.nextSibling);
                  var venueElement = document.createElement('td');
                  venueElement.classList.add('fc-list-event-venue');
                  venueElement.textContent = venue;
                  eventElement.parentElement.insertBefore(venueElement, eventElement.nextSibling);
       
              }
          }
        
      },
   
      events: allevents
    });
    function getHashCode(str) {
        var hash = 0;
        if (str.length === 0) return hash;
        for (var i = 0; i < str.length; i++) {
            var char = str.charCodeAt(i);
            hash = (hash * 65599 + char) % 1000000; 
        }
        return hash;
    }
    calendar.render();
    console.log(events1);
/*   }); */
</script>
<style> 

  body {
    margin: 40px 10px;
    padding: 0;
    font-family: Arial, Helvetica Neue, Helvetica, sans-serif;
    font-size: 14px;
}
  #calendar {
    max-width: 1100px;
    margin: 0 auto;
  }
.fc-event-event-title{
font-weight: bold;
}
.fc-list-event-title-color-1 {
        color: #49C389;
        text-align: left;
        font-weight: bold;
    }

    .fc-list-event-title-color-2 {
        color: #4C8DDA;
        text-align: left;
        font-weight: bold;
    }

    .fc-list-event-title-color-3{
        color: #EE5743;
        text-align: left;
        font-weight: bold;
    }

    .fc-list-event-title-color-4 {
        color: #BD3275;
        text-align: left;
        font-weight: bold;
    }

    .fc-list-event-title-color-5{
        color: #DF3838;
        text-align: left;
        font-weight: bold;
    }

    .fc-list-event-title-color-6{
        color: #1D5094;
        text-align: left;
        font-weight: bold;
    }
    .fc-list-event-title-color-7{
        color: #660C4A;
        text-align: left;
        font-weight: bold;
    }

    .fc-list-event-venue {
        font-weight: bold;
    }
    .fc-list-event-location {
        font-weight: bold;
    }
    .fc-list-event-time{
    font-weight: bold;
    }
    
.fc .fc-daygrid-body-natural .fc-daygrid-day-events{ margin-bottom:0;}
.fc .fc-daygrid-body-unbalanced .fc-daygrid-day-events{ min-height:auto;}

.fc-scroller-harness tr th{ padding:20px; background: #2c3e50 !important; color: #fff; }
    .fc-event-main {border-left:5px solid #1A00FF; background: #ECE9F7;}
    .fc-direction-ltr .fc-daygrid-block-event:not(.fc-event-start), .fc-direction-rtl .fc-daygrid-block-event:not(.fc-event-end){ border-left-width:0px;}
    .fc-timegrid-event-harness-inset .fc-timegrid-event, .fc-timegrid-event.fc-event-mirror, .fc-timegrid-more-link{ box-shadow:0 !important;}
    .fc-timegrid-event{ border-radius:0;}
    .fc-timegrid-event-harness(n) .fc-v-event {background: pink !important;}
    .fc-timegrid-event-harness(3n) .fc-v-event {background: blue !important;}
    .fc-v-event(3n){background: green !important;}
    .fc-v-event(4n){background: purple !important;}
    .fc-v-event .fc-event-main, .fc-event-title{ font-weight:bold; color: #000;}
.fc-scroller-harness tr th a{color: #fff; }
</style>

<section class="light_bg my-0" style="padding: 60px 0;">
  <div class="container">
    <div class="row d-flex align-items-start">
      <div class="col-lg-3">
        <h3 class="sub_heading"><liferay-ui:message key="ONLINETRAINING"/></h3>
       <!--  <p class="large_text">Placeholder for text.</p> -->
      </div>
      <div class="col-lg-9">
        <div class="container online_training">
          <% 
          Date todayDate11 = new Date();
          todayDate11.setHours(0);
          todayDate11.setMinutes(0);
          todayDate11.setSeconds(0);
          List<Events> eventLinks1 = null;
          String sd="";
          DynamicQuery dq = EventsLocalServiceUtil.dynamicQuery(); 
          dq.add(RestrictionsFactoryUtil.eq("eventtype", "Training"));
          dq.add(RestrictionsFactoryUtil.eq("trainingpartner", "Online Training"));
          eventLinks1 = EventsLocalServiceUtil.dynamicQuery(dq);
          try {
              eventLinks1= EventsLocalServiceUtil.dynamicQuery(dq, 0,
                      EventsLocalServiceUtil.getEventsesCount());
          } catch (Exception e) {
              e.printStackTrace();
          }
          int totalItems = eventLinks1.size();
          for (Events eventLink : eventLinks1) {
        	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
              String title = eventLink.getTitle();
              long eid=eventLink.getEventId();
              String startDate = ""; 
              try{	
      			Date dt = eventLink.getStartDate();
      			startDate = sdf.format(dt);
      			Date date = sdf.parse(startDate);
         		SimpleDateFormat outputFormat = new SimpleDateFormat("d'"
         		                + DateFor.getOrdinalSuffix(Integer.parseInt(startDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
         		sd=outputFormat.format(date);
      		}catch(Exception e){
      			e.printStackTrace();
      		}
           //   System.out.println(startDate);
          %>
          <div class="card">
            <a href="#">
            <%=title %>
            </a>
            <div class="card-footer">
              <p class="d-flex align-items-center flex-wrap">
                <span class="me-auto"><%= sd%></span>
                <a onClick="viewRecords1('<%=eid %>');" class="arrow_button"><liferay-ui:message key="rm"/> <i class="fa-regular fa-chevrons-right"></i></a>
              </p>
            </div>
          </div>
          <% } %>
          <!-- End of JSP code replacement -->
        </div>
        <ul id="pagination" class="pagination justify-content-end">
          <!-- Pagination links will be dynamically added here -->
        </ul>
      </div>
    </div>
  </div>
</section>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function() {
    var initialItemsPerPage = 4; // Number of items to display on the first page
    var remainingItemsPerPage = 4; // Number of items to display on the remaining pages
    function showItems(page) {
      var itemsPerPage = (page === 1) ? initialItemsPerPage : remainingItemsPerPage;
      var startIndex = (page - 1) * itemsPerPage;
      var endIndex = startIndex + itemsPerPage;
      $(".online_training .card").hide();
      $(".online_training .card").slice(startIndex, endIndex).show();
    }
    function generatePagination() {
      var totalItems = $(".online_training .card").length; // Total number of items
      var totalPages = Math.ceil(totalItems / remainingItemsPerPage); // Calculate total number of pages
      var pagination = $("#pagination");
      pagination.empty();
      if (currentPage > 1) {
        pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (currentPage - 1) + '"><i class="fa-regular fa-chevrons-left"></i></a></li>');
      }
      else
	  {
	  pagination.append('<li class="page-item disabled"><a class="page-link" href="#"><i class="fa-regular fa-chevrons-left"></i></a></li>');
	  }
      for (var i = 1; i <= totalPages; i++) {
        var activeClass = (i === currentPage) ? "active" : "";
        pagination.append('<li class="page-item ' + activeClass + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>');
      }
      if (currentPage < totalPages) {
        pagination.append('<li class="page-item"><a class="page-link" href="#" data-page="' + (currentPage + 1) + '"><i class="fa-regular fa-chevrons-right"></i></a></li>');
      }
      else
	  {
	  pagination.append('<li class="page-item disabled"><a class="page-link" href="#"><i class="fa-regular fa-chevrons-right"></i></a></li>');
	  }
    }
    $("#pagination").on("click", ".page-link", function(e) {
      e.preventDefault();
      var page = parseInt($(this).data("page"));
      currentPage = page;
      showItems(currentPage);
      generatePagination();
    });
    var currentPage = 1;
    showItems(currentPage);
    generatePagination();
  });
</script>
 <section id="mediagallery_section" class="py-5 my-0">
    <div class="container">
        <div class="main_heading">
            <h1><liferay-ui:message key="MEDIAGALLERY&VIDEOS"/></h1>
        </div>
        <div class="row mediagallery_slider mediagallery_card">
            <% 
         //   ThemeDisplay themeDisplay = (ThemeDisplay) request.getAttribute(WebKeys.THEME_DISPLAY);
            Date todayDate = new Date();
            todayDate.setHours(0);
            todayDate.setMinutes(0);
            todayDate.setSeconds(0);
            List<Events> eventLinks = null;
            DynamicQuery dq1 = EventsLocalServiceUtil.dynamicQuery(); 
            dq1.add(RestrictionsFactoryUtil.eq("eventtype", "Training"));
            eventLinks = EventsLocalServiceUtil.dynamicQuery(dq1);

            try {
                eventLinks= EventsLocalServiceUtil.dynamicQuery(dq1, 0,
                		EventsLocalServiceUtil.getEventsesCount());
            } catch (Exception e) {
                e.printStackTrace();
            }

            int x = 1;
            for (Events eventLink : eventLinks) {
                if (x > 4) {
                    break;
                }  
                String color="";
          	  if(x%4==0)
          		  color="green";
          	  else if(x%4==1)
          		  color="red";
          	  else if(x%4==2)
          		  color="yellow";
          	  else if(x%4==3)
          		  color="blue";
                String eventtype=eventLink.getEventtype();
                System.out.println(eventtype);
                long eventid = eventLink.getEventId();
                List<YouTubeLinks> yl = YouTubeLinksLocalServiceUtil.findByeventId(eventid);
                List<GalleryDocuments> galleryDocumentsList = GalleryDocumentsLocalServiceUtil.findByeventId(eventid);
                String youtubelink="";
                if (galleryDocumentsList.size()>0) {
                    %>
                    <div class="col-md-4 col-lg-3 col-sm-12 p-2">	
                        <div class="card h-100 <%=color%>">
                            <div class="owl-carousel owl-theme mediagallery_scroller" uk-lightbox>
                                <% 
                                String eventtype1=eventLink.getEventtype();
                                String title = eventLink.getTitle();
                                String description = eventLink.getDescription();
                                String location = eventLink.getLocation();
                                String startTime = eventLink.getStartTime();
                                String endTime = eventLink.getEndTime();
                                String startDate = "";
                                String endDate = "";
                                String sd1="";
                                String ed="";
                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                try {	
                                    Date dt = eventLink.getStartDate();
                                    startDate = sdf.format(dt);
                                    Date date = sdf.parse(startDate);
                             		SimpleDateFormat outputFormat = new SimpleDateFormat("d'"
                             		                + DateFor.getOrdinalSuffix(Integer.parseInt(startDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
                             		sd1=outputFormat.format(date);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                try {	
                                    Date dt = eventLink.getEndDate();
                                    endDate = sdf.format(dt);
                                    Date date1 = sdf.parse(endDate);
                             		SimpleDateFormat outputFormat1 = new SimpleDateFormat("d'"
                             		                + DateFor.getOrdinalSuffix(Integer.parseInt(endDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
                             		ed=outputFormat1.format(date1);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }

                                for (GalleryDocuments galleryDoc : galleryDocumentsList) {  
                                    String fileUrl = ""; 
                                    long fileEntryId = galleryDoc.getFileEntryId();
                                    if (fileEntryId != 0L) {
                                        try {
                                            fileUrl =EventsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
                                        } catch (Exception e) {
                                            e.printStackTrace();
                                        }
                                    }
                                    %> 
                                    <div class="item">	
                                        <a class="uk-inline" href="<%=fileUrl %>">
                                            <img class="img-fluid img-thumbnail" src="<%=fileUrl %>" alt="">
                                        </a>
                                    </div>					    
                                <% } %>  
                                <%if(yl.size()>0){
	                                	    for (YouTubeLinks youtube : yl) {  
	    	                                    String fileUrl1 = ""; 
	    	                                   youtubelink=youtube.getYoutubelink();
	    	                                   String[] keys= youtubelink.split("=");
	    	   					            if(keys.length>1){
	    	   					    			 System.out.println("keys>>>"+keys[0]);
	    	   					    			 System.out.println("keys>>>"+keys[1]);
	    	   					    	    	 fileUrl1 =" https://img.youtube.com/vi/"+keys[1]+"/0.jpg";
	    	   					    	     }
	    	   					    	     else{
	    	   					    	    	  keys= youtubelink.split("/");
	    	   					    	    	  String key=keys[keys.length-1];
	    	   					    	    	  System.out.println("keys>>>"+key);
	    	   					    	    	  fileUrl1 =" https://img.youtube.com/vi/"+key+"/0.jpg";
	    	   					    	     }
	    	                                    %> 
	    	                                    <div class="item">	
	    	                                        <a class="uk-inline" href="<%=youtubelink %>">
	    	                                            <img class="img-fluid img-thumbnail" src="<%=fileUrl1 %>" alt="">
	    	                                        </a>
	    	                                    </div>					    
	    	                                <% } }%>  		
                            </div>		
                            <div class="card-body">
                                <h5 class="card-title">
                                <%if(title.length()>25){ %> 
				<%= title.substring(0, 25)+". . . " %>
			<% }else{ %><%= title %><% } %>
                                
                                </h5>
                                <ul class="event_detailslist">
                                    <li class="time"><%=sd1 %> - <%=ed %></li>
                                    <li class="location"><%=location %></li>
                                </ul>
                            </div>
                             <p class="card-link"><a href="/eventlist?eventId=<%=eventid%>&eventtype=<%=eventtype1%>"><liferay-ui:message key="rm"/></a></p>
                        </div>	
                    </div>
                    <% x++; %>
                <% }
            } %>
            <div class="col-lg-12 text-center"> <a href="/eventlist?eventtype1=<%="CapacityBuilding"%>" class="black_btn text-center" target="_blank"><liferay-ui:message key="ViewAll"/></a></div>
        </div>
    </div>
</section>
	
</main>
<% }else if(Plid==34||Plid==29){ 
	 // Infra Financing
	 %>
	 <section id="mediagallery_section" class="py-5 my-0">
	    <div class="container">
	        <div class="main_heading">
	            <h1><liferay-ui:message key="MEDIAGALLERY&VIDEOS"/></h1>
	        </div>
	        <div class="row mediagallery_slider mediagallery_card">
	            <% 
	            Date todayDate = new Date();
	            todayDate.setHours(0);
	            todayDate.setMinutes(0);
	            todayDate.setSeconds(0);
	            List<Events> eventLinks = null;
	            DynamicQuery idq1 = EventsLocalServiceUtil.dynamicQuery(); 
	            idq1.add(RestrictionsFactoryUtil.eq("eventtype","Gallery"));
	            
	            try {
	            	eventLinks = EventsLocalServiceUtil.dynamicQuery(idq1);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	            System.out.println("Size:"+eventLinks.size());
	            int x = 1;
	            for (Events eventLink : eventLinks) {
	                if (x > 4) {
	                    break;
	                }  
	                String color="";
	          	  if(x%4==0)
	          		  color="green";
	          	  else if(x%4==1)
	          		  color="red";
	          	  else if(x%4==2)
	          		  color="yellow";
	          	  else if(x%4==3)
	          		  color="blue";
	                String eventtype=eventLink.getEventtype();
	                System.out.println(eventtype);
	                long eventid = eventLink.getEventId();
	                List<GalleryDocuments> galleryDocumentsList = GalleryDocumentsLocalServiceUtil.findByeventId(eventid);
	                List<YouTubeLinks> yl = YouTubeLinksLocalServiceUtil.findByeventId(eventid);
	                if (galleryDocumentsList.size()>0) {
	                    %>
	                    <div class="col-md-4 col-lg-3 col-sm-12 p-2">	
	                        <div class="card h-100 <%=color%>">
	                            <div class="owl-carousel owl-theme mediagallery_scroller" uk-lightbox>
	                                <% 
	                                System.out.println("x value:"+x);
	                                String title = eventLink.getTitle();
	                                String description = eventLink.getDescription();
	                                String location = eventLink.getLocation();
	                                String startTime = eventLink.getStartTime();
	                                String endTime = eventLink.getEndTime();
	                                String startDate = "";
	                                String endDate = "";
	                                String youtubelink="";
	                                String sd="";
	                     	    	String ed="";
	                                SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
	                                String heventtype=eventLink.getEventtype();
	                                try {	
	                                    Date dt = eventLink.getStartDate();
	                                    startDate = sdf.format(dt);
	                                    Date date = sdf.parse(startDate);
	                             		SimpleDateFormat outputFormat = new SimpleDateFormat("d'"
	                             		                + DateFor.getOrdinalSuffix(Integer.parseInt(startDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
	                             		sd=outputFormat.format(date);
	                                } catch (Exception e) {
	                                    e.printStackTrace();
	                                }

	                                try {	
	                                    Date dt = eventLink.getEndDate();
	                                    endDate = sdf.format(dt);
	                                    Date date1 = sdf.parse(endDate);
	                             		SimpleDateFormat outputFormat1 = new SimpleDateFormat("d'"
	                             		                + DateFor.getOrdinalSuffix(Integer.parseInt(endDate.substring(8, 10))) + "' MMM''yy",Locale.ENGLISH);
	                             		ed=outputFormat1.format(date1);
	                                } catch (Exception e) {
	                                    e.printStackTrace();
	                                }

	                                for (GalleryDocuments galleryDoc : galleryDocumentsList) {  
	                                    String fileUrl = ""; 
	                                    long fileEntryId = galleryDoc.getFileEntryId();
	                                    if (fileEntryId != 0L) {
	                                        try {
	                                            fileUrl =EventsPortlet.getFile(fileEntryId, themeDisplay.getScopeGroupId());	  
	                                        } catch (Exception e) {
	                                            e.printStackTrace();
	                                        }
	                                    }
	                                    %> 
	                                    <div class="item">	
	                                        <a class="uk-inline" href="<%=fileUrl %>">
	                                            <img class="img-fluid img-thumbnail" src="<%=fileUrl %>" alt="">
	                                        </a>
	                                    </div>					    
	                                <% } %> 
	                                  <%if(yl.size()>0){
	                                	    for (YouTubeLinks youtube : yl) {  
	    	                                    String fileUrl1 = ""; 
	    	                                   youtubelink=youtube.getYoutubelink();
	    	                                   String[] keys= youtubelink.split("=");
	    	   					            if(keys.length>1){
	    	   					    			 System.out.println("keys>>>"+keys[0]);
	    	   					    			 System.out.println("keys>>>"+keys[1]);
	    	   					    	    	 fileUrl1 =" https://img.youtube.com/vi/"+keys[1]+"/0.jpg";
	    	   					    	     }
	    	   					    	     else{
	    	   					    	    	  keys= youtubelink.split("/");
	    	   					    	    	  String key=keys[keys.length-1];
	    	   					    	    	  System.out.println("keys>>>"+key);
	    	   					    	    	  fileUrl1 =" https://img.youtube.com/vi/"+key+"/0.jpg";
	    	   					    	     }
	    	                                    %> 
	    	                                    <div class="item">	
	    	                                        <a class="uk-inline" href="<%=youtubelink %>">
	    	                                            <img class="img-fluid img-thumbnail" src="<%=fileUrl1 %>" alt="">
	    	                                        </a>
	    	                                    </div>					    
	    	                                <% } }%> 
	                                	  
	                                	
	                            </div>		
	                            <div class="card-body">
	                                <h5 class="card-title"><%=title %></h5>
	                                <ul class="event_detailslist">
	                                    <li class="time"><%=sd %> - <%=ed %></li>
	                                    <li class="location"><%=location %></li>
	                                </ul>
	                            </div>
	                             <p class="card-link"><a href="/eventlist?eventId=<%=eventid%>&eventtype=<%=heventtype%>"><liferay-ui:message key="rm"/></a></p>
	                        </div>	
	                    </div>
	                    <% x++; %>
	                <% }
	            } %>
	            <div class="col-lg-12 text-center"> <a href="/eventlist?eventtype1=<%="InfraFinancing"%>" class="black_btn text-center" target="_blank"><liferay-ui:message key="ViewAll"/></a></div>
	        </div>
	    </div>
	</section>
	<% }
 
 else if(Plid==30||Plid==43){ %>
 <%@ include file="/eventslist.jsp" %>
 <%}
%>         
 <portlet:renderURL var="viewRecords1">
			<portlet:param name="mvcPath" value="/trainingDetails.jsp"/> 
		</portlet:renderURL>
		<script>
 function viewRecords1(eventId){
		$('#<portlet:namespace />views1').find('input[name=<portlet:namespace />eventId]').val(eventId);
		$("#<portlet:namespace />views1").submit();
	}
</script>
 <aui:form name="views1" method="post" action="<%=viewRecords1 %>" style="display:none;">
   <aui:input type="text" name="eventId" value=""></aui:input>
</aui:form> 