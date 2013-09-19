<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="navStartLevel"><c:out value="${cms.element.settings.startlevel}" default="1" /></c:set>
<cms:navigation type="treeForFolder" startLevel="${navStartLevel}" endLevel="${navStartLevel + 2}" var="nav"/>
<div class="nav-side">
	<ul class="nav nav-tabs nav-stacked">			
		<c:set var="oldLevel" value="" />

		<c:forEach items="${nav.items}" var="elem">
			<c:set var="currentLevel" value="${elem.navTreeLevel}" />
			<c:choose>
				<c:when test="${empty oldLevel}"></c:when>
				<c:when test="${currentLevel > oldLevel}"><ul class="nav"></c:when>
				<c:when test="${currentLevel == oldLevel}"></li></c:when>
				<c:when test="${oldLevel > currentLevel}">
					<c:forEach begin="${currentLevel + 1}" end="${oldLevel}"></li></ul></c:forEach></li>
				</c:when>
			</c:choose>
			<li<c:if test="${!elem.navigationLevel && nav.isActive[elem.resourceName]}"> class="active"</c:if>><a href="<cms:link>${elem.resourceName}</cms:link>">${elem.navText}</a>
			<c:set var="oldLevel" value="${currentLevel}" />
		</c:forEach>

		<c:forEach begin="${navStartLevel}" end="${oldLevel}"></li></ul></c:forEach>
		<c:if test="${not empty nav.items}"></li></c:if>
	</ul>
</div>