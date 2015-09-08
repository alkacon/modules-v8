<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.schemas.flexible">

<cms:formatter var="content">
	<div<c:if test="${not empty cms.element.settings.cssClass}"> class="${cms.element.settings.cssClass}"</c:if>>
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="unify.flexible.message.edit" /></div>
		</c:when>
		<c:otherwise>
			<c:if test="${not cms.element.settings.hideTitle}">
				<div class="headline"><h3 ${rdfa.Title}>${content.value.Title}</h3></div>
			</c:if>	
			<c:forEach var="elem" items="${content.subValueList['Choice']}">
				<c:choose>
					<c:when test="${elem.name == 'Text'}">
						${elem}
					</c:when>
					<c:when test="${elem.name == 'Code'}">
						<c:choose>
							<c:when test="${cms.element.settings.requireReload && cms.edited}">
								<div class="alert"><fmt:message key="unify.flexible.message.changed" /></div>
								${cms.enableReload}
							</c:when>
							<c:otherwise>
							${elem}
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${elem.name == 'Image'}">
						<img src="<cms:link>${elem.value.Image}</cms:link>" alt="${elem.value.Title}" title="${elem.value.Title}" class="img-responsive" />
					</c:when>
					<c:otherwise>
						<div class="alert"><fmt:message key="unify.flexible.message.edit" /></div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>
</cms:formatter>

</cms:bundle>