<%@page taglibs="c,cms,fn,fmt" %>
<cms:formatter var="content" val="value">
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

<c:set var="paragraph" value="${content.value.Paragraph}" />

<div class="paragraph margin-bottom-20">
	<c:set var="imgalign">noimage</c:set>
	<c:if test="${paragraph.value.Image.exists}">
		<c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
	</c:if>
	
	<c:set var="headline">
		<c:choose>
			<c:when test="${paragraph.value.Headline.isSet}">${paragraph.value.Headline}</c:when>
			<c:otherwise>Untitled</c:otherwise>
		</c:choose> 
	</c:set>
	
	<div class="headline">
		<c:set var="backLink">
			<c:choose>
				<c:when test="${cms.detailContentId == content.id}">${content.filename}</c:when>
				<c:otherwise>${cms.requestContext.uri}</c:otherwise>
			</c:choose>
		</c:set>
		<a href="<cms:link>%(link.weak:/demo/user-content-list/edit-post/)</cms:link>?fileId=${content.id}&backLinkSuccess=${backLink}&backLinkCancel=${backLink}">
			<button type="button"
				class="btn btn-default bs-post-edit pull-right glyphicon glyphicon-edit"></button>
		</a>
		<h4>${headline}</h4>
		<c:if test="${author ne ''}">
			<ul class="list-unstyled list-inline blog-info">
				<li><i class="icon-pencil"></i> ${author}</li>
			</ul>
		</c:if>
	</div>
	<c:choose>
				
		<c:when test="${imgalign == 'left'}">		
			<div class="row">
				<div class="col-md-4">
					<div class="thumbnail-kenburn"><div class="overflow-hidden">
						<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
						</div></div>		
				</div>
				<div class="col-md-8">
					<div>${paragraph.value.Text}</div>		
					<c:if test="${paragraph.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">
						<c:choose>
							<c:when test="${not empty paragraph.value.Link.value.Text}">${paragraph.value.Link.value.Text}</c:when>
							<c:otherwise>WWW</c:otherwise>
						</c:choose>
						</a></p>
					</c:if>		
				</div>
			</div>		
		</c:when>
		<c:otherwise>
			<div>${paragraph.value.Text}</div>		
			<c:if test="${paragraph.value.Link.exists}">
				<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">
					<c:choose>
						<c:when test="${not empty paragraph.value.Link.value.Text}">${paragraph.value.Link.value.Text}</c:when>
						<c:otherwise>WWW</c:otherwise>
					</c:choose>
				</a></p>
			</c:if>
		</c:otherwise>
			
	</c:choose>	
</div>

</cms:formatter>