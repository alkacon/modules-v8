<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.grid.schemas.tabs">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30">

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
	</c:if>

	<div class="tab-v1">
		<ul class="nav nav-tabs">
			<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
				<li class="${status.first? 'active':''}"><a href="#${cms.container.name}-${cms.element.instanceId}-tab-container${status.count}" data-toggle="tab">${label}</a></li>
			</c:forEach>
		</ul>

		<div class="tab-content">
			<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
				<cms:container name="tab-container${status.count}" type="layoutrowsonly" tagClass="tab-pane ${status.first? 'active':''}" maxElements="2">
					<div class="alert alert-warning fade in">
						<h4><fmt:message key="bootstrap.tabs.emptycontainer.headline"/></h4>
						<p><fmt:message key="bootstrap.tabs.emptycontainer.text"/></p>           
					</div>     
        </cms:container>
			</c:forEach>
		</div><!--/tab-content-->
	</div><!--/tab-v1-->

</div>

</cms:formatter>
</cms:bundle>