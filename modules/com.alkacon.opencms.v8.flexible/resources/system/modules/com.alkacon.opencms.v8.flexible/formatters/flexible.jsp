<%@page buffer="none" session="false" taglibs="c,cms" %>

<cms:formatter var="content" val="value">
	<div style="width: ${cms.container.width}px; <c:if test="${cms.element.settings.marginBottom eq 'true'}"> margin-bottom: 20px; </c:if>">
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			Bitte bearbeiten Sie das Element.
		</c:when>
		<c:otherwise>
			<c:if test="${cms.element.settings.hideTitle ne 'true'}">
				<h2>${value.Title}</h2>
			</c:if>	
			<c:forEach var="elem" items="${content.subValueList['Choice']}">
				<c:choose>
					<c:when test="${elem.name == 'Text'}">
						${elem}
					</c:when>
					<c:when test="${elem.name == 'Code'}">
						<c:choose>
							<c:when test="${cms.edited}">
								Inhalt wurde ge&auml;ndert, bitte die Seite neu laden!
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
						Bitte bearbeiten Sie das Element.
					</c:otherwise>
				</c:choose>
			</c:forEach>
		</c:otherwise>
	</c:choose>
	</div>
</cms:formatter>