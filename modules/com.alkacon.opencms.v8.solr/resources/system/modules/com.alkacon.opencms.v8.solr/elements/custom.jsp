<%@page session="false" taglibs="c,cms,fmt" import="org.opencms.main.OpenCms"%>
<div>
	<link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/reuters.css:cd946db3-f687-11e1-b6b3-058770d8fd70)</cms:link>" media="screen"/>
	<fmt:setLocale value="${cms.locale}" />
	<fmt:bundle basename="com.alkacon.opencms.v8.solr.messages">
		<c:choose>
			<c:when test="${cms.element.inMemoryOnly} || ${cms.edited}">
				<fmt:message key="v8.solr.reload" />
			</c:when>
			<c:otherwise>
				<form action="<cms:link>${cms.requestContext.uri}</cms:link>" method="post" class="searchForm"> 
					<input type="text" name="query"  />
					<input class="button" type="submit" value="<fmt:message key="v8.solr.search" />"/>
				</form>
				<div class="box ${cms.element.settings.boxschema} results">
					<c:set var="query" value="${param.query}" />
					<c:if test="${!empty query}">
						<cms:resourceload collector="byQuery" param="${query}" preload="true">
							<cms:contentinfo var="info" />
							<c:if test="${info.resultSize > 0}">
								<h4><fmt:message key="v8.solr.results" /></h4>
								<div class="boxbody">
									<cms:resourceload>
										<cms:resourceaccess var="res" />
										<c:set var="resource" value="${res.resource}" />
										<c:set var="typeId" value="${resource.typeId}" />
										<c:set var="typeName"><%= OpenCms.getResourceManager().getResourceType(pageContext.getAttributesScope("typeId")).getTypeName() %></c:set>
										<div class="boxbody_listentry">
											<div class="twocols">
												<div><strong>${res.readProperties['Title']}</strong> [ <fmt:message key="v8.solr.type" />: ${typeName}, <fmt:message key="v8.solr.modified" />: <fmt:formatDate value="${cms:convertDate(resource.dateLastModified)}" dateStyle="SHORT" timeStyle="SHORT" type="both" />, <fmt:message key="v8.solr.size" />: ${res.file.length} Bytes ]</div>
												<div><strong><fmt:message key="v8.solr.path" />:</strong> ${resource.rootPath}</div>
											</div>
										</div>
									</cms:resourceload>
								</div>
							</c:if>
						</cms:resourceload>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
	</fmt:bundle>
</div>
