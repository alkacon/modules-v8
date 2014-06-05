<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="<c:if test="${cms.container.type == 'content-wide'}">row </c:if>margin-bottom-30">

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h3 ${rdfa.Title}>${value.Title}</h3></div>
	</c:if>

	<div class="tab-v1">
		<ul class="nav nav-tabs">
			<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
				<li class="${status.first? 'active':''}"><a href="#${cms.container.name}-${cms.element.instanceId}-tab-container${status.count}" data-toggle="tab">${label}</a></li>
			</c:forEach>
		</ul>

		<div class="tab-content">
			<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
				<cms:container name="tab-container${status.count}" type="content" tagClass="tab-pane ${status.first? 'active':''}"></cms:container>
			</c:forEach>
		</div><!--/tab-content-->
	</div><!--/tab-v1-->

</div>

</cms:formatter>