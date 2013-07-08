<%@page buffer="none" session="false" taglibs="c,cms,fn" %>
<c:set var="navStartLevel" ><cms:property name="NavStartLevel" file="search" default="0" /></c:set>
<cms:navigation type="forFolder" startLevel="${navStartLevel}" var="nav"/>
<div id="nav_main" class="gradient">
<c:if test="${not empty nav.items}">
	<ul>
		<c:forEach items="${nav.items}" var="elem">
		<li>
			<a href="<cms:link>${elem.resourceName}</cms:link>" <c:choose><c:when test="${fn:startsWith(cms.requestContext.uri, elem.navigationLevel ? elem.parentFolderName :  elem.resourceName)}">class="gradient current"</c:when><c:otherwise>class="gradient"</c:otherwise></c:choose>>${elem.navText}</a>
		</li>
		</c:forEach>
	</ul>
</c:if>
</div>