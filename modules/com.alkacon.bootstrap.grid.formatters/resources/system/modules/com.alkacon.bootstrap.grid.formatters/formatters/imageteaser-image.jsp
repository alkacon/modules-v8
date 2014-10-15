<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.grid.schemas.imageteaser">
<cms:formatter var="content" val="value" rdfa="rdfa">
	<c:choose>
		<c:when test="${cms.element.inMemoryOnly}">
			<div class="alert"><fmt:message key="bootstrap.imageteaser.message.new" /></div>
		</c:when>
		<c:otherwise>
			<c:set var="cssShadow"></c:set>
			<c:if test="${cms.element.setting.shadow.value == 'true'}">
				<c:set var="cssShadow">box-shadow shadow-effect-1</c:set>
			</c:if>
      <c:set var="cssBorder"></c:set>
			<c:if test="${cms.element.setting.border.value == 'true'}">
				<c:set var="cssBorder">img-bordered</c:set>
			</c:if>
      <c:set var="cssShape"></c:set>
			<c:if test="${cms.element.setting.shape.isSet and cms.element.setting.shape.value != 'none'}">
				<c:choose>
          <c:when test="${cms.element.setting.shape.value == 'rounded'}">
            <c:set var="cssShape">rounded-2x</c:set>
          </c:when>
          <c:when test="${cms.element.setting.shape.value == 'circle'}">
            <c:set var="cssShape">rounded-x</c:set>
          </c:when>
        </c:choose>
			</c:if>
      <div class="margin-bottom-20">
      
        <c:if test="${cms.element.setting.zoom.value == 'true'}">
          <script type="text/javascript">
        		jQuery(document).ready(function() {
        			jQuery("#fancyboxzoom${cms.element.id}").fancybox({
        				groupAttr: 'data-rel',
        				prevEffect: 'none',
        				nextEffect: 'none',
        				closeBtn: true,
        				helpers: {
        					title: {
        						type: 'inside'
        						}
        					}
        				});
        		});
        	</script>
        </c:if>
      
			 <div class="${cssShadow}" ${rdfa.Image}>
        <c:choose>
        <c:when test="${cms.element.setting.zoom.value == 'true'}">
          <a class="fancybox-button zoomer" href="<cms:link>${value.Image}</cms:link>" title="${value.Headline}" data-rel="fancybox-button" id="fancyboxzoom${cms.element.id}">
            <span class="overlay-zoom">
        </c:when>
        <c:when test="${value.Link.isSet}">
          <a href="<cms:link>${value.Link}</cms:link>">
        </c:when>
        </c:choose>				
				  <img src="<cms:link>${value.Image}</cms:link>" class="${cssShape} img-responsive ${cssBorder}" alt="${value.Headline}" />
        <c:choose>
        <c:when test="${cms.element.setting.zoom.value == 'true'}">
          <span class="zoom-icon"></span>
          </span>
          </a>
        </c:when>
        <c:when test="${value.Link.isSet}">
          </a>
        </c:when>
        </c:choose>	
			 </div>
       <c:if test="${cms.element.setting.showtext.value == 'true'}">
        <p ${rdfa.Text}>${value.Text}</p>
        <c:if test="${cms.element.setting.zoom.value == 'true' and value.Link.isSet}"><p><a class="btn-u btn-u-small" href="<cms:link>${value.Link}</cms:link>"><fmt:message key="bootstrap.imageteaser.frontend.readmore" /></a></p></c:if>
       </c:if>
      </div>
		</c:otherwise>
	</c:choose>

</cms:formatter>
</cms:bundle>