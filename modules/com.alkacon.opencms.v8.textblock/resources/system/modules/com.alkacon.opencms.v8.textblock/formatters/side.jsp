<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="box ${cms.element.settings.boxschema}">

	<%-- Title of the text block --%>
	<c:if test="${not cms.element.settings.hidetitle}">
		<h4 ${rdfa.Title}>${value.Title}</h4>
	</c:if>	
	
	<div class="boxbody">
		<%-- Paragraphs of the text block --%>
		<c:forEach var="paragraph" items="${content.valueList.Paragraph}">
		<div class="paragraph">
			<c:set var="showimg" value="false" />
			<c:if test="${paragraph.value.Image.exists}">
				<c:set var="showimg" value="true" />
				<c:set var="imgalign"><cms:elementsetting name="imgalign" default="${paragraph.value.Image.value.Align}" /></c:set>
				<c:set var="imgclass"></c:set>
				<c:set var="imgwidth">${(cms.container.width - 20) / 3}</c:set>
				<c:choose>
					<c:when test="${imgalign == 'top'}">
						<c:set var="imgwidth">${cms.container.width - 22}</c:set>
						<c:set var="imgclass">top</c:set>
					</c:when>
					<c:when test="${imgalign == 'left' || imgalign == 'lefthl'}">
						<c:set var="imgclass">left</c:set>
					</c:when>
					<c:when test="${imgalign == 'right' || imgalign == 'righthl'}">
						<c:set var="imgclass">right</c:set>
					</c:when>
				</c:choose>
			</c:if>
			<c:if test="${showimg && (imgalign == 'lefthl' || imgalign == 'righthl' || imgalign == 'top')}">
				<c:if test="${paragraph.value.Image.value.Enlarge == 'true'}"><a href="<cms:link>${paragraph.value.Image.value.Image.xmlText['link/target']}</cms:link>" class="thickbox" title="${paragraph.value.Image.value.Title}"></c:if>
				<cms:img src="${paragraph.value.Image.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
				<c:if test="${paragraph.value.Image.value.Enlarge == 'true'}"></a></c:if>
			</c:if>
			<%-- Optional headline of the paragraph --%>
			<c:if test="${paragraph.value.Headline.isSet}">
				<h5 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h5>
			</c:if>
			<c:if test="${showimg && (imgalign == 'left' || imgalign == 'right')}">
				<c:if test="${paragraph.value.Image.value.Enlarge == 'true'}"><a href="<cms:link>${paragraph.value.Image.value.Image.xmlText['link/target']}</cms:link>" class="thickbox" title="${paragraph.value.Image.value.Title}"></c:if>
				<cms:img src="${paragraph.value.Image.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
				<c:if test="${paragraph.value.Image.value.Enlarge == 'true'}"></a></c:if>
			</c:if>
			<c:choose>
				<c:when test="${cms.element.settings.keephtml}">
					<div ${paragraph.rdfa.Text}>
					${paragraph.value.Text}
					</div>
				</c:when><c:otherwise>
					<div>
					${cms:trimToSize(cms:stripHtml(paragraph.value.Text), 300)}
					</div>
				</c:otherwise>
			</c:choose>
			
			<c:if test="${cms.element.settings.keephtml and paragraph.value.Option.exists}">
			<ul>
			<c:forEach var="elem" items="${paragraph.subValueList['Option']}">
			<c:choose>
				<c:when test="${elem.name == 'Link'}">
					<c:set var="linktext">${elem.value.Link}</c:set>
					<c:if test="${not elem.value.Text.isEmptyOrWhitespaceOnly}">
						<c:set var="linktext">${elem.value.Text}</c:set>
					</c:if>
					<li><a href="<cms:link>${elem.value.Link}</cms:link>">${linktext}</a></li>
				</c:when>
				<c:when test="${elem.name == 'Attachment'}">
					<c:set var="linktext">${elem.value.Document}</c:set>
					<c:if test="${not elem.value.Text.isEmptyOrWhitespaceOnly}">
						<c:set var="linktext">${elem.value.Text}</c:set>
					</c:if>
					<li><a href="<cms:link>${elem.value.Document}</cms:link>">${linktext}</a></li>
				</c:when>
			</c:choose>
			</c:forEach>
			</ul>
		</c:if>
		</div>
		</c:forEach>
	</div>
</div>

</cms:formatter>