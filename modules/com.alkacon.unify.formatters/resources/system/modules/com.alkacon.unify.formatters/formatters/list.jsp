<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" import="org.opencms.i18n.CmsEncoder" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.formatters.list">

<cms:formatter var="con" rdfa="rdfa">

	<c:set var="solrParamType">fq=type:${(con.value.TypesToCollect eq "both") ? "u-blog OR u-event" : ((con.value.TypesToCollect eq "event") ? "u-event" : "u-blog")}</c:set>
	<c:set var="solrParamDirs">&fq=parent-folders:\"/sites/default${cms.subSitePath}\"</c:set>
	<c:set var="solrFilterQue">${con.value.FilterQueries}</c:set>
	<c:set var="sortOptionAsc">{ "label" : %(key.sortorder.asc), "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
	<c:set var="sortOptionDesc">{ "label" : %(key.sortorder.desc), "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>
    <c:set var="itemsPerPage"><c:out value="${con.value.ItemsPerPage}" default="100"/></c:set>
	<div>
		${cms.reloadMarker}
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><h3><fmt:message key="unify.list.message.new" /></h3></div>
		</c:when>
		<c:when test="${cms.edited}">
			<div class="alert"><h3><fmt:message key="unify.list.message.edit" /></h3></div>
		</c:when>
		<c:otherwise>
				<c:if test="${not cms.element.settings.hidetitle}">
					<div class="headline headline-md"><h2 ${rdfa.Headline}><c:out value="${con.value.Headline}" escapeXml="false" /></h2></div>
				</c:if>			
	
				<c:set var="innerPageDivId">${cms.element.id}-inner</c:set>
				<c:set var="linkInnerPage"><cms:link>%(link.strong:/system/modules/com.alkacon.unify.formatters/elements/list-inner.jsp:5ca5be42-5cff-11e5-96ab-0242ac11002b)</cms:link></c:set>
				<c:set var="additionalFilterQueries">${con.value.FilterQueries}</c:set>
				<c:set var="linkInnerPage">${linkInnerPage}?typesToCollect=${con.value.TypesToCollect}&pathes=\"/sites/default${cms.subSitePath}\"&itemsPerPage=${itemsPerPage}&teaserLength=${teaserLength}</c:set>
				<c:set var="linkInnerPage">${linkInnerPage}&extraQueries=<%=CmsEncoder.encode((String) pageContext.getAttribute("additionalFilterQueries"))%>&__locale=${cms.locale}&sortOrder=${con.value.SortOrder}&pageUri=${cms.requestContext.uri}</c:set>
				<div id="${innerPageDivId}" class="posts lists blog-item">
					<cms:include file="%(link.strong:/system/modules/com.alkacon.unify.formatters/elements/list-inner.jsp:5ca5be42-5cff-11e5-96ab-0242ac11002b)">
						<cms:param name="typesToCollect">${con.value.TypesToCollect}</cms:param>
						<cms:param name="pathes">"/sites/default${cms.subSitePath}"</cms:param>
						<cms:param name="itemsPerPage">${itemsPerPage}</cms:param>
						<cms:param name="teaserLength">${teaserLength}</cms:param>
						<cms:param name="extraQueries">${con.value.FilterQueries}</cms:param>
						<cms:param name="__locale">${cms.locale}</cms:param>
						<cms:param name="sortOrder">${con.value.SortOrder}</cms:param>
						<cms:param name="pageUri">${cms.requestContext.uri}</cms:param>
					</cms:include>
				</div>
				<script type="text/javascript">
					function reloadInnerList(searchStateParameters) {
						$.get("${linkInnerPage}&".concat(searchStateParameters), function(resultList) {
							$("#${innerPageDivId}").html( resultList );
						});
					}
				</script>
		</c:otherwise>
	</c:choose>
	</div>
</cms:formatter>
</cms:bundle>