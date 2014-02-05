<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.imagerow">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div>

	<script type="text/javascript">
		jQuery(document).ready(function() {
			jQuery(".fancybox-imgrow-button").fancybox({
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

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>

	<div class="row">
		<c:forEach var="item" items="${content.valueList.Item}">
			<div ${item.rdfa["Link|Image"]} class="${cms:lookup(fn:length(content.valueList.Item), '1:col-xs-12|2:col-sm-6|3:col-sm-4|4:col-md-3 col-sm-6|5:col-md-2 col-sm-6|6:col-md-2 col-sm-4')}">				
                <div class="thumbnails">
           	 		<c:if test="${item.value.Image.isSet}">
						<a class=" fancybox-imgrow-button zoomer" data-rel="fancybox-imgrow-button" title="${item.value.Text}" href="<cms:link>${item.value.Image}</cms:link>">
							<div class="overlay-zoom thumbnail">  
								<cms:img alt="${item.value.Text}" title="${item.value.Text}" src="${item.value.Image}" scaleType="2" scaleColor="transparent" scaleQuality="75" noDim="true" width="${720}" height="${450}" cssclass="img-responsive" />
								<div class="zoom-icon"></div>                   
							</div>
						</a>
					</c:if>

					<c:choose>
						<c:when test="${item.value.Headline.isSet && item.value.Link.isSet}">
							<div class="center"><p><a class="hover-effect" href="<cms:link>${item.value.Link}</cms:link>" ${item.rdfa.Headline}><strong>${item.value.Headline}</strong></a></p></div>
						</c:when>
						<c:when test="${item.value.Headline.isSet}">
							<div class="center"><p><strong ${item.rdfa.Headline}>${item.value.Headline}</strong></p></div>
						</c:when>
					</c:choose>
					<c:if test="${not item.value.Image.isSet and item.value.Link.isSet}"><div style="text-align: right; margin-top: 20px;"><a class="btn-more hover-effect" style="position: relative;" href="<cms:link>${item.value.Link}</cms:link>"><fmt:message key="bootstrap.imagerow.frontend.readmore" /></a></div></c:if>

				</div>
			</div>
		</c:forEach>
	</div>
</div>

</cms:formatter>
</cms:bundle>