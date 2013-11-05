<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.blog">

<cms:formatter var="content" val="value" rdfa="rdfa">

	<div <c:if test="${cms.container.type == 'content-full'}"> class="row"</c:if>>

		<c:choose>
			<c:when test="${not cms.detailRequest or cms.container.name == 'middle-left-detail' or cms.container.name == 'middle-right-detail'}">
				<c:set var="layoutvariant"><c:out value="${cms.element.settings.layoutvariant}" default="top" /></c:set>
				<c:choose>
					<c:when test="${layoutvariant == 'top' or layoutvariant == 'left'}">
						<c:set var="boxClass">search-blocks-${layoutvariant}-<c:out value="${cms.element.settings.color}" default="sea" /></c:set>
					</c:when>
					<c:otherwise>
						<c:set var="boxClass">search-blocks-colored search-blocks-<c:out value="${cms.element.settings.color}" default="sea" /></c:set>
					</c:otherwise>
				</c:choose>
				<div class="search-page"><div class="search-blocks ${boxClass}">
                    <div class="row">
                        <c:if test="${value.Paragraph.value.Image.exists}">
							<div class="col-md-4 search-img">
								<cms:img src="${value.Paragraph.value.Image.value.Image}" width="800" cssclass="img-responsive"
								scaleColor="transparent" scaleType="0" alt="${paragraph.value.Image.value.Title}"
								title="${paragraph.value.Image.value.Title}" />
							</div>
						</c:if>
                        <div class="col-md-8">
                            <h2><a href="<cms:link>${content.filename}</cms:link>" ${rdfa.Title}>${value.Title}</a></h2>
							<c:set var="showdate"><c:out value="${cms.element.settings.showdate}" default="true" /></c:set>
							<c:if test="${showdate}">
								<ul class="list-unstyled">
								   <li><i class="icon-calendar"></i> <fmt:formatDate value="${cms:convertDate(value.Date)}" dateStyle="LONG" timeStyle="SHORT" type="both" /></li>
								</ul>
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
                    </div>                            
                </div></div>
			</c:when>
			<c:otherwise>
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
</cms:bundle>