<%@page buffer="none" session="false" import="org.opencms.main.*, org.opencms.file.*" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<cms:secureparams />

<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.login">

<jsp:useBean id="login" class="org.opencms.jsp.CmsJspLoginBean" scope="page">
        <%
                login.init (pageContext, request, response);
        %>
        <c:set var ="loginou">${cms.element.settings.loginou}</c:set>
        <c:if test="${param.action eq 'login' && !empty param.name && !empty param.password}">
                <c:choose>
                        <c:when test ="${not empty cms.element.settings.loginou}">
                          <% login.login ("/"+(String)pageContext.getAttribute ("loginou")+"/" + request.getParameter("name"), request.getParameter("password"), "Offline", request.getParameter("requestedResource")); %>
                        </c:when>
                        <c:otherwise>
                         <% login.login (request.getParameter("name"), request.getParameter("password"), "Offline", request.getParameter("requestedResource")); %>
                        </c:otherwise>
                </c:choose>
        </c:if>
        <c:if test="${param.action eq 'logoff'}">
        <%
                login.logout();
        %>
        </c:if>
</jsp:useBean>

<div class="row">
<form class="reg-page" <c:if test="${cms.container.type == 'content-full'}">style="width: 400px"</c:if> action="<cms:link>${cms.requestContext.uri}</cms:link>" method="get">

<input type="hidden" name="requestedResource" value="${param.requestedResource}" />

<c:choose>
	<c:when test="${! login.loggedIn}">
		<div class="reg-header">		
			<h3><fmt:message key="bootstrap.login.title.loggedoff" /></h3>
			<p><fmt:message key="bootstrap.login.message.loggedoff" /></p>
		</div>

		<div class="input-group margin-bottom-20">
			<span class="input-group-addon"><i class="icon-user"></i></span>
			<input class="form-control" type="text" name="name" placeholder="<fmt:message key="bootstrap.login.label.username" />"/>
		</div>
		<div class="input-group margin-bottom-20">
			<span class="input-group-addon"><i class="icon-lock"></i></span>
			<input class="form-control" type="password" name="password" placeholder="<fmt:message key="bootstrap.login.label.password" />">
		</div>
		<div class="controls form-inline">
			<button class="btn-u" type="submit" name="action" value="login" ><fmt:message key="bootstrap.login.label.login" /></button>
		</div>   
	</c:when>
	<c:otherwise>
		<div class="reg-header">
			<h3><fmt:message key="bootstrap.login.title.loggedin" /></h3>
			<p><fmt:message key="bootstrap.login.message.loggedin" />: <b>${cms.requestContext.currentUser.name}</b></p>
		</div>

		<div class="controls form-inline">
			<button class="btn-u btn-u-blue" type="submit" name="action" value="logoff" ><fmt:message key="bootstrap.login.label.logoff" /></button>
		</div>   
	</c:otherwise>
</c:choose>

<c:if test="${!login.loginSuccess}">
	<div class="alert alert-error">
		<strong><fmt:message key="bootstrap.login.message.failed" /></strong>:<br />
		${login.loginException.localizedMessage}
	</div>
</c:if>
               
</form>  
</div>

</cms:bundle> 