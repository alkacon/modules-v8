<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.grid.schemas.list">

<cms:formatter var="con" rdfa="rdfa">

	<c:if test="${'' ne con.value.SortOrder && '' ne con.value.RowCount && '' ne con.value.CreatePath}">
		<c:set var="solrParamType">&fq=type:bsg-blog</c:set>
		<c:set var="solrParamDirs">&fq=parent-folders:"/sites/default/"</c:set>
		<c:set var="solrFilterQue">${con.value.FilterQueries}</c:set>
		<c:set var="solrParamSort">&sort=collector.priority_prop ${con.value.SortOrder}, newsdate_${cms.locale}_dt ${con.value.SortOrder}</c:set>
		<c:set var="solrParamRows">&rows=${con.value.RowCount}</c:set>
		<c:set var="resCreatePath">|createPath=${con.value.CreatePath}</c:set>
		<c:set var="collectorParam">${solrParamType}${solrParamDirs}${solrFilterQue}${solrParamSort}${solrParamRows}${resCreatePath}</c:set>
	</c:if>

	<div>

		<c:choose>
			<c:when test="${cms.element.inMemoryOnly}">
				<div class="alert"><fmt:message key="bootstrap.list.message.new" /></div>
			</c:when>
			<c:when test="${empty collectorParam}">
				<div class="alert"><fmt:message key="bootstrap.list.message.edit" /></div>
			</c:when>
			<c:otherwise>
      
				<c:if test="${not cms.element.settings.hidetitle}">
					<div class="headline headline-md"><h2 ${rdfa.Headline}><c:out value="${con.value.Headline}" escapeXml="false" /></h2></div>
				</c:if>			

				<div class="posts lists blog-item">

        	<cms:contentload collector="byContext" param="${collectorParam}" preload="true">
						<cms:contentinfo var="info" />
          </cms:contentload>

          <c:set var="itemsPerPage" value="100" />
          <c:if test="${con.value.ItemsPerPage.isSet}"><c:set var="itemsPerPage">${con.value.ItemsPerPage}</c:set></c:if>
          <fmt:parseNumber var="pages" value="${info.resultSize / itemsPerPage}" integerOnly="true" />
          <c:if test="${(info.resultSize % itemsPerPage) > 0}">
						<c:set var="pages" value="${pages + 1}" />
					</c:if>
          <c:set var="currPage" value="1" />
					
						<c:choose>
            	<c:when test="${info.resultSize > 0}">

              	<div id="list_large_pages">
        					<div id="list_large_page_1">
        						<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/elements/list-large-singlepage.jsp:ea05d64f-5452-11e4-9866-005056b61161)">
        							<cms:param name="pageUri" value="${cms.requestContext.uri}" />
        							<cms:param name="__locale" value="${cms.locale}" />
        							<cms:param name="itemsPerPage" value="${itemsPerPage}" />
        							<cms:param name="collectorParam" value="${collectorParam}" />
        							<cms:param name="teaserLength"><c:out value="${cms.element.settings.teaserlength}" default="100" /></cms:param>
                      <cms:param name="showDate"><c:out value="${cms.element.settings.showdate}" default="true" /></cms:param>
                      <cms:param name="buttonColor"><c:out value="${cms.element.settings.buttoncolor}" default="red" /></cms:param>
        							<cms:param name="currPage" value="1" />
        						</cms:include>
        					</div>
                </div>
							</c:when>
            	<c:otherwise>
            		<div class="alert alert-warning fade in">
            			<fmt:message key="bootstrap.list.message.empty" />
                	<cms:contentload collector="byContext" param="${collectorParam}" editEmpty="true"></cms:contentload>
								</div>
            	</c:otherwise>
            </c:choose>

          <c:if test="${pages > 1}">
             <ul id="list_large_pagination"></ul>
          </c:if>

					<c:if test="${con.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${con.value.Link.value.URI}</cms:link>">${con.value.Link.value.Text}</a></p>
					</c:if>		

				</div>

        <c:if test="${pages > 1}">
          <script type="text/javascript">
            var currentLargePage = 1;
            var lastLargePage = 1;

  					var options = {
  						bootstrapMajorVersion: 3,
  						size: "normal",
  						currentPage: 1,
  						numberOfPages: 5,
  						onPageClicked: function(e,originalEvent,type,page){
  							loadLargeListPage(page);
  						},
  						totalPages: ${pages}
  					}

  					$("#list_large_pagination").bootstrapPaginator(options);

            function loadLargeListPage(page) {
              lastLargePage = currentLargePage;
	          currentLargePage = page;
              if (lastLargePage != currentLargePage) {
            		if ($('#list_large_page_' + page).length == 0 ) {

            			$.post("<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/elements/list-large-singlepage.jsp:ea05d64f-5452-11e4-9866-005056b61161)</cms:link>", { 
                  	pageUri: "${cms.requestContext.uri}", 
                    __locale: "${cms.locale}",
                    itemsPerPage: "${itemsPerPage}",
                    collectorParam: '${collectorParam}',
                    teaserLength: <c:out value="${cms.element.settings.teaserlength}" default="100" />,
                    showDate: <c:out value="${cms.element.settings.showdate}" default="true" />,
                    buttonColor: "<c:out value="${cms.element.settings.buttoncolor}" default="red" />",
                    currPage: currentLargePage, }, function(data){ loadLargeListPage2(data); });

            		} else {
            			switchLargeListPage();
            		}
            	}
            }

            function loadLargeListPage2(data) {
            	var singlePage = '<div id="list_large_page_' + currentLargePage + '" style="display: none;"></div>';
            	$('#list_large_pages').append(singlePage);
            	var divNode = document.getElementById('list_large_page_' + currentLargePage);
            	divNode.innerHTML = data;
            	switchLargeListPage();
            }
            
            function afterSwitchLargeListPage() {
            	$('#list_large_page_' + lastLargePage).hide();
            	$('#list_large_page_' + currentLargePage).fadeIn('fast');
            }
            
            function switchLargeListPage() {
            	$('#list_large_page_' + lastLargePage).fadeOut('fast', afterSwitchLargeListPage);
            }
  				</script>
        </c:if>

			</c:otherwise>
		</c:choose>

	</div>
	
</cms:formatter>
</cms:bundle>