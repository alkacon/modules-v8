<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="serachPage">${cms.functionDetail['Search page']}</c:set>
<%
	org.opencms.file.CmsObject cmsObject = new org.opencms.jsp.CmsJspActionElement(pageContext, request, response).getCmsObject();
	String siteRoot = cmsObject.getRequestContext().getSiteRoot();
	String searchLink = org.opencms.main.OpenCms.getLinkManager().getRootPath(cmsObject, (String) pageContext.getAttribute("serachPage"));
	String onlineLink = org.opencms.main.OpenCms.getLinkManager().getOnlineLink(cmsObject, searchLink);
%>
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