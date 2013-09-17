<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pathparts" value="${fn:split(cms.requestContext.folderUri, '/')}" />
<c:set var="navStartLevel">${param.startlevel}</c:set>
<c:set var="navStartFolder" value="/" />
<c:forEach var="folderName" items="${pathparts}" varStatus="status">
	<c:if test="${status.count <= navStartLevel}">
		<c:set var="navStartFolder">${navStartFolder}${folderName}/</c:set>
	</c:if>
</c:forEach>
<cms:navigation type="forSite" resource="${navStartFolder}" startLevel="${navStartLevel}" endLevel="${navStartLevel + 1}" var="nav"/>
<div class="navbar">                                
	<div class="navbar-inner">                                  
		<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</a><!-- /nav-collapse -->                                  
		<div class="nav-collapse collapse">                                     
			<ul class="nav top-2">
	<c:set var="oldLevel" value="" />
	<c:forEach items="${nav.items}" var="elem" varStatus="status">
		<c:set var="currentLevel" value="${elem.navTreeLevel}" />

		<c:choose>
			<c:when test="${empty oldLevel}"></c:when>
			<c:when test="${currentLevel > oldLevel}"><ul class="dropdown-menu"></c:when>
			<c:when test="${currentLevel == oldLevel}"></li></c:when>
			<c:when test="${oldLevel > currentLevel}">
				<c:forEach begin="${currentLevel+1}" end="${oldLevel}"></li></ul><b class="caret-out"></b></c:forEach>
			</c:when>
		</c:choose>

		<c:set var="markItem">false</c:set>
		<c:if test="${fn:startsWith(cms.requestContext.uri, elem.resourceName)}">
			<c:set var="markItem">true</c:set>
		</c:if>

		<c:set var="parentItem">false</c:set>
		<c:if test="${currentLevel == 1}">
			<c:set var="parentItem">true</c:set>
		</c:if>

		<c:set var="listClass" value="" />
		<c:if test="${markItem}">
			<c:set var="listClass">class="active"</c:set>
		</c:if>

		<c:set var="caret"></c:set>
		<c:if test="${parentItem and not status.last}">
			<c:forEach items="${nav.items}" var="nextelem" varStatus="nextstatus">
				<c:if test="${nextstatus.count eq (status.count + 1) and nextelem.navTreeLevel eq 2}">
					<c:set var="caret">&nbsp;<b class="caret"></b></c:set>
				</c:if>
			</c:forEach>
		</c:if>

		<li ${listClass}>
		<a href="<c:choose><c:when test="${parentItem and not empty caret}">#</c:when><c:otherwise><cms:link>${elem.resourceName}</cms:link></c:otherwise></c:choose>"<c:if test="${parentItem}"> class="dropdown-toggle" data-toggle="dropdown"</c:if>>${elem.navText}${caret}</a>
		<c:set var="oldLevel" value="${currentLevel}" />
	</c:forEach>

	<c:forEach begin="${navStartLevel + 1}" end="${oldLevel}"></li></ul></c:forEach>
	<c:if test="${not empty nav.items}"></li></c:if>
    <li><a class="search"><i class="icon-search search-btn"></i></a></li>                               
			</ul>
			<div class="search-open">
				<div class="input-append">
					<form>
						<input type="text" class="span3" placeholder="Search" />
						<button type="submit" class="btn-u">Go</button>
					</form>
				</div>
			</div>
		</div><!-- /nav-collapse -->                                
	</div><!-- /navbar-inner -->
</div><!-- /navbar -->
