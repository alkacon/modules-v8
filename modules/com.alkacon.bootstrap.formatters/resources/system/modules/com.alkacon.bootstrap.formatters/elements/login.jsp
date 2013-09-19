<%@page buffer="none" session="false" import="org.opencms.main.*, org.opencms.file.*" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="cms" uri="http://www.opencms.org/taglib/cms" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<cms:secureparams />
<fmt:setLocale value="${cms.locale}" />
<cms:bundle basename="com.alkacon.bootstrap.schemas.login">
<form class="log-page" action="<cms:link>${cms.requestContext.uri}</cms:link>" method="get">
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

<%-- Title of the login box--%>
<h3><fmt:message key="bootstrap.login.title" /></h3>

<c:choose>
        <c:when test="${!login.loggedIn}">
                <p><fmt:message key="bootstrap.login.text" /></p>
        </c:when>
        <c:otherwise>
                <p><b><fmt:message key="bootstrap.login.message.loggedin" />:</b></p><p>
                <c:set var="firstname"><cms:user property="firstname"/></c:set>
                <c:set var="lastname"><cms:user property="lastname"/></c:set>
                <c:if test="${not empty firstname}">${firstname}&nbsp;</c:if><c:if test="${not empty lastname}">${lastname}</c:if>
                <c:set var="username"><cms:user property="name"/></c:set>
                <c:if test="${empty firstname && empty lastname}">
                        <c:if test="${fn:indexOf(username, '/') != -1}">
                                <c:set var="username">${fn:substringAfter(username, '/')}</c:set>
                        </c:if>
                        (${username})
                </c:if>
                </p>
        </c:otherwise>
        </c:choose>
                <c:if test="${!login.loginSuccess}">
                        <div class="alert alert-error">
                                <strong><fmt:message key="bootstrap.login.message.failed" /></strong>:<br />
                                ${login.loginException.localizedMessage}
                        </div>
                </c:if>
               
               <input type="hidden" name="action" value="login" />
               <input type="hidden" name="requestedResource" value="${param.requestedResource}" />

               <div class="input-prepend">
	                <span class="add-on"><i class="icon-user"></i></span>
	                <input class="input-block-level" type="text" name="name" placeholder="<fmt:message key="bootstrap.login.label.username" />"/>
	            </div>
	            <div class="clearfix"></div>
	            <div class="input-prepend">
	                <span class="add-on"><i class="icon-lock"></i></span>
	                <input class="input-block-level" type="password" name="password" placeholder="<fmt:message key="bootstrap.login.label.password" />">
	            </div>
	            <div class="controls">
	                <button class="btn-u" type="submit"><fmt:message key="bootstrap.login.label.login" /></button>
	            </div>
	            <div class="clearfix"></div>           
</form>
</cms:bundle> 