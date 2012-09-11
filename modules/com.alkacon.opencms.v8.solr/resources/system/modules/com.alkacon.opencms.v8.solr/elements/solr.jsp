<%@page buffer="none" session="false" taglibs="c,cms,fmt" import="org.opencms.main.OpenCms, org.opencms.jsp.CmsJspActionElement" %>
<div class="wrap">
  <script type="text/javascript">
  	var solrRequestHandler = "handleSolrSelect";
  	var opencmsServlet = "<%= OpenCms.getLinkManager().getOnlineLink(new CmsJspActionElement(pageContext, request, response).getCmsObject() , "/") %>";
  	var opencmsLocale = "${cms.requestContext.locale}";
  </script>
  <fmt:setLocale value="${cms.locale}" />
  <fmt:bundle basename="com.alkacon.opencms.v8.solr.messages">
  <link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/jquery-ui-1.8.23.custom.css)</cms:link>" media="screen"/>
  <link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/jquery.autocomplete.css)</cms:link>" media="screen"/>
  <link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/reuters.css)</cms:link>" media="screen"/>
  <script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/com.alkacon.opencms.v8.solr.scripts.js)</cms:link>"></script>
  <script type="text/javascript" src="<cms:link>/system/modules/com.alkacon.opencms.v8.solr/resources/messages_${cms.requestContext.locale}.js</cms:link>"></script>
  <div class="right">
    <div id="result">
      <div id="navigation">
        <ul id="pager"></ul>
        <div id="pager-header"></div>
      </div>
      <div id="docs"></div>
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
