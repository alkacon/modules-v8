<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="org.opencms.jsp.CmsJspActionElement,org.opencms.file.CmsRequestContext,org.opencms.main.OpenCms"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%><%
	CmsJspActionElement jae = new  CmsJspActionElement(pageContext, request, response);
	CmsRequestContext con = jae.getCmsObject().getRequestContext();
	String glo = con.addSiteRoot("/.content/");
	String onlineLink = OpenCms.getLinkManager().getOnlineLink(jae.getCmsObject(), con.getUri()); %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.newsarticle" />

<cms:formatter var="function" rdfa="rdfa">

	<div <c:if test="${cms.container.type == 'content-full'}"> class="row"</c:if>>
		<div id="alkaconSolrSearch" class="lists margin-bottom-20">
			<script type="text/javascript">
				var GWTsolrContextInformation = {
				        "onlineURL"    : "<%= onlineLink %>",
				        "rootSite"     : "<%= con.getSiteRoot() %>",
				        "globalPath"   : "<%= con.getSiteRoot() + "/demo/" %>",
				        "subSitePath"  : "<%= con.getSiteRoot() %><c:out value='${cms.subSitePath}' />",
				        "initialQuery" : "" + encodeURI('${cms.element.settings.restoreQuery}') + "",
				        "searchQuery"  : "<c:out escapeXml='true' value='${param.solrWidgetAutoCompleteHeader}' />",
				        "isDoccenter"  : <c:out value="${cms.element.settings.mode ne 'web'}"/>,
				        "addtionalFL" : ["content_de","content_en"]
				}
			</script>
			<div class="row margin-bottom-20">
				<div class="col-md-4">
					<div id="solrWidgetAutoComplete"></div>
					<div id="leftCol">
						<div class="margin-bottom-20"></div>
						<div id="solrWidgetTextFacet"></div>
						<div id="solrWidgetAdvisorButton"></div>
						<div id="solrWidgetResetFacets"></div>
					</div>
				</div>
				<div class="col-md-8">
					<div id="loading">
						<img src="<cms:link>/system/modules/com.alkacon.bootstrap.solr/resources/images/ajax-loader.gif</cms:link>" title="loading ..." alt="Loading, please wait." />
						<p>loading</p>
					</div>
					<div id="rightCol">
						<div id="solrWidgetShareResult"></div>
						<div id="solrWidgetSortBar"></div>
						<div class="row margin-bottom-20"></div>
						<div id="solrWidgetResultCount"></div>
						<div id="solrWidgetResultList"></div>
						<div id="solrWidgetResultPagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>

</cms:formatter>
