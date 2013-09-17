<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div<c:if test="${cms.container.type == 'content-full'}"> class="row-fluid"</c:if>>

	<c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">
		<div class="paragraph margin-bottom-20">

		<c:if test="${paragraph.value.Headline.isSet}">
			<div class="headline">
				<h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3>
			</div>
		</c:if>

		<c:if test="${paragraph.value.Image.exists}">
			<c:choose>
				<c:when test="${cms.element.settings.imgalign == 'top'}">
					<c:set var="imgClass">top</c:set>
					<c:set var="imgWidth">${cms.container.width}</c:set>
				</c:when>
				<c:when test="${cms.element.settings.imgalign == 'right'}">
					<c:set var="imgClass">pull-right rgt-img-margin</c:set>
					<c:set var="imgWidth">120</c:set>
				</c:when>
				<c:otherwise>
					<c:set var="imgClass">pull-left lft-img-margin</c:set>
					<c:set var="imgWidth">120</c:set>
				</c:otherwise>
			</c:choose>
			<cms:img src="${paragraph.value.Image.value.Image}" cssclass="${imgClass}" width="${imgWidth}" scaleColor="transparent" scaleType="0" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
		</c:if>

		<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>

		<c:if test="${paragraph.value.Link.exists}">
			<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
		</c:if>

		<c:if test="${paragraph.value.Image.exists}">
			<div class="clearfix"></div>
		</c:if> 

	</div>
	</c:forEach> 

</div>

</cms:formatter>