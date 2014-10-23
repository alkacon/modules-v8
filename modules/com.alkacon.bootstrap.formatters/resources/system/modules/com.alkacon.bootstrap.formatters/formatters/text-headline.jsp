<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30">
	<div class="headline">
		<c:choose>
		<c:when test="${value.Headline.isSet}">
			<h2 ${rdfa.Headline}>${value.Headline}</h2>
		</c:when>
		<c:otherwise>
			<h2 ${rdfa.Headline}>----------</h2>
		</c:otherwise>
		</c:choose>
	</div>

</div>

</cms:formatter>