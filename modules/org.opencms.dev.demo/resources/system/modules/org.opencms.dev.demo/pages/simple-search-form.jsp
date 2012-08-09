<%@page buffer="none" session="false" taglibs="c,cms,fn" import="org.opencms.main.*, org.opencms.search.*, org.opencms.file.*, org.opencms.jsp.*, java.util.*" %><%   
    
    // Create a JSP action element
    org.opencms.jsp.CmsJspActionElement cms = new CmsJspActionElement(pageContext, request, response);
    
    // Get the search manager
    CmsSearchManager searchManager = OpenCms.getSearchManager(); 

%>

<%-- Initialize the search bean. --%>
<jsp:useBean id="search" scope="request" class="org.opencms.search.CmsSearch">
    <jsp:setProperty name = "search" property="*"/>
    <% search.init(cms.getCmsObject()); %>
</jsp:useBean>

<div>

<%-- Display the search form.
     - Set detail function page of the form as action target. 
     - Please learn more about detail function page in "Detail function detail demo". --%>
<form method="post" action="${cms.functionDetail['searchresults']}">
	<h1>Search</h1>
	<table class="deflist" cellspacing="8">
	    <tr>
	    	<th valign="top">Query:</th>
		
		<td><input type="text" name="query" size="18" value="<c:if test="${not empty param.query}"><c:out value="${param.query}"/></c:if>"></td></tr>
		
		<tr>
			<th valign="top">Index:</th>
			<td>
			<select name="index" style="width:152px;">
			<%
			    for (Iterator i = searchManager.getIndexNames().iterator(); i.hasNext();) {
			        String indexName = (String)i.next();
			        pageContext.setAttribute("indexName",indexName);
			%>
				<option <c:if test="${not empty param.index and indexName == param.index}">selected</c:if> ><c:out value="${indexName}" /></option>
			<%
			    }
			%>
			</select>
			</td>
		</tr>				
		<tr>
			<th valign="top">Fields:</th>
			<td>
				<input type="checkbox" name="field" value="title" 
				<c:if test="${fn:contains(search.fields,'title')}">checked</c:if>>Title<br>
				<input type="checkbox" name="field" value="keywords" 
				<c:if test="${fn:contains(search.fields,'keywords')}">checked</c:if>>Keywords<br>
				<input type="checkbox" name="field" value="description" 
	    			<c:if test="${fn:contains(search.fields,'description')}">checked</c:if>>Description<br>
				<input type="checkbox" name="field" value="content" 
				<c:if test="${fn:contains(search.fields,'content')}">checked</c:if>>Content<br>
			</td>
		</tr>
	</table>
	<p>
	<input type="submit" value="Submit">
</form>

</div>