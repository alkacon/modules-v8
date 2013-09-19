<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="list" rdfa="rdfa">

	<c:set var="solrQuery">fq=type:bs-newsarticle&fq=con_locales:${cms.locale}&fq=parent-folders:("/shared/.content/newsarticles/" OR "/sites/default/.content/newsarticles/")&sort=collector.priority_prop desc, newsdate_${cms.locale}_dt desc&rows=100|createPath=/sites/default/.content/newsarticles/na_%(number:5).html</c:set>
	<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width + 30) / 100) * 30}" maxFractionDigits="0" /></c:set>
	<c:set var="headCount"><fmt:formatNumber type="number" value="${((cms.container.width + 30) / 100) * 8}" maxFractionDigits="0" /></c:set>

	<div <c:if test="${cms.container.type == 'content-full'}"> class="row-fluid"</c:if>>

		<div class="posts margin-bottom-20 blog-item">

			<div class="headline"><h4 ${rdfa.Title}><c:out value="${list.value['Title']}" escapeXml="false" /></h4></div>

	<cms:contentload collector="byQuery" param="${solrQuery}" preload="true" >
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
				<dl class="dl-horizontal">
					<a href="<cms:link>${content.file.rootPath}</cms:link>">
						<h4 class="media-heading">
							${cms:trimToSize(cms:stripHtml(headline), headCount)}
							<span><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></span>
						</h4>
					</a>
					<c:if test="${paragraph.value.Image.exists}">
				    <dt>
				    	<a href="<cms:link>${content.file.rootPath}</cms:link>">
				    		<cms:img src="${paragraph.value.Image.value.Image}"
				    		         alt="${paragraph.value.Image.value.Title}" 
				    	             width="50" scaleColor="transparent" scaleType="0"/>
				  		</a>
				    </dt>
					</c:if>
				    <dd>
				        <p><a href="<cms:link>${content.file.rootPath}</cms:link>">${cms:trimToSize(cms:stripHtml(paragraph.value.Text), wordCount)}</a></p>
				    </dd>
				</dl>
				<!-- // END entry -->
	
			</cms:contentload>
		</c:if>
	</cms:contentload>

		</div>

	</div>

</cms:formatter>
