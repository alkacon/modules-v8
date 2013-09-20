<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.newsarticle" />

<c:set var="solrParamType">&fq=type:${param.resourceType}</c:set>
<c:set var="solrParamDirs">&fq=parent-folders:${param.parentFolders}</c:set>
<c:set var="solrParamSort">&sort=collector.priority_prop ${param.sortOrder}, newsdate_${cms.locale}_dt ${param.sortOrder}</c:set>
<c:set var="solrParamRows">&rows=${param.rowCount}</c:set>
<c:set var="resCreatePath">|createPath=${param.createPath}</c:set>
<c:set var="collectorParam">${solrParamType}${solrParamDirs}${solrParamSort}${solrParamRows}${resCreatePath}</c:set>
<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width + 30) / 100) * 60}" maxFractionDigits="0" /></c:set>

<cms:formatter var="function" rdfa="rdfa">

	<div <c:if test="${cms.container.type == 'content-full'}"> class="row-fluid"</c:if>>
		<div class="headline">
			<h3 ${rdfa.Title}><c:out value="${function.value['Title']}" escapeXml="false" /></h3>
		</div>
		<div class="lists margin-bottom-20">

			<cms:contentload collector="byContext" param="${collectorParam}" preload="true">
				<cms:contentinfo var="info" />
				<c:if test="${info.resultSize > 0}">
					<cms:contentload editable="true">
						<cms:contentaccess var="content" />
						<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
						<c:set var="headline">${content.value.Title}</c:set>
						<c:if test="${paragraph.value.Headline.isSet}">
							<c:set var="headline">${paragraph.value.Headline}</c:set>
						</c:if>

						<!-- entry -->
						<div class="entry">
							<div class="row-fluid">
								<div class="span12">
									<a class="headlink" href="<cms:link>${content.file.rootPath}</cms:link>"><h4>${headline}</h4></a>
									<span class="date"> <fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></span>
								</div>
							</div>
							<div class="row-fluid">
								<div class="span4">
									<c:if test="${paragraph.value.Image.exists}">
										<a href="<cms:link>${content.file.rootPath}</cms:link>">
											<cms:img
												src="${paragraph.value.Image.value.Image}" 
												alt="${paragraph.value.Image.value.Title}"
												width="600"
												scaleQuality="60" 
												scaleColor="transparent" 
												scaleType="0" />
										</a>
									</c:if>
									<c:if test="${!paragraph.value.Image.exists}">
										<span><fmt:message key="no.image" /></span>
									</c:if>
								</div>
								<div class="span8">
									<a class="textlink" href="<cms:link>${content.file.rootPath}</cms:link>">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), wordCount)}</a>
								</div>
							</div>
						</div>
						<!-- // END entry -->

					</cms:contentload>
				</c:if>
			</cms:contentload>

		</div>
	</div>

</cms:formatter>
