<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<jsp:useBean id="cloneModule" scope="request" class="org.opencms.workplace.tools.modules.CmsCloneModule">
	<jsp:setProperty name="cloneModule" property="*" />
	<% cloneModule.init(pageContext, request, response); %>
</jsp:useBean>
<c:if test="${'true' eq param.submit}">
	<% cloneModule.executeModuleClone(); %>
</c:if>
