<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="org.opencms.xml.containerpage.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="xmlimage.message.new" /></div>
		</c:when>
		<c:otherwise>
        
            <c:set var="copyright"></c:set>
 			<c:if test="${value.Copyright.isSet}">
                <c:set var="copyright">&#13;&copy; ${value.Copyright}</c:set>
			</c:if>
            
            <c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : 'mb-20'}</c:set>
            <c:if test="${cms.element.setting.cssClass.isSet}">
                <c:set var="cssClass" value="${cms.element.setting.cssClass.value}" />
            </c:if>            

            <div class="${cssClass}">
            
            <c:if test="${value.Link.isSet}">
                <a href="<cms:link>${value.Link}</cms:link>">
            </c:if>

			<span ${rdfa.Image}>
                <img 
                    src="<cms:link>${value.Image}</cms:link>" 
                    class="img-responsive ${cms.element.setting.cssShape}"
                    ${content.imageDnd['Image']} 
                    alt="${value.Text}" 
                    title="<c:out value='${value.Text}' escapeXml='false' />" />
            </span>

            <c:if test="${value.Link.isSet}">
                </a>
            </c:if>
			<c:if test="${value.Text.isSet and cms.element.setting.showtext.value == 'true'}">
			     <p class="margin-top-10" ${rdfa.Text}>${value.Text}</p>
            </c:if>  
            </div>               
		</c:otherwise>
	</c:choose>

</cms:formatter>
</cms:bundle>