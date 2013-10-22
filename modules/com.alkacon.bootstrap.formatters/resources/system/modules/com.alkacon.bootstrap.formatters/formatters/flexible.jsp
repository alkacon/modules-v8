<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.flexible">

<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:if test="${cms.container.type == 'content-full'}"><div class="row"></c:if>
	<div<c:if test="${not empty cms.element.settings.cssClass}"> class="${cms.element.settings.cssClass}"</c:if>>
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="bootstrap.flexible.message.edit" /></div>
		</c:when>
		<c:otherwise>
			<c:if test="${not cms.element.settings.hideTitle}">
				<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
			</c:if>	
			<c:forEach var="elem" items="${content.subValueList['Choice']}">
				<c:choose>
					<c:when test="${elem.name == 'Text'}">
						${elem}
					</c:when>
					<c:when test="${elem.name == 'Code'}">
						<c:choose>
							<c:when test="${cms.edited}">
								<div class="alert"><fmt:message key="bootstrap.flexible.message.changed" /></div>
							</c:when>
							<c:otherwise>
							${elem}
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${elem.name == 'Image'}">
						<cms:img src="${elem.value.Image}" alt="${elem.value.Title}" title="${elem.value.Title}" width="${cms.container.width}" scaleType="0" scaleQuality="70" scaleRendermode="0" />
					</c:when>
					<c:otherwise>
						<div class="alert"><fmt:message key="bootstrap.flexible.message.edit" /></div>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>
	<c:if test="${cms.container.type == 'content-full'}"></div></c:if>
</cms:formatter>

</cms:bundle>