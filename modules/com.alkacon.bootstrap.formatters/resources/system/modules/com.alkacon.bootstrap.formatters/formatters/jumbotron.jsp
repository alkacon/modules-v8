<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="pagefullwidth"><cms:property name="bs.page.fullwidth" file="search" default="false-bc" /></c:set>

<cms:formatter var="content" val="value" rdfa="rdfa">

<c:if test="${cms.container.type == 'content-full' && (pagefullwidth != 'true') && (pagefullwidth != 'true-bc')}"><div class="row"></c:if>

<div class="jumbotron">
	<h1 ${rdfa.Title}>${value.Title}</h1>
	<p ${rdfa.Text}>${value.Text}</p>
	<c:if test="${value.Link.exists and value.Link.value.URI.isSet}">
		<p>
			<a class="btn btn-u btn-lg" href="<cms:link>${value.Link.value.URI}</cms:link>">${value.Link.value.Text}</a>
		</p>
	</c:if>
</div>

<c:if test="${cms.container.type == 'content-full' && (pagefullwidth != 'true') && (pagefullwidth != 'true-bc')}"></div></c:if>

</cms:formatter>