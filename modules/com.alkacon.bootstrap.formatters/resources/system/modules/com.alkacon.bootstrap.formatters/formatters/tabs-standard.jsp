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
			<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
				<li<c:if test="${status.first}"> class="active"</c:if>><a href="#tab${cms.element.id}-${status.count}" data-toggle="tab">${item.value.Label}</a></li>
			</c:forEach>
		</ul>

		<div class="tab-content">
			<c:forEach var="item" items="${content.valueList.Item}" varStatus="status">
				<div class="tab-pane<c:if test="${status.first}"> active</c:if>" id="tab${cms.element.id}-${status.count}">
					<c:if test="${item.value.Image.isSet}"><div class="row"><div class="col-sm-3 hidden-xs"><img class="img-responsive img-tab-space" src="<cms:link>${item.value.Image}</cms:link>" alt="" /></div><div class="col-sm-9"></c:if>
					<c:if test="${item.value.Headline.isSet}"><h4>${item.value.Headline}</h4></c:if>
					<div ${item.rdfa.Text}>${item.value.Text}</div>
					<c:if test="${item.value.Image.isSet}"></div></div></c:if>
				</div>
			</c:forEach>
		</div><!--/tab-content-->
	</div><!--/tab-v1-->

</div>

</cms:formatter>