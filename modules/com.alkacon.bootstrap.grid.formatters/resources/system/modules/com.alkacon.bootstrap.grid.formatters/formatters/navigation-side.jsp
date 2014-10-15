<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
<div>
  <c:set var="subIdCounter">1</c:set>
	<c:set var="pathparts" value="${fn:split(cms.requestContext.folderUri, '/')}" />
  <c:set var="navStartLevel">${param.startlevel + 1}</c:set>
  <c:set var="navStartFolder" value="/" />
  <c:forEach var="folderName" items="${pathparts}" varStatus="status">
	 <c:if test="${status.count <= navStartLevel}">
		<c:set var="navStartFolder">${navStartFolder}${folderName}/</c:set>
	 </c:if>
  </c:forEach>
  <cms:navigation type="forSite" resource="${navStartFolder}" startLevel="${navStartLevel}" endLevel="${navStartLevel + 2}" var="nav"/>
  <ul class="list-group sidebar-nav-v1 nav-side" id="sidebar-nav">
	<c:set var="oldLevel" value="" />
	<c:forEach items="${nav.items}" var="elem" varStatus="status">
		<c:set var="currentLevel" value="${elem.navTreeLevel}" />

		<c:choose>
			<c:when test="${empty oldLevel}"></c:when>
			<c:when test="${currentLevel > oldLevel}"><ul class="collapse" id="collapse-${subIdCounter}"><c:set var="subIdCounter">${subIdCounter + 1}</c:set></c:when>
			<c:when test="${currentLevel == oldLevel}"></li></c:when>
			<c:when test="${oldLevel > currentLevel}">
				<c:forEach begin="${currentLevel + 1}" end="${oldLevel}"></li></ul></c:forEach>
			</c:when>
		</c:choose>

		<c:set var="markItem">false</c:set>
		<c:if test="${fn:startsWith(cms.requestContext.uri, elem.resourceName) || (elem.navigationLevel && fn:startsWith(cms.requestContext.uri, elem.parentFolderName))}">
			<c:set var="markItem">true</c:set>
		</c:if>

		<c:set var="listClass" value="" />
    <c:set var="parentItem">false</c:set>
		<c:if test="${currentLevel == navStartLevel}">
			<c:set var="parentItem">true</c:set>
      <c:set var="listClass">list-group-item</c:set>
		</c:if>

		<c:if test="${markItem}">
      <c:choose>
        <c:when test="${parentItem}"><c:set var="listClass">list-group-item active</c:set></c:when>
        <c:otherwise><c:set var="listClass">active</c:set></c:otherwise>
      </c:choose>
		</c:if>

    <c:set var="nextElemDeeper">false</c:set>
		<c:if test="${not status.last}">
			<c:forEach items="${nav.items}" var="nextelem" varStatus="nextstatus">
				<c:if test="${nextstatus.count eq (status.count + 1) and nextelem.navTreeLevel > currentLevel}">
						  <c:set var="nextElemDeeper">true</c:set>
              <c:set var="listClass">list-group-item list-toggle</c:set> 
              <c:if test="${markItem}">
                       <c:set var="listClass">${listClass} active</c:set>
              </c:if>  
				</c:if>
			</c:forEach>
		</c:if>

		<li class="${listClass} nav-side-level-${elem.navTreeLevel - navStartLevel}">
		<a <c:choose><c:when test="${nextElemDeeper}">class="accordion-toggle" href="#collapse-${subIdCounter}" data-toggle="collapse"</c:when><c:otherwise>href="<cms:link>${elem.resourceName}</cms:link>"</c:otherwise></c:choose>>${elem.navText}</a>
		<c:set var="oldLevel" value="${currentLevel}" />
	</c:forEach>

	<c:forEach begin="${navStartLevel + 1}" end="${oldLevel}"></li></ul></c:forEach>
	<c:if test="${not empty nav.items}"></li></c:if>
	</ul>
</div>
</cms:formatter>