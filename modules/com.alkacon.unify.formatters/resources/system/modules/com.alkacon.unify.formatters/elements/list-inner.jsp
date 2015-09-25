<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"
	import="org.opencms.relations.CmsCategoryService, org.opencms.file.CmsObject"%>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.unify.formatters.list">

	<c:set var="cmsObject" value="${cms.vfs.cmsObject}" />
	<%
	    CmsObject cmsObject = (CmsObject)pageContext.getAttribute("cmsObject");
	%>

	<%--c:set var="additionalParams">typesToCollect=${param.typesToCollect}&extraQueries=<%=CmsEncoder.encode(request.getParameter("extraQueries"))%>&pathes=${param.pathes}&itemsPerPage=${itemsPerPage}&teaserLength=${param.teaserLength}&sortOrder=${param.sortOrder}&__locale=${cms.locale}&pageUri=${param.pageUri}</c:set --%>
	<c:set var="buttonColor">${param.buttonColor}</c:set>
	<c:set var="teaserLength">${param.teaserLength}</c:set>
	<c:set var="solrParamType">fq=type:${(param.typesToCollect eq "both") ? "u-blog OR u-event" : ((param.typesToCollect eq "event") ? "u-event" : "u-blog")}</c:set>
	<c:set var="solrParamDirs">&fq=parent-folders:${param.pathes}</c:set>
	<c:set var="solrFilterQue">${param.extraQueries}</c:set>
	<c:set var="sortOptionAsc">{ "label" : sortorder.asc, "paramvalue" : "asc", "solrvalue" : "newsdate_${cms.locale}_dt asc" }</c:set>
	<c:set var="sortOptionDesc">{ "label" : sortorder.desc, "paramvalue" : "desc", "solrvalue" : "newsdate_${cms.locale}_dt desc" }</c:set>
	<c:set var="extraSolrParams">${solrParamType}${solrParamDirs}${param.extraQueries}</c:set>
	<c:set var="categoryFacetField">category_exact</c:set>
	<c:set var="searchConfig">
		{ "ignorequery" : true,
		  "extrasolrparams" : "${fn:replace(extraSolrParams,'"','\\"')}",
		  "pagesize" : ${param.itemsPerPage},
		  "sortoptions" : [
		  	<c:choose>
			<c:when test='${param.sortOrder eq "asc"}'>	
		  		${sortOptionAsc},	  		
		  		${sortOptionDesc}
		  	</c:when>
			<c:otherwise>
				${sortOptionDesc},
		  		${sortOptionAsc}
		  	</c:otherwise>
		</c:choose>
		  ],
		  "fieldfacets" : [
		  	{ "field" : "${categoryFacetField}", "label" : "facet.category.label", "order" : "index", "mincount" : 1 }
		  ],
		  pagenavlength: 5
		 }
