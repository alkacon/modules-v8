<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.image">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="bootstrap.image.message.new" /></div>
		</c:when>
		<c:otherwise>
			<c:set var="cssShadow"></c:set>
			<c:if test="${cms.element.setting.shadow.value == 'true'}">
				<c:set var="cssShadow">box-shadow shadow-effect-1</c:set>
			</c:if>
            <c:set var="cssBorder"></c:set>
			<c:if test="${cms.element.setting.border.value == 'true'}">
				<c:set var="cssBorder">div-bordered</c:set>
			</c:if>
            <c:set var="copyright"></c:set>
 			<c:if test="${value.Copyright.isSet}">
                <c:set var="copyright">&#13;&copy; ${value.Copyright}</c:set>
			</c:if>            

            <div class="margin-bottom-20">

            <c:if test="${cms.element.setting.showheadline.value == 'top'}">
                <div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
            </c:if>

			<div class="<c:out value='${cssShadow} ${cssBorder}' />">

            <c:if test="${value.Link.isSet and cms.element.setting.showlink.value == 'image'}">
              <a href="<cms:link>${value.Link}</cms:link>">
            </c:if>

			<span ${rdfa.Image}>
                <div class="thumbnail-kenburn overflow-hidden">
                <img 
                    src="<cms:link>${value.Image}</cms:link>"
                    ${content.imageDnd['Image']} 
                    class="img-responsive" 
                    alt="${value.Headline}" 
                    title="<c:out value='${value.Headline} ${copyright}' escapeXml='false' />" />
                </div>
            </span>

            <c:if test="${value.Link.isSet and cms.element.setting.showlink.value == 'image'}">
              </a>
            </c:if>

			</div>
       
            <c:choose>
                <c:when test="${cms.element.setting.showheadline.value == 'bottom'}">
                    <h2 ${rdfa.Headline}>${value.Headline}</h2>
                </c:when>
                <c:when test="${cms.element.setting.showheadline.value == 'bottomcenter'}">
                    <div class="center"><div class="margin-bottom-20"></div><p><strong ${rdfa.Headline}>${value.Headline}</strong></p></div>
                </c:when>
            </c:choose>
            <c:if test="${value.Text.isSet and cms.element.setting.showtext.value == 'true'}">
                <p class="margin-top-10" ${rdfa.Text}>${value.Text}</p>
            </c:if>        

            <c:if test="${value.Link.isSet and cms.element.setting.showlink.value == 'button'}">
                <p><a class="btn-u btn-u-small" href="<cms:link>${value.Link}</cms:link>"><fmt:message key="bootstrap.image.frontend.readmore" /></a></p>
            </c:if>

            </div>               
		</c:otherwise>
	</c:choose>

</cms:formatter>
</cms:bundle>