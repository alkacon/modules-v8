<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.grid.schemas.iconbox">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<div class="servive-block servive-block-colored servive-block-${value.Color}" ${rdfa.Link}>
		<c:if test="${value.Link.isSet}"><a href="<cms:link>${value.Link}</cms:link>"></c:if>
			<h2 class="heading-md" ${rdfa.Headline}>${value.Headline}</h2>
			<div><i class="icon-lg icon-bg-${value.Color} fa fa-${fn:toLowerCase(value.Icon.stringValue)}<c:if test="${fn:endsWith(fn:toLowerCase(value.Icon.stringValue), 'lightbulb')}">-o</c:if>"></i></div>
			<p ${rdfa.Text}>${value.Text}</p>
			<c:if test="${value.Link.isSet}"></a></c:if>
	</div>
</cms:formatter>
</cms:bundle>