<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<cms:formatter var="function" rdfa="rdfa">
	<div <c:if test="${cms.container.type == 'content-full'}"> class="row"</c:if>>
		<div id="alkaconSearch" class="lists margin-bottom-20">
			<div class="row margin-bottom-20">
				<div class="col-md-4">
					<div id="searchWidgetAutoComplete"></div>
					<div id="leftCol">
						<div class="margin-bottom-20"></div>
						<div id="searchWidgetTextFacet"></div>
						<div id="searchWidgetAdvisorButton"></div>
						<div id="searchWidgetResetFacets"></div>
					</div>
				</div>
				<div class="col-md-8">
					<div id="loading"></div>
					<div id="rightCol">
						<div id="searchWidgetShareResult"></div>
						<div id="searchWidgetSortBar"></div>
						<div class="row margin-bottom-20"></div>
						<div id="searchWidgetResultCount"></div>
						<div id="searchWidgetResultList"></div>
						<div id="searchWidgetResultPagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</cms:formatter>
