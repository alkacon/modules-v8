<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:set var="slevel">${param.startlevel}</c:set>
<c:if test="${slevel < 1}"><c:set var="slevel" value="1"/></c:if>
<cms:navigation type="breadCrumb" startLevel="${slevel - 1}" endLevel="-1" var="nav" param="true" />
<ul class="pull-right breadcrumb hidden-xs">
	<c:forEach items="${nav.items}" var="elem" varStatus="status">
		<c:set var="navText">${elem.navText}</c:set>
		<c:if test="${empty navText or fn:contains(navText, '??? NavText')}">
			<c:set var="navText">${elem.title}</c:set>
		</c:if>
		<c:if test="${!empty navText}">
			<li><c:if test="${true}"><a href="<cms:link>${elem.resourceName}</cms:link>"></c:if>${navText}</a></li>
		</c:if>
	</c:forEach>
</ul>