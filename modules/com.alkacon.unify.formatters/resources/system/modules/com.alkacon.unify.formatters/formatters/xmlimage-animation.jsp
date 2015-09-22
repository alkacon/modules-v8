<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.formatters.messages">
<cms:formatter var="content" val="value" rdfa="rdfa">
<div>
	<div class="thumbnails thumbnail-style thumbnail-kenburn" <c:if test="${not value.Image.isSet}">${rdfa.Image}</c:if>>

        <c:set var="showTextBelow" value="false" />
        <c:if test="${(value.Headline.isSet and cms.element.setting.showheadline.value == 'bottom') 
            or (cms.element.setting.showtext.value == 'true') 
            or (value.Link.isSet and cms.element.setting.showlink.value == 'button')}">
            <c:set var="showTextBelow" value="true" />
        </c:if>
        <c:set var="copyright"></c:set>
        <c:if test="${value.Copyright.isSet}">
            <c:set var="copyright">&#13;&copy; ${value.Copyright}</c:set>
        </c:if>   

         <c:if test="${value.Headline.isSet and cms.element.setting.showheadline.value == 'top'}">
              <div class="caption">
  				<c:choose>
  					<c:when test="${value.Link.isSet and cms.element.setting.showlink.value == 'headline'}">
  						<div class="headline"><h2><a class="hover-effect" href="<cms:link>${value.Link}</cms:link>" ${rdfa.Headline}>${value.Headline}</a></h2></div>
  					</c:when>
  					<c:otherwise>
  						<div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
  					</c:otherwise>
  				</c:choose>
  			</div>
        </c:if>
        
        <c:set var="cssClass">${cms.element.parent.setting.cssHints.isSet ? cms.element.parent.setting.cssHints : ''}</c:set>
        <c:if test="${cms.element.setting.cssClass.isSet}">
            <c:set var="cssClass" value="${cms.element.setting.cssClass.value}" />
        </c:if>

        <c:if test="${value.Image.isSet}"><div <c:choose><c:when test="${showTextBelow}">class="thumbnail-img ${cssClass}"</c:when><c:otherwise>class="${cssClass}"</c:otherwise></c:choose> ${rdfa.Image} ${content.imageDnd['Image']}>
            <div class="overflow-hidden">
                <img 
                    src="<cms:link>${value.Image}</cms:link>" 
                    class="img-responsive ${cms.element.setting.cssShape}"  
                    alt="${value.Headline}" 
                    title="<c:out value='${value.Headline} ${copyright}' escapeXml='false' />" />
            </div>
			<c:if test="${value.Link.isSet and cms.element.setting.showlink.value == 'image'}"><a class="btn-more hover-effect" href="<cms:link>${value.Link}</cms:link>"><fmt:message key="unify.image.frontend.readmore" /></a></c:if>
			</div>
        </c:if>

        <c:if test="${showTextBelow}">
            <div class="caption">
				<c:if test="${value.Headline.isSet and fn:startsWith(cms.element.setting.showheadline.value,'bottom')}">
      				<c:choose>
      					<c:when test="${value.Link.isSet and cms.element.setting.showlink.value == 'headline'}">
      						<h2><a class="hover-effect" href="<cms:link>${value.Link}</cms:link>" ${rdfa.Headline}>${value.Headline}</a></h2>
      					</c:when>
      					<c:when test="${cms.element.setting.showheadline.value == 'bottomcenter'}">
                   			<div class="center"><div class="margin-bottom-20"></div><p><strong ${rdfa.Headline}>${value.Headline}</strong></p></div>
                		</c:when>
      					<c:otherwise>
      						<h2 ${rdfa.Headline}>${value.Headline}</h2>
      					</c:otherwise>
      				</c:choose>
                </c:if>
				<c:if test="${value.Text.isSet and cms.element.setting.showtext.value == 'true'}">
                    <p ${rdfa.Text}>${value.Text}</p>
                </c:if>
				<c:if test="${value.Link.isSet and cms.element.setting.showlink.value == 'button'}"><div style="text-align: right; margin-top: 20px;"><a class="btn-more hover-effect" style="position: relative;" href="<cms:link>${value.Link}</cms:link>"><fmt:message key="unify.image.frontend.readmore" /></a></div></c:if>
			</div>
        </c:if>
	</div>
</div>
</cms:formatter>
</cms:bundle>