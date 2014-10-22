<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="isEditable" value="false" />
<c:if test="${param.currPage == '1'}"><c:set var="isEditable" value="true" /></c:if>

<cms:contentload collector="byContext" param="${param.collectorParam}" pageSize="${param.itemsPerPage}" pageIndex="${param.currPage}" editable="${isEditable}">
	<cms:contentaccess var="content" />
	<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
	<c:set var="headline">${content.value.Title}</c:set>
	<c:if test="${paragraph.value.Headline.isSet}"><c:set var="headline">${paragraph.value.Headline}</c:set></c:if>

	<dl class="dl-horizontal entry">
		<dt>
			<c:set var="imageExist" value="false"/>
			<c:if test="${paragraph.value.Image.exists}">
				<c:set var="imageExist" value="true"/>
				<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
					<cms:img src="${paragraph.value.Image.value.Image}" alt="${paragraph.value.Image.value.Title}" width="50" scaleColor="transparent" scaleType="0"/>
				</a>
			</c:if>
		</dt>
		<dd<c:if test="${!imageExist}"> class="noImg"</c:if>>
			<a href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">
				<h4 class="media-heading">${headline}</h4>
				<c:set var="showdate"><c:out value="${param.showDate}" default="true" /></c:set>
			  <c:if test="${showdate}"><p><i><small><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" /></small></i></p></c:if>
				<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), param.teaserLength)}</p>
			</a>
		</dd>
	</dl>

</cms:contentload>