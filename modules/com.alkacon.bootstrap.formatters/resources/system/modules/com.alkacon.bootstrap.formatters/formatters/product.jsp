<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="product" val="value" rdfa="rdfa">

<c:if test="${cms.container.type == 'content-full'}"><div class="row-fluid"></c:if>

<div class="hero-unit">
	<h1 ${rdfa.Name}>${value.Name}</h1>
	<p ${rdfa.Description}>${value.Description}</p>
	<c:if test="${product.value.Image.exists}">
		<c:choose>
			<c:when test="${cms.element.settings.imgalign == 'top'}">
				<c:set var="imgClass">top</c:set>
				<c:set var="imgWidth">${cms.container.width}</c:set>
			</c:when>
			<c:when test="${cms.element.settings.imgalign == 'right'}">
				<c:set var="imgClass">pull-right rgt-img-margin img-width-200</c:set>
				<c:set var="imgWidth">200</c:set>
			</c:when>
			<c:otherwise>
				<c:set var="imgClass">pull-left lft-img-margin img-width-200</c:set>
				<c:set var="imgWidth">200</c:set>
			</c:otherwise>
		</c:choose>
		<cms:img src="${product.value.Image.value.Image}" cssclass="${imgClass}" width="${imgWidth}" scaleColor="transparent" scaleType="0" alt="${product.value.Image.value.Title}" title="${product.value.Image.value.Title}" />
	</c:if>
	<c:if test="${product.value.Color.exists}">
		<div style="background-color: #${product.value.Color}; width: 50px; height: 50px;">&nbsp;</div>
	</c:if>
</div>

<c:if test="${cms.container.type == 'content-full'}"></div></c:if>

</cms:formatter>