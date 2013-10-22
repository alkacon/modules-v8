<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content">

<div<c:if test="${cms.container.type == 'content-full'}"> class="row"</c:if>>

<c:forEach var="paragraph" items="${content.valueList.Paragraph}">

	<c:set var="imgalign">noimage</c:set>
	<c:if test="${paragraph.value.Image.exists}">
		<c:set var="imgalign"><cms:elementsetting name="imgalign" default="left" /></c:set>
	</c:if>

	<c:if test="${paragraph.value.Headline.isSet}">
		<div class="headline"><h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3></div>
	</c:if>

	<c:choose>
	
		<c:when test="${imgalign == 'noimage' || imgalign == 'top'}">
			<c:if test="${imgalign == 'top'}">	
				<div ${paragraph.rdfa.Image} class="thumbnail-kenburn"><div class="overflow-hidden">
					<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="1200" height="300" scaleType="2" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
				</div></div>
			</c:if>
			<c:if test="${imgalign == 'noimage'}">	
				<span ${paragraph.rdfa.Image}></span>
			</c:if>
			<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>		
			<c:if test="${paragraph.value.Link.exists}">
				<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
			</c:if>
		</c:when>


		<c:when test="${imgalign == 'left'}">		
			<div class="row">
				<div class="col-md-4">
					<div ${paragraph.rdfa.Image} class="thumbnail-kenburn"><div class="overflow-hidden">
						<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
					</div></div>		
				</div>
				<div class="col-md-8">
					<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>		
					<c:if test="${paragraph.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
					</c:if>		
				</div>
			</div>		
		</c:when>
		
		
		<c:when test="${imgalign == 'right'}">
			<div class="row-fluid">
				<div class="col-md-8">
					<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>		
					<c:if test="${paragraph.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
					</c:if>		
				</div>
				<div class="col-md-4">
					<div ${paragraph.rdfa.Image} class="thumbnail-kenburn"><div class="overflow-hidden">
						<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
					</div></div>		
				</div>
			</div>			
		</c:when>
					
	</c:choose>	

</c:forEach> 

</div>

</cms:formatter>