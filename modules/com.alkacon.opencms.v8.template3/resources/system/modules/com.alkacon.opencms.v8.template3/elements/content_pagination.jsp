<%@page buffer="none" session="false" taglibs="c,cms,fmt" import="org.opencms.file.* ,org.opencms.jsp.* ,java.util.List " %>
<%
CmsJspActionElement  cms = new CmsJspActionElement(pageContext, request, response);
String parentfolder = CmsResource.getParentFolder(cms.getRequestContext().getFolderUri());

List parentnavi = cms.getNavigation().getNavigationForFolder(parentfolder);
CmsJspNavElement current = cms.getNavigation().getNavigationForResource(cms.getRequestContext().getFolderUri());

int navindex = parentnavi.indexOf(current);
boolean hasnext = false;
boolean hasback = false;
	if ((navindex-1) >=0){
	  CmsJspNavElement back = (CmsJspNavElement)parentnavi.get(navindex-1);
	  pageContext.setAttribute("back_uri", back.getResourceName());
	  hasback = true;
	}
	if ((navindex+1)< parentnavi.size()){
	  CmsJspNavElement next = (CmsJspNavElement)parentnavi.get(navindex+1);
	  pageContext.setAttribute("next_uri", next.getResourceName());
	  hasnext = true;
	}
pageContext.setAttribute("overview_uri", parentfolder );
pageContext.setAttribute("hasnext", hasnext);
pageContext.setAttribute("hasback", hasback);

%>
<fmt:setLocale value="${cms.locale}" />
<fmt:bundle basename="com.alkacon.opencms.v8.template3.workplace">
<span style="border-top: 1px solid #AAAAAA; display: block; margin-top: 20px; padding: 20px 0 0; text-align: center;">
	<c:choose>
		<c:when test="${hasback}">
			<span><a href="<cms:link>${back_uri}</cms:link>">&laquo; <fmt:message key="page.previous" /></a></span>
		</c:when>
		<c:otherwise>
			<span style="color: #AAAAAA;"> &laquo; <fmt:message key="page.previous" /></span>
		</c:otherwise>
	</c:choose>
	<span style="margin: 0px 25px;"><a href="<cms:link>${overview_uri}</cms:link>"><fmt:message key="page.overview" /></a></span>
	<c:choose>
		<c:when test="${hasnext}">
			<span><a href="<cms:link>${next_uri}</cms:link>"><fmt:message key="page.next" /> &raquo;</a></span>
		</c:when>
		<c:otherwise>
			<span style="color: #AAAAAA;"><fmt:message key="page.next" /> &raquo;</span>
		</c:otherwise>
	</c:choose>
</span>
</fmt:bundle>