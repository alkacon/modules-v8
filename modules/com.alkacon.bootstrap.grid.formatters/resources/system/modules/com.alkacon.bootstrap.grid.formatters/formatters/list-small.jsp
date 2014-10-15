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

				<div class="posts lists blog-item margin-bottom-20">

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
                <div id="list_small_pages">
        					<div id="list_small_page_1">
        						<cms:include file="%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/elements/list-small-singlepage.jsp:1e5fced7-5436-11e4-9866-005056b61161)">
        							<cms:param name="pageUri" value="${cms.requestContext.uri}" />
        							<cms:param name="__locale" value="${cms.locale}" />
        							<cms:param name="itemsPerPage" value="${itemsPerPage}" />
        							<cms:param name="collectorParam" value="${collectorParam}" />
        							<cms:param name="teaserLength"><c:out value="${cms.element.settings.teaserlength}" default="100" /></cms:param>
                      <cms:param name="showDate"><c:out value="${cms.element.settings.showdate}" default="true" /></cms:param>
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
             <ul id="list_small_pagination"></ul>
          </c:if>

					<c:if test="${con.value.Link.exists}">
						<p><a class="btn-u btn-u-small" href="<cms:link>${con.value.Link.value.URI}</cms:link>">${con.value.Link.value.Text}</a></p>
					</c:if>		

				</div>

        <c:if test="${pages > 1}">
          <script type="text/javascript">
            var currentSmallPage = 1;
            var lastSmallPage = 1;

  					var options = {
  						bootstrapMajorVersion: 3,
  						size: "small",
  						currentPage: 1,
  						numberOfPages: 5,
  						onPageClicked: function(e,originalEvent,type,page){
  							loadSmallListPage(page);
  						},
  						totalPages: ${pages}
  					}

  					$("#list_small_pagination").bootstrapPaginator(options);

            function loadSmallListPage(page) {
              lastSmallPage = currentSmallPage;
	          currentSmallPage = page;
              if (lastSmallPage != currentSmallPage) {
            		if ($('#list_small_page_' + page).length == 0 ) {

            			$.post("<cms:link>%(link.weak:/system/modules/com.alkacon.bootstrap.grid.formatters/elements/list-small-singlepage.jsp:1e5fced7-5436-11e4-9866-005056b61161)</cms:link>", { 
                  	pageUri: "${cms.requestContext.uri}", 
                    __locale: "${cms.locale}",
                    itemsPerPage: "${itemsPerPage}",
                    collectorParam: '${collectorParam}',
                    teaserLength: <c:out value="${cms.element.settings.teaserlength}" default="100" />,
                    showDate: <c:out value="${cms.element.settings.showdate}" default="true" />,
                    currPage: currentSmallPage, }, function(data){ loadSmallListPage2(data); });

            		} else {
            			switchSmallListPage();
            		}
            	}
            }

            function loadSmallListPage2(data) {
            	var singlePage = '<div id="list_small_page_' + currentSmallPage + '" style="display: none;"></div>';
            	$('#list_small_pages').append(singlePage);
            	var divNode = document.getElementById('list_small_page_' + currentSmallPage);
            	divNode.innerHTML = data;
            	switchSmallListPage();
            }
            
            function afterSwitchSmallListPage() {
            	$('#list_small_page_' + lastSmallPage).hide();
            	$('#list_small_page_' + currentSmallPage).fadeIn('fast');
            }
            
            function switchSmallListPage() {
            	$('#list_small_page_' + lastSmallPage).fadeOut('fast', afterSwitchSmallListPage);
            }
  				</script>
        </c:if>

			</c:otherwise>
		</c:choose>

	</div>

</cms:formatter>
</cms:bundle>