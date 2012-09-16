<%@page session="false" taglibs="c,cms,fmt"%>
<div>
	<link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/reuters.css:cd946db3-f687-11e1-b6b3-058770d8fd70)</cms:link>" media="screen"/>
	<fmt:setLocale value="${cms.locale}" />
	<fmt:bundle basename="com.alkacon.opencms.v8.solr.messages">
		<form action="<cms:link>${cms.requestContext.uri}</cms:link>" method="post"> 
			<input type="text" name="query"  />
			<input class="button" type="submit" value="<fmt:message key="v8.solr.search" />"/>
		</form><br/><br/>
		<div class="box ${cms.element.settings.boxschema}">
			<h4>Results</h4>
			<div class="boxbody">
				<cms:contentload collector="byQuery" param="${param.query}" preload="true">
					<cms:contentinfo var="info" />
					<c:if test="${info.resultSize > 0}">
						<cms:contentload editable="true">
							<cms:contentaccess var="resource" />
							<div class="boxbody_listentry">
								<c:set var="file" value="${resource.file}" />
								<div class="twocols">
									<div><span>Name:</span><span>${file.name}</span></div>
									<div><span>Root Path:</span><span>${file.rootPath}</span></div>
									<div><span>Structure Id:</span><span>${file.structureId}</span></div>
									<div><span>Resource Id:</span><span>${file.resourceId}</span></div>
									<div><span>Type Id:</span><span>${file.typeId}</span></div>
									<div><span>User Created:</span><span>${file.userCreated}</span></div>
									<div><span>User Last Modified:</span><span>${file.userLastModified}</span></div>
									<div><span>Date Content:</span><span>${file.dateContent}</span></div>
									<div><span>Date Created:</span><span>${file.dateCreated}</span></div>
									<div><span>Date Last Modified:</span><span>${file.dateLastModified}</span></div>
									<div><span>Date Released:</span><span>${file.dateReleased}</span></div>
									<div><span>Length:</span><span>${file.length}</span></div>
									<div><span>Project Last Modified:</span><span>${file.projectLastModified}</span></div>
									<div><span>Sibling Count:</span><span>${file.siblingCount}</span></div>
									<div><span>Version:</span><span>${file.version}</span></div>
								</div>
							</div>
						</cms:contentload>
					</c:if>
				</cms:contentload>
			</div>
		</div>
	</fmt:bundle>
</div>
