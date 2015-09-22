<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value" rdfa="rdfa">
<c:set var="showelements">${cms.element.settings.showelements}</c:set>

<div class="${cms.element.setting.wrapperclass.isSet ? cms.element.setting.wrapperclass : "mb-20" }">

    <c:if test="${cms.element.setting.anchor.isSet}">
        <a id="${cms.element.setting.anchor}" class="anchor"></a>
    </c:if>
    
	<c:if test="${(showelements == 'all' or showelements == 'headline') and value.Headline.isSet}">
		<div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
	</c:if>
	
	<div <c:if test="${not value.Link.exists}">${rdfa.Link}</c:if>>
		<c:if test="${showelements == 'all' or showelements == 'text'}">
			<div ${rdfa.Text}>${value.Text}</div>		
			<c:if test="${value.Link.exists}">
				<p ${rdfa.Link}><a class="btn btn-u u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
			</c:if>
		</c:if>
	</div>	
	
</div>

</cms:formatter>