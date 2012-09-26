<%@page session="false" taglibs="c,cms,fmt" import="org.opencms.main.*,org.opencms.file.*,org.opencms.jsp.*,org.opencms.jsp.util.*,org.opencms.xml.content.*,org.opencms.search.*,org.opencms.search.solr.*,java.util.*"%>
<div>
	<link rel="stylesheet" type="text/css" href="<cms:link>%(link.weak:/system/modules/com.alkacon.opencms.v8.solr/resources/css/reuters.css:cd946db3-f687-11e1-b6b3-058770d8fd70)</cms:link>" media="screen"/>
	<fmt:setLocale value="${cms.locale}" />
	<fmt:bundle basename="com.alkacon.opencms.v8.solr.messages">
		<form action="<cms:link>${cms.requestContext.uri}</cms:link>" method="post" class="searchForm"> 
			<input type="text" name="query" style="width:250px;" />
			<input class="button" type="submit" value="<fmt:message key="v8.solr.search" />"/>
		</form>
		<div class="box ${cms.element.settings.boxschema} results"><%
		    //////////////////
			// SEARCH START //
			//////////////////
			CmsObject cmsO = new CmsJspActionElement(pageContext, request, response).getCmsObject();
			String query = ((request.getParameter("query") != null && request.getParameter("query") != "") ? "q=" + request.getParameter("query") : "") + "&fq=type:ddarticle&sort=path asc&rows=5";
			CmsSolrResultList hits = OpenCms.getSearchManager().getIndexSolr("Solr Offline").search(cmsO, query);
			if (hits.size() > 0) { %>
				<h4>New way: <fmt:message key="v8.solr.results" /> <%= hits.getNumFound() %> found / rows <%= hits.getRows() %></h4>
				<div class="boxbody"><%
					//////////////////
					// RESULTS LOOP //
					//////////////////
					for (CmsSearchResource resource : hits) { %>
						<div class="boxbody_listentry">
							<div class="twocols">
								<div>Path:    <strong><%= resource.getRootPath() %></strong></div>
								<div>German:  <strong><%= resource.getDocument().getFieldValueAsString("Title_de") %></strong></div>
								<div>English: <strong><%= resource.getDocument().getFieldValueAsString("Title_en") %></strong></div>
							</div>
						</div> <%
					}
				%></div><%
			}
			List<CmsResource> resources = cmsO.readResources("/", CmsResourceFilter.DEFAULT_FILES.addRequireType(135), true);
			if (resources != null && !resources.isEmpty()) {
				%><h4>Classic way</h4>
				<div class="boxbody"><%
					//////////////////
					// RESULTS LOOP //
					//////////////////
					for (CmsResource resource : hits) {
						// read the resource's contnent from DB
						CmsFile file = cmsO.readFile(resource);
						// unmarshal the content (parsing XML is expensive)
    					CmsXmlContent content = CmsXmlContentFactory.unmarshal(cmsO, file);
						// initialize a new instance of a content access bean
    					CmsJspContentAccessBean germanBean  = new CmsJspContentAccessBean(cmsO, Locale.GERMAN, content);
						CmsJspContentAccessBean englishBean = new CmsJspContentAccessBean(cmsO, Locale.ENGLISH, content);
						pageContext.setAttribute("en", englishBean);
						pageContext.setAttribute("de", germanBean); %>
						<div class="boxbody_listentry">
							<div class="twocols">
								<div>Path:    <strong><%= resource.getRootPath() %></strong></div>
								<div>German:  <strong>${de.value.Title}</strong></div>
								<div>English: <strong>${en.value.Title}</strong></div>
							</div>
						</div> <%
					}
				%></div><%
			} %>
			<br/><br/>
			<h4>Total time used for querying and rendering the whole page: <%= System.currentTimeMillis() - hits.getStartTime() %> ms</h4>
		</div>
	</fmt:bundle>
</div>
