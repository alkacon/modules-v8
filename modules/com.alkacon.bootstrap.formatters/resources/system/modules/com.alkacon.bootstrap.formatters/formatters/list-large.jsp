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
	<c:set var="wordCount"><fmt:formatNumber type="number" value="${((cms.container.width + 30) / 100) * 30}" maxFractionDigits="0" /></c:set>

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

   				<c:set var="layoutvariant"><c:out value="${cms.element.settings.layoutvariant}" default="top" /></c:set>
  				<c:choose>
        		<c:when test="${layoutvariant == 'top' or layoutvariant == 'left'}">
        			<c:set var="boxClass">tag-box tag-box-<c:if test="${layoutvariant == 'top'}">v3</c:if><c:if test="${layoutvariant == 'left'}">v2</c:if> search-blocks-${layoutvariant}-<c:out value="${cms.element.settings.color}" default="sea" /></c:set>
        		</c:when>
        		<c:otherwise>
        			<c:set var="boxClass">servive-block servive-block-<c:out value="${cms.element.settings.color}" default="sea" /> search-blocks-<c:out value="${cms.element.settings.color}" default="sea" /></c:set>
        		</c:otherwise>
        	</c:choose>

					<cms:contentload collector="byContext" param="${collectorParam}" preload="true" >
						<cms:contentinfo var="info" />
						<c:if test="${info.resultSize > 0}">
							<cms:contentload editable="true">
								<cms:contentaccess var="content" />
					
								<!-- entry -->
								<c:set var="paragraph" value="${content.valueList.Paragraph['0']}" />
								<div class="search-page"><div class="${boxClass}">
									<div class="row">
										<c:if test="${paragraph.value.Image.exists}">
											<div class="col-md-4 search-img">
												<cms:img src="${paragraph.value.Image.value.Image}" width="800" cssclass="img-responsive"
												scaleColor="transparent" scaleType="0" noDim="true" alt="${paragraph.value.Image.value.Title}"
												title="${paragraph.value.Image.value.Title}" />
											</div>
										</c:if>
										<div class="col-md-8">
											<h2><a href="<cms:link>${content.filename}</cms:link>">${content.value.Title}</a></h2>
        							<c:set var="showdate"><c:out value="${cms.element.settings.showdate}" default="true" /></c:set>
        							<c:if test="${showdate}">
                        <p><i><fmt:formatDate value="${cms:convertDate(content.value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></i></p>
                      </c:if>
											<c:choose>
												<c:when test="${content.value.Teaser.isSet}">
													<p>${content.value.Teaser}</p>
												</c:when>
												<c:otherwise>
        									<c:set var="teaserlength"><c:out value="${cms.element.settings.teaserlength}" default="250" /></c:set>
        									<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserlength)}</p>
												</c:otherwise>
											</c:choose>
                      <div class="margin-bottom-10"></div>
                      <a href="<cms:link>${content.filename}</cms:link>" class="btn-u btn-u-<c:out value="${cms.element.settings.buttoncolor}" default="red" />"><fmt:message key="bootstrap.list.message.readmore" /></a>
										</div>
									</div>                            
								</div></div>
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