<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<fmt:bundle basename="com.alkacon.bootstrap.schemas.imagerow">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div>

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>

	<c:forEach var="item" items="${content.valueList.Item}" varStatus="status"><c:if test="${status.last}"><c:set var="itemCount" value="${status.count}" /></c:if></c:forEach>
	<ul class="thumbnails">
		<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
			<li class="span<fmt:formatNumber type="number" value="${12 / itemCount}" />">
            	<div class="thumbnail-style thumbnail-kenburn">
           	 		<c:if test="${item.value.Image.isSet}"><div class="thumbnail-img">
            			<div class="overflow-hidden"><img src="<cms:link>${item.value.Image}</cms:link>" alt="" /></div>
               			<c:if test="${item.value.Link.isSet}"><a class="btn-more hover-effect" href="<cms:link>${item.value.Link}</cms:link>">read more +</a></c:if>				
					</div></c:if>
					<c:if test="${item.value.Headline.isSet}"><h3><a class="hover-effect" href="#">${item.value.Headline}</a></h3></c:if>
					<p>${item.value.Text}</p>
				</div>
			</li>
		</c:forEach>
	</ul>		

</div>

</cms:formatter>
</fmt:bundle>