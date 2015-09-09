<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.schemas.iconbox">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<div class="service-block ${cms.element.setting.rounded} service-block-${cms.element.setting.color}" ${rdfa.Link}>
    <c:choose>
    	<c:when test="${cms.element.inMemoryOnly}">
    		<p><fmt:message key="unify.iconbox.message.new" /></p>
    	</c:when>
        <c:otherwise>
            <c:if test="${value.Link.isSet}"><a href="<cms:link>${value.Link}</cms:link>"></c:if>
  			<h2 class="heading-md" ${rdfa.Headline}>${value.Headline}</h2>
  			<div><i class="icon-lg icon-bg-${cms.element.setting.color} fa fa-${fn:toLowerCase(value.Icon.stringValue)}<c:if test="${fn:endsWith(fn:toLowerCase(value.Icon.stringValue), 'lightbulb')}">-o</c:if>"></i></div>
  			<p ${rdfa.Text}>${value.Text}</p>
  			<c:if test="${value.Link.isSet}"></a></c:if>
        </c:otherwise>
    </c:choose>
	</div>
</cms:formatter>
</cms:bundle>