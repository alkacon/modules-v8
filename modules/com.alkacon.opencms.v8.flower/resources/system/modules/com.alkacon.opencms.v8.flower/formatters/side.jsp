<%@page buffer="none" session="false" taglibs="c,cms" %>
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="box ${cms.element.settings.boxschema}">

	<%-- Title of the article --%>
	<c:if test="${not cms.element.settings.hidetitle}">
		<h4 ${rdfa.Name}>${value.Name}</h4>
	</c:if>	
	
	<div class="boxbody">
		<%-- Paragraphs of the article --%>
		<c:forEach var="description" items="${content.valueList.Description}">
		<div class="paragraph">
			<c:set var="showimg" value="false" />
			<c:if test="${description.value.Image.exists}">
				<c:set var="showimg" value="true" />
				<c:set var="imgalign"><cms:elementsetting name="imgalign" default="${description.value.Image.value.Align}" /></c:set>
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
				<cms:img src="${description.value.Image.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${description.value.Image.value.Title}" title="${description.value.Image.value.Title}" />
			</c:if>
			<%-- Optional headline of the paragraph --%>
			<c:if test="${description.value.Headline.isSet}">
				<h5 ${description.rdfa.Headline}>${description.value.Headline}</h5>
			</c:if>
			<c:if test="${showimg && (imgalign == 'left' || imgalign == 'right')}">
				<cms:img src="${description.value.Image.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${description.value.Image.value.Title}" title="${description.value.Image.value.Title}" />
			</c:if>
			<c:choose>
				<c:when test="${cms.element.settings.keephtml}">
					<div ${description.rdfa.Text}>
					${description.value.Text}
					</div>
				</c:when><c:otherwise>
					<div>
					${cms:trimToSize(cms:stripHtml(description.value.Text), 300)}
					</div>
				</c:otherwise>
			</c:choose>
		</div>
		</c:forEach>
	</div>
</div>

</cms:formatter>