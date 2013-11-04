<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<cms:formatter var="content" val="value" rdfa="rdfa">

	<%-- create author link --%>
	<c:set var="author" value="${fn:trim(value.Author)}" />
	<c:choose>
		<c:when test="${fn:length(author) > 3 && value.AuthorMail.exists}">
			<c:set var="author"><a href="mailto:${value.AuthorMail}" title="${author}">${author}</a></c:set>
		</c:when>
		<c:when test="${fn:length(author) > 3}">
			<c:set var="author">${author}</c:set>
		</c:when>
		<c:when test="${value.AuthorMail.exists}">
			<c:set var="author"><a href="mailto:${value.AuthorMail}" title="${value.AuthorMail}">${value.AuthorMail}</a></c:set>
		</c:when><c:otherwise><c:set var="author" value=""></c:set></c:otherwise>
	</c:choose>
	<%-- //END create author link --%>

	<div <c:if test="${cms.container.type == 'content-full'}"> class="row"</c:if>>

		<c:choose>
			<c:when test="${not cms.detailRequest}">
				<div class="search-page"><div class="search-blocks search-blocks-top-sea">
                    <div class="row">
                        <c:if test="${value.Paragraph.value.Image.exists}">
							<div class="col-md-4 search-img">
								<cms:img src="${value.Paragraph.value.Image.value.Image}" cssclass="img-responsive"
								scaleColor="transparent" scaleType="0" alt="${paragraph.value.Image.value.Title}"
								title="${paragraph.value.Image.value.Title}" />
								<ul class="list-unstyled">
								   <li><i class="icon-briefcase"></i> Dell, Google</li>
								   <li><i class="icon-map-marker"></i> New York, US</li>
								</ul>
							</div>
						</c:if>
                        <div class="col-md-8">
                            <h2><a href="<cms:link>${content.filename}</cms:link>" ${rdfa.Title}>${value.Title}</a></h2>
                            <p>${cms:trimToSize(cms:stripHtml(value.Paragraph.value.Text), 150)}</p>
							<a href="#" class="btn-u btn-u-red">read more</a>
                        </div>
                    </div>                            
                </div></div>
				<%--<div class="magazine-news">
					<dl class="dl-horizontal">
						<a href="<cms:link>${content.filename}</cms:link>"><h4 class="media-heading" ${rdfa.Title}>${value.Title}</h4></a>
						<dt>
							<c:if test="${value.Paragraph.value.Image.exists}">
							<a href="<cms:link>${content.filename}</cms:link>">
								<cms:img src="${value.Paragraph.value.Image.value.Image}" width="${imgWidth}"
								scaleColor="transparent" scaleType="0" alt="${paragraph.value.Image.value.Title}"
								title="${paragraph.value.Image.value.Title}" />
							</a>
							</c:if>
						</dt>
						<dd>
							<a href="<cms:link>${content.filename}</cms:link>">
								<p class="muted"><small><i class="icon-calendar"></i><fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="MEDIUM" timeStyle="SHORT" type="both" /></small></p>
								<p>${cms:trimToSize(cms:stripHtml(value.Paragraph.value.Text), 150)}</p>
							</a>
						</dd>
						
					</dl>

				</div>
				
				
				<div class="magazine-news">
					<div class="magazine-mini-news">
						<h3>
							<a href="<cms:link>${content.filename}</cms:link>" ${rdfa.Title}>${value.Title}</a>
						</h3>
						<div class="post-author">
							<c:if test="${author ne ''}"><strong>${author}</strong></c:if>
							<span><c:if test="${author ne ''}"> / </c:if><fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="MEDIUM" timeStyle="SHORT" type="both" /></span>
						</div>
						<p>${cms:trimToSize(cms:stripHtml(value.Paragraph.value.Text), 150)}</p>
					</div>
					<hr/>
				</div>
				--%>
			</c:when>
			<c:otherwise>
				<!-- blog header -->
				<div class="blog-page">
					<div class="blog">
						<h3 ${rdfa.Title}>${value.Title}</h3>
						<ul class="list-unstyled list-inline blog-info">
							<li><i class="icon-calendar"></i> <fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="SHORT" timeStyle="SHORT" type="both" /></li>
							<c:if test="${author ne ''}">
							<li><i class="icon-pencil"></i> ${author}</li>
							</c:if>
						</ul>
						<c:if test="${fn:length(content.valueList.Category) > 0}">
						<ul class="list-unstyled list-inline blog-tags">
							<li>
								<i class="icon-tags"></i>
								<c:forEach var="item" items="${content.valueList.Category}" varStatus="status">
									<a href="#">${item}</a>
								</c:forEach>
							</li>
						</ul>
						</c:if>
					</div>
				</div><!-- //END blog header -->
		
				<!-- paragraphs -->
				<c:forEach var="paragraph" items="${content.valueList.Paragraph}" varStatus="status">
		
					<div class="paragraph margin-bottom-20">
		
						<c:if test="${paragraph.value.Image.exists}">
							<c:choose>
								<c:when test="${cms.element.settings.imgalign == 'top'}">
									<c:set var="imgClass">top img-responsive</c:set>
									<c:set var="imgWidth">${cms.container.width}</c:set>
								</c:when>
								<c:when test="${cms.element.settings.imgalign == 'right'}">
									<c:set var="imgClass">pull-right rgt-img-margin img-responsive</c:set>
									<c:set var="imgWidth">
										<fmt:formatNumber type="number" value="${(cms.container.width - 70) / 4}" />
									</c:set>
								</c:when>
								<c:otherwise>
									<c:set var="imgClass">pull-left lft-img-margin img-responsive</c:set>
									<c:set var="imgWidth">
										<fmt:formatNumber type="number" value="${(cms.container.width - 70) / 4}" />
									</c:set>
								</c:otherwise>
							</c:choose>
							<cms:img src="${paragraph.value.Image.value.Image}" cssclass="${imgClass}" width="${imgWidth}"
								scaleColor="transparent" scaleType="0" alt="${paragraph.value.Image.value.Title}"
								title="${paragraph.value.Image.value.Title}" />
						</c:if>
						
						<c:if test="${paragraph.value.Headline.isSet}">
							<h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3>
						</c:if>
						<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>
						
						<c:if test="${paragraph.value.Link.exists}">
							<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
						</c:if>
						
						<c:if test="${paragraph.value.Image.exists}">
							<div class="clearfix"></div>
						</c:if>
		
					</div>
		
				</c:forEach><!-- //END paragraphs -->
			</c:otherwise>
		</c:choose>
	</div>
</cms:formatter>