</c:set>
	<div>
		<cms:search configString="${searchConfig}" var="search"
			addContentInfo="true" />

		<c:choose>
			<c:when test="${search.numFound > 0}">
				<div id="list_large_pages">
					<div class="row mb-20 pull-right">
						<section class="btn-group">
							<%-- Category filter --%>
							<c:set var="facetController"
								value="${search.controller.fieldFacets.fieldFacetController[categoryFacetField]}" />
							<c:set var="facetResult"
								value="${search.fieldFacet[categoryFacetField]}" />
							<c:if
								test="${not empty facetResult and cms:getListSize(facetResult.values) > 0}">

								<div class="btn-group ">
									<button type="button"
										class="dropdown-toggle btn-u btn-u-<c:out value="${buttonColor}" default="red" />"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false" id="dropdownMenu1" aria-expanded="true">
										<fmt:message key="${facetController.config.label}" />
										&nbsp; <span class="caret"></span>
									</button>
									<ul
										class="dropdown-menu dropdown-<c:out value="${buttonColor}" default="red" />">
										<li
											${cms:getListSize(facetController.state.checkedEntries) == 0?'class="active"' : ""}><a
											href="javascript:void(0)"
											onclick="reloadInnerList('${search.stateParameters.resetFacetState[categoryFacetField]}')"><fmt:message
													key="facet.category.none" /></a></li>
										<li role="separator" class="divider"></li>

										<c:forEach var="value" items="${facetResult.values}">
											<c:set var="selected">${facetController.state.isChecked[value.name] ? ' class="active"' : ""}</c:set>
											<%-- BEGIN: Calculate category label --%>
											<c:set var="itemName">${value.name}</c:set>
											<c:set var="basePath"><%=org.opencms.relations.CmsCategoryService.getInstance().readCategory(
                                            cmsObject,
                                            (String)pageContext.getAttribute("itemName"),
                                            request.getParameter("pageUri")).getBasePath()%></c:set>
											<c:set var="basePath">${fn:substring(basePath,0,fn:length(basePath)-1)}</c:set>
											<c:set var="folders" value='${fn:split(itemName,"/")}' />
											<c:set var="label"></c:set>
											<c:forEach begin="0" end="${fn:length(folders)-1}"
												varStatus="loop">
												<c:set var="basePath">${basePath}/${folders[loop.index]}</c:set>
												<c:set var="label">${label} / <%=org.opencms.relations.CmsCategoryService.getInstance().getCategory(
                                                cmsObject,
                                                (String)pageContext.getAttribute("basePath")).getTitle()%></c:set>
											</c:forEach>
											<c:set var="label">${fn:substring(label,2,-1)}</c:set>
											<%-- END: Calculate category label --%>
											<li ${selected}><a href="javascript:void(0)"
												onclick="reloadInnerList('${search.stateParameters.resetFacetState[categoryFacetField].checkFacetItem[categoryFacetField][value.name]}')">${label}
													(${value.count})</a>
										</c:forEach>
									</ul>
								</div>
							</c:if>

							<%-- Sort options --%>
							<c:set var="sortController" value="${search.controller.sorting}" />
							<c:if
								test="${not empty sortController and not empty sortController.config.sortOptions}">
								<c:set var="sortOption"
									value="${sortController.config.sortOptions[0]}"></c:set>
								<c:set var="sortIndex" value="1" />
								<c:if
									test="${sortController.state.checkSelected[sortOption] != true}">
									<c:set var="sortOption"
										value="${sortController.config.sortOptions[1]}"></c:set>
									<c:set var="sortIndex" value="0" />
								</c:if>


								<div class="btn-group">
									<button type="button"
										class="btn-u btn-u-<c:out value="${buttonColor}" default="red" /> dropdown-toggle"
										data-toggle="dropdown" aria-haspopup="true"
										aria-expanded="false" id="dropdownMenu2" aria-expanded="true">
										<fmt:message key="sort.options.label" />
										&nbsp; <span class="caret"></span>
									</button>
									<ul
										class="dropdown-menu dropdown-<c:out value="${buttonColor}" default="red" />"
										aria-labelledby="dropdownMenu2">
										<c:forEach var="sortOption"
											items="${sortController.config.sortOptions}">
											<c:set var="selected">${sortController.state.checkSelected[sortOption] ? ' class="active"' : ""}</c:set>
											<li ${selected}><a href="javascript:void(0)"
												onclick="reloadInnerList('${search.stateParameters.setSortOption[sortOption.paramValue]}')"><fmt:message
														key="${sortOption.label}" /></a></li>
										</c:forEach>
									</ul>
								</div>
							</c:if>
						</section>
					</div>


					<div id="list_large_page_1">
						<c:forEach var="result" items="${search.searchResults}">
							<c:set var="content" value="${result.xmlContent}" />
							<c:set var="paragraph"
								value="${content.valueList.Paragraph['0']}" />
							<cms:edit uuid='${result.fields["id"]}' create="true"
								delete="true">
								<div class="row margin-bottom-20">
									<c:choose>
										<c:when test="${param.typesToCollect == 'event'}">
											<div
												class="date-dark col-sm-2 hidden-xs">
												<div class="day">
													<fmt:formatDate
														value="${cms:convertDate(content.value.Date)}" pattern="E"
														type="date" />
												</div>
												<h3>
													<fmt:formatDate
														value="${cms:convertDate(content.value.Date)}"
														pattern="dd" type="date" />
												</h3>
												<div class="monthYear">
													<fmt:formatDate
														value="${cms:convertDate(content.value.Date)}"
														pattern="MMM yyyy" type="date" />
												</div>
											</div>
										</c:when>
										<c:otherwise>
											<c:if test="${paragraph.value.Image.exists}">
												<div class="col-md-4 search-img">
													<cms:img src="${paragraph.value.Image.value.Image}"
														width="800" cssclass="img-responsive"
														scaleColor="transparent" scaleType="0" noDim="true"
														alt="${paragraph.value.Image.value.Title}"
														title="${paragraph.value.Image.value.Title}" />
												</div>
											</c:if>
										</c:otherwise>
									</c:choose>
									<div
										class="col-${(param.typesToCollect == 'event')?'sm-10':'md-8'}">
										<h2>
											<a
												href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>">${content.value.Title}</a>
										</h2>
										<c:set var="showdate">
											<c:out value="${param.showDate}" default="true" />
										</c:set>
										<c:if test="${showdate}">
											<p>
												<i><fmt:formatDate
														value="${cms:convertDate(content.value.Date)}"
														dateStyle="LONG" timeStyle="SHORT" type="both" /> <c:if
														test="${content.value.EndDate.exists}">
											 	-&nbsp;<fmt:formatDate
															value="${cms:convertDate(content.value.EndDate)}"
															dateStyle="LONG" timeStyle="SHORT" type="both" />
													</c:if> </i>
											</p>
										</c:if>
										<c:choose>
											<c:when test="${content.value.Teaser.isSet}">
												<p>${content.value.Teaser}</p>
											</c:when>
											<c:otherwise>
												<p>${cms:trimToSize(cms:stripHtml(paragraph.value.Text), teaserLength)}</p>
											</c:otherwise>
										</c:choose>
										<div class="margin-bottom-10"></div>
										<a
											href="<cms:link baseUri="${param.pageUri}">${content.filename}</cms:link>"
											class="btn-u btn-u-<c:out value="${buttonColor}" default="red" />"><fmt:message
												key="unify.list.message.readmore" /></a>
									</div>
								</div>
							</cms:edit>
						</c:forEach>
					</div>
				</div>
				<c:set var="pagination" value="${search.controller.pagination}" />
				<!-- show pagination if it should be given and if it's really necessary -->
				<c:if test="${not empty pagination && search.numPages > 1}">
					<ul class="pagination">
						<li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
							<a href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage['
							1']}")'
						   aria-label='<fmt:message key="pagination.first.title"/>'>
								<span aria-hidden="true"><fmt:message
										key="pagination.first" /></span>
						</a>
						</li>
						<c:set var="previousPage">${pagination.state.currentPage > 1 ? pagination.state.currentPage - 1 : 1}</c:set>
						<li ${pagination.state.currentPage > 1 ? "" : "class='disabled'"}>
							<a href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage[previousPage]}")'
							aria-label='<fmt:message key="pagination.previous.title"/>'>
								<span aria-hidden="true"><fmt:message
										key="pagination.previous" /></span>
						</a>
						</li>
						<c:forEach var="i" begin="${search.pageNavFirst}"
							end="${search.pageNavLast}">
							<c:set var="is">${i}</c:set>
							<li ${pagination.state.currentPage eq i ? "class='active'" : ""}>
								<a href="javascript:void(0)"
								onclick='reloadInnerList("${search.stateParameters.setPage[is]}")'>${is}</a>
							</li>
						</c:forEach>
						<c:set var="pages">${search.numPages}</c:set>
						<c:set var="next">${pagination.state.currentPage < search.numPages ? pagination.state.currentPage + 1 : pagination.state.currentPage}</c:set>
						<li
							${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
							<a aria-label='<fmt:message key="pagination.next.title"/>'
							href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage[next]}")'>
								<span aria-hidden="true"><fmt:message
										key="pagination.next" /></span>
						</a>
						</li>
						<li
							${pagination.state.currentPage >= search.numPages ? "class='disabled'" : ""}>
							<a aria-label='<fmt:message key="pagination.last.title"/>'
							href="javascript:void(0)"
							onclick='reloadInnerList("${search.stateParameters.setPage[pages]}")'>
								<span aria-hidden="true"><fmt:message
										key="pagination.last" /></span>
						</a>
						</li>
					</ul>
				</c:if>
			</c:when>
			<c:otherwise>
				<div class="alert alert-warning fade in">
					<h3>
						<fmt:message key="unify.list.message.empty" />
					</h3>
					<c:if test='${not (con.value.TypesToCollect eq "u-blog") }'>
						<cms:edit createType="u-event">
							<div>Create a new event</div>
						</cms:edit>
					</c:if>
					<c:if test='${not (con.value.TypesToCollect eq "u-event") }'>
						<cms:edit createType="u-blog">
							<div>Create a new blog entry</div>
						</cms:edit>
					</c:if>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
</cms:bundle>