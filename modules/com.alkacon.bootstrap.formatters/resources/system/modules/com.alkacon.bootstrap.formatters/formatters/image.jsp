<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.image">
<cms:formatter var="content" val="value" rdfa="rdfa">

	<div ${content.rdfa["Link|Image"]}>				
		<div class="thumbnails thumbnail-style thumbnail-kenburn">
			<c:if test="${value.Image.isSet}"><div class="thumbnail-img">
				<div class="overflow-hidden"><img src="<cms:link>${value.Image}</cms:link>" class="img-responsive" alt="" /></div>
				<c:if test="${value.Link.isSet}"><a class="btn-more hover-effect" href="<cms:link>${value.Link}</cms:link>"><fmt:message key="bootstrap.image.frontend.readmore" /></a></c:if>
				</div></c:if>
			<div class="caption">
				<c:choose>
					<c:when test="${value.Headline.isSet && value.Link.isSet}">
						<h2><a class="hover-effect" href="<cms:link>${value.Link}</cms:link>" ${rdfa.Headline}>${value.Headline}</a></h2>
					</c:when>
					<c:when test="${value.Headline.isSet}">
						<h2 ${rdfa.Headline}>${value.Headline}</h2>
					</c:when>
				</c:choose>
				<p ${rdfa.Text}>${value.Text}</p>
				<c:if test="${not value.Image.isSet and value.Link.isSet}"><div style="text-align: right; margin-top: 20px;"><a class="btn-more hover-effect" style="position: relative;" href="<cms:link>${value.Link}</cms:link>"><fmt:message key="bootstrap.image.frontend.readmore" /></a></div></c:if>
			</div>
		</div>
	</div>

</cms:formatter>
</cms:bundle>