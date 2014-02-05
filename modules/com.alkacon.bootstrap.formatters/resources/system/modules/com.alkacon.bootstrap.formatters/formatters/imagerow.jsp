<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.imagerow">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div>

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>

	<div class="row">
		<c:forEach var="item" items="${content.valueList.Item}">
			<div ${item.rdfa["Link|Image"]} class="${cms:lookup(fn:length(content.valueList.Item), '1:col-xs-12|2:col-sm-6|3:col-sm-4|4:col-md-3 col-sm-6|5:col-md-2 col-sm-6|6:col-md-2 col-sm-4')}">				
            	<div class="thumbnails thumbnail-style thumbnail-kenburn">
           	 		<c:if test="${item.value.Image.isSet}"><div class="thumbnail-img">
            			<div class="overflow-hidden"><img src="<cms:link>${item.value.Image}</cms:link>" class="img-responsive" alt="" /></div>
               			<c:if test="${item.value.Link.isSet}"><a class="btn-more hover-effect" href="<cms:link>${item.value.Link}</cms:link>"><fmt:message key="bootstrap.imagerow.frontend.readmore" /></a></c:if>
					</div></c:if>
					<div class="caption">
						<c:choose>
							<c:when test="${item.value.Headline.isSet && item.value.Link.isSet}">
								<h3><a class="hover-effect" href="<cms:link>${item.value.Link}</cms:link>" ${item.rdfa.Headline}>${item.value.Headline}</a></h3>
							</c:when>
							<c:when test="${item.value.Headline.isSet}">
								<h3 ${item.rdfa.Headline}>${item.value.Headline}</h3>
							</c:when>
						</c:choose>
						<p ${item.rdfa.Text}>${item.value.Text}</p>
						<c:if test="${not item.value.Image.isSet and item.value.Link.isSet}"><div style="text-align: right; margin-top: 20px;"><a class="btn-more hover-effect" style="position: relative;" href="<cms:link>${item.value.Link}</cms:link>"><fmt:message key="bootstrap.imagerow.frontend.readmore" /></a></div></c:if>
					</div>
				</div>
			</div>
		</c:forEach>	
	</div>
</div>

</cms:formatter>
</cms:bundle>