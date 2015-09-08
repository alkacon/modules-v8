<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="jumbotron">

	<c:if test="${value.Headline.isSet}">
		<h1 ${rdfa.Headline}>${value.Headline}</h1>
	</c:if>

	<p><div ${rdfa.Text}>${value.Text}</div></p>
	<c:if test="${value.Link.exists and value.Link.value.URI.isSet}">
		<p>
			<a class="btn btn-u btn-lg" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a>
		</p>
	</c:if>
</div>

</cms:formatter>