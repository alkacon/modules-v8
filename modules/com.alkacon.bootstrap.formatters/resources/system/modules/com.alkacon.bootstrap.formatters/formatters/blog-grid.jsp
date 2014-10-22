<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.blog">

<cms:formatter var="content" val="value" rdfa="rdfa">
<div class="row margin-bottom-20">

				<c:set var="imgalign">noimage</c:set>
        <c:if test="${value.Paragraph.value.Image.exists}">
        	<c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
        </c:if>

				<c:if test="${imgalign == 'left'}">
					<div class="col-md-4 col-sm-2 hidden-xs">
						<cms:img src="${value.Paragraph.value.Image.value.Image}" width="800" cssclass="img-responsive"
							scaleColor="transparent" scaleType="0" noDim="true" alt="${paragraph.value.Image.value.Title}"
							title="${paragraph.value.Image.value.Title}" />
					</div>
				</c:if>

				<div class="col-md-8 col-sm-10 col-xs-12">
					<h2><a href="<cms:link>${content.filename}</cms:link>" ${rdfa.Title}>${value.Title}</a></h2>
					<c:set var="showdate"><c:out value="${cms.element.settings.showdate}" default="true" /></c:set>
					<c:if test="${showdate}">
						<p><i><fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></i></p>
					</c:if>
					<c:choose>
						<c:when test="${value.Teaser.isSet}">
							<p ${rdfa.Teaser}>${value.Teaser}</p>
						</c:when>
						<c:otherwise>
							<c:set var="teaserlength"><c:out value="${cms.element.settings.teaserlength}" default="250" /></c:set>
							<p>${cms:trimToSize(cms:stripHtml(value.Paragraph.value.Text), teaserlength)}</p>
						</c:otherwise>
					</c:choose>

					<a href="<cms:link>${content.filename}</cms:link>" class="btn-u btn-u-<c:out value="${cms.element.settings.buttoncolor}" default="red" />"><fmt:message key="bootstrap.blog.message.readmore" /></a>
				</div>

        <c:if test="${imgalign == 'right'}">
					<div class="col-md-4 col-sm-2 hidden-xs">
						<cms:img src="${value.Paragraph.value.Image.value.Image}" width="800" cssclass="img-responsive"
							scaleColor="transparent" scaleType="0" noDim="true" alt="${paragraph.value.Image.value.Title}"
							title="${paragraph.value.Image.value.Title}" />
					</div>
				</c:if>
			</div>                            
</cms:formatter>
</cms:bundle>