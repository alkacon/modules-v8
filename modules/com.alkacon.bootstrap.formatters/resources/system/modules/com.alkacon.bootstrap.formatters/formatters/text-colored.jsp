<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<c:if test="${cms.element.settings.bordercolor != 'none'}"> 
    <c:set var="borderstyle" value="colored-box-border-${cms.element.settings.borderpos} colored-box-border-style-${cms.element.settings.borderstyle} colored-box-border-color-${cms.element.settings.bordercolor}" />
</c:if>
<c:set var="boxclass" value="colored-box ${borderstyle} colored-box-${cms.element.settings.backgroundcolor}" />

<div class="<c:out value="margin-bottom-${cms.element.settings.marginbottom} ${boxclass}" />">

	<c:if test="${not cms.element.settings.hidetitle and value.Headline.isSet}">
		<h2 ${rdfa.Headline}>${value.Headline}</h2>
	</c:if>
	
	<div <c:if test="${not value.Link.exists}">${rdfa.Link}</c:if>>
		<div ${rdfa.Text}>${value.Text}</div>		
		<c:if test="${value.Link.exists}">
			<p ${rdfa.Link}><a class="btn-u btn-u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
		</c:if>		
	</div>	
	
</div>

</cms:formatter>