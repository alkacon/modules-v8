<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content">

<div class="<c:if test="${cms.container.type == 'content-wide'}">row </c:if>margin-bottom-30">

<c:forEach var="paragraph" items="${content.valueList.Paragraph}">

	<c:if test="${paragraph.value.Headline.isSet}">
		<div class="headline"><h2 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h2></div>
	</c:if>

	<div  ${paragraph.rdfa["Link|Image"]}>
			<div class="row">
				<c:if test="${paragraph.value.Image.exists}">
					<div class="col-md-4 col-sm-2 hidden-xs">
						<div class="thumbnail-kenburn"><div class="overflow-hidden">
							<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="400" scaleType="0" noDim="true" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
						</div></div>		
					</div>
				</c:if>
				<div class="<c:choose><c:when test="${paragraph.value.Image.exists}">col-md-8 col-sm-10 col-xs-12</c:when><c:otherwise>col-xs-12</c:otherwise></c:choose>">
					<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>		
					<c:if test="${paragraph.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
					</c:if>		
				</div>
			</div>		
	</div>
	
</c:forEach> 

</div>

</cms:formatter>