<%@page buffer="none" session="false" taglibs="c,cms"%><c:set var="serachPage">${cms.functionDetail['Search page']}</c:set><%
org.opencms.file.CmsObject cmsObject = new org.opencms.jsp.CmsJspActionElement(pageContext, request, response).getCmsObject();
String siteRoot = cmsObject.getRequestContext().getSiteRoot();
String searchLink = org.opencms.main.OpenCms.getLinkManager().getRootPath(cmsObject, (String) pageContext.getAttribute("serachPage"));
String onlineLink = org.opencms.main.OpenCms.getLinkManager().getOnlineLink(cmsObject, searchLink);
%>
<script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/dictionary.js:d2f20f93-1370-11e2-b821-2b1b08a6835d)</cms:link>"></script>
<script type="text/javascript" src="<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.formatters/search/configuration.js:e3fb6d55-0e64-11e2-8968-2b1b08a6835d)</cms:link>"></script>
<script type="text/javascript">
    var GWTsearchContextInformation = {
        "onlineURL"    : "<%= onlineLink %>",
        "rootSite"     : "<%= siteRoot %>",
        "globalPath"   : "<%= siteRoot + "/demo/" %>",
        "subSitePath"  : "<%= siteRoot %><c:out value='${cms.subSitePath}' />",
        "initialQuery" : "" + encodeURI('${cms.element.settings.restoreQuery}') + "",
        "searchQuery"  : "<c:out escapeXml='true' value='${param.searchWidgetAutoCompleteHeader}' />",
        "isDoccenter"  : <c:out value="${cms.element.settings.mode ne 'web'}"/>,
        "addtionalFL" : ["content_de","content_en"]
    }
</script>
<%= org.opencms.gwt.CmsGwtActionElement.createNoCacheScript("search", "9.0.0") %>