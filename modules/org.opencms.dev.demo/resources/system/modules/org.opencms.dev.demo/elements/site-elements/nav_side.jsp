<%@page buffer="none" session="false" taglibs="c,cms,fn" %>
<%-- Read the navigation start level from property. --%>
<c:set var="navStartLevel" ><cms:property name="NavStartLevel" file="search" default="0" /></c:set>

<%-- Use cms:navigation tag to build the navigation tree for folder. --%>
<cms:navigation type="treeForFolder" startLevel="${navStartLevel + 1}" endLevel="${navStartLevel + 4}" var="nav"/>
<div id="nav_left">
	<ul>			
		<c:set var="oldLevel" value="" />
		<%-- Iterate over the navigation elements to generate the navigation menu. --%>		
		<c:forEach items="${nav.items}" var="elem">
			
			<%-- Open or close the html list tags depending on the level of the navigation element in current iteration. --%>
			<c:set var="currentLevel" value="${elem.navTreeLevel}" />
			<c:choose>
				<c:when test="${empty oldLevel}"></c:when>
				<c:when test="${currentLevel > oldLevel}"><ul></c:when>
				<c:when test="${currentLevel == oldLevel}"></li></c:when>
				<c:when test="${oldLevel > currentLevel}">
					<c:forEach begin="${currentLevel+1}" end="${oldLevel}"></li></ul></c:forEach></li>
				</c:when>
			</c:choose>
			<%-- Entry in the navigation. --%>
			<%-- ${nav.isActive[elem.resourceName]} indicated, if the navigation element of the iteration was clicked(selected) by user. --%>
			<%-- ${elem.navigationLevel} indicates if navigation element of the iteration is a navigation entry resource. --%>					
			<li><a href="<cms:link>${elem.resourceName}</cms:link>" <c:if test="${nav.isActive[elem.resourceName] and !elem.navigationLevel }">class="current"</c:if>>${elem.navText}</a>
			
			<c:set var="oldLevel" value="${currentLevel}" />
		</c:forEach>
		
		<%-- Close all html list tags. --%>
		<c:forEach begin="${navStartLevel}" end="${oldLevel}"></li></ul></c:forEach>
		<c:if test="${not empty nav.items}"></li></c:if>
	</ul>
</div>