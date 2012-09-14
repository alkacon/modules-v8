<%@page buffer="none" session="false" taglibs="c,cms,fmt" import="org.opencms.main.OpenCms, org.opencms.jsp.CmsJspActionElement" %>
<div class="wrap">
  <fmt:setLocale value="${cms.locale}" />
  <fmt:bundle basename="com.alkacon.opencms.v8.solr.messages">
  <script type="text/javascript">
  	var solrRequestHandler = "handleSolrSelect";
  	var opencmsServlet = "<%= OpenCms.getLinkManager().getOnlineLink(new CmsJspActionElement(pageContext, request, response).getCmsObject() , "/") %>";
  	var opencmsLocale = "${cms.locale}";
	var GUI_PREV_0                           ="<fmt:message key="v8.solr.previous" />";
	var GUI_NEXT_0                           ="<fmt:message key="v8.solr.next" />";
	var GUI_DOCUMENTS_FOUND_0                ="<fmt:message key="v8.solr.documents.found" />";
	var GUI_MORE_0                           ="<fmt:message key="v8.solr.more" />";
	var GUI_LESS_0                           ="<fmt:message key="v8.solr.less" />";
	var GUI_NO_ITEMS_FOUND_0                 ="<fmt:message key="v8.solr.noitems" />";
	var GUI_NO_CONTENT_AVAILABLE_0           ="<fmt:message key="v8.solr.nocontent" />";
	var GUI_TAGS_LABEL_0                     ="<fmt:message key="v8.solr.facats" />";
	var GUI_VIEWING_ALL_DOCS_0               ="<fmt:message key="v8.solr.alldocs" />";
	var GUI_REMOVE_ALL_FACETS_0              ="<fmt:message key="v8.solr.remove" />";
	var GUI_DATE_FORMAT_0                    ="<fmt:message key="v8.solr.dateFormat" />";
  </script>
  <link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/jquery-ui-1.8.23.custom.css:cd961b66-f687-11e1-b6b3-058770d8fd70)</cms:link>" media="screen"/>
  <link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/jquery.autocomplete.css:cd9298f0-f687-11e1-b6b3-058770d8fd70)</cms:link>" media="screen"/>
  <link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/reuters.css:cd946db3-f687-11e1-b6b3-058770d8fd70)</cms:link>" media="screen"/>
  <script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/com.alkacon.opencms.v8.solr.scripts.js:cd98da89-f687-11e1-b6b3-058770d8fd70)</cms:link>"></script>
  <div class="right box box_schema3">
    <div id="result">
      <h4><fmt:message key="v8.solr.results"/>:&nbsp;<div id="pager-header"></div></h4>
        <div id="docs" class="boxbody"></div>
		<ul id="pager"></ul>
    </div>
  </div>
  <div class="left">
    <h2><fmt:message key="v8.solr.currentSelection"/></h2>
    <ul id="selection"></ul>
    <h2><fmt:message key="v8.solr.searchField"/></h2>
    <span id="search_help"><fmt:message key="v8.solr.stopSuggesting"/></span>
    <ul id="search">
      <input type="text" id="query" name="query"/>
    </ul>
    <h2><fmt:message key="v8.solr.category"/></h2>
    <div class="tagcloud" id="category_exact"></div>
    <h2><fmt:message key="v8.solr.type"/></h2>
    <div class="tagcloud" id="type"></div>
    <h2><fmt:message key="v8.solr.languages"/></h2>
    <div class="tagcloud" id="res_locales"></div>
    <h2><fmt:message key="v8.solr.lastUpdate"/></h2>
    <div id="calendar"></div>
    <div class="clear"></div>
  </div>
  <div class="clear"></div>
  </fmt:bundle>
</div>
