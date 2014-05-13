<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.teaserrow">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div>

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>
	
	<div class="row margin-bottom-10">
		<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
			<div ${item.rdfa.Link} class="${cms:lookup(fn:length(content.valueList.Item), '1:col-xs-12|2:col-sm-6|3:col-sm-4|4:col-md-3 col-sm-6|5:col-md-2 col-sm-6|6:col-md-2 col-sm-4')}">				
				<div class="servive-block servive-block-${item.value.Color}">
					<c:if test="${item.value.Link.isSet}"><a href="<cms:link>${item.value.Link}</cms:link>"></c:if>
					<h2 class="heading-md" ${item.rdfa.Headline}>${item.value.Headline}</h2>
					<div><i class="icon-lg icon-bg-${item.value.Color} fa fa-${fn:toLowerCase(item.value.Icon.stringValue)}<c:if test="${fn:endsWith(fn:toLowerCase(item.value.Icon.stringValue), 'lightbulb')}">-o</c:if>"></i></div>
					<p ${item.rdfa.Text}>${item.value.Text}</p>
					<c:if test="${item.value.Link.isSet}"></a></c:if>
				</div>
			</div>
		</c:forEach>	
	</div>

</div>

</cms:formatter>
</cms:bundle>