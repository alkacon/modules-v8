<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale scope="page" value="${param.locale}" />
<div>
    <%-- Title of the article --%>
    <h4>Dynamic Function Demo.</h4>
    <div>
        <%-- The text field of the article with image --%>
        <div class="paragraph">
            <jsp:useBean id="date" class="java.util.Date" />
            <%-- Use the setting option to define the format and style of the date time output. --%>
            <c:set var="format"><cms:elementsetting name="format"/></c:set>
            <c:set var="style"><cms:elementsetting name="style"/></c:set>
            <b><fmt:formatDate value="${date}" dateStyle="${style}" type="${format}" /></b>
            <h6>Settings:</h6>
            <ul>
                <li><b>Format:</b> <cms:elementsetting name="format"/></li>
                <li><b>Style:</b> <cms:elementsetting name="style"/></li>
            </ul>
            <h6>Parameters:</h6>
            <ul>
                <li><b>locale:</b> ${param.locale}</li>
            </ul>
        </div>
    </div>
</div>