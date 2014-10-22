<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30 <c:out value="${cms.element.settings.wrapperclass}" default="" />">

	<c:if test="${not cms.element.settings.hidetitle and value.Headline.isSet}">
		<div class="headline"><h2 ${rdfa.Headline}>${value.Headline}</h2></div>
	</c:if>
	
	<div ${rdfa.Link}>
		<div ${rdfa.Text}>${value.Text}</div>		
		<c:if test="${value.Link.exists}">
			<p><a class="btn-u btn-u-small" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a></p>
		</c:if>		
	</div>	
	
</div>

</cms:formatter>