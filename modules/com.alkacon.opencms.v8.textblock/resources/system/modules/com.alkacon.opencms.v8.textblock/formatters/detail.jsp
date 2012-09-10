<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="article-${cms.element.settings.boxschema}">

	<%-- Title of the text block --%>
	<c:if test="${not cms.element.settings.hidetitle}">
		<h2 ${rdfa.Title}>${value.Title}</h2>
	</c:if>	

	
	<%-- Paragraphs of the text block --%>
	<c:forEach var="paragraph" items="${content.valueList.Paragraph}">
	<div class="paragraph">
		<c:set var="showimg" value="false" />
		<c:if test="${paragraph.value.Image.exists}">
			<c:set var="showimg" value="true" />
			<c:set var="imgalign"><cms:elementsetting name="imgalign" default="${paragraph.value.Image.value.Align}" /></c:set>
			<c:set var="imgclass"></c:set>
			<c:set var="imgwidth">${((cms.container.width) / 2) - 25}</c:set>
			<c:choose>
				<c:when test="${imgalign == 'top'}">
					<c:choose>
						<c:when test="${cms.element.settings.boxschema == 'box_schema3'}">
						<c:set var="imgoffset">0</c:set>
						</c:when><c:otherwise>
					    	<c:set var="imgoffset">8</c:set>
						</c:otherwise>
					</c:choose>				
					<c:set var="imgwidth">${cms.container.width - imgoffset}</c:set>
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
			<h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3>
		</c:if>
		<c:if test="${showimg && (imgalign == 'left' || imgalign == 'right')}">
			<c:if test="${paragraph.value.Image.value.Enlarge == 'true'}"><a href="<cms:link>${paragraph.value.Image.value.Image.xmlText['link/target']}</cms:link>" class="thickbox" title="${paragraph.value.Image.value.Title}"></c:if>
			<cms:img src="${paragraph.value.Image.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
			<c:if test="${paragraph.value.Image.value.Enlarge == 'true'}"></a></c:if>
		</c:if>
		<div ${paragraph.rdfa.Text}>
		${paragraph.value.Text}
		</div>
		<c:if test="${showimg}">
			<div class="clear"></div>
		</c:if>
		
		<c:if test="${paragraph.value.Option.exists}">
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

</cms:formatter>