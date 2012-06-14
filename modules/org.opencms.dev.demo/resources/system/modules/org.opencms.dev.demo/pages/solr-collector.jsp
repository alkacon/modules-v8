<%@page buffer="none" session="false" taglibs="c,cms" %>
<div>
	<cms:contentload collector="byQuery" param="q=+parent-folders:/sites/default/ +type:ddarticle&rows=4&start=7&type=dismax&fl=*,score&sort=lastmodified desc" preload="true">
		<cms:contentinfo var="info" />
		<c:if test="${info.resultSize > 0}">
			<cms:contentinfo var="info" />			
			<c:if test="${info.resultSize > 0}">
				<h3>Solr Collector Demo</h3>
				<cms:contentload editable="false">
					<cms:contentaccess var="content" />
					<%-- Title of the article --%>
					<h6>${content.value.Title}</h6>
					<%-- The text field of the article with image --%>
					<div class="paragraph">
						<%-- Set the requied variables for the image. --%>
						<c:if test="${content.value.Image.isSet}">								
							<%-- Output of the image using cms:img tag --%>				
							<c:set var="imgwidth">${(cms.container.width - 20) / 3}</c:set>
							<%-- The image is scaled to the one third of the container width, considering the padding=20px on both sides. --%>
							<cms:img src="${content.value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="left" alt="${content.value.Image}" title="${content.value.Image}" />				
						</c:if>									
						${cms:trimToSize(cms:stripHtml(content.value.Text), 300)}
					</div>
					<div class="clear"></div>
				</cms:contentload>
			</c:if>
		</c:if>
	</cms:contentload>
</div>
