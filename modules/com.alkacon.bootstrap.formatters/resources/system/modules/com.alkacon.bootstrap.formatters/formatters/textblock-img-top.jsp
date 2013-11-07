<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:formatter var="content">

<div<c:if test="${cms.container.type != 'content'}"> class="row"</c:if>>

<c:forEach var="paragraph" items="${content.valueList.Paragraph}">

	<c:if test="${paragraph.value.Headline.isSet}">
		<div class="headline"><h3 ${paragraph.rdfa.Headline}>${paragraph.value.Headline}</h3></div>
	</c:if>

	<div  ${paragraph.rdfa["Link|Image"]}>

		<c:if test="${paragraph.value.Image.exists}">
			<div class="thumbnail-kenburn margin-bottom-10"><div class="overflow-hidden">
				<cms:img src="${paragraph.value.Image.value.Image}" scaleColor="transparent" width="1200" height="300" scaleType="2" cssclass="img-responsive" alt="${paragraph.value.Image.value.Title}" title="${paragraph.value.Image.value.Title}" />
			</div></div>
		</c:if>
		<div ${paragraph.rdfa.Text}>${paragraph.value.Text}</div>		
		<c:if test="${paragraph.value.Link.exists}">
			<p><a class="btn-u btn-u-small" href="<cms:link>${paragraph.value.Link.value.URI}</cms:link>">${paragraph.value.Link.value.Text}</a></p>
		</c:if>

	</div>
</c:forEach> 

</div>

</cms:formatter>