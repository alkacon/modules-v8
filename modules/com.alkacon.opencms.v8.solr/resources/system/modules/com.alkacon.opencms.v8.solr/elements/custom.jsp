<%@page session="false" taglibs="c,cms,fmt"%>
<div>
	<fmt:setLocale value="${cms.locale}" />
	<fmt:bundle basename="com.alkacon.opencms.v8.solr.messages">
		<form action="<cms:link>${cms.requestContext.uri}</cms:link>" method="post"> 
			<input type="text" name="query" value="*:*" />
			<input class="button" type="submit" value="<fmt:message key="v8.solr.search" />"/>
		</form><br/><br/>
		<div class="box ${cms.element.settings.boxschema}">
			<h4>Results</h4>
			<div class="boxbody">
				<cms:contentload collector="byQuery" param="<c:out value='${param.query}' default='*:*' />" preload="true">
					<cms:contentinfo var="info" />
					<c:if test="${info.resultSize > 0}">
						<cms:contentload editable="true">
							<cms:contentaccess var="resource" />
							<div class="boxbody_listentry">
								<c:set var="file" value="${resource.file}" />
								${file.rootPath}
							</div>
						</cms:contentload>
					</c:if>
				</cms:contentload>
			</div>
		</div>
	</fmt:bundle>
</div>
