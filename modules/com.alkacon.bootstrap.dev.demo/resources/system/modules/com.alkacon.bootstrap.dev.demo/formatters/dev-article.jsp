<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<cms:formatter var="content" val="value">
<div class="margin-bottom-30">
    <%-- Title of the article --%>
    <div class="headline"><h3>${value.Title}</h3></div>
    <%-- The text field of the article with image --%>
    <div class="paragraph">
        <c:set var="showing" value="false" />
        <c:if test="${value.Image.isSet}">
            <c:set var="showing" value="true" />
            <c:set var="imgwidth">${(cms.container.width - 50)}</c:set>
            <cms:img src="${value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="left" />
        </c:if>
        ${value.Text}
        <c:if test="${showing}">
            <div class="clear"></div>
        </c:if>
    </div>
</div>
</cms:formatter>