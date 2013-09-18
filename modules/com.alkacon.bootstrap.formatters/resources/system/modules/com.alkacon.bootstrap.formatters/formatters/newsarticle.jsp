<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div<c:if test="${cms.container.type == 'content-full'}"> class="row-fluid"</c:if>>
	<div class="headline">
		<h3 ${rdfa.Title}>${value.Title}</h3>
		<div ${rdfa.Description} class="paragraph margin-bottom-20">${value.Description}</div>
	</div>
</div>

</cms:formatter>
