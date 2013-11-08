<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<div class="margin-bottom-30">
    <div class="headline"><h3>File: example-include2.jsp</h3></div>
    <blockquote>
        <p>The Date is <b><%= new java.util.Date() %></b></p>
        <h3>Cache properties: <cms:property name="cache" file="this" default="(caching not set)"/></h3>
        <p>((include-target2.jsp[[</p>
        <p><cms:include file="%(link.weak:/dev-demo/.content/.functions/include-target2.jsp:afef4635-b5fe-11e1-b8db-c524a635a326)"/></p>
        <p>]]include-target2.jsp))</p>
    </blockquote>
</div>