<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="margin-bottom-30">
    <c:set var="operant1" value="${param.operant1}" />
    <c:set var="operant2" value="${param.operant2}" />
    <c:if test="${(!empty operant1)&&(!empty operant2)}">
        <c:catch var="error">
            <c:choose>
                <c:when test="${param.operator == '+'}">
                    <c:set var="result" value="${operant1+ operant2}" />
                </c:when>
                <c:when test="${param.operator == '-'}">
                    <c:set var="result" value="${operant1 - operant2}" />
                </c:when>
                <c:when test="${param.operator == '*'}">
                    <c:set var="result" value="${operant1 * operant2}" />
                </c:when>
                <c:when test="${param.operator == '/'}">
                    <c:set var="result" value="${operant1 / operant2}" />
                </c:when>
            </c:choose>
        </c:catch>
        <c:if test="${error == null}">
            <div class="view-article">
                <%-- Title of the article --%>
                <div class="headline">
                    <h3>Calculation result:&nbsp;<c:out value="${operant1}" escapeXml="true"/>&nbsp;<c:out value="${param.operator}" escapeXml="true"/>&nbsp;<c:out value="${operant2}" escapeXml="true"/>&nbsp;=&nbsp;<c:out escapeXml="true" value="${result}"/></h3>
                </div>
            </div>
        </c:if>
        <c:if test="${error != null}">
            <div class="view-article">
                <%-- Title of the article --%>
                <h2>Error</h2>
                <%-- The text field of the article with image --%>
                <div class="paragraph">
                    <p>Error occurs during the calculation. Please check the input fields.</p>
                </div>
            </div>
        </c:if>
    </c:if>
</div>