<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<cms:formatter var="con" rdfa="rdfa">
	<div>
		<div class="headline"><h3 ${rdfa.Title}><c:out value="${con.value.Title}" escapeXml="false" /></h3></div>
		<%-- Define a Solr query --%>
		<c:set var="solrQuery">&fq=type:ddarticle&sort=lastmodified desc</c:set>
		<%-- Define a create path --%>
		<c:set var="createPath">/dev-demo/collector-with-detail-page/.content/articles/</c:set>
		<%-- Collect the resources --%>
		<cms:contentload collector="byContext" param="${solrQuery}|createPath=&{createPath}" preload="true" >
			<cms:contentinfo var="info" />
			<c:if test="${info.resultSize > 0}">
				<cms:contentload editable="true">
					<cms:contentaccess var="content" />
					<div>
						<h4><a href="<cms:link>${content.filename}</cms:link>">${content.value.Title}</a></h4>
						<p>${content.value.Text}</p>
					</div>
				</cms:contentload>
			</c:if>
			<c:if test="${info.resultSize == 0}">
				Nothing found for query:<br/><em>${solrQuery}</em>
			</c:if>
		</cms:contentload>
	</div>
</cms:formatter>