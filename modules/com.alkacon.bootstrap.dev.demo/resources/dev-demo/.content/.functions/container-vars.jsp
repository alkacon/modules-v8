<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="margin-bottom-30">
    <div class="headline">
        <h3>Access of the container variables</h3>
    </div>
    <c:if test="${cms.container.type == 'center'}">
        <p>Specific information about containers of the container pages as well as information of a container element is provided by
        org.opencms.jsp.util.CmsJspStandardContextBean. This bean is available in jsps like formatter as soon as the container page is rendered.
        The values of the bean are adjusted depending on the element it is called from.
        In order to access the CmsJspStandardContextBean in a jsp use a predefined EL variable \${cms}.</p>
        <p>In this demo different variables, which are available inside of the current element, are displayed.
        These variables describe the current state of the container page and of the current container.<br/>
        Please check the following jsp to learn more about the source code:<br/>
        <strong>/system/modules/com.alkacon.bootstrap.dev.demo/pages/containervars.jsp</strong></p>
    </c:if>
    <h4>Current container</h4>
    <p>Following container attributes are defined in template:
    <b>Name:</b> ${cms.container.name}<br/>
    <b>Type:</b> ${cms.container.type}<br/>
    <b>Width:</b> ${cms.container.width}<br/>
    <b>Max Elements:</b> ${cms.container.maxElements}</p>
    <h4>Container page</h4>
    <ul>
        <li><b>Locale:</b> ${cms.page.locale}</li>
        <li><b>Container Names:</b>
            <ul>
                <c:forEach var="con" items="${cms.page.names}" varStatus="status">
                    <li>${con}</li>
                </c:forEach>
            </ul>
        </li>
        <li><b>Container Types:</b>
            <ul>
                <c:forEach var="con" items="${cms.page.types}" varStatus="status">
                    <li>${con}</li>
                </c:forEach>
            </ul>
        </li>
    </ul>
    <h4>Element Mode:</h4>
    <p><b>Mode:</b> ${cms.edited}</p>
    <c:if test="${cms.edited}">
        <p>Please reload the current page.</p>
        <p>The element mode is <strong>true</strong>, if the element have been moved or edited, but the page have not been reloaded yet.<br/>
        The element mode is <strong>false</strong>, if the element have not been changed since the last reload of the page.</p>
    </c:if>
    <c:if test="${!cms.edited}">
        <p>The element mode is <strong>true</strong>, if the element have been moved or edited, but the page have not been reloaded yet.<br/>
        The element mode is <strong>false</strong>, if the element have not been changed since the last reload of the page.</p>
    </c:if>
    <c:if test="${cms.container.name == 'centercolumn'}">
        <c:if test="${not empty cms.functionDetail['simplecalculator']}">
            <h4>Function detail path:</h4>
            <p>You can access the path to the configured function detail page using its name. Useful for the "action" attribute of the form.</p>
            <p>The path to the configured function detail page of "The Function detail page demo": ${cms.functionDetail['simplecalculator']}</p>
        </c:if>
    </c:if>
</div>
