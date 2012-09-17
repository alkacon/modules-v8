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
				<cms:resourceload collector="byQuery" param="${param.query}" preload="true">
					<cms:contentinfo var="info" />
					<c:if test="${info.resultSize > 0}">
						<cms:resourceload editable="true">
							<cms:resourceaccess var="resource" />
							<div class="boxbody_listentry">
								<div class="twocols">
									<div><span>Name:</span><span>${resource.name}</span></div>
									<div><span>Root Path:</span><span>${resource.rootPath}</span></div>
									<div><span>Structure Id:</span><span>${resource.structureId}</span></div>
									<div><span>Resource Id:</span><span>${resource.resourceId}</span></div>
									<div><span>Type Id:</span><span>${resource.typeId}</span></div>
									<div><span>User Created:</span><span>${resource.userCreated}</span></div>
									<div><span>User Last Modified:</span><span>${resource.userLastModified}</span></div>
									<div><span>Date Content:</span><span>${resource.dateContent}</span></div>
									<div><span>Date Created:</span><span>${resource.dateCreated}</span></div>
									<div><span>Date Last Modified:</span><span>${resource.dateLastModified}</span></div>
									<div><span>Date Released:</span><dspan>${resource.dateReleased}</span></div>
									<div><span>Length:</span><span>${resource.length}</span></div>
									<div><span>Project Last Modified:</span><span>${resource.projectLastModified}</span></div>
									<div><span>Sibling Count:</span><span>${resource.siblingCount}</span></div>
									<div><span>Version:</span><span>${resource.version}</span></div>
								</div>
							</div>
						</cms:contentload>
					</c:if>
				</cms:contentload>
			</div>
		</div>
	</fmt:bundle>
</div>
