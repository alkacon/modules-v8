<%@page buffer="none" session="false" trimDirectiveWhitespaces="true" %>
<%@taglib prefix="cms" uri="http://www.opencms.org/taglib/cms"%>
<div>
    <blockquote>
        <h3>File: example-include2a.jsp</h3>
        <p>The Date is <b><%= new java.util.Date() %></b></p>
        <h3>Cache properties: <cms:property name="cache" file="this" default="(caching not set)"/></h3>
    </blockquote>
</div>