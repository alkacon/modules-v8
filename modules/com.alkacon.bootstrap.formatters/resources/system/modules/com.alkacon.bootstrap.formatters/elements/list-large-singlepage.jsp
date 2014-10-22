<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.list">

<c:set var="isEditable" value="false" />
<c:if test="${param.currPage == '1'}"><c:set var="isEditable" value="true" /></c:if>

<cms:contentload collector="byContext" param="${param.collectorParam}" pageSize="${param.itemsPerPage}" pageIndex="${param.currPage}" editable="${isEditable}">
	<cms:contentaccess var="content" />
	<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
	<div class="row margin-bottom-20">
		<c:if test="${paragraph.value.Image.exists}">
			<div class="col-md-4 search-img">
				<cms:img src="${paragraph.value.Image.value.Image}" width="800" cssclass="img-responsive"
					scaleColor="transparent" scaleType="0" noDim="true" alt="${paragraph.value.Image.value.Title}"
					title="${paragraph.value.Image.value.Title}" />
			</div>
		</c:if>
		<div class="col-md-8">
			<h2><a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a></h2>
			<c:set var="showdate"><c:out value="${param.showDate}" default="true" /></c:set>
			<c:if test="${showdate}">
				<p><i><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></i></p>
			</c:if>
			<c:choose>
				<c:when test="${content.value.Teaser.isSet}">
					<p>${content.value.Teaser}</p>
				</c:when>
				<c:otherwise>
					<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), param.teaserLength)}</p>
				</c:otherwise>
			</c:choose>
			<div class="margin-bottom-10"></div>
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>" class="btn-u btn-u-<c:out value="${param.buttonColor}" default="red" />"><fmt:message key="bootstrap.list.message.readmore" /></a>
		</div>
	</div>

</cms:contentload>
</cms:bundle>