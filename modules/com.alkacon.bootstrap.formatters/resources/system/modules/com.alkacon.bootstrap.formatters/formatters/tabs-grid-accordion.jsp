<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.tabs">
<cms:formatter var="content" val="value" rdfa="rdfa">

<div class="margin-bottom-30">

	<c:if test="${not cms.element.settings.hidetitle}">
		<div class="headline"><h2 ${rdfa.Title}>${value.Title}</h2></div>
	</c:if>

	<div class="panel-group acc-v2" id="accordion${cms.element.instanceId}">
		<c:forEach var="label" items="${content.valueList.Label}" varStatus="status">
			<div class="panel panel-default">
			  <div class="panel-heading">
			  	<h4 class="panel-title">
					<a class="accordion-toggle ${status.first? 'active':''}" data-toggle="collapse" data-parent="#accordion${cms.element.instanceId}" href="#collapse${cms.element.instanceId}-${status.count}">
					  ${label}
					</a>
				</h4>
			  </div>
			  <div id="collapse${cms.element.instanceId}-${status.count}" class="panel-collapse collapse ${status.first? 'in':''}" style="height: ${status.first?'auto':'0px'};">
				<cms:container name="tab-container${status.count}" type="layoutrowsonly" tagClass="panel-body" maxElements="2">
        	<div class="alert alert-warning fade in">
						<h4><fmt:message key="bootstrap.tabs.emptycontainer.headline"/></h4>
						<p><fmt:message key="bootstrap.tabs.emptycontainer.text"/></p>           
					</div>     
        </cms:container>
			  </div>
			</div><!--/accordion-group-->
		</c:forEach>	
	</div><!--/accordion-->

</div>

</cms:formatter>
</cms:bundle>