<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.list">

<cms:formatter var="con" rdfa="rdfa">

	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="bootstrap.list.message.new" /></div>
		</c:when>
		<c:otherwise>

	<c:set var="solrParamType">&fq=type:${con.value.ResourceType}</c:set>
	<c:set var="solrParamDirs">&fq=parent-folders:${con.value.ParentFolders}</c:set>
	<c:set var="solrParamSort">&sort=collector.priority_prop ${con.value.SortOrder}, newsdate_${cms.locale}_dt ${con.value.SortOrder}</c:set>
	<c:set var="solrParamRows">&rows=${con.value.RowCount}</c:set>
	<c:set var="resCreatePath">|createPath=${con.value.CreatePath}</c:set>
	<c:set var="collectorParam">${solrParamType}${solrParamDirs}${solrParamSort}${solrParamRows}${resCreatePath}</c:set>
	<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width + 30) / 100) * 30}" maxFractionDigits="0" /></c:set>

	<div <c:if test="${cms.container.type == 'content-full'}">class="row"</c:if>>
	
		<c:if test="${not cms.element.settings.hidetitle}">
			<div class="headline headline-md"><h3 ${rdfa.Title}><c:out value="${con.value.Title}" escapeXml="false" /></h3></div>
		</c:if>			
		
		<div class="posts lists blog-item margin-bottom-20">
		
	<cms:contentload collector="byContext" param="${collectorParam}" preload="true" >
		<cms:contentinfo var="info" />
		<c:if test="${info.resultSize > 0}">
			<cms:contentload editable="true">
				<cms:contentaccess var="content" />
				<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
				<c:set var="headline">${content.value.Title}</c:set>
				<c:if test="${paragraph.value.Headline.isSet}"><c:set var="headline">${paragraph.value.Headline}</c:set></c:if>

				<!-- entry -->
				<dl class="dl-horizontal entry">
					<a href="<cms:link>${content.file.rootPath}</cms:link>">
						<h4 class="media-heading">${headline}</h4>
					</a>
					<c:if test="${paragraph.value.Image.exists}"><dt>
				    	<a href="<cms:link>${content.file.rootPath}</cms:link>">
						<cms:img src="${paragraph.value.Image.value.Image}" alt="${paragraph.value.Image.value.Title}" width="50" scaleColor="transparent" scaleType="0"/></a>
					</dt></c:if>
					<dd>
						<a href="<cms:link>${content.file.rootPath}</cms:link>">
							<p class="muted"><small> <fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" /></small></p>
							<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), wordCount)}</p>
						</a>
					</dd>
				</dl>
				<!-- // END entry -->

			</cms:contentload>
		</c:if>
	</cms:contentload>

		<c:if test="${con.value.Link.exists}">
      <p><a class="btn-u btn-u-small" href="<cms:link>${con.value.Link.value.URI}</cms:link>">${con.value.Link.value.Text}</a></p>
		</c:if>		

		</div>
	</div>

		</c:otherwise>
	</c:choose>
	
</cms:formatter>
</cms:bundle>