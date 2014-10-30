<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30">
	<div class="headline">
		<h2 ${rdfa.Headline}>${value.Headline}</h2>
	</div>
</div>

</cms:formatter>