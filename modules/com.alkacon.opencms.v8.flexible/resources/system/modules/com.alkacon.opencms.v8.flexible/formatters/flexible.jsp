<%@page buffer="none" session="false" taglibs="c,cms,fmt" %>

<fmt:setLocale value="${cms.locale}" />
<fmt:bundle basename="com.alkacon.opencms.v8.flexible.workplace">

<cms:formatter var="content" val="value" rdfa="rdfa">
	<div style="width: ${cms.container.width}px; <c:if test="${cms.element.settings.marginBottom}"> margin-bottom: 20px; </c:if>">
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<fmt:message key="v8flexible.message.edit" />
		</c:when>
		<c:otherwise>
			<c:if test="${not cms.element.settings.hideTitle}">
				<h2 ${rdfa.Title}>${value.Title}</h2>
			</c:if>	
			<c:forEach var="elem" items="${content.subValueList['Choice']}">
				<c:choose>
					<c:when test="${elem.name == 'Text'}">
						${elem}
					</c:when>
					<c:when test="${elem.name == 'Code'}">
						<c:choose>
							<c:when test="${cms.edited}">
								<fmt:message key="v8flexible.message.changed" />
							</c:when>
							<c:otherwise>
							${elem}
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:when test="${elem.name == 'Image'}">
						<cms:img src="${elem.value.URI}" alt="${elem.value.Title}" title="${elem.value.Title}" width="${cms.container.width}" scaleType="0" scaleQuality="70" scaleRendermode="0" />
					</c:when>
					<c:otherwise>
						<fmt:message key="v8flexible.message.edit" />
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>
</cms:formatter>

</fmt:bundle>