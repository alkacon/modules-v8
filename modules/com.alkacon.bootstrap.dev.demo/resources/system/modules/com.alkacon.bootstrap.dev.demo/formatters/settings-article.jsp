<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="${cms.locale}" />
<cms:formatter var="content" val="value">
<%-- The box schema changes the color of the box --%>
<div class="margin-bottom-30">
    <%-- Title of the article --%>
    <div class="headline"><h3><cms:elementsetting name="text" /></h3></div>
    <div>
        <%-- The text field of the article with image --%>
        <div class="boxbody_listentry">
            <%-- Set the requied variables for the image. --%>
            <c:set var="showing" ><cms:elementsetting name="showimage" default="false" /></c:set>
            <c:if test="${showing && value.Image.isSet}">
                <c:set var="showing" value="true" />
                <c:set var="imgclass">left</c:set>
                <%-- The image is scaled to the one third of the container width, considering the padding=20px on both sides. --%>
                <c:set var="imgwidth">${(cms.container.width - 20) / 3}</c:set>
                <cms:img src="${value.Image}" width="${imgwidth}" scaleColor="transparent" scaleType="0" cssclass="${imgclass}" alt="${value.Image}" title="${value.Image}" />
            </c:if>
            <c:set var="date"><cms:elementsetting name="date" /></c:set>
            <c:set var="dateformat"><cms:elementsetting name="format" /></c:set>
            <c:if test="${not empty date}">
                <i><fmt:formatDate value="${cms:convertDate(date)}" dateStyle="SHORT" timeStyle="SHORT" type="${dateformat}" /></i>
                <br/>
            </c:if>
            <c:if test="${value.Options.exists}">
                <c:forEach var="elem" items="${content.subValueList.Options}">
                    <c:choose>
                        <c:when test="${elem.name == 'Text'}">
                            <div>${elem}</div>
                        </c:when>
                        <c:when test="${elem.name == 'Html'}">
                            <div>${elem}</div>
                        </c:when>
                        <c:when test="${elem.name == 'Link'}">
                            <div><a href="<cms:link>${elem}</cms:link>">${elem}</a></div>
                        </c:when>
                    </c:choose>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <h4>Settings values:</h4>
    <div>
        <p>
<pre><b>Text field</b> "Text" = <cms:elementsetting name="text" /> <br/>
<b>Check box</b> "Show Image" = <cms:elementsetting name="showimage" default="false" /> <br/>
<b>Date picker</b> "Date" = <cms:elementsetting name="date" /> <br/>
<b>Radio buttons</b> "Date Format" = <cms:elementsetting name="format" /></pre>
		</p>
    </div>
</div>
</cms:formatter>