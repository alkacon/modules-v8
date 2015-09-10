<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.schemas.carousel">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30">

	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="unify.carousel.message.new" /></div>
		</c:when>
		<c:otherwise>
		
			<c:if test="${not cms.element.settings.hidetitle}">
				<div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
			</c:if>

			<div class="carousel slide carousel-v1" id="myCarousel-${content.file.structureId}">
				<div class="carousel-inner">
					<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
						<div class="item<c:if test="${status.first}"> active</c:if>">
							<cms:img alt="" src="${item.value.Image}" scaleType="2" scaleColor="transparent" scaleQuality="75" noDim="true" cssclass="img-responsive"/>
							<div class="carousel-caption">
								<c:if test="${item.value.Headline.isSet}">
									<h3 ${item.rdfa.Headline}>${item.value.Headline}</h3>
								</c:if>
								<p ${item.rdfa.Text}>${item.value.Text}</p>
							</div>
						</div>
					</c:forEach>
				</div>
				<div class="carousel-arrow">
					<a data-slide="prev" href="#myCarousel-${content.file.structureId}" class="left carousel-control">
						<i class="fa fa-angle-left"></i>
					</a>
					<a data-slide="next" href="#myCarousel-${content.file.structureId}" class="right carousel-control">
						<i class="fa fa-angle-right"></i>
					</a>
				</div>
			</div>

		</c:otherwise>
	</c:choose>
</div>

</cms:formatter>
</cms:bundle>