<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<c:set var="solrParamType">&fq=type:${param.resourceType}</c:set>
<c:set var="solrParamDirs">&fq=parent-folders:${param.parentFolders}</c:set>
<c:set var="solrParamSort">&sort=collector.priority_prop ${param.sortOrder}, newsdate_${cms.locale}_dt ${param.sortOrder}</c:set>
<c:set var="solrParamRows">&rows=${param.rowCount}</c:set>
<c:set var="resCreatePath">|createPath=${param.createPath}</c:set>
<c:set var="collectorParam">${solrParamType}${solrParamDirs}${solrParamSort}${solrParamRows}${resCreatePath}</c:set>
<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width + 30) / 100) * 30}" maxFractionDigits="0" /></c:set>

<fmt:setLocale value="${cms.locale}" />

<cms:formatter var="function" rdfa="rdfa">
	<div <c:if test="${cms.container.type == 'content-full'}">class="row"</c:if>>
	
		<c:if test="${not cms.element.settings.hidetitle}">
			<div class="headline headline-md"><h4 ${rdfa.Title}><c:out value="${function.value.Title}" escapeXml="false" /></h4></div>
		</c:if>			
		
		<div class="posts blog-item margin-bottom-20">
		
	<cms:contentload collector="byContext" param="${collectorParam}" preload="true" >
		<cms:contentinfo var="info" />
		<c:if test="${info.resultSize > 0}">
			<cms:contentload editable="true">
				<cms:contentaccess var="content" />
				<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
				<c:set var="headline">${content.value.Title}</c:set>
				<c:if test="${paragraph.value.Headline.isSet}"><c:set var="headline">${paragraph.value.Headline}</c:set></c:if>

				<!-- entry -->
				<dl class="dl-horizontal">
					<a href="<cms:link>${content.file.rootPath}</cms:link>">
						<h4 class="media-heading">${headline}</h4>
					</a>
					<c:if test="${paragraph.value.Image.exists}"><dt>
				    	<a href="<cms:link>${content.file.rootPath}</cms:link>">
						<cms:img src="${paragraph.value.Image.value.Image}" alt="${paragraph.value.Image.value.Title}" width="50" scaleColor="transparent" scaleType="0"/></a>
					</dt></c:if>
					<dd>
						<a href="<cms:link>${content.file.rootPath}</cms:link>">
							<p class="muted"><small><i class="icon-calendar"></i> <fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" /></small></p>
							<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), wordCount)}</p>
						</a>
					</dd>
				</dl>
				<!-- // END entry -->
			</cms:contentload>
		</c:if>
	</cms:contentload>

		</div>
	</div>

</cms:formatter>
