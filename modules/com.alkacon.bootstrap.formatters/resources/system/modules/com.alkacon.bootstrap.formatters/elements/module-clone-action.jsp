<%@page buffer="none" session="false" trimDirectiveWhitespaces="true"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="cloneModule" scope="request" class="org.opencms.workplace.tools.modules.CmsCloneModule">
	<jsp:setProperty name="cloneModule" property="*" />
	<% cloneModule.init(pageContext, request, response); %>
</jsp:useBean>
<c:if test="${param.submit}">
	<%
		try {
			cloneModule.executeModuleClone();
		} catch (Throwable t) {
		    // noop
		}
		if (cloneModule.success()) {
		    %><div id="success"><h2>Module: ${cloneModule.packageName} created successfully!</h2></div><%
		} else {
		    %><div id="success"><h2>Oops module: ${cloneModule.packageName} not created successfully!</h2></div><%
		}
	%>
</c:if>
