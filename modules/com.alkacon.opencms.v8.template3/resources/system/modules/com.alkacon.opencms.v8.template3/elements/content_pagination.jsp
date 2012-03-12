<%@page buffer="none" session="false" taglibs="c,cms" import="org.opencms.file.* ,org.opencms.jsp.* ,java.util.List " %>
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
<c:choose>
 <c:when test="${cms.locale == 'de'}">
  <c:set var="forwards">Weiter</c:set>
  <c:set var="back">Zurück</c:set>
  <c:set var="overview">Übersicht</c:set>
 </c:when>
 <c:otherwise>
  <c:set var="forwards">Forward</c:set>
  <c:set var="back">Backward</c:set>
  <c:set var="overview">Overview</c:set>
 </c:otherwise>
</c:choose>

<span style="text-align: center; display: block; margin: 10px 0px 0px 0px">
<c:if test="${hasback}">
<span><a href="<cms:link>${back_uri}</cms:link>"> &laquo; ${back}</a></span>
</c:if>
<span style="margin: 0px 25px;"><a href="<cms:link>${overview_uri}</cms:link>">${overview}</a></span>
<c:if test="${hasnext}">
<span><a href="<cms:link>${next_uri}</cms:link>">${forwards} &raquo;</a></span>
</c:if>
</span>
