<%@page buffer="none" session="false" taglibs="c,cms" %>
<%-- Add the attribute 'rdfa' to enable inline editing for this formatter --%>
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="view-article">

	<%-- Title of the article --%>
	<%-- Enable inline editing for title, set the ${rdfa.Title} as attribute of the html tag, which surrounds the field  --%>
	<h2 ${rdfa.Title}>${value.Title}</h2>
	
	<%-- The text field of the article with image --%>
	<div class="paragraph">
		<c:set var="showing" value="false" />
		<c:if test="${value.Image.isSet}">
			<c:set var="showing" value="true" />						
			<c:set var="imgwidth">${((cms.container.width) / 2) - 25}</c:set>
			<cms:img src="${value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="left" alt="${value.Image}" title="${value.Image}" />						
		</c:if>
		<%-- Enable inline editing for text, set the ${rdfa.Text} as attribute of the html tag, which surrounds the field  --%>
		<span ${rdfa.Text}>${value.Text}</span>
		<c:if test="${showing}">
			<div class="clear"></div>					
		</c:if>
	</div>
</div>

</cms:formatter>