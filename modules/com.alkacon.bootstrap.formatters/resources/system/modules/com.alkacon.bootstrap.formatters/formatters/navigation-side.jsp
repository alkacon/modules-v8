<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
<div>
	<c:set var="navStartLevel">${value.NavStartLevel.stringValue}</c:set>
	<cms:navigation type="treeForFolder" startLevel="${navStartLevel}" endLevel="${navStartLevel + 2}" var="nav"/>
	<ul class="nav-side list-group sidebar-nav-v1">			
		<c:forEach items="${nav.items}" var="elem">
			<li class="nav-side-level-${elem.navTreeLevel - navStartLevel} list-group-item<c:if test="${!elem.navigationLevel && nav.isActive[elem.resourceName]}"> active</c:if>"><a href="<cms:link>${elem.resourceName}</cms:link>">${elem.navText}</a></li>
		</c:forEach>
	</ul>
</div>
</cms:formatter>