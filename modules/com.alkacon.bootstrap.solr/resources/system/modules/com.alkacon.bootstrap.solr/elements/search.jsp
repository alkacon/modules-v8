<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<cms:formatter var="function" rdfa="rdfa">
	<div <c:if test="${cms.container.type == 'content-full'}"> class="row"</c:if>>
		<div id="alkaconSolrSearch" class="lists margin-bottom-20">
			<div class="row margin-bottom-20">
				<div class="col-md-4">
					<div id="solrWidgetAutoComplete"></div>
					<div id="leftCol">
						<div class="margin-bottom-20"></div>
						<div id="solrWidgetTextFacet"></div>
						<div id="solrWidgetAdvisorButton"></div>
						<div id="solrWidgetResetFacets"></div>
					</div>
				</div>
				<div class="col-md-8">
					<div id="loading"></div>
					<div id="rightCol">
						<div id="solrWidgetShareResult"></div>
						<div id="solrWidgetSortBar"></div>
						<div class="row margin-bottom-20"></div>
						<div id="solrWidgetResultCount"></div>
						<div id="solrWidgetResultList"></div>
						<div id="solrWidgetResultPagination"></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</cms:formatter>
