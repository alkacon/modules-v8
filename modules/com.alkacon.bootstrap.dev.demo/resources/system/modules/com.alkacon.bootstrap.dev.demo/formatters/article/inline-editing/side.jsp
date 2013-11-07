<%@page buffer="none" session="false" taglibs="c,cms" %>
<%-- Add the attribute 'rdfa' to enable inline editing for this formatter --%>
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="box box_schema1">

	<%-- Title of the article --%>
	<%-- Enable inline editing for title, set the ${rdfa.Title} as attribute of the html tag, which surrounds the field  --%>
	<h4 ${rdfa.Title}>${value.Title}</h4>
	<div class="boxbody">
		<%-- The text field of the article with image --%>				
		<div class="paragraph">
			<%-- Set the requied variables for the image. --%>
			<c:if test="${value.Image.isSet}">								
				<%-- The image is scaled to the one third of the container width, considering the padding=20px on both sides. --%>
				<c:set var="imgwidth">${(cms.container.width - 20) / 3}</c:set>
				<%-- Output of the image using cms:img tag --%>
				<cms:img src="${value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="left" alt="${value.Image}" title="${value.Image}" />				
			</c:if>
			<%-- Enable inline editing for text, set the ${rdfa.Text} as attribute of the html tag, which surrounds the field  --%>
			<span ${rdfa.Text}>${value.Text}</span>
		</div>		
	</div>
</div>

</cms:formatter>