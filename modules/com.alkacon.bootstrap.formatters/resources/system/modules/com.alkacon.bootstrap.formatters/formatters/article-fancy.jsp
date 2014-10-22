<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content">

<div class="<c:if test="${cms.container.type == 'content-wide'}">row </c:if>margin-bottom-30">

	<c:set var="layoutvariant"><c:out value="${cms.element.settings.layoutvariant}" default="top" /></c:set>
	<c:choose>
		<c:when test="${layoutvariant == 'top' or layoutvariant == 'left'}">
			<c:set var="boxClass">tag-box tag-box-<c:if test="${layoutvariant == 'top'}">v3</c:if><c:if test="${layoutvariant == 'left'}">v2</c:if> search-blocks-${layoutvariant}-<c:out value="${cms.element.settings.color}" default="sea" /></c:set>
		</c:when>
		<c:otherwise>
			<c:set var="boxClass">box-leftalign servive-block servive-block-<c:out value="${cms.element.settings.color}" default="sea" /> search-blocks-<c:out value="${cms.element.settings.color}" default="sea" /></c:set>
		</c:otherwise>
	</c:choose>
	
	<c:forEach var="paragraph" items="${content.valueList.Paragraph}">
   <div class="${boxClass}">
		<div class="row">

			<c:set var="imgalign">noimage</c:set>
			<c:if test="${paragraph.value.Image.exists}">
				<c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
			</c:if>

			<c:if test="${imgalign == 'left'}">
				<div class="col-md-4 col-sm-2 hidden-xs">
					<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" noDim="true" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
				</div>
			</c:if>

			<div class="<c:if test="${imgalign != 'noimage'}">col-md-8 col-sm-10 </c:if>col-xs-12">
				<c:if test="${paragraph.value.Headline.isSet}">
				<h2 class="heading-md" ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h2>
				</c:if>
				<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>	
				<c:if test="${paragraph.value.Link.exists}">
				<a href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>" class="btn-u btn-u-<c:out value="${cms.element.settings.buttoncolor}" default="red" />">${paragraph.value.Link.value.Text}</a>
				</c:if>
			</div>

			<c:if test="${imgalign == 'right'}">
				<div class="col-md-4 col-sm-2 hidden-xs">
					<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" noDim="true" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
				</div>
			</c:if>
		</div>                            
	 </div>
	</c:forEach> 
	
</div>
</cms:formatter>