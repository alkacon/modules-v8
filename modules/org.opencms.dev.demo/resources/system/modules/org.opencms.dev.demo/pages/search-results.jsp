<%@page buffer="none" session="false" taglibs="c,cms" import="org.opencms.main.*, org.opencms.search.*, org.opencms.file.*, org.opencms.jsp.*, java.util.*"%><%   
    
    // Create a JSP action element
    org.opencms.jsp.CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
    
    // Get the search manager
    CmsSearchManager searchManager = OpenCms.getSearchManager(); 

%>
<div>
<c:if test="${not empty param.query}">
<jsp:useBean id="search" scope="request" class="org.opencms.search.CmsSearch">
    <jsp:setProperty name = "search" property="*"/>
    <% 
    		search.init(cms.getCmsObject()); 		
    %>
</jsp:useBean>




<h1>Search result</h1>

<%
	int resultno = 1;
	int pageno = 0;
	if (request.getParameter("searchPage")!=null) {		
		pageno = Integer.parseInt(request.getParameter("searchPage"))-1;
	}
	resultno = (pageno*search.getMatchesPerPage())+1;
	out.write("search.getMatchesPerPage()" + search.getMatchesPerPage());
	String fields = search.getFields();
   if (fields==null) {
   	fields = request.getParameter("fields");
   }
    
   List result = search.getSearchResult();
   if (result == null) {
%>
<%
        if (search.getLastException() != null) { 
%>
<h3>Error</h3>
<%= search.getLastException().toString() %> 
<%
        }

    } else {
    
        ListIterator iterator = result.listIterator();
%>
<h3><%= search.getSearchResultCount() %> Results found for query &lt;<%= search.getQuery() %>&gt; in fields <%= fields %></h3>
<%
        while (iterator.hasNext()) {
            CmsSearchResult entry = (CmsSearchResult)iterator.next();
%>

				<h3><%= resultno %>.&nbsp;<a href="<%= cms.link(cms.getRequestContext().removeSiteRoot(entry.getPath())) %>"><%= entry.getTitle() %></a>&nbsp;(<%= entry.getScore() %>%)</h3>
				<h6>Keywords</h6>
				<%= entry.getKeywords() %>
				<h6>Excerpt</h6>
				<%= entry.getExcerpt() %>
				<h6>Description</h6>
				<%= entry.getDescription() %>
				<h6>Last modified</h6>
				<%= entry.getDateLastModified() %>

<%
        resultno++;            
        }
    }
%> 
<div class="searchPaging">
<%
	if (search.getPreviousUrl() != null) {
%>
		<input type="button" value="&lt;&lt; previous" onclick="location.href='<%= cms.link(search.getPreviousUrl()) %>&fields=<%= fields %>';">
<%
	}
	Map pageLinks = search.getPageLinks();
	Iterator i =  pageLinks.keySet().iterator();
	while (i.hasNext()) {
		int pageNumber = ((Integer)i.next()).intValue();
		String pageLink = cms.link((String)pageLinks.get(new Integer(pageNumber)));       		
		out.print("&nbsp; &nbsp;");
		if (pageNumber != search.getSearchPage()) {
%>
			<a href="<%= pageLink %>&fields=<%= fields %>"><%= pageNumber %></a>
<%
		} else {
%>
			<span class="currentpage"><%= pageNumber %></span>
<%
		}
	}
	if (search.getNextUrl() != null) {
%>
		&nbsp; &nbsp;<input type="button" value="next &gt;&gt;" onclick="location.href='<%= cms.link(search.getNextUrl()) %>&fields=<%= fields %>';">
<%
	} 
	
%>
</div>
</c:if>
</div>