<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.list">

<cms:formatter var="con" rdfa="rdfa">

	<c:if test="${'' ne con.value.SortOrder && '' ne con.value.RowCount && '' ne con.value.CreatePath}">
		<c:set var="solrParamType">&fq=type:bs-blog</c:set>
		<c:set var="solrParamDirs">&fq=parent-folders:"/sites/default/demo/"</c:set>
		<c:set var="solrFilterQue">${con.value.FilterQueries}</c:set>
		<c:set var="solrParamSort">&sort=collector.priority_prop ${con.value.SortOrder}, newsdate_${cms.locale}_dt ${con.value.SortOrder}</c:set>
		<c:set var="solrParamRows">&rows=${con.value.RowCount}</c:set>
		<c:set var="resCreatePath">|createPath=${con.value.CreatePath}</c:set>
		<c:set var="collectorParam">${solrParamType}${solrParamDirs}${solrFilterQue}${solrParamSort}${solrParamRows}${resCreatePath}</c:set>
	</c:if>
	<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width) / 100) * 20}" maxFractionDigits="0" /></c:set>

	<div <c:if test="${cms.container.type != 'content'}">class="row"</c:if>>

		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<div class="alert"><fmt:message key="bootstrap.list.message.new" /></div>
			</c:when>
			<c:when test="${empty collectorParam}">
				<div class="alert"><fmt:message key="bootstrap.list.message.edit" /></div>
			</c:when>
			<c:otherwise>

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
								<dt>
									<c:set var="imageExist" value="false"/>
									<c:if test="${paragraph.value.Image.exists}">
										<c:set var="imageExist" value="true"/>
										<a href="<cms:link>${content.file.rootPath}</cms:link>">
										<cms:img src="${paragraph.value.Image.value.Image}" alt="${paragraph.value.Image.value.Title}" width="50" scaleColor="transparent" scaleType="0"/>
										</a>
									</c:if>
								</dt>
								<dd<c:if test="${!imageExist}"> class="noImg"</c:if>>
									<a href="<cms:link>${content.file.rootPath}</cms:link>">
										<h4 class="media-heading">${headline}</h4>
										<p><i><small><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" type="DATE" /></small></i></p>
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

			</c:otherwise>
		</c:choose>

	</div>
	
</cms:formatter>
</cms:bundle>