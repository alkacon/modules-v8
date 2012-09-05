<%@page buffer="none" session="false" taglibs="c,cms,fmt" %>
<fmt:setLocale value="${cms.locale}" />
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="view-article">

	<%-- Title of the news --%>
	<h2 ${rdfa.Title}>${value.Title}</h2>
	
	<%-- Event Dates --%>			
	<p><i>
		<c:choose>		
			<c:when test="${cms.element.settings.showtime}">
				<fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" />
			</c:when>
			<c:otherwise>
				<fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="SHORT" type="date" />
			</c:otherwise>
		</c:choose>								
	</i></p>
	
	<%-- Paragraph of the news --%>
	<c:set var="paragraph" value="${value.Paragraph}" />
	<div class="paragraph">
		<c:set var="showimg" value="false" />
		<c:if test="${paragraph.value.Image.exists}">
			<c:set var="showimg" value="true" />
			<c:set var="imgalign"><cms:elementsetting name="imgalign" default="${paragraph.value.Image.xmlText['format']}" /></c:set>
			<c:set var="imgclass"></c:set>
			<c:set var="imgwidth">${((cms.container.width) / 2) - 25}</c:set>
			<c:choose>
				<c:when test="${imgalign == 'top'}">
					<c:set var="imgwidth">${cms.container.width}</c:set>
					<c:set var="imgclass">top</c:set>
				</c:when>
				<c:when test="${imgalign == 'left' }">
					<c:set var="imgclass">left</c:set>
				</c:when>
				<c:when test="${imgalign == 'right'}">
					<c:set var="imgclass">right</c:set>
				</c:when>
			</c:choose>
		</c:if>
		<c:if test="${showimg && (imgalign == 'top')}">
			<cms:img src="${paragraph.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${paragraph.value.Image.xmlText['description']}" title="${paragraph.value.Image.xmlText['description']}" />
		</c:if>
		<%-- Optional headline of the paragraph --%>
		<c:if test="${paragraph.value.Headline.isSet}">
			<h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3>
		</c:if>
		<c:if test="${showimg && (imgalign == 'left' || imgalign == 'right')}">
			<cms:img src="${paragraph.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${paragraph.value.Image.xmlText['description']}" title="${paragraph.value.Image.xmlText['description']}" />
		</c:if>
		<div ${paragraph.rdfa.Text}>
			${paragraph.value.Text}
		</div>
		<c:if test="${showimg}">
			<div class="clear"></div>
		</c:if>
	</div>
	
	<%-- News author --%>				
	<c:choose>		
		<c:when test="${value.AuthorMail.isSet}">
			<i><a href="mailto:${value.AuthorMail}">${value.Author}</a></i>
		</c:when>
		<c:otherwise>
			<i>${value.Author}</i>
		</c:otherwise>
	</c:choose>										
</div>

</cms:formatter>